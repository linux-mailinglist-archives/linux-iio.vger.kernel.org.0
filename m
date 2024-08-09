Return-Path: <linux-iio+bounces-8353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71DB94CFCF
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38341C20DC3
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411AC194088;
	Fri,  9 Aug 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XK4dzRPn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD519414A;
	Fri,  9 Aug 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205237; cv=none; b=hnNTYWgn6/ENEGuEnUEMv2fsNqQYO0/n3dNSc7AXq1jvq78IjQNWQiW+aAqvm2JgUBCBf7KruFiJ0nzOahPowd9eUZDb+BKD/1fK5Ve4L7G2wWNWQHZmAcYb43HexOE3PNXPfnteT0zYaloTWi3v2OxNyGTokW7rGbsLGAgoU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205237; c=relaxed/simple;
	bh=cCntDo5atUmam/0RCpNBfrJlvB/7wvXX2bTYEOHZo2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=RnJ1gCZcjdwNOQuHy5LNrUYzvC44cHM2XKJ4x/hvIV9zGDiCr1DxCZj0mjI2EXfU7bwakrmBEs1MFziuUugrur1pjll0D0/0H4EHpJZirURJqvp2gpPtsy0WD8aGKJqg20Y9HocFDaWnmtWU0h6+cnK2VgFhDwLhQFip40QwL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XK4dzRPn; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id cOOfsfITE7tglcOOfsO8Ff; Fri, 09 Aug 2024 14:07:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723205226;
	bh=eLSKGWghljnkOEFaengJiEdKvJCm8HRw9cwbykbGzRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XK4dzRPnyJulRKJq4BF9wWZa/4h260y4qdrHqlP/kSwuyhyxTd67GkcGyW5LfFhIP
	 luS7O6a2H+P0+6HVvPsIPVEuCqdlxy86wmPZO/H5LVTjt9c8/TKe4gPHl2eqU6PyFo
	 rgICpeX/KWFItZnM+1EEYOM0/5QZRPJfJzU90w79YCpugUDhcUbHl6KUILNI5xjq/q
	 McqFsjNmTsMfp49EWiTTjnuwLhAdOEAzPQo92yG27RlK6DZKHNAj2gAaF/lsScUAMV
	 EZKMdn6zeeqbuD/xyC88BPgnmZa/7D2MZERf5Yem7fo5xW2kLD9Gl9hqyib4Y8pFKp
	 x3r2eyPxdQnaA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 09 Aug 2024 14:07:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <16c09207-48c6-4988-873f-772fa277f3b8@wanadoo.fr>
Date: Fri, 9 Aug 2024 14:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: imu: smi240: imu driver
To: jianping.shen@de.bosch.com
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christian.Lorenz3@de.bosch.com, Kai.Dolde@de.bosch.com,
 Ulrike.Frauendorf@de.bosch.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dima.fedrau@gmail.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com, robh@kernel.org
In-Reply-To: <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/08/2024 à 13:16, 
Jianping.Shen-V5te9oGctAVWk0Htik3J/w@public.gmane.org a écrit :
> From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> 
> iio: imu: smi240: driver improvements
> Signed-off-by: Shen Jianping (ME-SE/EAD2) <Jianping.Shen-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> ---

Hi,

...

> diff --git a/drivers/iio/imu/smi240/smi240_core.c b/drivers/iio/imu/smi240/smi240_core.c
> new file mode 100644
> index 00000000000..4b2a4a290f3
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_core.c

...

> +static int smi240_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	int ret = 0;

No need to init (and in other places you don't)

> +	struct smi240_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +		ret = smi240_get_data(data, chan->type, chan->channel2, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		ret = smi240_get_low_pass_filter_freq(data, chan->type, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int smi240_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	int ret, i;
> +	struct smi240_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		for (i = 0; i < ARRAY_SIZE(smi240_low_pass_freqs); i++) {
> +			if (val == smi240_low_pass_freqs[i])
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(smi240_low_pass_freqs))
> +			return -EINVAL;
> +
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			data->accel_filter_freq = val;
> +			break;
> +		case IIO_ANGL_VEL:
> +			data->anglvel_filter_freq = val;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	// Write access to soft config is locked until hard/soft reset
> +	ret = smi240_soft_reset(data);
> +	if (ret)
> +		return ret;

Nitpick: missing new line?

> +	ret = smi240_soft_config(data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

...

> +int smi240_core_probe(struct device *dev, struct regmap *regmap)
> +{
> +	struct iio_dev *indio_dev;
> +	struct smi240_data *data;
> +	int ret, response;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Allocate iio device failed\n");

Usually messages related to memory allocation are not useful.
Just: return -ENOMEM?

> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->regmap = regmap;
> +	data->capture = 0;

No need to explicitly initialize 'capture', devm_iio_device_alloc() 
already zeroes the allocated emmory.
It doesn't hurt to be explicit, but why this field and not the other ones?

> +
> +	ret = regmap_read(data->regmap, SMI240_CHIP_ID_REG, &response);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Read chip id failed\n");
> +
> +	if (response != SMI240_CHIP_ID)
> +		dev_info(dev, "Unknown chip id: 0x%04x\n", response);

...

> diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
> new file mode 100644
> index 00000000000..ac9e37ffa37
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_spi.c

...

> +static int smi240_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	__be32 request;
> +	struct spi_device *spi = context;
> +	u8 reg_addr = ((u8 *)data)[0];
> +	u16 reg_data = ((u8 *)data)[2] << 8 | ((u8 *)data)[1];
> +
> +	request = SMI240_BUS_ID << 30;
> +	request |= FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> +	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> +	request |= FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> +	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +	request = cpu_to_be32(request);
> +
> +	return spi_write(spi, &request, sizeof(request));
> +}
> +
> +static struct regmap_bus smi240_regmap_bus = {

const?

> +	.read = smi240_regmap_spi_read,
> +	.write = smi240_regmap_spi_write,
> +};

...

CJ


