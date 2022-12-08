Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D968064699C
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLHHTD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHHTB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:19:01 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717D142981
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:19:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzUKWId3LTE3Np9rtsNZgMXeNrEJv05Hsuz11Po+mCgAFp77+rHhj+yZMYQbToZnG+cx7UasTxn+dwby7je4FZmOk66dLu1+/62MWhnJBsHJr/FwIrNk8yC/g8MtEfAd3nmGF7ExLuTXZva6koadNXk5j/yoTkuVuV5W9M9N7H6/lsPGRa5oxrUlmOMtMcAWFiXvbAmKqVX+iifOjZE1cndi0F8BMhc9BnuJvVDkTOBc714Xdt2SPGenCJelnzQq3EoH80EwT0u0gwGTLbYuxTeg/JLxs5feyNxwKvubyYtr27AFl2r3uK5XYBpzOJHhjgvvw6h8+d3IHCcqcf3QuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FowuSuIfGo3KDhHpJJ0HCEsTApCDSLbXbgHzBC84uY=;
 b=F5IKlGjVrBxWcGbGpBUb94C1lLfCl5HfqlcfQivQsAxsfzYeDnl8KpPD7S/9048iHCIgfzy36/KrVncsOQEXxJo4jc4Hs2pFlhLzHhOtw8xEyQg/5hrpdYpH7e5ukqXBZSLFCD11Jn204TqbJK6jpJrUJ+OLh0JVDK//zM4lZeISLDlHSXYWqHheYKSMODYZcaYrbKtRO25MJM5BvvSQAp4o1QzODgkXCKBDI3gIlo9V041BEtrOx79RDHDSUoCNvvqr/Vq2/EPBHv8mzMMAXOkCTdtit+8wsCm6Cks33LLqJ7XBHUPtXshQQrET258waX3NPOE/B2RM3/5jyt5tjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FowuSuIfGo3KDhHpJJ0HCEsTApCDSLbXbgHzBC84uY=;
 b=Ce/j59LM/R2xmXQqSwfXKIWIoj4GR+slSN6OKtDUTMTu64bNCOtMOmWMqvkBNgIxUpHnuxDNhJIJhkwoH44SbETDqf3AReaHZnJiY/kK0ARenYCfoBrFlr9eQk7/XQf9R8+//i7VZHV+6cmSuLSw6ErREI8MIWqh+LR2TcYdKSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:18:58 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:18:57 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 3/7] iio: imu: fxos8700: fix incompete ACCEL and MAGN channels readback
Date:   Thu,  8 Dec 2022 15:19:07 +0800
Message-Id: <20221208071911.2405922-4-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208071911.2405922-1-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB9PR04MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c775b5b-92b3-4648-8cf1-08dad8ec78ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHeiSDX5C+FiEDEe9Zdj6mv/EdL3hgIhba+g76OkWEGGmHt37Z4MfNtyHdbqt64zACqmcR7urqjzdba5qu8u2Tp//AZQJL7Ue+d7Qzqlzs8l415IZ8bUGfK+Z7HtJu80iBTSMj2QI9voWUAc3kcROBFuilnSTE07DcKL8XuGs/0mqPKeMMF13Ic231j3JcZwV3Q730gVPcuigr4WY0N11AoFVI7yD/oEmPMTtx8YlqV47JiSQkrZGeWxR8+rHpoG8AB+NuBGSoLPS+46SPmlkzqafs6jOkf5u/byRjk3JjQWvXmD6VUDBPExS2rLiKsUBOW5Bl618R5o9Ze1cg3iULcS/xjeKf5Q9e+2s2FVSkqGs8ptzP2OsOVsCCbyfPXpj9+BLe5YAb8u3DJo3Jv3GhRtUecHDViWdie4yrjkBKXuybuanwWGeM9BOQExeKkSWW19YszU0NHn2oBJTGodU2GMv2Psm8YXg2zdhk33rOR5eb8LIup9fiVsEbhOaKUwD3rcORetu1Q27h4q68XUKTAy4QxqW/8ncnviqF00Sc2/OyEqTKJ8bqMw1J/jZef5pQ85twadekQObEjucR945eUZQ4UfXbB8h9wZ2dIMEuEiPX+hsZbtRqdBdBXZYOy/XCQLy/5yOOIRSjyKAW2CiNU+pIrTWxGLwoEPoNgbbyWa3c3x6lsUsfVoucIu8IPq0CUMiEO6eJIYvqw7MQZm4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(83380400001)(2906002)(186003)(6486002)(6512007)(1076003)(6666004)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9Y/eTprOqO4ErKWwuVPwvuS9neGh5v2BaqYDh47Io+ySllzMANZFLGHiNnU?=
 =?us-ascii?Q?fRRCa0gge8X1eOC3hPv68gXCdxk4zjWNoF3j/EgQ5jk3+wnkhBBoyistAm4s?=
 =?us-ascii?Q?tkmDcQzpHXdI38UPp9JPjgRqo8ZHzgjjccrsBdEaHLbcNoudwMQW33YeXsP7?=
 =?us-ascii?Q?Ew+3A9tcWqIuu4O3SakTVKri8CsSLlDrxCT6K9bY78lP2k7zbMEogd6DgRHs?=
 =?us-ascii?Q?MOrigGbaOKApm9E8TP9DsdOAui4fhQjUWsDnWVdH2dCw6aX0KnIY8ArZw+ba?=
 =?us-ascii?Q?p1uvwzbrrNEPDZG3AifYwIoNpJSvw7n7dBYAzIk2EFsJRFHPRtrDrPJ1VxrR?=
 =?us-ascii?Q?9vF38KuIEQX+CZIMJOy1O430hoxRkIy09N4lPYWYgee6SSD2Ycn2b8LfCDuL?=
 =?us-ascii?Q?g6AwElWWTgr5HxhpNxZuHCA9UzzqPdsSfUbU97vEDYhhmhZ6CZauNyw0wqOR?=
 =?us-ascii?Q?3p2ANedQ3+5wYh7mx8hYkBdVTH19RYO8j+S2L24UyCSAqK1bQc7M10XvOy80?=
 =?us-ascii?Q?PKW4CjrbLM7+fWXHU8igRPRFoAKpWAe12bWBhvVthM7XNdVt4eGUFpFlWEDb?=
 =?us-ascii?Q?TqAV6+vRRSQgWaQtLXT4Fris+rXcmWDjz8Mx5yLi8AgLvscwZMBhxEaUYZQO?=
 =?us-ascii?Q?mErpBj6EV74bE0Am+5wi0fVpXjBRc0OUgpyvLmRBC7QT8f1hB9Roe5BTGG+d?=
 =?us-ascii?Q?TNvXLvp6bG67CiZ0t1KYXGC0lpnugb+EWT/p20FaRLe1eYx4mG9pmWx/Iy5o?=
 =?us-ascii?Q?4kwXhgm5+G7FtnLS8ujs3vzhWggjUXuw+saSDYxThlwugWbY+SY/4lcxCztm?=
 =?us-ascii?Q?iG6KTXPe45snRqhRc4EEhIPkXo0x17dvoxkNBP9brJXxVR7zPa6mA6UsTcKi?=
 =?us-ascii?Q?BReVVyGQ2m+AppMWj3emkic45GLNONO5MZZXavj5Cw+LSvlSX53PXFjAQF5t?=
 =?us-ascii?Q?iWeLzqU5jh92o5psgShtrl5CE8hr1JR+rKFLlfnoBEOm+GU+VLaqwbbWSpkN?=
 =?us-ascii?Q?ZjyZCwCAfVpH2sXPwvv4BpHI1UVfrPZt1sPB5a6Wx+VqWBYBusu0ngRw6/aE?=
 =?us-ascii?Q?l0HBq8Q40lWDz+GZmat6YQVaPV2PPzGRQS7pkfOYjx97ynEj+8VEYvLGe6sX?=
 =?us-ascii?Q?Kn0QB/5TBx7H65akISIYHrKKoPc6/azPpdwj36Vyf6cpgN5pouaCACSWE1+r?=
 =?us-ascii?Q?6JW4eiIeWoEt363xXAW/U6sZcoYPyAkum3u71tCw9FbnLX/M51LDWeOUmlcR?=
 =?us-ascii?Q?GtT3ORFBpEX7ey8Z2Kp4nNQAVol9pvNJdSpm1kQxJix1or02NoVFkomWpFGR?=
 =?us-ascii?Q?A3kD1xH9RLlEAeHDq36wFx46y/XGfzU3d9GJxb1Fd1cEmQ2MI5k2lXGMuuf/?=
 =?us-ascii?Q?7L5I6hI59hC9SZfC77SLkzim8im9Ak2maRwc/jYfZgLuyHqh2/jz0aVZmV+c?=
 =?us-ascii?Q?B0RFlzfhnqcAELjiAGbR9zTdlmrXU2SCApxDQxAmulL8Qk4fjUSCRT3BNWGP?=
 =?us-ascii?Q?UggIJX1zK9uNZKlA+lvzmHqKqIcsIW6qwuj8KAJo/qjdT+SWj3KYLqb+LE8G?=
 =?us-ascii?Q?4thUKOAdyEcvATHSPOt6U27UIxtCB3iR7rVi3Wdg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c775b5b-92b3-4648-8cf1-08dad8ec78ba
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:18:57.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2ruhjjy85nKTCa/0szdD5u74tD6/I0suLeb1j2cGMOxBo4z7w03yyxkWUl0c7UYHqR+VLIy7jRh8BTfX0na8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9701
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

The length of ACCEL and MAGN 3-aix channels output data is 6 byte
individually. However block only read 3 bytes data into buffer from
ACCEL or MAGN output data registers every time. It causes an incompete
ACCEL and MAGN channels readback.

Set correct value count for regmap_bulk_read to get 6 bytes ACCEL and
MAGN channels readback.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V2:
- Reserve the global DMA safe buffer
- Use sizeof(data->buf) instead of hardcoded FXOS8700_DATA_BUF_SIZE
- Rework commit log

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 977eb7dc7dbd..b62bc92bbacc 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -414,7 +414,7 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
 
 	/* Block read 6 bytes of device output registers to avoid data loss */
 	ret = regmap_bulk_read(data->regmap, base, data->buf,
-			       FXOS8700_DATA_BUF_SIZE);
+			       sizeof(data->buf));
 	if (ret)
 		return ret;
 
-- 
2.34.1

