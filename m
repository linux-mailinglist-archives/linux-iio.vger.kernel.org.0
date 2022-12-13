Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A864BAC3
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 18:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiLMRQM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 12:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiLMRQK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 12:16:10 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EB0B848;
        Tue, 13 Dec 2022 09:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emwpDcIdBqLiVbebwHi288jr+Lvf7coVbFySFzalUhKy1updLNdjIMU3FwjOOyzeQjw1LXNJREDfp5H0ANQhwPdJjR9vxe9Va8QBhCa6hCgrSLJ4eccyzQmYEkaP6nHzO89H8dw4KLWB5HgYhPN/z3v7Q76lM2gH07o4i1Z2lx0Hxv/Q/A4aeZzhy7kQkaYA0d/zUgF3kCmJj3HU2FeJvp03wzHE19hMwEDmnBLDvaScpnYSPLjWA6qh8TBh+aq9jpRKXBlkkWSL/IhDKNvaHWSLF81oWnMweyvLuuJ/Ns8ePqAloKeKcxE2+RvCMG9oXCg4vyFf1DjFFCoyVqx3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm1GhkCJSiStUlENXwmNLPiQVVtRj2M4BVBkl8Jbne4=;
 b=h9qjTZX8wrVn4BnoFurUXIruHKcCjlBnLWQilJcx10i5ibZZtFsusjQo382gR8TF+a9tS2DvNVv7sL6FgaK9EHIElGTt+2QFaDuJ5LQ9Y83VL9+meEcVEmWZeSECfXA7akRcorg1qc+EBnoEO2mPDh/Ux8xyCkHcmdShN7eTQY4vDZ090/6uKCmWuiVzCdPRUQn4LrAS2XjeKjvh7IvnCqFTH2z6biXT+Lt/YyP3DCKhwIVkQCcE0rHbmLWpGLAQrgOqVI19dNs20MDXR9I4xkUgldcoFhDwXja9iNpiLADmzqcyayz9FNW4Ohr5SlPki+8UfWEYEgsEDhBoUijObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm1GhkCJSiStUlENXwmNLPiQVVtRj2M4BVBkl8Jbne4=;
 b=Oo/xQEiAcgied+ZdWBbiuR0a/60CquuIviwcHdkYnmcWZe/GhodRzwYV5gHEOqhK76XjdsDDB9sBSc2K4+6TerftCCdLluMDwT/q8tYPkBXCXXgDRJmUm+Y7zkeeIrxjn8NfmRZdrqMBW2oZA07+02wSz7g4t903BZKC4dsmvg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:16:07 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:16:07 +0000
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
Subject: [PATCH v3 1/4] iio: accel: add fxls8974cf support
Date:   Tue, 13 Dec 2022 11:15:32 -0600
Message-Id: <20221213171536.1880089-2-han.xu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8cd7e8e-2ce0-447f-23fc-08dadd2db902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWpvy9k3znue1FZ29P4Zed6WGb+TidoWktiN06ChehMMTBqikENp3gkccCLSGJMSbGs7XB/yntGSWeRRhj4PLaTLfj+ezFA5B6esIp+dl8WVl7O4TiP5TsGjomjkqL2tjNwtbhGyzM5TVlMdo8FS/Q961BwDpznLW8oiinemapRUpKm48LMfRoxPgvXbNhT3HuGcUOgeTpv/X/aVr55wIBXAcfqltn6H2U1eD282/jiMdj0wjmzOl8Q6bhd4hPk/wXFYbw3gfwvrPjAVi7lMDpti8MwU7ghPA2kIx/uzvJ1MKbuCySDY08dgauka9xEZvKNtsZXuGeIiaj8V24fTiz1vBFAGVcBIGNa1vhgx0Wtukmk3UTqCahKI4bbphSIJM8vemU15ZhiiQ2xvmfXmwzjqkjY8hc6L0eXEmvYb/OstHJDs8QRyyAW8lQxzgBgRoqh6E6s8W8swdqt7jIOnWTKNdFnZoCTvY8IeCvY8Wk0LSC6mzrgDcfN//LDQvMkZMjIciP0MGMh3ILyqY2xujTaL+xbWhnVM7RhSLvOYBPZpI5oV21KbwHZr7sIaaDg84uRN41K7tL8IMkvbKxWOcW4gGmXT1IDEQS7bfFe6njGZ+Q6/eBS++QDOptpvT6gTK/9CKJsVQ0tavdUcFDxXI9l9JKmh3Lg7xnnZ3sV8Dhmr5pVn1khHrf+9LZ7XpQL5jmBKotg/cFjWinAzRKZU5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36756003)(6486002)(110136005)(316002)(478600001)(86362001)(38350700002)(38100700002)(54906003)(6512007)(1076003)(52116002)(186003)(6506007)(6666004)(2616005)(26005)(66556008)(44832011)(41300700001)(66476007)(5660300002)(66946007)(8936002)(7416002)(2906002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?di6jlYHox+RC+EgGCkk+u/S8N8m9ATCGtV3PHYeRuqz0U+n+VdGbm6oth9qV?=
 =?us-ascii?Q?gcKMLpWuuIZjtrgjQHpbypGFfDSWoV3EAfJ8JQs3LUvcC89FYxaHAZ7AZ3zy?=
 =?us-ascii?Q?2mvAB3YDzzfOr1eJRHM+VHilgL8GiJEun+qKLxbca4fiuUjYyhPWidevTOWE?=
 =?us-ascii?Q?cPcfTqHxr0jF0upCTOKc8djyXH12BwKqzhWpuMSzHOyZtPVx40kuHfBw8vtB?=
 =?us-ascii?Q?W/5YfcA7bJNOjW6T58IYNc6HpfMvYBQjJSbsJ3wDEMq86x/5msSahA5eK5e2?=
 =?us-ascii?Q?9S9VB03qrr0425qDfEDeASGMpxs3Zk5sPKUINDsa5P65KMFawDvH0mD2iYD1?=
 =?us-ascii?Q?2LxJUGXGVgjCyOBrD0e2umwZnVEp8gmzulDwH0ghiwZ0ysBWFKQ169+L+7Fs?=
 =?us-ascii?Q?CgfjClrK2UnFYNGgtCOlziZmL0NINNmIuEdFpZzZlO7DbE/5VRGX3tL4HRd3?=
 =?us-ascii?Q?DCCK4oBrBuYXGd6pXkPbHWQmtk1miyRlfmxoub79safq4H7R3pq0MU8rJAZi?=
 =?us-ascii?Q?WGXgayxlMs9dZc+b5Cvw7ugZlBnz2o/j6V6KpujsZi+3gfqOlCExpDzCtcTk?=
 =?us-ascii?Q?sdUOMVgS+68SYIGzZUm21Ybc6i9C6z2E+djE4ud/JNFSXWGHHCgoVaXGVvC7?=
 =?us-ascii?Q?iRyhOmyQLveVIUwKgfmWR2Qak9vtrCvdqyssesBPg4oe4wzmJeb7gdX55uU7?=
 =?us-ascii?Q?W5NiaDMx5hykfFMFoxApOcFAz+7oLMXESt2Vrk3Q8ksnuN7VMTJaDvT5IyNP?=
 =?us-ascii?Q?fBCDbWxsM5O1gVd2RSGvTuptzulDDAfJzeRbPhNxDrWfix7naBZ4r3zDHMXG?=
 =?us-ascii?Q?/EWZE0UZXX9ocsEfIrcaNCwbvEnJmFwNSKxK7rjjyYwCOUUPFt0FtbzWVqw8?=
 =?us-ascii?Q?D6pr5hGdhhZHm+zBib+Sk4pfH78iod3MVRaxsy0Ry4nwUeNhKK4FBSt9rY9w?=
 =?us-ascii?Q?sGbvnr1w23MsgMCgd38j4aWrHMZbj+BXQdi7VWvMRIzPGDxQ3MzQWn/rPfwi?=
 =?us-ascii?Q?IKWpRJHTLG22Q9FM/Wm3QWdAdlHGK/Yid6jLUHd+KF18Xb9flwLruvVMUMv3?=
 =?us-ascii?Q?XHarqV2yTk6MyHBCOtkN+WBROJI15hIzzKo+S+1mXd1HOIDAHeknOR5ZbnsE?=
 =?us-ascii?Q?ubW0OEKX/iNJSxjIaywrdxgEh31PEUIVeDc72ieKry8/vcrFGfd6CoZl/gUg?=
 =?us-ascii?Q?j83EqUTSC5g2IKUzgeu19ZLWOfo4cQPO/n5lU7kf0VreykjO9ou/ziXm0nh7?=
 =?us-ascii?Q?TbR4bHF4u30v8KMe3pIeqtx0GYDG/jtirSSltrJOZVrcrDgbpqKzM85Njczg?=
 =?us-ascii?Q?OJi0EKcT2/a3QwHRA9AUkKJ/RsXDqm+Vbily0JJS4kNHW903zaMFcBnLd5wP?=
 =?us-ascii?Q?NlLT/O61J4o4QeakAkioRQDdKItSLC2z/LkEECwYfnvVm/2a7MMIJYquFSjq?=
 =?us-ascii?Q?PavckaCJSl5Cl2SId2v0gjclpSK/JBRDB81Wza2IG7TUKwQAFyaFcWxiyaHv?=
 =?us-ascii?Q?EXrvUF7hvfxiYv9vnMsklDf7HokXJCVl2Hlz+sJytAkFeHreulGYX/d+zd9m?=
 =?us-ascii?Q?YPrEuHRt4hq4X6TFxFY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cd7e8e-2ce0-447f-23fc-08dadd2db902
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:16:07.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtFQnrKaA/R+Z95PM4eFse5hRo/9kZfDwTiWJUVWEV8NU3n/MZzkLiKBq5MnPuOZ
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

From: Haibo Chen <haibo.chen@nxp.com>

FXLS8974CF is similar with FXLS8962AF, the only difference is the
device id change to 0x86.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 0d672b1469e8..98811e4e16bb 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -126,6 +126,7 @@
 
 #define FXLS8962AF_DEVICE_ID			0x62
 #define FXLS8964AF_DEVICE_ID			0x84
+#define FXLS8974CF_DEVICE_ID			0x86
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
@@ -764,6 +765,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
 		.channels = fxls8962af_channels,
 		.num_channels = ARRAY_SIZE(fxls8962af_channels),
 	},
+	[fxls8974cf] = {
+		.chip_id = FXLS8974CF_DEVICE_ID,
+		.name = "fxls8974cf",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
 };
 
 static const struct iio_info fxls8962af_info = {
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 22640eaebac7..17dd56756ff9 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
 static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
+	{ "fxls8974cf", fxls8974cf },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
@@ -37,6 +38,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
 static const struct of_device_id fxls8962af_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
+	{ .compatible = "nxp,fxls8974cf" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 9cbe98c3ba9a..45c7e57412e0 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -11,6 +11,7 @@ struct device;
 enum {
 	fxls8962af,
 	fxls8964af,
+	fxls8974cf,
 };
 
 int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
-- 
2.25.1

