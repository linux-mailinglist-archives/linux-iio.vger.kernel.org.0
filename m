Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904157184E5
	for <lists+linux-iio@lfdr.de>; Wed, 31 May 2023 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjEaO0e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 May 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjEaO0c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 May 2023 10:26:32 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4413D
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 07:26:13 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8wvYl008615;
        Wed, 31 May 2023 14:25:48 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2173.outbound.protection.outlook.com [104.47.23.173])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qub7gu0yx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbAvg63DU5sJEbLAj8MyuEuS4KEcY1NGFPP+3l0meUuSrfFde8T2UaxEyxlWP9OOugkUztOAj3fHNHaS8yOSXO9+SfOJL6hvuL5KKNCM45Sstn0VF47v4/N9uLHv47WySmxhagcldMGZVZ/LGkF9uc5k0bPgG0FsroVGicADSxpV3mymXbysFFcIwMi80Jif0EutbYNAxrnv/bua2q6NyOc+cj8PXUSDNCXD/DClexEWKaIuYXu0ccj1Sxs5WjdtVT3tq0i+PFr84kFK2gLprjxM+19rjWs0o+nF6DwzS7wdEUxky5xJpVCMST+XaED3akKfsRMSFSgH8Uy3XOVolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIwkGJkdijBDxgTP4v0U5Ez/23aQ/ggz8AqymM3BWOQ=;
 b=h3lQ5NxA+Ty3D6p9agT8E52kzYAzk62Vwgu7cehXXYSRKCbxFmkY086de/hBI1l/ccnBI0044UbuhGkuE/5FcgW90qpgkQlmeAVYt2KkMA8CdS18msmvyFS5atIpiQd6aGcnEkncT6c3H4b+EeqZiZ2hIxApvs3g8w8AlRgxjpL6sqnYTeGksq6Goo0YkrwX6GTjUMdxVFHYxwqXCBxoxeQa4guTIzvkYVmKhra9VQ0qXsPyiwpHnhI3tUrAI7EL5i6jWLS4bL18NC5qTTrbfEr8YfsvxEoUkaHpTO74Fc3fMsJYvi0PT9sWEHbbOTrecPlbgfGWomAzMClNDh3OdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIwkGJkdijBDxgTP4v0U5Ez/23aQ/ggz8AqymM3BWOQ=;
 b=UnLGr7BZXKdpKhuL8nBy6OOMI2GixARz16QOTO5qaJJgGAXcJzDbmncTmK+i6Toa+2pBMvbSdTPT0aTsUosPdRLKqLCszBYO7Ni7EP/qYqBaQ59ghSD4/VTKL7B4dgsc8JUDO7abzwRX2MAH14xV4gHsFO7S8vVzCW0mVPI6qEk5eSdHWSI3evI/NcpQ0avxK2uotlqyGHlGolDmxNHkoQDDtrvTMtSCWnHySeW+GB20+sUFykNJMNGk2PS/z0UudzBiEYxmdO0Q9czqnLw4VFT/EZto5a6M2t5wLcua53m6/Rgt5HM2Dci0AcLy9Dvh5CVFHRuZvs+RW0Cpsceq7w==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB3226.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 14:25:45 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:25:45 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 3/4] iio: make invensense timestamp module generic
Date:   Wed, 31 May 2023 14:25:12 +0000
Message-Id: <20230531142513.48507-4-inv.git-commit@tdk.com>
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
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: e075caa7-782b-4c3d-0e8d-08db61e2ebdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXHosRKlfYSrIZZzGyMR1a94cgh+NWPTB7/UdU4WrAkyFVvtOGRaN6f0sONeDEPTyD45UXOzPR7qA1sWiOsx52lkaW6xNWyToSjnSNmy6FHpLz8+fAGTi3bhzd4CAyIA9PPcwh/a95cLfo/b13eAoEs1E6R3RKOf4FIVb6Tr2+KDjslDT8RpeMrfqsF2NjSWRa1u22WxH7odA4lwK7P41SAj4AVhzWqKOpWg8ukh6dq2cFk2EnoLvIGWaZlEFPElA8LLBgRhjsD3EBA6kVAkJi7VZxs84umKx0WlkftsbyQhs8w6bh4AubJ/hKpjU48dV2mKasNM5gOX+kQ5s95L/NmJyRvmJGnjCiDIzgOsAd1kVBwQ8Bg9ZCFqmLoUCvY9ZhzlU4RTEFx5TMw/B60WWHCQewXEVJFiBrVVYynCX40bOhI8HxN/aVP2oEnik0M4M4J2DrqKL11q6h+dq0TfKkVzbFRhDhEpHH0N5EiR7DfTFqp1qaHI/HpQQ/2Qnk3GnGSWEfZzgKWP7PMaMtxx6XERd4PXsNrvUo49KCOAPrLOGfotRiCNOL9DA/jhG9Ln1zWPVhYigdhIWElMOu4S2Gy1Z9O7tCgPz5cYBThK+qIunqdpVLDxSBaPKGGaCWhnNwGiAr2Pe3pyN7oiPs8/ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(30864003)(2616005)(2906002)(186003)(83380400001)(36756003)(38100700002)(38350700002)(8936002)(8676002)(41300700001)(86362001)(478600001)(4326008)(66556008)(66476007)(66946007)(5660300002)(6486002)(52116002)(6666004)(316002)(6512007)(9686003)(6506007)(26005)(1076003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pl8AfCt/nEnQqJltMQhypdX2oDTNKCYjVnX3JGEzpTzbjdV+8zhHSplPDoj/?=
 =?us-ascii?Q?6qDNYeuimzGK3bw1ImJQgYF4+iWaw6YMjhMAndLyORF6si+VBNH6/CJOF30a?=
 =?us-ascii?Q?swXqGOpuBz2CClfUQXs7PQYHGBg9ei37aNQryPBdW6dM9cTUoVHoJa+gXuku?=
 =?us-ascii?Q?j4FYUbQxD/bRauqy/DMgA5snx+SPME5WhBvf3R3F0k23HbvWVBOV1lSh+ISD?=
 =?us-ascii?Q?bHFmdTMTV3RPd5nfcwG4Wke10JfaoY/9eoHv7zSrJDhdpLHodAa/yeoE+yAF?=
 =?us-ascii?Q?ExpH0RtAb1CClds24GeCt4TnisRMXxpQjxNnDT8F+r3/bllioT9Wi8wVg/CG?=
 =?us-ascii?Q?U0OrtV9d92aIPxepK1ZK4QdssqMwAE2PPDMD6CPOEg0+8XrYdhSYqfZ0Wa/Q?=
 =?us-ascii?Q?l7GqElGSBOIfA3tPrQH8oBBFmGZNlRoXDGcraOjvAoWowllSX8jOmcHVGzHf?=
 =?us-ascii?Q?/jjXio+psXSIrLPNqn8l/PGumL7PerDAzw4klv4zrdaQ2WgKkYhO+oGaL+ap?=
 =?us-ascii?Q?YzSnHnokDTryhmetsSTup8Hc+B3HuJacQntvGthQIInhI8qBhlTkrV2tLjv3?=
 =?us-ascii?Q?BPkkUYqTiEYptrXDBPZIuJygB1NSvOU5aDu7a+s/5NKNuvcEbDqGHK0o01fZ?=
 =?us-ascii?Q?MxVcLcBZp2LXOmsy+HzK6nniSLo02eUi66e7FkT+4yCMFVpJJSuglfiZFoev?=
 =?us-ascii?Q?DmjYD35BaNI9xn5tQYqWw6THul5kOGYKlFFxOzzvXgsF1u7a409el5iCLi6k?=
 =?us-ascii?Q?gvx/AXCiR2JsBkfxpBuJvZJqxSbitTT7FuBfjc72UJ7Oiq7B80v0IJU2ii/k?=
 =?us-ascii?Q?UlDBZ+11VgjfvBKtk88CXueD9vaJTojmu5nMPDw2ugNcwvy0GZe9ZNidEnJp?=
 =?us-ascii?Q?+DB9LASCAnE2aXM9LOXqHv0/VoJVJ4NQvSfxMS2Ena7x7KCDICcTtYDAoHP9?=
 =?us-ascii?Q?SUcyypJfQPP9yPvhPK57JRVgr3qr3Sus5Y54mE2o1norddyqHt4X5A6M3V+9?=
 =?us-ascii?Q?wjfobYXtjJZitL0iNl/S577RlbNf8oB86d9SEZlip1mKNg3qtkuetwFyC3sN?=
 =?us-ascii?Q?vercGmjfEHVGL7xzqmKPxIZ0IM7AWtYJQoFXTsQ+9Ce7GhvIJyyJKdUQsMVP?=
 =?us-ascii?Q?60cakic2JSyF90uHS6Maps7kfSRJKsXWSNEbFYa5CAcTllT3ftdDjiFxu0cl?=
 =?us-ascii?Q?sFjOsmTkWpt9F1ngIEvvQUDyiynHWhSmSQjanML3IuGWMHpjUHgBfY2+fkCq?=
 =?us-ascii?Q?4RdXx9dJXu66r5DfvOTLLH8fiFtC1dhT7Zif5lleJ5ZVYIiQS9lY/lFmMQDf?=
 =?us-ascii?Q?nO+MkFwReyUfsmWI0VTvTvN6B5//hrHWVVEZBkSxgN+IHtHIH38bGCHKJhrN?=
 =?us-ascii?Q?GUwknzMNUdlMiRYK3JZGn+YInS6kbg5Ca+VYc1R6U8gbkNNGby2mWr/3SWQc?=
 =?us-ascii?Q?jsPw5ldNQtjD4Uq5hC4AhbQ9EzzTeiklsKYd5R5VIVKmopOq/D5Wa2KDpGY0?=
 =?us-ascii?Q?N0tskWl6HeczR6RXdjoAwrrRKH9rhk7e/CWVdHSh/8Kgfl8xMUESyBzWU+wU?=
 =?us-ascii?Q?U36Oa3ak7awtNixiWlHJ/S92PUePq3ZfhJzYxI88?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e075caa7-782b-4c3d-0e8d-08db61e2ebdf
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:25:45.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOZUpOjrhZEyfn4aMDA6FNOZqsUicQbz/NpzAKRSr6/PvUmawfHYOzdSJDv2VqV9FX4LR4c2dXkH+12f8hvfRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_09,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Rename common module to inv_sensors_timestamp, add configuration
at init (chip internal clock, acceptable jitter, ...) and update
inv_icm42600 driver integration.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/inv_sensors/Makefile       |  2 +-
 ...00_timestamp.c => inv_sensors_timestamp.c} | 89 +++++++++----------
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 32 ++++---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 30 +++----
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 32 ++++---
 .../linux/iio/common/inv_icm42600_timestamp.h | 81 -----------------
 .../linux/iio/common/inv_sensors_timestamp.h  | 89 +++++++++++++++++++
 8 files changed, 189 insertions(+), 167 deletions(-)
 rename drivers/iio/common/inv_sensors/{inv_icm42600_timestamp.c => inv_sensors_timestamp.c} (57%)
 delete mode 100644 include/linux/iio/common/inv_icm42600_timestamp.h
 create mode 100644 include/linux/iio/common/inv_sensors_timestamp.h

diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/common/inv_sensors/Makefile
index 93bddb9356b8..dcf39f249112 100644
--- a/drivers/iio/common/inv_sensors/Makefile
+++ b/drivers/iio/common/inv_sensors/Makefile
@@ -3,4 +3,4 @@
 # Makefile for TDK-InvenSense sensors module.
 #
 
-obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_icm42600_timestamp.o
+obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_sensors_timestamp.o
diff --git a/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
similarity index 57%
rename from drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
rename to drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 411f561e1a24..060191ef3125 100644
--- a/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -7,20 +7,18 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
-
-/* internal chip period is 32kHz, 31250ns */
-#define INV_ICM42600_TIMESTAMP_PERIOD		31250
-/* allow a jitter of +/- 2% */
-#define INV_ICM42600_TIMESTAMP_JITTER		2
-/* compute min and max periods accepted */
-#define INV_ICM42600_TIMESTAMP_MIN_PERIOD(_p)		\
-	(((_p) * (100 - INV_ICM42600_TIMESTAMP_JITTER)) / 100)
-#define INV_ICM42600_TIMESTAMP_MAX_PERIOD(_p)		\
-	(((_p) * (100 + INV_ICM42600_TIMESTAMP_JITTER)) / 100)
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
+/* compute jitter, min and max following jitter in per mille */
+#define INV_SENSORS_TIMESTAMP_JITTER(_val, _jitter)		\
+	(div_s64((_val) * (_jitter), 1000))
+#define INV_SENSORS_TIMESTAMP_MIN(_val, _jitter)		\
+	(((_val) * (1000 - (_jitter))) / 1000)
+#define INV_SENSORS_TIMESTAMP_MAX(_val, _jitter)		\
+	(((_val) * (1000 + (_jitter))) / 1000)
 
 /* Add a new value inside an accumulator and update the estimate value */
-static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint32_t val)
+static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, uint32_t val)
 {
 	uint64_t sum = 0;
 	size_t i;
@@ -39,56 +37,57 @@ static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint32_t val)
 	acc->val = div_u64(sum, i);
 }
 
-void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
-				 uint32_t period)
+void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
+				const struct inv_sensors_timestamp_chip *chip)
 {
-	/* initial odr for sensor after reset is 1kHz */
-	const uint32_t default_period = 1000000;
+	memset(ts, 0, sizeof(*ts));
+
+	/* save chip parameters and compute min and max clock period */
+	ts->chip = *chip;
+	ts->min_period = INV_SENSORS_TIMESTAMP_MIN(chip->clock_period, chip->jitter);
+	ts->max_period = INV_SENSORS_TIMESTAMP_MAX(chip->clock_period, chip->jitter);
 
 	/* current multiplier and period values after reset */
-	ts->mult = default_period / INV_ICM42600_TIMESTAMP_PERIOD;
-	ts->period = default_period;
-	/* new set multiplier is the one from chip initialization */
-	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+	ts->mult = chip->init_period / chip->clock_period;
+	ts->period = chip->init_period;
 
 	/* use theoretical value for chip period */
-	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
+	inv_update_acc(&ts->chip_period, chip->clock_period);
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
 
-int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t period, bool fifo)
+int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t period, bool fifo)
 {
 	/* when FIFO is on, prevent odr change if one is already pending */
 	if (fifo && ts->new_mult != 0)
 		return -EAGAIN;
 
-	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+	ts->new_mult = period / ts->chip.clock_period;
 
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
-static bool inv_validate_period(uint32_t period, uint32_t mult)
+static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period, uint32_t mult)
 {
-	const uint32_t chip_period = INV_ICM42600_TIMESTAMP_PERIOD;
 	uint32_t period_min, period_max;
 
 	/* check that period is acceptable */
-	period_min = INV_ICM42600_TIMESTAMP_MIN_PERIOD(chip_period) * mult;
-	period_max = INV_ICM42600_TIMESTAMP_MAX_PERIOD(chip_period) * mult;
+	period_min = ts->min_period * mult;
+	period_max = ts->max_period * mult;
 	if (period > period_min && period < period_max)
 		return true;
 	else
 		return false;
 }
 
-static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,
-				   uint32_t mult, uint32_t period)
+static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
+				    uint32_t mult, uint32_t period)
 {
 	uint32_t new_chip_period;
 
-	if (!inv_validate_period(period, mult))
+	if (!inv_validate_period(ts, period, mult))
 		return false;
 
 	/* update chip internal period estimation */
@@ -99,7 +98,7 @@ static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,
 	return true;
 }
 
-static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
+static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 {
 	int64_t delta, jitter;
 	int64_t adjust;
@@ -108,7 +107,7 @@ static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
 	delta = ts->it.lo - ts->timestamp;
 
 	/* adjust timestamp while respecting jitter */
-	jitter = div_s64((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JITTER, 100);
+	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
 	if (delta > jitter)
 		adjust = jitter;
 	else if (delta < -jitter)
@@ -119,13 +118,13 @@ static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
 	ts->timestamp += adjust;
 }
 
-void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
+void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 				      uint32_t fifo_period, size_t fifo_nb,
 				      size_t sensor_nb, int64_t timestamp)
 {
-	struct inv_icm42600_timestamp_interval *it;
+	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
-	const uint32_t fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
 	uint32_t period = ts->period;
 	bool valid = false;
 
@@ -151,15 +150,15 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 		return;
 	}
 
-	/* if interrupt interval is valid, sync with interrupt timestamp */
+	/* if interrupt interval is valid, align with interrupt timestamp */
 	if (valid)
 		inv_align_timestamp_it(ts);
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
 
-void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      unsigned int fifo_no)
+void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t fifo_period, size_t fifo_nb,
+				     unsigned int fifo_no)
 {
 	int64_t interval;
 	uint32_t fifo_mult;
@@ -180,14 +179,14 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
 	 */
 	if (ts->timestamp != 0) {
 		/* compute measured fifo period */
-		fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+		fifo_mult = fifo_period / ts->chip.clock_period;
 		fifo_period = fifo_mult * ts->chip_period.val;
 		/* computes time interval between interrupt and this sample */
 		interval = (int64_t)(fifo_nb - fifo_no) * (int64_t)fifo_period;
 		ts->timestamp = ts->it.up - interval;
 	}
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
 
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense sensors timestamp module");
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 1015de636a94..795f31b47318 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -12,7 +12,7 @@
 #include <linux/math64.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
@@ -98,7 +98,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -126,7 +126,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -311,7 +311,7 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 					int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -330,8 +330,8 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
-						iio_buffer_enabled(indio_dev));
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
 	if (ret)
 		goto out_unlock;
 
@@ -707,7 +707,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -719,8 +720,15 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	ts = iio_priv(indio_dev);
-	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.accel.odr));
+	inv_sensors_timestamp_init(ts, &ts_chip);
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
@@ -745,7 +753,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
@@ -768,15 +776,15 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 
 		/* update odr */
 		if (odr & INV_ICM42600_SENSOR_ACCEL)
-			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
-							 st->fifo.nb.total, no);
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
 
 		/* buffer is copied to userspace, zeroing it to avoid any data leak */
 		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-		ts_val = inv_icm42600_timestamp_pop(ts);
+		ts_val = inv_sensors_timestamp_pop(ts);
 		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 4a39d31e911f..42a4a1a52d60 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -11,7 +11,7 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
@@ -275,12 +275,12 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(dev);
 
 	mutex_lock(&st->lock);
-	inv_icm42600_timestamp_reset(ts);
+	inv_sensors_timestamp_reset(ts);
 	mutex_unlock(&st->lock);
 
 	return 0;
@@ -504,7 +504,7 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 
 int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 {
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp *ts;
 	int ret;
 
 	if (st->fifo.nb.total == 0)
@@ -512,8 +512,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle gyroscope timestamp and FIFO data parsing */
 	ts = iio_priv(st->indio_gyro);
-	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					 st->fifo.nb.gyro, st->timestamp.gyro);
+	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
@@ -522,8 +522,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle accelerometer timestamp and FIFO data parsing */
 	ts = iio_priv(st->indio_accel);
-	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					 st->fifo.nb.accel, st->timestamp.accel);
+	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
@@ -536,7 +536,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 				     unsigned int count)
 {
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp *ts;
 	int64_t gyro_ts, accel_ts;
 	int ret;
 
@@ -552,9 +552,9 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.gyro > 0) {
 		ts = iio_priv(st->indio_gyro);
-		inv_icm42600_timestamp_interrupt(ts, st->fifo.period,
-						 st->fifo.nb.total, st->fifo.nb.gyro,
-						 gyro_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
+						st->fifo.nb.total, st->fifo.nb.gyro,
+						gyro_ts);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
@@ -562,9 +562,9 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.accel > 0) {
 		ts = iio_priv(st->indio_accel);
-		inv_icm42600_timestamp_interrupt(ts, st->fifo.period,
-						 st->fifo.nb.total, st->fifo.nb.accel,
-						 accel_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
+						st->fifo.nb.total, st->fifo.nb.accel,
+						accel_ts);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index f3e379f9733d..0eb11911f786 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -16,7 +16,6 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 6caea7b8a344..57dd7324e9e9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -12,7 +12,7 @@
 #include <linux/math64.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
@@ -98,7 +98,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -126,7 +126,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -323,7 +323,7 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 				       int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -342,8 +342,8 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
-						iio_buffer_enabled(indio_dev));
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
 	if (ret)
 		goto out_unlock;
 
@@ -718,7 +718,8 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -730,8 +731,15 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	ts = iio_priv(indio_dev);
-	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.gyro.odr));
+	inv_sensors_timestamp_init(ts, &ts_chip);
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
@@ -757,7 +765,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
@@ -780,15 +788,15 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 
 		/* update odr */
 		if (odr & INV_ICM42600_SENSOR_GYRO)
-			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
-							 st->fifo.nb.total, no);
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
 
 		/* buffer is copied to userspace, zeroing it to avoid any data leak */
 		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-		ts_val = inv_icm42600_timestamp_pop(ts);
+		ts_val = inv_sensors_timestamp_pop(ts);
 		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
diff --git a/include/linux/iio/common/inv_icm42600_timestamp.h b/include/linux/iio/common/inv_icm42600_timestamp.h
deleted file mode 100644
index 00fd452632a3..000000000000
--- a/include/linux/iio/common/inv_icm42600_timestamp.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2020 Invensense, Inc.
- */
-
-#ifndef INV_ICM42600_TIMESTAMP_H_
-#define INV_ICM42600_TIMESTAMP_H_
-
-#include <linux/kernel.h>
-
-/**
- * struct inv_icm42600_timestamp_interval - timestamps interval
- * @lo:	interval lower bound
- * @up:	interval upper bound
- */
-struct inv_icm42600_timestamp_interval {
-	int64_t lo;
-	int64_t up;
-};
-
-/**
- * struct inv_icm42600_timestamp_acc - accumulator for computing an estimation
- * @val:	current estimation of the value, the mean of all values
- * @idx:	current index of the next free place in values table
- * @values:	table of all measured values, use for computing the mean
- */
-struct inv_icm42600_timestamp_acc {
-	uint32_t val;
-	size_t idx;
-	uint32_t values[32];
-};
-
-/**
- * struct inv_icm42600_timestamp - timestamp management states
- * @it:			interrupts interval timestamps
- * @timestamp:		store last timestamp for computing next data timestamp
- * @mult:		current internal period multiplier
- * @new_mult:		new set internal period multiplier (not yet effective)
- * @period:		measured current period of the sensor
- * @chip_period:	accumulator for computing internal chip period
- */
-struct inv_icm42600_timestamp {
-	struct inv_icm42600_timestamp_interval it;
-	int64_t timestamp;
-	uint32_t mult;
-	uint32_t new_mult;
-	uint32_t period;
-	struct inv_icm42600_timestamp_acc chip_period;
-};
-
-void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
-				 uint32_t period);
-
-int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t period, bool fifo);
-
-void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      size_t sensor_nb, int64_t timestamp);
-
-static inline int64_t
-inv_icm42600_timestamp_pop(struct inv_icm42600_timestamp *ts)
-{
-	ts->timestamp += ts->period;
-	return ts->timestamp;
-}
-
-void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      unsigned int fifo_no);
-
-static inline void
-inv_icm42600_timestamp_reset(struct inv_icm42600_timestamp *ts)
-{
-	const struct inv_icm42600_timestamp_interval interval_init = {0LL, 0LL};
-
-	ts->it = interval_init;
-	ts->timestamp = 0;
-}
-
-#endif
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
new file mode 100644
index 000000000000..23440bc7322c
--- /dev/null
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_SENSORS_TIMESTAMP_H_
+#define INV_SENSORS_TIMESTAMP_H_
+
+#include <linux/kernel.h>
+
+struct inv_sensors_timestamp_chip {
+	uint32_t clock_period;
+	uint32_t jitter;
+	uint32_t init_period;
+};
+
+/**
+ * struct inv_sensors_timestamp_interval - timestamps interval
+ * @lo:	interval lower bound
+ * @up:	interval upper bound
+ */
+struct inv_sensors_timestamp_interval {
+	int64_t lo;
+	int64_t up;
+};
+
+/**
+ * struct inv_sensors_timestamp_acc - accumulator for computing an estimation
+ * @val:	current estimation of the value, the mean of all values
+ * @idx:	current index of the next free place in values table
+ * @values:	table of all measured values, use for computing the mean
+ */
+struct inv_sensors_timestamp_acc {
+	uint32_t val;
+	size_t idx;
+	uint32_t values[32];
+};
+
+/**
+ * struct inv_sensors_timestamp - timestamp management states
+ * @chip:		chip internal characteristics
+ * @it:			interrupts interval timestamps
+ * @timestamp:		store last timestamp for computing next data timestamp
+ * @mult:		current internal period multiplier
+ * @new_mult:		new set internal period multiplier (not yet effective)
+ * @period:		measured current period of the sensor
+ * @chip_period:	accumulator for computing internal chip period
+ */
+struct inv_sensors_timestamp {
+	struct inv_sensors_timestamp_chip chip;
+	uint32_t min_period;
+	uint32_t max_period;
+	struct inv_sensors_timestamp_interval it;
+	int64_t timestamp;
+	uint32_t mult;
+	uint32_t new_mult;
+	uint32_t period;
+	struct inv_sensors_timestamp_acc chip_period;
+};
+
+void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
+				const struct inv_sensors_timestamp_chip *chip);
+
+int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t period, bool fifo);
+
+void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
+				     uint32_t fifo_period, size_t fifo_nb,
+				     size_t sensor_nb, int64_t timestamp);
+
+static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
+{
+	ts->timestamp += ts->period;
+	return ts->timestamp;
+}
+
+void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t fifo_period, size_t fifo_nb,
+				     unsigned int fifo_no);
+
+static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
+{
+	const struct inv_sensors_timestamp_interval interval_init = {0LL, 0LL};
+
+	ts->it = interval_init;
+	ts->timestamp = 0;
+}
+
+#endif
-- 
2.34.1

