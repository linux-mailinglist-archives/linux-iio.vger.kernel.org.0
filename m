Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E19433A1E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhJSPXS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 11:23:18 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:18040
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231189AbhJSPXR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 11:23:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9W+7CP8SW6yaQRzn4ceFSsiF5y/3BJnHEW14MwsUoGqV8ig15v7e6IRNK303BSOYKPkx3fXTFPSsB8wA0NGMNStiAYiPDlWTIqxmFINnSZ/pZKGUNq4XjFKmW3/t9lEzuq6u6ip0xhRW53zrb4LzHcdibQMuwg4fdrMLZTb2PV3alnuRroydWcylX6a6s0nkfetFa76Apnry0/UOHBa5LnsFLlTZ9YJinbWhvZpgi8qkwaKolvHYC3pMq4JVeuFmy+0l6Mg+hDVXKjd8+yajDSZEeWjy52f6pFh8+lZk3uq6KC9wNl12JL5tFJsj1rNrfVAQcw0MKSFWLClmfgaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nxzBRLSLiUrwm3jabPFngYSqsME4yTpVGTjF1Fu+/s=;
 b=Wedlw6uKkRd08FuzWyRUBnmtnGFTDSJ0ftQ/zrv4OuM/UFYdkQAUiGkPN0AYYf59OINzcsdmITXI6dVrCz91djnImt644rWOAMjtV4UugNsQoFeWWUnthNRsJCRH4d/sKEDIy/jBzffiPpAJZpIzjT1D8vkOlDXAZ1IupKUuVJZqVm8owSECri/wyPsoneFUgq2ejxBJKlT441WyycWJaUH0CQoUqwzlKRvbGPgKmHElwSF4wM73Z3hDjyx08CQTb0fT58CYKTVil8tTy71WYosCziepDqJJYTX/rxiZkSr8FFrhJNlc/bMRaSm8/jMpp5hwu1OKFrDpB8qvAQxZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nxzBRLSLiUrwm3jabPFngYSqsME4yTpVGTjF1Fu+/s=;
 b=lduyQrWW4433oN5NWO+qe7Hi2W+uMmtKkaDYZzAEoLB9BKE9BVQOO92xBwu+DneLN4fgsVT/NmOVXFszPvNF6QNS5Z2ffdqXVGqu/kzT30DwCp5uyrlMIUHZyYaGlF6CyZrXfR0Uk2iorowc3iW1tFGm/zHo/JmTUTtFx3S/rPk=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by DM5PR02MB3179.namprd02.prod.outlook.com (2603:10b6:4:66::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 15:21:01 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::69) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 15:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:21:01 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 16:20:56 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 16:20:56 +0100
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org
Received: from [10.71.188.1] (port=8251 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mcqv4-00030B-7X; Tue, 19 Oct 2021 16:20:50 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v7 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Tue, 19 Oct 2021 16:20:47 +0100
Message-ID: <20211019152048.28983-4-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b3ed4ea-8e1e-42b9-6595-08d993140f5b
X-MS-TrafficTypeDiagnostic: DM5PR02MB3179:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3179EB1A20D3AA6F34420332A9BD9@DM5PR02MB3179.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hxdkTS7HhoAd77qLqevdJYkYRsgvOGSgca/Mt5q6gbMe+jsdgqIrJyxg8GywixuT2mmL1EwvJBbrtXRriBkFT6f0fTr0TunlwP37KoEmLyd0Kf0eEn2rd1A9UbRuMY4V9HjTwp//Y0JTCvPThlJ3Y8F2LbwE1yFJWs9Fb1jbd4rd7waM1o0b15NqWMF5hDFVJBwXCafFxSIdQ4mLgs1jxjnrjoYQqlmkMVvHdI+/r549PXGWPJMR93xUURLZYz+qkefZ/I4XZdrju6DKfFEb5K3OlriYPuwlX63Pwc4AfRvcSdKViQajYEf+5R5MP6Qs037MYIRYrZJqrHXuME5iBTzbZyxAbGh7AxrzP8oaRmD2Y4F2fm9HTtuNlIOd/lqZ/yVFOW6PyUvDR53PNiAnbBTLLxw/USuwwFPJHnH/6XzdRy3ZdcBhp3SN/N54sbyXQxJto+e/tR2wSJzRPGmNheZuqAFML95Rf5wAjwu0Hm4y8OaHw4Pk9TVWsUymNpbWK/YFI2iFH1PXOxwDZoGp/Us85rBySN2mPIaihYGrIoxsYNXquSotuEjWjJ02MNLVyMcTLQJ5t1wRibiDp5CUCy0DhNZCajBEtbDFdoQpM+Ux/bbl4v3UESHotAk2f2p8F+9U5IkUxtE+m4fvAvxlMW6jPByYk3mcaA7jBZ4oDSPYKd7gtltURZf3X2Ly3Vu9tKuVrS5zQUnDL4Rbft0B1vXVFGmQrXUB8fLWCP84k4Oepj3BpD7BQPGH8C7q9QI9072UG5xXQa+/xgIfl2Z2OpuS+lYzJa7zQ4H1U29C9iSCbyf0cLgYhrm6ITIp44icUDIddhh8/zZVYRZxJFRsiosu9/1g/b12N2UTGL0MYY3LFf4zzjQUD1wwjY2oGuL
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(966005)(36906005)(6666004)(70206006)(356005)(336012)(8936002)(26005)(7696005)(107886003)(426003)(2616005)(508600001)(83380400001)(36860700001)(4326008)(36756003)(110136005)(2906002)(70586007)(103116003)(47076005)(9786002)(8676002)(7636003)(1076003)(82310400003)(5660300002)(186003)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:21:01.3663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3ed4ea-8e1e-42b9-6595-08d993140f5b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3179
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

