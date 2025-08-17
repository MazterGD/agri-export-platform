import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/auth";

// Define protected routes and their required roles
const protectedRoutes: Record<string, string[]> = {
  '/dashboard': ['admin', 'farmer', 'buyer_agent', 'compliance_officer', 'support_moderator'],
  '/admin': ['admin'],
  '/farms': ['admin', 'farmer', 'compliance_officer'],
  '/export': ['admin', 'buyer_agent', 'farmer'],
  '/compliance': ['admin', 'compliance_officer'],
  '/support': ['admin', 'support_moderator']
};

// Routes that don't require authentication
const publicRoutes = ['/', '/auth/signin', '/auth/error', '/api/health'];

export default async function middleware(req: NextRequest) {
  const { pathname } = req.nextUrl;

  // Allow public routes
  if (publicRoutes.includes(pathname) || pathname.startsWith('/api/auth/')) {
    return NextResponse.next();
  }

  // Get session
  const session = await auth();

  // Redirect to signin if not authenticated
  if (!session) {
    const signInUrl = new URL('/auth/signin', req.url);
    signInUrl.searchParams.set('callbackUrl', pathname);
    return NextResponse.redirect(signInUrl);
  }

  // Check role-based access
  const requiredRoles = protectedRoutes[pathname];
  if (requiredRoles && !requiredRoles.includes(session.user?.role || '')) {
    const accessDeniedUrl = new URL('/access-denied', req.url);
    return NextResponse.redirect(accessDeniedUrl);
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    '/((?!api/auth|_next/static|_next/image|favicon.ico|.*\\.png$).*)',
  ],
}
