Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED89453554
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 16:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhKPPM5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 10:12:57 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:56800
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238033AbhKPPL5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 10:11:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhy/W86QH/NX/N/WsNxLQq3vQBrKV6AMVZS91kCobBwaMojLdfcI1KSJr1jnew1yB55M3kAws2osHMbWGdGqrV7vorvQD10vIN8ASqIALoDGtqTIdG2e0B8f88thQ2fZL1cCrkqWILZF7OCZoF8uTE6P+5z9KpHkmO4Zq6aFrydc2I1PD/xAghNDzUNjQ7pOqpA4AvwVtXfTYHcuUnWL+RUDkVXf2QpMGmgTIrXKO7Ld52pavg3R1NwVoYbd5N/aJi3nLxDbYUaNXxg/ZzpyGygqHifZXxq34BvCZC4uQhex6GDDjXoncMxnWmMo1W6teAB/AzO8b8YlaSJF70Y0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ/MGkAWI2JN+XbJ/rh4fCzf0wpVeH0QKtVIy03fiS8=;
 b=csgMBk+exfC6Ivd6WObF03GwshtSwIyg7JszMDIvsdovMRgLB7WOzmUA24zbc0StgjjqnBeHvU0TgRxg7ivmBEZeoqvnGnHSXOpxJ9RBiScpnlYgm3zGUR4/WvzYwDmWjeHXJ02rsR9BqpbKKJYaWPit2sN87/PM3rJM4DtoKXgxkvnJ76NsOZ+y0LQP7XNk3mcBVIJtdFqr0a7nIoUev53GPgmEuF9/8lMavRyFbDxxovm2ECxP2igPPkVuw+27YfcWitCIL+95LQdjGYgVMgHZPBYNnzkLGn/X0lS37lFcOODTkymSiHIqv9Pllhs3dkHuHrWNuKxqkJ+OSYXGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ/MGkAWI2JN+XbJ/rh4fCzf0wpVeH0QKtVIy03fiS8=;
 b=K3N3Vayq8DFvFIs1fJp+pXuCKqc5GO1bKrR64m/I8LbwWuIdbyECZUFeFvKqGZZM/MU1A0/PCUUY0hJI8MfQ28VDmT1IeTo3wz8WKep9GIh4/tlaILK68nRNeDstM4XTcQUP5b4M54I97fSqj09Z/JfqMdmSv7aUYWrt8rpjnv0=
Received: from BN9PR03CA0953.namprd03.prod.outlook.com (2603:10b6:408:108::28)
 by CY4PR02MB2568.namprd02.prod.outlook.com (2603:10b6:903:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 15:08:56 +0000
Received: from BN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::2d) by BN9PR03CA0953.outlook.office365.com
 (2603:10b6:408:108::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Tue, 16 Nov 2021 15:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT060.mail.protection.outlook.com (10.13.3.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 15:08:55 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 15:08:50 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 15:08:50 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 andriy.shevchenko@linux.intel.com,
 heikki.krogerus@linux.intel.com
Received: from [10.71.188.1] (port=4502 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mn04i-0008P4-3u; Tue, 16 Nov 2021 15:08:44 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v9 4/5] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Tue, 16 Nov 2021 15:08:41 +0000
Message-ID: <20211116150842.1051-5-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cceea2d7-ee36-4170-d85c-08d9a9130229
X-MS-TrafficTypeDiagnostic: CY4PR02MB2568:
X-Microsoft-Antispam-PRVS: <CY4PR02MB25684C950A0F6DCFA5F18D7BA9999@CY4PR02MB2568.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+iOQRb/cjzuarWCVqLUOa4yNHzL8e2fnqukTQyYPB6stnI2SEO7AIpqSvagULFhkeEa0qIClos5bsafbIsOyBSecsx0NYL51CYIwFqh1mPjR0AjZRsFh0RGEQNom/J6WPNQ+Q+3RqIVjoM2j4qfIR+OFBJgh5BIdrC9ZXCxA4AeHlPcMTjEY98JvoqVuGUzYeO4LBvGxPiHe7jVFT6Ex5/Nsaq5KVqlyeG+PZKBMTEI6w28Z3lTxRE5cNJlc1z0EtwcrylzHCdGpkRJg8Sz1qrWV1N5x35qinF0Gd7seWpvJ+0iJULWx2W/rtVLPKG8zDDceiJ1Yjq9HOuI0Yk9F8YhGSxXtOo2VyQG0I/jEWnV7+urGd5TK+SqfKCy1tygoZzApk+wEcfcZIeBmhNfLmZRe4f0YBDENQcP5/hqx3us5wmBV5PDQVlY3tH05oMCKbAXDsN/YWuyc+O1US+u38UDV4R2KqjSU+zSfJryuUwtIdfAaxNX77OFMb00tFAIt++0czOhwVJ05FfOeBHAI58VE9Tdm7OsjwgcUok7mAdtLUkJ7tvyYrTs7oSuFlvz2FcpvPB5ClcAeSEwTctGKG882f/YPajcz8bFrsIq+0JU8omfTMstxUimi1K9ba9K5uvpcXrYMuNZc+vF0nOIIzzRHZ6gBkTasMTBLqP2GIpLp6kMFEhMz9YvqNTv71pe1kgIjhtS5ovsSYE8HgKU/MuXOv2L46c56PkwtKQRnVCafk2KnzGMtFCqE4L9TrAo1SgVZfBNliN5g5Ihugy9oESZz7CQs09Uj9ryUTO7/MmhstwZCfSu/+T8CChIrZwkU1tDwSxMkq+etlocDvcQqx/YCP7bJk3Nn+j5m9AX7KeTtRrb3cu7bsnkCUdO/37pWTSg71hkIn9+ZHNSt57me2zLnnoRfi8tUrKCyWxxE2M=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(47076005)(2616005)(110136005)(82310400003)(103116003)(9786002)(36906005)(316002)(426003)(70206006)(83380400001)(6666004)(2906002)(36756003)(70586007)(4326008)(356005)(508600001)(26005)(8676002)(336012)(7636003)(8936002)(966005)(921005)(5660300002)(7696005)(186003)(36860700001)(107886003)(1076003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:08:55.3706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cceea2d7-ee36-4170-d85c-08d9a9130229
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2568
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
new file mode 100644
index 000000000000..87992db389b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -0,0 +1,227 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,zynqmp-ams.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Ultrascale AMS controller
+
+maintainers:
+  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+
+description: |
+  The AMS (Analog Monitoring System) includes an ADC as well as on-chip sensors
+  that can be used to sample external voltages and monitor on-die operating
+  conditions, such as temperature and supply voltage levels.
+  The AMS has two SYSMON blocks which are PL (Programmable Logic) SYSMON and
+  PS (Processing System) SYSMON.
+  All designs should have AMS registers, but PS and PL are optional. The
+  AMS controller can work with only PS, only PL and both PS and PL
+  configurations. Please specify registers according to your design. Devicetree
+  should always have AMS module property. Providing PS & PL module is optional.
+
+  AMS Channel Details
+  ```````````````````
+  Sysmon Block  |Channel|                       Details                                 |Measurement
+                |Number |                                                               |Type
+  ---------------------------------------------------------------------------------------------------------
+  AMS CTRL      |0      |System PLLs voltage measurement, VCC_PSPLL.                    |Voltage
+                |1      |Battery voltage measurement, VCC_PSBATT.                       |Voltage
+                |2      |PL Internal voltage measurement, VCCINT.                       |Voltage
+                |3      |Block RAM voltage measurement, VCCBRAM.                        |Voltage
+                |4      |PL Aux voltage measurement, VCCAUX.                            |Voltage
+                |5      |Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.       |Voltage
+                |6      |VCC_PSINTFP_DDR voltage measurement.                           |Voltage
+  ---------------------------------------------------------------------------------------------------------
+  PS Sysmon     |7      |LPD temperature measurement.                                   |Temperature
+                |8      |FPD temperature measurement (REMOTE).                          |Temperature
+                |9      |VCC PS LPD voltage measurement (supply1).                      |Voltage
+                |10     |VCC PS FPD voltage measurement (supply2).                      |Voltage
+                |11     |PS Aux voltage reference (supply3).                            |Voltage
+                |12     |DDR I/O VCC voltage measurement.                               |Voltage
+                |13     |PS IO Bank 503 voltage measurement (supply5).                  |Voltage
+                |14     |PS IO Bank 500 voltage measurement (supply6).                  |Voltage
+                |15     |VCCO_PSIO1 voltage measurement.                                |Voltage
+                |16     |VCCO_PSIO2 voltage measurement.                                |Voltage
+                |17     |VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).                 |Voltage
+                |18     |VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).                 |Voltage
+                |19     |VCC_PSADC voltage measurement.                                 |Voltage
+  ---------------------------------------------------------------------------------------------------------
+  PL Sysmon     |20     |PL temperature measurement.                                    |Temperature
+                |21     |PL Internal voltage measurement, VCCINT.                       |Voltage
+                |22     |PL Auxiliary voltage measurement, VCCAUX.                      |Voltage
+                |23     |ADC Reference P+ voltage measurement.                          |Voltage
+                |24     |ADC Reference N- voltage measurement.                          |Voltage
+                |25     |PL Block RAM voltage measurement, VCCBRAM.                     |Voltage
+                |26     |LPD Internal voltage measurement, VCC_PSINTLP (supply4).       |Voltage
+                |27     |FPD Internal voltage measurement, VCC_PSINTFP (supply5).       |Voltage
+                |28     |PS Auxiliary voltage measurement (supply6).                    |Voltage
+                |29     |PL VCCADC voltage measurement (vccams).                        |Voltage
+                |30     |Differential analog input signal voltage measurment.           |Voltage
+                |31     |VUser0 voltage measurement (supply7).                          |Voltage
+                |32     |VUser1 voltage measurement (supply8).                          |Voltage
+                |33     |VUser2 voltage measurement (supply9).                          |Voltage
+                |34     |VUser3 voltage measurement (supply10).                         |Voltage
+                |35     |Auxiliary ch 0 voltage measurement (VAux0).                    |Voltage
+                |36     |Auxiliary ch 1 voltage measurement (VAux1).                    |Voltage
+                |37     |Auxiliary ch 2 voltage measurement (VAux2).                    |Voltage
+                |38     |Auxiliary ch 3 voltage measurement (VAux3).                    |Voltage
+                |39     |Auxiliary ch 4 voltage measurement (VAux4).                    |Voltage
+                |40     |Auxiliary ch 5 voltage measurement (VAux5).                    |Voltage
+                |41     |Auxiliary ch 6 voltage measurement (VAux6).                    |Voltage
+                |42     |Auxiliary ch 7 voltage measurement (VAux7).                    |Voltage
+                |43     |Auxiliary ch 8 voltage measurement (VAux8).                    |Voltage
+                |44     |Auxiliary ch 9 voltage measurement (VAux9).                    |Voltage
+                |45     |Auxiliary ch 10 voltage measurement (VAux10).                  |Voltage
+                |46     |Auxiliary ch 11 voltage measurement (VAux11).                  |Voltage
+                |47     |Auxiliary ch 12 voltage measurement (VAux12).                  |Voltage
+                |48     |Auxiliary ch 13 voltage measurement (VAux13).                  |Voltage
+                |49     |Auxiliary ch 14 voltage measurement (VAux14).                  |Voltage
+                |50     |Auxiliary ch 15 voltage measurement (VAux15).                  |Voltage
+  --------------------------------------------------------------------------------------------------------
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynqmp-ams
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    description: AMS Controller register space
+    maxItems: 1
+
+  ranges:
+    description:
+      Maps the child address space for PS and/or PL.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  '#io-channel-cells':
+    const: 1
+
+  ams-ps@0:
+    type: object
+    description: |
+      PS (Processing System) SYSMON is memory mapped to PS. This block has
+      built-in alarm generation logic that is used to interrupt the processor
+      based on condition set.
+
+    properties:
+      compatible:
+        enum:
+          - xlnx,zynqmp-ams-ps
+
+      reg:
+        description: Register Space for PS-SYSMON
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+  ams-pl@400:
+    type: object
+    description:
+      PL-SYSMON is capable of monitoring off chip voltage and temperature.
+      PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
+      from external master. Out of this interface currently only DRP is
+      supported. This block has alarm generation logic that is used to
+      interrupt the processor based on condition set.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - xlnx,zynqmp-ams-pl
+
+      reg:
+        description: Register Space for PL-SYSMON.
+        maxItems: 1
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^channel@([2-4][0-9]|50)$":
+        type: object
+        description:
+          Describes the external channels connected.
+
+        properties:
+          reg:
+            description:
+              Pair of pins the channel is connected to. This value is
+              same as Channel Number for a particular channel.
+            minimum: 20
+            maximum: 50
+
+          xlnx,bipolar:
+            $ref: /schemas/types.yaml#/definitions/flag
+            type: boolean
+            description:
+              If the set channel is used in bipolar mode.
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        xilinx_ams: ams@ffa50000 {
+            compatible = "xlnx,zynqmp-ams";
+            interrupt-parent = <&gic>;
+            interrupts = <0 56 4>;
+            reg = <0x0 0xffa50000 0x0 0x800>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            #io-channel-cells = <1>;
+            ranges = <0 0 0xffa50800 0x800>;
+
+            ams_ps: ams-ps@0 {
+                compatible = "xlnx,zynqmp-ams-ps";
+                reg = <0 0x400>;
+            };
+
+            ams_pl: ams-pl@400 {
+                compatible = "xlnx,zynqmp-ams-pl";
+                reg = <0x400 0x400>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                channel@30 {
+                    reg = <30>;
+                    xlnx,bipolar;
+                };
+                channel@31 {
+                    reg = <31>;
+                };
+                channel@38 {
+                    reg = <38>;
+                    xlnx,bipolar;
+                };
+            };
+        };
+    };
-- 
2.17.1

