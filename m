Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6029E157B41
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgBJN2q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:28:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11264 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731400AbgBJN2p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:45 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADS3Nr029525;
        Mon, 10 Feb 2020 08:28:44 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udmqt6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:44 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSh4x022102
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Feb
 2020 08:28:42 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 08:28:42 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZr017670;
        Mon, 10 Feb 2020 08:28:40 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 8/9] iio: adis16480: Make use of __adis_initial_startup
Date:   Mon, 10 Feb 2020 15:26:05 +0200
Message-ID: <20200210132606.9315-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

From: Nuno Sá <nuno.sa@analog.com>

All actions done in `adis16480_initial_setup()` are now done in
`__adis_initial_startup()` so, there's no need for code duplication.
Furthermore, the call to `adis16480_initial_setup()` is done before any
device configuration since the device will be reset if not already (via
rst pin). This is actually fixing a potential bug since `adis_reset()` was
being called after configuring the device which is obviously a problem.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 80 +++++++++++--------------------------
 1 file changed, 24 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index acbe1701fc2d..cfae0e4476e7 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -822,10 +822,12 @@ static const char * const adis16480_status_error_msgs[] = {
 
 static int adis16480_enable_irq(struct adis *adis, bool enable);
 
-#define ADIS16480_DATA(_timeouts)					\
+#define ADIS16480_DATA(_prod_id, _timeouts)				\
 {									\
 	.diag_stat_reg = ADIS16480_REG_DIAG_STS,			\
 	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,				\
+	.prod_id_reg = ADIS16480_REG_PROD_ID,				\
+	.prod_id = (_prod_id),						\
 	.has_paging = true,						\
 	.read_delay = 5,						\
 	.write_delay = 5,						\
@@ -888,7 +890,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
+		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts),
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -901,7 +903,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(&adis16480_timeouts),
+		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts),
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -914,7 +916,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
+		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts),
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -927,7 +929,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
+		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts),
 	},
 	[ADIS16490] = {
 		.channels = adis16485_channels,
@@ -941,7 +943,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(&adis16495_timeouts),
+		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts),
 	},
 	[ADIS16495_1] = {
 		.channels = adis16485_channels,
@@ -955,7 +957,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
+		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
 	},
 	[ADIS16495_2] = {
 		.channels = adis16485_channels,
@@ -969,7 +971,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
+		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
 	},
 	[ADIS16495_3] = {
 		.channels = adis16485_channels,
@@ -983,7 +985,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
+		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
 	},
 	[ADIS16497_1] = {
 		.channels = adis16485_channels,
@@ -997,7 +999,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
+		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
 	},
 	[ADIS16497_2] = {
 		.channels = adis16485_channels,
@@ -1011,7 +1013,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
+		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
 	},
 	[ADIS16497_3] = {
 		.channels = adis16485_channels,
@@ -1025,7 +1027,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
+		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
 	},
 };
 
@@ -1064,40 +1066,6 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
-static int adis16480_initial_setup(struct iio_dev *indio_dev)
-{
-	struct adis16480 *st = iio_priv(indio_dev);
-	uint16_t prod_id;
-	unsigned int device_id;
-	int ret;
-
-	adis_reset(&st->adis);
-	msleep(70);
-
-	ret = adis_write_reg_16(&st->adis, ADIS16480_REG_GLOB_CMD, BIT(1));
-	if (ret)
-		return ret;
-	msleep(30);
-
-	ret = adis_check_status(&st->adis);
-	if (ret)
-		return ret;
-
-	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_PROD_ID, &prod_id);
-	if (ret)
-		return ret;
-
-	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
-	if (ret != 1)
-		return -EINVAL;
-
-	if (prod_id != device_id)
-		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
-				device_id, prod_id);
-
-	return 0;
-}
-
 static int adis16480_config_irq_pin(struct device_node *of_node,
 				    struct adis16480 *st)
 {
@@ -1278,18 +1246,22 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
+	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		return ret;
 
+	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
+	if (ret)
+		goto error_stop_device;
+
 	ret = adis16480_get_ext_clocks(st);
 	if (ret)
-		return ret;
+		goto error_stop_device;
 
 	if (!IS_ERR_OR_NULL(st->ext_clk)) {
 		ret = adis16480_ext_clk_config(st, spi->dev.of_node, true);
 		if (ret)
-			return ret;
+			goto error_stop_device;
 
 		st->clk_freq = clk_get_rate(st->ext_clk);
 		st->clk_freq *= 1000; /* micro */
@@ -1301,24 +1273,20 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		goto error_clk_disable_unprepare;
 
-	ret = adis16480_initial_setup(indio_dev);
-	if (ret)
-		goto error_cleanup_buffer;
-
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_stop_device;
+		goto error_cleanup_buffer;
 
 	adis16480_debugfs_init(indio_dev);
 
 	return 0;
 
-error_stop_device:
-	adis16480_stop_device(indio_dev);
 error_cleanup_buffer:
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
 error_clk_disable_unprepare:
 	clk_disable_unprepare(st->ext_clk);
+error_stop_device:
+	adis16480_stop_device(indio_dev);
 	return ret;
 }
 
-- 
2.20.1

