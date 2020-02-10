Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA30157B3D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgBJN2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:28:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5300 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727870AbgBJN2k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:40 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADOCwU009666;
        Mon, 10 Feb 2020 08:28:39 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1tyq81ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:38 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSae3058031
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:37 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 05:28:35 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 05:28:27 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 05:28:35 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZl017670;
        Mon, 10 Feb 2020 08:28:33 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/9] iio: imu: adis16400: initialize adis_data statically
Date:   Mon, 10 Feb 2020 15:25:59 +0200
Message-ID: <20200210132606.9315-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change overrides commit 380b107bbf944 ("iio: adis: Introduce timeouts
structure"). It removes the memory allocation and moves the 'adis_data'
information to be static on the chip_info struct.

This also adds a timeout structure to ADIS16334, since it was initially
omitted. This was omitted (by accident) when the change was done.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400.c | 139 ++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index cfb1c19eb930..1c0770e03ec9 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -156,7 +156,7 @@ struct adis16400_state;
 
 struct adis16400_chip_info {
 	const struct iio_chan_spec *channels;
-	const struct adis_timeout *timeouts;
+	const struct adis_data adis_data;
 	const int num_channels;
 	const long flags;
 	unsigned int gyro_scale_micro;
@@ -930,12 +930,63 @@ static const struct iio_chan_spec adis16334_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(ADIS16400_SCAN_TIMESTAMP),
 };
 
+static const char * const adis16400_status_error_msgs[] = {
+	[ADIS16400_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
+	[ADIS16400_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
+	[ADIS16400_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
+	[ADIS16400_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
+	[ADIS16400_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
+	[ADIS16400_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
+	[ADIS16400_DIAG_STAT_ALARM2] = "Alarm 2 active",
+	[ADIS16400_DIAG_STAT_ALARM1] = "Alarm 1 active",
+	[ADIS16400_DIAG_STAT_FLASH_CHK] = "Flash checksum error",
+	[ADIS16400_DIAG_STAT_SELF_TEST] = "Self test error",
+	[ADIS16400_DIAG_STAT_OVERFLOW] = "Sensor overrange",
+	[ADIS16400_DIAG_STAT_SPI_FAIL] = "SPI failure",
+	[ADIS16400_DIAG_STAT_FLASH_UPT] = "Flash update failed",
+	[ADIS16400_DIAG_STAT_POWER_HIGH] = "Power supply above 5.25V",
+	[ADIS16400_DIAG_STAT_POWER_LOW] = "Power supply below 4.75V",
+};
+
+#define ADIS16400_DATA(_timeouts)					\
+{									\
+	.msc_ctrl_reg = ADIS16400_MSC_CTRL,				\
+	.glob_cmd_reg = ADIS16400_GLOB_CMD,				\
+	.diag_stat_reg = ADIS16400_DIAG_STAT,				\
+	.read_delay = 50,						\
+	.write_delay = 50,						\
+	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,			\
+	.status_error_msgs = adis16400_status_error_msgs,		\
+	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |	\
+		BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |			\
+		BIT(ADIS16400_DIAG_STAT_XACCL_FAIL) |			\
+		BIT(ADIS16400_DIAG_STAT_XGYRO_FAIL) |			\
+		BIT(ADIS16400_DIAG_STAT_YGYRO_FAIL) |			\
+		BIT(ADIS16400_DIAG_STAT_ZGYRO_FAIL) |			\
+		BIT(ADIS16400_DIAG_STAT_ALARM2) |			\
+		BIT(ADIS16400_DIAG_STAT_ALARM1) |			\
+		BIT(ADIS16400_DIAG_STAT_FLASH_CHK) |			\
+		BIT(ADIS16400_DIAG_STAT_SELF_TEST) |			\
+		BIT(ADIS16400_DIAG_STAT_OVERFLOW) |			\
+		BIT(ADIS16400_DIAG_STAT_SPI_FAIL) |			\
+		BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |			\
+		BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |			\
+		BIT(ADIS16400_DIAG_STAT_POWER_LOW),			\
+	.timeouts = (_timeouts),					\
+}
+
 static const struct adis_timeout adis16300_timeouts = {
 	.reset_ms = ADIS16400_STARTUP_DELAY,
 	.sw_reset_ms = ADIS16400_STARTUP_DELAY,
 	.self_test_ms = ADIS16400_STARTUP_DELAY,
 };
 
+static const struct adis_timeout adis16334_timeouts = {
+	.reset_ms = 60,
+	.sw_reset_ms = 60,
+	.self_test_ms = 14,
+};
+
 static const struct adis_timeout adis16362_timeouts = {
 	.reset_ms = 130,
 	.sw_reset_ms = 130,
@@ -972,7 +1023,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.timeouts = &adis16300_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
 	},
 	[ADIS16334] = {
 		.channels = adis16334_channels,
@@ -985,6 +1036,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
+		.adis_data = ADIS16400_DATA(&adis16334_timeouts),
 	},
 	[ADIS16350] = {
 		.channels = adis16350_channels,
@@ -996,7 +1048,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.timeouts = &adis16300_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
 	},
 	[ADIS16360] = {
 		.channels = adis16350_channels,
@@ -1009,7 +1061,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.timeouts = &adis16300_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
 	},
 	[ADIS16362] = {
 		.channels = adis16350_channels,
@@ -1022,7 +1074,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.timeouts = &adis16362_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16362_timeouts),
 	},
 	[ADIS16364] = {
 		.channels = adis16350_channels,
@@ -1035,7 +1087,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.timeouts = &adis16362_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16362_timeouts),
 	},
 	[ADIS16367] = {
 		.channels = adis16350_channels,
@@ -1048,7 +1100,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.timeouts = &adis16300_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
 	},
 	[ADIS16400] = {
 		.channels = adis16400_channels,
@@ -1060,7 +1112,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
-		.timeouts = &adis16400_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16400_timeouts),
 	},
 	[ADIS16445] = {
 		.channels = adis16445_channels,
@@ -1074,7 +1126,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
-		.timeouts = &adis16445_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16445_timeouts),
 	},
 	[ADIS16448] = {
 		.channels = adis16448_channels,
@@ -1088,7 +1140,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
-		.timeouts = &adis16448_timeouts,
+		.adis_data = ADIS16400_DATA(&adis16448_timeouts),
 	}
 };
 
@@ -1099,52 +1151,6 @@ static const struct iio_info adis16400_info = {
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
-static const char * const adis16400_status_error_msgs[] = {
-	[ADIS16400_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
-	[ADIS16400_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
-	[ADIS16400_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
-	[ADIS16400_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
-	[ADIS16400_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
-	[ADIS16400_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
-	[ADIS16400_DIAG_STAT_ALARM2] = "Alarm 2 active",
-	[ADIS16400_DIAG_STAT_ALARM1] = "Alarm 1 active",
-	[ADIS16400_DIAG_STAT_FLASH_CHK] = "Flash checksum error",
-	[ADIS16400_DIAG_STAT_SELF_TEST] = "Self test error",
-	[ADIS16400_DIAG_STAT_OVERFLOW] = "Sensor overrange",
-	[ADIS16400_DIAG_STAT_SPI_FAIL] = "SPI failure",
-	[ADIS16400_DIAG_STAT_FLASH_UPT] = "Flash update failed",
-	[ADIS16400_DIAG_STAT_POWER_HIGH] = "Power supply above 5.25V",
-	[ADIS16400_DIAG_STAT_POWER_LOW] = "Power supply below 4.75V",
-};
-
-static const struct adis_data adis16400_data = {
-	.msc_ctrl_reg = ADIS16400_MSC_CTRL,
-	.glob_cmd_reg = ADIS16400_GLOB_CMD,
-	.diag_stat_reg = ADIS16400_DIAG_STAT,
-
-	.read_delay = 50,
-	.write_delay = 50,
-
-	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,
-
-	.status_error_msgs = adis16400_status_error_msgs,
-	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_XACCL_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_XGYRO_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_YGYRO_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_ZGYRO_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_ALARM2) |
-		BIT(ADIS16400_DIAG_STAT_ALARM1) |
-		BIT(ADIS16400_DIAG_STAT_FLASH_CHK) |
-		BIT(ADIS16400_DIAG_STAT_SELF_TEST) |
-		BIT(ADIS16400_DIAG_STAT_OVERFLOW) |
-		BIT(ADIS16400_DIAG_STAT_SPI_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |
-		BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |
-		BIT(ADIS16400_DIAG_STAT_POWER_LOW),
-};
-
 static void adis16400_setup_chan_mask(struct adis16400_state *st)
 {
 	const struct adis16400_chip_info *chip_info = st->variant;
@@ -1158,23 +1164,6 @@ static void adis16400_setup_chan_mask(struct adis16400_state *st)
 			st->avail_scan_mask[0] |= BIT(ch->scan_index);
 	}
 }
-
-static struct adis_data *adis16400_adis_data_alloc(struct adis16400_state *st,
-						   struct device *dev)
-{
-	struct adis_data *data;
-
-	data = devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
-	if (!data)
-		return ERR_PTR(-ENOMEM);
-
-	memcpy(data, &adis16400_data, sizeof(*data));
-
-	data->timeouts = st->variant->timeouts;
-
-	return data;
-}
-
 static int adis16400_probe(struct spi_device *spi)
 {
 	struct adis16400_state *st;
@@ -1207,9 +1196,7 @@ static int adis16400_probe(struct spi_device *spi)
 			st->adis.burst->extra_len = sizeof(u16);
 	}
 
-	adis16400_data = adis16400_adis_data_alloc(st, &spi->dev);
-	if (IS_ERR(adis16400_data))
-		return PTR_ERR(adis16400_data);
+	adis16400_data = &st->variant->adis_data;
 
 	ret = adis_init(&st->adis, indio_dev, spi, adis16400_data);
 	if (ret)
-- 
2.20.1

