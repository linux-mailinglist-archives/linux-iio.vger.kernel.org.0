Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0817864699E
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLHHTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHHTH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:19:07 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7274B42F50
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HniBAOwN5BwwHirlFSC/P0MJ/91HimmJYwqrJJKeaJFhwhaZP4qvpeV4VpZWu22gqDcZ5t3iBuoY+g+9RH43/gWB6e3ieIj4IA//Le6dHuBboDUVU3+UZWkNOPxy+TYsIyBq+oUgtWu7i+buuU331g0urfrSO4HK9cZkMw53gnPALf+eJp08AQhE/FjkJomxIdHOuVpKUWuaOBIZlG9udvT/0NRNJd8nTIzdTpr+koN9d7pHwTwdxtqDKKrQsgCzgw2nuw3pTBAqXwObMed3Smidp0FTf9xiSpokec2dURJYwUhSx5dWgCw/u/OTZcM80TENug+RKPYil+rOYXUIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc0hTKImr5D12L+lvYZ3cvDQWrLfTt9do2U2aoGl8SQ=;
 b=e2T0DGCfgofXeUhuLERxGbvU/eQ7VjtKkU5cJ19lJssTBhVHQIc0GJYipecb1L/Y82wONQL3tZx8rkfG9NIX/12BaMkfx3fL2+WVkljHXbriP47P6ARKGfSXM8hxl/Wa/CimM9h5W/7C/PvdsttIut2Nft2LHHzT+rRhDcSO3SrsW6wTT6I7G3+mzCso1q2xaOoa1a63baITirUfTQ5RYbgmc0KxtO0lli7RyPpY7mdPRxGeI7MKIGeRnQxQt8x4Mzcd8O7CsgsMpQj6O/iIkEaI6imXv56024V6v3e+0i+lbQQUocz0dhDLQ2PSukAtqCjPVZ2G/83AB1mBHtFhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc0hTKImr5D12L+lvYZ3cvDQWrLfTt9do2U2aoGl8SQ=;
 b=pyUEnhtMMXVTtqMJN7oeC4BMxM5vvodVULQ5zj7X8MmJIlyb09BzshENzDbFYtFgtTWWYU27xL+jOH6f8ABBUiMmwl+IYcbRYRL4TixUjgGdLigRNdAHC8NgVNdx1g48P+9XaI3t2UCYagZEsa9KIDsTeIqEXRg00uIpa8rInkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:19:03 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:19:03 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 5/7] iio: imu: fxos8700: fix ACCEL measurement range selection
Date:   Thu,  8 Dec 2022 15:19:09 +0800
Message-Id: <20221208071911.2405922-6-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b892bdaf-508f-4a6f-1786-08dad8ec7c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgPZM2uZLJFfk3spIDWfQANPQMjP7Yterq5agjHCyP3yP5INGUjkNTJUSIC2sw/PK07V6/t7hvJIr1b54RawAHiI2YNr01VW5D4QEKc3ZYfhZJE7JJlcnEF1qvjMeDe0s4CDaVEw8FjryAvVcXRe92X7ZRnpB9Dj8Df4PwUgia39XXKqvHvG1QJCM47tY7Opg11QMuXkuZLjeQH4bucGAAEZFWx49s/yfsGBsM2qChVuKaX0XCCCWjxaNdld7aTtNwPR0fxxHnY/MDg8TjzG2rpEXlhR1mBueAlkpAag6n0FLqt+bjLfReaXeKoaLNIzJsTF3jam/Y7ZgqYOVTO5Xmv4ZTuXE3cFl+wLwrIEO4W5B1O6XUMHSx9f2qQgTEXrbNYPu1Q7+p9qbrCZsyzAG8+vS0UBNSrL+cg+0mLUlKirbWz0eULbtVzc4AQqGoPXwO8i/dNfdDhL81g5gQI83Lfuv/QqnHNGLPxZQUlhkB5K/HrXeDjutzj+MgjebKKxwVAePSPDuLK5vZTkS0hESxRir+kK/Xw6OflHGh3YClqZiM7R6qPtCFYnjKRvgHR/gG0YMvnsitKfIZwFul2qvm13/87x9UfIfETqe8a6t+HBrIvIPncJ4n2FDr4ZucJg/bagISqAKqMV/9Ymr3xMNAgEw3vF9frZQp3SDnWPbrzxbi6g44Y4SaIYpxkgoZUMChX9V/hgLx8n4v+brmkRHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(83380400001)(2906002)(186003)(6486002)(6512007)(1076003)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dboSrW0cIkrAdB/qqTlP7lNCAMgu+jD3Igu3Jk6cx+/Oh+SUwjJtPmKs75Fs?=
 =?us-ascii?Q?5VxzsMEoSvge5bDBbYRs1yIw+ncyzP0eENsU6mT7ZEfLbOcytC/yMuMtCgGZ?=
 =?us-ascii?Q?anAv93+ws76saC4lcpEEIggsdPyBaqyoE9PF/jeCt7naDAGKPtcini4ba6kR?=
 =?us-ascii?Q?cFvM0JOl6oGSlxy8vbl5wyhILgDwvaqLekr/6fjSTQIygh0Tn3C6HEWPV8mW?=
 =?us-ascii?Q?FdUCbqqxsDCQFX2/jWZqdaJ6qLauV715cIAXXSynlM53zPBnuZ5r6bctDaxw?=
 =?us-ascii?Q?0el+dIi6LneRNH7tk7h0/N6CSpU4Yc2LJY/lEI8zGF3qH2FeVjnR1DP7rQi1?=
 =?us-ascii?Q?fOqAFVyHd3BDPh7qOKkD9dAToCIOzi7Lfq4laawW7N8Q7Ua/mQiN3vBDUeX2?=
 =?us-ascii?Q?8HsjFfb4Lvp/+Colqdx1pTYgT37xbIv6oXThjMatLIid7yTShRJdYcgjuQcb?=
 =?us-ascii?Q?N1dWFVDnEDeT1ArVmbNlZrvlG9qkAH0TwCxDUQssNEf8fTXYory+LG2pTh3l?=
 =?us-ascii?Q?QBawhzDHjS0jKceeQ+xypACTjKv6tid9sLNfQjfHxGrYxMUtftwm3fhQaJov?=
 =?us-ascii?Q?POf/3REgqMmbgwECoes+viI0yoi2kP3imZC7CIBnYzawGl2OExCtGxrEsMMQ?=
 =?us-ascii?Q?1gT94kQKRWzvma78EGN6XeKNh7XzQrVf341UIZJyMCrtQZOYR0FzNVI6rUYZ?=
 =?us-ascii?Q?1gqR/SSUSJc770z6yP1kWMv3c39ggTxoaqkJDC5FcK1wSvP/dYl30bO1cJ+Z?=
 =?us-ascii?Q?QU4b2yLMlx0o65OSzVZlf278zNtSnd/rA+nizU4n/wtYqkiArUEzyHQTUdyg?=
 =?us-ascii?Q?6BUVE4cFaVr5+PweUNWGhZ6pz0wPqVs0EphNq4uZiwMPAnxBmzO4I693ZAO0?=
 =?us-ascii?Q?DE7aINhJIgOKkQsSrehauQnv8MMcJsC7r09Swpkq1u6hWVx0AYSY2EZSWkiv?=
 =?us-ascii?Q?DrDX8rJVpd+6/DtXyXiDt6Co+a9X2QwAO+U1VdDQPZiOxPLia6mZJNXICPJK?=
 =?us-ascii?Q?yE1sKythgIrpKJmOj92wO4miGr369ZdoJH4ZnsgLwstx6+NQ3U/aJbczhki7?=
 =?us-ascii?Q?49RN/sc1fuiDGWggwwMTAiD8gJJl2V+0N3UIkwFl+lhWP8YGwyQu/TH4SNkh?=
 =?us-ascii?Q?lHmzMa9QVTQfkdRkgnJWMM3Q2MDy0HYOv7O18T2KjaaMl1xTvo3KKxpvBT63?=
 =?us-ascii?Q?sT6xN26EAbyLlFgawT/1UOkyP/HPzfmt89i966oSfAtYlbQweq1A2u+qwoSY?=
 =?us-ascii?Q?QHD6UCZcAOn7Y1jsmzyRiIoMoj1tivnlg5H2mBJZX09FEQCGWhmIA73E89BC?=
 =?us-ascii?Q?r0cF7Ukcm4N7tawhhV7JGiL+3YBEU3Yf25K1WPkKGhGRnv4I8JEd+LzrBr8g?=
 =?us-ascii?Q?CzNSj6MHIkKsdmbNoWYX9d1TKfkozQtnnroyGvJixw++mKLrkdMis9FYPFjD?=
 =?us-ascii?Q?VWgnJ5UnBrSdKVtbaCqMKiwM7CY/rFz0apZuG46G6rhZHAP4OxoG46oaStZP?=
 =?us-ascii?Q?6KwH5TVRNYwilbYBGnr6u4uHgUNqiQkJA748FyZkigZNHKbrZp03cu1wZhSm?=
 =?us-ascii?Q?223Fkb3eS31DjrjwDCP7ahu1FrG1j1C8v8aiJwCt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b892bdaf-508f-4a6f-1786-08dad8ec7c42
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:19:03.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEhvesAlzu/MEEU8wtCik+ZiZJ+uvnztUNqdyc9tH/Q9ZPP5AL5MCRF/oZ3Az5m5W/S74sbasSjVoDVRAi/WrQ==
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

When device is in active mode, it fails to set an ACCEL full-scale
range(2g/4g/8g) in FXOS8700_XYZ_DATA_CFG. This is not align with the
datasheet, but it is a fxos8700 chip behavier.

Keep the device in standby mode before setting ACCEL full-scale range
into FXOS8700_XYZ_DATA_CFG in chip initialization phase and setting
scale phase.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V2:
- Rework commit log and comment
- Using regmap_write() instead of regmap_update_bits() for readability

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index d2e784628820..773f62203bf0 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -345,7 +345,8 @@ static int fxos8700_set_active_mode(struct fxos8700_data *data,
 static int fxos8700_set_scale(struct fxos8700_data *data,
 			      enum fxos8700_sensor t, int uscale)
 {
-	int i;
+	int i, ret, val;
+	bool active_mode;
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 	struct device *dev = regmap_get_device(data->regmap);
 
@@ -354,6 +355,25 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 		return -EINVAL;
 	}
 
+	/*
+	 * When device is in active mode, it failed to set an ACCEL
+	 * full-scale range(2g/4g/8g) in FXOS8700_XYZ_DATA_CFG.
+	 * This is not align with the datasheet, but it is a fxos8700
+	 * chip behavier. Set the device in standby mode before setting
+	 * an ACCEL full-scale range.
+	 */
+	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
+	if (ret)
+		return ret;
+
+	active_mode = val & FXOS8700_ACTIVE;
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
@@ -361,8 +381,12 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	if (i == scale_num)
 		return -EINVAL;
 
-	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
+	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
 			    fxos8700_accel_scale[i].bits);
+	if (ret)
+		return ret;
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
+				  active_mode);
 }
 
 static int fxos8700_get_scale(struct fxos8700_data *data,
@@ -631,14 +655,17 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 	if (ret)
 		return ret;
 
-	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
-	ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+	/*
+	 * Set max full-scale range (+/-8G) for ACCEL sensor in chip
+	 * initialization then activate the device.
+	 */
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

