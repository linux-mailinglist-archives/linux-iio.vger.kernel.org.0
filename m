Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6C157B3E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgBJN2m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:28:42 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4024 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731386AbgBJN2j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADSA3m029594;
        Mon, 10 Feb 2020 08:28:37 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udmqt5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:37 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSZ7Z058028
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:35 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Feb
 2020 05:28:33 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 05:28:33 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZk017670;
        Mon, 10 Feb 2020 08:28:31 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/9] iio: imu: adis16480: initialize adis_data statically
Date:   Mon, 10 Feb 2020 15:25:58 +0200
Message-ID: <20200210132606.9315-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change overrides commit 380b107bbf944 ("iio: adis: Introduce timeouts
structure"). It removes the memory allocation and moves the 'adis_data'
information to be static on the chip_info struct.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* initialize 'adis_data' statically on adis16480,adis16136 & adis16400
* split 'iio: imu: adis: Refactor adis_initial_startup' patch
  - new: 'iio: imu: adis: add unlocked __adis_initial_startup()'
  - new: 'iio: imu: adis: add support product ID check in adis_initial_startup'
  - modified: 'iio: imu: adis: Refactor adis_initial_startup'
* added 'prod_id' field together with 'prod_id_reg' on 'adis_data'
  each device that wants to use the 'prod_id_reg' must also provide an
  expected 'prod_id' value

 drivers/iio/imu/adis16480.c | 140 ++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index dac87f1001fd..4c4de1b62769 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -138,7 +138,7 @@ struct adis16480_chip_info {
 	unsigned int max_dec_rate;
 	const unsigned int *filter_freqs;
 	bool has_pps_clk_mode;
-	const struct adis_timeout *timeouts;
+	const struct adis_data adis_data;
 };
 
 enum adis16480_int_pin {
@@ -796,6 +796,55 @@ enum adis16480_variant {
 	ADIS16497_3,
 };
 
+#define ADIS16480_DIAG_STAT_XGYRO_FAIL 0
+#define ADIS16480_DIAG_STAT_YGYRO_FAIL 1
+#define ADIS16480_DIAG_STAT_ZGYRO_FAIL 2
+#define ADIS16480_DIAG_STAT_XACCL_FAIL 3
+#define ADIS16480_DIAG_STAT_YACCL_FAIL 4
+#define ADIS16480_DIAG_STAT_ZACCL_FAIL 5
+#define ADIS16480_DIAG_STAT_XMAGN_FAIL 8
+#define ADIS16480_DIAG_STAT_YMAGN_FAIL 9
+#define ADIS16480_DIAG_STAT_ZMAGN_FAIL 10
+#define ADIS16480_DIAG_STAT_BARO_FAIL 11
+
+static const char * const adis16480_status_error_msgs[] = {
+	[ADIS16480_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
+	[ADIS16480_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
+	[ADIS16480_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
+	[ADIS16480_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
+	[ADIS16480_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
+	[ADIS16480_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
+	[ADIS16480_DIAG_STAT_XMAGN_FAIL] = "X-axis magnetometer self-test failure",
+	[ADIS16480_DIAG_STAT_YMAGN_FAIL] = "Y-axis magnetometer self-test failure",
+	[ADIS16480_DIAG_STAT_ZMAGN_FAIL] = "Z-axis magnetometer self-test failure",
+	[ADIS16480_DIAG_STAT_BARO_FAIL] = "Barometer self-test failure",
+};
+
+static int adis16480_enable_irq(struct adis *adis, bool enable);
+
+#define ADIS16480_DATA(_timeouts)					\
+{									\
+	.diag_stat_reg = ADIS16480_REG_DIAG_STS,			\
+	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,				\
+	.has_paging = true,						\
+	.read_delay = 5,						\
+	.write_delay = 5,						\
+	.self_test_mask = BIT(1),					\
+	.status_error_msgs = adis16480_status_error_msgs,		\
+	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |	\
+		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |			\
+		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),			\
+	.enable_irq = adis16480_enable_irq,				\
+	.timeouts = (_timeouts),					\
+}
+
 static const struct adis_timeout adis16485_timeouts = {
 	.reset_ms = 560,
 	.sw_reset_ms = 120,
@@ -838,7 +887,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.timeouts = &adis16485_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -851,7 +900,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.timeouts = &adis16480_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16480_timeouts),
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -864,7 +913,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.timeouts = &adis16485_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -877,7 +926,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.timeouts = &adis16485_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
 	},
 	[ADIS16490] = {
 		.channels = adis16485_channels,
@@ -891,7 +940,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.timeouts = &adis16495_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16495_timeouts),
 	},
 	[ADIS16495_1] = {
 		.channels = adis16485_channels,
@@ -905,7 +954,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.timeouts = &adis16495_1_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
 	},
 	[ADIS16495_2] = {
 		.channels = adis16485_channels,
@@ -919,7 +968,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.timeouts = &adis16495_1_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
 	},
 	[ADIS16495_3] = {
 		.channels = adis16485_channels,
@@ -933,7 +982,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.timeouts = &adis16495_1_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
 	},
 	[ADIS16497_1] = {
 		.channels = adis16485_channels,
@@ -947,7 +996,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.timeouts = &adis16495_1_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
 	},
 	[ADIS16497_2] = {
 		.channels = adis16485_channels,
@@ -961,7 +1010,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.timeouts = &adis16495_1_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
 	},
 	[ADIS16497_3] = {
 		.channels = adis16485_channels,
@@ -975,7 +1024,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.timeouts = &adis16495_1_timeouts,
+		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
 	},
 };
 
@@ -1048,53 +1097,6 @@ static int adis16480_initial_setup(struct iio_dev *indio_dev)
 	return 0;
 }
 
-#define ADIS16480_DIAG_STAT_XGYRO_FAIL 0
-#define ADIS16480_DIAG_STAT_YGYRO_FAIL 1
-#define ADIS16480_DIAG_STAT_ZGYRO_FAIL 2
-#define ADIS16480_DIAG_STAT_XACCL_FAIL 3
-#define ADIS16480_DIAG_STAT_YACCL_FAIL 4
-#define ADIS16480_DIAG_STAT_ZACCL_FAIL 5
-#define ADIS16480_DIAG_STAT_XMAGN_FAIL 8
-#define ADIS16480_DIAG_STAT_YMAGN_FAIL 9
-#define ADIS16480_DIAG_STAT_ZMAGN_FAIL 10
-#define ADIS16480_DIAG_STAT_BARO_FAIL 11
-
-static const char * const adis16480_status_error_msgs[] = {
-	[ADIS16480_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
-	[ADIS16480_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
-	[ADIS16480_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
-	[ADIS16480_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
-	[ADIS16480_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
-	[ADIS16480_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
-	[ADIS16480_DIAG_STAT_XMAGN_FAIL] = "X-axis magnetometer self-test failure",
-	[ADIS16480_DIAG_STAT_YMAGN_FAIL] = "Y-axis magnetometer self-test failure",
-	[ADIS16480_DIAG_STAT_ZMAGN_FAIL] = "Z-axis magnetometer self-test failure",
-	[ADIS16480_DIAG_STAT_BARO_FAIL] = "Barometer self-test failure",
-};
-
-static const struct adis_data adis16480_data = {
-	.diag_stat_reg = ADIS16480_REG_DIAG_STS,
-	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,
-	.has_paging = true,
-
-	.read_delay = 5,
-	.write_delay = 5,
-
-	.status_error_msgs = adis16480_status_error_msgs,
-	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),
-
-	.enable_irq = adis16480_enable_irq,
-};
-
 static int adis16480_config_irq_pin(struct device_node *of_node,
 				    struct adis16480 *st)
 {
@@ -1245,22 +1247,6 @@ static int adis16480_get_ext_clocks(struct adis16480 *st)
 	return 0;
 }
 
-static struct adis_data *adis16480_adis_data_alloc(struct adis16480 *st,
-						   struct device *dev)
-{
-	struct adis_data *data;
-
-	data = devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
-	if (!data)
-		return ERR_PTR(-ENOMEM);
-
-	memcpy(data, &adis16480_data, sizeof(*data));
-
-	data->timeouts = st->chip_info->timeouts;
-
-	return data;
-}
-
 static int adis16480_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -1285,9 +1271,7 @@ static int adis16480_probe(struct spi_device *spi)
 	indio_dev->info = &adis16480_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	adis16480_data = adis16480_adis_data_alloc(st, &spi->dev);
-	if (IS_ERR(adis16480_data))
-		return PTR_ERR(adis16480_data);
+	adis16480_data = &st->chip_info->adis_data;
 
 	ret = adis_init(&st->adis, indio_dev, spi, adis16480_data);
 	if (ret)
-- 
2.20.1

