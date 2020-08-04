Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853DC23B862
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgHDKDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 06:03:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16208 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728270AbgHDKDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2020 06:03:19 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0749suB1015699;
        Tue, 4 Aug 2020 06:03:18 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n69ehdk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 06:03:18 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 074A3H5G058003
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 4 Aug 2020 06:03:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 06:03:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 06:03:15 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 4 Aug 2020 06:03:15 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 074A3CbQ002099;
        Tue, 4 Aug 2020 06:03:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] iio: imu: adis16480: Add support for burst read function
Date:   Tue, 4 Aug 2020 13:04:13 +0300
Message-ID: <20200804100414.39002-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

The burst read function (BRF) provides a method for reading a batch of
data (status, temperature, gyroscopes, accelerometers, timestamp/data
counter and CRC code), which does not require a stall time between each
16-bit sgment and only requires on command on the DIN line to initiate.

The BRF contains either 19 or 20 different data segments of 16-bits
each. After making the burst request, the response can have one or two
"don't care" 16-bit responses before the BURST_ID. This is why the
received burst sequence needs to be followed until the BURST_ID is
detected, which indicates that the data will be contained in the
following 17 segments of 16-bits each. Temperature is the first data
channel in the sequence.

Currently, the burst function is activated by default for all devices
that support it. A future patch will offer the option to enable/disable
this feature from userspace.

Also, the CRC code is not checked. This will be added in a future patch
as well.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 106 +++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 1eb4f98076f1..9b100c8fb744 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -23,6 +23,9 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
 #include <linux/debugfs.h>
 
 #define ADIS16480_PAGE_SIZE 0x80
@@ -101,6 +104,9 @@
  * Available only for ADIS1649x devices
  */
 #define ADIS16495_REG_SYNC_SCALE		ADIS16480_REG(0x03, 0x10)
+#define ADIS16495_REG_BURST_CMD			ADIS16480_REG(0x00, 0x7C)
+#define ADIS16495_BURST_ID			0xA5A5
+#define ADIS16495_BURST_MAX_DATA		20
 
 #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
 
@@ -138,6 +144,7 @@ struct adis16480_chip_info {
 	unsigned int max_dec_rate;
 	const unsigned int *filter_freqs;
 	bool has_pps_clk_mode;
+	struct adis_burst *burst;
 	const struct adis_data adis_data;
 };
 
@@ -163,6 +170,20 @@ struct adis16480 {
 	unsigned int clk_freq;
 };
 
+static struct adis_burst adis16495_burst = {
+	.en = true,
+	.reg_cmd = ADIS16495_REG_BURST_CMD,
+	/*
+	 * adis_update_scan_mode_burst() sets the burst length in respect with
+	 * the number of channels and allocates 16 bits for each. However, for
+	 * adis1649x devices, the data for each channel is composed of a 16-bit
+	 * low and 16-bit high part. Besides this, the burst sequence contains
+	 * data for BURST_ID, SYS_E_FLAG, TIME_STAMP, CRC_LWR, CRC_UPR, one or
+	 * two don't care segments.
+	 */
+	.extra_len = 12 * sizeof(u16),
+};
+
 static const char * const adis16480_int_pin_names[4] = {
 	[ADIS16480_PIN_DIO1] = "DIO1",
 	[ADIS16480_PIN_DIO2] = "DIO2",
@@ -953,6 +974,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.burst = &adis16495_burst,
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
 	},
 	[ADIS16495_2] = {
@@ -967,6 +989,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.burst = &adis16495_burst,
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
 	},
 	[ADIS16495_3] = {
@@ -981,6 +1004,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.burst = &adis16495_burst,
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
 	},
 	[ADIS16497_1] = {
@@ -995,6 +1019,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.burst = &adis16495_burst,
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
 	},
 	[ADIS16497_2] = {
@@ -1009,6 +1034,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.burst = &adis16495_burst,
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
 	},
 	[ADIS16497_3] = {
@@ -1023,10 +1049,81 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.burst = &adis16495_burst,
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
 	},
 };
 
+static irqreturn_t adis16480_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16480 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	int ret, bit, offset, i = 0;
+	__be16 data[ADIS16495_BURST_MAX_DATA], *buffer, *d;
+
+	if (!adis->buffer)
+		return -ENOMEM;
+
+	mutex_lock(&adis->state_lock);
+	if (adis->current_page != 0) {
+		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
+		adis->tx[1] = 0;
+		spi_write(adis->spi, adis->tx, 2);
+	}
+
+	ret = spi_sync(adis->spi, &adis->msg);
+	if (ret)
+		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
+
+	adis->current_page = 0;
+	mutex_unlock(&adis->state_lock);
+
+	if (!(adis->burst && adis->burst->en)) {
+		buffer = adis->buffer;
+		goto push_to_buffers;
+	}
+	/*
+	 * After making the burst request, the response can have one or two
+	 * "don't care" 16-bit responses, before the BURST_ID.
+	 */
+	d = (__be16 *)adis->buffer;
+	for (offset = 0; offset < 3; offset++) {
+		if (d[offset] == ADIS16495_BURST_ID) {
+			offset += 2; /* TEMP_OUT */
+			break;
+		}
+	}
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			indio_dev->masklength) {
+		/*
+		 * When burst mode is used, temperature is the first data
+		 * channel in the sequence, but the temperature scan index
+		 * is 10.
+		 */
+		if (bit == ADIS16480_SCAN_TEMP) {
+			data[2 * i] = d[offset];
+		} else {
+			/* The lower register data is sequenced first */
+			data[2 * i] = d[2 * bit + offset + 2];
+			data[2 * i + 1] = d[2 * bit + offset + 1];
+		}
+		i++;
+	}
+
+	buffer = data;
+
+push_to_buffers:
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+		pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info adis16480_info = {
 	.read_raw = &adis16480_read_raw,
 	.write_raw = &adis16480_write_raw,
@@ -1264,7 +1361,14 @@ static int adis16480_probe(struct spi_device *spi)
 		st->clk_freq = st->chip_info->int_clk;
 	}
 
-	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
+	/* If burst mode is supported, enable it by default */
+	if (st->chip_info->burst) {
+		st->adis.burst = st->chip_info->burst;
+		st->adis.burst_extra_len = st->chip_info->burst->extra_len;
+	}
+
+	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+					    adis16480_trigger_handler);
 	if (ret)
 		goto error_clk_disable_unprepare;
 
-- 
2.17.1

