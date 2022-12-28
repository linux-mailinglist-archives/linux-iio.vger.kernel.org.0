Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10586574C2
	for <lists+linux-iio@lfdr.de>; Wed, 28 Dec 2022 10:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiL1JjQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Dec 2022 04:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiL1JjO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2022 04:39:14 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2070.outbound.protection.outlook.com [40.107.103.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C5F015
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2022 01:39:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxgZR2Q/5qEasjWQgkOUvVQImmwwl7TOpX8R99MyhLzxCb8/7QOKQYTcYsuHctthUxdWd2eTp8alMcTWBA+w1QVhG8rNSkijwu/VuEwSj1NaF2QfdH4GcJv8kgqbKk2nUMm6sXCUTlyhChUC2X2Xsys1HGJiOCka0MQxaokJGUIuQXS+xwvdbux7p5WCtCJ/Bt6xK4+i6hfqmCjLSVnqjes5aJueDTWnpIi0EIw9IcyM47qSGhoE6fN7yCCoosTtJy/vg/2RIZ5+RGOnjxUsCH5514oGs5wRfNIZ5mTuz8JNu38uQd8nqpWlPADH9LWgdiIJ9Rz5mA59gQgb3S04Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgXC0Z3/M2gPBYpPr4l3jOhdS4KGeH6Tl2udpBH5iwQ=;
 b=DNDs4j8aijnGNmhvM7p4sz+SZgFrke89IXiq0XSApKdVH6/XwtBGKYL3CUzNUyTpXvIsP4dI4SKStqresrQxTyzbzV8wRLF3SwH0Gi+UGz5NDDdJjbB0B92md9JPI8NHiUDelQ3XAWRcAbT8DBRDRWXIbw/J7jtKg83+EsagnIx7XHm3HZ7JvxBCSd510Q1xMfFMRSBsZEfhozJpmdMNm0gSrX6Xh7j0Hwaiz6+wFmo1heYv5sjpvXY+L6zc0oaNtuWOok5+c0uVM58W1qrkRufJ1WXoEfafgbtO469WdE0PsbrsJdOVuJEbJak7aNI+AVwUWGxsfFHkQZBnZAn+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgXC0Z3/M2gPBYpPr4l3jOhdS4KGeH6Tl2udpBH5iwQ=;
 b=Qm+nsHG2yP+E8LoCvP5Ntdwm0fJ/HTq781xZI6OfUQBSM7olOeW7mK5MXdrhq85IPyZDHbenV8Jd7Q1yNzj8f57NLEONaJPA4yYxG7bkBCJlQzqKO1HfWnD61CcMEvqpy3eUF6jMqAJBK+OZzdV6SuSJAjEE5oDI2C3E+DtOPbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 09:39:10 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5944.014; Wed, 28 Dec 2022
 09:39:10 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 2/4] iio: imu: fxos8700: fix failed initialization ODR mode assignment
Date:   Wed, 28 Dec 2022 17:39:39 +0800
Message-Id: <20221228093941.270046-3-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228093941.270046-1-carlos.song@nxp.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7c9863-623e-47f7-451e-08dae8b75f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRa2ncO/69cnGIruqQ4WEADhpF+69xnj2RDLIUByRqLZKrQQlweP0jGR7Wn4dE1WWolV7cCqR55Hw3lanQ+omcs5Dl87NTYGnQwr5cYbUydMKTG2UAdLJG4W9JALNcgO4M66d/oiRJfDMML2Ip4QMRIzoa8JAFzrXjd95YuzS08Jlb9u07CdiGNTJHHdSMdRdn+yrtcGA8nId7RQ79xoecMSj6ajqD6duuUY2/1DWtiS0p4p/UVPb3uCAE80C+dC/qbJHUKA1PVzLPNQKktGzJq/kmSkURhQvAsM4QbcgXu3vvi/7K4sNZ+ZVLybDvQSQP2hzUw/KmvcZhfayiYWJYrWAEN80OCFyVRHGOGhNk9V7N4TM3Aok6lpM3GcJ4FJtcfWFgCS5fPZzVtmPatmQZhmuT5nx3N4y9s6XJVvnWeeYHNomOrggymyTuW8xj25Egv1VdXkv1w0hgAGanyaH8ClGwVA2l+CPhV4AZDGv5qoDSsReb8HYDPvxZUfFL/blu8luCHaTtiuhYeDPjgdz01A0ZI4msTSGzgQrN9VSaPi/z993gCaILFn6hob5iRKzcGdXjHywKBTrOsrvFhZP2L+f3xymPV2kWg8dt6IINBzlg6GHxriWLLM0dMXc1814yIVS4Im6qvkFcd+B4M9Qj+Y1tsfqncJv99KB2r853UtUtm79w2WnNTcdREowURA53UBlrdKdySGJQ9BD3J5Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(66476007)(66556008)(4326008)(8676002)(8936002)(86362001)(5660300002)(66946007)(41300700001)(36756003)(316002)(2906002)(83380400001)(52116002)(6486002)(478600001)(1076003)(6666004)(2616005)(6506007)(186003)(26005)(6512007)(9686003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B+0bxaVZ9ZDqUy2NcrJiHW5MMG+2jeW5cy5zotvXeyzP3g8Rzu2JGqZEExPS?=
 =?us-ascii?Q?9NdtjxWvOYYH1dnxPlsrse3WCHpesoI8BSebKUCCDzCP6T35VZJYjtSftpZn?=
 =?us-ascii?Q?zj6CKwUFFBoMaGywy1o/z7abUNpksiYc8GL9rDCgA3WEr8R9Wr+lYdimYKK8?=
 =?us-ascii?Q?DrW4GQVr88jFfmivYrTGi7hy4sQeMlMXrETy4waiFM70PulqL8I8gsIVBwCj?=
 =?us-ascii?Q?6HWgUD+NmVwNRcsb+PiZzOgGdbv0k/PkahIAZaRJ6tzNvAQmT4JghCk6bmRg?=
 =?us-ascii?Q?95Nuw5XvqbA8Muhbj54pLy4pZDryh+T28e3OnkRbgdfQ/p7umb62bTCA0BzP?=
 =?us-ascii?Q?N2rXrbt/78EqhC5mniAmMX1weqLhkafPCHWWehx3NlMAloon+eIyT4vQTE3f?=
 =?us-ascii?Q?UnuHVukuRN8FAup/1dq3W/FSTGvPTGc+zfl5lLSqMyvSgvGxu/fGhCPPxwhm?=
 =?us-ascii?Q?7Ta/e+8RG4/DrCNa8Stbb4fYbEdR5RCHChGTrZBX5A7cSaRFEbCvgIlTgYs+?=
 =?us-ascii?Q?qLudGcmPKCbsO6nmlsfaNvLJ344Q+7HUJ1Jw5kaccYoqr9J5BIMOeQXSXrBX?=
 =?us-ascii?Q?u6f89pujVH7H5kW34Ek9F5BtC/pWdIk+Vnd8rK1C+fDF4yo+JmbWmmrlt+1D?=
 =?us-ascii?Q?rVC0HFrEzzZYDLIPev4sFHj/dUX9Yulye3VoUTy0SmWwP2sP9Z/EGWG+XneT?=
 =?us-ascii?Q?WWgfuMo5IyYKxvpqKqNexbtKQGzzbnT30CAg+9sRJloWNtmYxBskZpaKI/p/?=
 =?us-ascii?Q?/caSLCua5vKuUeODMac87dU4D/EIrf4WsoBqkKXf2AUiwy/uOJM5Pqm6+RZx?=
 =?us-ascii?Q?J46M5YXfu/VFwEXBO1t5hsw7lbKfQZ1MfM2pm7OZTKlZhhZSHuhjjgbV+iqt?=
 =?us-ascii?Q?ThQWOCRpU1qyrapfgHyHmlNcjk5dI/ucJpn9DsfJU/x66SQPaROSK9APu5fL?=
 =?us-ascii?Q?QzLKFLmmmF7QH1LPykD7hwYqt/ZO3EwJCgdHLz+4YkJEDHZR8XaqWkzAsUPP?=
 =?us-ascii?Q?JimDRkHOTR58KXRPr3+tEdfTwr42chFQexHtt0/TrRuVi1e6DH7msaXxrkT7?=
 =?us-ascii?Q?MwvBWVwGL1aVJXld4y6DxVRsS3VD5KE+o8/vOg+OzkpzMQNaDb7erb10H4l3?=
 =?us-ascii?Q?tHqIXhXK7rQrmodQCvRABmy5SjezwubkJEhaBqL4qS4xjNehcQYyMT2AXBYV?=
 =?us-ascii?Q?CywWkBVwZsaRgq2KNyew8RmJ5/BDnwse2enL4K3zOw5Rju3k7IxHtiangxVw?=
 =?us-ascii?Q?Mx3aHRz8rcQyn1ZUnClhIivPiWGXy0vL03PSChiiMpJTBzJyLKAo2JI84FPw?=
 =?us-ascii?Q?gNwTnlpdkrKLTLWc/FES6awsDx/g3Mv7CqOS9gQmi4o9Lbo4nF9ow7TB8jLK?=
 =?us-ascii?Q?JQxwMoYhxk6c5PznhPztyH4bOqG49Qzqz19KDXN6Z44LPEMlTatMLJiDR5pz?=
 =?us-ascii?Q?icKEjmLJV4eRBDuoaU/Xjcz8g1qMf1DHH85E6lA2AExTHfGHQKuaYCxSwC9W?=
 =?us-ascii?Q?2IYRPOQVtBp5mF4TCKl1wSA5cxng7EMhS4CZMe4VKEylncRKbR1gDz1PcXuM?=
 =?us-ascii?Q?gT2RvjDqvHMYlJkZoJtLeHCmrl4Pi2e1fzMZ505n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7c9863-623e-47f7-451e-08dae8b75f5d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 09:39:10.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSDAHqAwLLICPIW07YTA+e93zm4DbTMa3E2TXtE6jhmEX2vYYQjEWCRqRDC6VjgV3yfwfLNYA94Xs8qCLrR5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

The absence of correct offset leads a failed initialization ODR mode
assignment.

Select MAX ODR mode as the initialization ODR mode by field mask and
FIELD_PREP.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V4:
- None
Changes for V3:
- Legal use of FIELD_PREP() and field mask to select initialization
  ODR mode
- Rework commit log
---
 drivers/iio/imu/fxos8700_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index a1af5d0fde5d..de4ced979226 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -611,6 +611,7 @@ static const struct iio_info fxos8700_info = {
 static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 {
 	int ret;
+	int reg;
 	unsigned int val;
 	struct device *dev = regmap_get_device(data->regmap);
 
@@ -663,8 +664,11 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 		return ret;
 
 	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
-	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &reg);
+	if (ret)
+		return ret;
+	reg = reg | FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX) | FXOS8700_ACTIVE;
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1, reg);
 }
 
 static void fxos8700_chip_uninit(void *data)
-- 
2.34.1

