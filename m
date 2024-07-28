Return-Path: <linux-iio+bounces-8001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F4293E6B0
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978D1B2166A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F87EF10;
	Sun, 28 Jul 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcexLlmO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF776F2E8;
	Sun, 28 Jul 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181592; cv=none; b=CpC8XW8vsgckVnLQJZILtOK1BlmIGL/6ZnfDBF5ETgzLZNYC9WCgFenBJaNl+gqcxbouCNyOtYCJ6lI8Bx03JWUoU1TI6++VgMi77SJqF7Akj/OYxIvTnhiO1jUAfBL8nY8rQhP7TkRVJ6JoRuZUN83EZFMsgbb2Jk4RSip/u/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181592; c=relaxed/simple;
	bh=w8CUFLcEnvdNvj4DgpNvBdCJq5FCKEwyXyCM9msZQF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5tNXHbboB4ncaX/tac1u2LyM7PGSWUPjwu1PJn6qPhKbSSYs/3NTkUFXBR3AOd9hgaaYoTvJ9YGl0yjPyehH/JFtwBYEHEyI11oje8iMVitmA13540RQrxKvgZODFTu1i2xORVVGxCzZXzYxeCUz4ae7Lt/B38vsPPEQL07htI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcexLlmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38876C4AF0B;
	Sun, 28 Jul 2024 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181591;
	bh=w8CUFLcEnvdNvj4DgpNvBdCJq5FCKEwyXyCM9msZQF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcexLlmOMKkl6guCSH2R3oMs53GXRvILoWd9+4g3wn2LIu0mOhuW3bByEaJoxD6b+
	 GrRF5HP+uEgmw3QQYdzqqlSNOa5APIa5pUgcJomZiOn4dTE6YtzwDR8B00wqUFgGrx
	 LUlangzY7odG85zlUp+7CWzJI0KWX1CLm5wdEIPI5MHuzSlmxzSgPulez3yH0R09wD
	 BTda3MCOlnplsVfGgMywSzhiT5C7WoNeR3dBEuiq9bgMj6vuRTKUJbnp9Z0xXlNCHK
	 vqV7klxUfHSA15vqfW4KPQDTqWypgvPt+wCCgJEhoQkx8jLsGVQ7lnNSdePG+poLOz
	 TAYvg/aYkOc9g==
Date: Sun, 28 Jul 2024 16:46:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: pressure: bmp280: Use bulk read for
 humidity calibration data
Message-ID: <20240728164621.16615ce6@jic23-huawei>
In-Reply-To: <20240725231039.614536-2-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
	<20240725231039.614536-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 01:10:33 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Convert individual reads to a bulk read for the humidity calibration data.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

One comment inline.  Short version is move that complicated field start enum
next to the code so we don't need to say so much for it to make sense.

> ---
>  drivers/iio/pressure/bmp280-core.c | 62 ++++++++++--------------------
>  drivers/iio/pressure/bmp280.h      |  6 +++
>  2 files changed, 27 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 3deaa57bb3f5..d5e5eb22667a 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -118,6 +118,12 @@ enum bmp580_odr {
>   */
>  enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
>  
> +/*
> + * These enums are used for indexing into the array of humidity parameters
> + * for BME280.

I was thinking of a comment that also mentioned the overlap. Perhaps something like
...


Index of the byte containing the start of each humidity parameter. Some
parameters stretch across multiple bytes including into the start of the byte
where another humidity parameter begins. Unaligned be/le accesses are used
to allow fields to be extracted with FIELD_GET(). 

Or, just refer to the field layout being complex and to see
bme280_read_calib function.

Actually come to think of it, just move this enum down there so it
is local to the code and the usage is more obvious / comment less important.

> + */
> +enum { H2 = 0, H3 = 2, H4 = 3, H5 = 4, H6 = 6 };
> +
>  enum {
>  	/* Temperature calib indexes */
>  	BMP380_T1 = 0,
> @@ -344,6 +350,7 @@ static int bme280_read_calib(struct bmp280_data *data)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	struct device *dev = data->dev;
> +	s16 h4_upper, h4_lower;
>  	unsigned int tmp;
>  	int ret;
>  
> @@ -352,14 +359,6 @@ static int bme280_read_calib(struct bmp280_data *data)
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Read humidity calibration values.
> -	 * Due to some odd register addressing we cannot just
> -	 * do a big bulk read. Instead, we have to read each Hx
> -	 * value separately and sometimes do some bit shifting...
> -	 * Humidity data is only available on BME280.
> -	 */
> -
>  	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
>  	if (ret) {
>  		dev_err(dev, "failed to read H1 comp value\n");
> @@ -368,43 +367,24 @@ static int bme280_read_calib(struct bmp280_data *data)
>  	calib->H1 = tmp;
>  
>  	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
> -			       &data->le16, sizeof(data->le16));
> -	if (ret) {
> -		dev_err(dev, "failed to read H2 comp value\n");
> -		return ret;
> -	}
> -	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
> -
> -	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
> -	if (ret) {
> -		dev_err(dev, "failed to read H3 comp value\n");
> -		return ret;
> -	}
> -	calib->H3 = tmp;
> -
> -	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
> -			       &data->be16, sizeof(data->be16));
> +			       data->bme280_humid_cal_buf,
> +			       sizeof(data->bme280_humid_cal_buf));
>  	if (ret) {
> -		dev_err(dev, "failed to read H4 comp value\n");
> +		dev_err(dev, "failed to read humidity calibration values\n");
>  		return ret;
>  	}
> -	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
> -				  (be16_to_cpu(data->be16) & 0xf), 11);
>  
> -	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
> -			       &data->le16, sizeof(data->le16));
> -	if (ret) {
> -		dev_err(dev, "failed to read H5 comp value\n");
> -		return ret;
> -	}
> -	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
> -
> -	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
> -	if (ret) {
> -		dev_err(dev, "failed to read H6 comp value\n");
> -		return ret;
> -	}
> -	calib->H6 = sign_extend32(tmp, 7);
> +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> +	calib->H3 = data->bme280_humid_cal_buf[H3];
> +	h4_upper = FIELD_GET(BME280_COMP_H4_GET_MASK_UP,
> +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> +	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, h4_upper);
> +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
> +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> +	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
> +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> +			get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> +	calib->H6 = data->bme280_humid_cal_buf[H6];
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index ccacc67c1473..9bea0b84d2f4 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -257,8 +257,13 @@
>  #define BME280_REG_COMP_H5		0xE5
>  #define BME280_REG_COMP_H6		0xE7
>  
> +#define BME280_COMP_H4_GET_MASK_UP	GENMASK(15, 8)
> +#define BME280_COMP_H4_PREP_MASK_UP	GENMASK(11, 4)
> +#define BME280_COMP_H4_MASK_LOW		GENMASK(3, 0)
>  #define BME280_COMP_H5_MASK		GENMASK(15, 4)
>  
> +#define BME280_CONTIGUOUS_CALIB_REGS	7
> +
>  #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
>  #define BME280_OSRS_HUMIDITY_SKIP	0
>  #define BME280_OSRS_HUMIDITY_1X		1
> @@ -423,6 +428,7 @@ struct bmp280_data {
>  		/* Calibration data buffers */
>  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
>  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> +		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
>  		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
>  		/* Miscellaneous, endianness-aware data buffers */
>  		__le16 le16;


