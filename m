Return-Path: <linux-iio+bounces-21904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E916B0F4FD
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3CB7AAF9F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F72E62CF;
	Wed, 23 Jul 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jyH96fok"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983B290BA2
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279995; cv=none; b=jmVHxgavXJK2cz37/aEB0LHAYQZVgidFo24C6mRBsj27xfgBKEiP2PkhIV1aUNDys2WZ6Sz03+zLTF0OzOEtnzwaFjpRr+h60GQ4IOjOZbpbXBkW8ieSXXzkgyBribMgccrLuJheolu4r95Kh8Bv258Q8OJyko+5APolj3WlO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279995; c=relaxed/simple;
	bh=5FTpl/NRfvEkFRhjOOq98Ttksl7wdniPV0iq+DVaeqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFXFpHAfAOzmZWYj8ZnHJIZ8dC+MuthcEvQtSVu8ELKn+YP4pcqFww9xz/dhUnaKKUOb6R/wxOD+rFkuXIn/zjl+uOYpSo/2tPkY3FK1wpe4kC0QBsZPhpeNR5Qa7qNG7yEjS4g/ixYDySuKJR3f+kvq9tDvslqjpYCU6pWqg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jyH96fok; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73e7804cf31so1372651a34.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753279992; x=1753884792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dw0qg84XGboauik3OyIcaiMuYcrk46ZtcbxJuSXi7l0=;
        b=jyH96fok83SYnodFX3GXcxPop9W4lfcVcfECGv1MITol8k5tF4SAU1O+ojC47DE3nb
         /IXvpNmCM3sUvJP9CMzazYzugjZecnu7a9HO/2Bu2qqzciaMcRw/U+4mQH91dWQ6tn+Z
         IcKMckvB5Ns2SWC1GACmgYJDkg/pCo6Ro8LXnbfzGGxl1KqlRdmhy+UhyzZpPi7zYysO
         gTsgYxi2V5x+6ZdaOniwEylr38Hnog7E9bvhJbKgR8MzhPVfrQw4cZCuyB+wRyIZLaOH
         4yjwi3QuB86dZiFvRKeJYwzhjx6fwx1hCtK1H/jPoTQ9WHoRgk7ZHew+ZMUUwo1DKjL7
         X0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279992; x=1753884792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw0qg84XGboauik3OyIcaiMuYcrk46ZtcbxJuSXi7l0=;
        b=kWSD18zYUGQ2xCGadlCmOgqrbdpcFUCY2BahFZQkjWqdQgJPKfN8jT3AshwbX9dGGy
         2I69iJW/WN4UWOR1Y9OpgnSoLsleSSOWYY5J18KWOfI2kz/x2LdL15taf+BxHzwqYjqa
         2M0GjB9o0up0zbLdZGvPz0sOr2F3plCCDBaADb5uV8gpspOgkhnn4MX2i+cOx0u/oC2Z
         WUgoqDyQYhzM66qam+NGrw6QCAiE8iFsbtWbRh5Td+nn2INWHSxSG/WlfMgPZZeQPYym
         chOAxT9afPiTigea++2GRvm66MmuEoySr1HdzryRVmxCHfWzUlM9BlGuKj2RxH29Z3lW
         UhjA==
X-Forwarded-Encrypted: i=1; AJvYcCUul4o0CPyN9QjuVbuVBZefxhp5sUKOgEsVlqToaTdBXihvQIYX0HlHGKECaGnKauLlWQkHI3fqRy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwOtKvQd27AOxTZrG2VHZaXhh/CGj+Y9IRz2BjuaNSZ8kmOTz
	bsbqi4d3sy6nmlyGUXKYH//LpGTtF4Uw7IHol7k4bOjSDpgl/MO98NfojkNSHMfX+iM=
X-Gm-Gg: ASbGncvrs7IQcEfC8bxX7DnxjREuxT9DwitRDg7YQa5MBsW+rCfKIP1lcQia0vktAB4
	EPf6S2H8xzTgxFeZXRrvjblUEONwkBCyvPpDBNKfyDkj7Zm2/QJ2d1XQhcd4jTYkPjDbUADCEag
	oMPEHaiHGPcHcYF0+TAhb6NVTW5HbenhCZK44+f84bq/ejxwx342Y2UBRbYx2oXsLdkzZUGV4I8
	tLWPBH7Sf4aax1HXObzZjbbjws5VHL24lcVWM9me7Hsr+Wkcp9wHclW2L+992+4dYz3F0GhiOH4
	R1jJC6X88k/oHZO3tPIS+L6L2hHUYe8elnzfET14QzqRNT/mwWoMpM08eUx2VQ8m83hi8ZCuE21
	gnstmOeklJF+Ltiag71RINBsGy4Rhy/xtFqvaq3X+2NCeh0mM8GTCt3QSzKxARaJsVElsVR1x
X-Google-Smtp-Source: AGHT+IGEqgbFDs2ptHSJgDIqTDFj0Aa5AW48aA/zqI9KSm2t4dpjAyk+5El/XZiInaZL3nwv+NwVqw==
X-Received: by 2002:a05:6830:4d8a:b0:739:fc48:6831 with SMTP id 46e09a7af769-74088ac1d69mr1906242a34.21.1753279990795;
        Wed, 23 Jul 2025 07:13:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73ea2fd3b11sm2160309a34.7.2025.07.23.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 07:13:10 -0700 (PDT)
Message-ID: <4cb1a608-a069-450c-8962-7966259d97a8@baylibre.com>
Date: Wed, 23 Jul 2025 09:13:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: ltr390: Add debugfs register access support
To: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723114645.596648-1-akshayaj.lkd@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250723114645.596648-1-akshayaj.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 6:46 AM, Akshay Jindal wrote:
> Add support for debugfs_reg_access through the driver's iio_info structure
> to enable low-level register read/write access for debugging.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
> Testing details:
> ================
> -> Tested on Raspberrypi 4B. Follow for more details.
> 

...

>  drivers/iio/light/ltr390.c | 99 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 89 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index ee59bbb8aa09..1f6ee0fd6d19 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -38,12 +38,20 @@
>  #define LTR390_ALS_UVS_GAIN		0x05
>  #define LTR390_PART_ID			0x06
>  #define LTR390_MAIN_STATUS		0x07
> -#define LTR390_ALS_DATA			0x0D
> -#define LTR390_UVS_DATA			0x10
> +#define LTR390_ALS_DATA_0		0x0D
> +#define LTR390_ALS_DATA_1		0x0E
> +#define LTR390_ALS_DATA_2		0x0F
> +#define LTR390_UVS_DATA_0		0x10
> +#define LTR390_UVS_DATA_1		0x11
> +#define LTR390_UVS_DATA_2		0x12
>  #define LTR390_INT_CFG			0x19
>  #define LTR390_INT_PST			0x1A
> -#define LTR390_THRESH_UP		0x21
> -#define LTR390_THRESH_LOW		0x24
> +#define LTR390_THRESH_UP_0		0x21
> +#define LTR390_THRESH_UP_1		0x22
> +#define LTR390_THRESH_UP_2		0x23
> +#define LTR390_THRESH_LOW_0		0x24
> +#define LTR390_THRESH_LOW_1		0x25
> +#define LTR390_THRESH_LOW_2		0x26
>  
>  #define LTR390_PART_NUMBER_ID		0xb
>  #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
> @@ -98,11 +106,62 @@ struct ltr390_data {
>  	int int_time_us;
>  };
>  
> +static bool ltr390_is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LTR390_MAIN_CTRL:
> +	case LTR390_ALS_UVS_MEAS_RATE:
> +	case LTR390_ALS_UVS_GAIN:
> +	case LTR390_PART_ID:
> +	case LTR390_MAIN_STATUS:
> +	case LTR390_ALS_DATA_0:
> +	case LTR390_ALS_DATA_1:
> +	case LTR390_ALS_DATA_2:
> +	case LTR390_UVS_DATA_0:
> +	case LTR390_UVS_DATA_1:
> +	case LTR390_UVS_DATA_2:
> +	case LTR390_INT_CFG:
> +	case LTR390_INT_PST:
> +	case LTR390_THRESH_UP_0:
> +	case LTR390_THRESH_UP_1:
> +	case LTR390_THRESH_UP_2:
> +	case LTR390_THRESH_LOW_0:
> +	case LTR390_THRESH_LOW_1:
> +	case LTR390_THRESH_LOW_2:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ltr390_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LTR390_MAIN_CTRL:
> +	case LTR390_ALS_UVS_MEAS_RATE:
> +	case LTR390_ALS_UVS_GAIN:
> +	case LTR390_INT_CFG:
> +	case LTR390_INT_PST:
> +	case LTR390_THRESH_UP_0:
> +	case LTR390_THRESH_UP_1:
> +	case LTR390_THRESH_UP_2:
> +	case LTR390_THRESH_LOW_0:
> +	case LTR390_THRESH_LOW_1:
> +	case LTR390_THRESH_LOW_2:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Using rd_table and wr_table is a bit more compact than readable_reg
writeable_reg.

> +
>  static const struct regmap_config ltr390_regmap_config = {
>  	.name = "ltr390",
>  	.reg_bits = 8,
>  	.reg_stride = 1,
>  	.val_bits = 8,
> +	.max_register = LTR390_THRESH_LOW_2,
> +	.readable_reg = ltr390_is_readable_reg,
> +	.writeable_reg = ltr390_is_writeable_reg,
>  };
>  
>  /* Sampling frequency is in mili Hz and mili Seconds */
> @@ -194,7 +253,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  			if (ret < 0)
>  				return ret;
>  
> -			ret = ltr390_register_read(data, LTR390_UVS_DATA);
> +			ret = ltr390_register_read(data, LTR390_UVS_DATA_0);
>  			if (ret < 0)
>  				return ret;
>  			break;
> @@ -204,7 +263,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  			if (ret < 0)
>  				return ret;
>  
> -			ret = ltr390_register_read(data, LTR390_ALS_DATA);
> +			ret = ltr390_register_read(data, LTR390_ALS_DATA_0);
>  			if (ret < 0)
>  				return ret;
>  			break;
> @@ -454,14 +513,14 @@ static int ltr390_read_threshold(struct iio_dev *indio_dev,
>  
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
> -		ret = ltr390_register_read(data, LTR390_THRESH_UP);
> +		ret = ltr390_register_read(data, LTR390_THRESH_UP_0);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret;
>  		return IIO_VAL_INT;
>  
>  	case IIO_EV_DIR_FALLING:
> -		ret = ltr390_register_read(data, LTR390_THRESH_LOW);
> +		ret = ltr390_register_read(data, LTR390_THRESH_LOW_0);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret;
> @@ -480,10 +539,10 @@ static int ltr390_write_threshold(struct iio_dev *indio_dev,
>  	guard(mutex)(&data->lock);
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
> -		return regmap_bulk_write(data->regmap, LTR390_THRESH_UP, &val, 3);
> +		return regmap_bulk_write(data->regmap, LTR390_THRESH_UP_0, &val, 3);
>  
>  	case IIO_EV_DIR_FALLING:
> -		return regmap_bulk_write(data->regmap, LTR390_THRESH_LOW, &val, 3);
> +		return regmap_bulk_write(data->regmap, LTR390_THRESH_LOW_0, &val, 3);
>  
>  	default:
>  		return -EINVAL;
> @@ -586,6 +645,25 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
> +						unsigned int reg, unsigned int writeval,
> +						unsigned int *readval)
> +{
> +	int ret;
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +
> +	if (!readval)
> +		return regmap_write(data->regmap, reg, writeval);

nit: reverse the if logic to avoid !

> +
> +	ret = regmap_read(data->regmap, reg, readval);

Just return directly here as well.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static const struct iio_info ltr390_info = {
>  	.read_raw = ltr390_read_raw,
>  	.write_raw = ltr390_write_raw,
> @@ -594,6 +672,7 @@ static const struct iio_info ltr390_info = {
>  	.read_event_config = ltr390_read_event_config,
>  	.write_event_value = ltr390_write_event_value,
>  	.write_event_config = ltr390_write_event_config,
> +	.debugfs_reg_access = ltr390_debugfs_reg_access,
>  };
>  
>  static irqreturn_t ltr390_interrupt_handler(int irq, void *private)


