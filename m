Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4243E64BAC7
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 18:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiLMRQ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 12:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiLMRQ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 12:16:27 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567938A3;
        Tue, 13 Dec 2022 09:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQdiIrGfOeUvagvdJYua2qj05FMl/BCIWfqqxGPYUo6KLFV45MCN2D6G2CmNSU46hLecVE4LAXLIXU91vBe6mkpf+bQMWxq4z+UKC6P2Vqiugmxz4PTkEc1ROhlBw1KTMQx8bznIXgrsQ0/b0/eGaIyENRVPKtPZ9ZPGhhFlufcAtV1/6UnRaEB9a3JCquLfZRWphozPtLW6vZ9M5ELGON5DLoVDwNS9FPM2y1h3LgpZubbwnARJ/LXzvbl4NG7yzMq12GiZv2PkfAqP/tJsQV6Xqx4m8+KGQlroVjCbvUrSkSgyH5oPJS6AzQ64rEtt3TvG5gusflfxeAFzlZe9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6KTtRcCRdE5bsP/cABzUgdgIlAMMva1pxs8OqNTFWE=;
 b=AbWmyr0yg7eGYomFhrzchKli2H+o408dyFqCHszbBrp//IKmouzy3MLY8B0rZZR1SZ++kJmv4aSZO/MWqYX1Mjwva0nfL/pLQ8W2HCXAyKYmDeN5fXPI+/czYxB24gvU2Mp8kgeNj/wxtNZAWb43/zTf2W7/cTf0GXfQZgEfXjkHnkZEcUnWnZcFxmL418qjQyGQyKCrxCFW8L0uMonGADIiiCWcj4eR8L9H9AU9TcB6+Qxp3OTXgKcNooxFyCuds+x3P6lMugxutmzlbwdJiYLw25KSchFAZkK6Rx4TyhhstHGmsOHmvcmTb+MlRDELXK6VgQeemzdO6MmwoccqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6KTtRcCRdE5bsP/cABzUgdgIlAMMva1pxs8OqNTFWE=;
 b=aEFVgsxq4BqKjWv/doqoUKmlJK4xmUacAp3nooyRyyBw2X7DNqEFwqJ7jVZFg6/vinA0209F1aGFcxbvfLOOZ3TA0gEUjvK+lUrEWs+oXLU9iHNPQoRmFI57DZzFOd9CyFU7VG04fL49Dm5MXke6SlqZw191S3SuDFMf2pwCfFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:16:16 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:16:16 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Han Xu <han.xu@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH 2/4] iio: accel: add the new entry in driver for FXLS8967AF
Date:   Tue, 13 Dec 2022 11:15:34 -0600
Message-Id: <20221213171536.1880089-4-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213171536.1880089-1-han.xu@nxp.com>
References: <20221213171536.1880089-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3bdac5-ecfa-4a08-447a-08dadd2dbdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX79g5NY9Y7BcmJ7GYBWRhFfTdvkeghbkxyaDK3yAE1JH0xZrHsQmvxW8UcZfUg7MG68QW6fBMajA9hmWzv+hwswzsDHx01HF9yJ9WUN/8zqADTMb/OYxJc86qOLx9KYWw+wIsWi+/BskQUjRm6+exkZ3e0xkfaSqMiyaj0P9Pw1yref1Luon6Zs6Ccw3Lvn2mqGnPZpkXFH1jHLy7/rZxt2a44SuCykgvU32XZF4oAY/FNIaKNPzA0vzLFrLBBZto40QAqS3d737EVf+gbQC2se2g57uEAY0quB+2+yHAfjAlq9xYHqq4oYgHqclv30TnW7fq1gm7oMfCgIR7juJR5CzlwpVzn7ZHQ8PRcBmz3T35T4V98ZeBs6PYQmcC+TY2lCOqrn6eagOABIdok4cS0S6T+JuOQ++ZIFaa6g6vv/iBtMMewXy0rtbRS/iwhwNgPGRhThSmb4ieUcqvePOn9iLkx+S1MckPFP2J/NEjWJsXpWNHiG12KN2vXhbUBppo8ilIGsC6Iiw6HdLLxbmZoGDgRjyH2WQYXaWNFHicEdGcBIf+sx105vCPNRGd91SHIeHD0qlth8iRoTZ+70ZJZEkedZ9WFb+cIMEUAPEztrbqzA37X8HmQplDbkJWjWw0PWt/33b/+tMvK1EwyZ9hXCdiG/yaAQR6Y+GnytWjaNl1SIQr4LIhGG4hnH4KAZ7GiHKPE3vMghFOihyJphqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36756003)(6486002)(110136005)(316002)(478600001)(86362001)(38350700002)(38100700002)(54906003)(6512007)(1076003)(52116002)(186003)(6506007)(6666004)(2616005)(26005)(66556008)(44832011)(41300700001)(66476007)(5660300002)(66946007)(8936002)(7416002)(2906002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hk9JRfwtEdCs9CtH0OC1hfAFSxCvzeaTL0MndRVnd2lwfHLX9fL+h+gAuZYr?=
 =?us-ascii?Q?SXKaPzHfPy9WddUpotPk7v+b/bYba7AE1IHJz0hEbjaPBQ+T4fiy+0W2Q4KE?=
 =?us-ascii?Q?OcvwUd84yESX66lMKFj5l/J8IDMfZlMO9K2qYOvqqVhCugtmAU77L9g1gBM9?=
 =?us-ascii?Q?8VkPxGLOUW+rx62XQYmYMoKhvl0YTIl4E74CExpH+VJwIw/xXZ4Lr96Xs8i9?=
 =?us-ascii?Q?4uJV1HiNPLTKqUB/h5YZR15bk3X7r52aNAEPaUxJTrZnYJLOyTPEDyrrWXDz?=
 =?us-ascii?Q?LdYXXUIHlg7GuMq7vS92Liba4BT8IYz1COX6AC49jSAZ8+Gemf3U61+q3gRE?=
 =?us-ascii?Q?NXukfKi0bm8kD9+vmJwZQnNeVjOVsZeX3aUJfe4x1Zv6XBojyiFUM0QK3SZq?=
 =?us-ascii?Q?0d//lYovnfi+e9SPq5ffbIt+nvYbz+QsnVbE6m8C/qR4KnGDS4vsPUo9Pt8L?=
 =?us-ascii?Q?YjOEtkDk2N5A/0H89h5g9bFExCr3WaMPkXTUAXTFv8I5pY1E/eJM5HYfyDaw?=
 =?us-ascii?Q?ZDZHoaLwap/N/H7y5GDbNBMkPmxdV5+M+h8Fq43VTdgq8w0Zb8vLIbDqIY2k?=
 =?us-ascii?Q?EIOYZrJYTRmQHkB8Jz42KQhmh8hkDxmQCuQGWuCmPnYxCZhbs3z2GEkL7z4Z?=
 =?us-ascii?Q?p7qw/ZATZMFkPIXl8XCeNxRR3wLAR0cSjowxj+YLWDQTMy3arikrFVMMvWpR?=
 =?us-ascii?Q?tT5dOrXzwtvQdZVIajgg2jGMschHg2a/62aEcLX9jo+DJb+Y6o98wb8hLg1q?=
 =?us-ascii?Q?0BddUAeZKuirAru41dkNdJZJFdqkUD19HqXYnQtTOn9nxvV3wsO6B4fUZEOc?=
 =?us-ascii?Q?knVkl0+87CZFdcMLhn/a1isP6+H8mdDxEi73y5k8UIxrhSpSpozg6d19cYFA?=
 =?us-ascii?Q?B2wGQHRr3IKs0U2z45OpmG6kwsCrWk3qEvMnvuAILtwzATz5yMQWo7YjqRmu?=
 =?us-ascii?Q?qQT7ghpPnLVSeoxYkBcdYbZzO0rxbHujI0QdfWIZvfvKuMN6Duf8JtZTnygn?=
 =?us-ascii?Q?oW7srczfdIDg6xOTPVobssoNY/4pclvh+Wu8omqlIVxQFwhCLsDf68Dqpx+6?=
 =?us-ascii?Q?q+pT3b2eyLXKms3SbreNYrIrmcP2lUd7IYsVqJbqaFQzNxWiPguNmczqGhc6?=
 =?us-ascii?Q?Otstsa4nQH90ABa5gmvcMIkc94TZIJtYPmRVK2oDQemFj0bdd12F5zgvNV+G?=
 =?us-ascii?Q?n4PlzMDrgvWMj78YUPBBOR6nzKGNiV4JG9UB4TE0p96fUjgc7DqYUXmto9Yp?=
 =?us-ascii?Q?OYsjFSnOadz2z5juXDjqMsaCH6mtW8zN40B0lX5mDJiByG/mu328D8x1aHd1?=
 =?us-ascii?Q?Yo28WyKk85oRFWpUuPe3AR9OEBtRW3XOqghA0nIPVDCEtse6UplJm/OTDl+8?=
 =?us-ascii?Q?zwV616aOujzazpbrQ8wa763ztyw9uN0msMkURxFLZ+zr7cIjC1d8fyeBXzh8?=
 =?us-ascii?Q?LSEC9fMbYifg3mzhp7FLRGBQA1ofXvSGKdCWuh0w5FaJoCq8EL8r0Hj+kwXy?=
 =?us-ascii?Q?1mKpFKh2GEvZGKzgW+oI0O4akzIKmiq0WLkTa9Qk5gOyJomkZicjUkk2kfML?=
 =?us-ascii?Q?xSUYLASRnp3orOf7Ldg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3bdac5-ecfa-4a08-447a-08dadd2dbdd8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:16:16.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivas2WosSNS3OjK100T+CqkKMRVOgmuyAAgzEet5fwABLB77xbj5KJ30NYp5Zykw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641
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
changes in v2
- change chip info orders
---
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 98811e4e16bb..c3589c3084ee 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -127,6 +127,7 @@
 #define FXLS8962AF_DEVICE_ID			0x62
 #define FXLS8964AF_DEVICE_ID			0x84
 #define FXLS8974CF_DEVICE_ID			0x86
+#define FXLS8967AF_DEVICE_ID			0x87
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
@@ -765,6 +766,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
 		.channels = fxls8962af_channels,
 		.num_channels = ARRAY_SIZE(fxls8962af_channels),
 	},
+	[fxls8967af] = {
+		.chip_id = FXLS8967AF_DEVICE_ID,
+		.name = "fxls8967af",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
 	[fxls8974cf] = {
 		.chip_id = FXLS8974CF_DEVICE_ID,
 		.name = "fxls8974cf",
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 17dd56756ff9..a8944b255a28 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
 static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
+	{ "fxls8967af", fxls8967af },
 	{ "fxls8974cf", fxls8974cf },
 	{}
 };
@@ -38,6 +39,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
 static const struct of_device_id fxls8962af_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
+	{ .compatible = "nxp,fxls8967af" },
 	{ .compatible = "nxp,fxls8974cf" },
 	{}
 };
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 45c7e57412e0..ba33eb2b807d 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -11,6 +11,7 @@ struct device;
 enum {
 	fxls8962af,
 	fxls8964af,
+	fxls8967af,
 	fxls8974cf,
 };
 
-- 
2.25.1

