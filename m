Return-Path: <linux-iio+bounces-14930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A23A25EA7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A9F7A1B49
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2320967A;
	Mon,  3 Feb 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yah0lpYk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA503595E;
	Mon,  3 Feb 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596475; cv=none; b=A/T0IrBplKnQXlXFUEp536qHWo/PaE5xeMyTfCBUIjYsf4l6jCFHrYAf783fAfZ0nbgpp+Gxj06mFZ1Z9yGZ8Z7uuLgfwph3JOQhmPp3uqp17etuj7+0mJUUYTqAtr5vI6TI6iNPNv9gpLBBj404z6H4wQJ6tS7S1G9PEdBz/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596475; c=relaxed/simple;
	bh=JTBxX0dat01a9U3ZHZbxuyA3ju8loUiSY7T5tw/yGMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGeDqI33CLwsfyCjti516zqVg3zIMi5CsaFDpO5xAYAua34eMSieuyvcdFIJ80pQd9suIojcoCJwcocGIA/sgd9Ndih7aYikgyEsPwRF1heLVU5zbpsBBp4e/7ROkTzZgY28DiegwbcLWjiOVFJEerJTx6RBIJeah/U2/lHtFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yah0lpYk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166f1e589cso11180275ad.3;
        Mon, 03 Feb 2025 07:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738596472; x=1739201272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xInHEYQYfUJmgEgNS9xBAKboi++StzaQOj0FmuTE31c=;
        b=Yah0lpYkVn5eEuKHg0T9IYBZyneaUiRezPJRp6XGlpRzM4TDhq9BsnIXSVs0h68ptr
         u2lDI/4V/WuU1wazuPdv/bj69O14Ryuf2Oi8Da8TSo9NlRAuCNYUFRBcpWBNwjvfXiKe
         maV4fJ05PJCEFM0JRIhA/Og0n926X5vgp3lv+FwzEcRXU1Lec34ty6oz+WrFdG47ZMa7
         jVg12MdTWGwVBVfYvY14VgGejctOxlL1zSklrjZCPtqLnpxG4YKABRFi00AqnApQ/zy4
         UiF6Tb91l10q2UF0CHmj7Vdj4GXL63PBMXVNfJ7WMl0cdH8GZoAFx36pD0rH0Yiq07dA
         F/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738596472; x=1739201272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xInHEYQYfUJmgEgNS9xBAKboi++StzaQOj0FmuTE31c=;
        b=qb/xGmB+VfIYA2gDQAUIyMwu6hw5hCvMF9/gBWAQAhiAwSfhIWbFEnPcUQsT0+aS1W
         mFah5uNTQ2ep7aH+T6TiOjpdw2/KlpR3myvyV8Zz7QV1Zo6WJSiufsqOZgJ4K8bmtmlR
         2lpQBYolqtu2Mb4LGiLB5wEZltLY03NBukyCek+QGQa3XikHN7he/WFyQD6x+UFgn7Q9
         hJQ9UhyB5+4a4wvrwg+fDJZHTeBOXDfLJX8e1MmtdcEl+qqXhHWE/KPPVSPN6JN2iSzm
         BMEF4SOOEBLjgYuB0LoPlHRI/OH2GGpI/AHozWSuN8I2JNuF9yKgAbUqOLj5D2Ii5IKz
         Y15w==
X-Forwarded-Encrypted: i=1; AJvYcCUO5x64rQOxweAKMmrWs8l+pPPVyh1VlEuK44DG5CSgWyMeXcPv0XafKlxehY1oBOYMt6VxCRgstQ9oePmp@vger.kernel.org, AJvYcCXJhjqPH4WLmrLUJ7H1jxVv8IRA35nqEQb5m6KV94Ei5tWDyQFd7TEhLHF0aP/Uzf9IupmynV25eT7p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SY5lKHGak4pXIkQaAITA/0a9IZoMF3IswhMvs35inDNPbv29
	LhmLzTKG1CFJErGEf/nzXiIO3DuOAJu3OzQwaUF5Z7QeBwG+vGPR
X-Gm-Gg: ASbGncuTfXVBoVZZ57QY6t5Tg5Odj+oUI7ijeTOEzmH6AYjKaym+iO/hWrfb98yj9iL
	KMIWkZF4VMyv3gPSxDvKEok+8RcR34NR6wlpDI1CI+m7n7gWEW6OZcrd6jKegY4SqluzNG1VGSn
	unFIhjKjLl2jjWKyMMa1+r5IrUpUBF/cu14lIzxleyv6q4JgHAu3kJ6vrSZ/Oarvew0lPzc8mLO
	kT56fiWZYosk3zdbI3AfDMkVQV9jKWMCvQXyelrm6Xvw2egYbRxnWOWkKMdFBr+eK8kT1vVz82z
	dmkKP/xHgAS448huwhwYODirXA==
X-Google-Smtp-Source: AGHT+IGUIy1idLsF8BAdkcT/q2sd8Kglz05pHxayAigiBCh5rMM3MRINQg8z3+qnkVoVqpYjkxRhJA==
X-Received: by 2002:a17:903:2f84:b0:216:3dc0:c8ab with SMTP id d9443c01a7336-21dd7c4976fmr354447405ad.9.1738596470171;
        Mon, 03 Feb 2025 07:27:50 -0800 (PST)
Received: from localhost ([2804:30c:273d:6d00:d9cf:ba3b:291b:37ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ef9c2sm78089375ad.114.2025.02.03.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:27:49 -0800 (PST)
Date: Mon, 3 Feb 2025 12:28:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH v2 14/16] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <Z6DgoPacpQoG38_k@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <2d3c69d92a9688f4a20bd6de70f694482501f61c.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d3c69d92a9688f4a20bd6de70f694482501f61c.1737985435.git.Jonathan.Santos@analog.com>

On 01/27, Jonathan Santos wrote:
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to SYNC_IN pin. In
> multidevices setup, the SYNC_OUT from other devices can be used as
> synchronization source.
> 
> Use trigger-sources property to enable device synchronization over SPI
> for single and multiple devices.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * Synchronization via SPI is enabled when the Sync GPIO is not defined.
> * now trigger-sources property indicates the synchronization provider or
>   main device. The main device will be used to drive the SYNC_IN when
>   requested (via GPIO or SPI).
> ---
>  drivers/iio/adc/ad7768-1.c | 81 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 7686556c7808..01ccbe0aa708 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -193,6 +193,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  
>  struct ad7768_state {
>  	struct spi_device *spi;
> +	struct spi_device *sync_source_spi;
>  	struct regmap *regmap;
>  	struct regulator *vref;
>  	struct mutex lock;
> @@ -206,6 +207,7 @@ struct ad7768_state {
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
>  	struct gpio_desc *gpio_reset;
> +	bool en_spi_sync;
>  	const char *labels[ARRAY_SIZE(ad7768_channels)];
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -264,6 +266,21 @@ static int ad7768_spi_reg_write(void *context,
>  	return spi_write(st->spi, st->data.d8, 2);
>  }
>  
> +static int ad7768_send_sync_pulse(struct ad7768_state *st)
> +{
> +	if (st->en_spi_sync) {
> +		st->data.d8[0] = AD7768_WR_FLAG_MSK(AD7768_REG_SYNC_RESET);
> +		st->data.d8[1] = 0x00;
> +
> +		return spi_write(st->sync_source_spi, st->data.d8, 2);
Hmm, is it really OK to do something like that? I mean, is that safe?
I wonder if that can lead to race conditions if, for example, sync_source_spi
is already registered as an IIO device doing buffered capture.
Or maybe sync_source_spi is in the middle of some read-modify-write cycle
and we sneak in this transfer. I think we also don't know from here if
sync_source_spi device is expecting to have it's AD7768_REG_SYNC_RESET changed.

For multi-device synchronization, I'm still biased towards something like we
had for for quad-adaq7768-1 [1] with one device managing the others.

I would like to try something like that along with the component infrastructure 
(include/linux/component.h, drivers/base/component.c), but I already have
a bunch of pending stuff.
Basic idea would be to treat multiple ADCs that are intended for synchronized
read as a single aggregated device (that would have and manage all individual
SPI devices) with component infrastructure.
I suspect that might be useful for the AD7192 [2] case as well.

[1]: https://github.com/analogdevicesinc/linux/tree/adaq7768-aggregate-dev
[2]: https://lore.kernel.org/linux-iio/20241128125811.11913-4-alisa.roman@analog.com/

Anyway, I guess better to just do what David suggested and check the
trigger-source device is the same as this SPI device and then write to our own
registers or error out otherwise.

> +	} else if (st->gpio_sync_in) {
> +		gpiod_set_value_cansleep(st->gpio_sync_in, 1);
> +		gpiod_set_value_cansleep(st->gpio_sync_in, 0);
> +	}
> +
> +	return 0;
> +}
> +
...

