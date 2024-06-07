Return-Path: <linux-iio+bounces-6023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9E900A17
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5969F1C23452
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70F199EB3;
	Fri,  7 Jun 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HalwvGgD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F7154444;
	Fri,  7 Jun 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776752; cv=none; b=rzlOgsAfkKl4wupAd7N8Qh+TxqDtCLktEEncjemlVdjENcXPejuaP9aUI3B3RSw9JwnASyGh0GhTbPjAOAmH6qvEL+uvXhyGs9zDegXNl02p5rg94ydEvtcb0+dApwEWUIxGgx/5lH1izEViRgDLlV/JtW7IeeO/8a6c0+Kj6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776752; c=relaxed/simple;
	bh=btXPYBeWunPMzdwZzv3tIblVtyr25Ls9mguktJUPpDs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoArK7U2FtbHs7kLgwb3a4h7V43MdabJO2nwJJKRM7PeGR0rg52w8L9qYHf6O1ZuZkK/ftLmPcWLKIInfzzobFy3uOSL+4Y0X7C1HP4RTgmrTEygPMm7yHB8mj/o4easIVErTmOCEDX3Ha3YDBqcYJjvUsgDI/i0/+2wXOSFfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HalwvGgD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35dc0472b7eso2029172f8f.2;
        Fri, 07 Jun 2024 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717776749; x=1718381549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsoTRmnRrcL8D+5ar12zWQ+piDt2PSv6klA9B6ko12w=;
        b=HalwvGgD1+Px6FcFcuuSUvuoNWQ2jtITtrif4OB6HjChp4mW04W8w2x9v08yY0lReb
         7susEWVZw7u40s6SIvSMIOI8FJsayu/8qqcOZ9/GFqqxIvl1auYw46wd9HMkEhZCRRr/
         f4TopX5n4bb9RWwXZFsRNWtO0xSou1mY6/Eo/9FpKI8H7Zb07t+1Fp5WYKgnohl6dsgH
         7BnyehqW48Uqp3tGvjs7rKEJLJEAh1C/3XUsvubEdtZrouwQA9CUcw/20kAYl1Qovfi7
         tqY5CnKs2wUOe4nj+1kjcMBrSaTrMIW09JCwAeUDzn6VF3ZIlXvJQsbBZO9GpANdwr0X
         AggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776749; x=1718381549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsoTRmnRrcL8D+5ar12zWQ+piDt2PSv6klA9B6ko12w=;
        b=px6V0t+4t0xmybcZf9FeRknCktr/eJhiOQ7WP4xuVhzotJpD3CqoR6v1Bz2wWDP+bf
         tjqaHzQI1YI+JmivcCRjvMP0P9HzUdU+ipUMODAd9wk3cwFsn6ctXOB15pQrfkno3WaP
         lefCU0imz07rDFPlDnoVCoz31kcoMPzN/iU/tv6MdnqZe0APwE2uyUquSC51vGqC551n
         HoVCtepjN4ucH+yTdMv2U1yDPKfp9WCazNwdOBiH+cjop7HGpzmswIlf2Ftgh/Cmy+By
         K1f55kvmHAnIkxHOUEYe3FYb/gBSGjOUE4XA0FfmjcfFYNN0MHFdYsfU4ZZ4WPyel1Dc
         4ivw==
X-Forwarded-Encrypted: i=1; AJvYcCViB/nhzwJHrDJnJ3dMzSXGvVf7l8jgupvvVdPhPKZNxmHHc7gvIRynzmvQhFpuh6v4Y1tYBHz2jcnyovTXW2jt7nmEWJEKWnGxFyRyCAL1qYbwcWdvjpNNraTSHiltVnBx6p6IGj9k
X-Gm-Message-State: AOJu0YweRHr/ISAdO2X/6DhNH8uiDZWNc0y8VoeLRdi/SngTs7K5Jsg5
	H5hMnqHbwi8ewyHGF/qwsteGFkOPMk8jixG5BD33DIW0H/EDSvhw
X-Google-Smtp-Source: AGHT+IEMMHicXui8m5YMG9hEFYt2Te/24BrOcooGkBGIm/DPSPR8/Narb2bxa42tfDHl/gA81noZdg==
X-Received: by 2002:a05:6000:1e87:b0:354:cf3b:5791 with SMTP id ffacd0b85a97d-35efee90c4cmr2010131f8f.70.1717776748799;
        Fri, 07 Jun 2024 09:12:28 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:aa2c:a157:bad:9dae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f08b280d0sm1472406f8f.86.2024.06.07.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:12:28 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Fri, 7 Jun 2024 18:12:26 +0200
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, dpfrey@gmail.com, himanshujha199640@gmail.com,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mike.looijmans@topic.nl
Subject: Re: [PATCH v2 13/19] iio: chemical: bme680: Add read buffers in union
Message-ID: <20240607161226.GB258325@vamoiridPC>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
 <20240606212313.207550-16-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606212313.207550-16-vassilisamir@gmail.com>

On Thu, Jun 06, 2024 at 11:23:07PM +0200, Vasileios Amoiridis wrote:
> Move the buffers that are used in order to read data from the
> device in the union which handles all the device read/write
> buffers. Also create defines for the number of bytes that are
> being read from the device and don't use magic numbers.
> 

Also this shouldn't have been here for the same reason. Ah, should
have been more careful...

The rest are fine though, so let me know and I submit a v3 with any
new potential changes.

Vasilis

> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h      |  7 +++++
>  drivers/iio/chemical/bme680_core.c | 47 +++++++++++++++---------------
>  2 files changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index 8d0f53c05d7d..7d0ff294725a 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -56,6 +56,13 @@
>  #define   BME680_GAS_MEAS_BIT			BIT(6)
>  #define   BME680_MEAS_BIT			BIT(5)
>  
> +#define BME680_TEMP_NUM_BYTES			3
> +#define BME680_PRESS_NUM_BYTES			3
> +#define BME680_HUMID_NUM_BYTES			2
> +#define BME680_GAS_NUM_BYTES			2
> +
> +#define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
> +
>  /* Calibration Parameters */
>  #define BME680_T2_LSB_REG	0x8A
>  #define BME680_H2_MSB_REG	0xE1
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index b13797f7d873..3c33c21b5d6a 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -111,10 +111,13 @@ struct bme680_data {
>  	s32 t_fine;
>  
>  	union {
> +		u8 buf[3];
> +		unsigned int check;
> +		__be16 be16;
>  		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
>  		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
>  		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
> -	}; 
> +	};
>  };
>  
>  static const struct regmap_range bme680_volatile_ranges[] = {
> @@ -449,7 +452,6 @@ static u8 bme680_oversampling_to_reg(u8 val)
>  static int bme680_wait_for_eoc(struct bme680_data *data)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> -	unsigned int check;
>  	int ret;
>  	/*
>  	 * (Sum of oversampling ratios * time per oversampling) +
> @@ -462,16 +464,16 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
>  
>  	usleep_range(wait_eoc_us, wait_eoc_us + 100);
>  
> -	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
> +	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
>  	if (ret) {
>  		dev_err(dev, "failed to read measurement status register.\n");
>  		return ret;
>  	}
> -	if (check & BME680_MEAS_BIT) {
> +	if (data->check & BME680_MEAS_BIT) {
>  		dev_err(dev, "Device measurement cycle incomplete.\n");
>  		return -EBUSY;
>  	}
> -	if (!(check & BME680_NEW_DATA_BIT)) {
> +	if (!(data->check & BME680_NEW_DATA_BIT)) {
>  		dev_err(dev, "No new data available from the device.\n");
>  		return -ENODATA;
>  	}
> @@ -560,7 +562,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be32 tmp = 0;
>  	u32 adc_temp;
>  	s16 comp_temp;
>  
> @@ -574,13 +575,14 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
>  		return ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
> -			       &tmp, 3);
> +			       data->buf, BME680_TEMP_NUM_BYTES);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read temperature\n");
>  		return ret;
>  	}
>  
> -	adc_temp = be32_to_cpu(tmp) >> 12;
> +	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK,
> +			     get_unaligned_be24(data->buf));
>  	if (adc_temp == BME680_MEAS_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(dev, "reading temperature skipped\n");
> @@ -606,7 +608,6 @@ static int bme680_read_press(struct bme680_data *data,
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be32 tmp = 0;
>  	u32 adc_press;
>  
>  	/* Read and compensate temperature to get a reading of t_fine */
> @@ -615,13 +616,14 @@ static int bme680_read_press(struct bme680_data *data,
>  		return ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
> -			       &tmp, 3);
> +			       data->buf, BME680_PRESS_NUM_BYTES);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read pressure\n");
>  		return ret;
>  	}
>  
> -	adc_press = be32_to_cpu(tmp) >> 12;
> +	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK,
> +			      get_unaligned_be24(data->buf));
>  	if (adc_press == BME680_MEAS_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(dev, "reading pressure skipped\n");
> @@ -638,7 +640,6 @@ static int bme680_read_humid(struct bme680_data *data,
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be16 tmp = 0;
>  	u16 adc_humidity;
>  	u32 comp_humidity;
>  
> @@ -648,13 +649,13 @@ static int bme680_read_humid(struct bme680_data *data,
>  		return ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
> -			       &tmp, sizeof(tmp));
> +			       &data->be16, BME680_HUMID_NUM_BYTES);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read humidity\n");
>  		return ret;
>  	}
>  
> -	adc_humidity = be16_to_cpu(tmp);
> +	adc_humidity = be16_to_cpu(data->be16);
>  	if (adc_humidity == BME680_MEAS_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(dev, "reading humidity skipped\n");
> @@ -672,8 +673,6 @@ static int bme680_read_gas(struct bme680_data *data,
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be16 tmp = 0;
> -	unsigned int check;
>  	u16 adc_gas_res, gas_regs_val;
>  	u8 gas_range;
>  
> @@ -693,19 +692,20 @@ static int bme680_read_gas(struct bme680_data *data,
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
> -	if (check & BME680_GAS_MEAS_BIT) {
> +	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
> +	if (data->check & BME680_GAS_MEAS_BIT) {
>  		dev_err(dev, "gas measurement incomplete\n");
>  		return -EBUSY;
>  	}
>  
>  	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
> -			       &tmp, sizeof(tmp));
> +			       &data->be16, BME680_GAS_NUM_BYTES);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read gas resistance\n");
>  		return ret;
>  	}
> -	gas_regs_val = be16_to_cpu(tmp);
> +
> +	gas_regs_val = be16_to_cpu(data->be16);
>  	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
>  
>  	/*
> @@ -834,7 +834,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  {
>  	struct iio_dev *indio_dev;
>  	struct bme680_data *data;
> -	unsigned int val;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -865,15 +864,15 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> -	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
> +	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading chip ID\n");
>  		return ret;
>  	}
>  
> -	if (val != BME680_CHIP_ID_VAL) {
> +	if (data->check != BME680_CHIP_ID_VAL) {
>  		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
> -			val, BME680_CHIP_ID_VAL);
> +			data->check, BME680_CHIP_ID_VAL);
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.25.1
> 

