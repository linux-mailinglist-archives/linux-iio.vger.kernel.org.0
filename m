Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F466404C8
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 11:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiLBKfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 05:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiLBKfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 05:35:33 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99FDC1BFB
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 02:35:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF2t+O4nt59z47zq6EcMQMS4My5Khc6UPLMbw5k8tB6t8zy3c9gJKYT7hff1LcrVhvJAN5l7uJbbX+U0KKj3J8XMRHJV7bL2MoYiPPMv1XmLQY9qdHedBp7OGSBRhQ67kwrDSQfdzbgkUEn8Jiv/o5TLHeBw5l9w7vNYOAxoO2pA09HrmgdPUIGdC8M/yaAKN4kPp7niJQKqB4u1WcoKefihCY+kb0EbLWEEMQRZ+03n9hnImEdmEUoSCH0V+piE/WctFMDW8ZLojiB1Oy6CQFt6Tumlj3yjXYC7KHK1ib79bMexhl4Gep1Dr0SOEvHByIxSoTjChao8U3Muad3nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVz7nqm/dKcEPdDtwgDZli6CzUnJMd/+bWDe8bEEX/8=;
 b=lQr7Skq636rBMJU7wlzikOOr5XpR20WTlo6H6sGkcK+5/zCLI5m7/r5tgns7ssl1Xg5b8U8cFP++jWdCkKx896ZMib9K7WFP7ayYlE+fiM9yYaJeI/7qD0Q5w38L1HcUc0omHnNMzQhUAduTbKJ9l9Azs2uxqqfpIhT5SonrR/ndiR7WZ+XNdDgWOOkr/pWEN5tPhfu672NAbzAegUWyY0RUgCGo2HHigFH+DysFB+xzP/GG2BatNS80AefcZKzEM2Hlj4f1ACTHdr9VnnnVpt44vX372A08emMIVpCtrhCotjqoTnzlTjUlcyJd+NWCxdFwDa0HdAJUS667AqcEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVz7nqm/dKcEPdDtwgDZli6CzUnJMd/+bWDe8bEEX/8=;
 b=Aq0ZDlYWRkNK5GYotnpld/1WWWVODD83KY6FV1nhxoSHSwsYJjngUO3IHx+f57XWdmf7l7ryegsNBx3HKI+z1aP0kkj1UYAw/SiKOUWtMr5p+wsFIri3iUntTp1h81XCysyWneNHIUxwZ/umZWWAn5gGCLSNotcSaKZCSwOTpD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 10:35:30 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 10:35:30 +0000
From:   Carlos Song <carlos.song@nxp.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/4] iio: imu: fxos8700: fix CTRL_REG1 register configuration error
Date:   Fri,  2 Dec 2022 18:35:36 +0800
Message-Id: <20221202103538.2218925-3-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a38b46f-6322-43b3-4ea7-08dad450ef12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bXBywmIuBMLr+WY4byUdECN21v74lznJshVUuFKVpz8cCUOJ36xyjaU5NRAaE6Gq8ZgtRuy0xHIWpAZ/SXlVI8REWYl+RJH9+c9NANdRm5Tp3fR4A7PJqEk6p3MfyI08Zexg3CyI4rMnWbsp8ppUHc4WsebGMvLWnmHQJX4DLWqfTF23EKrq82St+6prMuMT9Tzm8s7OjTSqNehoKyGcmsGvZscKtRxO7rEtehbXTPxhF/cRgSPviS9/TmZPQwTLfTMpfWL5ihoNnChzVB2EPhcLV6JbEUUO8biztpFDgDnX+uQKfBsaKwjcgJDk3SZYShyNk+l/ctaABu7vVX6LVZUcq6RKeOsvWeuNwE2KeDqWAcp9A+KEgfe1tc9fMISc/+av1U3rvVIPHRzN/gTjdeO2lK6Ul9ioorIvIsE6uZrQpE96JLBw1V/r+Tj3SX/6twQpoyVuRm4BooqFgJJT7SOWqM/FHU6stiCczagrcTXXp7hqRoMcszz0f1jxH7FxKZkcxBc9oXLdTrtpV0JbvEGG55g0CCD7DMgb7kQdGb4a8d4vrNhedjphVweHXWU7NJ3NcWpRJtWufplEnxnX0iRpltEX/ZEaG48saBYHhDpnr940JOPs6LchBGZ2gstcgReIy0gg2F96mJ6WIdvP4rnbgJYAOB+Fv/JxVBDRA1jZOXyGuE3ls0V41fB19rdrGgl98EkOye4j1Q3JTNzjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(52116002)(6506007)(6486002)(186003)(6512007)(26005)(316002)(478600001)(8676002)(66476007)(4326008)(66946007)(66556008)(2616005)(41300700001)(1076003)(8936002)(5660300002)(44832011)(83380400001)(2906002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/989SJrny/cZM/WNl7x+JQinV+xZ1qslCN45+Ggm7Q8dPjH0dWpTvprEzhq9?=
 =?us-ascii?Q?IwwkNwXwUhQTDHBLGiUtVoS64teu2tqrqNCG5Zy2hAzOHJrp/GHVi29JZme0?=
 =?us-ascii?Q?VHdsoUQlgDN5ZQvhQsOyDUizQhQSnyqeQRTseBOlCE0HBz8cbB1LyNRc+zBo?=
 =?us-ascii?Q?+SaRUZ8sBP0Yy7IXfs75rTEuRE9f9ZF7fhbYo+wuqVGzbMjKAMLqQY4uu+g5?=
 =?us-ascii?Q?L5yTVcJvF6qb4T+LHd261SQqXLQd37J0SyXvcVaULsCFJq/BELsIGn3anu4S?=
 =?us-ascii?Q?uuk3PONelflAg58C6qPPblGCamb4aeqOXwegyBoUpB3xG+8lSVvTKc8u2LhJ?=
 =?us-ascii?Q?v5UHKYAzvC+f7UPo2d9gfOqqkeN2GITK/TsL8b4mfjfXcxXv84jyjjTox+Br?=
 =?us-ascii?Q?y2hxHVBfGHmRuzEj8rQM4UtCwHYl6GdCT82lwj5cUF+WipvXJAqD68EpKvcW?=
 =?us-ascii?Q?jVEpq0RTZk4L45ON9PUVwLhYtpS2lmr7Pj3RbzBBeXqBkJdmFIRnb/f+2VO8?=
 =?us-ascii?Q?1GO8KiY4pk+Lpr4MKXzAawif+xCqGJmOKCbm9qhbkTLgSR/c9oa4TqSstlkZ?=
 =?us-ascii?Q?5QkRGU8tbI/1kuCFTYxkkq4jqvxTbe2Ub212VsUaP7jA17j14X8a2N6eg4le?=
 =?us-ascii?Q?URX84DfixWYeAcb102Hnw3WHib6upBwFFJOYu1y8nTwDu9OcAPUKs9xcrWUF?=
 =?us-ascii?Q?zEGWY1oJdgQ+TBKZuYtgk83PTX3qnsx5IW+yJmmG4jwsAG38tYpM38QnuK9p?=
 =?us-ascii?Q?OffTGkV/1WDLVFhnHD0Qfqo2I6aYayCO0BGILRVPcKyCDAdCZWOFhiInwK+E?=
 =?us-ascii?Q?PKyH2A6UV2tIC2ykk/zj6k1k0F5kca6/RrrTEEVlIaudq08HtkTrcxhuHv8H?=
 =?us-ascii?Q?IZXnwhWgumhBexX+Tgu/AEpHhLN6x1YRU/a5oR+qXD8lncVORAg9vOr91TO5?=
 =?us-ascii?Q?B19dfE3/aM1Opfneg4WKdbirX95mks7jRrMr6943rVsOP0sRbQbGHXTOBTFK?=
 =?us-ascii?Q?MHSqeyeNXB5rU4uvo9PD7kL+SSzijnE0uudrsvOfRgbMVEyTw3c+7CTsSVgI?=
 =?us-ascii?Q?XMO46d4FHvxeLkObTz+wFOlMXBX+mpRmjsgbnvzyPLTVSofk5eR5wx7bpeFp?=
 =?us-ascii?Q?50ZqTquDXYUJiiIdFF6PlFwTCFLiR997VxCBf00JtgJeuRcj5MbVBLjLy9ug?=
 =?us-ascii?Q?tOnsqecI59Mt7vQbubN2vAun7IGB3i3XQvmbcb29kKcOA7fokNuiK4lamftn?=
 =?us-ascii?Q?MsXNER2nyotXbDe/Olf/QC9N1gP4FkiV9fBkO+SvYX4ltSK+wzIDQzNs2QVK?=
 =?us-ascii?Q?/jJ1rY2PaHS3X0cK4fd9ISMRuExTqu4N3BZjWlJAzs/7qBHSgiKwt1uA4+VG?=
 =?us-ascii?Q?D+4fEFGyj2jjRBqHAmR3BbW5Tq6VolXJCqyXKe5qtzQ3DSWZ0Tm7Hz4kdJVl?=
 =?us-ascii?Q?uQFk4+bDGedxQWqxXMS3nAQ9G4PC/Wz6DOFxZ+AkLH+xNCqlF9GtrkV+LzqK?=
 =?us-ascii?Q?tFkZxW6TCUpbT9Ut8dc4kdQiYqBE675kHqMa3BuydNnRhecNs6EDWAKnK1Ol?=
 =?us-ascii?Q?ZbPKS44JtF0ZPLTKRrAoq1xY6rJHZU20pFBSQnVe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a38b46f-6322-43b3-4ea7-08dad450ef12
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 10:35:30.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toSLz87Gx4TENjUGhBq6LkOMTrZzoSg+kHh9aiyYiYxYY85g7Vr4mlbeolmYaU+5i1MDShACjpDcM9tz5AvWlQ==
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

When the device is in active mode, any change of the other fields within
CTRL_REG1 will lead an invalid configuration. This not align with the
datasheet, but it is a fxos8700 chip behavier.

Set the device in standby mode before configuring CTRL_REG1 register
in chip initialization phase and setting scale phase.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/imu/fxos8700_core.c | 36 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index a69122799892..60c08519d8af 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -343,7 +343,8 @@ static int fxos8700_set_active_mode(struct fxos8700_data *data,
 static int fxos8700_set_scale(struct fxos8700_data *data,
 			      enum fxos8700_sensor t, int uscale)
 {
-	int i;
+	int i, ret, val;
+	bool active_mode;
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 	struct device *dev = regmap_get_device(data->regmap);
 
@@ -352,6 +353,23 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 		return -EINVAL;
 	}
 
+	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
+	if (ret)
+		return ret;
+
+	active_mode = val & FXOS8700_ACTIVE;
+	/*
+	 * The device must be in standby mode to change any of the
+	 * other fields within CTRL_REG1. This not align with the
+	 * datasheet, but it is a fxos8700 chip behavier.
+	 */
+	if (active_mode) {
+		ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
+				   val & ~FXOS8700_ACTIVE);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < scale_num; i++)
 		if (fxos8700_accel_scale[i].uscale == uscale)
 			break;
@@ -359,8 +377,12 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	if (i == scale_num)
 		return -EINVAL;
 
-	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
+	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
 			    fxos8700_accel_scale[i].bits);
+	if (ret)
+		return ret;
+	return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
+				  FXOS8700_ACTIVE, active_mode);
 }
 
 static int fxos8700_get_scale(struct fxos8700_data *data,
@@ -607,14 +629,14 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 	if (ret)
 		return ret;
 
-	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
-	ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+	/* Set for max full-scale range (+/-8G) */
+	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
 	if (ret)
 		return ret;
 
-	/* Set for max full-scale range (+/-8G) */
-	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
+	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
+			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
 }
 
 static void fxos8700_chip_uninit(void *data)
-- 
2.34.1

