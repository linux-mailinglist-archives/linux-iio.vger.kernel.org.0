Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9EB70B8FE
	for <lists+linux-iio@lfdr.de>; Mon, 22 May 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjEVJdP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 May 2023 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEVJdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 May 2023 05:33:14 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB3E6
        for <linux-iio@vger.kernel.org>; Mon, 22 May 2023 02:33:03 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8nsad001379;
        Mon, 22 May 2023 09:32:39 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2171.outbound.protection.outlook.com [104.47.23.171])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qpmjw94eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 09:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdRC550FhgHjiFQUj6HiN5pnK3a3zq+v8kjiHMl7IQ6+FsbvvFeY0jGvIOj8wFLWq4vCxqIV7JVXcF3dJabuW3gS2m1RWOkvfWTZKyGOhvgx2hcC4pK9oimwbzkyM9srf+RnIyuVKB53+yFRygmJJFCmuzgb/Mi3+H+guGLgrINUpPbg7nVXuvuQ+WXOdGFBuWG4DR3Xq6c0KNUIg/cY0nbtPrBh9Lo1s7UZ4xJBqG/sP+IPxoEBCCkfQb6c/zHpBoicjQ1IummxtBYQVefYRG7ezpmeM279kHBlWK5wJy9v5q3hBsJKCM8Juzv6xpluszeBhpXgmBf3sWb0g2cAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb9YKxts6+ilKtX0mIgg/JTUGAXMEj/Lze/+O3XiiUA=;
 b=VF/EoSF+idcNd+u2C2j+GT6eDd5AXe6JaKsi+rmNObzF/dD+t/8MzR3lN3VuQ+T66H0ZVPHUUK8vH5YXW7BbcN3/y2ErpoFxwgUoVm68Idzpad1LxxNjVMmGZmh7l676/p5TFkGUnId8CBf5dSembhsTzuLNnXLsophdTypGZlt5PecuzZ/bYhmFELZ2TNZAjplaC3kumuO3j+VrbqNbI270K/zHuFd4+uWfAZxxuVm6acatkkLqPFSPogbFE2V792aWycYLk/0ehlJkdy7nyhBi/qH2RoJBHRvQt/PKf4ScAEkr40cl8HZ5S9DXThOYRjPlqMMrn8RQeP5m+uihhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb9YKxts6+ilKtX0mIgg/JTUGAXMEj/Lze/+O3XiiUA=;
 b=Gn1XsYeR9T76KNQaWdY/8+/su8JkUxPhohsRBCcAiF8NMTQnBlG56HOa0JTPw1Cm3Q4hSmSuwADKHIkvMvZqQgK7UHKIqueznyl0LbBGir+HSe+j9A369PI79gwHdSt5AvfCKRTKgAXHkuANdwoTlg8B+o7ywjPRZRbgB1WYK2PA5RNfnbqblih9HYunlrcDQLPzeagbqhjH8NC/vJ3FYAMk9PwV6n9eVhXCvQRtPwtvnZoLiiKDWQO0hMDdAQOZJfQJdsQqa/RpgAHK07SAHN1XnK3hojnU12cjK4IeMfSEn+7z+sBzFtiWavNVvHvIPoE4Nno9gWkcARhlVNJ+pA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB3793.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:407::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:32:35 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:32:31 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3] iio: imu: inv_icm42600: avoid frequent timestamp jitter
Date:   Mon, 22 May 2023 09:32:10 +0000
Message-Id: <20230522093210.817212-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::7) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB3793:EE_
X-MS-Office365-Filtering-Correlation-Id: e000a330-8f62-45aa-48e5-08db5aa77715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFpOUyEXBadm8rxxw/SbxnVXQ/QPiGoCBDfm6sQI1GatDtqL78JdEbv/o9QvgDLiInqIY4argBEC8vsh0aYvprD6NglzQPDDVS40vN7nS5FkqzAXuq4woob7YWlcz5+AbYJHWHlaJVtK/9goa+TW9aWae6M9lpiVS+q+I6S4acWI/43C7LvzwWzF89cFtc6ybaVKtPI+Lz4QSL2Pez7hwN57WED9ZxNKlgmsPQaQ2CYst6HEMq8Mqv+J4LRu/GCf2ifD0KE79DeTW3VqEQlBiDy5cTr9WTahHkaLsKOD2FZuBVj7qhQePLUl4OJt3tsSNVHP3y4lSrzPEwGi2jvpbyQIpdNcSN8H+1j2HbMDfWBBTj4IgYzTJEIqzFRF6zDnwcKga4CvD4WrmB2F8IktOiWBcnayNZKAVTVT/MZ8gEYf/OyFRlw1AndUfhyh0JRtJugiXjwPCkoa6htD8eLcFDz2BoFJjSqPutw3ukx8G2s6pYhMzsixppk4MkpTK59P/jESi5NsEmvjrfTt+8Ggw2meUhNqc1unMhc2rJZ4T7BKRSJYawdUy5plPKfjm745DQUaqP+w3ovBwv07meRhx9C12+ECgpJhca3ODNFaBg9A/bnugmd808Fu61NYgmQr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2906002)(5660300002)(83380400001)(8676002)(8936002)(41300700001)(66556008)(66946007)(4326008)(66476007)(316002)(36756003)(6486002)(6666004)(478600001)(52116002)(2616005)(9686003)(6512007)(6506007)(1076003)(26005)(86362001)(186003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnbQ4m18j6p7lNuTIIuw2h+vfMYTXnMDL6iRc7xFgiLX16e89PRULcc9K0ep?=
 =?us-ascii?Q?hPhBBYqbecdlM6FPFSttI4e8LVDkbXGGkB7/pf9mwUPxhQXJwdaGa4F/M0Vp?=
 =?us-ascii?Q?U110NgHJAET/UBw4U8K13r8xyibl/Ev5gF1FsTLxzEl0rwilO0UdHBs5ZO+T?=
 =?us-ascii?Q?ptkFrexvmWrzSc+LZv3mATTaaOmDS79V0PRtDY5p0YkAlDkSsjNTfm5bufUT?=
 =?us-ascii?Q?Lm4fJO18xkK6cqWKyhDjORIz3zH0yQIPReFgOTDnBFPA5AAH6VXWMVC+wt8k?=
 =?us-ascii?Q?DfXAcDoM7MoDuRWPbfNmYDkvIMg0A+QRvd5+dl2153v/YKgW/phNckmiCGm7?=
 =?us-ascii?Q?n8+7KE6iqt2JHr+AE9HqZ+16ItwfxNtKLVbqEE6sGRaqJMOkMzF3kljVs4ew?=
 =?us-ascii?Q?d1Kwab/Z/3DblLiBWoghgX8+BDLnlndnws+DdOLlZwpKq4QcMqRzqwxzONv9?=
 =?us-ascii?Q?JlcJxEnKn4lybZADs2grLc/1sUgsOsk5O6MlNIaBQUfZdodvx7XdQcpUVf2h?=
 =?us-ascii?Q?G6UkFeRurgLEb4Rl6dvoYZJgh+KiveBpUU10nkUCkw5EsnAnt6AW+iK/zIi2?=
 =?us-ascii?Q?ubbF0xo251xk1+Dd86ZhVnva3yc2S0G6OBC20DKfA1NxopYsII96ZlOdj11X?=
 =?us-ascii?Q?ciMFbS3XVSKw05vI/2qSkUsrFfacr/Y6qcTGCCIU3rY6ImN/s9oKkqScXOvU?=
 =?us-ascii?Q?yWnP+/u1U/rwcma9SB3aSPxalTIxQT8jjzbq8EfRZJ0u2DsfbOur+SXWDpgR?=
 =?us-ascii?Q?hLRmFkDycAaIB2UKX53h/2Y9RJb5FkMvKBi4DzQ62ppjxpKdLF3qyyT/iAyw?=
 =?us-ascii?Q?lmCGf10DaFIUSWsR3TZiBc6ubTlCfHU+Tp+ixHv4IKul3l0DdluxxCFHmGzX?=
 =?us-ascii?Q?gycC4MO9zW1JfRb3Nb22zfy5JODOXSZXA1OYNBkmWdK1wAnWxdLSTMubjXs5?=
 =?us-ascii?Q?fUM3/iHytnK3wCSCAPti8eEmBm1AY36f9oMCGIxhYd28IigG8y9vC4kjTaqJ?=
 =?us-ascii?Q?gI5fwQRbADjbtYPIlNa49iofeUnnvUrKLmhSjPAggcrcLysJg7mjkI6RB35Q?=
 =?us-ascii?Q?xKuDSmR+CN8W1mII7VsAmaHmpbAZ0xhet51kKXxZxRT/pKVVRzDC8sAQgAXD?=
 =?us-ascii?Q?XnqhipGHEfY1VUsoTgwL4ar98q3zzr+ep8fII/Qspaspuuml6FsmicJEhFg8?=
 =?us-ascii?Q?/LjwzOwRhfdxp6aO4GsbTqjqveceeGqq5DBWlz4PvYdYl0mRmBxnkrk3AN5Y?=
 =?us-ascii?Q?3D9Xgmv+aYanLohCzSJZnEVxewsNiFTLUR78LQuli5365AiJXxm3rGiH/Jsv?=
 =?us-ascii?Q?GqrXsXjxBfPKzim1lu1b6ov/+TyDQ4ZarBxYQu+XjATJWOoiIZbVr3kaEctR?=
 =?us-ascii?Q?ON1ju4j1u7AbdJzKrHzrMDrsiHdIsFlrFmpJWWTuxSRgmuk5HxyFn5nNXJps?=
 =?us-ascii?Q?IgZu7bW+dgkztWRXJi6iMln26lHqaEc5XaiVOj5t1rzesQR6hcc15UyfmjU6?=
 =?us-ascii?Q?vUx18ft7WxFlfwA3WkTx3mxZcP6tUS793AqifeD+mECKjcXkFG4msFRLrfd0?=
 =?us-ascii?Q?GTwYvXO6vAXwHaBtdW+UY0+Yh5VuIeAFx3dGizA4?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e000a330-8f62-45aa-48e5-08db5aa77715
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:32:30.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlsttQY18GnTmnbNZ1poxKVdVwbE6G1dy9z81OxYmzEXzXOXDTbccgSuh2rcXG7bNXQG2sAmwyTSDeRExn6v9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

We are currently synchronizing every time the data timestamp with
the IT timestamp, leading to system jitter jamming timestamps.
To fix that and keep it simple, let's just synchronize when the
delta is bigger than the acceptable jitter, and keep
synchronization at the jitter value.

The result is much stable timestamps reflecting better the real
physical value. Example @50Hz delta timestamp,
* before: 20.123ms, 19.721ms, 20.023ms, 20.353ms, 19.821ms, ...
* after: 20.173ms, 20.173ms, 20.173ms, 20.40ms, 20.173ms, ...

Refactorize code and delete the unnecessary handling of multiple
FIFO data.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
v3:
 - Fix compilation issue by using div_s64 for 64 / 32 bits division
   reported by kernel test robot.
v2:
 - Rework commit message for more clarity.
 - Delete Fixes tag.

 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 49 ++++++++++---------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
index 7f2dc41f807b..37cbf08acb3a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
@@ -93,8 +93,8 @@ static bool inv_validate_period(uint32_t period, uint32_t mult)
 		return false;
 }
 
-static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
-				    uint32_t mult, uint32_t period)
+static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,
+				   uint32_t mult, uint32_t period)
 {
 	uint32_t new_chip_period;
 
@@ -104,10 +104,31 @@ static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
 	/* update chip internal period estimation */
 	new_chip_period = period / mult;
 	inv_update_acc(&ts->chip_period, new_chip_period);
+	ts->period = ts->mult * ts->chip_period.val;
 
 	return true;
 }
 
+static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
+{
+	int64_t delta, jitter;
+	int64_t adjust;
+
+	/* delta time between last sample and last interrupt */
+	delta = ts->it.lo - ts->timestamp;
+
+	/* adjust timestamp while respecting jitter */
+	jitter = div_s64((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JITTER, 100);
+	if (delta > jitter)
+		adjust = jitter;
+	else if (delta < -jitter)
+		adjust = -jitter;
+	else
+		adjust = 0;
+
+	ts->timestamp += adjust;
+}
+
 void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 				      uint32_t fifo_period, size_t fifo_nb,
 				      size_t sensor_nb, int64_t timestamp)
@@ -116,7 +137,6 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	int64_t delta, interval;
 	const uint32_t fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
 	uint32_t period = ts->period;
-	int32_t m;
 	bool valid = false;
 
 	if (fifo_nb == 0)
@@ -130,10 +150,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	if (it->lo != 0) {
 		/* compute period: delta time divided by number of samples */
 		period = div_s64(delta, fifo_nb);
-		valid = inv_compute_chip_period(ts, fifo_mult, period);
-		/* update sensor period if chip internal period is updated */
-		if (valid)
-			ts->period = ts->mult * ts->chip_period.val;
+		valid = inv_update_chip_period(ts, fifo_mult, period);
 	}
 
 	/* no previous data, compute theoritical value from interrupt */
@@ -145,22 +162,8 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	}
 
 	/* if interrupt interval is valid, sync with interrupt timestamp */
-	if (valid) {
-		/* compute measured fifo_period */
-		fifo_period = fifo_mult * ts->chip_period.val;
-		/* delta time between last sample and last interrupt */
-		delta = it->lo - ts->timestamp;
-		/* if there are multiple samples, go back to first one */
-		while (delta >= (fifo_period * 3 / 2))
-			delta -= fifo_period;
-		/* compute maximal adjustment value */
-		m = INV_ICM42600_TIMESTAMP_MAX_PERIOD(ts->period) - ts->period;
-		if (delta > m)
-			delta = m;
-		else if (delta < -m)
-			delta = -m;
-		ts->timestamp += delta;
-	}
+	if (valid)
+		inv_align_timestamp_it(ts);
 }
 
 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
-- 
2.34.1

