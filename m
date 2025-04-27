Return-Path: <linux-iio+bounces-18727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DCA9E300
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 14:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344C25A207D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C24A18;
	Sun, 27 Apr 2025 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY7EOGwS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FC3FFD;
	Sun, 27 Apr 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745757438; cv=none; b=j1Op5+P9al8WYlTNqEqq9rJRm2yppEG22Wx8ypm72pRr3hYPmwYHtBEH2z/F+lCdbnJO3RnDv+NMFVjQ7Ju6Pr40YxOAKQNhPhNMnr/T7Fg8s6xvRq+9/1qbdSeW09UN1t5aqEtMT93/8IrTNkIcE2uCw3ibJEKqiOSWBvRSkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745757438; c=relaxed/simple;
	bh=X7R8lbJF1XAvncUzxivgId0lkpF91/ukRf8b/i72oHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMWt420MP/UMnfuV8Bk8GpkeXYPclpe/yu0gk6R8/wreFwrseK8EhWijoJ2DmhJGCxaQgO66SklfEqI31uV92lUAtHbvVkvYjwv4ZiQAli1mhMQMcmWJ1yvjzn9qTcOX1MyrniYSWsFFg+G0qO3pcjq3dB3uYTM9qMOWourBZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY7EOGwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB847C4CEE3;
	Sun, 27 Apr 2025 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745757437;
	bh=X7R8lbJF1XAvncUzxivgId0lkpF91/ukRf8b/i72oHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SY7EOGwSjTHinF+/rtifUl1xTx18HLXYgTS9EixOpD8yiu2cXxip+dmEnLjggyQv6
	 fr13umwRQcNwoVUbXSN05tRaUVACYz1dulYK8j/JbmdQHkMaEhpp2z0tykPRQPZgNP
	 7A1oTv9pZzSLuGNYb6p9FuXY+3M6mv4AMuCpj+D61MuOQfusbIi0rN4mFINUxAsuu6
	 WGXcQJPKw/A9e3Pw/t//DEwXJgQiSq+SFCAcry+t2Yap0a3T/DK0PdmVPkTyie9b44
	 eP2EQ1ZQsUGGmyJzZxQaONLekS95f1XFy8Lp6kiSXVuBa04a4Pts1sRi4VW5Cq630y
	 4yFeBjkNBwjew==
Date: Sun, 27 Apr 2025 13:37:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 05/11] iio: accel: adxl345: add freefall feature
Message-ID: <20250427133710.48693777@jic23-huawei>
In-Reply-To: <20250421220641.105567-6-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:35 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the freefall detection of the sensor together with a threshold and
> time parameter. A freefall event is detected if the measuring signal
> falls below the threshold.
> 
> Introduce a freefall threshold stored in regmap cache, and a freefall
> time, having the scaled time value stored as a member variable in the
> state instance.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
I tweaked as follows to make change in patch 9 simpler.

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8fcb8ade049b..1f4fc512e05f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -123,13 +123,15 @@ enum adxl345_chans {
        chan_x, chan_y, chan_z,
 };
 
-/* free fall */
-static const struct iio_event_spec adxl345_freefall_event_spec = {
-       .type = IIO_EV_TYPE_MAG,
-       .dir = IIO_EV_DIR_FALLING,
-       .mask_separate = BIT(IIO_EV_INFO_ENABLE),
-       .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+static const struct iio_event_spec adxl345_all_event_spec[] = {
+       /* free fall */
+       {
+               .type = IIO_EV_TYPE_MAG,
+               .dir = IIO_EV_DIR_FALLING,
+               .mask_separate = BIT(IIO_EV_INFO_ENABLE),
+               .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
                BIT(IIO_EV_INFO_PERIOD),
+       },
 };
 
 static const struct iio_chan_spec adxl345_channels[] = {
@@ -141,8 +143,8 @@ static const struct iio_chan_spec adxl345_channels[] = {
                .modified = 1,
                .channel2 = IIO_MOD_X_AND_Y_AND_Z,
                .scan_index = -1, /* Fake channel */
-               .event_spec = &adxl345_freefall_event_spec,
-               .num_event_specs = 1,
+               .event_spec = adxl345_all_event_spec,
+               .num_event_specs = ARRAY_SIZE(adxl345_all_event_spec),
        },
 };

> ---
>  drivers/iio/accel/adxl345_core.c | 134 +++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index c464c87033fb..f42c861100cd 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -75,6 +75,7 @@ struct adxl345_state {
>  	u32 tap_duration_us;
>  	u32 tap_latent_us;
>  	u32 tap_window_us;
> +	u32 ff_time_ms;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -122,10 +123,27 @@ enum adxl345_chans {
>  	chan_x, chan_y, chan_z,
>  };
>  
> +/* free fall */
> +static const struct iio_event_spec adxl345_freefall_event_spec = {
> +	.type = IIO_EV_TYPE_MAG,
> +	.dir = IIO_EV_DIR_FALLING,
> +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +		BIT(IIO_EV_INFO_PERIOD),
> +};
> +
>  static const struct iio_chan_spec adxl345_channels[] = {
>  	ADXL345_CHANNEL(0, chan_x, X),
>  	ADXL345_CHANNEL(1, chan_y, Y),
>  	ADXL345_CHANNEL(2, chan_z, Z),
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
> +		.scan_index = -1, /* Fake channel */
> +		.event_spec = &adxl345_freefall_event_spec,
> +		.num_event_specs = 1,
> +	},
>  };
>  
>  static const unsigned long adxl345_scan_masks[] = {
> @@ -383,6 +401,63 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
>  	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
>  }
>  
> +/* freefall */
> +
> +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*en = FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> +{
> +	unsigned int regval, ff_threshold;
> +	bool en;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_threshold);
> +	if (ret)
> +		return ret;
> +
> +	en = cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> +
> +	regval = en ? ADXL345_INT_FREE_FALL : 0x00;
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> +				  ADXL345_INT_FREE_FALL, regval);
> +}
> +
> +static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
> +			       u32 val_fract_us)
> +{
> +	unsigned int regval;
> +	int val_ms;
> +
> +	/*
> +	 * max value is 255 * 5000 us = 1.275000 seconds
> +	 *
> +	 * Note: the scaling is similar to the scaling in the ADXL380
> +	 */
> +	if (1000000 * val_int + val_fract_us > 1275000)
> +		return -EINVAL;
> +
> +	val_ms = val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
> +	st->ff_time_ms = val_ms;
> +
> +	regval = DIV_ROUND_CLOSEST(val_ms, 5);
> +
> +	/* Values between 100ms and 350ms (0x14 to 0x46) are recommended. */
> +	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
> +}
> +
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -495,6 +570,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_MAG:
> +		ret = adxl345_is_ff_en(st, &int_en);
> +		if (ret)
> +			return ret;
> +		return int_en;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -518,6 +598,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_MAG:
> +		return adxl345_set_ff_en(st, state);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -532,6 +614,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
>  	unsigned int tap_threshold;
> +	unsigned int ff_threshold;
>  	int ret;
>  
>  	switch (type) {
> @@ -565,6 +648,22 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_MAG:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF,
> +					  &ff_threshold);
> +			if (ret)
> +				return ret;
> +			*val = ff_threshold;
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_PERIOD:
> +			*val = st->ff_time_ms;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -612,6 +711,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  		break;
> +	case IIO_EV_TYPE_MAG:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
> +			if (ret)
> +				return ret;
> +			break;
> +		case IIO_EV_INFO_PERIOD:
> +			ret = adxl345_set_ff_time(st, val, val2);
> +			if (ret)
> +				return ret;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -865,6 +980,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							IIO_MOD_X_AND_Y_AND_Z,
> +							IIO_EV_TYPE_MAG,
> +							IIO_EV_DIR_FALLING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
>  		samples = adxl345_get_samples(st);
>  		if (samples < 0)
> @@ -973,6 +1099,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
>  	unsigned int tap_threshold;
> +	unsigned int ff_threshold;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -992,6 +1119,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
>  	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
>  
> +	ff_threshold = 8;			/*    8 [0x08]            */
> +	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1068,6 +1198,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		if (ret)
>  			return ret;
>  
> +		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, ff_threshold);
> +		if (ret)
> +			return ret;
> +
>  		/* FIFO_STREAM mode is going to be activated later */
>  		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
>  		if (ret)


