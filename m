Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECB23AB8F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgHCRUy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 13:20:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10724 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbgHCRUy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 13:20:54 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073H2u2a027348;
        Mon, 3 Aug 2020 13:20:52 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n6cjqhtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:20:52 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 073HKpKj063786
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 3 Aug 2020 13:20:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 3 Aug 2020
 13:20:50 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 3 Aug 2020 13:20:49 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 073HKlah008684;
        Mon, 3 Aug 2020 13:20:49 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v4 1/3] iio: accel: adxl372: Add support for FIFO peak mode
Date:   Mon, 3 Aug 2020 20:22:17 +0300
Message-ID: <20200803172219.33911-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803172219.33911-1-alexandru.tachici@analog.com>
References: <20200803172219.33911-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

By default, if all three channels (x, y, z) are enabled, sample sets of
concurrent 3-axis data is stored in the FIFO. This patch adds the option
to configure the FIFO to store peak acceleration (x, y and z) of every
over-threshold event. When pushing to iio buffer we push only enabled
axis data.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 72 +++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 67b8817995c0..cce25cde6252 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -133,6 +133,9 @@
 
 /* The ADXL372 includes a deep, 512 sample FIFO buffer */
 #define ADXL372_FIFO_SIZE			512
+#define ADXL372_X_AXIS_EN(x)			(((x) >> 0) & 0x1)
+#define ADXL372_Y_AXIS_EN(x)			(((x) >> 1) & 0x1)
+#define ADXL372_Z_AXIS_EN(x)			(((x) >> 2) & 0x1)
 
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
@@ -251,8 +254,10 @@ struct adxl372_state {
 	struct device			*dev;
 	struct regmap			*regmap;
 	struct iio_trigger		*dready_trig;
+	struct iio_trigger		*peak_datardy_trig;
 	enum adxl372_fifo_mode		fifo_mode;
 	enum adxl372_fifo_format	fifo_format;
+	unsigned int			fifo_axis_mask;
 	enum adxl372_op_mode		op_mode;
 	enum adxl372_act_proc_mode	act_proc_mode;
 	enum adxl372_odr		odr;
@@ -264,6 +269,7 @@ struct adxl372_state {
 	u8				int2_bitmask;
 	u16				watermark;
 	__be16				fifo_buf[ADXL372_FIFO_SIZE];
+	bool				peak_fifo_mode_en;
 };
 
 static const unsigned long adxl372_channel_masks[] = {
@@ -522,6 +528,22 @@ static int adxl372_get_status(struct adxl372_state *st,
 	return ret;
 }
 
+static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
+{
+	__be16	axis_sample[3];
+	int i = 0;
+
+	memset(axis_sample, 0, 3 * sizeof(__be16));
+	if (ADXL372_X_AXIS_EN(st->fifo_axis_mask))
+		axis_sample[i++] = sample[0];
+	if (ADXL372_Y_AXIS_EN(st->fifo_axis_mask))
+		axis_sample[i++] = sample[1];
+	if (ADXL372_Z_AXIS_EN(st->fifo_axis_mask))
+		axis_sample[i++] = sample[2];
+
+	memcpy(sample, axis_sample, 3 * sizeof(__be16));
+}
+
 static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
@@ -553,8 +575,12 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 			goto err;
 
 		/* Each sample is 2 bytes */
-		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
+		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
+			/* filter peak detection data */
+			if (st->peak_fifo_mode_en)
+				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
 			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+		}
 	}
 err:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -815,13 +841,22 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
+	st->fifo_axis_mask = adxl372_axis_lookup_table[i].bits;
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
 					  indio_dev->masklength);
+
+	/* Configure the FIFO to store sets of impact event peak. */
+	if (st->peak_fifo_mode_en) {
+		st->fifo_set_size = 3;
+		st->fifo_format = ADXL372_XYZ_PEAK_FIFO;
+	}
+
 	/*
 	 * The 512 FIFO samples can be allotted in several ways, such as:
 	 * 170 sample sets of concurrent 3-axis data
 	 * 256 sample sets of concurrent 2-axis data (user selectable)
 	 * 512 sample sets of single-axis data
+	 * 170 sets of impact event peak (x, y, z)
 	 */
 	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
 		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
@@ -876,7 +911,7 @@ static int adxl372_validate_trigger(struct iio_dev *indio_dev,
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
 
-	if (st->dready_trig != trig)
+	if (st->dready_trig != trig && st->peak_datardy_trig != trig)
 		return -EINVAL;
 
 	return 0;
@@ -887,6 +922,25 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
+static int adxl372_peak_dready_trig_set_state(struct iio_trigger *trig,
+					      bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (state)
+		st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;
+
+	st->peak_fifo_mode_en = state;
+
+	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
+}
+
+static const struct iio_trigger_ops adxl372_peak_data_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+	.set_trigger_state = adxl372_peak_dready_trig_set_state,
+};
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
 static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
 		       0444, adxl372_show_filter_freq_avail, NULL, 0);
@@ -965,13 +1019,27 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 		if (st->dready_trig == NULL)
 			return -ENOMEM;
 
+		st->peak_datardy_trig = devm_iio_trigger_alloc(dev,
+							       "%s-dev%d-peak",
+							       indio_dev->name,
+							       indio_dev->id);
+		if (!st->peak_datardy_trig)
+			return -ENOMEM;
+
 		st->dready_trig->ops = &adxl372_trigger_ops;
+		st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
 		st->dready_trig->dev.parent = dev;
+		st->peak_datardy_trig->dev.parent = dev;
 		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+		iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
 		ret = devm_iio_trigger_register(dev, st->dready_trig);
 		if (ret < 0)
 			return ret;
 
+		ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
+		if (ret < 0)
+			return ret;
+
 		indio_dev->trig = iio_trigger_get(st->dready_trig);
 
 		ret = devm_request_threaded_irq(dev, st->irq,
-- 
2.20.1

