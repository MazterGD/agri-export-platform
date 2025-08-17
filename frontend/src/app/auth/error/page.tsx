"use client";

import { Container, Title, Text, Button, Stack } from "@mantine/core";
import { useSearchParams } from "next/navigation";
import Link from "next/link";

export default function AuthErrorPage() {
  const searchParams = useSearchParams();
  const error = searchParams.get('error');

  const getErrorMessage = (error: string | null) => {
    switch (error) {
      case 'Configuration':
        return 'There is a problem with the server configuration.';
      case 'AccessDenied':
        return 'Access denied. You do not have permission to sign in.';
      case 'Verification':
        return 'The verification token has expired or is invalid.';
      default:
        return 'An unknown error occurred during authentication.';
    }
  };

  return (
    <Container size="sm" py={40}>
      <Stack align="center" gap="md">
        <Title order={1}>Authentication Error</Title>
        <Text size="lg" ta="center">
          {getErrorMessage(error)}
        </Text>
        <Button component={Link} href="/auth/signin" color="green">
          Try Again
        </Button>
      </Stack>
    </Container>
  );
}
