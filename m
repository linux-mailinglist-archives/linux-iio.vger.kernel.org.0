Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AD26E0AD
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgIQQ1K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 12:27:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45024 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728462AbgIQQ1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 12:27:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HFTarl001165;
        Thu, 17 Sep 2020 11:50:53 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p677tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 11:50:52 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08HFopVi011800
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Sep 2020 11:50:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 17 Sep 2020 11:50:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 17 Sep 2020 11:50:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 17 Sep 2020 11:50:57 -0400
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08HFojFK030124;
        Thu, 17 Sep 2020 11:50:48 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] iio: adis16400: Drop adis_burst usage
Date:   Thu, 17 Sep 2020 17:52:21 +0200
Message-ID: <20200917155223.218500-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917155223.218500-1-nuno.sa@analog.com>
References: <20200917155223.218500-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_10:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=1
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170119
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Burst mode variables are now part of the `adis_data` struct. The driver
also has now to explicitly define the length of the burst buffer.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 889c8c2a19f4..421b1988c1d4 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -317,11 +317,6 @@ enum adis16400_chip_variant {
 	ADIS16448,
 };
 
-static struct adis_burst adis16400_burst = {
-	.en = true,
-	.reg_cmd = ADIS16400_GLOB_CMD,
-};
-
 static int adis16334_get_freq(struct adis16400_state *st)
 {
 	int ret;
@@ -947,7 +942,7 @@ static const char * const adis16400_status_error_msgs[] = {
 	[ADIS16400_DIAG_STAT_POWER_LOW] = "Power supply below 4.75V",
 };
 
-#define ADIS16400_DATA(_timeouts)					\
+#define ADIS16400_DATA(_timeouts, _burst_len)				\
 {									\
 	.msc_ctrl_reg = ADIS16400_MSC_CTRL,				\
 	.glob_cmd_reg = ADIS16400_GLOB_CMD,				\
@@ -973,6 +968,8 @@ static const char * const adis16400_status_error_msgs[] = {
 		BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |			\
 		BIT(ADIS16400_DIAG_STAT_POWER_LOW),			\
 	.timeouts = (_timeouts),					\
+	.burst_reg_cmd = ADIS16400_GLOB_CMD,				\
+	.burst_len = (_burst_len)					\
 }
 
 static const struct adis_timeout adis16300_timeouts = {
@@ -1023,7 +1020,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 18),
 	},
 	[ADIS16334] = {
 		.channels = adis16334_channels,
@@ -1036,7 +1033,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16334_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16334_timeouts, 0),
 	},
 	[ADIS16350] = {
 		.channels = adis16350_channels,
@@ -1048,7 +1045,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 0),
 	},
 	[ADIS16360] = {
 		.channels = adis16350_channels,
@@ -1061,7 +1058,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
 	},
 	[ADIS16362] = {
 		.channels = adis16350_channels,
@@ -1074,7 +1071,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16362_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
 	},
 	[ADIS16364] = {
 		.channels = adis16350_channels,
@@ -1087,7 +1084,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16362_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
 	},
 	[ADIS16367] = {
 		.channels = adis16350_channels,
@@ -1100,7 +1097,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
 	},
 	[ADIS16400] = {
 		.channels = adis16400_channels,
@@ -1112,7 +1109,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16400_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16400_timeouts, 24),
 	},
 	[ADIS16445] = {
 		.channels = adis16445_channels,
@@ -1126,7 +1123,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16445_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16445_timeouts, 16),
 	},
 	[ADIS16448] = {
 		.channels = adis16448_channels,
@@ -1140,7 +1137,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16448_timeouts),
+		.adis_data = ADIS16400_DATA(&adis16448_timeouts, 24),
 	}
 };
 
@@ -1196,9 +1193,6 @@ static int adis16400_probe(struct spi_device *spi)
 	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
 		adis16400_setup_chan_mask(st);
 		indio_dev->available_scan_masks = st->avail_scan_mask;
-		st->adis.burst = &adis16400_burst;
-		if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
-			st->adis.burst_extra_len = sizeof(u16);
 	}
 
 	adis16400_data = &st->variant->adis_data;
-- 
2.28.0

