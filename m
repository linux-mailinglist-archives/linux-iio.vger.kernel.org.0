Return-Path: <linux-iio+bounces-26601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE9C988EF
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 18:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2DE24E20DC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208BB33859B;
	Mon,  1 Dec 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OOg8xbtE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6A3191A2
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610865; cv=none; b=DtHE0E06WKzSQwXZOVD3Ew5qBl8oboDd5Eu2ybfBLOOwrt+nW0oSzcCIO9VJNja2KpTtC5kt/Evx8GpaYWnzxnfrT9hUgtm6zery15XW4nDkgDv/GCyZbRTgOPeMCJSgbg/K0YKXk/R1SczPDCPCqZ1SBd2ieJd8pFIxXceJq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610865; c=relaxed/simple;
	bh=dw0EQgDhJf6pflbx0XU9AUC5UfvzhU1O45vcNf+4wNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV1r1vAu/KY9YyXAQzvnsJBOFnnZCPCnqvSSKRbgbJFrmPFf/yfKMMI96j2ZAYEQ8s+6SDk7pLf7lPCghz7+HlxYKXk/Cf0kA3kLW/zQEw1FMFY4Vr0ZpcBpNpW05pg3uYoYOraQ5xs6m8jvUgHXPRDKHkuxtOQvwZ8urnUr4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OOg8xbtE; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c6e9538945so3016844a34.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764610860; x=1765215660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUSAUQ4UhX/yrGJneAdKjlg2vo7uvO8/o8WCYG0EHC4=;
        b=OOg8xbtEpMg0PxGcb2TMvdJTAqPEXETpuBrI4GwNQJOo3h1HiLBpDiYHFjDWdTepjh
         rNCc8YwACurRShrKYTmCswR9rPhXH8nT46qWISHyCkbrTrapPs60VsQktKF7s3VfV7fP
         ygmrufFlPmQx+TGU+i0/yBrcLeNjsNxlBwy0qHMjreqoe4+HGoh+nNJoby8XfHPJ5Yyq
         LOkjQk3xmXLO0SoWr3p/01fUnqnGv3f5Ym/3LGejBT5asnUDFjqbeBEpzOHDXthehmvU
         G2NWYsRdvDpQqm2+uIdrDJkkPFXnef7CYsLrOOoquH+WX9ptMNeYodY7tgOKkACQF2cL
         iIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764610860; x=1765215660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUSAUQ4UhX/yrGJneAdKjlg2vo7uvO8/o8WCYG0EHC4=;
        b=b4zWZH2QtROcJZ9dSnkdVm+TgVivCETOapOrwu1i9gE2OPjiFzI/ZftJ5YAD7+wklq
         AOk5QCX11cQKpRakSUhXf38eIG1SwwCNqK0BAYFfd6lIuVNsMvQdJ+YRCQo7v+Kqpnfb
         tJkAr3jpd6snc2aSUV2akNGIEHi3z74zN6tg6S+jeTrwQ+o91POFlouM4i7rHxb8Icfl
         wStTtg7Yhfx3qmZcWDmpwwKHivZTV4ivyhThXN3TNUJplNSMl4H9gphPiYMlBrHtWu3U
         z8Hy2je/wC08DFOhjoFeHjSz5DJVtOLg7w8WDtVBxqsgWkqcTD8iEzRfvmvqyhDjFz7t
         oDsg==
X-Forwarded-Encrypted: i=1; AJvYcCX407kvhQKjuBRwNPJZ4zKnZXlgyrsL2S2sMSIHgswhNRZ/F4bvrYpgRTAmRnhz0E40o34sX1gv0BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSXGOzUdwBVAqoXXOrLxtnAuFEV4DmLd8sEYqXmXQqdLc4laT
	WL9d1iqpvByzA1bhQ6Dat2RUyuY9rBh5RP6ZfzS73crVQCN1fHjkWR3eUr2NteXOnW4A9A/0Eqg
	qnJS2
X-Gm-Gg: ASbGncvlAyoEjs4G99ZOyxX+IwWFSJ71DRlYPKqqEG7TwA7DMrp7WKbMKY9XOumrCyA
	iuLtqobRUd8u37NwY54ute5vfEDmHHc97HMJQqWoDM7frV85uZ5UeWy+NVQ4Y3adva6gliuRY49
	yjxEtcQKkVu9e/CZt/qG+cv+lk+mTsLxxMnJeXZjTopTjCfFukva0903mKUo/zS2EzZ8vzyXJZV
	GwEfVTeuhaQ7O+362B0aiMB33SapHdmbvNvtJGydWuxNyu175aLAhMtZWLrzlTtbaOo9RkVFZRw
	qtJTBCZlhJauLkls+weORHXkhDBtBgOUC4kTFJ2qyQrLqdvheSwkpZYd4OfOT3GD1IylYjoRL9l
	Z1o6Xh2k3mLQ8nl92DjwlNHHIWdtYnaj/XjqEf6rD/c7qrS3FenDvX7HGyMp8hqtKxNO64Wta/7
	Iyj+ETye3m3B2LVQqaDiB0J5A+WB32EeWbpiL7jNyNbCC2cGxt9F9OunqbdA==
X-Google-Smtp-Source: AGHT+IG+VqtbcF63ImMJvcB2zvTP7A25IT3mbkL7vvfyw0u4SaAIjSEERp0oLrPGuUtWRtZJli+CEw==
X-Received: by 2002:a05:6830:6e9f:b0:7c7:7f85:d19 with SMTP id 46e09a7af769-7c798abffa9mr19107007a34.8.1764610859972;
        Mon, 01 Dec 2025 09:40:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:b67b:16c:f7ae:4908? ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5fec7fsm4903164a34.11.2025.12.01.09.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 09:40:59 -0800 (PST)
Message-ID: <7e042d4e-0ca6-4b2c-9b65-79593a526b5d@baylibre.com>
Date: Mon, 1 Dec 2025 11:40:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: support write/read offset
To: Tomas Melin <tomas.melin@vaisala.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com>
 <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 5:59 AM, Tomas Melin wrote:
> Support configuring output offset value. Among the devices
> currently supported by this driver, this setting is specific to
> ad9434.

What is the purpose of adjusting the offset. If it is to compensate
e.g. for manufacturing variations, the CALIBBIAS might be a better
choice. In any case, the commit message should explain a bit better
the intended use.

> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/adc/ad9467.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 2910b6c5b576d101a25c0b5f0fb9024f0b4da63d..41b29e9e765b4296358bb277d63993889ce46290 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -145,6 +145,7 @@ struct ad9467_chip_info {
>  	unsigned int num_lanes;
>  	unsigned int dco_en;
>  	unsigned int test_points;
> +	const int *offset_range;
>  	/* data clock output */
>  	bool has_dco;
>  	bool has_dco_invert;
> @@ -234,6 +235,10 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  	return 0;
>  }
>  
> +static const int ad9434_offset_range[] = {
> +	-128, 1, 127,
> +};
> +
>  static const unsigned int ad9265_scale_table[][2] = {
>  	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
>  };
> @@ -281,6 +286,23 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
>  	*val2 = tmp % 1000000;
>  }
>  
> +#define AD9434_CHAN(_chan, avai_mask, _si, _bits, _sign)		\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = _chan,						\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
> +		BIT(IIO_CHAN_INFO_OFFSET),				\
> +	.info_mask_shared_by_type_available = avai_mask,		\
> +	.scan_index = _si,						\
> +	.scan_type = {							\
> +		.sign = _sign,						\
> +		.realbits = _bits,					\
> +		.storagebits = 16,					\
> +	},								\
> +}
> +
>  #define AD9467_CHAN(_chan, avai_mask, _si, _bits, _sign)		\
>  {									\
>  	.type = IIO_VOLTAGE,						\
> @@ -298,7 +320,8 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
>  }
>  
>  static const struct iio_chan_spec ad9434_channels[] = {
> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> +	AD9434_CHAN(0, BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +		    0, 12, 's'),
>  };
>  
>  static const struct iio_chan_spec ad9467_channels[] = {
> @@ -367,6 +390,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
>  	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
>  	.vref_mask = AD9434_REG_VREF_MASK,
>  	.num_lanes = 6,
> +	.offset_range = ad9434_offset_range,
>  };
>  
>  static const struct ad9467_chip_info ad9265_chip_tbl = {
> @@ -499,6 +523,29 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
>  	return -EINVAL;
>  }
>  
> +static int ad9467_get_offset(struct ad9467_state *st, int *val)
> +{
> +	*val = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
> +	if (*val < 0)
> +		return *val;


Since processed value is (raw + offset) * scale, this means that
the offset will be applied twice, once in hardware and once in
software. I don't think that is the intended case here?

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad9467_set_offset(struct ad9467_state *st, int val)
> +{
> +	int ret;
> +
> +	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
> +		return -EINVAL;
> +
> +	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
> +	if (ret < 0)
> +		return ret;

This could use a comment explaining why we need to do the sync after
adjusting the offset.

> +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
> +				AN877_ADC_TRANSFER_SYNC);
> +}
> +
>  static int ad9467_outputmode_set(struct ad9467_state *st, unsigned int mode)
>  {
>  	int ret;
> @@ -802,6 +849,8 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
>  	struct ad9467_state *st = iio_priv(indio_dev);
>  
>  	switch (m) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		return ad9467_get_offset(st, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		return ad9467_get_scale(st, val, val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -836,6 +885,8 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		return ad9467_set_offset(st, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		return ad9467_set_scale(st, val, val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -874,6 +925,11 @@ static int ad9467_read_avail(struct iio_dev *indio_dev,
>  	const struct ad9467_chip_info *info = st->info;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		*type = IIO_VAL_INT;
> +		*vals = info->offset_range;
> +		*length = 3;

We don't need to specify length when using IIO_AVAIL_RANGE.

> +		return IIO_AVAIL_RANGE;
>  	case IIO_CHAN_INFO_SCALE:
>  		*vals = (const int *)st->scales;
>  		*type = IIO_VAL_INT_PLUS_MICRO;
> 


