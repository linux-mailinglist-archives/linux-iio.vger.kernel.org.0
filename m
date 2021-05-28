Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C862E39466E
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhE1Rb4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 13:31:56 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:37216
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbhE1Rbx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 May 2021 13:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTQaCHcjMSZYkViBVA2g1ctLZNn0Aw1iKlKymYvq15128843WpyKU4W7Pj2Tn+TNnwfkHehbRcXzHXAml41vdu+EZBUu9dXprrzu6V9YujUhL5czrliHqLo0lXmxs4y2KH3+F5XbF2H1Cj7KOGvKmxhCK3NubQWpL/95pbrZeEIPPBPv7dCpqSH0EKLNhqb8wosiUFszQ8pQbbsstPQb5aFjnhxoKnaYPF1sNuxzot7MbCBoAsozhiCjbSKtz3OdyGowjBFELjepZBLhZyC6SuEMu0z3BixZL4K3Y77klxRaTppJ9r+SFw5iaVupWB7U3pT8GoNXH4ZS0Vpf241YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc0pVLwrjxIi/ccus0Gx9fdZdufkkNpWkV3DShsQcf0=;
 b=eAeckqHsxh01DJYjrWwDdXbK1aPoYbgGd/ogg7dQoJ19rEDV6e4cyv5s1wNqW7q6xBB91qwqyB7Ok4JLCI1J8btLu3lL5J6GMLLjc4PRy6A0yoePhr7O/hOjnDiy1RZ/iBNNYAofqwBA2kvX+mP8kYS9PYl3PCwpqTuP/9PiuJMbzQdbJ/cdg8I02NX883138dYtc5G4y1uAoqZZKHFbyd1ylJlz+1suBnUuNNLjMVh6OctCzwf0DtBOCaOI0KXcOJDtE1ZANJA16Z/Po4B44lDBZw1bGImRwOGB53/o56u472I5VwViRLFRQdAIsqzw7nbJt5xJtAZlB3QwG/pSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc0pVLwrjxIi/ccus0Gx9fdZdufkkNpWkV3DShsQcf0=;
 b=mEOhxgf8e7SsAYW4widCGCe3b0ffLBS5kCIykIwOdFD23XvGDpDbubhe3gR9VHlD7v8ou5p7jw9A5t0S5cEYcCyoUMzEc5A+eiZi6UAF4UDTJku9n/0BmIll4iP2pmMF+0PoWWwOcxheWDPFxCVR8zy47JOteOpqccmyqt1xMH8=
Received: from SA0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:130::16)
 by BY5PR02MB6577.namprd02.prod.outlook.com (2603:10b6:a03:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 17:30:16 +0000
Received: from SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:130:cafe::f6) by SA0PR13CA0011.outlook.office365.com
 (2603:10b6:806:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Fri, 28 May 2021 17:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0014.mail.protection.outlook.com (10.97.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 17:30:16 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 18:30:12 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 28 May 2021 18:30:12 +0100
Envelope-to: git-dev@xilinx.com,
 anand.ashok.dumbre@xilinx.com,
 michal.simek@xilinx.com,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.71.188.1] (port=44054 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1lmgJA-0004hp-FJ; Fri, 28 May 2021 18:30:04 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v5 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Fri, 28 May 2021 18:29:58 +0100
Message-ID: <20210528172959.15663-4-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
References: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2d23d8-6fbf-4a9e-2315-08d921fe4243
X-MS-TrafficTypeDiagnostic: BY5PR02MB6577:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6577C323AF9CF1C8E9696F46A9229@BY5PR02MB6577.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGP8AnY1OHUtSNI+0FbAfg+XgBgARI9dFdnfIQxweOQ2sua1zrlVTS54eRpHD+BzodNED0YOy+q4Vb5alx2G+AoPZ2i/Jcbu3PX+DaZFnsOMxAQcTDmngbqA9g5ovkchpQnxw5HGddWlvXZ/ZhUwuqqK/ONet/1GYYcKjmj94u4rtCT1jvc09TuSOfYKAPPVRxYC6nkk6Rb+6Hj5VLSyj1NT2mWk05YWJpXK5xlRnMKjOnFRB36/jkA/SSmTt3z9Qfc6vf1ehBL/vz6rR69zPKkYU0NZZo+9CZqll3GnQw/oFnafzAqq+1Xbzbcmd3z6M8/6HSPR4NhUTkqDZuCZNUMOwYkmtnO2t1b7dp2ISqfjcklzZYkRq62RXVXgF4C6ehrrNYq8QWWkgBTkBBmlniOXK2JWwPwJ/WshUzgFUr2Y7juAjffJNOUl+f9kN8ftiUGjYVZZ5rKmjz21hBp7228iMDyEF3UXJXhq9WwzJAfnxcUOgeXKi2A+3S+irTErfI2PvSjeIdv1x74b+T9W82rMd5OJzqetikC6v6OdPATdSINuZ0+vuQpuqNMNSn5RJ9LFrfQbAflhyjzma68M8/Bm7t5mdLyNXnljAzSrljCdJHpnJv97y283k3iIMWbbX4omkIB2btfLoWkZ9TwQBdhTHBwv1Pbvetig/bcgOMoPcGGRQ4CCTWE8LYfeeQL40pZBPLN851dFhvfKmpGWG9XxqUL63xNLBjhWMVnlkHp6SOb7UdX4oxHL4CUNBjrAbFFSJH4KJgDKPmUM4Z5ccEA3NaUse93XKhIjr//L9qnUl2GatJa7QUfJC4p5cA/2
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(46966006)(36756003)(966005)(5660300002)(82310400003)(478600001)(316002)(7696005)(36906005)(110136005)(26005)(2906002)(186003)(8936002)(36860700001)(8676002)(2616005)(107886003)(426003)(336012)(1076003)(9786002)(4326008)(6666004)(47076005)(7636003)(83380400001)(70586007)(70206006)(82740400003)(103116003)(356005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 17:30:16.4072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2d23d8-6fbf-4a9e-2315-08d921fe4243
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6577
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 265 ++++++++++++++++++
 1 file changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
new file mode 100644
index 000000000000..df3cfca69e2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -0,0 +1,265 @@
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
+  Sysmon Block	|Channel|			Details					|Measurement
+  		|Number	|							 	|Type
+  ---------------------------------------------------------------------------------------------------------
+  AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.			|Voltage
+  		|1	|Battery voltage measurement, VCC_PSBATT.			|Voltage
+  		|2	|PL Internal voltage measurement, VCCINT.			|Voltage
+  		|3	|Block RAM voltage measurement, VCCBRAM.			|Voltage
+  		|4	|PL Aux voltage measurement, VCCAUX.				|Voltage
+  		|5	|Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.	|Voltage
+  		|6	|VCC_PSINTFP_DDR voltage measurement.				|Voltage
+  ---------------------------------------------------------------------------------------------------------
+  PS Sysmon	|7	|LPD temperature measurement.					|Temperature
+  		|8	|FPD temperature measurement (REMOTE).				|Temperature
+  		|9	|VCC PS LPD voltage measurement (supply1).			|Voltage
+  		|10	|VCC PS FPD voltage measurement (supply2).			|Voltage
+  		|11	|PS Aux voltage reference (supply3).				|Voltage
+  		|12	|DDR I/O VCC voltage measurement.				|Voltage
+  		|13	|PS IO Bank 503 voltage measurement (supply5).			|Voltage
+  		|14	|PS IO Bank 500 voltage measurement (supply6).			|Voltage
+  		|15	|VCCO_PSIO1 voltage measurement.				|Voltage
+  		|16	|VCCO_PSIO2 voltage measurement.				|Voltage
+  		|17	|VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).			|Voltage
+  		|18	|VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).			|Voltage
+  		|19	|VCC_PSADC voltage measurement.					|Voltage
+  ---------------------------------------------------------------------------------------------------------
+  PL Sysmon	|20	|PL temperature measurement.					|Temperature
+  		|21	|PL Internal voltage measurement, VCCINT.			|Voltage
+  		|22	|PL Auxiliary voltage measurement, VCCAUX.			|Voltage
+  		|23	|ADC Reference P+ voltage measurement.				|Voltage
+  		|24	|ADC Reference N- voltage measurement.				|Voltage
+  		|25	|PL Block RAM voltage measurement, VCCBRAM.			|Voltage
+  		|26	|LPD Internal voltage measurement, VCC_PSINTLP (supply4).	|Voltage
+  		|27	|FPD Internal voltage measurement, VCC_PSINTFP (supply5).	|Voltage
+  		|28	|PS Auxiliary voltage measurement (supply6).			|Voltage
+  		|29	|PL VCCADC voltage measurement (vccams).			|Voltage
+  		|30	|Differential analog input signal voltage measurment.		|Voltage
+  		|31	|VUser0 voltage measurement (supply7).				|Voltage
+  		|32	|VUser1 voltage measurement (supply8).				|Voltage
+  		|33	|VUser2 voltage measurement (supply9).				|Voltage
+  		|34	|VUser3 voltage measurement (supply10).				|Voltage
+  		|35	|Auxiliary ch 0 voltage measurement (VAux0).			|Voltage
+  		|36	|Auxiliary ch 1 voltage measurement (VAux1).			|Voltage
+  		|37	|Auxiliary ch 2 voltage measurement (VAux2).			|Voltage
+  		|38	|Auxiliary ch 3 voltage measurement (VAux3).			|Voltage
+  		|39	|Auxiliary ch 4 voltage measurement (VAux4).			|Voltage
+  		|40	|Auxiliary ch 5 voltage measurement (VAux5).			|Voltage
+  		|41	|Auxiliary ch 6 voltage measurement (VAux6).			|Voltage
+  		|42	|Auxiliary ch 7 voltage measurement (VAux7).			|Voltage
+  		|43	|Auxiliary ch 8 voltage measurement (VAux8).			|Voltage
+  		|44	|Auxiliary ch 9 voltage measurement (VAux9).			|Voltage
+  		|45	|Auxiliary ch 10 voltage measurement (VAux10).			|Voltage
+  		|46	|Auxiliary ch 11 voltage measurement (VAux11).			|Voltage
+  		|47	|Auxiliary ch 12 voltage measurement (VAux12).			|Voltage
+  		|48	|Auxiliary ch 13 voltage measurement (VAux13).			|Voltage
+  		|49	|Auxiliary ch 14 voltage measurement (VAux14).			|Voltage
+  		|50	|Auxiliary ch 15 voltage measurement (VAux15).			|Voltage
+  --------------------------------------------------------------------------------------------------------
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynqmp-ams
+
+  interrupts:
+    description: IRQ line for AMS
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: ams-irq
+
+  reg:
+    description: AMS Controller register space
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: ams-base
+
+  ranges:
+    description:
+      Keep the property empty to map child address space
+      (for PS and/or PL) nodes 1:1 onto the parent address space.
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
+patternProperties:
+  "^ams-ps@0,0$":
+    type: object
+    description: |
+      PS (Processing System) SYSMON is memory mapped to PS. This block has
+      built-in alarm generation logic that is used to interrupt the processor
+      based on condition set.
+
+    properties:
+      compatible:
+          enum:
+            - xlnx,zynqmp-ams-ps
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
+  "^ams-pl@1,0$":
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
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+    patternProperties:
+      "^xlnx,ext-channels$":
+
+        type: object
+
+        description:
+          List of external channels that are connected to the AMS PL module.
+          If this property is not present, no external channels will be
+          assumed to be connected.
+
+        properties:
+          '#address-cells':
+            const: 1
+
+          '#size-cells':
+             const: 0
+
+        additionalProperties: false
+
+        patternProperties:
+          "^channel@([0-9]{1,2}|1[0-5][0-9])$":
+            type: object
+            description:
+              Describes the external channels connected.
+
+            properties:
+              reg:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                description:
+                  Pair of pins the channel is connected to. This value is
+                  same as Channel Number for a particular channel.
+                minimum: 20
+                maximum: 50
+
+              xlnx,bipolar:
+                $ref: /schemas/types.yaml#/definitions/flag
+                type: boolean
+                description:
+                  If the set channel is used in bipolar mode.
+
+            required:
+              - reg
+
+            additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - reg
+  - reg-names
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
+            interrupt-names = "ams-irq";
+            reg = <0x0 0xffa50000 0x0 0x800>;
+            reg-names = "ams-base";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            #io-channel-cells = <1>;
+            ranges = <0 0 0xffa50800 0x800>;
+
+            ams_ps: ams-ps@0,0 {
+                compatible = "xlnx,zynqmp-ams-ps";
+                reg = <0 0x400>;
+            };
+
+            ams_pl: ams-pl@1,0 {
+                compatible = "xlnx,zynqmp-ams-pl";
+                reg = <0x400 0x400>;
+                xlnx,ext-channels {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    channel@30 {
+                        reg = <30>;
+                        xlnx,bipolar;
+                    };
+                    channel@31 {
+                        reg = <31>;
+                    };
+                    channel@38 {
+                        reg = <38>;
+                        xlnx,bipolar;
+                    };
+                };
+            };
+        };
+    };
-- 
2.17.1

