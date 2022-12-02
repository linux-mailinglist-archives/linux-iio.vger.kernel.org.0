Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501E6404CE
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiLBKfo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 05:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiLBKfk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 05:35:40 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA210CD9A9
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 02:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny8cDo9LgMrgtMMU06E2kicV6s0PD6vgk/eJTGHSDOokZ6iQwbqAWi0CqFQhB1Q4XHyiAKQ/bbuJzOhIbEYbtvjnEUBioMIkVfalrKIBZet2zYujwf18PDY6ex+VJLQ51N013dIUDjwz70EUw5ChpryFI+eVK3VXL3L1sjchSjA5OhhoKfWiC9vET5gksuvVSaN+A9BZ45YBWsm5Ol+E9+ljacVT/H0uXS1Q1cwutK1AtUKbViltkMGR8gWlYdEb2lFdBtYDm5uYGTjghFFqjj0Kq+MnOTl/x4riJ2Va/LizTpI0AEFEybAP9Jdl/K6eNCsajcaB9LzlFGdavHiq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09TgKXj4pu1Po4EQ6jB0jvyDyrSV5utaAt6Tey6p4jA=;
 b=JUw3vkFKjgqCNeKsuFOMoDoksOQn+rvOepDpziwziurHWgn7hr+AtuwZFTIVBKFaT5i0uwZG88yBzbZdOe66T0IfIcVF/CMq26uBQn9zMZfKPgEBb933ik74piY9SC2Y8zV/7x1xbHwrOwi206F9cmP9p83TZrhbB/fkRDIt4BacUUMFqcZv4HbtMzzO9VuWCFYmRNvzm2sf/xqi+aWY+mORKhTDShMijtNpfdI4+Mb0Vh5Hj3iKIemwP1JiFKmP4hUkNbgvbhVspCFSj5dLeDhnlG9+2EgDKeiKMOMU2sHcI8NEo+qxdJD85v2shXMxLcZ7nNo6FlIDejzCKoq1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09TgKXj4pu1Po4EQ6jB0jvyDyrSV5utaAt6Tey6p4jA=;
 b=svMvRAh/hZxiUSVaLW/ocvF39eypTkUJ3gb3fqm99VHf8NmsTiqG0QjYezbodJsycKrVUx3X9oRBFhFHFM7owsCZXmlhfZvnTwIr/r1tJkDRWf0QouMO60vwC0LaIUf0hz8Qy6terw+onI1zomjZCxAIKs0J9FbHX+wzQBB38qY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 10:35:36 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 10:35:36 +0000
From:   Carlos Song <carlos.song@nxp.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH 4/4] iio: imu: fxos8700: fix magnetometer scale getting error
Date:   Fri,  2 Dec 2022 18:35:38 +0800
Message-Id: <20221202103538.2218925-5-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b824964-c3cf-4d29-4ca6-08dad450f2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: put2ZqXyQEno2RW65/ifMIa4TyGJIpCaJNdNMmoywnl0UkBDOCLTBLYDfnnbnBc/UwS8EW0BDozXyXkliZiS35Iiz2vmoM/Y0maqwAQ7lkBWfq9Xv/yQNT3Otz8wrPXjORZ6vviCQ0M6v7KWBbDNKGSgQhhZXCsUeYVlJAwBEAwCd1f5JoxHAdPe+KgnJw2nlsLquYthK/FyuqmqPzvE8XXuxsn1GGaZ9TIGskMo1ZkEVLg7ApK6NuUGRsS6wxTQlMOmjjU11nfzkiET630xcyuXjo4yH5Zxyx8QNDKlxrBW4ZxcFksfzB5L/8HHXApItCelnRW0RxihSMXte6Q4ztnuSvxALdJdo1brulB90gTC+80rOdc/RwHwpyLihfn4JsuR2LzYZjpC3NDu6XuF7ObGsjSwz+8JUz0XAwBP8e7ylQrEF3nEAvoV07IYOklcxJ1uCwPzr8aCVRktlonB5/ZcbEVguLk0MOLL5y2ztFxPaaJMvhI2R+C5dfr1r5Ynzo0scDzhfS5cuZ6c3TJhSicVH2A0OHRMOk5vsaVHw/vl4HCsA9vOmft2RA9PMGy5JVVK+n3wyajn7860nXrVUQHV3VJTtZ6ygb4Dc5XXUZXNgia/dItOi5H5Kv3+4a5WjMbC0ONqq1C+juB45M75fJE3hrnY7/mjsvY0juYdVLY/bhR9sTVPYjIiBaMpLHQ1tVRCJ+HZPhjQ1k5ibC2StQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(52116002)(6506007)(6486002)(186003)(6512007)(26005)(316002)(478600001)(8676002)(66476007)(4326008)(66946007)(66556008)(2616005)(41300700001)(1076003)(8936002)(5660300002)(44832011)(83380400001)(2906002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/4J+dENkub3V/s19qMZSY5oDe7FS0ACXG2Rbps3OcG2fA7m/8UpCiBxXQgEh?=
 =?us-ascii?Q?8VT/P/c2IAneKIUGrzln/85CVT+HTmz6aLv5MqL3JpKjhvSYelmtpX1rB1ce?=
 =?us-ascii?Q?Kdp80Kax6YMObBgmT4M4p7TX7580MgF9Ylusa465XLLsHMoxvnFtPibezGNz?=
 =?us-ascii?Q?gQwcgH123mmrs100Svp8Y6Z551FZeMrTBpAAdF9RB7B1FBrB2DmWC550Jy/V?=
 =?us-ascii?Q?1kHn49Qp1KaNpVxRrO70LX1ZImRjTnkDztaXPTqGr0XfIUGHZUP204hyIQyV?=
 =?us-ascii?Q?YyAfv6drNfrStArGBlSSd0Uln6GiwYpDSW4ZBAkZtCGVNdE0Kiyc9P0Df2Be?=
 =?us-ascii?Q?V1TKoN6tJ1ycj+KMruMe5fXDMybBi1j52osv8BbkjNjQP9IBByDElhzB68Jr?=
 =?us-ascii?Q?/xyE/v7OsIH+p7rQwrk8j5GxMXvO2gen6ji56IqEA4P3u8uRcNHSYKHnxBQ8?=
 =?us-ascii?Q?Lj6pbbyOiAiDaBErrZCElk9RxVyLKj/mkrzVCMhAwxMntbWD9Ojs3414J31l?=
 =?us-ascii?Q?EkRX4n6r/LKV6hdQ740TDgtzwDZoWBnQD7IxbKYbbWS/vO3QRPx6L2bXUDA0?=
 =?us-ascii?Q?5PV/z2ONIGqlvW9K4E3fdTf+OkiGsNNu0j4565/rCc7N/uymNxdz8KqRjSKi?=
 =?us-ascii?Q?lLIPkwFEoAMz5DzNWZEZAPla/zVaKXylxRHCEFnGMLRZVoJ/EsdY+NxkDBJI?=
 =?us-ascii?Q?xbQdYKMNV+BSdaEzdDFhcMnXXJbomJYdPOr9hDtnfVN+lsbt3yy44LUxrzl+?=
 =?us-ascii?Q?uegAtVDhpX3OWhjWM7KEa4awfDk7zmaWx7RGXxlFlD/rtgWx7P1OYTMzP8yg?=
 =?us-ascii?Q?Myc8dSq05tGcR384NZD2EsCTf7m5FpR7chWHBj/CRZbpj/dv/vo3ZCnMZWON?=
 =?us-ascii?Q?F6DmfSc3zoLlWo+O3yfQoW/b13WyJyPCf998v0ERaAwFokYGzc9bzbI1RwRx?=
 =?us-ascii?Q?qiBWPlmZnhRrlrQ37V9Z9LZXaLqemiX4Q1eAKPYVxO25PGwFq8aM8KIjSGjZ?=
 =?us-ascii?Q?NjIIiputfBIfZrj+FSupNKJNEH4I/CbcuuK1BAIE8JT16LINPcIhq7Qx9DTX?=
 =?us-ascii?Q?Xoh64ZmYLarDC9la9tW1qFA36NJLHP2uwSsfJdZGVdXxjt3/sH3MA0X2VrAu?=
 =?us-ascii?Q?RY56C6iF/QD0Sg8WId7PXE76bwGuurcQCMvpF1+9VuvTeeUfu12x8ngcB8U/?=
 =?us-ascii?Q?NnfCw0OarUwRJvyRDax6SJlmnULXBspy3SC0NauoSLWfOoHW3pMY15k5XY80?=
 =?us-ascii?Q?Pyr83m08uMvKZS6u6pqJ1h/vanp9SK92XN3U//dV+I0NNH8Bf1hT3gq7xrGV?=
 =?us-ascii?Q?E5qUvYplPS4FWhBqYtSH1KrG7w7th16LputSrJ27YwuPkyRh3rKF3x72DyrQ?=
 =?us-ascii?Q?JqQAN6Xo8W9FiFPtL5MqjkJFoaE+RA+jraX7q6EtME+1OVhjL8+9OJ9NtWuT?=
 =?us-ascii?Q?leci8beiBeeADBsRL/UZzeqa+8PBntoS68S1B5kLJ2sweRT3xEbT3ANcjAyM?=
 =?us-ascii?Q?1ZCn9LlNEZIVYJTGwZPdPmPpMMsJOnueowC1yrnseLOpyDNyidlhYNY8yLRh?=
 =?us-ascii?Q?tnqFlMoAHcCj8xeWsr2K6A6EsCbxhBnxI6DtnrkT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b824964-c3cf-4d29-4ca6-08dad450f2ce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 10:35:36.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/s7SXh+wwqMya4Sf/3RrK5DPMtiZQgPOA9eaRqazQxzl/BYp+0Rxzxs8W3KhoIt+IV4smfCk8Anb7DsPN52uw==
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

Incorrect iio channel type cause a magnetometer scale getting
error. Meanwhile magnetometer scale and available magnetometer
scale should be locked as 0.1uT according to the datasheet.

Set magn sensor type "IIO_MAGN" and modify magn_scale fixed "0.1uT".

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/imu/fxos8700_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 27e3bd61d054..8d46462dca76 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -319,7 +319,7 @@ static enum fxos8700_sensor fxos8700_to_sensor(enum iio_chan_type iio_type)
 	switch (iio_type) {
 	case IIO_ACCEL:
 		return FXOS8700_ACCEL;
-	case IIO_ANGL_VEL:
+	case IIO_MAGN:
 		return FXOS8700_MAGN;
 	default:
 		return -EINVAL;
@@ -350,7 +350,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 
 	if (t == FXOS8700_MAGN) {
-		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
+		dev_err(dev, "Magnetometer scale is locked at 0.1uT\n");
 		return -EINVAL;
 	}
 
@@ -393,7 +393,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 
 	if (t == FXOS8700_MAGN) {
-		*uscale = 1200; /* Magnetometer is locked at 1200uT */
+		*uscale = 100000; /* Magnetometer scale is locked at 0.1 uT */
 		return 0;
 	}
 
@@ -563,7 +563,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
 static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
 		      "1.5625 6.25 12.5 50 100 200 400 800");
 static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
-static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
+static IIO_CONST_ATTR(in_magn_scale_available, "0.100000");
 
 static struct attribute *fxos8700_attrs[] = {
 	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
-- 
2.34.1

