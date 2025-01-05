Return-Path: <linux-iio+bounces-13911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA7A01AE1
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CABF3A2FB0
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4817BB0D;
	Sun,  5 Jan 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPW/6rD+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5D8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098014; cv=none; b=qkWBw/kbNHe3AsgO4fJY32kbE+LAL757mMQk6JGmKiIkMs2q2LkYZfvmTwQu5bE4rYfu57oYULwdI7yGekcGEk07VSt842GsXDFRXAu5cQ5r96x/UY0sIzSi9OU+H38wkB6JkAtOK1tbXjULMBXiQ8a5Se4ieJ6KSO+QFrQrcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098014; c=relaxed/simple;
	bh=ffVqcrp7WSVymc9RZ8iLqJXWAA/B3Rk4otNv7EmrnCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRa2DcYuyTIbjfusXgYCZqC3qXsGH5fle2ftRjL1J7ZyYCOKXHY2reSHNvZ2FO2jf9W9d0972+E81gbL6tYw0Elqp5qN+wzVDg0GEd7NbynWA2NIwR4fQyA+5bN2Sc/qp2o19ORqXFAR9sszVSJI1tLq93+2uWdJN9TGA+J05u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPW/6rD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA26C4CED0;
	Sun,  5 Jan 2025 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098014;
	bh=ffVqcrp7WSVymc9RZ8iLqJXWAA/B3Rk4otNv7EmrnCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPW/6rD+ouE6aOLbYsYNe3+a3adQ/kHZyjBsQBDsbSyagAU0rnVhyqrOENc8G+lfQ
	 7SWAXNbmnyeeC/cqLQyEBbtclVEzh5j0PxwaBiY2HaEkZvBLTihQbjbQ7rHgXNB26X
	 86MMnxIWqm/si+rDVu2Ke+hMV5chZijS2KoOYjqTIPnOakaY9EX24D9v0xDGCQoqoi
	 b9oi3aDw6BuFDDHUjF9XeysmCuTLOA/iDdPFvLng/Q4Rgqvzg1ddBcDShJ4YxFf8gK
	 CJ/KWBm6Pm7ulFW2pUVq3dFmFgdxnGxRjx4Iy7/97egFLo1tP1ocGlu13IYZxJKu/A
	 KqWm/C65UoYLA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 12/27] iio: adc: ad4695: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:57 +0000
Message-ID: <20250105172613.1204781-13-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
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
---
 drivers/iio/adc/ad4695.c | 240 ++++++++++++++++++++++-----------------
 1 file changed, 133 insertions(+), 107 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 3c2c01289fda..e7bf4870099c 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -617,6 +617,25 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 	return spi_sync_transfer(st->spi, xfer, i + 1);
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
@@ -629,19 +648,12 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 
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
@@ -679,45 +691,45 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
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
@@ -726,64 +738,75 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
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
@@ -833,26 +856,29 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
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
2.47.1


