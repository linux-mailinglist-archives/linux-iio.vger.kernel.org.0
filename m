Return-Path: <linux-iio+bounces-13743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3275F9FA426
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 06:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2535E18894BD
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 05:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F814E2E8;
	Sun, 22 Dec 2024 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmUUqKKO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0117BA9;
	Sun, 22 Dec 2024 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734847000; cv=none; b=nuFnyrDFYw8iZ0GdEtWdgerxqvkiNV98rSsz4c/t5pu8kbe2NJayTnrMLMlQAOKj/uG3lHV/EYYuZN+C1NEruc/5MeBrkfs3bf1jAciICcR6KXbPffdwADY13YPE4ILWSL+hu5p/Vjx0SLVKIkZQ4dkPB/wQMc0aZiiSFNYmc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734847000; c=relaxed/simple;
	bh=rtAOpsMPWgRC8DgMJ/m1PF5WA8zSOXdQrLT3ciodyk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkNDumFgUbRmv3iE5pK+OkC3DyO1ocX/AUb7r1h06CLrh9qySiZTQ/DJ8YZiB3cfT7qgdeH98ztncETjg5UHQJq/HjuCxPGj9YEhIUNFwEoqsBCgKtVQ1qI0Pz6s38wuvJsnmZYGbIjkMh0RHnBMm6dS1S9IpxDMogCoRBOjO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmUUqKKO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72739105e02so3366272b3a.0;
        Sat, 21 Dec 2024 21:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734846998; x=1735451798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5BwgJZPVtl4XhwNY1XFgizSA3iSqTzWQpG8IdnlsPp4=;
        b=KmUUqKKO0rjxmlkWbvuZh0nm8qBx+osqUyNOxw3oOX97mFTV9K+sWgY3jP25xZnTqg
         LTN8W0LdtpgI4cKb/NAVKw9bVeHmDZuojavWPH5YdZVlpWkSzfTqVoiASbYR/WTFrnlG
         lheFPeuGDvottNMIwl5EWElFCnr5zEizn9tIetDzrZCVDTD7QVGE7EqITEXyE8CvnZnS
         oAKIbzD7McNagfIPj/+xuioYZzAaI0+unDpeV4MQme8SBEQp+4gGpXzX4Ggcv47USwGm
         a3zy9QbLrXL/PjhB3oMj8sPXbgQl9kC/l2qpUUxyT0yH1LVow3um+Sem3/tEJPufuu6U
         HDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734846998; x=1735451798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BwgJZPVtl4XhwNY1XFgizSA3iSqTzWQpG8IdnlsPp4=;
        b=rDbwSjcUtNMFhpOe8snvaDpYwGFNX4DqihOd0CaNB68C5GPd5VS4HwKyWeszjp51Qq
         fAhWG8xedDB5MFfk9705Q9lg2EalSHDX3lG3K+QvAUr1VKTCg6f8AuOUUOoSh2mtzPwI
         VmtDgyWttnExT+XeqsYk4kqT/4Q6NZFMlFi6sE9VP/0UV7AU31C5vVqlYQYXv5bIqb5F
         ViZaJwFh0W/DFVWkiJyGAP7hbVgdqtpj/8v0cDkTbLivYNPLzAOlTJ/cVkUwzcLMVA5F
         zmd4AOlAdQ7qspOMDOZsdtBtiwnBkZPaW68KYv6HTIBE5IkdxZNTom6oWeq1J8N8WAuA
         z18g==
X-Forwarded-Encrypted: i=1; AJvYcCVcskzDBlzPJ8hcPW7BDmGPu4SOzip7kweebGiaoRxO+cEmz9m0RQZcT7NeOFdG6b8B+Oj4ef6n2wYDkt8G@vger.kernel.org, AJvYcCWeDw4bCYtB9lVKUmfDXdZ9olgrpD4UuGBUVL5qgP9Vj/A1WG43uF56xmgOj43jU57IGshZAWu3Yi4w@vger.kernel.org, AJvYcCX96ZNryv1AkCyjrv2kzxANH1D6fN7ewzD/cjgQ9SUjXbO5eVA3ZvZ4o5kss1rLHoBB56jBBZiflSI2@vger.kernel.org, AJvYcCXQjMU43D/NlaOV5SI7TwOH6pRKEcyotGqi1djtT6b506HzdQdrV5RU5uiZLLLYCbiGCkCKcoMh/bjL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dY4xELqp9mM0tSvbDzIM5y8HxiuPG/EBKWLv11k9UP3fhA26
	TFZsqp9DZoBJHEEOJEzGm4qC0yCF8nQxHDIQyiAeS0qMkCPhR3YJ
X-Gm-Gg: ASbGncuSZYEib01W48WQTDAfF9y8+k0iCS/oMCRZXl/CJCM5fFcxdAB4WOsV9E3WivZ
	SbkDeN8X5UyrkvEUcLp7JFUbvv5G0wPZY7aAC4eiAOAWhpDvAMhVc+CzVgPeUDq5UXVIau0ceXD
	0nRWtq1Ku7romdmifTHSi7/SiCNbOQNxXUrJMywLZHJnQizW+WEmRdgQirN0Ym0IZLXF4j3o9Vp
	+Dn9TjUQ0+68drS6QENeofGXxAb5YaXAHC2Ao02p9jIjN8HBUW4Djc2eLlf9GL0mw==
X-Google-Smtp-Source: AGHT+IFmzvmOXgYF9y+4NfgUyaSRpQVJIRtpzFBicntYlHMruGNiqBTmQzgJb/9ooYLi/PXK0JTMLA==
X-Received: by 2002:a05:6a00:8087:b0:725:ef4d:c1bd with SMTP id d2e1a72fcca58-72abde84667mr13284129b3a.19.1734846997952;
        Sat, 21 Dec 2024 21:56:37 -0800 (PST)
Received: from localhost ([2804:30c:4057:c200:dfe2:5075:a83a:1a44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8157f9sm5808035b3a.24.2024.12.21.21.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 21:56:37 -0800 (PST)
Date: Sun, 22 Dec 2024 02:57:13 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <Z2eqOSN2Uk8SfTq1@debian-BULLSEYE-live-builder-AMD64>
References: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
 <20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5@baylibre.com>

Hello Esteban, some comments inline.

On 12/19, Esteban Blanc wrote:
> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> 
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
[...]
> +
> +static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
> +			   void *val, size_t val_size)
> +{
> +	int ret;
> +	struct ad4030_state *st = context;
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_data,
> +		.rx_buf = st->rx_data.raw,
> +		.len = reg_size + val_size,
> +		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
Is speed_hz really needed? What happens if the controller can't clock at 80MHz?

> +	};
> +
> +	if (xfer.len > ARRAY_SIZE(st->tx_data) ||
> +	    xfer.len > ARRAY_SIZE(st->rx_data.raw))
> +		return  -EINVAL;

Would it make sense to bring register configuration mode commands into the
regmap calls?
I mean, to do the ad4030_enter_config_mode() transfer here and the
ad4030_exit_config_mode() at the end of this function.
From datasheet, it looks like both enter/exit config mode are required for reg
access so why not doing them in the regmap callbacks?
With that, I think it won't be needed to call register config mode functions
in ad4030_single_conversion() and in buffer enable/disable functions.
Might need implement regmap_config read and write callbacks to properly handle
regmap_bulk_read/write interface.


> +
> +	memset(st->tx_data, 0, ARRAY_SIZE(st->tx_data));
> +	memcpy(st->tx_data, reg, reg_size);
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, &st->rx_data.raw[reg_size], val_size);
> +
> +	return ret;
> +}
> +
[...]
> +
> +static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      int *val,
> +				      int *val2)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	u16 gain;
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, AD4030_REG_GAIN_CHAN(chan->address),
> +			       st->rx_data.raw, AD4030_REG_GAIN_BYTES_NB);
> +	if (ret)
> +		return ret;
> +
> +	gain = get_unaligned_be16(st->rx_data.raw);
My impression is that it is a bit odd to handle endianness after/before
calling regmap_read/write(). Can you try set
.val_format_endian_default = REGMAP_ENDIAN_BIG, in ad4030_regmap_bus?
If that doesn't help, what about doing the get/set_unaligned stuff within
the bus read/write calls?

> +
> +	/* From datasheet: multiplied output = input × gain word/0x8000 */
> +	*val = gain / 0x8000;
Use a define to give a name to the gain constant?

> +	*val2 = mul_u64_u32_div(gain % 0x8000, NANO, 0x8000);
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
[...]

