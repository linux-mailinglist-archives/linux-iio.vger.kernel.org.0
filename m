Return-Path: <linux-iio+bounces-6012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF29007D1
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCD11F21C4B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C119FA94;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meKX77Yo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA01990D8;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771989; cv=none; b=BLfKoA0JC8MTMFwuKz2KQsrznC+wBABCM57InY/unG3jCyOoGPbSMpx9uja8gG44HajGC/cg049zsvwO4jkD1oLpoq5jGLWK8U+4Qi0L0yrKD59eeOyivqYIr9vK0WqE337tWw9GTfReYYhtl10IYg65zINsJHfrgeO0CEL+7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771989; c=relaxed/simple;
	bh=jF1hYS+Xw8/uu5A6FAN+qO2D3BAQBvvCsaYhMGqhiTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQc5njWEkzPrAQq47sSU5ZKy6A4XF52/A4+g9Z1VXCf5YwSQSLShYvK8MZ4yO3oXNRZdtQq2k/ShUDVRG08bt16AdjEnjDNnlJdM9tQZ0xJ6AWrnqlg4NA8IDQk4q4woRm/hHEZiYeXoBQ2SXQm0TjBQ7umJr3QWuVGvNOP/RL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meKX77Yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39FF0C4AF0E;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771989;
	bh=jF1hYS+Xw8/uu5A6FAN+qO2D3BAQBvvCsaYhMGqhiTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=meKX77Yoa5B0qj4CD824ZHcUc82aH3pnjlPxdtFhAjn5uRPNP/82wY01RskFarjqj
	 3tLfqkpMrj2k6ownHWmmdeaSWjvQ3F78UUPZ7eG9Ud2OhBIIT7Xq8VcEhyjsesi5z/
	 aytcwAmf7MqeNfKpJuvxMH64aQIJFZvSs/MjkVWa8kTN9fWcWVA9VUTN2jDuTpn0bx
	 ySfiSeBAekiXed3M6gG9YIjPe0XLDJVYIY2GGTbgRcnuU7Zt6UK8pQuw5JuoCtEdy4
	 0WFTRyEnAFE4DCdEvtbNGtMFD6A1X2UKxEI6Q+kpIvQFnEyLqyUEoJPQfu4nNq4R0h
	 ydK56I+qV2rZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307FCC27C5F;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 07 Jun 2024 17:53:09 +0300
Subject: [PATCH v7 3/9] iio: adc: ad_sigma_delta: add disable_one callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-ad4111-v7-3-97e3855900a0@analog.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
In-Reply-To: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717771987; l=5816;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=L9cR6TgpFTXo/pEkA7l2c0LKsp4wR/2/7ocp+j3+FrY=;
 b=H9GHO1Hr46Dze1nAGn2DyeyGmAqoN00NlZ3/JmlIsmn+4giLZLDguUMnopNta0JLuKhlyKXxA
 /h6lPWiX8oPD4DElT/01u9r3bW92TC/jVLXWQH1C20bfFVNHNGrWfDT
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Sigma delta ADCs with a sequencer need to disable the previously enabled
channel when reading using ad_sigma_delta_single_conversion(). This was
done manually in drivers for devices with sequencers.

This patch implements handling of single channel disabling after a
single conversion.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7124.c               | 14 ++++++++------
 drivers/iio/adc/ad7173.c               | 11 ++++++-----
 drivers/iio/adc/ad_sigma_delta.c       |  6 ++++++
 include/linux/iio/adc/ad_sigma_delta.h | 14 ++++++++++++++
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index e7b1d517d3de..3beed78496c5 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -555,10 +555,18 @@ static int ad7124_disable_all(struct ad_sigma_delta *sd)
 	return 0;
 }
 
+static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+
+	return ad7124_spi_write_mask(st, AD7124_CHANNEL(chan), AD7124_CHANNEL_EN_MSK, 0, 2);
+}
+
 static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.set_channel = ad7124_set_channel,
 	.append_status = ad7124_append_status,
 	.disable_all = ad7124_disable_all,
+	.disable_one = ad7124_disable_one,
 	.set_mode = ad7124_set_mode,
 	.has_registers = true,
 	.addr_shift = 0,
@@ -582,12 +590,6 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		/* After the conversion is performed, disable the channel */
-		ret = ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan->address), 2,
-				      st->channels[chan->address].ain | AD7124_CHANNEL_EN(0));
-		if (ret < 0)
-			return ret;
-
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		mutex_lock(&st->cfgs_lock);
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 638e2468efbf..f3088e8b4b8b 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -569,10 +569,16 @@ static int ad7173_disable_all(struct ad_sigma_delta *sd)
 	return 0;
 }
 
+static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
+{
+	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
+}
+
 static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.set_channel = ad7173_set_channel,
 	.append_status = ad7173_append_status,
 	.disable_all = ad7173_disable_all,
+	.disable_one = ad7173_disable_one,
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.addr_shift = 0,
@@ -668,11 +674,6 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		/* disable channel after single conversion */
-		ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(chan->address), 2, 0);
-		if (ret < 0)
-			return ret;
-
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_TEMP) {
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 97a05f325df7..ec34b3d1336f 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -321,6 +321,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	ad_sigma_delta_disable_one(sigma_delta, chan->address);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 	iio_device_release_direct_mode(indio_dev);
@@ -671,6 +672,11 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 			dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_all().\n");
 			return -EINVAL;
 		}
+
+		if (!info->disable_one) {
+			dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_one().\n");
+			return -EINVAL;
+		}
 	}
 
 	if (info->irq_line)
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 383614ebd760..f8c1d2505940 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -37,6 +37,10 @@ struct iio_dev;
  * @append_status: Will be called to enable status append at the end of the sample, may be NULL.
  * @set_mode: Will be called to select the current mode, may be NULL.
  * @disable_all: Will be called to disable all channels, may be NULL.
+ * @disable_one: Will be called to disable a single channel after
+ *		ad_sigma_delta_single_conversion(), may be NULL.
+ *		Usage of this callback expects iio_chan_spec.address to contain
+ *		the value required for the driver to identify the channel.
  * @postprocess_sample: Is called for each sampled data word, can be used to
  *		modify or drop the sample data, it, may be NULL.
  * @has_registers: true if the device has writable and readable registers, false
@@ -55,6 +59,7 @@ struct ad_sigma_delta_info {
 	int (*append_status)(struct ad_sigma_delta *, bool append);
 	int (*set_mode)(struct ad_sigma_delta *, enum ad_sigma_delta_mode mode);
 	int (*disable_all)(struct ad_sigma_delta *);
+	int (*disable_one)(struct ad_sigma_delta *, unsigned int chan);
 	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
 	bool has_registers;
 	unsigned int addr_shift;
@@ -140,6 +145,15 @@ static inline int ad_sigma_delta_disable_all(struct ad_sigma_delta *sd)
 	return 0;
 }
 
+static inline int ad_sigma_delta_disable_one(struct ad_sigma_delta *sd,
+					     unsigned int chan)
+{
+	if (sd->info->disable_one)
+		return sd->info->disable_one(sd, chan);
+
+	return 0;
+}
+
 static inline int ad_sigma_delta_set_mode(struct ad_sigma_delta *sd,
 	unsigned int mode)
 {

-- 
2.43.0



