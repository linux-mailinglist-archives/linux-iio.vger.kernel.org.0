Return-Path: <linux-iio+bounces-22519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B4B1FB9E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8879C1897589
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757426B759;
	Sun, 10 Aug 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pODyD+Uj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B041B3930
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754849626; cv=none; b=pQJ3rDAC/aN9TGdCd/BfltkJ9JmaiU2E5PWOq7eNtLJSc9NVX5QMDnXQlkSvK6QXgWqOwUrHhGzhbuqsXDSseBF5aU1mZM1WiXhv5tLy6+TLgGE53AjtQ/FOjjf27hma00kfHFuykG65CdzU+WSewyMwEmBl33in1oNGaCs2xCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754849626; c=relaxed/simple;
	bh=31ncAEqC5PIa/2qq0TNRDy0EP7yX8TsnhgkTLHC9IZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umKMma//j9vD8hcr5gdjAyK8v0MMV0ylf29O/lQv3QrWlHDeeaRXi9XohCoHft1Jl0Ztkr8Rk+HE84bx+oGONNKjLd0q+OEvBgSByWAlfOO3kub7QJp3Javp9getvDgxXpH56KTLHbuOIa7eHNYkwCMfFdKDtl0kAH8Zas7WqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pODyD+Uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD04C4CEEB;
	Sun, 10 Aug 2025 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754849625;
	bh=31ncAEqC5PIa/2qq0TNRDy0EP7yX8TsnhgkTLHC9IZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pODyD+UjcVbgMbIqdQpTfqsLKMeWXJrgpQjZBfRiIhoSJ7/4dgOEI1Wz15zIaOMV8
	 9h2wKyyBEJ8+0J8YCQHgveemSG3y17AfSVXT/G2+8wDT3IctYX+I2UFWWSLkFlSe0p
	 0HKbT3RvXciuzPdhfKjVaHAYvgvxzDc6mWOKMVqX3XCmbVBJfrUcUeGdt+Ba3oJWom
	 MYW0oWeJ0GUoYWyV28lcRK/6z4wdsG71ffuhe4pwBZJ2wfddDLghX+u4uOgftDGHxH
	 PEJVAQax2mdsPPY7Qv2oLU6blOnQqHe2n4sNahi+57J5dl6I/YHQj9xPOT9h5mTucg
	 BETU83BcbX8uw==
Date: Sun, 10 Aug 2025 19:13:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings
 for BMx280
Message-ID: <20250810191338.12b568df@jic23-huawei>
In-Reply-To: <20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Aug 2025 16:08:00 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> These devices were using a hardcoded IIR filter of length 4.  Enable
> filter_low_pass_3db_frequency settings to control the filter length
> settings of the device (as done already for the BMx380 and BMx580
> devices, even though the 3dB corner has an inverse relation to the
> filter length).  Remove an offset of 1 from the internal handling of
> the available values.

This confuses me.  Are we saying those other devices have a 3db frequency
control that is not obeying the ABI? If so that sneaked in past me but
please don't continue that (and we should fix that broken use of the ABI).

Jonathan

> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> ---
>  drivers/iio/pressure/bmp280-core.c | 36 +++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 4efdbfc3ac2c..b3dcee3fe9b3 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -185,7 +185,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 'u',
> @@ -201,7 +202,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 's',
> @@ -221,7 +223,8 @@ static const struct iio_chan_spec bme280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 'u',
> @@ -237,7 +240,8 @@ static const struct iio_chan_spec bme280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 's',
> @@ -253,7 +257,8 @@ static const struct iio_chan_spec bme280_channels[] = {
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.scan_index = 2,
>  		.scan_type = {
>  			.sign = 'u',
> @@ -856,7 +861,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  		if (!data->chip_info->iir_filter_coeffs_avail)
>  			return -EINVAL;
>  
> -		*val = (1 << data->iir_filter_coeff) - 1;
> +		*val = data->chip_info->iir_filter_coeffs_avail[data->iir_filter_coeff];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -999,7 +1004,7 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
>  	int i;
>  
>  	for (i = 0; i < n; i++) {
> -		if (avail[i] - 1  == val) {
> +		if (avail[i]  == val) {
>  			prev = data->iir_filter_coeff;
>  			data->iir_filter_coeff = i;
>  
> @@ -1281,9 +1286,9 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  	}
>  
>  	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
> -				 BMP280_FILTER_MASK |
> -				 BMP280_TSTBY_MASK,
> -				 tstby | BMP280_FILTER_4X);
> +				 BMP280_TSTBY_MASK |
> +				 BMP280_FILTER_MASK,
> +				 tstby | data->iir_filter_coeff);
>  	if (ret) {
>  		dev_err(data->dev, "failed to write config register\n");
>  		return ret;
> @@ -1348,6 +1353,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
>  static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
>  static const int bmp280_temp_coeffs[] = { 10, 1 };
>  static const int bmp280_press_coeffs[] = { 1, 256000 };
> +static const int bmp280_iir_filter_coeffs_avail[] = { 0, 2, 4, 8, 16 };
>  
>  const struct bmp280_chip_info bmp280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -1381,6 +1387,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
>  	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
>  	.sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */
>  
> +	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
> +	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
> +	.iir_filter_coeff_default = 2,
> +
>  	.temp_coeffs = bmp280_temp_coeffs,
>  	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
>  	.press_coeffs = bmp280_press_coeffs,
> @@ -1567,6 +1577,10 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
>  	.sampling_freq_default = BME280_ODR_0HZ, /* MODE_FORCED */
>  
> +	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
> +	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
> +	.iir_filter_coeff_default = 2,
> +
>  	.temp_coeffs = bmp280_temp_coeffs,
>  	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
>  	.press_coeffs = bmp280_press_coeffs,
> @@ -2155,7 +2169,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
>  }
>  
>  static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
> -static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
> +static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
>  static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
>  static const int bmp380_temp_coeffs[] = { 10, 1 };
>  static const int bmp380_press_coeffs[] = { 1, 100000 };


