Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BD449D96
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 22:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhKHVIh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 16:08:37 -0500
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:61280
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239769AbhKHVIc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Nov 2021 16:08:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsMcVC4zb+g8hKCI1WOugq3RoJD7Y4tSiXkjPUiIz8efOgtVL0/oxMpn9n/dZ0zxKIRu49mhTnmg5DqX3LrvFt+j3atUe3rr3yDkHP0tzzJLqbeGZ815V+AogRZr2PbonjhCIQGQZFlt2htjOw05UW0MRGySZsM6nd9tUPLjCd7KW75aivt/80ee0W+PDAcqyt+1Daro2i0d1CYVpVPg96/hCLxCHxdhkB8NzIas4oh2agkQBJx5JYMqRq8yxHYbhd6KyGCmsIvZOBH6Mgo9t1dXqV043buO/kt3b9vqJB24u9BzTZnUttmdQ9cXQjJyo7JOGpjJFxnPtcXcmty00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nxzBRLSLiUrwm3jabPFngYSqsME4yTpVGTjF1Fu+/s=;
 b=RL9EFYYFcuwbfv2nVwLb0KcOqkO7QH1Nag0Jm5F00wadQgj3bbSCelOnMSYhcx9942V8z3goy5kTqfw2hnMaQsl9j0pbcHXyLjxTQPMlP0zyj2IA9hx2SM2kHECRMouvE7oY+cNE9ebdvug7M9kwA1D9cckwAsyGg/KLCb+9jQjkDEfAW0YZjinNItNNV3lX1zo9kmo1Hsty9OC/AmCy1BXyzgCH6oiDs7UIRH4RW+v2uo0HDgb9dOQqXtzuBUQudgNdAGK9FVIDf5Ukmqqr63cn/X3niP3z8lBWYHy5VpdU9RpjsdFB8Q+Ym/+1KtA3uiI5dRwQQOrqFumg1HFMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nxzBRLSLiUrwm3jabPFngYSqsME4yTpVGTjF1Fu+/s=;
 b=ZLRICXEZfLWUCGgGCdEZg5KOg8J9vjwvvhVt3+Bp9pqxMrk08nLWbkN4CuuNJd9xTOBSpE8KCS9mls/w0xYW7BopKCGqDVySFF88vOr97Rs2fxschON3PDVBG4NiA3+utiK4sRJNoVG7u+F0xhiHbvdAIDRwn6Y/7CzNuzjUU1I=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by MWHPR02MB2589.namprd02.prod.outlook.com (2603:10b6:300:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 21:05:43 +0000
Received: from DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::67) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 21:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT026.mail.protection.outlook.com (10.13.5.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:05:42 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 8 Nov 2021 21:05:39 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 8 Nov 2021 21:05:39 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org
Received: from [10.71.188.1] (port=52274 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mkBpj-0008LJ-5Y; Mon, 08 Nov 2021 21:05:39 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v8 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Mon, 8 Nov 2021 21:05:08 +0000
Message-ID: <20211108210509.29870-4-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2aa992-927f-47ed-f4a7-08d9a2fb86a7
X-MS-TrafficTypeDiagnostic: MWHPR02MB2589:
X-Microsoft-Antispam-PRVS: <MWHPR02MB258927311A0A741B129AF376A9919@MWHPR02MB2589.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcntXu/gFcDQDtuXmpDMcZLv3o/A7j4pz822VDEinmowqtg6wPH79CEIQTg39Hqb2fdZuAbrLkfIzdskPUhvMrLlbH/i8MtsJmrpwReyakCVWmtoh7l+9WAQNCit9YAZ55ErSQNuHWy1LeCvw8PIszKfKlBJh3ToSQ/HAzs6K8OEQB1ODyCiAfSKIC4iQ+lADB6v7q5jNzhtTdT+DWw/vB2h1dvpLd6VsXZPQkDcRC2pD514SRxdnYvdf16O7+X6klDOvxpXgT/7AuiaxGxtLhHM2czF22gVc+qz3R9MymtNaHs1H9ZRDLjxiH5tADkfWHMTpQhuZk4yhdfaqwKs5ViK1oO4xvohbnShvmnAR+FKqLtDQ3HWuizBjjOd4j0/1zwIciCqi0Oz7f1jUgwGgE4mT48vZZGQrLvzMbNVTUt7rvUGAI88d4TBhdfGF3bA6U1EPCm5yC2zxNv5LIdhr4+2d1uQE9dDKh/3zW6wdebeKR2prG5QwrrGaBNQNBk62HEIGS0sHDRXrvy5LAMFTrYrq/778JIexcmrchr8pckbZIilrCW6bnS+yJXUMu093tRN6n2qUXfO5o1W6A5/81wd65/FaUkOYeXNpaqx0UBw4ISAMoOKq6GfGbszmLPDULQZdSXhrvHLvX9qqNklsfZvNxofK9L0JIXk8CS4OYzxzR/YFHf01VwSjw5LVXkEvKKj5i6LCX48jEsRlrydAF9+D1v5hWamB+sgyQdco73+l7am3uRrXngn5ONEZdtTavSM9YEJCgcalKraCkc6hX7HqP9Iwmq+85Dppj2kv6AHQ0kUcXYNlV5jQ+b1Nvf6Bzuo3aRy0I8A3HjOHeVVOLfhd/5mCOArhzZ2s4fzpxqlI1/BjuNY5guvlPTipw+T
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(2906002)(103116003)(4326008)(70206006)(9786002)(107886003)(110136005)(47076005)(36756003)(5660300002)(7696005)(83380400001)(8676002)(6666004)(36906005)(1076003)(426003)(336012)(36860700001)(70586007)(508600001)(26005)(82310400003)(316002)(356005)(966005)(8936002)(7636003)(186003)(2616005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:05:42.6372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2aa992-927f-47ed-f4a7-08d9a2fb86a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2589
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
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

