"use client";

import { signIn, getSession } from "next-auth/react";
import { Button, Container, Title, Text, Stack } from "@mantine/core";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

export default function SignInPage() {
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  useEffect(() => {
    getSession().then((session) => {
      if (session) {
        router.push('/dashboard');
      }
    });
  }, [router]);

  const handleSignIn = async () => {
    setLoading(true);
    try {
      await signIn("asgardeo", { 
        callbackUrl: "/dashboard",
        redirect: true 
      });
    } catch (error) {
      console.error("Sign in error:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Container size="sm" py={40}>
      <Stack align="center" gap="md">
        <Title order={1}>Agricultural Export Platform</Title>
        <Text size="lg" color="dimmed" ta="center">
          Connect with farmers and export opportunities
        </Text>
        <Button
          size="lg"
          onClick={handleSignIn}
          loading={loading}
          color="green"
        >
          Sign in with Asgardeo
        </Button>
      </Stack>
    </Container>
  );
}
