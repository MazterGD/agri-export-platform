"use client";

import { useSession, signOut } from "next-auth/react";
import { Container, Title, Text, Button, Card, Grid, Badge } from "@mantine/core";
import { redirect } from "next/navigation";

export default function DashboardPage() {
  const { data: session, status } = useSession();

  if (status === "loading") {
    return <div>Loading...</div>;
  }

  if (status === "unauthenticated") {
    redirect("/auth/signin");
  }

  const handleSignOut = () => {
    signOut({ callbackUrl: "/auth/signin" });
  };

  const getRoleColor = (role: string) => {
    switch (role) {
      case 'admin': return 'red';
      case 'farmer': return 'green';
      case 'buyer_agent': return 'blue';
      case 'compliance_officer': return 'yellow';
      case 'support_moderator': return 'purple';
      default: return 'gray';
    }
  };

  return (
    <Container size="lg" py={40}>
      <Grid>
        <Grid.Col span={12}>
          <Card shadow="sm" p="lg">
            <Title order={1} mb="md">Welcome to Your Dashboard</Title>
            <Text size="lg" mb="md">Hello, {session?.user?.name}!</Text>
            
            <Text><strong>Email:</strong> {session?.user?.email}</Text>
            <Text><strong>Role:</strong> 
              <Badge color={getRoleColor(session?.user?.role || '')} ml="xs">
                {session?.user?.role}
              </Badge>
            </Text>
            <Text><strong>User ID:</strong> {session?.user?.asgardeoUserId}</Text>
            
            <Button 
              color="red" 
              variant="outline" 
              mt="lg"
              onClick={handleSignOut}
            >
              Sign Out
            </Button>
          </Card>
        </Grid.Col>
      </Grid>
    </Container>
  );
}
