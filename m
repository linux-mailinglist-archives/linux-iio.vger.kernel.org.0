Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187066DF70
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjAQNxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 08:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjAQNwx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 08:52:53 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87AE3CE05;
        Tue, 17 Jan 2023 05:51:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHyNDdIRLPrBVZVqDA3iKT8EoFzo7Xm0m8abhQpnukILeFbq2L1trikcdzdzQ35n26YkxsbxxWKuZ6osnshPt5X1oeMylGCGp317mEePNZ6y/0Nwz8uDaBvLrUXY8ByyJoeu5OnZtkDUEeQKkyYWXw/GPJ8gIt/eygw9lxgwi9P360jD9aL71KB0D4JsZd1sqcJoHPlocpO9C2OSd1Z0wO+uFt1z2xSB3ut/FQ0HHno9cNm2YCljFs2zXMssQqZUWExLBzfsNpqUCaiYKpvO009nKu4Bv7U9IZlw2X9Al5vS3QsJZYnaaLnIxHkFm0RAVBJ4EZTakxNvxYezq7QX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dckup4bNqyej2ibkcfsxjXeol4324ikjI78C+Rf6Q4=;
 b=IfKcMnHi2zf/eCzRbQ2jp45STQ7Prj5iuN5KWnW0IZrvQ7oepcVuT2gVQlsYwJwaDwaVt3C4Oi2kSQe8P3ZPsk9H2592uPUa4UdecKOA0R9zA6UN52GBvlOLWb3RmcgvnX+2//dUy+U/NRGToR5O0QD/fF1UzkFzELQoa6Mg6KUbfVAYKLz3tgVzFNGRgaqqBxsB1xO290HTYaJo1dKBfBBiVFd7nQKgpGxfF21VHM1y4BEZ/7C4nrQdNVlr3wk0FA27cIt/26FfPlTmsxkkj7P5wupbWgOaIpMr4vCdEUf+8kDvORi/j/vOA+ZhgmRhKGR4sS2MHXHSp28F/NiUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dckup4bNqyej2ibkcfsxjXeol4324ikjI78C+Rf6Q4=;
 b=G6+d45zxE6wz/QRJLZjF37qO9WNqoOQ8RBKMU1cLoTa/9AQp+B16qYjJUXTi38KzpbZTiZoulwb7g2NE671IDRIh192Ax+5luoEDTAsG3Jq9reUc48LxKUMhffqyl7V8p1MgKrDcMGusNaCfCIgjkF00C96COnqSiAgD33seOEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:51:22 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 13:51:22 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        haibo.chen@nxp.com
Subject: [PATCH v6 2/3] dt-bindings: iio: adc: Add NXP IMX93 ADC
Date:   Tue, 17 Jan 2023 21:51:36 +0800
Message-Id: <20230117135137.1735536-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117135137.1735536-1-haibo.chen@nxp.com>
References: <20230117135137.1735536-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bebf70-b3de-4e01-053b-08daf891eab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGfUHrn0dUlzkhz+yHb9EL+7xYrA75PwMOz1eCDBRfQtDbxj0ntqtSiBv3WlbSbLeF83soLWaNufFLsT+cUKOIuzVoCu2IJXPkxKJYhJkyjRJD/F4nob6I+xxoe92u/JDWZ5zlY605U+4PU6CgfVdNJ2ND/e5MgW23tvfcio2jvcRe5t1rKRiKWYNmhKt2tOh3GXdPUSGx2/3o+ArsK8pSeN+Ek7JNuBADfN9kcpUZz0UKWuRwoO4tB7IhqpL4XWXnAhwc0A61XFO/P4KzEiyVcQq4VHmkx4pvJcCZxcgHqg8sgNsTlvdQYbudVQ22O1LLeWLC+AM+rM0zgTIgUYp883pLRK+x3Domu5rFn/Yfl+v4IfiVlpRGAM5oIgLsp3A/R9/Kfpz2BHVGT9P3A1e2ad4ZhYrXFEz3tRK6bGq+3E6tgNxGsYGVaEHLecz2zj5tXJYrtflIErfswH0V9BOLVMBboFlEzgSLFfXA4Ap9nhsfeHjE4uA2m4mi80YRJj24awamq7/k4IdktJeZebvaXmymVfc7K+wAaBfgB9amSbs8gHJYI3jJPMdoL+fXFjqQ2LrULZyjzgkH+A+W7qGo6RldF7QvlHp+c0A3gQsbwXqWd30ASn7VKONEwbfv6tG7nuVmAjX4cPLDB9HPjcFPZNNanmul7b1/8/cmGgjLmiMkh8H54rGhp9NWCDPZRN+OhZRqQGvyyzEoJKdfVcmHSb5PKCuGcbc+7LfB0w09177gT52km0KMPdFgZ8EGp2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(36756003)(86362001)(66946007)(66556008)(8936002)(8676002)(66476007)(7416002)(2906002)(4326008)(38100700002)(83380400001)(5660300002)(38350700002)(316002)(6666004)(6486002)(52116002)(966005)(41300700001)(478600001)(2616005)(6512007)(1076003)(9686003)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vHPUuYkuQE/D8zakpbhX8Mb3Tcbp/qKRN6QE32EhB9y46aIMPp57uN6zl/4S?=
 =?us-ascii?Q?REKrEdlY8fA47Zyzqwnb8owwjhPDMihZqn0df4RtNbEBpxrzTvSHZSqaMfEG?=
 =?us-ascii?Q?ZzaELPnhr/e4DhJ1FjSJAW2fX8VY98H20N7Y/ZHbe/xcQd5fS6Rd/N6qZfx2?=
 =?us-ascii?Q?8h+4/5iwWv8eRTeMp7v/XKSiaaWaEUgOWLnm94ZQDdgiw9ng8zyLiTS3EdRf?=
 =?us-ascii?Q?BFz5UYw+DhgVHm3D6lIJg25c0rSmQ2RfrxCxz0cSQzGX0PNbLEaBpEpLsUtz?=
 =?us-ascii?Q?iBWTMhi3Y/ktjFhA/WnnbqeL2n6PmRaelc12iNKrk20tucJZziOhin/zkjXK?=
 =?us-ascii?Q?BFMkfYu8oluM/OIhFj1KjrfOlDMROX/rdPjE73Q/LwjhDSmAmaUg6lss7g8Q?=
 =?us-ascii?Q?5U9JkwpyfWN8EyanQ6k3FySpt8+89w1oUfUzQi9jxfq4HUTwx3oLbhdocjRK?=
 =?us-ascii?Q?ahyA7aYF0aJ0xXzrOHijeVnB1nhl0lABTIAHtpsnHZsEvRaof7uJ5hX/sRAB?=
 =?us-ascii?Q?dnEuEH7/nwn3HyOKvKAF8O4XMcAzPd71yLS5RSlO5ykiFJRIN7+Zc519fu+J?=
 =?us-ascii?Q?+Ze0FlOazKVYD0QP0ngIQ5rxYSsZwVSZqlYAuz9N3FIe720SCE5gaETp0+bp?=
 =?us-ascii?Q?hdwR37BUROrT9GeMckezxY3inBzhA1kAcEhejnOBdsGsCrtSdJv/i9Vu6AYT?=
 =?us-ascii?Q?SmcSxHuje5YhSsrMNVpzm+AvXIrtN0FQ0rExILJf5DRckII8zwBVA52MoQZi?=
 =?us-ascii?Q?ofqEjyz+xzlSDgitS09XxIBMHtY+QUy0V9jF8nU8cHU9e7DQ2wTojJUW0urg?=
 =?us-ascii?Q?nemI8QXF5iOggi5sRIzr0BPLEJNm4cWUiHgRnzK9/Z5R2kwg0T6V+NrFQLY5?=
 =?us-ascii?Q?PEhzSQuAUWA9rLhcJa5/CpTxOm6m/eMgMcafQugIPWB/qU+QIxL3rCG/ywrH?=
 =?us-ascii?Q?clRTy9FmdN22qUThwgeMkOqF2k/TwuOvTttVFTV7fL1aTq1vKRGgSYtjIgiD?=
 =?us-ascii?Q?QFYywyB370ctF8s0ropVsif3cGuunVYd1GlCJqHS4cjXN7VMdCMntiqxfmGe?=
 =?us-ascii?Q?uPcHTCdc/gD9JnCYK7u1Id3TyxRbGMNXJUIAloJqTPGytf2tVVXe6dzXwANP?=
 =?us-ascii?Q?YKO0o/HJ/x7qu/2Xmh6LPX8hD7Jxjqcb6xjPSNa7yTZbH1tX3bXyQXHpDR+n?=
 =?us-ascii?Q?mvAFHZxTfJqgpprRxZomeL0PSVHtNTjLyymSnY1gKM8+mFSHldKXwcc7CGMg?=
 =?us-ascii?Q?QWn+5gf70Ao54qz6/uxn6UZ/XMa3PPRbjozXePkZ08b3lzEpH/y4g1OEGEuC?=
 =?us-ascii?Q?i48YoHqR15QaHtpgj/3suQvdWeiUHDetDC2NTDVdFx7XKwmJkMi1+kwbRTcq?=
 =?us-ascii?Q?vzo3uu7uCN24b1LwyQuqGK3BbKzWtfew5MifMK399INYEnwJHsbQ1DeMhWO2?=
 =?us-ascii?Q?Q1PMbRJzbP3JTyIYZD0F/kqFbYlzqJOywTmqORNxrRh+g8VIs4Uc5xh1W4fy?=
 =?us-ascii?Q?zblE2tNedqSWmwn4/Hvaf6Eg1S5QMUnW8vuChO5/k2kXtMAXIdRBQmISfnAR?=
 =?us-ascii?Q?4zTGX0EJbHgjXIYGRfytMkWho8HJe4N2/+SdkKNx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bebf70-b3de-4e01-053b-08daf891eab9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:51:21.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcUWqHrw4Wi65kwQ98KCEoopPhHLG1QUgDFigRix3U0uuxVHKk8EJIjPzKbTrkWqk0pKCzj/PNgM8CgX4i7glw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The IMX93 SoC has a new ADC IP, so add binding documentation
for NXP IMX93 ADC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../bindings/iio/adc/nxp,imx93-adc.yaml       | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
new file mode 100644
index 000000000000..dacc526dc695
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,imx93-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP iMX93 ADC
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+
+description:
+  The ADC on iMX93 is a 8-channel 12-bit 1MS/s ADC with 4 channels
+  connected to pins. it support normal and inject mode, include
+  One-Shot and Scan (continuous) conversions. Programmable DMA
+  enables for each channel  Also this ADC contain alternate analog
+  watchdog thresholds, select threshold through input ports. And
+  also has Self-test logic and Software-initiated calibration.
+
+properties:
+  compatible:
+    const: nxp,imx93-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: WDGnL, watchdog threshold interrupt requests.
+      - description: WDGnH, watchdog threshold interrupt requests.
+      - description: normal conversion, include EOC (End of Conversion),
+          ECH (End of Chain), JEOC (End of Injected Conversion) and
+          JECH (End of injected Chain).
+      - description: Self-testing Interrupts.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ipg
+
+  vref-supply:
+    description:
+      The reference voltage which used to establish channel scaling.
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - vref-supply
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@44530000 {
+            compatible = "nxp,imx93-adc";
+            reg = <0x44530000 0x10000>;
+            interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk IMX93_CLK_ADC1_GATE>;
+            clock-names = "ipg";
+            vref-supply = <&reg_vref_1v8>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.34.1

