Return-Path: <linux-iio+bounces-7728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1FD9380EE
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7652E1C214FE
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771B83CD6;
	Sat, 20 Jul 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQKefR9Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F553B64A;
	Sat, 20 Jul 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721474173; cv=none; b=qdQIb05dtlCzkkofbeQN+HDF86l1SpsnwqXBbqymPZTobwfavVLoFQDBLxTUzcA2Oo7s9CWdsyqJ2WOYl9hzrHu+Yn75x5qX9xFUEl20lYQCtBBxBUtk54RXNH1M6EcKKScmjpnZKM4Nx2LfP6pDQqoTKzQTpr55xsDPSD7kLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721474173; c=relaxed/simple;
	bh=ZJS6Gvv1EZ3iEhwrglAXMsONsHmroqRKlD3d8mv3a10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvVw8iWpeBCv8wZZWTFRGKegSePo9sqRqGd4VSJudySAPa1+6qSZXmTFb6qakDDx77xPUJ6Z0vJqBMFZOFLmxzTiikYcbFqc2Pr7vtxphDse0S8c/vZv4G5CfJRpRhwUZHnrPwAZntD6rjDB99t4X0AghLw2RDcC/82/a1+ZpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQKefR9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FA6C2BD10;
	Sat, 20 Jul 2024 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721474172;
	bh=ZJS6Gvv1EZ3iEhwrglAXMsONsHmroqRKlD3d8mv3a10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQKefR9YH1YgePqZdmfpCwa/9IiAXO1uCk2BzUkMPtAV8ksOSN7ky7K0oFX/dIDks
	 bZQsJVGDYfEtysEtqutwdaz2vJMYoyePa0T5TTRKyHupTjk3y9W0ftayYi53OXUby3
	 khJGWbNIJ2DeC73g0tcN3dGeRWNK7LXNVf+/L0ohKImYiRM1oqobNi0ZErL4KpiAYv
	 W7xoqLNN6EhoDOXR+F25Lwacs0WRs6WJ1ijNizAqx3nkp9U8mcO4RTxgdaMa7EyCiU
	 ESpkAjxY7u7nIcKlvulX3dv59hzJtkOKdKcVCjyWiiJi6co8EehSBCt4sBSiPUaKFB
	 eyjgAHOn9Igyg==
Date: Sat, 20 Jul 2024 12:16:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/10] iio: pressure: bmp280: Use bulk read for
 humidity calibration data
Message-ID: <20240720121604.560d24e0@jic23-huawei>
In-Reply-To: <20240711211558.106327-5-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 23:15:52 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Convert individual reads to a bulk read for the humidity calibration data.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 57 +++++++++---------------------
>  drivers/iio/pressure/bmp280.h      |  5 +++
>  2 files changed, 21 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 3deaa57bb3f5..9c32266403bd 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -118,6 +118,8 @@ enum bmp580_odr {
>   */
>  enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
>  
> +enum { H2 = 0, H3 = 2, H4 = 3, H5 = 4, H6 = 6 };
Maybe add a comment to this that these are the locations where
the field 'starts' and that some overlap such as H5 and H6.

> +
>  enum {
>  	/* Temperature calib indexes */
>  	BMP380_T1 = 0,
> @@ -344,6 +346,7 @@ static int bme280_read_calib(struct bmp280_data *data)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	struct device *dev = data->dev;
> +	s16 h4_upper, h4_lower;
>  	unsigned int tmp;
>  	int ret;
>  
> @@ -352,14 +355,6 @@ static int bme280_read_calib(struct bmp280_data *data)
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
> @@ -368,43 +363,23 @@ static int bme280_read_calib(struct bmp280_data *data)
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
> -	if (ret) {
> -		dev_err(dev, "failed to read H4 comp value\n");
> -		return ret;
> -	}
> -	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
> -				  (be16_to_cpu(data->be16) & 0xf), 11);
> -
> -	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
> -			       &data->le16, sizeof(data->le16));
> +			       data->bme280_humid_cal_buf,
> +			       sizeof(data->bme280_humid_cal_buf));
>  	if (ret) {
> -		dev_err(dev, "failed to read H5 comp value\n");
> +		dev_err(dev, "failed to read humidity calibration values\n");
>  		return ret;
>  	}
> -	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
>  
> -	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
> -	if (ret) {
> -		dev_err(dev, "failed to read H6 comp value\n");
> -		return ret;
> -	}
> -	calib->H6 = sign_extend32(tmp, 7);
> +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> +	calib->H3 = data->bme280_humid_cal_buf[H3];
> +	h4_upper = FIELD_GET(BME280_COMP_H4_MASK_UP,
> +			     get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
> +			     get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> +	calib->H4 = sign_extend32((h4_upper & ~BME280_COMP_H4_MASK_LOW) | h4_lower, 11);

This looks unusual.  Why mask with MASK_LOW?  The field_get above already drops the bottom
4 bits an this is dropping more.  Should that H4_MASK_UP actually be GENMASK(15, 8)
and then you shift it left 4 to make space for the lower part?

Original code was messing with values inline so there is less need for it
to be explicit in how it does the masks.  Here you imply a 12 bit field but only use
8 bits of it which isn't good.


> +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> +				  get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> +	calib->H6 = data->bme280_humid_cal_buf[H6];
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index ccacc67c1473..56c01f224728 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -257,8 +257,12 @@
>  #define BME280_REG_COMP_H5		0xE5
>  #define BME280_REG_COMP_H6		0xE7
>  
> +#define BME280_COMP_H4_MASK_UP		GENMASK(15, 4)
> +#define BME280_COMP_H4_MASK_LOW		GENMASK(3, 0)
>  #define BME280_COMP_H5_MASK		GENMASK(15, 4)
>  
> +#define BME280_CONTIGUOUS_CALIB_REGS	7
> +
>  #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
>  #define BME280_OSRS_HUMIDITY_SKIP	0
>  #define BME280_OSRS_HUMIDITY_1X		1
> @@ -423,6 +427,7 @@ struct bmp280_data {
>  		/* Calibration data buffers */
>  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
>  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> +		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
>  		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
>  		/* Miscellaneous, endianness-aware data buffers */
>  		__le16 le16;


