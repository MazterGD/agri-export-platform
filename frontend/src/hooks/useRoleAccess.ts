import { useSession } from "next-auth/react";

export const useRoleAccess = () => {
  const { data: session, status } = useSession();
  
  const hasRole = (role: string) => {
    return session?.user?.role === role;
  };
  
  const hasAnyRole = (roles: string[]) => {
    return roles.includes(session?.user?.role || '');
  };
  
  const isAdmin = () => hasRole('admin');
  const isFarmer = () => hasRole('farmer');
  const isBuyerAgent = () => hasRole('buyer_agent');
  const isComplianceOfficer = () => hasRole('compliance_officer');
  const isSupportModerator = () => hasRole('support_moderator');
  
  const canAccess = (requiredRoles: string[]) => {
    if (status === "loading") return false;
    if (status === "unauthenticated") return false;
    return hasAnyRole(requiredRoles);
  };
  
  return {
    session,
    status,
    hasRole,
    hasAnyRole,
    isAdmin,
    isFarmer,
    isBuyerAgent,
    isComplianceOfficer,
    isSupportModerator,
    canAccess,
    currentRole: session?.user?.role,
    isAuthenticated: status === "authenticated"
  };
};
