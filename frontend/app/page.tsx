"use client";

import { Center, Text } from "@chakra-ui/react";
import MasterLayout from "@/components/MasterLayout";
import { ProtocolGridBase } from "@/components/Protocols/ProtocolGridBase";
import { protocols } from "@/data/protocols";

export const runtime = "nodejs";

export default function Home() {
  return (
    <MasterLayout hideConnectWalletBtn={false}>
      <Center flexDir={"column"} mt={"3rem"}>
        <ProtocolGridBase protocolsData={protocols} />
      </Center>
    </MasterLayout>
  );
}
