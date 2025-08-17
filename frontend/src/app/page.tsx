"use client";

import { useSession } from "next-auth/react";
import { Container, Title, Text, Button, Stack } from "@mantine/core";
import Link from "next/link";
import { redirect } from "next/navigation";

export default function HomePage() {
  const { data: session, status } = useSession();

  if (status === "loading") {
    return <div>Loading...</div>;
  }

  if (session) {
    redirect("/dashboard");
  }

  return (
    <Container size="md" py={80}>
      <Stack align="center" gap="xl">
        <Title order={1} size={48} ta="center">
          Agricultural Export Platform
        </Title>
        <Text size="xl" ta="center" maw={600}>
          Connecting farmers with global export opportunities through our secure platform
        </Text>
        <Button 
          component={Link}
          href="/auth/signin"
          size="xl"
          color="green"
        >
          Get Started
        </Button>
      </Stack>
    </Container>
  );
}
