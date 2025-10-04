Return-Path: <linux-iio+bounces-24725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D3BB8F5F
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED6F3BDB81
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763632264CE;
	Sat,  4 Oct 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE9zWMpz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5471DA23
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759591978; cv=none; b=slRFGxYNTivjZSEPGUv5OO+G91Elmde6OCFcU/einRuFZkRzgKw3K8+0xo58JwHzqokVrjledjNjGlIB4+BmNaNaMvr+hVbD4K5wWx3702NZd/OijqL09r4V7mcLUDyNbjv2YIr61WD43Tqv1VvgNlOSvqI5DwCZs27Odv/i4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759591978; c=relaxed/simple;
	bh=tYoS9neZO/B8VmKlSJlRgKjvubBg2eRCbd+gxKDfYLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fk3o0MxWtgwt166INZQ2dUIthA2Je4t9RjOOzUq9s9QktbiqXnUZUExgUrPCGaWZMf+I+nfa+efvgI2bz9Y3dlBFX3uOc4J8a6hZgy6AMl8wIy3ASubAEgH1TZI1V++PyVyXwkFEfiGPNeF6DTVnOgIeL6x7tn8PgKyGoE9HQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE9zWMpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56537C4CEF1;
	Sat,  4 Oct 2025 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759591977;
	bh=tYoS9neZO/B8VmKlSJlRgKjvubBg2eRCbd+gxKDfYLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LE9zWMpzfrx6sQ8u4pR2a2Nr1jJV+y6t7iO+4a55TGY7l8DDK8YrvYZxj5wiXP5Bj
	 pimv2gwJIyc2F5JSMKRTajEzObJskVkWRLcQJY8YapNKQepBtyqKuh6dUnLD6qsYc7
	 LMyFsyTgIkNMhG88u4+OL+Zr0EtXjbIAOqNpl4bI5ol+se1ckPHH14UXqtUTHruGQJ
	 wkxFeDR1tKYTldGv4VstWJqoJ7gytazaYVDtYt0g+w3oUWg/W5V5ZxSt2QwDLecUu6
	 s4sizC951uaylYK7iDsfArc9xZc2YktbsBn4biMrsaU8Xm2YXZy8msvWw+g6CCUT4m
	 rIe6bAWZLI4Bw==
Date: Sat, 4 Oct 2025 16:32:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v3 7/9] iio: pressure: bmp280: implement
 sampling_frequency for BMx280
Message-ID: <20251004163252.5ec4e594@jic23-huawei>
In-Reply-To: <20250928172637.37138-9-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
	<20250928172637.37138-9-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 19:26:35 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> As was already commented in bm280.h:468, sampling_frequency can be
> emulated on BMx280 devices indirectly via t_standby configuration.
> Actually implement it to enable this useful feature.  This allows to
> switch between MODE_FORCED and MODE_NORMAL operation and use the same
> sysfs read implementations for both modes.  As MODE_FORCED is a driver
> feature, the corresponding entry in the ODR table has to be added
> after the actual register settings.  The resulting register setting is
> either masked by the driver or clamped to a permissible value on
> device, so does not disturb the device operation.  MODE_FORCE is
> triggered by setting a sampling frequency of 0Hz, following the
> precedent of stm32_timer_trigger.
> 
> The bmp[235]_conv() functions check if the sensor already operates in
> NORMAL_MODE and skip waiting for measurement completion to save the
> overhead of the superfluous mode seting.
> 
> The actual sampling frequency depends on the oversampling_ratio
> settings. In order to keep the constant ODR tables, the available
> sampling frequency values are fixed and have been calculated for
> oversampling_ratio=1 on all available channels assuming maximum
> measurement duration per the data sheet truncated to three significant
> digits; corresponding to the minimum achievable sampling frequency for
> the highest measurement speed configuration.
> 
> The ODR tables for the BM[35]80 devices have been extended to allow
> for MODE_FORCED operation also and the handling of the table values in
> chip_config is adapted accordingly.
> 
> Report of the actual sampling frequency via sysfs is possible, but not
> yet implemented.  In preparation for that implementation the
> calculation of measurement time has previously been factored out from
> bmp280_conv into bmp280_calc_meas_time_us.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> 
A few unrelated changes have slipped in here that should be broken out
so that this patch is clearly doing just one thing rather than several.

> ---
> 
> BME280 redefines the last two ODR register settings vs. BMP280, which
> are therefore out of order w.r.t. the other values.
> 
> Calculated ODR values:
> |--------+---------+---------|
> |   t_sb | min ODR | min ODR |
> |   [ms] |  BMP280 |  BME280 |
> |--------+---------+---------|
> |      0 | 155.642 | 107.527 |
> |    0.5 | 144.404 | 102.041 |
> |   62.5 |  14.509 |  13.928 |
> |  125.0 |   7.609 |   7.446 |
> |  250.0 |   3.900 |   3.857 |
> |  500.0 |   1.975 |   1.963 |
> | 1000.0 |   0.994 |   0.991 |
> | 2000.0 |   0.498 |     --- |
> | 4000.0 |   0.250 |     --- |
> |   10.0 |     --- |  51.813 |
> |   20.0 |     --- |  34.130 |
> |--------+---------+---------|
> 
> Proper consideration of the OSR when setting sampling_frequency could
> be introduced in a later patch after discussion of how to handle the
> combinatorial explosion of the table size or alternatively a
> complicated on-the-fly computation that also depends on the device
> type.  Note in particular that there are combinations of OSR and ODR
> settings for the BMP580 at least that are illegal and hence replaced
> by the device with a default setting, something this driver also
> currently does not check for or handle.
I'm a little confused. Is calculating this on demand what the next patch
is doing?

> 
> This driver currently also lacks the the *_available attributes and
> all associated implementation for all supported devices.  This should
> be introduced in conjunction with the previously mentioned patch, so
> that the available settings for the current configuration can be
> obtained from user space.
> ---
>  drivers/iio/pressure/bmp280-core.c | 297 ++++++++++++++++++++---------
>  drivers/iio/pressure/bmp280.h      |  22 ++-
>  2 files changed, 228 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index e72cfd4c10b9..9ade6d9e047b 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c

> @@ -816,7 +869,7 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
>  	return -EINVAL;
>  }
>  
> -static int bmp280_write_sampling_frequency(struct bmp280_data *data,
> +static int bmp280_write_sampling_freq(struct bmp280_data *data,
>  					   int val, int val2)
>  {
>  	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
> @@ -893,7 +946,7 @@ static int bmp280_write_raw_impl(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return bmp280_write_sampling_frequency(data, val, val2);
> +		return bmp280_write_sampling_freq(data, val, val2);

Rename is fine, but not in a patch doing anything more substantial.

>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		return bmp280_write_iir_filter_coeffs(data, val);
>  	default:
> @@ -971,6 +1024,34 @@ static const unsigned long bme280_avail_scan_masks[] = {
>  	0
>  };

> @@ -1098,24 +1185,28 @@ static int bmp280_conv(struct bmp280_data *data)
>  
>  static int bmp280_chip_config(struct bmp280_data *data)
>  {
> -	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> -		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
> -	u8 filter = FIELD_PREP(BMP280_FILTER_MASK, data->iir_filter_coeff;
> +	u8 osr_temp  = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1);
> +	u8 osr_press = FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
> +	u8 filter    = FIELD_PREP(BMP280_FILTER_MASK, data->iir_filter_coeff);
> +	u8 tstby     = FIELD_PREP(BMP280_TSTBY_MASK, (data->sampling_freq ?: 1) - 1);
> +	u8 mode      = FIELD_PREP(BMP280_MODE_MASK, data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP);
>  	int ret;
>  
>  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>  				BMP280_OSRS_TEMP_MASK |
>  				BMP280_OSRS_PRESS_MASK |
>  				BMP280_MODE_MASK,
> -				osrs | BMP280_MODE_SLEEP);
> +				osr_temp | osr_press | mode);
> +	if (ret)
> +		return ret;
>  	if (ret) {

Some rebase issue?  Can't get here for obvious reasons! :)

>  		dev_err(data->dev, "failed to write ctrl_meas register\n");
>  		return ret;
>  	}

> @@ -1675,24 +1774,26 @@ static int bmp380_read_calib(struct bmp280_data *data)
>  }
>  
>  static const int bmp380_odr_table[][2] = {
> -	[BMP380_ODR_200HZ]	= {200, 0},
> -	[BMP380_ODR_100HZ]	= {100, 0},
> -	[BMP380_ODR_50HZ]	= {50, 0},
> -	[BMP380_ODR_25HZ]	= {25, 0},
> -	[BMP380_ODR_12_5HZ]	= {12, 500000},
> -	[BMP380_ODR_6_25HZ]	= {6, 250000},
> -	[BMP380_ODR_3_125HZ]	= {3, 125000},
> -	[BMP380_ODR_1_5625HZ]	= {1, 562500},
> -	[BMP380_ODR_0_78HZ]	= {0, 781250},
> -	[BMP380_ODR_0_39HZ]	= {0, 390625},
> -	[BMP380_ODR_0_2HZ]	= {0, 195313},
> -	[BMP380_ODR_0_1HZ]	= {0, 97656},
> -	[BMP380_ODR_0_05HZ]	= {0, 48828},
> -	[BMP380_ODR_0_02HZ]	= {0, 24414},
> -	[BMP380_ODR_0_01HZ]	= {0, 12207},
> -	[BMP380_ODR_0_006HZ]	= {0, 6104},
> -	[BMP380_ODR_0_003HZ]	= {0, 3052},
> -	[BMP380_ODR_0_0015HZ]	= {0, 1526},
> +	/* BMP380_ODR_FORCED is a driver feature, not a register setting */
> +	[BMP380_ODR_FORCED]	= {   0,      0 },

Similar to below. The reformat is unrelated cause of noise in this patch
(but nice to have in a precursor!)

> +	[BMP380_ODR_200HZ]	= { 200,      0 },
> +	[BMP380_ODR_100HZ]	= { 100,      0 },
> +	[BMP380_ODR_50HZ]	= {  50,      0 },
> +	[BMP380_ODR_25HZ]	= {  25,      0 },
> +	[BMP380_ODR_12_5HZ]	= {  12, 500000 },
> +	[BMP380_ODR_6_25HZ]	= {   6, 250000 },
> +	[BMP380_ODR_3_125HZ]	= {   3, 125000 },
> +	[BMP380_ODR_1_5625HZ]	= {   1, 562500 },
> +	[BMP380_ODR_0_78HZ]	= {   0, 781250 },
> +	[BMP380_ODR_0_39HZ]	= {   0, 390625 },
> +	[BMP380_ODR_0_2HZ]	= {   0, 195313 },
> +	[BMP380_ODR_0_1HZ]	= {   0,  97656 },
> +	[BMP380_ODR_0_05HZ]	= {   0,  48828 },
> +	[BMP380_ODR_0_02HZ]	= {   0,  24414 },
> +	[BMP380_ODR_0_01HZ]	= {   0,  12207 },
> +	[BMP380_ODR_0_006HZ]	= {   0,   6104 },
> +	[BMP380_ODR_0_003HZ]	= {   0,   3052 },
> +	[BMP380_ODR_0_0015HZ]	= {   0,   1526 },
>  };

> @@ -2061,7 +2169,7 @@ static int bmp580_soft_reset(struct bmp280_data *data)
>  	fsleep(2000);
>  
>  	/* Dummy read of chip_id */
> -	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
> +	ret = regmap_read(data->regmap, BMP580_REG_ID, &reg);

Unrelated change.

>  	if (ret) {
>  		dev_err(data->dev, "failed to reestablish comms after reset\n");
>  		return ret;
> @@ -2205,38 +2313,40 @@ static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
>  }
>  
>  static const int bmp580_odr_table[][2] = {
> -	[BMP580_ODR_240HZ] =	{240, 0},

whilst I do prefer your new formatting. That's mostly an unrelated change
that should be in a different patch.  This one should just
introduce the new entrees.

> -	[BMP580_ODR_218HZ] =	{218, 0},
> -	[BMP580_ODR_199HZ] =	{199, 0},
> -	[BMP580_ODR_179HZ] =	{179, 0},
> -	[BMP580_ODR_160HZ] =	{160, 0},
> -	[BMP580_ODR_149HZ] =	{149, 0},
> -	[BMP580_ODR_140HZ] =	{140, 0},
> -	[BMP580_ODR_129HZ] =	{129, 0},
> -	[BMP580_ODR_120HZ] =	{120, 0},
> -	[BMP580_ODR_110HZ] =	{110, 0},
> -	[BMP580_ODR_100HZ] =	{100, 0},
> -	[BMP580_ODR_89HZ] =	{89, 0},
> -	[BMP580_ODR_80HZ] =	{80, 0},
> -	[BMP580_ODR_70HZ] =	{70, 0},
> -	[BMP580_ODR_60HZ] =	{60, 0},
> -	[BMP580_ODR_50HZ] =	{50, 0},
> -	[BMP580_ODR_45HZ] =	{45, 0},
> -	[BMP580_ODR_40HZ] =	{40, 0},
> -	[BMP580_ODR_35HZ] =	{35, 0},
> -	[BMP580_ODR_30HZ] =	{30, 0},
> -	[BMP580_ODR_25HZ] =	{25, 0},
> -	[BMP580_ODR_20HZ] =	{20, 0},
> -	[BMP580_ODR_15HZ] =	{15, 0},
> -	[BMP580_ODR_10HZ] =	{10, 0},
> -	[BMP580_ODR_5HZ] =	{5, 0},
> -	[BMP580_ODR_4HZ] =	{4, 0},
> -	[BMP580_ODR_3HZ] =	{3, 0},
> -	[BMP580_ODR_2HZ] =	{2, 0},
> -	[BMP580_ODR_1HZ] =	{1, 0},
> -	[BMP580_ODR_0_5HZ] =	{0, 500000},
> -	[BMP580_ODR_0_25HZ] =	{0, 250000},
> -	[BMP580_ODR_0_125HZ] =	{0, 125000},
> +	/* BMP580_ODR_FORCED is a driver feature, not a register setting */
> +	[BMP580_ODR_FORCED] =	{   0,      0 },
> +	[BMP580_ODR_240HZ] =	{ 240,	    0 },
> +	[BMP580_ODR_218HZ] =	{ 218,	    0 },
> +	[BMP580_ODR_199HZ] =	{ 199,	    0 },
> +	[BMP580_ODR_179HZ] =	{ 179,	    0 },
> +	[BMP580_ODR_160HZ] =	{ 160,	    0 },
> +	[BMP580_ODR_149HZ] =	{ 149,	    0 },
> +	[BMP580_ODR_140HZ] =	{ 140,	    0 },
> +	[BMP580_ODR_129HZ] =	{ 129,	    0 },
> +	[BMP580_ODR_120HZ] =	{ 120,	    0 },
> +	[BMP580_ODR_110HZ] =	{ 110,	    0 },
> +	[BMP580_ODR_100HZ] =	{ 100,	    0 },
> +	[BMP580_ODR_89HZ] =	{  89,	    0 },
> +	[BMP580_ODR_80HZ] =	{  80,	    0 },
> +	[BMP580_ODR_70HZ] =	{  70,	    0 },
> +	[BMP580_ODR_60HZ] =	{  60,	    0 },
> +	[BMP580_ODR_50HZ] =	{  50,	    0 },
> +	[BMP580_ODR_45HZ] =	{  45,	    0 },
> +	[BMP580_ODR_40HZ] =	{  40,	    0 },
> +	[BMP580_ODR_35HZ] =	{  35,	    0 },
> +	[BMP580_ODR_30HZ] =	{  30,	    0 },
> +	[BMP580_ODR_25HZ] =	{  25,	    0 },
> +	[BMP580_ODR_20HZ] =	{  20,	    0 },
> +	[BMP580_ODR_15HZ] =	{  15,	    0 },
> +	[BMP580_ODR_10HZ] =	{  10,	    0 },
> +	[BMP580_ODR_5HZ] =	{   5,	    0 },
> +	[BMP580_ODR_4HZ] =	{   4,	    0 },
> +	[BMP580_ODR_3HZ] =	{   3,	    0 },
> +	[BMP580_ODR_2HZ] =	{   2,	    0 },
> +	[BMP580_ODR_1HZ] =	{   1,	    0 },
> +	[BMP580_ODR_0_5HZ] =	{   0, 500000 },
> +	[BMP580_ODR_0_25HZ] =	{   0, 250000 },
> +	[BMP580_ODR_0_125HZ] =	{   0, 125000 },
>  };
>  

> @@ -2707,7 +2821,7 @@ static const int bmp580_temp_coeffs[] = { 125, 13 };
>  static const int bmp580_press_coeffs[] = { 1, 64000};
>  
>  const struct bmp280_chip_info bmp580_chip_info = {
> -	.id_reg = BMP580_REG_CHIP_ID,
> +	.id_reg = BMP580_REG_ID,

As below. Unrelated change. Separate patch with clear reasoning for why.

>  	.chip_id = bmp580_chip_ids,
>  	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
>  	.regmap_config = &bmp580_regmap_config,
> @@ -3367,10 +3481,13 @@ static int bmp280_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -
> -	data->chip_info->set_mode(data, BMP280_SLEEP);
> +	int ret;
>  
>  	fsleep(data->start_up_time_us);

Add a comment on why we need a sleep before setting the mode.
It's unusual to need resume to sleep before doing anything at all.


> +	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP);
> +	if (ret)
> +		return ret;
> +
>  	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  }
>  
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index df90ed720bc6..8e05cdf869e7 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -13,7 +13,7 @@
>  #define BMP580_REG_OSR_CONFIG		0x36
>  #define BMP580_REG_IF_CONFIG		0x13
>  #define BMP580_REG_REV_ID		0x02
> -#define BMP580_REG_CHIP_ID		0x01
> +#define BMP580_REG_ID			0x01

That looks like an unrelated change.

