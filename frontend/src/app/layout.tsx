import '@mantine/core/styles.css';
import '@mantine/notifications/styles.css';
import '@mantine/dates/styles.css';
import '@mantine/dropzone/styles.css';
import '@mantine/carousel/styles.css';

import { ColorSchemeScript, MantineProvider } from '@mantine/core';
import { Notifications } from '@mantine/notifications';
import { SessionProvider } from "next-auth/react";

export const metadata = {
  title: 'Agricultural Export Platform',
  description: 'Connecting farmers with export buyer agents',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <ColorSchemeScript />
      </head>
      <body>
        <MantineProvider>
          <SessionProvider>
            <Notifications />
            {children}
          </SessionProvider>
        </MantineProvider>
      </body>
    </html>
  );
}
