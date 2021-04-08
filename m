Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45B357DAC
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhDHHyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 03:54:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12424 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhDHHyp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 03:54:45 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1387pND0025076;
        Thu, 8 Apr 2021 03:54:23 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 37rw59wjq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 03:54:22 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1387sKN1019051
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Apr 2021 03:54:21 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 8 Apr 2021
 00:54:19 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 8 Apr 2021 00:54:19 -0700
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1387sHb9019594;
        Thu, 8 Apr 2021 03:54:17 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] iio: adis16480: support burst read function
Date:   Thu, 8 Apr 2021 09:56:43 +0200
Message-ID: <20210408075643.70183-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Bte-3AlnBVc_61nvkUgOrzOcaPmwkQbb
X-Proofpoint-GUID: Bte-3AlnBVc_61nvkUgOrzOcaPmwkQbb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_02:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080053
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some supported devices support burst read function. This provides a method
for reading a batch of data (status, temperature, gyroscopes,
accelerometers, time stamp/data counter, and CRC code), which does not
require a stall time between each 16-bit segment and only requires one
command on the DIN line to initiate. Devices supporting this mode
are:

  * adis16495-1
  * adis16495-2
  * adis16495-3
  * adis16497-1
  * adis16497-2
  * adis16497-3

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
Changes in v2:
 * Return right away if offset == 4 (no valid transition found from
brurst_id to sys_flags)

 drivers/iio/imu/adis16480.c | 161 +++++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index f81b86690b76..b782070a27f5 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -5,6 +5,7 @@
  * Copyright 2012 Analog Devices Inc.
  */
 
+#include <linux/crc32.h>
 #include <linux/clk.h>
 #include <linux/bitfield.h>
 #include <linux/of_irq.h>
@@ -19,11 +20,14 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/lcm.h>
+#include <linux/swab.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include <linux/debugfs.h>
 
@@ -103,6 +107,12 @@
  * Available only for ADIS1649x devices
  */
 #define ADIS16495_REG_SYNC_SCALE		ADIS16480_REG(0x03, 0x10)
+#define ADIS16495_REG_BURST_CMD			ADIS16480_REG(0x00, 0x7C)
+#define ADIS16495_BURST_ID			0xA5A5
+/* total number of segments in burst */
+#define ADIS16495_BURST_MAX_DATA		20
+/* spi max speed in burst mode */
+#define ADIS16495_BURST_MAX_SPEED              6000000
 
 #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
 
@@ -163,6 +173,8 @@ struct adis16480 {
 	struct clk *ext_clk;
 	enum adis16480_clock_mode clk_mode;
 	unsigned int clk_freq;
+	/* Alignment needed for the timestamp */
+	__be16 data[ADIS16495_BURST_MAX_DATA] __aligned(8);
 };
 
 static const char * const adis16480_int_pin_names[4] = {
@@ -863,7 +875,7 @@ static const char * const adis16480_status_error_msgs[] = {
 
 static int adis16480_enable_irq(struct adis *adis, bool enable);
 
-#define ADIS16480_DATA(_prod_id, _timeouts)				\
+#define ADIS16480_DATA(_prod_id, _timeouts, _burst_len)			\
 {									\
 	.diag_stat_reg = ADIS16480_REG_DIAG_STS,			\
 	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,				\
@@ -887,6 +899,8 @@ static int adis16480_enable_irq(struct adis *adis, bool enable);
 		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),			\
 	.enable_irq = adis16480_enable_irq,				\
 	.timeouts = (_timeouts),					\
+	.burst_reg_cmd = ADIS16495_REG_BURST_CMD,			\
+	.burst_len = (_burst_len),					\
 }
 
 static const struct adis_timeout adis16485_timeouts = {
@@ -931,7 +945,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts),
+		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0),
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -944,7 +958,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts),
+		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0),
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -957,7 +971,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts),
+		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0),
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -970,7 +984,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts),
+		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0),
 	},
 	[ADIS16490] = {
 		.channels = adis16485_channels,
@@ -984,7 +998,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts),
+		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts, 0),
 	},
 	[ADIS16495_1] = {
 		.channels = adis16485_channels,
@@ -998,7 +1012,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2),
 	},
 	[ADIS16495_2] = {
 		.channels = adis16485_channels,
@@ -1012,7 +1028,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2),
 	},
 	[ADIS16495_3] = {
 		.channels = adis16485_channels,
@@ -1026,7 +1044,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2),
 	},
 	[ADIS16497_1] = {
 		.channels = adis16485_channels,
@@ -1040,7 +1060,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2),
 	},
 	[ADIS16497_2] = {
 		.channels = adis16485_channels,
@@ -1054,7 +1076,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2),
 	},
 	[ADIS16497_3] = {
 		.channels = adis16485_channels,
@@ -1068,10 +1092,121 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2),
 	},
 };
 
+static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem, const u32 crc)
+{
+	u32 crc_calc;
+	u16 crc_buf[15];
+	int j;
+
+	for (j = 0; j < n_elem; j++)
+		crc_buf[j] = swab16(buf[j]);
+
+	crc_calc = crc32(~0, crc_buf, n_elem * 2);
+	crc_calc ^= ~0;
+
+	return (crc == crc_calc);
+}
+
+static irqreturn_t adis16480_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16480 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	int ret, bit, offset, i = 0;
+	__be16 *buffer;
+	u32 crc;
+	bool valid;
+	const u32 cached_spi_speed_hz = adis->spi->max_speed_hz;
+
+	adis_dev_lock(adis);
+	if (adis->current_page != 0) {
+		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
+		adis->tx[1] = 0;
+		ret = spi_write(adis->spi, adis->tx, 2);
+		if (ret) {
+			dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
+			adis_dev_unlock(adis);
+			return ret;
+		}
+	}
+
+	adis->spi->max_speed_hz = ADIS16495_BURST_MAX_SPEED;
+
+	ret = spi_sync(adis->spi, &adis->msg);
+	if (ret) {
+		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
+		adis_dev_unlock(adis);
+		return ret;
+	}
+
+	adis->spi->max_speed_hz = cached_spi_speed_hz;
+	adis->current_page = 0;
+	adis_dev_unlock(adis);
+
+	/*
+	 * After making the burst request, the response can have one or two
+	 * 16-bit responses containing the BURST_ID depending on the sclk. If
+	 * clk > 3.6MHz, then we will have two BURST_ID in a row. If clk < 3MHZ,
+	 * we have only one. To manage that variation, we use the transition from the
+	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5A5. If
+	 * we not find this variation in the first 4 segments, then the data should
+	 * not be valid.
+	 */
+	buffer = adis->buffer;
+	for (offset = 0; offset < 4; offset++) {
+		u16 curr = be16_to_cpu(buffer[offset]);
+		u16 next = be16_to_cpu(buffer[offset + 1]);
+
+		if (curr == ADIS16495_BURST_ID && next != ADIS16495_BURST_ID) {
+			offset++;
+			break;
+		}
+	}
+
+	if (offset == 4) {
+		dev_err(&adis->spi->dev, "Invalid burst data\n");
+		goto irq_done;
+	}
+
+	crc = be16_to_cpu(buffer[offset + 16]) << 16 | be16_to_cpu(buffer[offset + 15]);
+	valid = adis16480_validate_crc((u16 *)&buffer[offset], 15, crc);
+	if (!valid) {
+		dev_err(&adis->spi->dev, "Invalid crc\n");
+		goto irq_done;
+	}
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		/*
+		 * When burst mode is used, temperature is the first data
+		 * channel in the sequence, but the temperature scan index
+		 * is 10.
+		 */
+		switch (bit) {
+		case ADIS16480_SCAN_TEMP:
+			st->data[i++] = buffer[offset + 1];
+			break;
+		case ADIS16480_SCAN_GYRO_X ... ADIS16480_SCAN_ACCEL_Z:
+			/* The lower register data is sequenced first */
+			st->data[i++] = buffer[2 * bit + offset + 3];
+			st->data[i++] = buffer[2 * bit + offset + 2];
+			break;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
+irq_done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info adis16480_info = {
 	.read_raw = &adis16480_read_raw,
 	.write_raw = &adis16480_write_raw,
@@ -1341,7 +1476,7 @@ static int adis16480_probe(struct spi_device *spi)
 		st->clk_freq = st->chip_info->int_clk;
 	}
 
-	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, adis16480_trigger_handler);
 	if (ret)
 		return ret;
 
-- 
2.31.1

