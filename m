Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD544BFD4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 12:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhKJLKl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 06:10:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22376 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231444AbhKJLKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2021 06:10:35 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AA82iNM018625;
        Wed, 10 Nov 2021 06:07:36 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c8a7p0jdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 06:07:36 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1AAB7YSI020120
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 06:07:35 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 03:07:33 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 03:07:33 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 10 Nov 2021 03:07:33 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AAB7OD8030773;
        Wed, 10 Nov 2021 06:07:31 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] iio: adc: ad_sigma_delta: Add sequencer support
Date:   Wed, 10 Nov 2021 13:17:48 +0200
Message-ID: <20211110111750.27263-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110111750.27263-1-alexandru.tachici@analog.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: DYd8whASDUDZUzqLhjBHL68LJgR9IIFq
X-Proofpoint-GUID: DYd8whASDUDZUzqLhjBHL68LJgR9IIFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111100059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Some sigma-delta chips support sampling of multiple
channels in continuous mode.

When the operating with more than one channel enabled,
the channel sequencer cycles through the enabled channels
in sequential order, from first channel to the last one.
If a channel is disabled, it is skipped by the sequencer.

If more than one channel is used in continuous mode,
instruct the device to append the status to the SPI transfer
(1 extra byte) every time we receive a sample.
All sigma-delta chips possessing a sampling sequencer have
this ability. Inside the status register there will be
the number of the converted channel. In this way, even
if the CPU won't keep up with the sampling rate, it won't
send to userspace wrong channel samples.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 106 ++++++++++++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  22 +++++
 2 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 1d652d9b2f5c..d595e7972975 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -342,33 +342,48 @@ EXPORT_SYMBOL_GPL(ad_sigma_delta_single_conversion);
 static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	unsigned int channel;
+	unsigned int i, slot;
 	int ret;
 
-	channel = find_first_bit(indio_dev->active_scan_mask,
-				 indio_dev->masklength);
-	ret = ad_sigma_delta_set_channel(sigma_delta,
-		indio_dev->channels[channel].address);
-	if (ret)
-		return ret;
+	slot = 0;
+	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
+		sigma_delta->slots[slot] = indio_dev->channels[i].address;
+		ret = ad_sigma_delta_set_channel(sigma_delta, indio_dev->channels[i].address);
+		if (ret)
+			return ret;
+		slot++;
+	}
+
+	sigma_delta->active_slots = slot;
+	sigma_delta->current_slot = 0;
+
+	if (sigma_delta->active_slots > 1) {
+		ret = ad_sigma_delta_append_status(sigma_delta, true);
+		if (ret)
+			return ret;
+	}
+
+	kfree(sigma_delta->samples_buf);
+	sigma_delta->samples_buf = kzalloc(slot * indio_dev->channels[0].scan_type.storagebits,
+					   GFP_KERNEL);
+	if (!sigma_delta->samples_buf)
+		return -ENOMEM;
 
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 
 	ret = ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_CONTINUOUS);
-	if (ret)
-		goto err_unlock;
+	if (ret) {
+		kfree(sigma_delta->samples_buf);
+		spi_bus_unlock(sigma_delta->spi->master);
+		return ret;
+	}
 
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
 
 	return 0;
-
-err_unlock:
-	spi_bus_unlock(sigma_delta->spi->master);
-
-	return ret;
 }
 
 static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
@@ -386,6 +401,9 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 
+	if (sigma_delta->status_appended)
+		ad_sigma_delta_append_status(sigma_delta, false);
+
 	sigma_delta->bus_locked = false;
 	return spi_bus_unlock(sigma_delta->spi->master);
 }
@@ -396,6 +414,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	uint8_t *data = sigma_delta->rx_buf;
+	unsigned int transfer_size;
+	unsigned int sample_size;
+	unsigned int sample_pos;
+	unsigned int status_pos;
 	unsigned int reg_size;
 	unsigned int data_reg;
 
@@ -408,20 +430,55 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	else
 		data_reg = AD_SD_REG_DATA;
 
+	/* Status word will be appended to the sample during transfer */
+	if (sigma_delta->status_appended)
+		transfer_size = reg_size + 1;
+	else
+		transfer_size = reg_size;
+
 	switch (reg_size) {
 	case 4:
 	case 2:
 	case 1:
-		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[0]);
+		status_pos = reg_size;
+		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[0]);
 		break;
 	case 3:
+		status_pos = reg_size + 1;
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[1]);
+		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
 		break;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
+	if (sigma_delta->status_appended) {
+		u8 converted_channel;
+
+		converted_channel = data[status_pos] & sigma_delta->info->status_ch_mask;
+		if (converted_channel != sigma_delta->slots[sigma_delta->current_slot]) {
+			/* Desynq occurred during continuous sampling of multiple channels.
+			 * Drop this incomplete sample and start from first channel again.
+			 */
+
+			sigma_delta->current_slot = 0;
+			iio_trigger_notify_done(indio_dev->trig);
+			sigma_delta->irq_dis = false;
+			enable_irq(sigma_delta->spi->irq);
+
+			return IRQ_HANDLED;
+		}
+	}
+
+	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
+	sample_pos = sample_size * sigma_delta->current_slot;
+	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
+	sigma_delta->current_slot++;
+
+	if (sigma_delta->current_slot == sigma_delta->active_slots) {
+		sigma_delta->current_slot = 0;
+		iio_push_to_buffers_with_timestamp(indio_dev, sigma_delta->samples_buf,
+						   pf->timestamp);
+	}
 
 	iio_trigger_notify_done(indio_dev->trig);
 	sigma_delta->irq_dis = false;
@@ -430,10 +487,17 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned long *mask)
+{
+	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+
+	return bitmap_weight(mask, indio_dev->masklength) <= sigma_delta->info->num_slots;
+}
+
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
 	.postdisable = &ad_sd_buffer_postdisable,
-	.validate_scan_mask = &iio_validate_scan_mask_onehot,
+	.validate_scan_mask = &ad_sd_validate_scan_mask,
 };
 
 static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
@@ -517,8 +581,14 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
  */
 int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
+	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	int ret;
 
+	sigma_delta->slots = devm_kcalloc(dev, sigma_delta->info->num_slots,
+					  sizeof(*sigma_delta->slots), GFP_KERNEL);
+	if (!sigma_delta->slots)
+		return -ENOMEM;
+
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      &ad_sd_trigger_handler,
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index c525fd51652f..758ff25590c3 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -32,6 +32,7 @@ struct iio_dev;
 /**
  * struct ad_sigma_delta_info - Sigma Delta driver specific callbacks and options
  * @set_channel: Will be called to select the current channel, may be NULL.
+ * @append_status: Will be called to enable status append at the end of the sample, may be NULL.
  * @set_mode: Will be called to select the current mode, may be NULL.
  * @postprocess_sample: Is called for each sampled data word, can be used to
  *		modify or drop the sample data, it, may be NULL.
@@ -39,19 +40,24 @@ struct iio_dev;
  *		if there is just one read-only sample data shift register.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
+ * @status_ch_mask: Mask for the channel number stored in status register.
  * @data_reg: Address of the data register, if 0 the default address of 0x3 will
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
+ * @num_slots: Number of sequencer slots
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
+	int (*append_status)(struct ad_sigma_delta *, bool append);
 	int (*set_mode)(struct ad_sigma_delta *, enum ad_sigma_delta_mode mode);
 	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
 	bool has_registers;
 	unsigned int addr_shift;
 	unsigned int read_mask;
+	unsigned int status_ch_mask;
 	unsigned int data_reg;
 	unsigned long irq_flags;
+	unsigned int num_slots;
 };
 
 /**
@@ -76,6 +82,12 @@ struct ad_sigma_delta {
 	uint8_t			comm;
 
 	const struct ad_sigma_delta_info *info;
+	unsigned int		active_slots;
+	unsigned int		current_slot;
+	bool			status_appended;
+	/* map slots to channels in order to know what to expect from devices */
+	unsigned int		*slots;
+	uint8_t			*samples_buf;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -97,6 +109,16 @@ static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
 	return 0;
 }
 
+static inline int ad_sigma_delta_append_status(struct ad_sigma_delta *sd, bool append)
+{
+	if (sd->info->append_status) {
+		sd->status_appended = append;
+		return sd->info->append_status(sd, append);
+	}
+
+	return 0;
+}
+
 static inline int ad_sigma_delta_set_mode(struct ad_sigma_delta *sd,
 	unsigned int mode)
 {
-- 
2.25.1

