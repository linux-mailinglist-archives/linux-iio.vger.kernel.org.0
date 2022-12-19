Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB66509DC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Dec 2022 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLSKNy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Dec 2022 05:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiLSKNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2022 05:13:49 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A08D65FE;
        Mon, 19 Dec 2022 02:13:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DexNeplrBRv8E2I23unhlqqpwdGtE+D5p898fIbUfeFJOcbGAUuFEtvtmiboe4/DPlxuRPk/hLhC8BmRZ8rk1WWRw0IaQonjsZpO/Rxd9yQIIBfxgr7ToXEGXrOqOAKI80y7zj78kXQVsPLDwnSW4FxiG6MOmdjjSSLLk7CQLgMyDYwrWhi4+hZRX46yXIM984xnf6UnK8C2znpDNJWkVToKrd8eTAvQSevA8A7DaANU3+0sqyX/Nl6V3fDqNVTV9qykEyLbB0rTdsQTeaCBS565abIz7+mBawKTjdFAjaCmxPbywW8wTZvQ5NyIRR/Ymz6UZHEmiwQIgMAXJTSb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYurfjzNhiWkHbQ+7z+h/M2VnO0svQn1uAjsmbnOFB4=;
 b=JaU/bNkePlA1NzCRB9q4X/zjx19ZwiYHAs7cjr2D+H8YY3GwZG8gyHjqyR/D0X3rqu9BWJSCw813WVkbXteZLHu8yFrcq01Z9y9IAZgwYO8Rj5xqhRgDlA7ZGgQLRKS8JSqh/x0AnBCkt9HvhiCynRO8z9x5W+lZSyhStfJrtZtQzBtM3laQkSSe1VzfGs8KgS4Ocb/7WOHdvsWTULdrtKOnMz03puLW4rLMWSCmnP3grDgxIP0hbcfmehS/Wb4veGqmZv9Z7Ow1jCDj0B8xiqHJBekwOAjUJHcbzsD4eCCsS3gSw9BKp+cCysDcphbO0mJ2sOxkD4fGEr2sUtgF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYurfjzNhiWkHbQ+7z+h/M2VnO0svQn1uAjsmbnOFB4=;
 b=XkhGwLRXwBEzP8tRUyLpLy7WtnFBYjeYn8ayowXogweAbAVXPg7nhFQkNGY4O/MCRVdYo+yov4Vqtkml7Iwg49sorrkhX1CsgLA+FpnSYMGz1j9WMhDap1JfTxajRIdTT2IvyNdjJmdDatDHnI3UThs5ygXsY12Y0LDJ9XLJQfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.10; Mon, 19 Dec 2022 10:13:43 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:13:43 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, haibo.chen@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: iio: adc: Add binding documentation for NXP IMX93 ADC
Date:   Mon, 19 Dec 2022 18:13:35 +0800
Message-Id: <20221219101336.3929570-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219101336.3929570-1-haibo.chen@nxp.com>
References: <20221219101336.3929570-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc8aeec-a0d6-4c0a-2ba9-08dae1a9b4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nCOLMz3t+geX9prXaZ6VDGU6DrQ8mcmRJZhTy1DtNZJw5xFwJi8iRdFf8KkieQIRj28zRO8NGyORvXWgIiv7mR2ggYxN3SsNz+lRK2+OY5/RvsMX8+4vu/j15+iJ2jcfGIPHUxkeSITI180Pcc6Gnpt021Q7q8vXnts/Csn+9lyaoRRIep+ivctEzVFW19D9NTvJR+jccf3OFcxXGPQyFsaI5HT4BciHQV0x4sVbKFXVR4sPjoVHAf4CTY06WncnPxv/r+2POz4vKAYng8P/W25Jvnw3P3Y9ZlUkF8hOFly2NBckKUPs0h6ESgZF1Z825QzpKeB2j9sj++rrbUAW7l3O55oWjwJhCbDRRC3gjNN8+SygxCBzHPb7ty+Ak/0lZ2tjwLSvlQVbcFhAh8pgpQOLAuqmW3jhkJZyeGB6BTSths+uBGkGDzvKNVAuWzw5JFBY7y5H6hIF/730eOLJDL2aME1khYdKMqSrPlxXEKZHVl4AnIJqtuzJ6659LZ4WKg1wpfigyosGqBhcK1pB9+hjt3dWMgYKCkf36+6X4bLfAYCkkmVKduJqVGwji/X7+13Owj4bHJVEzb5zErjkNAawAEfr5UQfQA05w97xmi3LiDxExHVtk0K5IaGVvZ3//9R0aUx6WjdBdaSjzCSfDLd8Tf/OXQvXEB0NnI1SG2Z837joCJXpnrWHK9XRp8d2USk/jrOXwQn3eGTiUb/FJIYcK+hyzDyh4skgJTNxMyMtRMDqc2ZbOIQ5IiBYrL2y3HrMbPVhAR60Ko++pWLbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(66556008)(38350700002)(41300700001)(7416002)(66476007)(66946007)(8676002)(86362001)(8936002)(6512007)(36756003)(52116002)(26005)(2906002)(478600001)(6666004)(4326008)(186003)(2616005)(83380400001)(1076003)(6506007)(316002)(966005)(38100700002)(5660300002)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TbN8lwDzHsn7vlow75264+z0q1hrWVmjDskigJnBdRc5eDZYbovqJgTW9PXz?=
 =?us-ascii?Q?xqkKzKiD60haJg8z63r6v5x5WGht6urJNU8Qgx+kF08PVgTlpE8nfvcoFSpe?=
 =?us-ascii?Q?zSIPL/gChW4B/H6t4Bkhd6adZAddUgSP6ly9L9eRlCvk96qZ5BEvIiFbUQ6N?=
 =?us-ascii?Q?EF2VHEqE/5Oqw3AvNaGnM9BPZWUKPf4HSaZc0l9dp8i/QAWI3SSN1EbEM4tW?=
 =?us-ascii?Q?wJmvToi65ru920NNOg10uLfO1H+YqejFedyU765teF4t2CB/pDdvf4QT1WJO?=
 =?us-ascii?Q?C9BDt9/nUmiJEZ6QwSGWz0EyJkxzTpNutR4dPVdZho0X9gDlOrmcat9Zt766?=
 =?us-ascii?Q?veld5MnmMQNBS6mr+ZD7jvxaucccbrFXM1Ol6vcr4nPgBrjX+Oy/iFczgNsg?=
 =?us-ascii?Q?2Gz8/tJu+qGgkOKuOtdHxLZycCs3ttgrHaojE5Bm5HyU3cmnQJqeCFgN1N1U?=
 =?us-ascii?Q?t7Fgy1r3R4YspzrQDLkgXZOsoGOK7fpzOQ0EW/Jkytb8qEEiw/qomnvDt97j?=
 =?us-ascii?Q?1QS007+MzNI0UGIL4buzIzB7cPm/Nrk56EQON7XhKVCQTzr4hf2xMTVP6EaX?=
 =?us-ascii?Q?Yhr/ck/sVlSD9uqOneD/mOCwJe2RLV+/iDPWPml+ladziQ/tET6SAQoZv8wQ?=
 =?us-ascii?Q?TZStBVM3XhOO6vEQFTCBgqqtS4+ndIZROFiahAhLOBbWnBfOOFZyBF810MFR?=
 =?us-ascii?Q?NabWR/9Wuo4ivS5hOwDEqq6nCv4WumWF4jiKdTUamVvY4zzjsaRs4LdUa4ue?=
 =?us-ascii?Q?2gk9keYi7Nhea2PuLE+ZSbhxhzMtKL8fKCn0Mkz+FltL0O1KofIteqRwmL0y?=
 =?us-ascii?Q?aascz5MxYfNIAfFjz5uW5BUXSSJx8Fxcnkey5dKsna4I2+XJHY15bp+/oond?=
 =?us-ascii?Q?iHqRXPOavdPsVJnOmTI1IEM8unPnlWNYaaoEZGBQzeMj9Pd1Q9ZWjR4Mcl1M?=
 =?us-ascii?Q?wVB2Q5MIrJL31H+ONAcs4o59yqs/Bh0z9uX6AWPa1U8isYAOwDaaEXDBk7vi?=
 =?us-ascii?Q?zrs+QvMUmlj+Y6UujqAyIT5/emveRp9BUi/oCpbqARhUzglodrtNRxDGX546?=
 =?us-ascii?Q?3R7YHr44FN1BSLOFspPW8zS3dBOzXh7tamR//C5eemnS2rKLyA9KTlOYQHEf?=
 =?us-ascii?Q?67OqmXfojGL+Y81vgeBFbtISghz8xcP6BL4l7Xj6x6FXSh+VlfYCdmkeBhr8?=
 =?us-ascii?Q?ni/sE4/ydPHXWvqFvNGH0SgOc7J95tYrqdD1gwsg7c/obPSe/DeZXAa2esZH?=
 =?us-ascii?Q?xA7HRgicbD0hP6l/ELHY2G4lhJG7kdpy7Q3ubZNAh0sWS46A9X6nvsrA7gBo?=
 =?us-ascii?Q?xVaqMHAlZOaAYY7B2pVIuJC7jfPUH7mrLCaKRcv7r0kUFGsGLSk53k54JCwN?=
 =?us-ascii?Q?jDi2QGKilCB9GlXaGAUxzN27Ylv+8dBfbGFr6mCtl0UHwpDXstnU/gGBsZG6?=
 =?us-ascii?Q?BvHL3ls2/KIxudeih74QLNi4YYGyWCCHbmEDcE/lFFMpxtUHdYeLBIOQ6uwt?=
 =?us-ascii?Q?2RTibu0V3pUduN7x0bwVSbc3pNq8+KZ/Katlvjl0Aw0Iik/VuR9h5+wUDYRP?=
 =?us-ascii?Q?AWKsZxzzSIucziEoYlYW37M7Fxzue2uI2RCF+pya?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc8aeec-a0d6-4c0a-2ba9-08dae1a9b4eb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 10:13:42.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMxbAPiJ9IU+rrBnTtfnsTYygQ4TksaXvofdy/XvV1AOOlgHx9GTw9hP77urDzoH1Jx2Q6jfqBcUMd/OOzylhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178
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

