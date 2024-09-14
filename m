Return-Path: <linux-iio+bounces-9550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2972979119
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6253F2827BA
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723AE1CF7C9;
	Sat, 14 Sep 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv4cOXwV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5C1CEEAB;
	Sat, 14 Sep 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321449; cv=none; b=RBV+esdHdLt9LTue2kPy2LKrQAP9PTMo2sFq9Dxwgje7dYsvCMorOj35O4KD02PYnHjpWEaKGb7HSV80rE6O5aHDVqN35eLiz/7rTcjCuMihCy8BqStJ9yg1IATRAz6uSIW7z0E5Zqwy+MWQDLkCzAmu+FKg2Zav8xqB10AR+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321449; c=relaxed/simple;
	bh=/lAtZJ5HykopUMiPN/wR8wLT7yz7+UzfH0VFgsHLvMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJgvhF0SKUAoCNOfJvUW8MKOUvs1MXk5DEdks7Ms4p1snKwJMWo3W5GOz7ucO70k/l8sA/Jc5dFu2SSdEwdLydS7Iq0ff4uQiqIUp3Z2cmZyWSLQ4sMZg/kcjwCbNROD5GBDktHYM1Gv7wNg9w7/Xr1rKhoho7XkzxctDYbUHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv4cOXwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A37EC4CEC0;
	Sat, 14 Sep 2024 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726321448;
	bh=/lAtZJ5HykopUMiPN/wR8wLT7yz7+UzfH0VFgsHLvMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sv4cOXwVAOCfixVvQqrd9WAVAKuDShiQom1Iitjs+d0BEmaaqsB0HgCp0Qa86FCL5
	 FNcu3+15gAmZOBMm5PE1nB7ZqskmVfiKSbwDyhzpgflA43aTh7oNvg8QNXT7wo/wS4
	 nOncnobEB4zLx93Prlhrjaat92R/SREb5F1GYpkuWFVyW4q/dAHSosNMS4lEGGV9kQ
	 oBNYUEe86KCAXC0+/+tfSR7whC0Qm+FxRM9fMWQ87QA0jzn4gJF2ZvtJH3T/bUhIeO
	 rHnCbbvX+t8+O/s85vgMBj/v5yC8i2GrzichCFDSoD8UWO+xFflJPoWLXEiIwTMWKi
	 oA5Q14lb5sDkQ==
Date: Sat, 14 Sep 2024 14:44:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: ltr390: Added configurable sampling
 frequency support
Message-ID: <20240914144402.16486b79@jic23-huawei>
In-Reply-To: <20240910045030.266946-2-abhashkumarjha123@gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
	<20240910045030.266946-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 10:20:26 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Provied configurable sampling frequency(Measurement rate) support.
Spell check: Provide

> Also exposed the available sampling frequency values using read_avail
> callback.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash,

A few minor comments inline and an (optional) request to cleanup
the mask definitions in the existing code.
> ---
>  drivers/iio/light/ltr390.c | 68 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 7e58b50f3..73ef4a5a0 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -39,6 +39,7 @@
>  
>  #define LTR390_PART_NUMBER_ID		0xb
>  #define LTR390_ALS_UVS_GAIN_MASK	0x07
> +#define LTR390_ALS_UVS_MEAS_RATE_MASK	0x07
These masks should be converted to GENMASK().
If you don't mind doing it a precursor patch to do so
would be nice to have.

However whether or not you cleanup existing mask definitions,
please use GENMASK() for this new one.

>  #define LTR390_ALS_UVS_INT_TIME_MASK	0x70
>  #define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
>  
> @@ -87,6 +88,18 @@ static const struct regmap_config ltr390_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> +/* Sampling frequency is in mili Hz and mili Seconds */
> +static const int ltr390_samp_freq_table[][2] = {
> +		[0] = {40000, 25},
I'm trying to slowly get IIO to standardise strongly around
		[0] = { 4000, 25 },

etc.  So space after { and before }
> +		[1] = {20000, 50},
> +		[2] = {10000, 100},
> +		[3] = {5000, 200},
> +		[4] = {2000, 500},
> +		[5] = {1000, 1000},
> +		[6] = {500, 2000},
> +		[7] = {500, 2000}

Add a trailing comma.  Sure we probably will never get any more entries
but it isn't a terminator entry so convention is put the comma anyway.

> +};
> +
>  static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
>  {
>  	struct device *dev = &data->client->dev;
> @@ -135,6 +148,18 @@ static int ltr390_counts_per_uvi(struct ltr390_data *data)
>  	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
>  }
>  
> +static int ltr390_get_samp_freq(struct ltr390_data *data)
> +{
> +	int ret, value;
> +
> +	ret = regmap_read(data->regmap, LTR390_ALS_UVS_MEAS_RATE, &value);
> +	if (ret < 0)
> +		return ret;
> +	value &= LTR390_ALS_UVS_MEAS_RATE_MASK;

FIELD_GET() preferred because then the reader doesn't have to check
if this mask includes the LSB.  It slightly helps review and compiler
will get rid of the shift by nothing anyway.

> +
> +	return ltr390_samp_freq_table[value][0];
> +}
> +
>  static int ltr390_read_raw(struct iio_dev *iio_device,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
> @@ -191,6 +216,10 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  		*val = data->int_time_us;
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = ltr390_get_samp_freq(data);
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -199,6 +228,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  /* integration time in us */
>  static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
>  static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
> +static const int ltr390_freq_map[] = { 40000, 20000, 10000, 5000, 2000, 1000, 500, 500 };
>  
>  static const struct iio_chan_spec ltr390_channels[] = {
>  	/* UV sensor */
> @@ -206,16 +236,18 @@ static const struct iio_chan_spec ltr390_channels[] = {
>  		.type = IIO_UVINDEX,
>  		.scan_index = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
Obviously a long line above, but | should generally be on that previous line.
Probably best to reformat it as
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
						     BIT(IIO_CHAN_INFO_SCALE) |
						     BIT(IIO_CHAN_INFO_SAMP_FREQ),

Note should have always had a trailing comma.  Add that whilst here.

	
>  	},
>  	/* ALS sensor */
>  	{
>  		.type = IIO_LIGHT,
>  		.scan_index = 1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
>  	},
>  };
>  
> @@ -264,6 +296,27 @@ static int ltr390_set_int_time(struct ltr390_data *data, int val)
>  	return -EINVAL;
>  }
>  
> +static int ltr390_set_samp_freq(struct ltr390_data *data, int val)
> +{
> +	int ret, idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(ltr390_samp_freq_table); idx++) {
> +		if (ltr390_samp_freq_table[idx][0] != val)
> +			continue;
> +
> +		guard(mutex)(&data->lock);
> +		ret = regmap_update_bits(data->regmap,
> +					LTR390_ALS_UVS_MEAS_RATE,
> +					LTR390_ALS_UVS_MEAS_RATE_MASK, idx);

		return regmap_update_bits()

is the same thing as what you have here.


> +		if (ret)
> +			return ret;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +



