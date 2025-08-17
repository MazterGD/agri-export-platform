import NextAuth from "next-auth"
import type { Provider } from "next-auth/providers"

// Extend Profile type to include Asgardeo-specific fields
interface AsgardeoProfile {
  sub: string;
  email: string;
  given_name?: string;
  family_name?: string;
  groups?: string[];
  [key: string]: any;
}

// Custom Asgardeo provider for SPA (without client secret)
const AsgardeoProvider: Provider = {
  id: "asgardeo",
  name: "Asgardeo",
  type: "oidc",
  issuer: process.env.AUTH_ASGARDEO_ISSUER,
  clientId: process.env.AUTH_ASGARDEO_ID,
  client: {
    token_endpoint_auth_method: "none",
  },
  checks: ["pkce", "state"],
  authorization: {
    params: {
      scope: "openid email profile groups",
      response_type: "code",
    }
  },
  wellKnown: `https://api.asgardeo.io/t/codecrewuom/oauth2/oidcdiscovery`,
  profile(profile: AsgardeoProfile) {
    return {
      id: profile.sub,
      name: `${profile.given_name || ''} ${profile.family_name || ''}`.trim(),
      email: profile.email,
      role: profile.groups?.[0] || "user",
      asgardeoUserId: profile.sub,
      given_name: profile.given_name,
      family_name: profile.family_name
    }
  }
}

declare module "next-auth" {
  interface User {
    role?: string;
    asgardeoUserId?: string;
    given_name?: string;
    family_name?: string;
  }
  interface Session {
    user: {
      id: string;
      name?: string | null;
      email?: string | null;
      image?: string | null;
      role?: string;
      asgardeoUserId?: string;
      given_name?: string;
      family_name?: string;
    }
  }
}

export const { handlers, signIn, signOut, auth } = NextAuth({
  providers: [AsgardeoProvider],
  pages: {
    signIn: '/auth/signin',
    error: '/auth/error',
  },
  callbacks: {
    async jwt({ token, user, profile, account }) {
      if (user) {
        token.role = user.role;
        token.asgardeoUserId = user.asgardeoUserId;
        token.given_name = user.given_name;
        token.family_name = user.family_name;
      }
      if (profile) {
        const asgardeoProfile = profile as AsgardeoProfile;
        token.role = asgardeoProfile.groups?.[0] || "user";
        token.asgardeoUserId = asgardeoProfile.sub;
        token.given_name = asgardeoProfile.given_name;
        token.family_name = asgardeoProfile.family_name;
      }
      if (account) {
        token.accessToken = account.access_token;
        token.idToken = account.id_token;
      }
      return token;
    },
    async session({ session, token }) {
      if (token && session.user) {
        session.user.id = token.sub!;
        session.user.role = token.role as string;
        session.user.asgardeoUserId = token.asgardeoUserId as string;
        session.user.given_name = token.given_name as string;
        session.user.family_name = token.family_name as string;
        session.user.name = `${token.given_name || ''} ${token.family_name || ''}`.trim();
      }
      return session;
    }
  },
  events: {
    async signIn({ user, account, profile }) {
      console.log("User signed in:", { 
        userId: user.id, 
        email: user.email, 
        role: user.role 
      });
    },
    async signOut(message) {
      if ("token" in message) {
        console.log("User signed out:", { userId: message.token?.sub });
      }
    }
  },
  debug: process.env.NODE_ENV === "development",
})
