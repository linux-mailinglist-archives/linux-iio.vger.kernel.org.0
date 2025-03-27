Return-Path: <linux-iio+bounces-17286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E71A73669
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED1A188A86E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1FC19F11F;
	Thu, 27 Mar 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xtc2u7vF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE31946C8
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091934; cv=none; b=lKfstPhZfrz1RgzMnC716n2BZNJXr47L7Zv4YsHb2nIRGD+CR9oHjYOs8kUncSRxuxX5eATN01TP+Ylau61YI3pEQfCjwwkF+TiqrcpRkvuywiZfGHkD4TIrIk6LRXa4fS5MKrl0qk0lDSmJqysRLcurj9S4/ugBmPatP27+694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091934; c=relaxed/simple;
	bh=0SQScDqEeMbzQnwpiKKIFG9Vk68To6MbYwSHP1HvL3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0T8/1PFRONqOjIvtLUYUTwNTy+BC/lCej04jvxT1/YbrLVqoMPUSX8WTo1g/RSnhTcR48NrxrvJHB3n/W36TGZ4U5vRSHOhRfHazngHm0mVKoQ+yVuAVqm4QIM09oLrrvRBafEVMxBtsxyvtShFnjSgsa3AjCdWssTbScg6huM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xtc2u7vF; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72bceb93f2fso1260562a34.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743091931; x=1743696731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unBVHfPgws2ZkgWdON6HD2DMgITftuEecvFOlYQpcdY=;
        b=Xtc2u7vFHOb37SBR0T56eXgaf+/sBptQ9j+ezC78qT4beeRDX1s5a99Pav5/IFOVBe
         zh+cmNHwkoJbqknMt2phTjCQAgdKXYg7oQD9yVQaBMGksO4gQRni4eoC+2+y31Avno0D
         FM+iignRE1pU5Icvw9MJNEi1dda1m3Ym2NDMxZU+ZkKuBmDghffnTxHieH3X9L1CULOO
         wsgOwR/fneDpF/znALSo16vdZ2TeS0+USX2TO/eBrHmjIGXTxwrxVH+WyESKdw31A+ox
         C4jfrdGNO4NwI7Tiq8Ty1e8GCADV6wP4P9ZXXZi88rRnpNt+oH4aQvbEiYDiq0hibaO4
         nePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743091931; x=1743696731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unBVHfPgws2ZkgWdON6HD2DMgITftuEecvFOlYQpcdY=;
        b=aJvQYuCmrvEx+WMINsTpXbhUZZBLPHDXowwLoCFQ6vOAzUYEY08Kai1SHMiY6xPo7h
         Z8fcM80OOfJgISlmZj268tXkjzFnv4H9h4+APciuVWwyh7f2Atpjw8eD5ARp2RjZOI+v
         VcNjHInkPmvEeuZTxK6K5S7iNClHnzGpzzsiyvj5QleaR0PST+QsPw9zwRyIOP1gBmc4
         mov5a4OOYhULBhJHhHOT4LMhPtMBML/jWQYg71J1zSkpRsCOjYZjhMupNFLMWeRxcivh
         yRSd6sgy+S+LS4xbPAAd+CB3zAwVDgkpqDD+B2/Owp1TQPpC3MerxWT3bMaABbXvyPPR
         46+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2rkEiD76akf3Zoye0ecZWwxIDMDyqjGOKn5BI0tjy0P9E7tbXwOyJLdo0duDWW3WSX3epNZk4LJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrU1VSfixxH762U0u1a5EY6UAe1ajNzZ1VDog2EjaWti5zuNEx
	Ia9xK9sBaCQYukIBCZUEfmUX2+cGH+6DzM7W5btrG6DrV3XCJh2/HsBkZmXK2BA=
X-Gm-Gg: ASbGncs7IbmahlOn4sf+cwg8TfhayEILY2VW6AUVqliWijvImOknN6+m3mLdHM4dHXk
	JhT5VaCp+3gpZEsdxANjy01e0jd4Xj/VODbq2SVECnRs8XdXFNJBBz4Psv12JEo8Qr84iFZmMYo
	W/wIL+WIJxYO+NQwEJtcWCB5UgqtjG4+gH1wcfaeQx+YvHOImHarmuiKjDbf+Zzy0WxHwWMfD9I
	muFrEpI0pup11lWM78NdIWSwV7yI1VMvwbk2IsSQ6FUlYsN6KtgNWgQxpXsSXepjicEuwyIsymr
	qhkF9/0ops2R8S48emeBoNUv8seNtO1XoCOJTb86sNysJPNFAPCbl/K1EIrc3aXDSI1gn0NBp8n
	vOMdprg==
X-Google-Smtp-Source: AGHT+IEByi/X8WFBEGBZrgq4UEw/KyKlyq98XRQT7qQm4oHe4x24ITtjZpAD1WQiKg8vcaO17wnr9A==
X-Received: by 2002:a05:6808:3c46:b0:3f6:ab0d:8db1 with SMTP id 5614622812f47-3ff032dcf36mr751735b6e.3.1743091930689;
        Thu, 27 Mar 2025 09:12:10 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf5e4c32sm2826363b6e.0.2025.03.27.09.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 09:12:09 -0700 (PDT)
Message-ID: <35f4d22a-e478-4a43-bbb6-f9d34ce1f888@baylibre.com>
Date: Thu, 27 Mar 2025 11:12:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iio: adc: ad4000: Add support for SPI offload
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
 <d67e71b9fab270d16b6b5e26a3594dfc73be1ae5.1742992305.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d67e71b9fab270d16b6b5e26a3594dfc73be1ae5.1742992305.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 8:24 AM, Marcelo Schmitt wrote:
> FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> SPI-Engine to execute transfers to poll data from the ADC. That allows data
> to be read at the maximum sample rates. Also, it is possible to set a
> specific sample rate by setting the proper PWM duty cycle and related state
> parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> trigger) is used in combination with SPI-Engine.
> 
> Add support for SPI offload.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

...

> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 4fe8dee48da9..9fc56853265e 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -16,11 +16,13 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>

Alphabetical order?

>  #include <linux/units.h>
>  #include <linux/util_macros.h>
>  #include <linux/iio/iio.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  

...

>  
> +/*
> + * When SPI offload is configured, transfers are executed withouth CPU

s/withouth/without/

> + * intervention so no soft timestamp can be recorded when transfers run.
> + * Because of that, the macros that set timestamp channel are only used when
> + * transfers are not offloaded.
> + */

...

> @@ -784,7 +1081,10 @@ static int ad4000_probe(struct spi_device *spi)
>  	switch (st->sdi_pin) {
>  	case AD4000_SDI_MOSI:
>  		indio_dev->info = &ad4000_reg_access_info;
> -		indio_dev->channels = chip->reg_access_chan_spec;
> +
> +		/* Set CNV/CS high time for when turbo mode is used */
> +		spi->cs_inactive.value = st->time_spec->t_quiet1_ns;
> +		spi->cs_inactive.unit = SPI_DELAY_UNIT_NSECS;

This code path later calls ad4000_prepare_3wire_mode_message() which sets:

	xfers[0].cs_change_delay.value = st->time_spec->t_conv_ns;

Which contradicts/overrides this.

>  
>  		/*
>  		 * In "3-wire mode", the ADC SDI line must be kept high when
> @@ -796,9 +1096,26 @@ static int ad4000_probe(struct spi_device *spi)
>  		if (ret < 0)
>  			return ret;
>  
> +		if (st->using_offload) {
> +			indio_dev->channels = &chip->reg_access_offload_chan_spec;
> +			indio_dev->num_channels = 1;
> +			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to optimize SPI msg\n");
> +		} else {
> +			indio_dev->channels = chip->reg_access_chan_spec;
> +			indio_dev->num_channels = ARRAY_SIZE(chip->reg_access_chan_spec);
> +		}
> +
> +		/*
> +		 * Call ad4000_prepare_3wire_mode_message() so single-shot read
> +		 * SPI messages are always initialized.
> +		 */
>  		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret,
> +					     "Failed to optimize SPI msg\n");
>  
>  		ret = ad4000_config(st);
>  		if (ret < 0)
> @@ -806,19 +1123,47 @@ static int ad4000_probe(struct spi_device *spi)
>  
>  		break;
>  	case AD4000_SDI_VIO:
> -		indio_dev->info = &ad4000_info;
> -		indio_dev->channels = chip->chan_spec;
> +		if (st->using_offload) {
> +			indio_dev->info = &ad4000_offload_info;
> +			indio_dev->channels = &chip->offload_chan_spec;
> +			indio_dev->num_channels = 1;
> +
> +			/* Set CNV/CS high time for when turbo mode is not used */
> +			if (!st->cnv_gpio) {
> +				spi->cs_inactive.value = st->time_spec->t_conv_ns;
> +				spi->cs_inactive.unit = SPI_DELAY_UNIT_NSECS;

I'm still not sold on this. We know it has no effect with AXI SPI Engine and
it is writing over something that usually comes from DT. It is misleading.

And the non-offload case already does:

	xfers[0].cs_change_delay.value = st->time_spec->t_conv_ns;

which actually does work with the AXI SPI Engine. So why not be consistent and
do it the same way for the offload case?

It also seems safe to omit this altogether in the offload case and assume that
the max sample rate will also ensure that the miniumum time for CS deasserted
is respected.

> +				ret = spi_setup(spi);
> +				if (ret < 0)
> +					return ret;
> +			}
> +
> +			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to optimize SPI msg\n");
> +		} else {
> +			indio_dev->info = &ad4000_info;
> +			indio_dev->channels = chip->chan_spec;
> +			indio_dev->num_channels = ARRAY_SIZE(chip->chan_spec);
> +		}
> +
>  		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret,
> +					     "Failed to optimize SPI msg\n");
>  
>  		break;

