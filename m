Return-Path: <linux-iio+bounces-18772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA62A9F0AC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6AB1A82835
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10226A0C7;
	Mon, 28 Apr 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H8HvM+rM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A8269CF0;
	Mon, 28 Apr 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843332; cv=none; b=IpeNRrWiNdshjg8o6voz3853sssslxtWqqJx8KiUrQgkQG4TgiJqGkp3aRmbJhnvnE/FY5+UP8JdcHlQzxFc212+/9YDZ6eydIXuW2OxIMsl/3ofPOgzfqLLh27XtUpk4bWpExTR8CxoKCvMN43PxOp5JhKOU/V51CbDVQLZnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843332; c=relaxed/simple;
	bh=FhposC6dBzhn4s7Koj0P61iOS7zAKbblmweTDnQu4TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+OuizbiJDmB8CrnfVwBS/Ghk9XT0RabUZanGOKjyW/e7Ugdoqx3wpq3dmUuMx3oUXxd8t+TUeGTCzwaTg02ILMAo8rMpx9aUhHs9hwkg0h2Z1oXVRr1/h6OKMU7piM0hVpx5T5bz7iUP08112Dsz5iLU1GrbXe1hrd4pbmWGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H8HvM+rM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S97UVu014124;
	Mon, 28 Apr 2025 08:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HhoZ3
	YiLPTwzfcngMCLjxLaLkiN/ZPTH3sBVB746etE=; b=H8HvM+rMvF/+LsAiBwFZ3
	rK3w9sEB8TRXnmigVS954cC+tyAEpbVv5FfIbNoP+0rT6yILNrw9TpiSK9IvtTY+
	rcy0/EFnE6qe/3jEmWBhFnSbHjCU3DG+GJh8TwDJOVHYADE8jAff8ICt8stXhx2K
	qUrPbfJIPW6/ef/p1u3ELnAJApNWESBYAFYV9BmIScUtYZj+5nKB64IOY399nOPL
	VqA4RQIoEDs2U0SNdMfS+eUfzKrC0NzxNnLhqdsWGwWF7IOlReYiOQ1XYSN5KUsU
	tb+EkVpEjlbyZlLM5KCrdvKr7LMQPnfDNH/a29NnBQ2YiEaOk/211rEdFTfrYGQo
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468sb76nyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 08:28:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53SCSYjv011809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 08:28:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 28 Apr
 2025 08:28:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 08:28:34 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53SCSLO5032516;
	Mon, 28 Apr 2025 08:28:23 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/7] iio: adc: ad4170: Add support for buffered data capture
Date: Mon, 28 Apr 2025 09:28:20 -0300
Message-ID: <db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: C027JJ44bbBilIwTnC0UeMx8BFN9ffKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwMiBTYWx0ZWRfX1mAWQ7a3Rs0m DQJNMH71a8/43MxhipK8tk8pWSL0/CN9MPFexTiLzoQQT4Qvh+xB60VW8PnegqJbrfwHCOaty5K 8SjMovLJ5riyT9bKqkfdPpsVVFi2SMJsU57cgHNp491dZBEB2zSfxhwEDAix+ZjIuxiZYbInAoz
 7GXw485eh+qQBzQRBZV3msaOBlbHWnkwq4kk+2hQOhSRwOeqFGWp29YEmWYvHZqj45MUAS8RWTn IBgGEP/1ByHPzU0NjZPnC63soXbW+3ooLfRQ4rPhMYaC0oLVmBSFVBH/JQCfAisAp4M60R4HiqW aT0Z9BFv5FiB71um2g/m9ARXnuckZcsG/1NsAImsHJm8aRIAWj/sOlrgBY1kB47QM9eno8Y9Jjd
 L7thCJbIR4klSEv7l2Y8ayGJ2eetwK42rHcTSsKDlZfHYcLd3K/TF6fXytY3xgwqRzMf21Rk
X-Proofpoint-ORIG-GUID: C027JJ44bbBilIwTnC0UeMx8BFN9ffKc
X-Authority-Analysis: v=2.4 cv=HPzDFptv c=1 sm=1 tr=0 ts=680f7473 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=iVdL9K_2dCMw-VmQ2KkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280102

Extend the AD4170 driver to allow buffered data capture in continuous read
mode. In continuous read mode, the chip skips the instruction phase and
outputs just ADC sample data, enabling faster sample rates to be reached.
The internal channel sequencer always starts sampling from channel 0 and
channel 0 must be enabled if more than one channel is selected for data
capture. The scan mask validation callback checks the aforementioned
condition is met.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
changes since v1
- Using bitmap_weight().
- rx_buf changed from __be32 to u8 array to better cope with new regmap config.

 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4170.c | 199 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 199 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d5d0308da007..9b4787c127fc 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -75,6 +75,8 @@ config AD4170
 	tristate "Analog Device AD4170 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 4d0af15cb48d..5fcf1c023ac2 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -10,8 +10,12 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -54,6 +58,7 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
 
@@ -221,6 +226,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
 enum ad4170_ref_buf {
@@ -347,12 +353,16 @@ struct ad4170_state {
 	u32 int_pin_sel;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	struct completion completion;
+	struct iio_trigger *trig;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	__be32 bounce_buffer[AD4170_MAX_CHANNELS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
 	 */
 	u8 tx_buf[AD4170_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
-	u8 rx_buf[AD4170_SPI_MAX_XFER_LEN];
+	u8 rx_buf[4];
 };
 
 static void ad4170_fill_sps_tbl(struct ad4170_state *st)
@@ -434,6 +444,10 @@ static int ad4170_reg_write(void *context, unsigned int reg, unsigned int val)
 	case 1:
 		st->tx_buf[2] = val;
 		break;
+	case 0:
+		/* Write continuous read exit code */
+		st->tx_buf[0] = AD4170_ADC_CTRL_CONT_READ_EXIT;
+		return spi_write(st->spi, st->tx_buf, 1);
 	default:
 		return -EINVAL;
 	}
@@ -843,6 +857,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
+		.shift = 8,
 		.endianness = IIO_BE,
 	},
 };
@@ -1451,11 +1466,27 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad4170_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *active_scan_mask)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned int chan_index;
+	int ret;
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
 
@@ -1731,16 +1762,166 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
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
+	return regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
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
+	 * Use a high register address (virtual register) to request a write of
+	 * 0xA5 to the ADC during the first 8 SCLKs of the ADC data read cycle,
+	 * thus exiting continuous read.
+	 */
+	ret = regmap_write(st->regmap, AD4170_ADC_CTRL_CONT_READ_EXIT_REG, 0);
+
+	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
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
+
+	/*
+	 * The channel sequencer cycles through the enabled channels in
+	 * sequential order, from channel 0 to channel 15, bypassing disabled
+	 * channels. When more than one channel is enabled, channel 0 must
+	 * always be enabled. See datasheet channel_en register description at
+	 * page 95.
+	 */
+	if (bitmap_weight(scan_mask, masklength) > 1)
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
+		st->bounce_buffer[i] = get_unaligned_be32(st->rx_buf);
+	}
+
+	iio_push_to_buffers(indio_dev, st->bounce_buffer);
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_trigger_ops ad4170_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
 static irqreturn_t ad4170_irq_handler(int irq, void *dev_id)
 {
 	struct iio_dev *indio_dev = dev_id;
 	struct ad4170_state *st = iio_priv(indio_dev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(st->trig);
+	else
+		complete(&st->completion);
 
 	return IRQ_HANDLED;
 };
 
+static int ad4170_trigger_setup(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-trig%d",
+					  indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad4170_trigger_ops;
+	st->trig->dev.parent = indio_dev->dev.parent;
+
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
+	if (ret)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "Failed to register trigger\n");
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	return 0;
+}
+
 static int ad4170_regulator_setup(struct ad4170_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1851,8 +2032,22 @@ static int ad4170_probe(struct spi_device *spi)
 				       indio_dev->name, indio_dev);
 		if (ret)
 			return ret;
+
+		ret = ad4170_trigger_setup(indio_dev);
+		if (ret)
+			return ret;
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


