Return-Path: <linux-iio+bounces-15005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBFEA27C5E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8543A3B17
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9F14B094;
	Tue,  4 Feb 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbcklVdq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EB204C20
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699436; cv=none; b=BWr72JOftOXnGf9pllWNVG2zl8vNTPiN1pO5l2xo26imY4/ffJbu0pHLyfYL4LXD+V1f2HN79vtor1+3Tc0XQ+5o2ZU6Kf1viFLg1+eFU3AE4FbyeSg2JIK3u44v9IO8LJ3vjJ3sqhsu6P1nLWfJUYuAGy6CiKJR63jWiuzpYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699436; c=relaxed/simple;
	bh=FGFF9acb4h/zHpQ8mS/4HyarxD4lApfWvQ6IdD31nHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bgb/ShB/WNtwPkjPspuAJ9iUBrFoowUGaW1SDG/tXVHsSEfJf15WWgjPm+IdIDVYgjEMUAUojbw5ePPAEBH8L/xBHDDUXQNptQhpBe5MtnqosUQcJG4+N6A7a4/lAliBm7dvAVpXEYZqzvsyX7B5OxY+NNbVf0mQ5pxQKo2Eqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbcklVdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60A6C4CEE6;
	Tue,  4 Feb 2025 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699436;
	bh=FGFF9acb4h/zHpQ8mS/4HyarxD4lApfWvQ6IdD31nHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbcklVdqatmoLWA06rACzK4CwniEIF3VTo3XRiS9suLfbSJXI69zkzvMJt1ZIkpB2
	 46uywLH7b05I18DEO1XxynHLxQ7B/04V4FcJnaOk6gij1qwRiTrdGtFFR+KLLDy/y+
	 Ve8bebNJZNsDJTLa8pUzkzDjWFsFaM1mM2LcD59Icfh3+9sQ0ubyFabRUmjBkINTdJ
	 YINc4Vos7rfBamYe3TnSKYP9rLYefv2yaKVlUJozgDGgVN4sSpNdVCk07sBfX3e0eb
	 rWSid1wHzb08OMk0yBs6IQ8pe0ryVv2qZt0QcWY91Wa+Ctb5nK1kKv7LkKrSoJcL3O
	 l062C2hBCjGzg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/27] iio: adc: ad4695: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:33 +0000
Message-ID: <20250204200250.636721-12-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.  In some cases code is factored
out to utility functions that can do a direect return with the
claim and release around the call.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 240 ++++++++++++++++++++++-----------------
 1 file changed, 133 insertions(+), 107 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 13cf01d35301..4bb22f4d739b 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -738,6 +738,25 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
+static int __ad4695_read_info_raw(struct ad4695_state *st,
+				  struct iio_chan_spec const *chan,
+				  int *val)
+{
+	u8 realbits = chan->scan_type.realbits;
+	int ret;
+
+	ret = ad4695_read_one_sample(st, chan->address);
+	if (ret)
+		return ret;
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(st->raw_data, realbits - 1);
+	else
+		*val = st->raw_data;
+
+	return IIO_VAL_INT;
+}
+
 static int ad4695_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -750,19 +769,12 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad4695_read_one_sample(st, chan->address);
-			if (ret)
-				return ret;
-
-			if (chan->scan_type.sign == 's')
-				*val = sign_extend32(st->raw_data, realbits - 1);
-			else
-				*val = st->raw_data;
 
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = __ad4695_read_info_raw(st, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -800,45 +812,45 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBSCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = regmap_read(st->regmap16,
-					AD4695_REG_GAIN_IN(chan->scan_index),
-					&reg_val);
-				if (ret)
-					return ret;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+			ret = regmap_read(st->regmap16,
+					  AD4695_REG_GAIN_IN(chan->scan_index),
+					  &reg_val);
+			iio_device_release_direct(indio_dev);
+			if (ret)
+				return ret;
 
-				*val = reg_val;
-				*val2 = 15;
+			*val = reg_val;
+			*val2 = 15;
 
-				return IIO_VAL_FRACTIONAL_LOG2;
-			}
-			unreachable();
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = regmap_read(st->regmap16,
-					AD4695_REG_OFFSET_IN(chan->scan_index),
-					&reg_val);
-				if (ret)
-					return ret;
-
-				tmp = sign_extend32(reg_val, 15);
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+			ret = regmap_read(st->regmap16,
+					  AD4695_REG_OFFSET_IN(chan->scan_index),
+					  &reg_val);
+			iio_device_release_direct(indio_dev);
+			if (ret)
+				return ret;
 
-				*val = tmp / 4;
-				*val2 = abs(tmp) % 4 * MICRO / 4;
+			tmp = sign_extend32(reg_val, 15);
 
-				if (tmp < 0 && *val2) {
-					*val *= -1;
-					*val2 *= -1;
-				}
+			*val = tmp / 4;
+			*val2 = abs(tmp) % 4 * MICRO / 4;
 
-				return IIO_VAL_INT_PLUS_MICRO;
+			if (tmp < 0 && *val2) {
+				*val *= -1;
+				*val2 *= -1;
 			}
-			unreachable();
+
+			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
@@ -847,64 +859,75 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad4695_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int __ad4695_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct ad4695_state *st = iio_priv(indio_dev);
 	unsigned int reg_val;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		switch (mask) {
-		case IIO_CHAN_INFO_CALIBSCALE:
-			switch (chan->type) {
-			case IIO_VOLTAGE:
-				if (val < 0 || val2 < 0)
-					reg_val = 0;
-				else if (val > 1)
-					reg_val = U16_MAX;
-				else
-					reg_val = (val * (1 << 16) +
-						   mul_u64_u32_div(val2, 1 << 16,
-								   MICRO)) / 2;
-
-				return regmap_write(st->regmap16,
-					AD4695_REG_GAIN_IN(chan->scan_index),
-					reg_val);
-			default:
-				return -EINVAL;
-			}
-		case IIO_CHAN_INFO_CALIBBIAS:
-			switch (chan->type) {
-			case IIO_VOLTAGE:
-				if (val2 >= 0 && val > S16_MAX / 4)
-					reg_val = S16_MAX;
-				else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
-					reg_val = S16_MIN;
-				else if (val2 < 0)
-					reg_val = clamp_t(int,
-						-(val * 4 + -val2 * 4 / MICRO),
-						S16_MIN, S16_MAX);
-				else if (val < 0)
-					reg_val = clamp_t(int,
-						val * 4 - val2 * 4 / MICRO,
-						S16_MIN, S16_MAX);
-				else
-					reg_val = clamp_t(int,
-						val * 4 + val2 * 4 / MICRO,
-						S16_MIN, S16_MAX);
-
-				return regmap_write(st->regmap16,
-					AD4695_REG_OFFSET_IN(chan->scan_index),
-					reg_val);
-			default:
-				return -EINVAL;
-			}
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (val < 0 || val2 < 0)
+				reg_val = 0;
+			else if (val > 1)
+				reg_val = U16_MAX;
+			else
+				reg_val = (val * (1 << 16) +
+					   mul_u64_u32_div(val2, 1 << 16,
+							   MICRO)) / 2;
+
+			return regmap_write(st->regmap16,
+					    AD4695_REG_GAIN_IN(chan->scan_index),
+					    reg_val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (val2 >= 0 && val > S16_MAX / 4)
+				reg_val = S16_MAX;
+			else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
+				reg_val = S16_MIN;
+			else if (val2 < 0)
+				reg_val = clamp_t(int,
+						  -(val * 4 + -val2 * 4 / MICRO),
+						  S16_MIN, S16_MAX);
+			else if (val < 0)
+				reg_val = clamp_t(int,
+						  val * 4 - val2 * 4 / MICRO,
+						  S16_MIN, S16_MAX);
+			else
+				reg_val = clamp_t(int,
+						  val * 4 + val2 * 4 / MICRO,
+						  S16_MIN, S16_MAX);
+
+			return regmap_write(st->regmap16,
+					    AD4695_REG_OFFSET_IN(chan->scan_index),
+					    reg_val);
 		default:
 			return -EINVAL;
 		}
+	default:
+		return -EINVAL;
 	}
-	unreachable();
+}
+
+static int ad4695_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ret = __ad4695_write_raw(indio_dev, chan, val, val2, mask);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
 }
 
 static int ad4695_read_avail(struct iio_dev *indio_dev,
@@ -954,26 +977,29 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 				     unsigned int *readval)
 {
 	struct ad4695_state *st = iio_priv(indio_dev);
-
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		if (readval) {
-			if (regmap_check_range_table(st->regmap, reg,
-						     &ad4695_regmap_rd_table))
-				return regmap_read(st->regmap, reg, readval);
-			if (regmap_check_range_table(st->regmap16, reg,
-						     &ad4695_regmap16_rd_table))
-				return regmap_read(st->regmap16, reg, readval);
-		} else {
-			if (regmap_check_range_table(st->regmap, reg,
-						     &ad4695_regmap_wr_table))
-				return regmap_write(st->regmap, reg, writeval);
-			if (regmap_check_range_table(st->regmap16, reg,
-						     &ad4695_regmap16_wr_table))
-				return regmap_write(st->regmap16, reg, writeval);
-		}
+	int ret = -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (readval) {
+		if (regmap_check_range_table(st->regmap, reg,
+					     &ad4695_regmap_rd_table))
+			ret = regmap_read(st->regmap, reg, readval);
+		if (regmap_check_range_table(st->regmap16, reg,
+					     &ad4695_regmap16_rd_table))
+			ret = regmap_read(st->regmap16, reg, readval);
+	} else {
+		if (regmap_check_range_table(st->regmap, reg,
+					     &ad4695_regmap_wr_table))
+			ret = regmap_write(st->regmap, reg, writeval);
+		if (regmap_check_range_table(st->regmap16, reg,
+					     &ad4695_regmap16_wr_table))
+			ret = regmap_write(st->regmap16, reg, writeval);
 	}
+	iio_device_release_direct(indio_dev);
 
-	return -EINVAL;
+	return ret;
 }
 
 static const struct iio_info ad4695_info = {
-- 
2.48.1


