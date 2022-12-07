Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF97645E9A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 17:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLGQVf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 11:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLGQVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 11:21:34 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E61A63B94;
        Wed,  7 Dec 2022 08:21:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXFUKRqqyv2u1keMizWMYVRz3VN+XBzHzigMAJjfVyY2+dpVtAeNAM1vkMWoEM7V/KT8S8s9spdsSugD3KbKRTVJrg07o3o6NFYVD6MP9TrHnt2LD4S1IRGAHfOf8IDe3zvLhJ7gZ+BvF1Z2Pfg/tRDnoVNv1Xn7YtosjQ+Z2BgDB6LsBJcpJB7yf5UT0QeTpMD/VPZHqoLv1zcLxQzipc3sdpC4XgStW5l6bT5bKstvhi+E3cTcEUudk4dXL2rmHbi/YecHtFxIo+dXqTWPl5LbwT6vctrTE9Qfa76NWS9zpaUXXGb1lqZ6D/dCbJxRyqXS2KTVr3ODjyuxvsf9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2E9GjTeazPcN9slw205Cq68QU5MJGAoDa7osAZANVU=;
 b=axUibnmBr9fnKPgLOqg8J41c9swY8IurucP5X0JiLlM8B2WAZ23mHewgyyFoG/s2KdvCJ5yF6nBgjCHgTYUYyFBW/0pBHSmklrpa2OiDH/6pgjYTechBfC9JP8W+OSqyT8k6RFUrXTyyxlELYnDhYOoxj08NRIlk4x+mYy4NsVt3Hsti9DKbaJh+8Xs8NC13PSLOmlvcFNqqAgsLldq6l6wIO7av34asfbRM5Cp2VF/53ET1wb64WsgIdr84HjTeyN9oK/TyW1ruKQM1YXaJbpOq8cJ/4HH7FPmP6kRlsHKyUkseYhNx7xYawH+LzMNNOPMCO5LyKNflTM5/lAyMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2E9GjTeazPcN9slw205Cq68QU5MJGAoDa7osAZANVU=;
 b=MejSAhl/+EuOT5oXZYzmIB92vEldzuiJhGzr0RqNMn21a2SdX76I20lHjPsT8oPezsRaTlGVf2NJBOhAlCXEygG0RunBtZisAEf1njnuggWkRI16gySVT4LZZWcnKhBLonfgK998lMs9ZgmXn7QtxRoLlKI3G8Vadstfa9jtKIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 16:21:30 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:21:30 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 1/2] iio: accel: add the new entry in driver for FXLS8967AF
Date:   Wed,  7 Dec 2022 10:20:44 -0600
Message-Id: <20221207162045.669958-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c7e03c-9d20-4f7e-2a77-08dad86f17e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mstvEK18290SoeiCB+26QLRHNBJYI414Kv8bA+JPkPLaKY2ic54Dn27cdcp2rGwRI6BFRWi2fzBzL9an6aVU7vl9J52yz8d6IF6FYcumo47iw8kUuHFiNLGlPRC94vzrBVhty4azY6d3TnOVAiNu7A5ljQWLi8bnVY8DpAb3bHZ2i1t7G/1RQy0liRJ81VlCuiLRclTRaHNTmupBZLNhxk8ytopZHAeawDxOtlvb+5mYopEYstTNdywMskvxpXa6Gy5m7AnW3h6TFhMaa3e1XNb/fnoD9xs0IDDGGKXgX/Nm2d96zggLnjT64yVHyaA9TgOjQ5jTJl5Ahn0u/LZR3hptHdAeO1ssdWmP7GYE9zcA7//D6+WDPSpOU8dtbftEltQI+1nvzOl6p32y82j9BRiQMBeNjFX/D/zmvK1BhJ5YdwoJFvHt+UVOcXGbe4zIn71DLMpTCi28Yrx30kS8YyZUFWh4gS1sr70ZpULS4tPPMMyDysyPgz00HBKUsVuR1/RjjTEiQoJa8PcaICaufVHKUnJ1wvYTnFCG6Zf8c7XmF8jpSDOk0SkxUOouL/dK+sqOw3xmYqEFdAumZnq/8aCQgcdsuiPORM7tLCfDpIuQm2mzyKbmuXkLsPDi8vS1h4qmY0Jra3q1q3Bd++mOrhOGhmxFHz0VHtS25F0zsnMMr2JHQI80QQSw3+Scqizz3mDzatS73pGlOyEzDljlJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(1076003)(2616005)(186003)(86362001)(38350700002)(38100700002)(2906002)(8936002)(5660300002)(44832011)(6666004)(6486002)(26005)(6506007)(41300700001)(66476007)(66946007)(66556008)(6512007)(4326008)(478600001)(52116002)(8676002)(110136005)(316002)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gatcXTbfyB6qmWiS5Az3OO9MqIIFGQyTGDyxSpjrelBzRj+AAL2a11GJvNGJ?=
 =?us-ascii?Q?sPxRjOjTK9gOct4hFK562xdPlScgjV14g4OZqDE5SPRDT49e8cjFFCkEcON1?=
 =?us-ascii?Q?Ab5BjPkNBl7Vja852G3AzGVnThs4ZI5BcF1fIMYG6cJk8BQrimwXEwOEVLye?=
 =?us-ascii?Q?QuCMTpnVRTU2rJ5g55Xb+DtLCetmqX1nf2dz4FqcGJM6MUSkdQeCS8P8Ga11?=
 =?us-ascii?Q?RHwkR+2jOJf03RqKveRoWS4D3Bp/IEBVyPcqEACblpztI7bADoSDmRXjSo9H?=
 =?us-ascii?Q?ExH4sSWr1mtN60DInHVPDEmEzYUY50OzE6YrWJgTQicF5f/JiUPsDSh2K5K4?=
 =?us-ascii?Q?tXO8PKE410cgSQrBJP/Z9iBIfVrjlHaT6kYrXMBVW5k+hN/cl8HkCL1iy3Xj?=
 =?us-ascii?Q?WihOTM28APyz35CZcKiJDFUwAnY6wxSAbeq4c7Z6N9bK5qxlcL3q0YhhoZIZ?=
 =?us-ascii?Q?M5QePct4GDjSMdAxmgRW1KZJ2DhSZhfIKKnKerjANLFMk71ENtsnFSNnCRKJ?=
 =?us-ascii?Q?m8Bkj8IVA7zhZxn+oBFeA1DMJcM3dDVBMDtaEvULFQlDLyvh0kwWMQz4b0So?=
 =?us-ascii?Q?/C3/V2+iUXdjeC6xyqdKsek8pGhRU/yTEwrKLFQC6JwBl2oTJAWwVzXLaVOx?=
 =?us-ascii?Q?A+uaMXfwULUOr5JoznEtiqHvq2IjZlvutuTps2VNUBo4t2K9nFThHZEPjaEH?=
 =?us-ascii?Q?6J4JmR0uGC2/l4BB5Pvzac2AZtGf9gRoQryrx9CU8mxU8cN2uRC/jUNCe1+z?=
 =?us-ascii?Q?UohooA84tkZ1yidd/qlVHMqC/KMbzG1XEzPZpa0cnvDhL+DvH/4QW80a389y?=
 =?us-ascii?Q?cb/zmUpVDQ+wxMuE7tOYnvAvUvldotpOihUQOA1CCcygNjtwVtRJdDh9oP0Z?=
 =?us-ascii?Q?r+VVCfz+yR8IFsKGwpmOdhi1TXqOXqkwOF5gSKxlopzUFLOJV1ue6bG0Cvib?=
 =?us-ascii?Q?lR7A90FtlrftMwsoRiLca8vOgd8JfQNYjrSksUDXxCPoMLzozFv7oMHOIlLi?=
 =?us-ascii?Q?YfeMl7h7e0Dcc2Im9cWdcmBDcmQOw/a/Kx+g3FOJr0cQRW0XELyUFlDRgETu?=
 =?us-ascii?Q?j75bEcv+XKrjSb1gDUZlIF5fgn/1u/fB4gxaIj9b/JPYCB9+nIc5ofrzRHW7?=
 =?us-ascii?Q?fAf0aO6pSWwr935u31EIHHBCTmcaNQQ2IePofI3yN4RaoYnom+FvvqVgzO33?=
 =?us-ascii?Q?fJfeuqCUT63ZzrOZNFQeuZ3BRwwMKxyPeNfaP09UlUPOc9pdRD0vpLfuZNLO?=
 =?us-ascii?Q?rp3RL0Shag4nPzbr5Wj2jdQX6hUTzKk0A823745fMD6+w3n9wfo0yYOn5caX?=
 =?us-ascii?Q?LkEzZgHYcqvqX6pEW+YnIEKMHPpxmHWEzXGUTbLru4leJe27R19GDbQiIrH8?=
 =?us-ascii?Q?niu1rL7LNj/hbOKalx7H+A9qi+KvRoApI72yWHrWuIH/1BNENb0XGVeWCKhG?=
 =?us-ascii?Q?C2cmb8ss82uhEiWoPGZC5kn9g29qyqJWUSMALNW6n8IEu9IK5dW4p2MMJ8Fc?=
 =?us-ascii?Q?nJ4Io7myNmfZ63kXxMZUVYtV4FaIB7zZA19TJvWCIbj3OpH0V2kmcGZbs7v7?=
 =?us-ascii?Q?NRIadGOia+c9i5g8tz0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c7e03c-9d20-4f7e-2a77-08dad86f17e1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:21:30.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNYrpC4LhM20LhauvQis+LvplpjHYPfW4FTIcloqvkBCzhPnoaMuBzKYH7HOPEOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add this new device entry in the driver id table.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 17a6f4f4e06c..ddeb1b153499 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -127,6 +127,7 @@
 #define FXLS8962AF_DEVICE_ID			0x62
 #define FXLS8964AF_DEVICE_ID			0x84
 #define FXLS8974CF_DEVICE_ID			0x86
+#define FXLS8967AF_DEVICE_ID			0x87
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
@@ -772,6 +773,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
 		.channels = fxls8962af_channels,
 		.num_channels = ARRAY_SIZE(fxls8962af_channels),
 	},
+	[fxls8967af] = {
+		.chip_id = FXLS8967AF_DEVICE_ID,
+		.name = "fxls8967af",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
 };
 
 static const struct iio_info fxls8962af_info = {
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 4a755a39d702..fd21f524e04f 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -31,6 +31,7 @@ static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
 	{ "fxls8974cf", fxls8974cf },
+	{ "fxls8967af", fxls8967af },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
@@ -39,6 +40,7 @@ static const struct of_device_id fxls8962af_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
 	{ .compatible = "nxp,fxls8974cf" },
+	{ .compatible = "nxp,fxls8967af" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 45c7e57412e0..7de924d15694 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -12,6 +12,7 @@ enum {
 	fxls8962af,
 	fxls8964af,
 	fxls8974cf,
+	fxls8967af,
 };
 
 int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
-- 
2.25.1

