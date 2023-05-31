Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBB7184E1
	for <lists+linux-iio@lfdr.de>; Wed, 31 May 2023 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjEaO03 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 May 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjEaO0Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 May 2023 10:26:25 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519EB1A5
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 07:26:09 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VD5Ck1030918;
        Wed, 31 May 2023 14:25:44 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2107.outbound.protection.outlook.com [104.47.23.107])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3quanmk3c3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCotOcG1T4eGaAQs4wIRlhNOX2cqdE2U+zOXSSglXQqLHYlp2/HmezmT0IGN04uzgNmkcKYUfX9dPinl+lL3OdbhQAsMz+jjjwlWvVPXcAruGETUXwkXumq2rjCZf6fxZxsC4coaaSwS+ucrgq4AzNou5uwfwdnxL1zauIX9r/lk73kv+6AmYqU9nj/XEqKT8K98cTZBOlAqHu2cDkbDtxCWG0VFJO4THsfUjEVsRJU8Vspanp+YGBUmJra8b92b9zpw8jCPrRXcIWeZeXfrHZC9KIioLrWKR6WFo8fYV/HBs72FZsJ9TTCZt/ru4aPup5xpc2cbuQBZML6tXx9o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sJYkZy138zblZgRLIUvmUQ0R8GXgRe85wfpyKVNOjA=;
 b=P9I23SGTLxI79z96F5h6OYEnzX+N/5tXNWmdde8QetoXehBxlUBBHES2lshoKILNtYHOHJYMBi2fQ3zYP+OWYwHVtoCn7B16RTxeAWpQqox2Izl8bYKhifO+ICBmyU3kb+kY0GVOq8J2RBjoMwJel3xlAehsw+WuejH23EiOgCKWuRGLOPNirUWrnguzwV/Cvg0OKt2cr6+1TubwpNaMXNIjZCpx6sUbm5K0nW7Ly7W4K5vyDouZQXoO46V8HuEro3XBnahbqaMVJBxykooGd16fDfzzaFUyNZ1DYN39dM3OMmnQiFfC8/g1IpP+T1ILSZSXfbmxfba8abxU1xP2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sJYkZy138zblZgRLIUvmUQ0R8GXgRe85wfpyKVNOjA=;
 b=kdr5F5pTCPOt3rNzEzND1EAmJawy90auqjCTmDOtqgR6ZzfcDGFn9wWW1kBZmHoN6/kV5aDjYirXTpDpwBiEOvBLToCK34Hr55wkKsUJTf8/bUdogaEmV/grrCezBdGr368XhENlAVjpptEmwenaY9Mqak7OfkYPnpfrb3hZi+N7lppIVG4a3dkLnUIsnDh9tLm8PE6AZU3k6iWN1COxQ5dJCE4SKol/EQixoz0i6posNCjyiNCtNSGfsuEretl5JXkHjp451zyECJFdzBtkJr7DvK0pp3XPKEIObIGMBIH/55RX5dR/SZvje3XqAzRigjK3AYQHa6iWVXLPwme4GA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2785.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 14:25:41 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:25:41 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 1/4] iio: imu: inv_icm42600: make timestamp module chip independant
Date:   Wed, 31 May 2023 14:25:10 +0000
Message-Id: <20230531142513.48507-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531142513.48507-1-inv.git-commit@tdk.com>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB2785:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bd48f4-a3d7-41f8-cf2b-08db61e2e97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qgj9RTCx/Uab3nFFt0P3yZoyutTAI59l/VlKznhXisqL0plskQEQi+JfKdWed9aR+7+eNHtfgXxHG0CX+ezXUrSl71dmiHteGJSG4WN6EbCBOF7G1uqBG75M59K6knxHgMlzBDmG8EcrBWzceqvFIfW6Qc7RXZXbY47aYCEd2VJVWNgpGuDR1C4rp5EYMult673vNYVLGkJt3AeZdNUYt2kOvhRfBuygLIvQox6wi/idtpuCffdUhDK3IBjdhFQC++NNzoJOLyd0K55vJpo0nwf75+JlOaNpLCyO1pcmRb6mc//Psse56E9r4q3QgBxKSstTNg7dF/GM1d9wnf0pq1OiQ0l5Fj7iYL9NHsW/W5vk8Wc7SsO9EXca1UaevNBTUSHpBDShtMeEtucjvJvZ7LDQXHLmrLPC/CNJm+iFwMRHatyK8EixMfOacFUwzqcOi1wQyZEMq+W2RwZVQTaix5rNwmLdEzzjHWDgM8zo6AwFOwKEZxQO9zFkCWlLUgXwnkUEX/anj7J3tsB76sqFSl4i0v3qxZIgrC00voiqM93wz9Il2RCKxTrymBCZnpWbG86VRuBH6CzoHxc6ae8tiQ9/OzW1maev7sYskfQUugSOcGwUqSRTnMEMA2p9/h9c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(86362001)(36756003)(2906002)(186003)(5660300002)(6506007)(1076003)(26005)(9686003)(6512007)(6666004)(52116002)(6486002)(2616005)(478600001)(83380400001)(38350700002)(4326008)(66946007)(66476007)(66556008)(38100700002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDIcLp/6TDu2xtHiuz3BKFX6+qOZFNw96eqb0F5Ux4vhb34/Oan8Cn2Wiod7?=
 =?us-ascii?Q?AWpcN+45PpzpoUQK/SPlAQjv5ptssD1fL34ZOAdjWN/W18RkjtcF6cbmDJw3?=
 =?us-ascii?Q?/xhEslI6JFAs0B1LWCnHRZbnTLJQ+j8ALqJpXW+y8O3A29fqm4jEFoq9/bHV?=
 =?us-ascii?Q?vPB290ZXTO3tzdBj6+tYJVyCR2lOpmKyR/fw8/UJz42Dy4F6j3lCFZ1SuCkJ?=
 =?us-ascii?Q?c3TBGi8Tu6pTE95C2DLeMil0pZanWSoriJZcECcye7wrVw1xxskclK5uoAj+?=
 =?us-ascii?Q?JVHZ6FzD2rTJJgIOLwCY3/VcmEaehy7lZWekfScztii/ahtQPrBAeohaV2ic?=
 =?us-ascii?Q?ym+6TCRKY4D/TWi6lHNEmv5RhBmtsHecIMGNitbHeuOGZfkmbSfU2kLURlLK?=
 =?us-ascii?Q?ywbOBIhmgUgRLTTiIzvNSUAkD1gHvywlSnp0Mr0XXumaB3VY+BwyvBzQ95Rv?=
 =?us-ascii?Q?l4fUk575wPNMvWi/OZ8vp8V70frTCODXhcGiRs6J6QMvOTf5nfDGaTZFw8II?=
 =?us-ascii?Q?JFbYCEn/m/l7gG7ejjgT1Deivm1vr+TM7poCvkTYwRs5zayE69Vh/xzOw/ll?=
 =?us-ascii?Q?FdP3R81Jgh3/x0rH9xFvV+y0znTCzhkdclvpiHhkqh21tCyGB77Jt5VU3ZSR?=
 =?us-ascii?Q?yZfUyH52Qk9GT5B99gYOojuvp1iEvZcQouBMyWRXcUrOLo0R7NxtI46/7Gi2?=
 =?us-ascii?Q?E+MbkjKYfqIjX8F/6G0/n//qJOKbnKF69G5uvJr6EMcI3L4MeY4iM32aX/eH?=
 =?us-ascii?Q?HZDZrA+9yUiXAjdeNiFFKn/ucMq7MK8jJe2aXxxLp97nEmPmWAoZWGQ9ElUy?=
 =?us-ascii?Q?FyGAdYYbmMBy50RQPW9Cm+LAfqVM52Q7VvBGhPejzJ7PkyOLVpQxPduRyIpc?=
 =?us-ascii?Q?sCwnZjVWBiYiEO/ekT7S05t1VOPLM+7EyQKtSpVdmhw79HPM2FnTy9yUgQJN?=
 =?us-ascii?Q?Yo0YomRh3jHglM47o7W0VS4fpGcL0PjF1KA8X7dPM6fbhiOqsnQwZd6HDE0F?=
 =?us-ascii?Q?TfqTvdSHzSnilwE3YXcEPkQnAAveAo/uzh0LZFy6xiJUZs5e3eydX/rOF/2d?=
 =?us-ascii?Q?xIMaadgRfou/EsxlwSEo/cYn7wzGIb31EVEyy7/bQAoZvIIABngf+kH2yeUu?=
 =?us-ascii?Q?ha2EL1SWA9pEJXDar0weMgRbL1sn6AHsDz6i2hqsf9RDrldzPdfGUfjHtezl?=
 =?us-ascii?Q?mpsQH9tHMl0WIKvS82TLbbpi1Ru2zk09/n1Kt6dmRCRM9c33Gz5EildDYZLL?=
 =?us-ascii?Q?bCaBNNQqA2e0sz9dHaW1N3IdfST6N5SeUcL0lc1bfAjvyp7o9FaKIwirHi7I?=
 =?us-ascii?Q?M50Yb+KoqjnvrrjxkjZbfpSBDrdReLqGMsLMZXI7j/qqkXIj1upLlB5KUSHP?=
 =?us-ascii?Q?Bh6VuTevihOpzxTgpTUPT2JWX0ISsXaTSGYUyRpc0AxsUwQ4xVr4bIZ5J+Sy?=
 =?us-ascii?Q?yWUawcO3d5vPjOiKrRll8GZ6SlUsYiisME4/XQXzw/XdDag0oF+u5DoruO9d?=
 =?us-ascii?Q?2y1sFoJ8iUzDzcBse0TCrnPczU5rkYeZkEx2A+5lfLIlFxY0lu5Ru8yERNkK?=
 =?us-ascii?Q?cEn5BSDqReXqoFEN6eEkvl1Bu1wBahTF/1QKAsiD?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bd48f4-a3d7-41f8-cf2b-08db61e2e97c
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:25:41.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llTq71Drpq+7FsptqxPRlNs78ZRv6HA0QNsR31XXEpuLyBmQoUJeZm6kfmofoNCq1hS5qY0RgHS6767j0QaNxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Move icm42600 dependent function inside the core module.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 11 +++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.c  | 14 +-------------
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.h  |  4 ----
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 7b3a2a0dc2cb..c34735b05830 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -516,6 +516,17 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 					 "inv_icm42600", st);
 }
 
+static int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st)
+{
+	unsigned int val;
+
+	/* enable timestamp register */
+	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
+	      INV_ICM42600_TMST_CONFIG_TMST_EN;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
+				  INV_ICM42600_TMST_CONFIG_MASK, val);
+}
+
 static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
 {
 	int ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
index 37cbf08acb3a..ceae8ccb1747 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
@@ -4,10 +4,9 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/regmap.h>
 #include <linux/math64.h>
+#include <linux/errno.h>
 
-#include "inv_icm42600.h"
 #include "inv_icm42600_timestamp.h"
 
 /* internal chip period is 32kHz, 31250ns */
@@ -56,17 +55,6 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
 }
 
-int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st)
-{
-	unsigned int val;
-
-	/* enable timestamp register */
-	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
-	      INV_ICM42600_TMST_CONFIG_TMST_EN;
-	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
-				  INV_ICM42600_TMST_CONFIG_MASK, val);
-}
-
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo)
 {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
index 4e4f331d4fe4..00fd452632a3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
@@ -8,8 +8,6 @@
 
 #include <linux/kernel.h>
 
-struct inv_icm42600_state;
-
 /**
  * struct inv_icm42600_timestamp_interval - timestamps interval
  * @lo:	interval lower bound
@@ -53,8 +51,6 @@ struct inv_icm42600_timestamp {
 void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 				 uint32_t period);
 
-int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st);
-
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo);
 
-- 
2.34.1

