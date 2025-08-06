Return-Path: <linux-iio+bounces-22339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E062DB1C8A0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934C018C34D6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3128FFDA;
	Wed,  6 Aug 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ucujOpHq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54236290BA2
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493834; cv=none; b=DMj8ZP1/aJ1BNSnvrA2Z+r4Ok436BcDo1Syw3K08DcVS6eZ3qSGbCkA9aOM82EkDc3sa91XJyVy3043RW/SihVZ+iHQGCU+J/f6M9DxUUFAhLUQ84tXprhJi1J8LXfOeurcOQRWLdso/dB/d7iGTZ7m8d6h1BhSSBaHWYeeLwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493834; c=relaxed/simple;
	bh=OszhbkdMPupIjgX6yom83SUovUXe0uwBPDhBdYx0RxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbzLd7hsSJu6936Hi/LE5Gk7Lj34Kw6kt6ACv7ob6TlHWbfOhRKxpZzzWXdI82fVIlDbL7YKXNNNRpCI+dKkrU+AsIsKRVWT8Bze94LrZS68LIV/z6Q2aGLysFsOhcWXMGR8VZ+dJXZRsnF1xuK4eGNfhPIDGjDGZP/Kn14Tiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ucujOpHq; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-610cbca60cdso2749377eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 06 Aug 2025 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754493830; x=1755098630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXHVs/s25sxmyveilQOMZ/f0ZmdI0gCsYXlfGVaBTKE=;
        b=ucujOpHqII0Z6fNJ5FT4l8+Qe2kvfuK5RhHdwLGqsY8ZaWI0p8/X+grzJkVQubSf+E
         QRfPKvvnycGJhOD5x+s5787UUYvq+55bGZkpbKHpXjj6lRBbeUTvKB8NfACMjUtdmd/C
         w2P4AW2+VIqoS+fKlTpRggbRLTROJ12BYYutaoFaBZ7eclmAClEL2IcDO68TnqfDlrDL
         yr/qXaTe8gygbg300LvknLQW2F0cLdMyAl/bC2jgbgZALCS8UhyS/74TzNXm9xBwBfyY
         s5i4LUd6QI0kFwZaw8uqX00JxldTlXgbbhn7h/3j8fZY+/FlJyJ7lh8fn/dFhs3cnE0G
         6b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493830; x=1755098630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXHVs/s25sxmyveilQOMZ/f0ZmdI0gCsYXlfGVaBTKE=;
        b=ebMfmydona6+MM96+HSDsytxw+oseFp1XlMdUl7EGP+B8O3H+mKTyHiyoYLYdZDgNZ
         ednLq61KAndLvM6FJiNinH3PVY1E499DzRNDFl0t2b6QYJ2rRbwiIRltqC8S3wfbKcgF
         +vS3du1hTiX0bpUmrcivou2T2LKk2CNNH6sEpQNNspSJjDA8YD9AIkDosDDeY5jXU/D8
         yMDn0A+MlVrc03f2bI+7htmPnspcEKDmGKkB7xhbRHIK7GBUpYj4bMUtEraalHAs/pfq
         zav8klzbbniGBIEvdKxesU/Tzmvc0dEdcfZlmeZ2HGc+Lh99Oj0U/sIRI++zpIW6K1K2
         LetQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsVH/IpHX1D6jC7/5kVeDQzXNE9SL/qPpAhUI1UL8AADlrP7URk0kVJMuVDPBKtmEqqJACqv2ox5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmKwL4Qyf5f1okphZ/GYnndRmmyTWo4g29P1CHcqviQfLmbdfP
	uRAFroubB7H06ncklVXpn09r0qb0o0sdSmodRLM3n49Tv3XKEsugHhjwOOEOeyK2Twg=
X-Gm-Gg: ASbGncslqjZ9FlFZ3pVMUdZTxs8wSi6c0LSBlARBxJNNNswYIKk+tFLQait70VDf1N+
	dSOh0YZurDWlEDNa4lQQdT8VAPk04KJ7l573+p97ai7X7oDZN8hjpUFEjoZOBVJCQv99HyjYQro
	kjlWvwIh3mHrEZZ4i7mmIOMXiVC1p4nYIilvlrNzK0O5RZNouN3NfHeJ32CY+S76L1frSvSDPvM
	raCpzomHyxQuNs3ifCY0JmptOTnBR+NyDHqT5eS5SsBuQtVm/SgeyLGyxdvASGm2yGELl2Uysdw
	9QAgOvptcnhpwoDccko8uK2dxsIftHqr8ngdF6DK7YdZjhfIs7ppkHuaVU62N/vB6TMNh+pNtaB
	R8acVvclZdBwBCybSZPjXM6xTWKP5ZgsmPjcexIfjpP/GCR7bz5qzo0U/AmbQ9zyWaEvEfvNwsN
	Q=
X-Google-Smtp-Source: AGHT+IFRRNsxY9jM0PL1twblGzQQGuLGeS2INiCJOTVywPv49wcXz1VVskJdMLJuJJdCFjkXNsqYsQ==
X-Received: by 2002:a05:6820:1993:b0:619:7d9b:3f0b with SMTP id 006d021491bc7-61b60dfd7afmr2085950eaf.5.1754493830285;
        Wed, 06 Aug 2025 08:23:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-619bdc80b34sm1036807eaf.9.2025.08.06.08.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:23:49 -0700 (PDT)
Message-ID: <629801b8-a647-442b-83ba-6328ecf7a977@baylibre.com>
Date: Wed, 6 Aug 2025 10:23:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iio: adc: ad7476: Support ROHM BD79105
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 2:04 AM, Matti Vaittinen wrote:
> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
> 
> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
> conversion. Unlike with the ad7091 and ad7091r which also have a
> CONVSTART pin, the BD79105 requires that the pin must remain high also
> for the duration of the SPI access.
> 
> (*) Couple of words about the SPI. The BD79105 has pins named as
> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
> ISO.
> 
> DIN is a signal which can be used as a chip-select. When DIN is pulled
> low, the ADC will output the completed measurement via DOUT as SCLK is
> clocked. According to the data-sheet, the DIN can also be used for
> daisy-chaining multiple ADCs. Also, DOUT can be used also for a

Leave out one of the "also"s.

> 'data-ready' -IRQ. These modes aren't supported by this driver.
> 
> Support reading ADC scale and data from the BD79105 using SPI, when DIN
> is used as a chip-select.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/adc/ad7476.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 1f736be09663..fc98aadc4077 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -33,6 +33,7 @@ struct ad7476_chip_info {
>  	struct iio_chan_spec		convst_channel[2];
>  	void (*reset)(struct ad7476_state *);
>  	void (*conversion_pre_op)(struct ad7476_state *st);
> +	void (*conversion_post_op)(struct ad7476_state *st);
>  	bool				has_vref;
>  	bool				has_vdrive;
>  };
> @@ -64,6 +65,23 @@ static void ad7091_convst(struct ad7476_state *st)
>  	udelay(1); /* Conversion time: 650 ns max */
>  }
>  
> +static void bd79105_convst_disable(struct ad7476_state *st)
> +{
> +	if (!st->convst_gpio)
> +		return;
> +
> +	gpiod_set_value(st->convst_gpio, 0);
> +}
> +
> +static void bd79105_convst_enable(struct ad7476_state *st)
> +{
> +	if (!st->convst_gpio)
> +		return;
> +
> +	gpiod_set_value(st->convst_gpio, 1);
> +	udelay(1); /* 10ns required for conversion */

So ndelay(10)?

> +}
> +
>  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -81,6 +99,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
>  				    iio_get_time_ns(indio_dev));
>  done:
> +	if (st->chip_info->conversion_post_op)
> +		st->chip_info->conversion_post_op(st);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -278,6 +298,20 @@ static const struct ad7476_chip_info ltc2314_14_chip_info = {
>  	.has_vref = true,
>  };
>  
> +static const struct ad7476_chip_info bd79105_chip_info = {
> +	.convst_channel[0] = AD7091R_CONVST_CHAN(16),
> +	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	/*
> +	 * The BD79105 starts ADC data conversion when thw CONVSTART is set

s/thw/the/

Also s/CONVSTART/CONVSTART line/ would be a bit more clear.

> +	 * HIGH. The CONVSTART must be kept HIGH until the data has been
> +	 * read from the ADC.
> +	 */
> +	.conversion_pre_op = bd79105_convst_enable,
> +	.conversion_post_op = bd79105_convst_disable,
> +	.has_vref = true,
> +	.has_vdrive = true,
> +};
> +
>  static const struct iio_info ad7476_info = {
>  	.read_raw = &ad7476_read_raw,
>  };
> @@ -347,7 +381,6 @@ static int ad7476_probe(struct spi_device *spi)
>  	if (st->convst_gpio)
>  		indio_dev->channels = st->chip_info->convst_channel;
>  	/* Setup default message */
> -

Random whitespace change.

>  	st->xfer.rx_buf = &st->data;
>  	st->xfer.len = indio_dev->channels[0].scan_type.storagebits / 8;
>  
> @@ -393,6 +426,7 @@ static const struct spi_device_id ad7476_id[] = {
>  	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
>  	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
>  	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
> +	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
>  	/*
>  	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
>  	 * point of view. The binding document mandates the ADS7866 to be

Unrelated to this patch, but interesting that we don't also have
an of_ lookup table.


