Return-Path: <linux-iio+bounces-6022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28277900A12
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D00282958
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC63199E90;
	Fri,  7 Jun 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLb38dIa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167C188CA1;
	Fri,  7 Jun 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776667; cv=none; b=P8Bh1A6OkwpT6ssKOvexHAb7Yb4dngTBDN3eT8ftT0y+EAfA5yJRnT/q+gYNtSiGtBzp2RFNAEEpjmxl22G+93V1j7DzQtVN81BtObuUAd8XfSxMxUotoK/bcMP/JXnDodXiS7A93NWc3S//vPqoac+xFMlaVSkAMPhF0Ur9eMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776667; c=relaxed/simple;
	bh=rU0N5rMF8e7bDYLErsSLG7V6n23L4t9d4TJanFMNhbE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbxZ/xesJT3hKzRuqc9HVzzLq7UzUCIzpYrFMNxf64xkJFWlsRbS8pj+13XtdiR33SY5H0k4kH6d1OBHiqpmeYgjImuodRmMniVmm9X5S6SQUzCxPFJKxbUGty7VmVhisWPDirIGtO2q7MHmdJTWuW4sACY70mgLxswcoTn3tn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLb38dIa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217926991fso1897595e9.3;
        Fri, 07 Jun 2024 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717776664; x=1718381464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5bdc+pfGoWpEU9poKk35GL0B8Njtn2Bkx1uKgiELHA=;
        b=FLb38dIalsoInIVU1CXvHu6LaUPQQbxhW3KkBp1fhCvR8bb989GNjGtIdA9PFsqImr
         iF+OGrwUKRFxXjbJbaMthrLA9jQh2cn7M3sRajxCGE1OQNUZ7ZX3s2wbTeB4ezPEsHCA
         9b1StoWOeP4XMso1/gf9mll6MSrg1VHgLj50fhOLYQk5LH2Pb7Z+jI+3tLrGbUZA6sos
         tAy5Nv+dpXIpI/oCLqDOfxLnWXPaN7PIOamH1Yf9UkMmQIOUT29tO5a5qnkJq9kU6Dre
         M1jxmJLXT9Nv1M8cQ82s/seESyLbPgeZXPAT6TcUPyXmxNTXRYAR5SHqLhxQMdgKrX8s
         +0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776664; x=1718381464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5bdc+pfGoWpEU9poKk35GL0B8Njtn2Bkx1uKgiELHA=;
        b=l+uJ48tuJwtJLY/hjQjxLX/QGCjQU0FJCcyCTXwxNPRpoZ/icrXimCtl6fdnjE8xHl
         1WUE2DP89qJmp3lpQjSLtV5ECIteLHEHWCi6B4MxhH4aCxQHLwKuMKsu1t9Hi/utFLOh
         2nY52jU83iKeVIhOx2El5+DvgSiKqk9QPXLhc59pc0rrk1V9cktRCsF+wQWVOojcsKgO
         htfeV11gjlZmP+FhBbxWtpnhLJp23A7WwtWjT0cjLInYFOSmqQV+phTMi94al3p3rjH2
         YMXtOJrucVkMfKAeZFBl3EA86/1Ng1lugWfFo/AUinAmtbR0Fe6zrLHdO/wLugH1aGWJ
         duww==
X-Forwarded-Encrypted: i=1; AJvYcCXTXB/R8HrQ/fvyAE7GjtWFdprFGc4mgKqQuqjl+o8OyMBg/qlWQACE/qciAaYyemQV/t9tQsBlk8wsW6SE62fhnGumu4Ya91vyHmjzwnpOH82O9Vx4qN728q76KpUNMMiJBpnceqm9
X-Gm-Message-State: AOJu0YyqYoc5ZxsGQ8hY+HWaTI2tGD3x0hp/3QYh18+MQkXdMKtyKKqY
	/8Hd6yeDgHxSS/faN4VwxmlLJpcp/brxRi9FX87sGY+c7uiLSbt/
X-Google-Smtp-Source: AGHT+IFo60xb52XcFSA3ErA6fEHCAfI5uL+rS8k24CxxqZdGNOqetnFSyYzlTIES8xDWUJVoYjz7ow==
X-Received: by 2002:a05:600c:511c:b0:41c:3e1:9db9 with SMTP id 5b1f17b1804b1-42164a20d89mr20905815e9.27.1717776664071;
        Fri, 07 Jun 2024 09:11:04 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:aa2c:a157:bad:9dae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e674sm57598235e9.6.2024.06.07.09.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:11:03 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Fri, 7 Jun 2024 18:11:01 +0200
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, dpfrey@gmail.com, himanshujha199640@gmail.com,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mike.looijmans@topic.nl
Subject: Re: [PATCH v2 13/19] iio: chemical: bme680: Add read buffers in DMA
 safe region
Message-ID: <20240607161101.GA258325@vamoiridPC>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
 <20240606212313.207550-14-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606212313.207550-14-vassilisamir@gmail.com>

On Thu, Jun 06, 2024 at 11:23:05PM +0200, Vasileios Amoiridis wrote:
> Move the buffers that are used in order to read data from the
> device in a DMA-safe region. Also create defines for the number
> of bytes that are being read from the device and don't use
> magic numbers.
> 

Well this commit shouldn't have been here, I changed the title and
forgot to delete it from the folder...

Vasilis

> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h      |  7 +++++
>  drivers/iio/chemical/bme680_core.c | 45 +++++++++++++++---------------
>  2 files changed, 29 insertions(+), 23 deletions(-)
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
> index 538696ac4205..99259d0cf13d 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -115,6 +115,9 @@ struct bme680_data {
>  	 * transfer buffers to live in their own cache lines.
>  	 */
>  	union {
> +		u8 buf[3];
> +		unsigned int check;
> +		__be16 be16;
>  		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
>  		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
>  		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
> @@ -453,7 +456,6 @@ static u8 bme680_oversampling_to_reg(u8 val)
>  static int bme680_wait_for_eoc(struct bme680_data *data)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> -	unsigned int check;
>  	int ret;
>  	/*
>  	 * (Sum of oversampling ratios * time per oversampling) +
> @@ -466,16 +468,16 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
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
> @@ -564,7 +566,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be32 tmp = 0;
>  	u32 adc_temp;
>  	s16 comp_temp;
>  
> @@ -578,13 +579,14 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
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
> @@ -610,7 +612,6 @@ static int bme680_read_press(struct bme680_data *data,
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be32 tmp = 0;
>  	u32 adc_press;
>  
>  	/* Read and compensate temperature to get a reading of t_fine */
> @@ -619,13 +620,14 @@ static int bme680_read_press(struct bme680_data *data,
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
> @@ -642,7 +644,6 @@ static int bme680_read_humid(struct bme680_data *data,
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be16 tmp = 0;
>  	u16 adc_humidity;
>  	u32 comp_humidity;
>  
> @@ -652,13 +653,13 @@ static int bme680_read_humid(struct bme680_data *data,
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
> @@ -676,8 +677,6 @@ static int bme680_read_gas(struct bme680_data *data,
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> -	__be16 tmp = 0;
> -	unsigned int check;
>  	u16 adc_gas_res, gas_regs_val;
>  	u8 gas_range;
>  
> @@ -697,19 +696,20 @@ static int bme680_read_gas(struct bme680_data *data,
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
> @@ -838,7 +838,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  {
>  	struct iio_dev *indio_dev;
>  	struct bme680_data *data;
> -	unsigned int val;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -869,15 +868,15 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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

