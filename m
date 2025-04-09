Return-Path: <linux-iio+bounces-17868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A5A824BA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE774A5FAC
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D74A264625;
	Wed,  9 Apr 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="meoDxLn9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415725F7B0;
	Wed,  9 Apr 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201536; cv=none; b=USQpxAv5C62AYKNjalU012sRjOs/aOPO//qXtMwF6lLGZ9ZNjz+6+JIt1kA5v30++b5rMoBuVvXkaeGR2XB1671W75cDTBkZIX1EPv9LNkaZQLGMsL+NVgLjra9tq9ZlNQqEgoMtfjuhpjfDGkRMkLO0LshcLJLRyaVMg27sXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201536; c=relaxed/simple;
	bh=EGUItf+bK08LHYWCFnRZTpGkZbeNSpjozLnBTnJrLz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgPRcdoVM98md7oVV7fjfIHYrK8Z4mV6n50WKPfQESEINRr86Z48dY+DgxdUzE5nv+VfuKygVcqu2QBHqQsuNuNoCxucgdQhmvMvnc+K+p/qH8HQHtZ5vJPW+EtT48GQK73VwmoqK33CwxjpPZQ9rqwgAsxOA1AJL7rrW5JSHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=meoDxLn9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399NqVT010181;
	Wed, 9 Apr 2025 08:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7n+3E
	Uu+hNZYiuEqIVcb1zJJMo5A4zt3AC3M9IAj654=; b=meoDxLn99m1taapP53oBo
	UoiPbq/PiFHuaBNNHzuX+mDPcrBxZ+CG4ODt/I00GIQ/m4krmlZf+1Yff3ecc6uS
	7ZLbMoq9KjnmrPVcxhLWzivLAQdE+WIzLpsmfoj21hHfoGGlsReY3TGeE3uuXlNo
	t4GVDcRLosZBvWULHyBbS7s5qB6Q0AY/2t7oL5E5TshNnPlAUN/K2qYaAUDRGYhd
	ttKhprIeHrg66b/KHyzli07e9yX5N80ro6WtyD+U4Zbe/VEwq3nIKI6lEzTO3GVe
	FFnLnQ7yBDf3O6bkLnQqm7mzM1mO4TdygX6bb0k1ax+RQq3NEL1opDGaYWReAonX
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45txc66acb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:25:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 539CPI4l041847
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Apr 2025 08:25:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 9 Apr 2025
 08:25:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 9 Apr 2025 08:25:17 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 539CP4BG016951;
	Wed, 9 Apr 2025 08:25:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 3/7] iio: adc: ad4170: Add support for buffered data capture
Date: Wed, 9 Apr 2025 09:25:02 -0300
Message-ID: <5f6d44ad4a4a5df088d91aa386229073f5364406.1744200264.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yhOtpzl7qMegOP6j56KItp2f4IF63lf3
X-Proofpoint-ORIG-GUID: yhOtpzl7qMegOP6j56KItp2f4IF63lf3
X-Authority-Analysis: v=2.4 cv=KePSsRYD c=1 sm=1 tr=0 ts=67f6672f cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=YGZcWCd7MsqG0SmrAXQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_04,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090074

Extend the AD4170 driver to allow buffered data capture in continuous read
mode. In continuous read mode, the chip skips the instruction phase and
outputs just ADC sample data, enabling faster sample rates to be reached.
The internal channel sequencer always starts sampling from channel 0 and
channel 0 must be enabled if more than one channel is selected for data
capture. The scan mask validation callback checks the aforementioned
condition is met.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4170.c | 170 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 0d24286ac2ab..5ffcdedf3e7f 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -10,10 +10,12 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -323,6 +325,16 @@ struct ad4170_state {
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	struct completion completion;
 	struct iio_trigger *trig;
+
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	__be32 bounce_buffer[AD4170_MAX_CHANNELS];
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	__be32 rx_buf __aligned(IIO_DMA_MINALIGN);
+	u8 tx_buf[2];
 };
 
 static void ad4170_fill_sps_tbl(struct ad4170_state *st)
@@ -882,6 +894,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
+		.shift = 8,
 		.endianness = IIO_BE,
 	},
 };
@@ -1480,11 +1493,29 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad4170_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *active_scan_mask)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned int chan_index;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	iio_for_each_active_channel(indio_dev, chan_index) {
+		ret = ad4170_set_channel_enable(st, chan_index, true);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static const struct iio_info ad4170_info = {
 	.read_raw = ad4170_read_raw,
 	.read_avail = ad4170_read_avail,
 	.write_raw = ad4170_write_raw,
 	.write_raw_get_fmt = ad4170_write_raw_get_fmt,
+	.update_scan_mode = ad4170_update_scan_mode,
 	.debugfs_reg_access = ad4170_debugfs_reg_access,
 };
 
@@ -1759,6 +1790,130 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 				 AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK);
 }
 
+static int ad4170_prepare_spi_message(struct ad4170_state *st)
+{
+	/*
+	 * Continuous data register read is enabled on buffer postenable so
+	 * no instruction phase is needed meaning we don't need to send the
+	 * register address to read data. Transfer only needs the read buffer.
+	 */
+	st->xfer.rx_buf = &st->rx_buf;
+	st->xfer.len = BITS_TO_BYTES(ad4170_channel_template.scan_type.realbits);
+
+	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
+
+	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->msg);
+}
+
+static int ad4170_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_CONT);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Enables continuous data register read.
+	 * This enables continuous read of the ADC Data register. The ADC must
+	 * be in a continuous conversion mode.
+	 */
+	return regmap_update_bits(st->regmap16, AD4170_ADC_CTRL_REG,
+				  AD4170_ADC_CTRL_CONT_READ_MSK,
+				  FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
+					     AD4170_ADC_CTRL_CONT_READ_ENABLE));
+}
+
+static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	int ret, i;
+
+	/*
+	 * To exit continuous read, write 0xA5 to the ADC during the first 8
+	 * SCLKs of the ADC data read.
+	 */
+	st->tx_buf[0] = AD4170_ADC_CTRL_CONT_READ_EXIT;
+	st->tx_buf[1] = 0;
+	ret = spi_write(st->spi, st->tx_buf, 2);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap16, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_CONT_READ_MSK,
+				 FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
+					    AD4170_ADC_CTRL_CONT_READ_DISABLE));
+	if (ret)
+		return ret;
+
+	ret =  ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
+	if (ret)
+		return ret;
+
+	/*
+	 * The ADC sequences through all the enabled channels (see datasheet
+	 * page 95). That can lead to incorrect channel being read if a
+	 * single-shot read (or buffered read with different active_scan_mask)
+	 * is done after buffer disable. Disable all channels so only requested
+	 * channels will be read.
+	 */
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = ad4170_set_channel_enable(st, i, false);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+static bool ad4170_validate_scan_mask(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	unsigned int masklength = iio_get_masklength(indio_dev);
+	unsigned long first, next;
+
+	/*
+	 * The channel sequencer cycles through the enabled channels in
+	 * sequential order, from channel 0 to channel 15, bypassing disabled
+	 * channels. When more than one channel is enabled, channel 0 must
+	 * always be enabled. See datasheet channel_en register description at
+	 * page 95.
+	 */
+	first = find_next_bit(scan_mask, masklength, 0);
+	next = find_next_bit(scan_mask, masklength, first + 1);
+	if (next < masklength)
+		return test_bit(0, scan_mask);
+
+	return true;
+}
+
+static const struct iio_buffer_setup_ops ad4170_buffer_ops = {
+	.postenable = ad4170_buffer_postenable,
+	.predisable = ad4170_buffer_predisable,
+	.validate_scan_mask = ad4170_validate_scan_mask,
+};
+
+static irqreturn_t ad4170_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4170_state *st = iio_priv(indio_dev);
+	int i, ret;
+
+	iio_for_each_active_channel(indio_dev, i) {
+		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			goto err_out;
+
+		st->bounce_buffer[i] = st->rx_buf;
+	}
+
+	iio_push_to_buffers(indio_dev, st->bounce_buffer);
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static const struct iio_trigger_ops ad4170_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
@@ -1768,7 +1923,10 @@ static irqreturn_t ad4170_irq_handler(int irq, void *dev_id)
 	struct iio_dev *indio_dev = dev_id;
 	struct ad4170_state *st = iio_priv(indio_dev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(st->trig);
+	else
+		complete(&st->completion);
 
 	return IRQ_HANDLED;
 };
@@ -1915,6 +2073,16 @@ static int ad4170_probe(struct spi_device *spi)
 			return dev_err_probe(dev, ret, "Failed to setup trigger\n");
 	}
 
+	ret = ad4170_prepare_spi_message(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to prepare SPI message\n");
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      &ad4170_trigger_handler,
+					      &ad4170_buffer_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup read buffer\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.47.2


