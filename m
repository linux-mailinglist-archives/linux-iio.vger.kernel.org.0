Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D456574C3
	for <lists+linux-iio@lfdr.de>; Wed, 28 Dec 2022 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiL1JjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Dec 2022 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiL1JjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2022 04:39:09 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53DDF11
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2022 01:39:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R52f+FaA0QcrE5PgsZ/vCzQKJh4o9qku37vCsDAY1O7p1kGUBjcDXJ521INJ1C78bx70W+zGmQtgfioSrgeEThIEwycHJW5iubZic/fYQZpA6xCH0OZ9TQF0s9gH0YYVzEt/A9wvPeRC8clRyG5iCvcic3lv8ZZaG4TrmtyimHk+n5k50rPQ5t0vMGlrF8PI6MzIUQHojwyIHEl3N+B64cZ/yfIx4nCGeZPlvxodgBmp6rUrxMMHCoUMFeTrbnOHQNaqXckQUKZr46WunU0gBFxcWCuLzPx7D+i89G+K0z1joGiX9LsLJjebqpoOT0HfmgVAjz87R0nFmKpkLLLG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIhyZryQxFaQMbqpvTPAfPJDo2jCPPhJp5rmu/3JlhI=;
 b=kkEUr+vDZJNHtrcjzywhcWtDs1uNWlKmFShNL+1ytKVzo0DqCGumAaGi8IX/I7rWI7dIZYcuGvrTIqiLfjYYbBrjt0wC2uysFWIuajSQpKYjNl4psHRpt0OBHOOa+wkWtiq2aVCNUEz4KIKtnJ5I4h5SDJsKx17QYyKZOIbHa+RG0+cJMHTKHZ/mi+aqOy7CYgSTbTQ0t2PnN/Qt1uky8gkeMaqQCcxV1qR6IAunoLt2zD6WiOAtjbvdQjZk2sKxk4t21mQc4xz12QSJJ18AKytsLSqPx6LFccZSLsn0drtZbymoaFypzo2Htmxguq7gpHDDGZ4hmVtHO+hLBuN+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIhyZryQxFaQMbqpvTPAfPJDo2jCPPhJp5rmu/3JlhI=;
 b=knQbm4M6KbXJ4/YxgaOCBYT3XspIuQn3Pu8Jlx2VWCnGHACztWE9a2Elr28NfbOhjWCReV7X4+1fXW270jVk/YRhE5O1hSxxlBCgtwjit5eiJKE4c639o0yoZ+ahrQdTuTyDzyp3dEK+5HdsrXEQQzngIbs811tzEcsKV8EiAoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 09:39:07 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5944.014; Wed, 28 Dec 2022
 09:39:07 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 1/4] iio: imu: fxos8700: fix incorrect ODR mode readback
Date:   Wed, 28 Dec 2022 17:39:38 +0800
Message-Id: <20221228093941.270046-2-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d086c384-fc3c-48e0-c37a-08dae8b75dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQlOSp7MAvbM9jqvVyxbxJO7t9GlfpZgw1BHBbdd7zFPDtIeni6Cxzna23DX0vYUuEzt/oaq92vCz86IunRIIZDJ7hLkocjW1ikmCjOn58SuIMtLBPYoc6mlRrJ0TehldQI6UEwsFZz8A/HDl3MqOFYaP5F9/VoORqOMkczaN7icPOaM+aomsmw6EkdQDHtV0pnhsIE7JWbG20Pfh1cZyx5Gace9K7h1IDxkwfQixaq0fw0NDFwXwHiL9H8fx5oj/9DCiILbvNydTQGruF031hzJyUhGX6mk6XemSBoFbEUDp2Flxe9uvE8AmR+ca56XNvD5ulfeObNm3KopEhhyIeWvhRu4IdvQudCSfp5utreGJG71lDw9D98qPuK2WRzwnCJiJzWOW+DEyIvVnd41QiQU4pUHS+MC7cfX/5OEh7Y8A13uTuXIYeAY5p126ygzRD+1HK9cARBd9DK3+KANj4VdpXOicJLfh26riTuq2okIRtI5+1ZvQfuGnlUONhYFMIo4aV/lVCWVUYuORaRWvJI7VtXJAD84SSdOQ+KvvZrD8ypaMve2Kzmvp7GyVpmO4nxWuGbSHytqjDNm8Hz7rIGoTyvmRmdfp3fDffUcvAFtaPYCIF75SkGL5GD7EZwfRE92/iW6kY7OahSGHxFKM0V9uSTOiriFOsGnxzb7U5oT/nZcx77SB6ZaJLFM38dg2FvR0eUvJXVRRY7+Hdas5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(66476007)(66556008)(4326008)(8676002)(8936002)(86362001)(5660300002)(66946007)(41300700001)(36756003)(316002)(2906002)(83380400001)(52116002)(6486002)(478600001)(1076003)(6666004)(2616005)(6506007)(186003)(26005)(6512007)(9686003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fvfRCVm0KLk1KGqt4j/3KaM1xsdzqlVlkpGG4B5uPzkkrUZi/H36WN5IGsQ+?=
 =?us-ascii?Q?Kb+NPRAz0971e/D/znwknvhtLDgsB7VNXFtS17xXSxgBH2SzZT5auzsRaCJB?=
 =?us-ascii?Q?FQcs5cetCRkdrEP+Fxb/ZEeoBSz8g91nVk07KA4DqShW8DhqcY7XyB+lCo5y?=
 =?us-ascii?Q?vtl/erKIVDFQeeNBIqwv0BRJryzlXGLQyBwDUTIzx+qgEXMSCXStG4ufZZWf?=
 =?us-ascii?Q?4d2RPXnHJMPXNcwpa6brxWXRHS/+vZxWDhYE7LbIOOazQc8z4lTTnMh0Fca+?=
 =?us-ascii?Q?4RZK3tpZHGKuwjI7DG8u5OQ0993wjnUpmkrHwkL2GB9xLwtlyHXf9p0ptpPN?=
 =?us-ascii?Q?cwfZap+Ukc9a12qeF9l6miZx5i6E+GDP7Ml//0P1IsCC/w2++w7Z1p5wrv8F?=
 =?us-ascii?Q?y6QyhyRXOSjFViuK0GrkdIwDh9aFRIrVq+P/JO1s2UHkCN/kVY7fSq3MYmjv?=
 =?us-ascii?Q?cIYXo860HL1vUMJ7rhzlzdgEuKs+wzgJ0DqjOo/MtkpjbQ8eZy/+MTbjJET/?=
 =?us-ascii?Q?7lVB1c37GQ9r4dUiqTg6kVVcsheRgpOM0tk4xeGGg2CkMbCjjht8MLHTwBD6?=
 =?us-ascii?Q?shWqp+yTWS2Jx4hdJsN+bscl2ZdHjaAHtFgSYU3MIsWWgMEDodBkPhXSx+mp?=
 =?us-ascii?Q?NgZB+CdkTi7K9yGe5uNHiQaCU+wNsIU0c93PD6/jHFlhsmGWWVf9As84pKEW?=
 =?us-ascii?Q?8ydJRzBmYwg2iX2mSBIytNmh85cVvDiEoe0rudnOjCRjrzGvUl0qmMKA/n9l?=
 =?us-ascii?Q?eIeWbyais3s/FIjS1mJBrOUmfUNcxxRRrSMzpKbFVSRg6ZSR76E/15+xzj5f?=
 =?us-ascii?Q?T4GPsILKoA2HWi12TYpowc4Nh0WZzQh+s+LiMDPeky+mDqlcV+5QozdONpJT?=
 =?us-ascii?Q?j7zbI8pWAbV/sS7OvDffwtWUYdm6agg2gv9wJVW9uplLVescEDhV39kEX0Qv?=
 =?us-ascii?Q?FhGbQJ1JoY6Pdczf86DFp19efs/KiF+NLaA0XQSMeu7gky/vhaZEYgTWxrfw?=
 =?us-ascii?Q?htSo37z+h6rWEIsPD7SGValjgvKKqrdjkGBhvj93Vy2dNYIEKfP8moLQeMRm?=
 =?us-ascii?Q?udSitEW7lbduY6SkN+kYF8fCTqEHUqb6dx8+7MR3XKwAQj3WFn/P6Xkw8iKO?=
 =?us-ascii?Q?Ob1DdkaSmZ3aj+ahicZN2hRsSjeG6VJoXXkeTS5yanE11HdG//Qmo7wMNLOf?=
 =?us-ascii?Q?e0MQ5beicA7QHhsaEryU702yI86T33x7S7PSIEzn52drTkU87whFinWZqqRo?=
 =?us-ascii?Q?UmmXnhW382Fvt+AfShKYT9TQgV3lNoLTJnYJkYNW5ZhOwHjs4yHA96VtjA+i?=
 =?us-ascii?Q?0L885pwtVio4mD9hE0qP2fzCfTwIh6h1kBlOPqLBgBhgcOC2+Pe6V2TeTXUh?=
 =?us-ascii?Q?gp6kUnvPPQ5o1F4TAnm/TW4AAtqHbdK+HGtKb7lzc75srzXPmTC3701QVIgr?=
 =?us-ascii?Q?Asjoq4goxfHq2U7QOMj7YRAlEFGYeANiCYJLDUP+i7VfEd4p/neQ0CDz/ykC?=
 =?us-ascii?Q?wNjJM9tQMsTzMDvKhV5+z1OjzxLarJJgSeq63n01hyVR8og10YTUcF7OcW4U?=
 =?us-ascii?Q?TdxfNnwXhr7Sc+cIUUyFnY1wuD9AxwY3Tp6PYz0w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d086c384-fc3c-48e0-c37a-08dae8b75dad
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 09:39:07.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BGSs4IFYqSdnPQyLJECnhNaxO10+2pIGmLhdENSGDRCyz8NS2Vw/olHBWTh6cqvcCf3s7cMADb1zWYW9zVNyA==
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

The absence of a correct offset leads an incorrect ODR mode
readback after use a hexadecimal number to mark the value from
FXOS8700_CTRL_REG1.

Get ODR mode by field mask and FIELD_GET clearly and conveniently.
And attach other additional fix for keeping the original code logic
and a good readability.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V4:
- Use ODR_MSK in the first place that merged the first two patches
  in V3 into this patch.
- Rework commit log
Changes for V3:
- Remove FXOS8700_CTRL_ODR_GENMSK and set FXOS8700_CTRL_ODR_MSK a
  field mask
- Legal use of filed mask and FIELD_PREP() to select ODR mode
- Rework commit log
---
 drivers/iio/imu/fxos8700_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 773f62203bf0..a1af5d0fde5d 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -10,6 +10,7 @@
 #include <linux/regmap.h>
 #include <linux/acpi.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -144,9 +145,9 @@
 #define FXOS8700_NVM_DATA_BNK0      0xa7
 
 /* Bit definitions for FXOS8700_CTRL_REG1 */
-#define FXOS8700_CTRL_ODR_MSK       0x38
 #define FXOS8700_CTRL_ODR_MAX       0x00
 #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
+#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
 #define FXOS8700_HMS_MASK           GENMASK(1, 0)
@@ -508,10 +509,8 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (i >= odr_num)
 		return -EINVAL;
 
-	return regmap_update_bits(data->regmap,
-				  FXOS8700_CTRL_REG1,
-				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
-				  fxos8700_odr[i].bits << 3 | active_mode);
+	val = val | FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) | active_mode;
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
 }
 
 static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
@@ -524,7 +523,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (ret)
 		return ret;
 
-	val &= FXOS8700_CTRL_ODR_MSK;
+	val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
 
 	for (i = 0; i < odr_num; i++)
 		if (val == fxos8700_odr[i].bits)
-- 
2.34.1

