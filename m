Return-Path: <linux-iio+bounces-24724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2DBB8F56
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E91F3C0C37
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA4272E6D;
	Sat,  4 Oct 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/pGnUdi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4882192B7D
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759591325; cv=none; b=u3bco6HeMlQ1QoG3hDYiswxCiywLmq/nWjCrNrmgBBbW/8VhowRoR8rFEh1ArHiIBoF9nNC3gIQ2++B/pcRPPyE85SY5nNC9Rbor6iuaEnaaWwxLIydGHPla4qjBwHG17Nq6t+/CpPg6APNyGbHUrtz12hpJvcsfDuOExcMxs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759591325; c=relaxed/simple;
	bh=raDeFcXjndVfq4rlV50Vx3ULZb+7W3p0CoHmCvZZTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXk/cCgpgSIsZ8MQzlqmWr4TY+bWINJBGVlzOqXw9YjGNlXJ0UgdE8Tej4j32rwz44izLUV193biYUrTim4FBj62jfHWIpf6Nceyaf/7Oiw4MMcgHen9Vsa48zZa3lDC9aoirVwP68LM5+DreNIMbmASoa2oxTczdCGLNUM0OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/pGnUdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0910DC4CEF1;
	Sat,  4 Oct 2025 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759591325;
	bh=raDeFcXjndVfq4rlV50Vx3ULZb+7W3p0CoHmCvZZTYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f/pGnUdiCSjpKerQ+dTpLtLT29TZgC/vcXuhPZmH5vSqfVBajoMjjKDPLD6yh9Uca
	 nXi83YNEXJ2ICRoxmJlD3gJDr+YLy/h8M8x9pkfpsFwIV6oJECr4ILKJdaYWrrS3cB
	 GUXhkLnC1fwEIPDYOG3cuwRc9l35ynevVbMavSFDoGN9/Druh04x8bhk7nDffpe6XU
	 9mjMmQDvZvSsHsCl3XTbUp+9v7TQiE4EPyCJqEb0evlkavIwicGYv6qSwe5UxnjHu/
	 axP9/+G0NpBslZxo8M4evulKRs3mdnTMMCuSWUy/e9ZzljvOKSl4sugoTkbpi9i/3K
	 MMVnUP3yURU5w==
Date: Sat, 4 Oct 2025 16:21:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v3 6/9] iio: pressure: bmp280: enable filter
 settings for BMx280
Message-ID: <20251004162158.087e2c81@jic23-huawei>
In-Reply-To: <20250928172637.37138-8-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
	<20250928172637.37138-8-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 19:26:34 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Follow the existing implementation for the BMx380 and BMx580 devices
> even though it doesn't conform to the API: The BMx280 devices were
> using a hardcoded value of 4, corresponding to the lowest corner
> frequency.  Enable filter_low_pass_3db_frequency settings to control
> the filter settings of the device.  The actual 3dB corner freqquency
> has an inverse relation to the value, which represents approximately
> the tau of the filter (for which the iio framework does not seem to
> have a suitable parameter). 
> 
> Remove a superfluous offset of -1 from
> the internal handling of the available values and use the table
> entries directly.  Keep the default value at the previous hardcoded
> value to ensure identical device behaviour after module load.
> 
> A change of the implementation to actually follow the API (breaking
> existing userspace) requires further discussion and more extensive
> changes elsewhere in the code and are left for later.

I'm not keen to introduce additional cases of the non compliant ABI
even if it is just more parts in the same driver.

So patch looks fine in so far as what it does, but that issue is a blocker.

J
> 
> ---
> 
> Filter coefficient settings in hardware: off, 2, 4, 8, 16, mapped to
> register values 0, 1, 2, 3, 4 (that's i and 2**i below), per the
> datasheet, the actual filter is:
> 
>   y(t) = ( (y(t-1) << i) - y(t-1) + x(t) ) >> i
>        = 2**-i * x(t) (2**i-1)*2**-i * y(t-1) )
> 
> That's the simplest filter that can be implemented in hardware,
> really; the canonical recursive single-pole LP with no gain has two
> coefficients, which should be 1-d and d (d because it's the sample
> decay).
> 
>    2**-i + (2**i-1)*2**-i = 2**-1 * ( 1 + 2**i - 1 ) = 1
> 
> so check that.  The time constant (rise time to 63%) is then
> 
>   tau = -1/ln(d)
> 
> Oddly enough the data sheet gives time to >75%, but that is just a
> scaling factor of ln(0.25) on the tau.  The nomalized corner frequency then is:
> 
>   fc/fs = -ln(d)/(2pi)
> 
> So lets check that:
> 
> |---+------+--------+--------+--------+--------+-----------+----------|
> | i | 2**i |    1-d |      d |    tau |  t>75% | datasheet |    fc/fs |
> |---+------+--------+--------+--------+--------+-----------+----------|
> | 0 |    1 |      1 |      0 |    --- |    --- |         1 |        1 |
> | 1 |    2 |    0.5 |    0.5 |  1.443 |  2.000 |         2 | 0.110318 |
> | 2 |    4 |   0.25 |   0.75 |  3.476 |  4.819 |         5 | 0.045786 |
> | 3 |    8 |  0.125 |  0.875 |  7.489 | 10.382 |        11 | 0.021252 |
> | 4 |   16 | 0.0625 | 0.9375 | 15.495 | 21.481 |        22 | 0.010272 |
> |---+------+--------+--------+--------+--------+-----------+----------|
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> ---
>  drivers/iio/pressure/bmp280-core.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 4f5c4bd89067..e72cfd4c10b9 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -159,6 +159,7 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 'u',
> @@ -174,6 +175,7 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 's',
> @@ -193,6 +195,7 @@ static const struct iio_chan_spec bme280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 'u',
> @@ -208,6 +211,7 @@ static const struct iio_chan_spec bme280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 's',
> @@ -223,6 +227,7 @@ static const struct iio_chan_spec bme280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 2,
>  		.scan_type = {
>  			.sign = 'u',
> @@ -714,7 +719,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  		if (!data->chip_info->iir_filter_coeffs_avail)
>  			return -EINVAL;
>  
> -		*val = (1 << data->iir_filter_coeff) - 1;
> +		*val = data->chip_info->iir_filter_coeffs_avail[data->iir_filter_coeff];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -844,7 +849,7 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
>  	int i;
>  
>  	for (i = 0; i < n; i++) {
> -		if (avail[i] - 1  == val) {
> +		if (avail[i] == val) {
>  			prev = data->iir_filter_coeff;
>  			data->iir_filter_coeff = i;
>  
> @@ -1095,6 +1100,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  {
>  	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
>  		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
> +	u8 filter = FIELD_PREP(BMP280_FILTER_MASK, data->iir_filter_coeff;
>  	int ret;
>  
>  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> @@ -1109,7 +1115,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  
>  	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
>  				 BMP280_FILTER_MASK,
> -				 BMP280_FILTER_4X);
> +				 filter);
>  	if (ret) {
>  		dev_err(data->dev, "failed to write config register\n");
>  		return ret;
> @@ -1174,6 +1180,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
>  static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
>  static const int bmp280_temp_coeffs[] = { 10, 1 };
>  static const int bmp280_press_coeffs[] = { 1, 256000 };
> +static const int bmp280_iir_filter_coeffs_avail[] = { 0, 2, 4, 8, 16 };
>  
>  const struct bmp280_chip_info bmp280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -1203,6 +1210,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
>  	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>  	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
>  
> +	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
> +	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
> +	.iir_filter_coeff_default = 2,
> +
>  	.temp_coeffs = bmp280_temp_coeffs,
>  	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
>  	.press_coeffs = bmp280_press_coeffs,
> @@ -1385,6 +1396,10 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>  	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
>  
> +	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
> +	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
> +	.iir_filter_coeff_default = 2,
> +
>  	.temp_coeffs = bmp280_temp_coeffs,
>  	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
>  	.press_coeffs = bmp280_press_coeffs,
> @@ -1982,7 +1997,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
>  }
>  
>  static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
> -static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
> +static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
>  static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
>  static const int bmp380_temp_coeffs[] = { 10, 1 };
>  static const int bmp380_press_coeffs[] = { 1, 100000 };


