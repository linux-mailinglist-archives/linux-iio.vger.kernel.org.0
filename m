Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D07248E7
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbjFFQWr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjFFQWp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 12:22:45 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F71E40
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 09:22:42 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3568m9s9005040;
        Tue, 6 Jun 2023 16:22:21 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2111.outbound.protection.outlook.com [104.47.23.111])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qyxvgj55s-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTgrqCJzYwgmte936OAZ5seeXwGVJoQbQaPtAxKHdUCMd3OXeD4gpq463wGySEjCbp6OGRknuNVMhosgKrnf0Pn7BdjfvtchMH4FFpqT/FhuypJ6b+1r9w+zv/pOcg2cET+PIzU375pI3pKPc4FmIEQM/qL396C28k936fTNHQemjH9rvo9Tav0wwGiUCUe9wNsfjhRAimUdnIV9ONyGU+JycIqPmdlwaddpbRH6OkP7kDzRRNAT9VVNhTUr9EFFc/mIjAF64iXuw4GtDCcaY9YXqrr/XDfH6nv4gBv1VLc9sMN3RBEfYnUOtWQ8ZFXktLgxRlIcaj9o5PS4+tTvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91m4jX5cnpdJX6OlwIy0jlgHXkN2VA/WCnPhaG+53d8=;
 b=nMH0ZjdoI4z3hftPHp1SMTorgi1HccgSMDkzx9k0DM5X+fQzh6/U/UyZLeReqqWCkZuE5h81iuBUx6kqZ8EM6VXaEjfmfBgGVtnFxrXvJPV92l42iJLF9bsNKJQVY/glbx8wdXpVoW+RXIP3KaxRcEg8kDoCWP4EeQNUI1ZybZaZobVuVapJgBh+icgi58k2c7gIbYrxFxTHM104ZrIUZFV13Cd18K+kINSbHDXiVIrShJXrjK4zBdl8PbFwjouiIW/bItVxHOebFpvygmuviyuaCbHXwSK1huWNNndyqm1eP7uzpqEpD/ACC+X5ziNFDZFop0/EZZNjLemO4H6WPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91m4jX5cnpdJX6OlwIy0jlgHXkN2VA/WCnPhaG+53d8=;
 b=elsKr2Xgz84rzXwV+Iw4MjRFOXeH9ODkl/gKY0EAdDXk+tuGmey1UgOyHwt0KvApmG3nXV1OGYTZRB37MFzBzCIwFgHjdjX0eF7OEIawedKY0nyALzgGkdj9Y7NFLJMZZJ43hCEM8jvu9EwCUhoWPU6lCvRBVSXg2eO/CaZmeoPLHRfBwBLdz8H9dKcHKxY4kqhDOlVpGP9vVKfrs5KYM2uSVgl2UMrYkEkbeGmW3qu41toZ7GPbC6b+k8QFJH00tf6wbAIxpJZ0vi7VlQA1o9K+m1DP9PC8aOmFrfff0Uz4uYS1AW8nA05RocsasFK11/0rWSn9d+HghF2XOheiJA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB2179.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 16:22:17 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:17 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 3/4] iio: make invensense timestamp module generic
Date:   Tue,  6 Jun 2023 16:21:46 +0000
Message-Id: <20230606162147.79667-4-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606162147.79667-1-inv.git-commit@tdk.com>
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB2179:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a07c113-865e-48be-b7af-08db66aa2fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thUwgeyO8C328LRpQQSanufm3fPkoYzDkiYlkoX26Z8/BP4qlaYeJzqFnxiNc32oGSeDm4cSNGpUZ87LnLnkiLh0SVPdX2OfGvnMqhXrV+p/gkO1s7el8JUv0qhtYxWLaiZGucT8cYv3c7TLVqP3Hnv7X6/aHmElWoxcUFghLFtgHx/LKAQWO7CZa2NSW/5Ke9VbfLjGF8CjCDSlmABM8N6nECyCSZXm8NtknuLynbC9iq/sbNZ7309R3FemMUsdFWe16/YoXpGhFnPj6BuLWeQQXCgUJFmz5gXm2se6Ok13+u6qaGHZ/QBL1jr4/8O91yOm59ay4b/sGWl77fTYtaiVmaDRdGockQu55CTh4JL9PGbsR7WyLODzp71VwGaLU53DpnoEslRqU8+KU4xjp8ZSpB3fXm0OaxqZzHMKtxPpCmUh94i/DNrQ6QHs7emopZFTsRXCsL3I2BqMAeXfYowexM38IFQEw5LCZiox4XsqA1FTWcf/x/XbZCf4muHTfXg7GdS6KjXhwel6AQTzdvoBbM0fU2QJJds9CEj7yhngtpsRypXERT9yIyyzR8HRzh3e1W6+jqdZlKdJygOD5eqsofgcOtFhfAaY9Q8FdHXKgM2mpTUGF4UP8CAOYvglOb3sDTx7kWVAX6uncoDwlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(5660300002)(6666004)(8936002)(8676002)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(38350700002)(38100700002)(2906002)(30864003)(1076003)(26005)(6506007)(6512007)(9686003)(86362001)(186003)(2616005)(83380400001)(52116002)(6486002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mstw4D2ntX3HQMUksBKIRfpk+FC3W/7uF+CXcIObnattW2GClC/DODgItqtS?=
 =?us-ascii?Q?Sa0GrRUEPVSZerheaHborDSvMjBntZNVRo5ce6ZY/fD7q+TcjaJA6+AazdS4?=
 =?us-ascii?Q?+HVlllKDOALBuCfapnLuz6G7IBZA1deTN1qBjckASfns6fYdOfaSLfthszTx?=
 =?us-ascii?Q?GMwCIC3AdYqsJGxaz4hZ4WIQeyOiSs6VPGjCuBFurgNbsjRW0b3im/ijwci+?=
 =?us-ascii?Q?KHFuz/oyLmf4dkqMPXblBbRLImevuia235VscLULy5/lC+fap1ANYiNkgCaG?=
 =?us-ascii?Q?Zp4pwtNj8u6WpNNrFeRV23ecDe+UcezQ7F2N0yWv/+R83ErmP1ASnq+Fl+HV?=
 =?us-ascii?Q?YvAIe3hRDbjkPXTGgBUeQz9HTK4txMRjCd493VbaKfgbZzyN6xH+YtAjNn9b?=
 =?us-ascii?Q?79jOy8pVMr3AxKncGU0roIDE5N6U4x6MM/jev3+EXYEYZPMxyz14O+RwcdZh?=
 =?us-ascii?Q?bv9FRB3vlW1T8zzPU2LnUQzCTK+udeqpfljM9Sh6nnNG7yy2ESBddPXOEaWg?=
 =?us-ascii?Q?J3WA54iWhDSxI3nA58mAFdUZlbN+Fz+ItiBedy9CC7yMpmcIAI9RnxFs+Vt/?=
 =?us-ascii?Q?J8RnNEdI1MmrtoQwwGYTcXopHAJXM2Gp54JxRfhI1mOXJOwlOHfo8q/lu7vZ?=
 =?us-ascii?Q?dIkeN5pKHcGqSAl+oBADpR4OXIzicPM2BStgcZksXhaQjbS74eKY/LPuNfwK?=
 =?us-ascii?Q?6Muup8C5PLgSvi1xWq2fh2IT/9YbPKetg2muxZbc3M0Cm68pM02442RSUmSu?=
 =?us-ascii?Q?fMN6AHF1eIuzzY0Vq5uRoyQEtEw/PGA/9FAC4R4QE8A8EsuH6M003RuRJjVW?=
 =?us-ascii?Q?Hgwr1Gm9UpYrD2Qhd6CG5wOtJffjjJjmmj4l8Qgm9Bn3xR7nMmJHjJSiLIFY?=
 =?us-ascii?Q?C/6yLnRgpWvpDxlbE5ibSpjJcSupu5/tAC+o3VxG3VhsElbCaRG5yddgbhPc?=
 =?us-ascii?Q?IMNKSD9txFvjg3FBWVbYl+QQ+MfaS/pVT9hcI/o9ZkVnYHIzgJf5Y+dXm1nC?=
 =?us-ascii?Q?4r6ltC4iYeL//j2yvsHgXe22+K32sACMc+YbWsnrwY00fyLy0/pSPPlwQxXt?=
 =?us-ascii?Q?aS48HqBHb1iZ/mk1qE/gsvdJXzX91ye5jLpvmtmMiTRy9t9gbFYkR6d7AqRV?=
 =?us-ascii?Q?WjTY5Ar21sIpZyuugXaDOXIkI6SBK5EmuRa4mUUPtUIgMaBk+mDOtpKsl18r?=
 =?us-ascii?Q?9ezMb2mX79OhBDsoxUkVEG8ayqOt3FRPfzcknOynNFusCKEv+Zlek5cR6aRp?=
 =?us-ascii?Q?GhfmwnusGTlnH2yCcvK5cNiJUH+eN3j6ftLvwA6I2rFuvRfVOzevnAOMB05C?=
 =?us-ascii?Q?PpzIWz2Vrco+QWEMLH6UnUqip/L/oCzcyMNPJ60rsyrL2WZq563m2jQ3U7eL?=
 =?us-ascii?Q?EX4TLLDFtF3PLWrztdvXqvYDJHLAaLPnm/YfGC/musxYTxzSD5jaJU0j4Nlf?=
 =?us-ascii?Q?hMQdHbTSy+U6sYjKfAKBYRyELxKGsQ9fkjy3KsmD0jkMCNkjMil4ch88OgBH?=
 =?us-ascii?Q?4FlD/xm6vmvzFqvoHqOGGV8VVjPBgiwqrLwBOronZAFpCoqKq40iD03iuyyD?=
 =?us-ascii?Q?7PXk/d2x4aENVIRbzWTzuinJuN+q0lX8R94Y41hK?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a07c113-865e-48be-b7af-08db66aa2fd4
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:22:14.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxSzS+pVSnqQRDKwsz/B2qDgfY6axBnIzxK8c8Hh7u9qRiQUmNx1hL4BMXrbHwg6ujR2Bvtas2ZOWGheRZKg1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 ...00_timestamp.c => inv_sensors_timestamp.c} | 87 +++++++++--------
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 32 ++++---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 30 +++---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 32 ++++---
 .../linux/iio/common/inv_icm42600_timestamp.h | 79 ---------------
 .../linux/iio/common/inv_sensors_timestamp.h  | 95 +++++++++++++++++++
 8 files changed, 194 insertions(+), 164 deletions(-)
 rename drivers/iio/common/inv_sensors/{inv_icm42600_timestamp.c => inv_sensors_timestamp.c} (58%)
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
similarity index 58%
rename from drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
rename to drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 7cd80cdf0ee5..03823ee57f59 100644
--- a/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -8,20 +8,18 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 
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
@@ -40,56 +38,57 @@ static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint32_t val)
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
@@ -100,7 +99,7 @@ static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,
 	return true;
 }
 
-static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
+static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 {
 	int64_t delta, jitter;
 	int64_t adjust;
@@ -109,7 +108,7 @@ static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
 	delta = ts->it.lo - ts->timestamp;
 
 	/* adjust timestamp while respecting jitter */
-	jitter = div_s64((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JITTER, 100);
+	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
 	if (delta > jitter)
 		adjust = jitter;
 	else if (delta < -jitter)
@@ -120,13 +119,13 @@ static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
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
 
@@ -156,11 +155,11 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
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
@@ -181,14 +180,14 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
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
index c2591101645a..b1e4fde27d25 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -12,7 +12,7 @@
 #include <linux/math64.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
@@ -99,7 +99,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -127,7 +127,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -312,7 +312,7 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 					int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -331,8 +331,8 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
-						iio_buffer_enabled(indio_dev));
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
 	if (ret)
 		goto out_unlock;
 
@@ -708,7 +708,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -720,8 +721,15 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
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
@@ -746,7 +754,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
@@ -769,15 +777,15 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 
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
index ba4bb389a9fc..6ef1df9d60b7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -11,7 +11,7 @@
 #include <linux/delay.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
@@ -276,12 +276,12 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
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
@@ -505,7 +505,7 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 
 int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 {
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp *ts;
 	int ret;
 
 	if (st->fifo.nb.total == 0)
@@ -513,8 +513,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle gyroscope timestamp and FIFO data parsing */
 	ts = iio_priv(st->indio_gyro);
-	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					 st->fifo.nb.gyro, st->timestamp.gyro);
+	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
@@ -523,8 +523,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle accelerometer timestamp and FIFO data parsing */
 	ts = iio_priv(st->indio_accel);
-	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					 st->fifo.nb.accel, st->timestamp.accel);
+	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
@@ -537,7 +537,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 				     unsigned int count)
 {
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp *ts;
 	int64_t gyro_ts, accel_ts;
 	int ret;
 
@@ -553,9 +553,9 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
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
@@ -563,9 +563,9 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
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
index 9d227b4776eb..a5e81906e37e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -16,7 +16,6 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 
-#include <linux/iio/common/inv_icm42600_timestamp.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 0ea3d8bf709d..3bf946e56e1d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -12,7 +12,7 @@
 #include <linux/math64.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
@@ -99,7 +99,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -127,7 +127,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -324,7 +324,7 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 				       int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -343,8 +343,8 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
-						iio_buffer_enabled(indio_dev));
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
 	if (ret)
 		goto out_unlock;
 
@@ -719,7 +719,8 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -731,8 +732,15 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
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
@@ -758,7 +766,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
@@ -781,15 +789,15 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 
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
index b808a6da15e5..000000000000
--- a/include/linux/iio/common/inv_icm42600_timestamp.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2020 Invensense, Inc.
- */
-
-#ifndef INV_ICM42600_TIMESTAMP_H_
-#define INV_ICM42600_TIMESTAMP_H_
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
index 000000000000..a47d304d1ba7
--- /dev/null
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_SENSORS_TIMESTAMP_H_
+#define INV_SENSORS_TIMESTAMP_H_
+
+/**
+ * struct inv_sensors_timestamp_chip - chip internal properties
+ * @clock_period:	internal clock period in ns
+ * @jitter:		acceptable jitter in per-mille
+ * @init_period:	chip initial period at reset in ns
+ */
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
+ * @min_period:		minimal acceptable clock period
+ * @max_period:		maximal acceptable clock period
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

