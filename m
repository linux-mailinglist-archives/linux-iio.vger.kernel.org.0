Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618F66404CB
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 11:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiLBKfm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 05:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiLBKfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 05:35:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5325C4CF4
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 02:35:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox/9BvqJFTfWBm6Jk/7R86ywt2jhkHQJ13ze6lwkgOPQ8JnTR1J4jQYYV+njiDyOpzLrmU4dHsdmoJW5v8aVe42yMToipytWhS9yCk6vy/xh5o7btyOYzv7M2VZgzn7l8Yo8gpzcrVTduffKFAMLHgpXwPHat48t4Psqx5VN+vlBQUZFX7KGIUlf6svcw8jjmKmvLsFBWzmT2ISIlfOSjXiQlqSn6d5jvD+Q2sZcHR4GsNTUX4zhNTgHRg2pL0NRBGRAmP8ixOn3+VrHP3vL9jIyRiEifmtlIPa3O31jrCArF36uuYlKhApMhOBSG14ha3TDQAPrOd2u5SZuPUa7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb1wGto07Ov4u9vvQZ/sg/5BMGUWcNxzMrIPp6bzkFU=;
 b=jv67nF1ogJPtije1dCKC2U6ICGDXh0U7R/UTGcqU1xKk/dCw538MzjydaY7Il4Vexx0ZN73At5ptpTcWcAoCxi3rBKAlopoybTKLMKZlISEVmIDAk16eONXmhyHihghXIzyaQSVdLELSU59zm3TC30WS+X6SmV9YH3EVJ07fK66twtDTpGwgIbSkarCl5sc21gmCbLxv7CuHjczXUMs7s+l7chtRA0DmjHqgSHIOaOesEeSIjCmmg8sbMvrbbgJvYSvAXyp9Ka/cnlWSZt4dm/HXNnK8cLpCvbSXBojvTv2zl/HzPP7nx9X+PHGKGW5mGsSPm4UCDE79yleBpmtKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb1wGto07Ov4u9vvQZ/sg/5BMGUWcNxzMrIPp6bzkFU=;
 b=YGOwzTKVEYVTTpZ6GxNO67P1G7k3Qhw3kOow3s9ORzjHGIIW0Ek4F3dEeEv4EJYy/PbVU0RgJ2vs2sor95scuu5BFBV8u/3wLa4D0IjrL+4FxevILkGJhebjKEiuwNy/Rbe2G+emI1kdE/SCKTpZ27Ano4nhEacNN+Fp1H3iJd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 10:35:27 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 10:35:27 +0000
From:   Carlos Song <carlos.song@nxp.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/4] iio: imu: fxos8700: fix get data function error
Date:   Fri,  2 Dec 2022 18:35:35 +0800
Message-Id: <20221202103538.2218925-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202103538.2218925-1-carlos.song@nxp.com>
References: <20221202103538.2218925-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: bc439f6c-aa90-47de-e123-08dad450ed56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXpNSrVADNUhTTvWIpyVa48npU3ATFW9JqsE3DK3DCkdKdsMsgQNzBoHaaHZPxdUW+QNI024ykaQg08uU5EuZl9xd0uBsP0nv4pxhTJe6A4wclEUCtK5CF3jjBg9yBuJ3ZJrEut2n2qiFpqiXaPr8gP4Raqr5m9fDSOiZqBGa6gN/NPDF7Nb2g9HiyBR1APy78PpMuU0+U13jRtk3k3LHviyXEeDdy0NahSdh5uIq3DlO87hXChLxW0K+KLYf0nOsBO2m4ZZ0z1IcEJPpGQiU2+05UlU+LpPCsk3LR3bIGiZ7aRoptDgRYp2h3h/UM0EL9MTJ415syXIXEa3s07Ior4pDTBM2knHfVied6D1W+NG9WS0eq2eh5AuhRawSBZo/ZOUwfMqOCiRbkVGUQS0g/QTmC6WeKH/WDl9FwQJeKUpVmcl8KSBy13LWEHcNMCLqDBs6lDQwEv2QARH2eUhzVpvrO3V9ZbBP5lxfSMW7poymvxea6ygGl1Ed3IIQ8fYdXQbpnJ57bCznhP1ORWwjkx7Q0g+CgweRtS8qVDMxcD3AYljrT1ArYYdCaJho0W3cGqtrIUfJ3q3faInyIVu31a9PaXALmo12OdyojS/54Zi+aJ1+lkEc5xPqh0YJlqAtgXJEH+z8gkLXxuYxY44KdpfgCGdJoKNwSuXShuXLHHyBCQrsX+6BOvcaj9BcbuksN2ovcmNdI5C84gSmtXojg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6666004)(52116002)(6506007)(6486002)(186003)(6512007)(26005)(316002)(478600001)(8676002)(66476007)(4326008)(66946007)(66556008)(2616005)(41300700001)(1076003)(8936002)(5660300002)(44832011)(83380400001)(2906002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/l15oDNdSOSXWheZ/XRXm5xMM5tyB3EePed6cjBYHr/U0PLyIBa1vCya4gSW?=
 =?us-ascii?Q?9x09BS3YAMG1lUCEUTCITcXIKYcjaoOzEdAJCR87FG8IWakNqnGlaVyqa/zF?=
 =?us-ascii?Q?l6SvOPjKpK3/WJgvdUty/nFdnSVI5mik75mc1wk6EbaXCRe5aQCtEdc9XNnl?=
 =?us-ascii?Q?eLy4TkA18cR2ZGLybbu0Y19HXMBR1451KRqL+FD+iBbxto6zNpPmoJaVvGoO?=
 =?us-ascii?Q?RMsvAc0TMBeSugRIWKzyHIAX1yULB8NpnrugMzDwtr1J5BxezOQdFjIzHenf?=
 =?us-ascii?Q?7uWYMVf2J0tCQUw4SCX4iPbFRCUJSwSAIoEn1g3x2MyLDC4X7vKaDBW/FCT4?=
 =?us-ascii?Q?FWWkPcm6IJT4u/anT6pV+noqvOabt9RwSlXLTTtbjFSI0WSzp5T4puXH9zhK?=
 =?us-ascii?Q?7OTaUEWs3g9pj6t5le6vBlEclFQBIxHppfqYr94LrTolJzZGG29VzCJc2U45?=
 =?us-ascii?Q?j4nM70lKJHgKWmgawHF6lXj5D6h6XR0pPIvz1wMZpGwWfG2rMz6B3X/HL5p2?=
 =?us-ascii?Q?vXoz4G62tS0U7ezAGEJQWOut62NrwEjr2zoPW4UZR/vZOxz9SqV8aRttJ7sI?=
 =?us-ascii?Q?I61Ibol6PeKf8aEfJt90S3MwZLMd22Cu9MBuAFx0j3/OhwYTyK43GRMzVRiz?=
 =?us-ascii?Q?ISXEFnFyYZ/EdvNcu/G+hEYEeqP9EuoAiO8Kdn4iXn7wiFJiFXnljFAxxquO?=
 =?us-ascii?Q?REjbFAS7gjaMsF9ZzBx1QHirlcBxJaRodMfEFR1C7rVyN7naNEtv7By/9c/m?=
 =?us-ascii?Q?/aOH/TAEe5ZsjmdtWF9W8YdhbQaBZYjbwLbKgrVddpzkjo3zm2I8fq4cCqr+?=
 =?us-ascii?Q?tulu12qKvCBTTM9chzREpHhC+uJs6XxtyX3QXFj5JIlOdnNJPRD+gNB62XmB?=
 =?us-ascii?Q?gaGSNCQHOzNyoJ5IariWCvnbnQNbui7Gt4STS7yfwDsJk6aU1mgmVd8lb9IK?=
 =?us-ascii?Q?uglJrYmIeqcebeixbgoT1x9xDXyF5EHA1hYFbn9KeDR0tno9CRhiMPHKA1lB?=
 =?us-ascii?Q?hcO2kMcV833/R5XQ4BAlFEU3u14ZpGfyQ51z3Je4MUBO4IBFUgmYwuNMzigR?=
 =?us-ascii?Q?cQtqeBkI2py9D4FIwQJ1hsU3S1jeiNIoU7eNshHbOOtOkWnnumQCHDKMxucg?=
 =?us-ascii?Q?ZT/8JIlX2KrMuCVQUcTMFyxAtYKE1QOuxykKEvl7U7XbCsqIvpQcGauZx8iL?=
 =?us-ascii?Q?rsrY+UWE31AFWoaGJ25QR++34e4YmMApu6fi1aLXLjTOoeDOR3LmHceinDKu?=
 =?us-ascii?Q?DESmwVFP4RNtNU0zxxTzdsNeejegvb+Xdp7ehIuBFV4M2jfJxB0BtbT0Tgil?=
 =?us-ascii?Q?A+l0EdbQgcmttDC++hIwvIcMsVNWA9OCaeRxB3yGJsq6n9iAnzr8mx3vFHon?=
 =?us-ascii?Q?YyPtXF7vXoOB5oWSP5kD0QoFi5Kyli0QoPAPAGJ7ikVQZlUY1wA+8m8MIWov?=
 =?us-ascii?Q?iHj8UqyCsiXKPN199p/mM6UK3jUHo8xaIHVCZhuhl+iGvakEt0we+GVmsV9R?=
 =?us-ascii?Q?k2npf1ySXQlotpr3p8oB5ujkNMbmxVf1aywgqib0iklfnZ1dYAlK00fgc1Ck?=
 =?us-ascii?Q?NKR9qvNGEfUJftw+3e7Y+2IYYqK0NeGq8m2I1xU6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc439f6c-aa90-47de-e123-08dad450ed56
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 10:35:27.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yiz3N0zo0K6U2InExTdZXtjZtpYJJ1Vcb1eviIIdUtvdJwwpxXBLs0Je8BUtzTdxRnkLN5eq7K1jE2dp3WcDGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Types of raw data include acceleration and magnetism, so base
address should vary with raw data types rightly. The function
for data acquisition is incorrect because of not considering
msb data and lsb data. Acceleration raw data is 14 bits and
magnetism raw data is 16 bits, data reprocessing is necessary
accordingly.

Rewrite the function for data acquisition. Base data register
address is configured correctly varied with acceleration and
magnetism raw data, and data reprocessing method is added.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Fixes: c9a8417a13ed ("iio: imu: fxos8700: Fix alignment for DMA safety")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/imu/fxos8700_core.c | 39 +++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 423cfe526f2a..a69122799892 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -162,12 +162,10 @@
 
 #define FXOS8700_DEVICE_ID          0xC7
 #define FXOS8700_PRE_DEVICE_ID      0xC4
-#define FXOS8700_DATA_BUF_SIZE      3
 
 struct fxos8700_data {
 	struct regmap *regmap;
 	struct iio_trigger *trig;
-	__be16 buf[FXOS8700_DATA_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
 /* Regmap info */
@@ -391,25 +389,42 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
 }
 
 static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
-			     int axis, int *val)
+				 int axis, int *val)
 {
-	u8 base, reg;
+	u8 base, offset;
+	__be16 buf;
+	s16 tmp;
 	int ret;
 	enum fxos8700_sensor type = fxos8700_to_sensor(chan_type);
 
-	base = type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
+	/*
+	 * FXOS8700_M_OUT_X_MSB is magnetic X-axis output data register address.
+	 * FXOS8700_OUT_X_MSB is acceler X-axis output data register address.
+	 * Type is 1 for FXOS8700_MAGN, 0 for FXOS8700_ACCEL.
+	 */
+	base = type ? FXOS8700_M_OUT_X_MSB : FXOS8700_OUT_X_MSB;
 
-	/* Block read 6 bytes of device output registers to avoid data loss */
-	ret = regmap_bulk_read(data->regmap, base, data->buf,
-			       FXOS8700_DATA_BUF_SIZE);
+	/* Convert axis to offset index */
+	offset = axis - IIO_MOD_X;
+
+	ret = regmap_bulk_read(data->regmap, base + offset, &buf, 2);
 	if (ret)
 		return ret;
 
-	/* Convert axis to buffer index */
-	reg = axis - IIO_MOD_X;
+	/*
+	 * Convert to native endianness. The accel data and magn data
+	 * are signed, so a forced type conversion is needed.
+	 */
+	tmp = be16_to_cpu(buf);
+
+	/*
+	 * Accel raw data is 14 bit, magn raw data is 16 bit, value should be
+	 * extended to 32 bit.
+	 */
+	if (!type)
+		tmp = tmp >> 2;
 
-	/* Convert to native endianness */
-	*val = sign_extend32(be16_to_cpu(data->buf[reg]), 15);
+	*val = sign_extend32(tmp, 15);
 
 	return 0;
 }
-- 
2.34.1

