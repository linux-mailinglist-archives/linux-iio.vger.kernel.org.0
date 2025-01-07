Return-Path: <linux-iio+bounces-14011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52897A04DD6
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5105E7A14DC
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918ED1F4E47;
	Tue,  7 Jan 2025 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xnG8v/TO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F11DF27C
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293749; cv=none; b=sLyNgwSeKbeEhzyzycoZ9ujWsCF7bL17ecJSSXWSN5V/nnIu0zIDOTp8iLtCgocsJ43/tp38PeMtD701YbaOARKxFNHiKY20jcGJNqjQhRCuAhwIv/B1R9xN4IvkK1V3VPzlCUguM25360ek2M1VXRlT40sapS2WGij6GcfOi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293749; c=relaxed/simple;
	bh=mvHARXc3GDUGNhpz8rTz4zHERBmLO2sCudSA/NxaUQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odv46j98qNWr31itxFLq5NTUnT9h3t1jjUtoX9IsevxVHc00Cf+zRLPnMXWuYyTw/88LtzCRA9+m82FHy5/7EEvzp7HL52t8JLwTfukw1EIAsEJV9DyWZSmrpulZ7bJFo9GVnkXNi9motLC7xGTQebX6Z4625e9lW+ofGmiCNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xnG8v/TO; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e1d7130a5so7937442a34.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293746; x=1736898546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qmhz9rXGJRvv4TjmEevXNY2EST1xicauOHa37fPV2o=;
        b=xnG8v/TOuoil4jiTGRrdGoY69UQXd4qGAYZ8LHfVGVeG7+w9eo3TC9ZJzdaVuv6lqH
         ojn9JaDzxq2xn5dHoCwJ8y0fJHJNJEySlYw8lv8BBTaQ2krk2Zgj5ZU65OkqI/zdgLMS
         gDj5w7c6l9AL83qwI79zutkmw6sO+8zD3JshgIaHEPjcwf6+Rcm1S14PS+v2F97fC1l7
         NJ8qa9cgVIiRIqV/J9hz3f8RfP47A4VJm46xuvRvKMSczfDbdW+gFJn8QrNA1JktPzDt
         qReQhFaGINHeP6pYFg6e0Uk0xJRa3IZNNu/VlA47qA2kS3P7iWMY9rw5j6RD2s8DP5eg
         ZCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293746; x=1736898546;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qmhz9rXGJRvv4TjmEevXNY2EST1xicauOHa37fPV2o=;
        b=L1vbaXSRP1CVXs4nTwQFk1faOFF97KrLlvASZslqwatc9rAjBLxBlOUIach6wZhv4E
         v9UJvv2hLcuN3XkrxhcbBHLywXntqMCitWacY3xjZNdfCnbiW80xk+eUaz4/+RyZtSyW
         r6G6jyryByHyH7TL9OE0/45TcdbRi9p2jpfp2DujSeLYSHut3eiul8LKZxTBqBmJo1+l
         uwu1iUHJSX5rLMnxNuQgg7BL0JxeXzjQjYp3xjcNX/db5pVdz+45AnZFaJqMFEkAnmUq
         o3LPqsJ9Zr6EQfR5Ek1xSJq0D75F7AHDfuPfYDBd19l2+D+Y5SufQo4wgsDz/aaf8WD+
         yNyg==
X-Forwarded-Encrypted: i=1; AJvYcCUcz4lvgAFh02CX/3gWJApa9UR1SKBTOULAvLmfZtXFPQnM5LtS35mG/Mv7WsXld6IS1SjBR0Co6N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVu9zdIuZW3C1aA0Syue+2robo+d/FsMbUpA104gCSP6H8KcDW
	EvR24Q2dWhbCo2OqeWnIyEu1jDgndwwojvUSQP+ISzzhj+yNYuvteRk4R+5nmT4=
X-Gm-Gg: ASbGnctVGz1M8wMYv7MBQ6eF8Hib5ES1/VKc660JlblNlI93xrNzU5D34rI9+aCkgCL
	uRKVBNx/zjs66OMK+7tH7qp1rgFxhjPA4exV6L4XDG9EiNPOmSiGG7BtsLeGy/bij48gZK/T+Nz
	gEqzKzRlXSTkS5kPDYu7bH/oVNfphEAnRXQhQCl5pjopx86SZtLjjHkkMDG3EJqC3ZU4f+okIpX
	U8MccdcFQJgZxhmbZ2Tewu0k5QwqSAZTvgrPF1wo8cdHnP27J6QjVIAGmGHslizuUelzWc1qckV
	5+n9SouWfM3fKCWI3g==
X-Google-Smtp-Source: AGHT+IGhiuxK73k8+Xg6kLGz1fPBR7ULZkj3SANDyA04PnNN9nhkAKZmu77LCGftZK5qFB1vEWr/2Q==
X-Received: by 2002:a05:6830:2b0c:b0:71e:1aef:72b5 with SMTP id 46e09a7af769-721e2f248dfmr376628a34.27.1736293746268;
        Tue, 07 Jan 2025 15:49:06 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f4db36fc94sm9951751eaf.9.2025.01.07.15.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:49:04 -0800 (PST)
Message-ID: <111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com>
Date: Tue, 7 Jan 2025 17:49:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/15] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <170c5ca1b6c45b2114f248d9085588572d6269b4.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <170c5ca1b6c45b2114f248d9085588572d6269b4.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:26 AM, Jonathan Santos wrote:
> When the device is configured to Sinc5 filter and decimation x8,
> output data is reduced to 16-bits in order to support 1 MHz of
> sampling frequency due to clock limitation.

We aren't going to get a 1 MHz sample rate without SPI offload support so maybe
we should save this patch until then?

In this patch, we are still reading 24-bits per sample, so we aren't really
getting any benefit. It is probably fine for now to leave it as 24-bit even if
the last 8 bits are all 0 or just noise.

Also, the datasheet says:

	this path allows viewing of wider bandwidth; however, it is quantization
	noise limited so that output data is reduced to 16 bits

So this doesn't actually seem related to higher sample rates. There is a CONVLEN
bit in the INTERFACE_FORMAT register that globally reduces the output size to
16-bit, which I suspect would be what we will need for achieving the highest
sample rate when we add SPI offload support.

> 
> Use multiple scan types feature to enable the driver to switch
> scan type in runtime, making possible to support both 24-bit and
> 16-bit resolution.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 65 ++++++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 9741a6d47942..5e4e7d387f9a 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -134,6 +134,11 @@ struct ad7768_clk_configuration {
>  	enum ad7768_pwrmode pwrmode;
>  };
>  
> +enum ad7768_scan_type {
> +	AD7768_SCAN_TYPE_NORMAL,
> +	AD7768_SCAN_TYPE_HIGH_SPEED,
> +};
> +
>  static const char * const ad7768_vcm_modes[] = {
>  	"(AVDD1-AVSS)/2",
>  	"2V5",
> @@ -145,6 +150,10 @@ static const char * const ad7768_vcm_modes[] = {
>  	"OFF",
>  };
>  
> +static const int ad7768_mclk_div_rates[4] = {
> +	16, 8, 4, 2,
> +};
> +
>  static const struct ad7768_clk_configuration ad7768_clk_config[] = {
>  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
>  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
> @@ -159,6 +168,21 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
>  	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
>  };
>  
> +static const struct iio_scan_type ad7768_scan_type[] = {
> +	[AD7768_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.realbits = 24,
> +		.storagebits = 32,

What happened to .shift = 8, ? If there is a reason for removing it, please add
that to the commit description.

> +		.endianness = IIO_BE,
> +	},
> +	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 32,

I guess it doesn't matter much since we are reading one sample at a time, but
I would expect storagebits to be 16 instead of 32. Or if it really needs to be
32, does it need shift = 16?

> +		.endianness = IIO_BE,
> +	},
> +};
> +
>  static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan);
>  static int ad7768_set_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan,
>  			  unsigned int mode);

...

> @@ -308,6 +329,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
>  	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, &readval, 3);
>  	if (ret < 0)
>  		return ret;
> +
> +	/*
> +	 * When the decimation rate is set to x8, the ADC data precision is reduced
> +	 * from 24 bits to 16 bits. Since the AD7768_REG_ADC_DATA register provides
> +	 * 24-bit data, the precision is reduced by right-shifting the read value
> +	 * by 8 bits.
> +	 */
> +	if (st->dec_rate == 8)
> +		readval = readval >> 8;

Why not change size of ad7768_spi_reg_read() instead of reading 3 bytes and
throwing one away?

>  	/*
>  	 * Any SPI configuration of the AD7768-1 can only be
>  	 * performed in continuous conversion mode.

