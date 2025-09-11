Return-Path: <linux-iio+bounces-23993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A37DB53D9B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982305A6E52
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B92DE709;
	Thu, 11 Sep 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fJtlTnQx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8D228C9D
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625656; cv=none; b=AiXg0Xd30dCraQgKaFud3YKNkVEX1RdNs2Fja3fSA0C7SvboCvJg5RjFR2WKt7INknuhncZ5vENigmorTtwvFPcJjf08DYywMhGmbRLi/h90JHKNGGytPEAOg3DedxGIajk7n33OWZLJ12feZ24fQk04v0lR1bWbzOGWFe/LQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625656; c=relaxed/simple;
	bh=/qbqklOy73Xy205h9CiRY2qnxrIANAuJGQ6ZqXMNk3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN0qngdYJMarQbSTHdoqghZo2Jg4B+R7f3zoDHb+3WvR6zHCtPpDmG6fQQV7r2ppiVqe00ID/udya9l1Cj2EW4MdK7EWTmVDUmuPfHn94dloqxuud7Clc9CiWysnfXnR/bdHqBCrtJ28YOmOhkZXTPHTQndgjhEcjL7Jz9x4NqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fJtlTnQx; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43b61050500so4794b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757625653; x=1758230453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Xdz7g9XJCi94PW1u7R25e+prar+7bf8nt1qt2s44Ts=;
        b=fJtlTnQx+tCkgTeyaqjf96obb1M2sYcjGcX5aIcWXGTpeaTXHLF9IZncZjkkH9x2Nj
         viOQwrZnCAOpbc+/OoNfuRdRBjpuClf/t4Z2nvRRsxDRBh2FP3PGdbU91NExOcx1ExZu
         PiKH5lwRca/PdiJwMA3QGg4quXpf9Cj5nKoqUe/YVfrl1M13v7I8M0/0qCqKH4ujnwKb
         gsDGUjiINsajfAbMlXbgnkx7cB3or0urFE50JoyaYapeoZwR1JdRHPX3TBFrQsMPR2nX
         zaKSE8tWsXVudCMQ0WoxtEuMA311RMH/mO69p7m01I5RrakHioobfQegeKojUIsTNcJR
         1I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757625653; x=1758230453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xdz7g9XJCi94PW1u7R25e+prar+7bf8nt1qt2s44Ts=;
        b=JTf4XJnLFFlb1mE2XM1hFTJ/LnfmC8lPpVXTL6TDYPNX5rF3xl59ylAzOA3zBPXOPC
         DrOb7lMBsU0d7pZfrgDO06F7bPFkUnZP+OHfamIgP5+iFWsaw+0hbVg9zEZ6TinzIOoE
         /BwMcpd85f1oTEqc1xxGcBxLm67d/8d0oUEP5grxzah+Yqvrl+KYzchAKOkyR+Bo1Cd0
         QUpf1SUdUucJuodR3aP08Be+AEj4WolB5ejzwgwspn4TbzlTDtsLikU59BfPvdHCAvDj
         re8iuWFndfmhoH75a5cPaPDJdiHcCW26fXVhhhRjlDlihnp8pRfEpyWoAmk/AZFU1XS4
         +abA==
X-Gm-Message-State: AOJu0YyvFQb4HtGdQi+x2dkL3cnnilwI6iC1fj9aVoOkBBkIUFO5z2tS
	m9Lgu3sXQoU2+mDakUogf/NKo46dZzF/gBar7JQjZALiCIMjTdILSAscFrY5sujf8c0=
X-Gm-Gg: ASbGncvL07fH8jYK98tVyMPdT2l8uGKOeTzB4ZT5C0zZsPm9IOKPYuoWTBm4twW1Pc3
	Wx9kk/z6jGD20G2mziYEzEZuB/GRxXUYYfeME73lS7b5CYH7OzUKjBQbl7ZtEx+y9B3KeUFjUb4
	iXx5i9mqnMDfJye+awlE7r1ZFictqHK0Z6Msp+JWVmNdFzT5kfGNvDqIYOvo6mUlEaOVXxQVDO6
	MLjh30u/L3oYlW0IQtnX61eHsQOYmV1b7v6+i8lfEw9OJSQEC38CHIZgENt3LIDWMGMpEFGivmI
	q4N8BdRuFHmdnjZVFG/pLYzI0yughidT32hoPhaWsqwlve8gvgS/xlCKcWP7WWFBk9LuIZvXkn8
	XmlRPzNBZW8Q4EAZJ33CBu8URW5pksXXLC8VUQaeibRyWPuiGf65h4at+CMqiwm6MF7E9r4c709
	8=
X-Google-Smtp-Source: AGHT+IEfEi9Sgc3MO/DgYcQbM9cS1aO0i6OLl4q1kcdgGhUYaznl1ArLjqw2SU9iu7Litt3zO5owUA==
X-Received: by 2002:a05:6808:1384:b0:43b:35de:29c5 with SMTP id 5614622812f47-43b8da0bd91mr288002b6e.30.1757625652844;
        Thu, 11 Sep 2025 14:20:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82abd2d5sm441365b6e.26.2025.09.11.14.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 14:20:51 -0700 (PDT)
Message-ID: <92306c8a-a2ec-4a43-80d7-c8e0c1cc0ee1@baylibre.com>
Date: Thu, 11 Sep 2025 16:20:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
 <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 6:24 AM, Matti Vaittinen wrote:

...

> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a2a3affe2c6dc86a237a164139c27ec66dc9d131
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79112.c
> @@ -0,0 +1,553 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ROHM ADC driver for BD79112 signal monitoring hub.
> + * Copyright (C) 2025, ROHM Semiconductor.
> + *
> + * SPI communication derived from ad7923.c and ti-ads7950.c

Really? I wrote the ti-ads7950 driver and I can't say I see the
resemblance. ;-)

> + */
> +

...

> +static int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)

u32 would make more sense when dealing with bit flags.

> +{
> +	int i, gpio_channels;

same for the local variable.

...

> +static int bd79112_probe(struct spi_device *spi)
> +{

...

> +
> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
> +	data->read_xfer[0].len = sizeof(data->read_tx);
> +	data->read_xfer[0].cs_change = 1;
> +	data->read_xfer[1].rx_buf = &data->read_rx;
> +	data->read_xfer[1].len = sizeof(data->read_rx);
> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
> +
> +	data->write_xfer.tx_buf = &data->reg_write_tx[0];
> +	data->write_xfer.len = sizeof(data->reg_write_tx);
> +	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);

If these messages never change (other than the data in the buffers), you can
call devm_spi_optimize_message() here on each message to get reduced CPU usage
on every SPI message for free.


