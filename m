Return-Path: <linux-iio+bounces-15204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79536A2DFC8
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4F218853A4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6691DED7B;
	Sun,  9 Feb 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw9IIqm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54051E0DE3
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124483; cv=none; b=sPLmcq/quZ9Y9bsCEDU2QPKCIWYdGKvPl8FUQnbVZtzeBHD5vLabyJTFaIhMEpXoB3riR7f7Q4VQYDAyn9TTW0qgKXPs+oKfG5yQpM6NvFdtHY8A339V2+n3ZLhtS/n47pPRahlehWgmeQJJCDIhN5QJqMxEaxlIISXp9uRvKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124483; c=relaxed/simple;
	bh=r06e45w7y/RPqT4Lo6jKZ9NpHEA4wvNPwLkvlBKkcXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDhO+fN2WnO0nUfpdx7otwseamFhQKeyNQRP+F2wMKeLXH9GMpVore63LAILILkVQClRXuD8MJH95EgYd69j9EkB7fiDHdyifHzSPLdXrokqHPIGdiZ4PCS2IEfHtK0wanKL2J2lWtuquEyoxZ8iXbLHnmMvgQg2+yi3QRCiEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw9IIqm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C119C4CEDD;
	Sun,  9 Feb 2025 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124483;
	bh=r06e45w7y/RPqT4Lo6jKZ9NpHEA4wvNPwLkvlBKkcXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aw9IIqm/93DH2ybNsA4mffJVb+VhNxVbPhXDCBRVd/6vk16A6K5QtjmWhSTJwq5ak
	 fJwB/veFft9N5Ja4oly3w8yV141nOkTujpUS1LFPGMyRf7C5eWwXqkUsCo/fYftl7W
	 TQ8w0x4lUknq0lnsKsFa1qxaqiQXB3hFsXXxQN0TKRkbtwDFVWSdYnoAV8qWwQenBr
	 AgUKP0+xXYruVdbGlSAv4TPN3DL+aEkb+Z8aNaG7xyY7QCAqcryDlCAV9XEO2vsMYH
	 3oBIxwvXs6N1uAm/HpjVRIvsBci/jpZ50L3xz8C2kO+loqsqZJhpq9Z8KTgokJO+uz
	 DZXTb3N7kauEg==
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
Subject: [PATCH v2 11/27] iio: adc: ad4695: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:08 +0000
Message-ID: <20250209180624.701140-12-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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
out to utility functions that can do a direct return with the
claim and release around the call.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Typo in commit description (David).
Note there are several sets current in flight that touch this driver.
I'll rebase as necessary depending on what order the dependencies resolve.
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


