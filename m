Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B84655FED
	for <lists+linux-iio@lfdr.de>; Mon, 26 Dec 2022 05:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLZE1I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Dec 2022 23:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZE0z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2022 23:26:55 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26564EA1;
        Sun, 25 Dec 2022 20:26:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nox4/iVKy5AFKQjjnfRcKpjr7M4cVorWuaeKKtUWlSLItxJ56SaOOB3CDY8b5mVE7b9YmxANVnYiY8K3K2AmaJuT4pnWRfE5Kspcb9M01xY7v2RRh7xXu42ToUP/D64w7YqnIuql5Q8JDR0gIsR9kezq65NzaO6dPAb/nJ1QaO+DsmH5Qwge333rxZVi3Mwgvm1H+BTRxMbJqSjPl5ni9yyckVMAFFmwK56g9dy16RqU0riS7anAlKwSZuYQe4zPzV6sVx2lALQq+X4XisKy+HedqlGjwlsTQEA+ggX+tTaDJKFC9SSqITojkHGjBE0ykoBQ3I+htutP1sJBBJy8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dckup4bNqyej2ibkcfsxjXeol4324ikjI78C+Rf6Q4=;
 b=ZxxwtRv6fDIz1fd92Okc8RplW2UE8AngYYmNqogkX2YQji6ZIh/ot2kosOIbeEVruKK7W/pR02mhpkCyiYfVHafuCjpGVPi50SsqkbyxcwBvGaDAVmp7VJd4Oquoum34zSZnFwXhw2Y40blBpROLiwtDtKXVU0tEm/ymcHQABpQxY5OE6r6DHXZ7tA5JXWelb9Sb2Duap9goRI7m051NKfizwRSkb1OPV41BKrQ9qwIZm8yUTuHCgsy6hezSZGoK5ogTkzKKhi9igSN/vcdqBBvKVjUkYWACIjOVtrA7VWZqdKYwZSdDQyuRZHYxkUhCBfOcAdBmQHsUfytBuJD79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dckup4bNqyej2ibkcfsxjXeol4324ikjI78C+Rf6Q4=;
 b=KDfBGHeDfyBWkDFbDV+h4UTcdspLV8H7y5k4xBrxf3FaiXvdOHSTR0wBTNO0u5hZfA3LAUeEi+x5p1dYAAYKW2EoDrH5gHQMLPXQ5b12c6wRNAEqrMwCkXGsFTeVywAZh8fNcU7eziBDRGfiG4/gMTNw1RdNS1xee9lhnwY0faY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7792.eurprd04.prod.outlook.com (2603:10a6:102:c0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Mon, 26 Dec 2022 04:26:53 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 04:26:53 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: iio: adc: Add NXP IMX93 ADC
Date:   Mon, 26 Dec 2022 12:27:18 +0800
Message-Id: <20221226042719.694659-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221226042719.694659-1-haibo.chen@nxp.com>
References: <20221226042719.694659-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 80025b16-83bc-495a-4913-08dae6f96a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNjUpzJTLYyL++4phZo7QaWSOhWn24OngEj2pwP1jzayljejJyDez90ZT5WZTGci0rgxp1cuU35R/XmNRR5WzLRGESm5wDTtrun+W+w/4wwXu+EcZslCZsI5aPsCXhAVQItbKWE2lhTW2er7AxZaTYe/u0ZLzi+LFCwHmRI0xcqiUvjwCHbWkSON8h2ewAlsco7VJWEEgr8H4CYvwvjjUFxPCtdneJREREisoPd+7qxMH76csLJp2KTEPYKg/0nFdoDrIe622dO5kG10tkfeJNuMv74mnbxyXyR6PkxIxEpBqHkmWdv100VwG0CKrRgo5jUxKEqOuy0qB1VQiIxIsQqLPx/7MkqZbPs5ynJt/SyveA4Vuh4QXnOo3x4HXegqttovRmBHiEtp/pssYulLslutZ66ouPpf3jult8nlblJKuDCWquQbxqgDIqRraUlu3tw/4X9yUpAeeW03kWsvWnDV1H8+9v4fku5K3ACTHuoRB1C5IUI136KlZ24d6YXqlqAokhtyv1LSA36EFOYgcxDrumz1sFm8LhjM7Zqog5X2CUTBBPedUPI3HKTxI6jJi1wW84ad8G+0yqoFhhyEijJdyE8Qev39fkAjiGDh/IN6bS1k9ZKJdeO7snPVNa6/+wQwTDDCoub+tS6Xv5kYh18ZdSirAljId4TF1VeQrfnNyzkMi4WJFTVKDu/et2CzRG5LIsbUqVA93w+XldPCweqcyKAQaZKofNkKZAPqjik8j1BmjGPJP4mAwLb0kv/GGRNYJAkDFFHg35U4VdBniQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(478600001)(6486002)(6666004)(966005)(2906002)(316002)(52116002)(36756003)(38100700002)(83380400001)(38350700002)(1076003)(2616005)(26005)(9686003)(6506007)(186003)(6512007)(86362001)(5660300002)(7416002)(41300700001)(8676002)(4326008)(66476007)(66556008)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQ+TsRsgINT511nkCCmPQ5pW6tZc/bxax/VefgQxMBRmukoCUdoqkWz/nau2?=
 =?us-ascii?Q?yoTarCev+lJBm6CWMBe0g214/aNnG/yjG1HN+CwFBrJdfIUNm7d17DDh0Pf8?=
 =?us-ascii?Q?dBGlyscJ7fgQpDqeRTyGqssbkp09cI7PHKVg0OSsVysBkttyfrUB69VOPjGZ?=
 =?us-ascii?Q?o4rM2sOCN9M56KF1TmJeXni3EerkGglByKqU+ufnO9e1VwpBQ7Lw3aUY9mig?=
 =?us-ascii?Q?DbFlBrdqmKqvfX1l02/zgXKZSJeq+2sZ9T9w+85hrLdr9MLsms641MBkg+rM?=
 =?us-ascii?Q?0M9/qvu0bDkV6J1li0wEXCrId5gJ600VNv8sY7q6Niyw39X+ztPq/bu0lXx9?=
 =?us-ascii?Q?dfcwxQoaFe6iYC7tDtjX/xqBSWPTKUquB9wJxphFNQn4Eb3MhUGJxajdesXy?=
 =?us-ascii?Q?2qHqsZfSchCc+K0SCQuO1yyuuYCM1NxWSvEyL4LYYNnLVe11y2cmpznYJgmU?=
 =?us-ascii?Q?18XUHatKZIIObdsfHPZHq69saoo8sa6HEDf6vVhNtr5z/9erU/nTVzkuKQVn?=
 =?us-ascii?Q?Edzm8R74U9rLWSalVpeplKwTUcMsKU04t3qck21ZzJV8MgVoVQ0VM9y3qxSn?=
 =?us-ascii?Q?aCN3Yj419L7XOm6mLQC58YZ2KTMdaWPayEyWeCmiq5fm3h8Is/0BZlQRUING?=
 =?us-ascii?Q?dhvQk7xXGBG8PD4hzxRoNSmiovxJxZQ3AhHEbWr8Zycask2bkhC7bzC9ybo+?=
 =?us-ascii?Q?2DY0RKennVTBhHmM4edx3Sqr3iSHvqC/8h+V+TelVVnZaX6yyGmxA8wVEsLb?=
 =?us-ascii?Q?ZFrqivq+iDqyBxXX0v1fBxxGmFWrmVLhN7dLVg3jOxrNZS1T4fik1/2DQwyv?=
 =?us-ascii?Q?2+fe2nZbIQG/uR2qHQr3luSvUr3Aw7uqXKW/km2JIFQmqoX1iiVrxS37QgSZ?=
 =?us-ascii?Q?RZO2UG9skWq1rT8nfMapgbTZisw+T2dkJtDxDZ8BL6eLzaXnp7HfilBXmreL?=
 =?us-ascii?Q?4uOq7mr0wOUupQVouTmovXt3FuvcG1b3Oqer658kssl9MXSwZxh7ZwgCzwKU?=
 =?us-ascii?Q?sXWmqjwctC83zsZmCjMv1OjCg68WKTGhM83UFFcskyIvT9XDuSBkA2JSd736?=
 =?us-ascii?Q?ti+VNwBn11Bakymy9OLSVBQzuf6ifpDMkYuqNC+4Fici7C86nfXk/bv7cmoX?=
 =?us-ascii?Q?6/zOF8VJOdH2SmUp/BL83eh3R+uzwRES9HZ3ofPL+ZhQU7JDH9Ibh852ZjML?=
 =?us-ascii?Q?THgMpXGUnQHl6uAYw06leA2I4FEOEGX6qmQvLtr806W/8o3H9HNMSOe6bPuM?=
 =?us-ascii?Q?fFebaUj7eiAEL/INdUHKWXTI+f7G+Yo007WzX+OfsBPLN7VPp40GL8K19XR+?=
 =?us-ascii?Q?a9ErQEMsaRdr0vtR64hohhdFXDejo/mFaDFzPSF+s5yhP5aHp0Sody6n5dww?=
 =?us-ascii?Q?PtUs6f94UEM2VMRIV+/naeQuZN4mMDubOSeQn/MHhnn7ujQfkj5wWdovo1NG?=
 =?us-ascii?Q?q92seyosOzcYLeOn3nJhpHPcOEFHkBNGvS4r+mKvZiwBJI0nR27eBBJAUX+k?=
 =?us-ascii?Q?d7ns1Pv6ZstjO5KQV57x/0czq/maznFIk04d40Lgheqj7DxqudlLsudFXLFQ?=
 =?us-ascii?Q?KDxMwKjmcOWmPEBuRM6FA+bl8Fu9ijs4/ekmBknW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80025b16-83bc-495a-4913-08dae6f96a32
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 04:26:53.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPkS6+y7a/YgkTRAn8W37vwFOHoZ6rpeaJpy6wmP0UxVVOe8U7A2uHO3ZYA4RAAtqXmovSRVhi33f645ET2mbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7792
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

