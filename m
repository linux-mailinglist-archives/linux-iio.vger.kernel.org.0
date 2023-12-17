Return-Path: <linux-iio+bounces-1029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63691816146
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C76C2810EF
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874A46456;
	Sun, 17 Dec 2023 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOSnRAzN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34224315B6
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEFCC433C7;
	Sun, 17 Dec 2023 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834588;
	bh=2uCw5nBLdjoWv8A5y412Z5b8SFsuPn40M7uS/av9Qyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOSnRAzN+HOny2TpwJtAMp/1E+GY/+iUQrNx9F2eAp5PUF5mEVaLHfCghozWSySHR
	 /S9oQfhgNI49Lw/CVeP2fXH/vtg/xtCuXQhT1zDVNtPMAZR2Y9E+k0bsu3LOaB9l3y
	 ZjvaSgzKneod7gQp78ov/Hn8mYa20ewqelsSZUMpSEnixc7bTwPw31nJLeEvtrPQpC
	 V+PHkzrLY7L9zd5C7krfGJ2I+VWHcSyk4+zxaffwqvtliNlkywKaIchhiww7j7Io8n
	 3ROnldFfi9PfTksPsBp1/Pw8SL5p6Z3xrqHAJzdgqglEcPZX0tBByD9mgfCPPLacrR
	 0G/lwywhhrmow==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 09/10] iio: adc: ad4130: Use automatic cleanup of locks and direct mode.
Date: Sun, 17 Dec 2023 17:35:47 +0000
Message-ID: <20231217173548.112701-10-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217173548.112701-1-jic23@kernel.org>
References: <20231217173548.112701-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces boilerplate and allows for simpler to follow direct returns.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4130.c | 128 ++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index feb86fe6c422..10ccb4ea8a29 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -887,9 +887,9 @@ static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
 	unsigned int old_fs;
 	int ret = 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (setup_info->filter_mode == val)
-		goto out;
+		return 0;
 
 	old_fs = setup_info->fs;
 	old_filter_mode = setup_info->filter_mode;
@@ -911,12 +911,10 @@ static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
 	if (ret) {
 		setup_info->fs = old_fs;
 		setup_info->filter_mode = old_filter_mode;
+		return ret;
 	}
 
- out:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static int ad4130_get_filter_mode(struct iio_dev *indio_dev,
@@ -927,9 +925,8 @@ static int ad4130_get_filter_mode(struct iio_dev *indio_dev,
 	struct ad4130_setup_info *setup_info = &st->chans_info[channel].setup;
 	enum ad4130_filter_mode filter_mode;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	filter_mode = setup_info->filter_mode;
-	mutex_unlock(&st->lock);
 
 	return filter_mode;
 }
@@ -971,7 +968,7 @@ static int ad4130_set_channel_pga(struct ad4130_state *st, unsigned int channel,
 	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
 	struct ad4130_setup_info *setup_info = &chan_info->setup;
 	unsigned int pga, old_pga;
-	int ret = 0;
+	int ret;
 
 	for (pga = 0; pga < AD4130_MAX_PGA; pga++)
 		if (val == st->scale_tbls[setup_info->ref_sel][pga][0] &&
@@ -981,21 +978,20 @@ static int ad4130_set_channel_pga(struct ad4130_state *st, unsigned int channel,
 	if (pga == AD4130_MAX_PGA)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (pga == setup_info->pga)
-		goto out;
+		return 0;
 
 	old_pga = setup_info->pga;
 	setup_info->pga = pga;
 
 	ret = ad4130_write_channel_setup(st, channel, false);
-	if (ret)
+	if (ret) {
 		setup_info->pga = old_pga;
+		return ret;
+	}
 
-out:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static int ad4130_set_channel_freq(struct ad4130_state *st,
@@ -1004,26 +1000,25 @@ static int ad4130_set_channel_freq(struct ad4130_state *st,
 	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
 	struct ad4130_setup_info *setup_info = &chan_info->setup;
 	unsigned int fs, old_fs;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	old_fs = setup_info->fs;
 
 	ad4130_freq_to_fs(setup_info->filter_mode, val, val2, &fs);
 
 	if (fs == setup_info->fs)
-		goto out;
+		return 0;
 
 	setup_info->fs = fs;
 
 	ret = ad4130_write_channel_setup(st, channel, false);
-	if (ret)
+	if (ret) {
 		setup_info->fs = old_fs;
+		return ret;
+	}
 
-out:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static int _ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
@@ -1066,19 +1061,13 @@ static int ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
 			      int *val)
 {
 	struct ad4130_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
 
-	mutex_lock(&st->lock);
-	ret = _ad4130_read_sample(indio_dev, channel, val);
-	mutex_unlock(&st->lock);
-
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		guard(mutex)(&st->lock);
+		return _ad4130_read_sample(indio_dev, channel, val);
+	}
 
-	return ret;
+	return -EINVAL;
 }
 
 static int ad4130_read_raw(struct iio_dev *indio_dev,
@@ -1092,24 +1081,24 @@ static int ad4130_read_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		return ad4130_read_sample(indio_dev, channel, val);
-	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&st->lock);
 		*val = st->scale_tbls[setup_info->ref_sel][setup_info->pga][0];
 		*val2 = st->scale_tbls[setup_info->ref_sel][setup_info->pga][1];
-		mutex_unlock(&st->lock);
 
 		return IIO_VAL_INT_PLUS_NANO;
+	}
 	case IIO_CHAN_INFO_OFFSET:
 		*val = st->bipolar ? -BIT(chan->scan_type.realbits - 1) : 0;
 
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
 		ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
 				  val, val2);
-		mutex_unlock(&st->lock);
 
 		return IIO_VAL_INT_PLUS_NANO;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1134,9 +1123,9 @@ static int ad4130_read_avail(struct iio_dev *indio_dev,
 
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&st->lock);
-		filter_config = &ad4130_filter_configs[setup_info->filter_mode];
-		mutex_unlock(&st->lock);
+		scoped_guard(mutex, &st->lock) {
+			filter_config = &ad4130_filter_configs[setup_info->filter_mode];
+		}
 
 		*vals = (int *)filter_config->samp_freq_avail;
 		*length = filter_config->samp_freq_avail_len * 2;
@@ -1197,21 +1186,18 @@ static int ad4130_update_scan_mode(struct iio_dev *indio_dev,
 	unsigned int val = 0;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	for_each_set_bit(channel, scan_mask, indio_dev->num_channels) {
 		ret = ad4130_set_channel_enable(st, channel, true);
 		if (ret)
-			goto out;
+			return ret;
 
 		val++;
 	}
 
 	st->num_enabled_channels = val;
 
-out:
-	mutex_unlock(&st->lock);
-
 	return 0;
 }
 
@@ -1232,22 +1218,19 @@ static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val
 		 */
 		eff = rounddown(AD4130_FIFO_SIZE, st->num_enabled_channels);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = regmap_update_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
 				 AD4130_FIFO_CONTROL_WM_MASK,
 				 FIELD_PREP(AD4130_FIFO_CONTROL_WM_MASK,
 					    ad4130_watermark_reg_val(eff)));
 	if (ret)
-		goto out;
+		return ret;
 
 	st->effective_watermark = eff;
 	st->watermark = val;
 
-out:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_info ad4130_info = {
@@ -1265,26 +1248,21 @@ static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad4130_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = ad4130_set_watermark_interrupt_en(st, true);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = irq_set_irq_type(st->spi->irq, st->inv_irq_trigger);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_WM);
 	if (ret)
-		goto out;
-
-	ret = ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
-
-out:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
 }
 
 static int ad4130_buffer_predisable(struct iio_dev *indio_dev)
@@ -1293,23 +1271,23 @@ static int ad4130_buffer_predisable(struct iio_dev *indio_dev)
 	unsigned int i;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = ad4130_set_mode(st, AD4130_MODE_IDLE);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = irq_set_irq_type(st->spi->irq, st->irq_trigger);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_DISABLED);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = ad4130_set_watermark_interrupt_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * update_scan_mode() is not called in the disable path, disable all
@@ -1318,13 +1296,10 @@ static int ad4130_buffer_predisable(struct iio_dev *indio_dev)
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		ret = ad4130_set_channel_enable(st, i, false);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-out:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops ad4130_buffer_ops = {
@@ -1338,9 +1313,8 @@ static ssize_t hwfifo_watermark_show(struct device *dev,
 	struct ad4130_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned int val;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	val = st->watermark;
-	mutex_unlock(&st->lock);
 
 	return sysfs_emit(buf, "%d\n", val);
 }
-- 
2.43.0


