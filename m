Return-Path: <linux-iio+bounces-22399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A91B1D86D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 15:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391633AC7D2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C224728B;
	Thu,  7 Aug 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyQtO/qQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CA23370A;
	Thu,  7 Aug 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571654; cv=none; b=XL9LZQl5psh6twiLM57XrWMV9ar5C2U6hm1Y8XH60xdTIT9OMpMuuDfBCQJkzObmQHp0lX7sqYYuc2R6Q9B7UvRW7WloLWdWDSvIFroDrx52Fae75D6rz2x0Qw9hNoOp2KTHsfqZ8FudG2SUhbMa8p15uc/VTjvDP1/BkzxSJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571654; c=relaxed/simple;
	bh=nFcaeaKVS0AO7LrWVY2jVfxQPyLgyvv9NluXeQDw9tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beI65Tv9bjxt5E4PkVTqo+owC2sLvKCBNQxW7qYJ7LYQss4w6k3tjwC+kMglHHfAOoLSgj96X32jLTZHmTcYA/dGasYOcb6w9mvdAHCgmE7vejp+wzdjS8a6fSC8OC9gxtsIYX7VkmczpLlScMI9onuYakk/S2TXNusm4664Bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyQtO/qQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso9695535e9.2;
        Thu, 07 Aug 2025 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754571651; x=1755176451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oWyKyzo15zN/yE/f1U3mSjYAQVXp/FLoWBvvAYxOQ+w=;
        b=IyQtO/qQ1xpuQcN0S0e0uLwNf7X1aSpXLiUfIpfKi+PhS0DLKcavIXD4ouuHS1uWRq
         vvLCvE2vL4ut8+dR3f4iD/sph9UmO1ptXTfp+PXTokV8M0P86MFh5KkM2hHMiKNf2TI7
         mWM0x1zqmOKf4vQJgIMo0EniHy09y7wwrJkhFU/bpOCHENqh1fzoBv5CpQPLwsBItOO7
         3jAr7Rzgs3O/C2cvZbN9OcWdIJVyE+Enm0W71o8hKWJu5Z6GdOBq87x2kTeEFMZOByOP
         BZnruNixxuVu0mvYSOiM/nD2mp8DudrA4b8s4NMUrmMcaxLpxsICSuXmNAnUZ1DiN8eN
         8rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754571651; x=1755176451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWyKyzo15zN/yE/f1U3mSjYAQVXp/FLoWBvvAYxOQ+w=;
        b=D8x1qggIlErF9qJo4EWC4nKv/M1uy8Ii+v8zmmBpDANBgDiqVO1oXuC3FXz4Jb79WP
         s8mAlb+Vtdw2fnG4DSXNPGmFAPmG+kv4qYad9phudvk9IOz3tHS9iUzHJ7CyJk0+AaG1
         ujafSUKP6H8RLqVW8QTXhzSC1dDByyBX0uBSY8gaDvHsfcblPsQIYZwaQu1Eql205UFm
         mc/Ux7uhQMF/tlYQBYac5/QlbeUuRvnK6R9NOq+XnQPH3pua6ayurj8b3/sGZVPtigVo
         51fH05TKP457keghWkfbaspRYWzDi/B5Z3i7ovdGRh/G4uwzYVTAzV3aDs2kYWY0RSQm
         nzcw==
X-Forwarded-Encrypted: i=1; AJvYcCVCaLi9xP65zZIZWUxkXMfsN75TxUqoRJCDsqZlmOXPxRzZNQe617fjF2FwKvoZGqLYHJL/uHUniLfW@vger.kernel.org, AJvYcCWeCxwJt3CeSbyM5I4cVgGKtPLdv7ZHaHOGYu7qQD1lwzEaHZZtYFN1V7vkAKuUvz0979GPzuA3y1a0hcLi@vger.kernel.org, AJvYcCXO7o439PI5MCyqgqYt68LTg/2hRdZxG1vjUFYAybhpw8W41P9nscROwxww/YLbq6H5V+lOfvAKEiEl@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwDYGbN6o26xwhbyLjxsAJidyYr20BPF1s6hg332g3WcHQz1v
	WzTkQFKFVWgUz9LIhFYPG2MVTFlJkveLtmMj7qBPmhIMTxuX6ZvZCwdt
X-Gm-Gg: ASbGnct7x6bB/8PUmlA/956ZHqVxZnCxH9OT57D5olEXK4sdKQ+ouDyLKE6FemJdEhP
	rSvsIFDhIc2SvXOsPoFVxvTt6x3fJ+GUG+E/s9Tr33D8XEOf6mdcxB66+/3jdp4I16M8qIke5m1
	p4eRJRe5wezqTTBEVMSm03Ndizbl9wqPLcxvVhUAeV1ZnrdMSNyCTE0TuyAIC71lJfIRF+R1oer
	445oweSSYOLda6ZHKd3Gwcbf/+ilOCNdg9ZgSoqjFQByYiC0vqYr0afLggHq+NfyyIGVxzSb5/w
	iwSNOenpJhbVCH8S3FVELu9j+MQAwEK3KLO5wUpyojHAevVXrzGLVl1zYZWcG7V2iIOk4tT+dMg
	U7k9JLb7X50s=
X-Google-Smtp-Source: AGHT+IECiMu14Kge5tpzvxrNSfYPftUEs+HWRA3ya6lF4fU/24hZChE8lcrKJWhMqEDbVTgpTyT9pg==
X-Received: by 2002:a05:600c:3ba3:b0:459:e200:67e0 with SMTP id 5b1f17b1804b1-459f33bb3b2mr10748955e9.10.1754571650603;
        Thu, 07 Aug 2025 06:00:50 -0700 (PDT)
Received: from nsa ([185.128.9.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5887b7fsm91562325e9.30.2025.08.07.06.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:00:50 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:01:06 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <stmpyitqnjst2l26xdlkfqdedczpnxhoydges7xumtl5e46pof@cyidmsvdtdnj>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>

On Thu, Aug 07, 2025 at 12:35:25PM +0300, Matti Vaittinen wrote:
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
> daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
> 'data-ready' -IRQ. These modes aren't supported by this driver.
> 
> Support reading ADC scale and data from the BD79105 using SPI, when DIN
> is used as a chip-select.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
>  v1 => v2:
>  - Fix the conversion delay for the BD79105
>  - Drop unnecessary GPIO check from the convstart disable
>  - Drop unintended whitespace change
>  - Fix spelling
> ---

IIUC, for this chip the CONV GPIO is actually mandatory no? If so, we
should likely fail probe in case there's no GPIO. And we could also change
the dt bindings accordingly.

Some more comments inline... 
>  drivers/iio/adc/ad7476.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 8914861802be..aa8a522633eb 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -31,6 +31,7 @@ struct ad7476_chip_info {
>  	struct iio_chan_spec		channel[2];
>  	void (*reset)(struct ad7476_state *);
>  	void (*conversion_pre_op)(struct ad7476_state *st);
> +	void (*conversion_post_op)(struct ad7476_state *st);
>  	bool				has_vref;
>  	bool				has_vdrive;
>  };
> @@ -39,6 +40,7 @@ struct ad7476_state {
>  	struct spi_device		*spi;
>  	struct gpio_desc		*convst_gpio;
>  	void (*conversion_pre_op)(struct ad7476_state *st);
> +	void (*conversion_post_op)(struct ad7476_state *st);

Pointer duplication again :)

>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
>  	struct iio_chan_spec		channel[2];
> @@ -63,6 +65,21 @@ static void ad7091_convst(struct ad7476_state *st)
>  	udelay(1); /* Conversion time: 650 ns max */
>  }
>  
> +static void bd79105_convst_disable(struct ad7476_state *st)
> +{
> +	gpiod_set_value(st->convst_gpio, 0);
> +}
> +
> +static void bd79105_convst_enable(struct ad7476_state *st)
> +{
> +	if (!st->convst_gpio)
> +		return;

I think the pattern for optional GPIOs is to just call
gpiod_set_value_*() and the lib handles NULL pointers. Also the above is
not coeherent with bd79105_convst_disable().

> +
> +	gpiod_set_value(st->convst_gpio, 1);

gpiod_set_value_cansleep()? I do see the driver is calling the same API
in other places but I do not see a reason for it... So, precursor patch?

- Nuno Sá

> +	/* Worst case, 2790 nS required for conversion */
> +	ndelay(2790);
> +}
> +
>  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -80,6 +97,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
>  				    iio_get_time_ns(indio_dev));
>  done:
> +	if (st->conversion_post_op)
> +		st->conversion_post_op(st);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -271,6 +290,20 @@ static const struct ad7476_chip_info ltc2314_14_chip_info = {
>  	.has_vref = true,
>  };
>  
> +static const struct ad7476_chip_info bd79105_chip_info = {
> +	.channel[0] = AD7091R_CHAN(16),
> +	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	/*
> +	 * The BD79105 starts ADC data conversion when the CONVSTART line is
> +	 * set HIGH. The CONVSTART must be kept HIGH until the data has been
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
> @@ -325,6 +358,7 @@ static int ad7476_probe(struct spi_device *spi)
>  	}
>  
>  	st->conversion_pre_op = chip_info->conversion_pre_op;
> +	st->conversion_post_op = chip_info->conversion_post_op;
>  	st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
>  						  "adi,conversion-start",
>  						  GPIOD_OUT_LOW);
> @@ -400,6 +434,7 @@ static const struct spi_device_id ad7476_id[] = {
>  	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
>  	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
>  	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
> +	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
>  	/*
>  	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
>  	 * point of view. The binding document mandates the ADS7866 to be
> -- 
> 2.50.1
> 



