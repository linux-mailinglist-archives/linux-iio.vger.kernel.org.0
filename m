Return-Path: <linux-iio+bounces-15609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B6A37682
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 19:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3CC3AFC40
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E29319D07A;
	Sun, 16 Feb 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P10WC2Ih"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2938385
	for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739729960; cv=none; b=rS6aU5j9+Cw+Bzi0Y8ipDBvkm7aylYN0UgoNVu7nBDr+6btONUTASNa6WoTX4g8X+d7i7B4QUqeMVK+nCMQTPdbfQa1DtEJjiGcFFe/YTEkqMwRsU+4zDduYzeoA9Y8hWwXzHx1zki0QYScVDsoiIonkU4LWNC8N/N5w3spOeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739729960; c=relaxed/simple;
	bh=QbqchZD8bbSZUVPjjRgz2YN6Co3adI8u3qwMwKFKRR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKLV5M7D4BjetTPmIc0Lh8y2DAsuLaYisp3oQPqQZ4R2aUnDxuLXfgPgSVxM1c609Zk6EP54PIKmhakIpAEWWc5Dl5zGbUiHh8OX+oFtd5h0OMq5Uc0ySUVvOgnJ/VPaR+g4pn3BaECOm9IcMUbGMFU9dVaLy5xiLUON6gr/Bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P10WC2Ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4053FC4CEDD;
	Sun, 16 Feb 2025 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739729959;
	bh=QbqchZD8bbSZUVPjjRgz2YN6Co3adI8u3qwMwKFKRR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P10WC2IhQh8Lvdd9r3GLwGxsYs+To86YR8uhftr9twnIavK9f4gs+uVVngtKBtL70
	 68NoDnuhkV4oc1lBvniLZm9nvxDxERGzYzjSCMHXa+gUNhykIWlpDWhG1nfc01btvY
	 uOXL3hCXk7vvleo1WnGaZ2S22v20tUhP4aWg9JmU1Vf8Ies1fWowwUM2s3AVL7wg/b
	 e8x9B+4UZCvDislta8Y+ovw1mSNtTQscTpShFC65fTWbKVu+uY9S1NyU+DsbKCO9BD
	 aFpS972c0GLB53O7Yy5X/mXsBQY7E5xEg+4zZTBggZ2ihETd0wkmomoTKSFGNVl57M
	 rbAydEIa4vKrw==
Date: Sun, 16 Feb 2025 18:19:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/27] iio: adc: ad4695: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <20250216181907.40d36bf7@jic23-huawei>
In-Reply-To: <20250209180624.701140-12-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	<20250209180624.701140-12-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Feb 2025 18:06:08 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
> 
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.  In some cases code is factored
> out to utility functions that can do a direct return with the
> claim and release around the call.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Typo in commit description (David).
> Note there are several sets current in flight that touch this driver.
> I'll rebase as necessary depending on what order the dependencies resolve.
I've done this rebase and applied on the testing branch of iio.git.

Would appreciate a sanity check if anyone has time though!

New code is as follows.  The one corner I was not sure on was
that for calibbias reading the direct mode claim was held for a long
time.  That seems to be unnecessary as we have a copy of osr anyway
in that function used for other purposes.

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 3a1a6f96480f..9dbf326b6273 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -1029,6 +1029,25 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
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
@@ -1049,19 +1068,12 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad4695_read_one_sample(st, chan->address);
-			if (ret)
-				return ret;
-
-			if (scan_type->sign == 's')
-				*val = sign_extend32(st->raw_data, realbits - 1);
-			else
-				*val = st->raw_data;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		ret = __ad4695_read_info_raw(st, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -1099,63 +1111,62 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBSCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = regmap_read(st->regmap16,
-					AD4695_REG_GAIN_IN(chan->scan_index),
-					&reg_val);
-				if (ret)
-					return ret;
-
-				*val = reg_val;
-				*val2 = 15;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+			ret = regmap_read(st->regmap16,
+					  AD4695_REG_GAIN_IN(chan->scan_index),
+					  &reg_val);
+			iio_device_release_direct(indio_dev);
+			if (ret)
+				return ret;
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
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = regmap_read(st->regmap16,
-					AD4695_REG_OFFSET_IN(chan->scan_index),
-					&reg_val);
-				if (ret)
-					return ret;
-
-				tmp = sign_extend32(reg_val, 15);
-
-				switch (cfg->oversampling_ratio) {
-				case 1:
-					*val = tmp / 4;
-					*val2 = abs(tmp) % 4 * MICRO / 4;
-					break;
-				case 4:
-					*val = tmp / 2;
-					*val2 = abs(tmp) % 2 * MICRO / 2;
-					break;
-				case 16:
-					*val = tmp;
-					*val2 = 0;
-					break;
-				case 64:
-					*val = tmp * 2;
-					*val2 = 0;
-					break;
-				default:
-					return -EINVAL;
-				}
-
-				if (tmp < 0 && *val2) {
-					*val *= -1;
-					*val2 *= -1;
-				}
-
-				return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type)
+		case IIO_VOLTAGE: {
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+			ret = regmap_read(st->regmap16,
+					  AD4695_REG_OFFSET_IN(chan->scan_index),
+					  &reg_val);
+			iio_device_release_direct(indio_dev);
+			if (ret)
+				return ret;
////THIS IS THE BIT I WOuLD LIKE EYES on.
+
+			tmp = sign_extend32(reg_val, 15);
+
+			switch (osr) {
+			case 1:
+				*val = tmp / 4;
+				*val2 = abs(tmp) % 4 * MICRO / 4;
+				break;
+			case 4:
+				*val = tmp / 2;
+				*val2 = abs(tmp) % 2 * MICRO / 2;
+				break;
+			case 16:
+				*val = tmp;
+				*val2 = 0;
+				break;
+			case 64:
+				*val = tmp * 2;
+				*val2 = 0;
+				break;
+			default:
+				return -EINVAL;
+			}
+
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
@@ -1255,72 +1266,83 @@ static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
 	return clamp_t(int, val_calc, S16_MIN, S16_MAX);
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
 	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
 
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
-				reg_val = ad4695_get_calibbias(val, val2, osr);
-				return regmap_write(st->regmap16,
-					AD4695_REG_OFFSET_IN(chan->scan_index),
-					reg_val);
-			default:
-				return -EINVAL;
-			}
-		case IIO_CHAN_INFO_SAMP_FREQ: {
-			struct pwm_state state;
-			/*
-			 * Limit the maximum acceptable sample rate according to
-			 * the channel's oversampling ratio.
-			 */
-			u64 max_osr_rate = DIV_ROUND_UP_ULL(st->chip_info->max_sample_rate,
-							    osr);
-
-			if (val <= 0 || val > max_osr_rate)
-				return -EINVAL;
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
 
-			guard(mutex)(&st->cnv_pwm_lock);
-			pwm_get_state(st->cnv_pwm, &state);
-			/*
-			 * The required sample frequency for a given OSR is the
-			 * input frequency multiplied by it.
-			 */
-			state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val * osr);
-			return pwm_apply_might_sleep(st->cnv_pwm, &state);
+			return regmap_write(st->regmap16,
+					    AD4695_REG_GAIN_IN(chan->scan_index),
+					    reg_val);
+		default:
+			return -EINVAL;
 		}
-		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-			return ad4695_set_osr_val(st, chan, val);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			reg_val = ad4695_get_calibbias(val, val2, osr);
+			return regmap_write(st->regmap16,
+					    AD4695_REG_OFFSET_IN(chan->scan_index),
+					    reg_val);
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		struct pwm_state state;
+		/*
+		 * Limit the maximum acceptable sample rate according to
+		 * the channel's oversampling ratio.
+		 */
+		u64 max_osr_rate = DIV_ROUND_UP_ULL(st->chip_info->max_sample_rate,
+						    osr);
+
+		if (val <= 0 || val > max_osr_rate)
+			return -EINVAL;
+
+		guard(mutex)(&st->cnv_pwm_lock);
+		pwm_get_state(st->cnv_pwm, &state);
+		/*
+		 * The required sample frequency for a given OSR is the
+		 * input frequency multiplied by it.
+		 */
+		state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val * osr);
+		return pwm_apply_might_sleep(st->cnv_pwm, &state);
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4695_set_osr_val(st, chan, val);
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
@@ -1417,26 +1439,29 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
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
 
 static int ad4695_get_current_scan_type(const struct iio_dev *indio_dev,


Jonathan

> ---
>  drivers/iio/adc/ad4695.c | 240 ++++++++++++++++++++++-----------------
>  1 file changed, 133 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 13cf01d35301..4bb22f4d739b 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -738,6 +738,25 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
>  	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  }
>  
> +static int __ad4695_read_info_raw(struct ad4695_state *st,
> +				  struct iio_chan_spec const *chan,
> +				  int *val)
> +{
> +	u8 realbits = chan->scan_type.realbits;
> +	int ret;
> +
> +	ret = ad4695_read_one_sample(st, chan->address);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->scan_type.sign == 's')
> +		*val = sign_extend32(st->raw_data, realbits - 1);
> +	else
> +		*val = st->raw_data;
> +
> +	return IIO_VAL_INT;
> +}
> +
>  static int ad4695_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -750,19 +769,12 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			ret = ad4695_read_one_sample(st, chan->address);
> -			if (ret)
> -				return ret;
> -
> -			if (chan->scan_type.sign == 's')
> -				*val = sign_extend32(st->raw_data, realbits - 1);
> -			else
> -				*val = st->raw_data;
>  
> -			return IIO_VAL_INT;
> -		}
> -		unreachable();
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret = __ad4695_read_info_raw(st, chan, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> @@ -800,45 +812,45 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -				ret = regmap_read(st->regmap16,
> -					AD4695_REG_GAIN_IN(chan->scan_index),
> -					&reg_val);
> -				if (ret)
> -					return ret;
> +			if (!iio_device_claim_direct(indio_dev))
> +				return -EBUSY;
> +			ret = regmap_read(st->regmap16,
> +					  AD4695_REG_GAIN_IN(chan->scan_index),
> +					  &reg_val);
> +			iio_device_release_direct(indio_dev);
> +			if (ret)
> +				return ret;
>  
> -				*val = reg_val;
> -				*val2 = 15;
> +			*val = reg_val;
> +			*val2 = 15;
>  
> -				return IIO_VAL_FRACTIONAL_LOG2;
> -			}
> -			unreachable();
> +			return IIO_VAL_FRACTIONAL_LOG2;
>  		default:
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -				ret = regmap_read(st->regmap16,
> -					AD4695_REG_OFFSET_IN(chan->scan_index),
> -					&reg_val);
> -				if (ret)
> -					return ret;
> -
> -				tmp = sign_extend32(reg_val, 15);
> +			if (!iio_device_claim_direct(indio_dev))
> +				return -EBUSY;
> +			ret = regmap_read(st->regmap16,
> +					  AD4695_REG_OFFSET_IN(chan->scan_index),
> +					  &reg_val);
> +			iio_device_release_direct(indio_dev);
> +			if (ret)
> +				return ret;
>  
> -				*val = tmp / 4;
> -				*val2 = abs(tmp) % 4 * MICRO / 4;
> +			tmp = sign_extend32(reg_val, 15);
>  
> -				if (tmp < 0 && *val2) {
> -					*val *= -1;
> -					*val2 *= -1;
> -				}
> +			*val = tmp / 4;
> +			*val2 = abs(tmp) % 4 * MICRO / 4;
>  
> -				return IIO_VAL_INT_PLUS_MICRO;
> +			if (tmp < 0 && *val2) {
> +				*val *= -1;
> +				*val2 *= -1;
>  			}
> -			unreachable();
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -847,64 +859,75 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int ad4695_write_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int val, int val2, long mask)
> +static int __ad4695_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
>  {
>  	struct ad4695_state *st = iio_priv(indio_dev);
>  	unsigned int reg_val;
>  
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		switch (mask) {
> -		case IIO_CHAN_INFO_CALIBSCALE:
> -			switch (chan->type) {
> -			case IIO_VOLTAGE:
> -				if (val < 0 || val2 < 0)
> -					reg_val = 0;
> -				else if (val > 1)
> -					reg_val = U16_MAX;
> -				else
> -					reg_val = (val * (1 << 16) +
> -						   mul_u64_u32_div(val2, 1 << 16,
> -								   MICRO)) / 2;
> -
> -				return regmap_write(st->regmap16,
> -					AD4695_REG_GAIN_IN(chan->scan_index),
> -					reg_val);
> -			default:
> -				return -EINVAL;
> -			}
> -		case IIO_CHAN_INFO_CALIBBIAS:
> -			switch (chan->type) {
> -			case IIO_VOLTAGE:
> -				if (val2 >= 0 && val > S16_MAX / 4)
> -					reg_val = S16_MAX;
> -				else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
> -					reg_val = S16_MIN;
> -				else if (val2 < 0)
> -					reg_val = clamp_t(int,
> -						-(val * 4 + -val2 * 4 / MICRO),
> -						S16_MIN, S16_MAX);
> -				else if (val < 0)
> -					reg_val = clamp_t(int,
> -						val * 4 - val2 * 4 / MICRO,
> -						S16_MIN, S16_MAX);
> -				else
> -					reg_val = clamp_t(int,
> -						val * 4 + val2 * 4 / MICRO,
> -						S16_MIN, S16_MAX);
> -
> -				return regmap_write(st->regmap16,
> -					AD4695_REG_OFFSET_IN(chan->scan_index),
> -					reg_val);
> -			default:
> -				return -EINVAL;
> -			}
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (val < 0 || val2 < 0)
> +				reg_val = 0;
> +			else if (val > 1)
> +				reg_val = U16_MAX;
> +			else
> +				reg_val = (val * (1 << 16) +
> +					   mul_u64_u32_div(val2, 1 << 16,
> +							   MICRO)) / 2;
> +
> +			return regmap_write(st->regmap16,
> +					    AD4695_REG_GAIN_IN(chan->scan_index),
> +					    reg_val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (val2 >= 0 && val > S16_MAX / 4)
> +				reg_val = S16_MAX;
> +			else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
> +				reg_val = S16_MIN;
> +			else if (val2 < 0)
> +				reg_val = clamp_t(int,
> +						  -(val * 4 + -val2 * 4 / MICRO),
> +						  S16_MIN, S16_MAX);
> +			else if (val < 0)
> +				reg_val = clamp_t(int,
> +						  val * 4 - val2 * 4 / MICRO,
> +						  S16_MIN, S16_MAX);
> +			else
> +				reg_val = clamp_t(int,
> +						  val * 4 + val2 * 4 / MICRO,
> +						  S16_MIN, S16_MAX);
> +
> +			return regmap_write(st->regmap16,
> +					    AD4695_REG_OFFSET_IN(chan->scan_index),
> +					    reg_val);
>  		default:
>  			return -EINVAL;
>  		}
> +	default:
> +		return -EINVAL;
>  	}
> -	unreachable();
> +}
> +
> +static int ad4695_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	ret = __ad4695_write_raw(indio_dev, chan, val, val2, mask);
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
>  }
>  
>  static int ad4695_read_avail(struct iio_dev *indio_dev,
> @@ -954,26 +977,29 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
>  				     unsigned int *readval)
>  {
>  	struct ad4695_state *st = iio_priv(indio_dev);
> -
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		if (readval) {
> -			if (regmap_check_range_table(st->regmap, reg,
> -						     &ad4695_regmap_rd_table))
> -				return regmap_read(st->regmap, reg, readval);
> -			if (regmap_check_range_table(st->regmap16, reg,
> -						     &ad4695_regmap16_rd_table))
> -				return regmap_read(st->regmap16, reg, readval);
> -		} else {
> -			if (regmap_check_range_table(st->regmap, reg,
> -						     &ad4695_regmap_wr_table))
> -				return regmap_write(st->regmap, reg, writeval);
> -			if (regmap_check_range_table(st->regmap16, reg,
> -						     &ad4695_regmap16_wr_table))
> -				return regmap_write(st->regmap16, reg, writeval);
> -		}
> +	int ret = -EINVAL;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (readval) {
> +		if (regmap_check_range_table(st->regmap, reg,
> +					     &ad4695_regmap_rd_table))
> +			ret = regmap_read(st->regmap, reg, readval);
> +		if (regmap_check_range_table(st->regmap16, reg,
> +					     &ad4695_regmap16_rd_table))
> +			ret = regmap_read(st->regmap16, reg, readval);
> +	} else {
> +		if (regmap_check_range_table(st->regmap, reg,
> +					     &ad4695_regmap_wr_table))
> +			ret = regmap_write(st->regmap, reg, writeval);
> +		if (regmap_check_range_table(st->regmap16, reg,
> +					     &ad4695_regmap16_wr_table))
> +			ret = regmap_write(st->regmap16, reg, writeval);
>  	}
> +	iio_device_release_direct(indio_dev);
>  
> -	return -EINVAL;
> +	return ret;
>  }
>  
>  static const struct iio_info ad4695_info = {


