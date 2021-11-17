Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5389454AA1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhKQQNq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 11:13:46 -0500
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:54696
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232073AbhKQQNl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 11:13:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIIYGTBBn8UQ31pIk43GRK2pvdP9Zlfdcd4ft9ncHj2hvwXqh5f85Gp0cU3difqqsE/b3FiItOiqw397OzQKOAD7Jfyj5n08Nnjw5rOMKdHwTA7u6vKKX65bOMier415rRDMqOqfF1jVdenRcuBDbBoyZgyF/tFPBDdKf1zsqSQsIWHpPuR3BYXLg4kV9CG/z3ZIYHn66Vt91GT0JsUIWAEr39QQ4jokU81CxGPYUT/ZAnY25gSgqzDkg1U7bEQJ+fi9/f9ZufM5xhkb+SnL45k9oBxHdTtFFLHq1nXBZ4y1BTKvtTLjbns/A0g2eRzfKtHFRlddWzVjbllBjF0RuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ/MGkAWI2JN+XbJ/rh4fCzf0wpVeH0QKtVIy03fiS8=;
 b=ZSis/aXWSDNvD2SD6Mp1ia/N77/chz0WuafuacFlemvEN2dhtyl+J7oULfiwS0UCQka9xSbufZorUnGWi7wTWobusntMfIvLa/ateQFGbhd2SMuQFTfdRwukkzvx0Y219MZK683iWmJy/JeDo//Cexc0mnNFk86Fp/j54LaAx3m/6bkrG1YcY7+Siu4SaexpPwRVqZT8NcmiNPW8D7PIorNJmFbQinMjlociGB2UNJF7qdDfqSRUS0tVSKcnU5MzA/9xITSxCrgL6IvYbmvvirZ6I0jPksRF5Zrzt0edB2KgshfvxuwJvSLO4/Q3IkGSkjaWbe7ZZs5ufMkliwBoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ/MGkAWI2JN+XbJ/rh4fCzf0wpVeH0QKtVIy03fiS8=;
 b=AP3Mv2XDTixGdZm4TQMWEOiScyMWnn17eaakOwIbksjaSI3OixJwEHU0Lw04oeI+JD+FRd5F5fCFlV3diu8HkAH8VnHu2nM9Rjnx47TSs2bmFyahpuZokoQANIR560AhWyHK8y0vRE5lxLRodeh4fyHVT1XJFXL53ZcXHwneD4s=
Received: from BN9PR03CA0337.namprd03.prod.outlook.com (2603:10b6:408:f6::12)
 by SJ0PR02MB7134.namprd02.prod.outlook.com (2603:10b6:a03:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 16:10:39 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::67) by BN9PR03CA0337.outlook.office365.com
 (2603:10b6:408:f6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Wed, 17 Nov 2021 16:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 16:10:39 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 17 Nov 2021 16:10:36 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 17 Nov 2021 16:10:36 +0000
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
Received: from [10.71.188.1] (port=38490 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mnNW2-0000gH-5U; Wed, 17 Nov 2021 16:10:30 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v10 4/5] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Wed, 17 Nov 2021 16:10:27 +0000
Message-ID: <20211117161028.11775-5-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 372cb981-6c27-48f3-c16c-08d9a9e4cc2b
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7134:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB71342DEC0ECD7AC5FB7E9BC9A99A9@SJ0PR02MB7134.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kT1zlmaS9OkHt7aYFq94O+g6iQ6YdEefHTd9LSGsjT8GC/+1A+W/r7qe9MkX1k4xSxeL0P7gQWcpzN9LB3ahOxTlfHF3AyiXtmPmBia+Lixt5P/uCtep702M+23WmEW4MPkUu5EvS/QAzh00mD9D5rIfiV6F42twrCK+Qp+KKh1D6lU/8Hd/ce0oDWcNdFLjcsPFY1qs/v4ZIJu+lgwwJo/7Ji4ZFOMZHW3zLIwMAI/ka7f+nAdKsiNfLgrkKlXjUirPusdwxJtWp1bohU/j+46Fm0Na8K5VplpZaylhk7A7h/6j63D4Rr9H06Nrwy8aIGgOpHWZeAY9J5eYkgK3fYipGLo0ZoxM7c0h3TtqD0WctKQ6FWlp1VvDY/av9GwQ7wcJH+UBU6ydyfjBeBbZ2eD4NhgHp47yJV9MJG009fh7P/TbkPd1iRbzZ9vrABAYoGP+0vyO36CZetgQ2eWhyJBaRRYRgVZ5IwPbfrKl/5HngODqpuTHavAztE2++9AAT+yaMWK9qyiiTckqclEiNi8U+tBDoRIjoLPY2EVokqcmaHG5UPiY0aY+BBMpm2fxj2Q2+chgeyO+KBsShTxpJpCVChLghIMtvUIwAmqduttPLNP55lpLffiP57qHr8tPkqFEBuckwBX0QBCh1OsStk43OkZ5AD3lFtXcXKZIgz+E1f5REnesf2TFT8qdGPj6dr97Ey4hok5RDYG+vIJen+vxAfVGdAaX41SFDcp0JbG0r5JUdLbQ9XVCiVueTnTOV/pr50HfFuvytp5g2pWPais9lA9NbuHnGpMCICtN8OwzFO+fOgso/wxUWQPUdIPAuJNNKADeTEv1I7s9jM2++FUBmTyYMMbmDdbPyEcsPhgnEzv+46wz2lPhpRE+UwTQwhwtymZdS60z/RTfEz/3ey3x1EAIWLQhPjWPGgtMBZM=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(336012)(426003)(36906005)(5660300002)(921005)(2906002)(316002)(2616005)(7696005)(4326008)(1076003)(36860700001)(36756003)(103116003)(966005)(186003)(508600001)(110136005)(26005)(8676002)(83380400001)(6666004)(47076005)(70206006)(107886003)(70586007)(9786002)(8936002)(7636003)(82310400003)(356005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 16:10:39.1003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372cb981-6c27-48f3-c16c-08d9a9e4cc2b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7134
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

