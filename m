Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3276F68AF
	for <lists+linux-iio@lfdr.de>; Thu,  4 May 2023 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEDJw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 May 2023 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjEDJw6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2023 05:52:58 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28471CD;
        Thu,  4 May 2023 02:52:56 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Mj0kZ030699;
        Thu, 4 May 2023 09:52:36 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3q8skyjsyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgbSn73C0DIJpSnmrEl4y5F8IsWT0ai/DP3Hfjf2Lat/K5QctEliZdMkGKJpOGEb11eUw6H1g3gXk7zfv0emIzLyKUCgJs3fhTcSdtTHTIgkPy3huOOzMgnu/mtoNSW0yE7mlWNThvu0sLgcwr3io4S9G8ne9x7l25D3ZFJ8JTASo6BGxfPb2vv+JnpP3zJahce3yJXvniuhwEjC7sDGMfNC2FcXlz8PsG7raggNmXbszF98BSSbAYcJ4f8AZraXkYC67TGI0XWCdtk+qBZbl8FAJ9FzOT27rb/txJJ69DsvYSOcAXDmzJpj6IeNPu9w/o7xOHhR7EMYvgr78Gk7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v04E9BA8qR7UlGhWOH38HfGUUH/lS8ltGR9UPtTm9jw=;
 b=QdQKcee1FGh1DJhIZ8slYPcGNkttYgcP/C1zztULP+A/mE0nIaHEg+ZRgrc0HWgZXO1jCVYYEXRlRvaVm47S0LLuRKaSn9HX8+OuNImPAlY16nKuyZLb1V79ux3pow6fRen+zlHJcOkygs3zeRvscZq7UVgEactjd1IZTYZuDao4klwBBdi3G+BzlDhXjAWZgn79KO4Oj9/U1jEKFPv15kJb0jpQQygjuzvRM+m03DsjCec3NrzaM0dzn9cPSO1UdPiJMlSCvANW7Dg6SPz5JlR0mUs4GeQjqqjxGivqkfsLlKLFqkLas8ZsaoCjQH/EmtitNMvoW18RAsI44qhB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v04E9BA8qR7UlGhWOH38HfGUUH/lS8ltGR9UPtTm9jw=;
 b=cazgjkuDssQwobF0E/eSSJ9HCd2ZDOn5+M9axP+fDgCQmCGZmeaQNcRmxSeXsuE//67NDdvcv4oyJSnbObfU8twHqUpWjdZD/53PHsenPKYDOrGffmy3whpyRhg6tz0w23J/tR+rDk4GnHvF0LUH2QX1LTHc9Fisj8LK5cL3ID86L5/aw/gYQcV10wS2R83T78OsfzDlq2X5YEym833pp8+lQfWrKJs11icA+oisZ/yAm8HEELgEl4Lii0ay4xnk26U4q39WGQzMhFe27P0O+SVUrA2C46MtqjU7C4vhjkEpmtBFxKirQd4A2vuxJ73k/GQ1g/AX8mXVEKx4pl2G9g==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB2117.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:194::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.25; Thu, 4 May
 2023 09:52:31 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647%4]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 09:52:31 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        inv.git-commit@tdk.com, stable@vger.kernel.org
Subject: [PATCH] iio: imu: inv_icm42600: fix too big timestamp jitter
Date:   Thu,  4 May 2023 09:52:04 +0000
Message-Id: <20230504095204.172715-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0475.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::12) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB2117:EE_
X-MS-Office365-Filtering-Correlation-Id: 387383b9-316f-4367-20e5-08db4c8546fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ew/51JwOg4oPLf0NZmVva9mv0XPJEDvm2ZcoD+dKAlgoNt69HIQj3J36/5cO/vsBjeyvXQe0utNwQ+4Q4zFJ3XU0z0NU4YZTwIWl5ICRDObCbTjlPdjvT9MApnXGVF8yU97rcHN6IbVtnW63ppvkFQJNqU9wy2Clfp3yId0dGBhcOTuMuOOtbEyhfWN4uG+f4BXNsQV2RL/fGFuyxZbPeOGAfswfjGF6B0f4J147gCQk7HCR00jXsdfZasP5KIqFIXoPHmCSkcOMrSuLql+tDQxFAXV6bufn7yt5/lwWCYtNNP03/qu8t3nH96oHLBmxY+1PB+3kBSvJoAWODrGzDWsOvxZf8JzfTUMKwQ0dMxhwi73DOyx+hUO5OFosSEVhXVi7R1poafzTCDBravz6k9OxBJLFiKjfCXyiQ5fxRq7Abr7xyM15z9QWI2kEs80zzLv+GnWH24QQbxG45DXS223VpH431N3eDuhfD/rxL3O4VMl2FMw2vPryDZYBfQbOl2OWcvQjB9MX3e2f++9KtVlswTFdz9dUg2b6TWsKabnvBhAh0QDpp/Hzz4PcvdWo+ouJ5THOSnkYuqDwA0YrjZocmRRYcuM289R6hayBpuzIRZYFu9DC7vH5tTdh79Bk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(83380400001)(2616005)(41300700001)(8936002)(8676002)(316002)(186003)(5660300002)(6512007)(6506007)(1076003)(9686003)(4326008)(26005)(38100700002)(38350700002)(66946007)(66476007)(66556008)(52116002)(6666004)(6486002)(86362001)(478600001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4cIjDEw1UEaFNPyYucjcN8wPI+XKiGucKYVtEmLr4bwlArXehevDUFHQUh4G?=
 =?us-ascii?Q?aWtFcr+IAoJvmftSFyE7vhif+O8it3US48Y+J4RSOO6P/scvddg1kZTCjIG8?=
 =?us-ascii?Q?9nVZ606hYFAWiOfU9Z71h4G5AiXvIrATlJ+h7eYZPtY+cFwlElYYMmSwYG/K?=
 =?us-ascii?Q?uaCKZkHy8ZNDPqucaCIJyMKgJV7YtrfjuG1pQJIdUMDP7zHdhsRCc10knMXy?=
 =?us-ascii?Q?WJcC21b8smPVEbAhyUijssD1uKBUAFmDhvtYu7UeQ9iupdl6AGRxa6gz6EJB?=
 =?us-ascii?Q?5RXaNAdP+Ax503M5Ei2h7s6R33FVQtdVjrmWUa8QDL5TpFvEqe9V+HgCmhGQ?=
 =?us-ascii?Q?Xyxycr/kEwAKJduSu+5berl7mmNhwTllskAlHIEGna7pNaAHZGEuOtFFIvaK?=
 =?us-ascii?Q?zap3nVOlcuTXWJs2hVMF8M+vXVgbivn/S98FLtNL6qcrq+CkbdPbLRsVmT5D?=
 =?us-ascii?Q?orsifT5/FJfaxh1WHNLWaDG5CR01kYYAvqTiNJqmUnkYjSp2htRZNl/bmY6b?=
 =?us-ascii?Q?s2qT2RBRHjWNr9fqdQCHy/56hpJQYnitUIWhk0VtMxgYC8Pe7c9zUzEz8w3U?=
 =?us-ascii?Q?h3EHnpF79EoJha9dvcIdeyXrJoNIwjBfmXvUfr694dvGTg0ibbWxQl+CiURC?=
 =?us-ascii?Q?ON/hcQTJ5oJp6A5TzE48rECMFuJyyw8/XEKlqC8yvqZU6QsOQVIF5ABqkYOo?=
 =?us-ascii?Q?eIhP3etd+XPIwT+iZt0mzhr/f5qnXulQbNXo8ZV8d/6yV5IbpeeVtHM4NDkR?=
 =?us-ascii?Q?RgQjtFDp8V+LeA34oVMuK86e9+VXOiSd8u1j3u9uXcnGxtlAkRHt8JBgQBZl?=
 =?us-ascii?Q?q1t7kfzQl13Xy/T9ongv0YGuan1nqityGJjjotNlxokfjmY4wxUisvC1sUSb?=
 =?us-ascii?Q?iBHiuS8Lf+TcBIqkA7JkHm/O6o8yWK0Z/kyxv1Kjcy95QC7gAADyoie/OgoE?=
 =?us-ascii?Q?+aebftHrfPRY8fVswKnAUhfXsC6ysgsD14ePzj2/b7MqaeffFcygpND9xYGw?=
 =?us-ascii?Q?02A9A5cmVtLKxG4G74RjZpiU5gY6j5n4VWbJlUFES/pebYrArw+nbEqOLIIS?=
 =?us-ascii?Q?BZSSLY7io2bvXqLRS19ItVY4cl0OFJSo2wLZGdpMj+GLM3D4Ub247n+4RKXM?=
 =?us-ascii?Q?c22JStZSVGvH7hPniIENbKRzJepojx7F1/L5B6UZvM6G2IzipdZP8RaX5wmM?=
 =?us-ascii?Q?Fg7MuPqMaf89VnpU9CmAYcSNiAM3uhx673120ynWRwU7LqsXliTJQLSiJSM9?=
 =?us-ascii?Q?HO+9pOPgFiGTEd2guU5w54z+oXGgiuqkA5/sekWOfzc6s8AZXWavSP23m8ch?=
 =?us-ascii?Q?8cAq0IxUy6bjqXQKaLgsq0cBaARdSKI5ETc90WM1CjLef9Ls4Bpp20eovc08?=
 =?us-ascii?Q?iwTrY/smPajzfK3zfbnjHwiFn7RhmSV9U8krm78JTsKkLhJZPD27iCWUOLV7?=
 =?us-ascii?Q?ieDQjzwPzXbgM38KJbGXId6yuTqbdX0KLBkgOUp2aZNIxiFA2FsfgIXRtkpr?=
 =?us-ascii?Q?eyMPQjZ6JRH23pln258Dhif3s6JPyfJpe89WYf3aaNbfG4BzeC45xxqSXTQH?=
 =?us-ascii?Q?yld7BZQthJNwI1BH3q72IUmIHD/UkQVXF7+FvM5f?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387383b9-316f-4367-20e5-08db4c8546fc
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 09:52:31.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKoHbJv7Bl0ElSsb2pMOza6Vianqr3KektGGoNZgpKEEU8IMdU8+4Oe5tJeK0TL0oZU2SQK9EZuKpS+HN1ZgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

We are adjusting timestamp with interrupt every time, leading to
a lot of jitter in timestamp values. Now the adjustment is done
only when the delta is bigger than the jitter.

Refactorize code and delete the unnecessary handling of multiple
FIFO data.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: <inv.git-commit@tdk.com>
Cc: <stable@vger.kernel.org>
---
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 49 ++++++++++---------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
index 7f2dc41f807b..af2e59fb7258 100644
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
+	jitter = ((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JITTER) / 100;
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

