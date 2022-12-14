Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD964C2A1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 04:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiLNDPP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 22:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiLNDOw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 22:14:52 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2072.outbound.protection.outlook.com [40.107.14.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25FF27CDF
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 19:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMEdhUyvYKnUX4/CFb+nptiEwoMBNkZsrwVEsYscwppd+zp8eiK9kPO19SrhK6/OYzNf0OQwvXPhA0oYaeUBwfRaJi7Wr5aJM2zkAe92b024is/4LxlG/7NDtbL3BXDT0q5Gcw6ErRCy/VondXHLxCoA9wHOQfcaQv124dJb9gg9L2d0qnR4FYIzYLlN2WywOwyEVuX1ytsFUnQLAPaYvZ1GslMWsXjIpzW8o824xPL/Vfem5dOmlvtOvKXKdHMml/G0GlBigEMRu6n0zNaKOl/VgCMPhqwRxkMUYL2V8QNgfiZoUQqAZj1gyK38zRW6wejOxIClqiYhsLwzLD9XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP3O1J8OSmjKxRgetyq1XE36/65/3uWRvh7n4jlxSyQ=;
 b=kXYSI/EVN0L3RVNon8h+eOkAh1vHH1uFcif7dlE5eFmYafrLhLC6AEp3U27WebqhLepzDNeE+SHXI10NvaVY40HPqHTTp78tEgDaxOvQHQVlx6JuIdltqAzifWI/a3SfFgWd7HewFatRmiPKnq+xJJGVpRVyrBwlJcTO6OJBgdQQEPEywQmK8fSWDQU1s9BKbDSDVsIEsDdPbg6xeN2VDtx18KN2R3IZsL24OXWFttrKRnWvrKae1G++t/npjKnAj+NMXIqkhC4TgVHoM9mKTPczY08NkHNw9pHAulgTSBOZ2Sm2Zp8LBd18jbX+lEXrozp38qDSPb38IUXE2Qkwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP3O1J8OSmjKxRgetyq1XE36/65/3uWRvh7n4jlxSyQ=;
 b=LvK2yRWOzxEoIYn6MNzXJujJ15Bq2Tx7fzqS6sTU66qn4UJObjjqyw4MIBOAAiMSbTxrObFMtAuuSxaUXTiLGIBqKz0aIRqnJzRi0R6otg5DDWkZSxTXwH2xlvQfcFUaPQwGYzRdhP3xMNyFiNyQrEE+CNfVMSXMX1UQv7UeEno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 14 Dec
 2022 03:14:43 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:14:43 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 3/5] iio: imu: fxos8700: fix failed initialization ODR mode assignment
Date:   Wed, 14 Dec 2022 11:15:01 +0800
Message-Id: <20221214031503.3104251-4-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214031503.3104251-1-carlos.song@nxp.com>
References: <20221214031503.3104251-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3e244f-03b9-4455-94ea-08dadd81589e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FneJ8hOLkCW/iQuMSEvIF2jXxnAcYevn67o3yy8tqE6eTE/VCC80deoqYtcQbSaz44jSn1LmLYGcHcWj3YbQdrYxeqp5vxEQEKI2tgLJoD6ZLwtwF54jvknM+22MmobFnIGN6NiSkA6ZPgOY7tyeF0Njgukn2PjNBYQqEexSZ9APYI38KQ1UgZhTMZNgBuvkLEbHWJR2fIwODSsEY/WBYwij2iREfXjpK3VUhJRt0/CVMYlEhtagbE+sXK40ts9S22fhkukDsu2pi5/iZLshzm+IHK2E5kdW3+sEVzgpqRh/gThHXOJshAXFN0CJki4XcRSfLrsBSdAkkXuuDC7LnvT4alQAIkRTUd1A0r28KLEMOd1plmx9sREIKjmIYhlb5Sxy4pHRgJqAlH9efzg4H6ynJraeOkogIJ3pvl7aK6Xsdgiy1VXE5tUnsVTtpVIV3FbiaNU37DLzhcHKO2O7QqDFzqlrasWMJ/zvu79AzBZT30iCYYOA0KCpQvX4ge1w5D5Au5sGVfLBUrBvUnZXbZ5Nrb88PPmHwd0NVJwZQ4pcakHulRj/AVnLAzvTKNzjHzYq9t6BUstO19bbM7Dl/kSc/JWrFsPB6hl/zNfEzYhJVahOiSvR8xnn1CCdgXgEgmoxR3IZf17LbpCJBEUgKDAdFbVxeW4qDhbBubshLPzBTqRsKwEWu0FINRM7DAk4oFL4wc8l0/po4zsfZU2FTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(66556008)(4326008)(36756003)(66946007)(41300700001)(66476007)(8676002)(316002)(5660300002)(38350700002)(38100700002)(6666004)(478600001)(6486002)(6506007)(186003)(1076003)(86362001)(2616005)(26005)(9686003)(52116002)(6512007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMAwuAJXUAaqyTRiCZ4Qh+crT0L1EtXdeZqrPmdWOp1Y1Yya7Me0X+xS93qI?=
 =?us-ascii?Q?j9azb/JGI62zheSB9pa9nHlhOuJB6bAsOhd0Jp1o/mXSpY/Fay8pCEl86J6d?=
 =?us-ascii?Q?CCTrRdq7F76/RLLGjWOi8YQs0o/tOdVJhmZYr3LZB//3ejBuTKtGj0hrKM4U?=
 =?us-ascii?Q?/FxjhutFI+FbARKfw4STZKpd+qGZRE4oxtWed1X+deXyREDig90Bwwt4MliL?=
 =?us-ascii?Q?WRDaZG7SIVPOss3QLyDVQ+NRuEey9jMp6m1SXSWkds/GOWwdcAaSS+To8mHq?=
 =?us-ascii?Q?WND8PaeyhA0LUSiZYMGt1b7EUCDdk08S4pwmg5aAZviUziiwK3SzfNzslHcq?=
 =?us-ascii?Q?CSWa0xajh2nT/TPCx3nJKMBWPdwrVvIXa3+X4ErAkczBB9llitJ+CNN+iEg7?=
 =?us-ascii?Q?aEspzkaP6UwMbfgh8ovAH7UhM06I3ZLejkXm0ZhW0P0fj6I3L1wOMcMlsRkh?=
 =?us-ascii?Q?B1G00SnmoDTFeeoi1Za6f0f4ZpqpL98wrBAweJhsISsq4V4ydsi+rq2zdRX6?=
 =?us-ascii?Q?+zPpnJMdtyXVn2z1mNj83tP0LEIUTv02v99Eud63bNwoRjLXUQeTf2IFzBtZ?=
 =?us-ascii?Q?NocsHWud/AwomPlTCxV+wuMk17rAAFzHte3pBR0u89flE7YXok3hvCnWtN94?=
 =?us-ascii?Q?zCPfOS/wRLjm81bel/sejF3EDF37Ghbl50A+VyJ6huNJrWLcD9idsQZiu4g2?=
 =?us-ascii?Q?F/8NwT/x65PQrrgfLtu1ahAZLMIaBUvpuDcX4DsyHeBUmmGXjcEl6SXB2xLX?=
 =?us-ascii?Q?7Bgq4iGB/lVspM8j5oi4vF2mIC4sx9rdbl8YDX0WRxRmkvilNZwknnFh8m7l?=
 =?us-ascii?Q?/NszKSkHAJP5woFjuoM93cd4As8f7jvnmDjl0eWqDi/oZyN7JRw+v2gf7w2P?=
 =?us-ascii?Q?K/N9WHqfBodEdRTRh0vCO6QMOu/y3NECmGoaGf+ACquFTkwsFhIuDnrsqU9A?=
 =?us-ascii?Q?hAzWR9wIjOLUR7Nqzf6T70f8Wt2yYib/NQDaXCQBwIGTZ1WChp4Xoku1cwNt?=
 =?us-ascii?Q?MAmrPjDkFHPxJEMvwA78Rp2KLWymnjSnwEJPWcuESFi5m/fz3qLe7pHfdLUR?=
 =?us-ascii?Q?U2Z4PGvcn59bX2q89Au7+W3enR3TyVEjZU0f/qvB+OxtpkqnM7PGdu9z56Nl?=
 =?us-ascii?Q?fxEPdhMREsNReJC8zrLs5QZ+K91XpmVz5C9+VCS8px+tng/q4DF0zNMM5xnj?=
 =?us-ascii?Q?Nk2zqO8Jhvl/UgtM1z+Kj6H98ZUZVYKi8TVIqdRzBRjeokS1a+kH7wWAdkPD?=
 =?us-ascii?Q?m6W2f0L/Y1fyPTBVQXuKD9Ri20iInrdAXg88sIrnle1V0vcJGqmqrA6/TT2L?=
 =?us-ascii?Q?XGfW5qRSdziBXbG+Znw0hDCZpxbv8gCO9og1SZlYtAuTcOCUKOTsFTcyBoiZ?=
 =?us-ascii?Q?DeBTz5BuRQ+4s6r7u/SNXherZbTxZexqDeZO22gwihP/OVst0JjpwjDRXUTd?=
 =?us-ascii?Q?bfgBi1zhLA9D/Wg1N2Q3ShjFRMBJjOAmBWYUHs9+rvXu8kS1+8Xv0E1kfIh4?=
 =?us-ascii?Q?mOOR2x6/nU1m8ptORwbxZdruPwncNwRJ/xSG9Fh4BU66VuncviTZ2ftNTv0D?=
 =?us-ascii?Q?vz0TiWyIqRZtfM+dOtNAla3JNaBUYbNhV4cLHghQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3e244f-03b9-4455-94ea-08dadd81589e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:14:43.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9VjOfY4R+FrQDHkpYMQhqPtMw4hgi60W7AZ05BZtK5DK4BVlFkjUiMNLnH3KVYMb2EhcGx/HQUpSnU3V49pIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
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

Changes for V3:
- Legal use of FIELD_PREP() and field mask to select initialization
  ODR mode
- Rework commit log

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

