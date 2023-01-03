Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C3365BF3B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jan 2023 12:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbjACLoL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Jan 2023 06:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbjACLna (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2023 06:43:30 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4215AE6F;
        Tue,  3 Jan 2023 03:43:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiKVKm24eoGIah/bkC5hmbScB6VY4RS6YjLIPeXSyr4G2IaHkxyrkSUHCGeA0eoFnxAZFm1uuxvebAGuqDERUQ6/Jm4lCqUqXeNXKFMO+tSbppqEwulHPhhB71aGCKLuwolMkG3uG+mdffIjkCzvybXRiZ1cnAWYYezYZaG7op0079WPuQLZ+JC2JhXGuMQddGCOnOk8OqYA1ptY4gbmHzTlOUY9L93PYm0JuvcVCn8l9cdku2rh0zuWsd8PpHSKSUPqxIrtiGEM1mmWM6NcQyKs+MunbIcZR5YV+LcLM5oEMZLNfBnoMmxNDK0TrE/0KG8ZHaprQ6c9LfXFvCtz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dckup4bNqyej2ibkcfsxjXeol4324ikjI78C+Rf6Q4=;
 b=gaZFNFMf8nz1Iyr7I4KWph70WUlqFkrhEjnn2dlLNw28rm/CA0umVopQ6ENgOzU4BxmEtVI9ueE2LIK8rb96OK22EhzkRrB/2FlMg3mNBZjnNAk451WhGrCtEMnet1D6h/tdkcOMuAp1eHUS2c3J+4QuxlDBTMLKy9lKZyuaN562aNoN7z8ZlHycQIQAtTXjKKpsxrtr6snBupycjTbPiRizPWFUOeNLXgshCA5TpiKLiBdJ8eQJX/kZnikU8z89HbwffyItw0ackxcycEk44/mWglEiSWQTENHzJviuWqoba8leV+GtnDkJsw93IOctkiKrzfzfMQnJa07vmJAPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dckup4bNqyej2ibkcfsxjXeol4324ikjI78C+Rf6Q4=;
 b=WSrl3PEG8Qkyqd22YJ1UqJl4ZJcVLPzXGgVqJBKw86WHWjQb7LYI2vuWXibANVWfW3AsS7tSCd1l7zlsky8IRQgu3qKbnBasV9uNjhMZEt1lSrl4ZxeenL2r1CEi4o+hnSf1t58GPYGpvL0ZxygFPj9s+LDkLogVeqizWfyvsVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 11:43:23 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 11:43:23 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: iio: adc: Add NXP IMX93 ADC
Date:   Tue,  3 Jan 2023 19:43:57 +0800
Message-Id: <20230103114359.2663262-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103114359.2663262-1-haibo.chen@nxp.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: c56c9113-62a2-4da7-9342-08daed7fb85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDs1BwCK8XyUhN2vxk4GbUPo3IlsOlhvbI9E9X/eChSRLgVS4EEqL46Vi1fPa7NGXFhddy5EfdeqaXsNdiV9oG/Mgmte1DEU1ndwkmbGNEdXz0FYkU7q/4hZBm5Z/50jwiXA9bUcYcE0AvGT8WRau38UWv1ffOauPocQz+voLOUP9/sQKPDooJFXjU2cqgU0sNZFr+yl4yj0KPGih3XG11etbIhtw2ZJ/o8UzgYXje7aeq5eY3qpfL2VmyP4M7raLpK4vywLPxx4Hlv+kS7gjFzHNihci/CfErkT5WrKqd6hljxbLOyl5VekCmjTOs0tM/ZbdUWyHmX6NmWGF1o0oMo2LUI7whOBqTY/+m0gDYQqJKllQMlKlsm9SuJiOogeinPnbglSVyQ1FNow4+qD9t3yzcVGYU5ob8pBw0NEWTkp5bbLpANrKR16VcHy1+PNbU6006oskOOvAub/kDd6ViE5Ohko+Ugy9L+svfW8NyzdzZ5Kpq6YEccEXMPLwNtY4dOujZYn9AjBvFP7W/jK6JIQOdbGlosgsZ6uncBe2nsDB71ihxnvijdaICClhnQoW8ntpzVM/nElRmNl4irhq4ctGk3lfD6kotW9oWAKo2EWFV6t31XH5mMvH/Cd8Z5cEMFvtjTx0rK/iT6+DCIts5N/gRjlZYxUNxr5yPlwIPMeAGOc1cDcyZ1rjMVmkroPvOELvTcchPmtZQiNq15sSluCMDWZUAjOOOKLfz4/GRFOyVQQdjTrStNsC2EgtNblSX3/MTFS91nBGAyvW/aekOWKztyviXaNLMUrFPNR4Jo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6512007)(9686003)(26005)(52116002)(6666004)(186003)(2906002)(6506007)(478600001)(6486002)(966005)(66556008)(66946007)(1076003)(66476007)(2616005)(4326008)(8676002)(41300700001)(316002)(83380400001)(5660300002)(7416002)(36756003)(38350700002)(38100700002)(8936002)(86362001)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EunOb6UxkoBe4qWFbz1xinoGe4ViKnqzDVvz+Fdz4uN8YR7EuNT0jO3TJp1c?=
 =?us-ascii?Q?UVOxtguMSl4PsxQIbEgUrXT9XPqHbJ1XhoQyBiEe5Q0P2trhAsdIcVmCTTn+?=
 =?us-ascii?Q?I9ziTOozLtGoRUM73XqRu43/c7h+hDMb3vgyI8WXwcbAWYTBQg/LrYfuQKZv?=
 =?us-ascii?Q?uf7jUs2FblRad0L+B8P470rFkqvakL3u+wH5ocoJb2oFbP9G+2d60XszRPB8?=
 =?us-ascii?Q?y6x0dmALjV4+UXogm/sDkhz51ZNcsarTKs+23u9UiSt3zs5DHgISZLByZPh4?=
 =?us-ascii?Q?g9C93fjlox9iNfYCWJr+juF0o+60HET/5+4Ek1oduPRBNkMUprLmqGvEvMyj?=
 =?us-ascii?Q?1QiIsDfBiramWERFGgd3kO52xhfyw/qK/NAtZSTFQKexJvs8mr4OxjmQVXwV?=
 =?us-ascii?Q?Deyq9iNwE/EMfy8kE9oOW8tilqHoCDOoHePgxNSOpgvfsscmo/TimWrOmM9O?=
 =?us-ascii?Q?OOk9SHd306t7RC/V6WEDSxcpvBBHdyvyrtxau7kzZnNNYqMJsu6U01sb/EWN?=
 =?us-ascii?Q?Zbl2q/sm0+tQHDirLqqNh5tOpHaa/j1bSsCnekIrQpSZpDmeIsCbNI7Yn+ao?=
 =?us-ascii?Q?Rj1kXHZtApROtJj/s+8rRxLUryDVjYEVuNkaCj+qfhdaJPPfkCV/MyLxAY+S?=
 =?us-ascii?Q?+2ia3MzCMTS35RSW+FSGevwRfSnjoSCTHiolChbzqNH2lWG6tHr9NkVA1hWH?=
 =?us-ascii?Q?XAKj+YLSr410KOhygXHWMwrG4oTgzfIjaJ22EZHTmQbiJcxkCqTr8YZBO5v5?=
 =?us-ascii?Q?YTAVjJrB/MOyL1YTUlkiA7eWRbDX6hodyJ4kqEc6QM13LkfgQ+DshzZi+LEo?=
 =?us-ascii?Q?L41vrHPJXSwTXQDGMwNO1hywgtWGjekhdz2I5Lzais6cWGPxDVx0GRjjm8Xo?=
 =?us-ascii?Q?lChXM+2DODiQMw4deonqLYj7X03xAaqGNTk72odtnWKlUIGrUxpODD6r8UA8?=
 =?us-ascii?Q?q049faOBEvF63P1ia55L8WPxEzBVRtojtHzGhdKN2Nv1WOXvA+PbPSL1OKHp?=
 =?us-ascii?Q?ITfMhQYlUJyZ5nrZzuadwfxQKiJ1ZSemfMqOvgpPQk8UEmtriaxrOnVNdIiW?=
 =?us-ascii?Q?diQExkrXOBYiExl/iZVlSEEjcz46sdlZKWUWlnFBRqyIiKjoYtXrEjxR2itV?=
 =?us-ascii?Q?e3r8aafpHj99kz9SNGWISl3V9vkKwKt3F2clc+vzB/O/fDlNyEfDBNuK1JF+?=
 =?us-ascii?Q?f8LtXhT043B/VhQZsd0vt+x5cq5oBgRenzjapqsJLQPJ/Y4FUCRywqUDjaVe?=
 =?us-ascii?Q?LfPPgBGJlmVgsHXZUo+e0Nvmn9OzI5rRvn/ZZ29412r8dZLJO1p5xqLBqMZo?=
 =?us-ascii?Q?uRVzdG1AthUjau9hKnVXtxLd+UXzWgos6rfSgbm8oyz+dfWXRuCPWypInzIf?=
 =?us-ascii?Q?9L9YlgRwePx5HR8rNm6YXnf5Br6WEUqkEpz93yzcSwYflaFNIpcu8b00KMUC?=
 =?us-ascii?Q?/ymFAhZ6+TmwCKZPH9T1Cf6nA6VOEg49JV6cOJG4eJKq5zdPDMGNemYrtCdL?=
 =?us-ascii?Q?FWiZQ5M4OCzmSJxqq7ZjTu7R7pSf7Qx3wUTvSY6gByGfJroVydzLKs1SoDCv?=
 =?us-ascii?Q?OLBrHSxqTC0AZNmPecZvhQi9dsdxq2GujDF5WmNY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56c9113-62a2-4da7-9342-08daed7fb85f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 11:43:23.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKzGOpZJ2nQTIrok9rhLU3pGPZS3iNDIWeS97j1ThR4vLVJ648QnSNJ/B6V0iWBnGol8CntX0O4TdQpe9UO4Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013
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

