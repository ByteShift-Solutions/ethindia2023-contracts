"use client";

import React, { useState } from "react";
import {
  Box,
  Container,
  FormControl,
  FormLabel,
  Heading,
  Input,
  Center,
  HStack,
  Spacer,
  Text,
  Flex,
  Button,
} from "@chakra-ui/react";
import MasterLayout from "@/components/MasterLayout";
import { ChevronLeftIcon } from "@chakra-ui/icons";
import Link from "next/link";
import { DarkButton } from "@/components/DarkButton";

const Aave = () => {
  const [balance, setBalance] = useState<string>("0");
  const [amount, setAmount] = useState<string>();

  return (
    <MasterLayout hideConnectWalletBtn={false}>
      <Container mt={10}>
        <Flex>
          <Text flex="1">
            <Button>
              <Link
                href="/"
                style={{
                  textDecoration: "none",
                }}
              >
                <ChevronLeftIcon />
              </Link>
            </Button>
          </Text>
          <Heading>Aave</Heading>
          <Spacer />
        </Flex>
        <FormControl mt={14}>
          <Flex>
            <FormLabel>Amount to deposit</FormLabel>
            <Spacer />
            <HStack fontSize={"sm"} cursor="pointer">
              <Text>Balance: </Text>
              <Text
                _hover={{
                  color: "blue.300",
                }}
              >
                {balance}
              </Text>
            </HStack>
          </Flex>
          <Input
            type="number"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
          />
        </FormControl>
        <Center mt={4}>
          <DarkButton>Deposit</DarkButton>
        </Center>
      </Container>
    </MasterLayout>
  );
};

export default Aave;
