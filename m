Return-Path: <linux-iio+bounces-17952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C9A85F20
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4767ADB7C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18331DFDAB;
	Fri, 11 Apr 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pzJodieH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2A19ABB6
	for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378487; cv=none; b=A3GHFNzJgS9kxh/MnSm02IAK0finYODcPUsbN1D8pSBemcFwoJpxbZoFRr4chRwItOP6e3EXBjsS4sFI2x8Z4U9NYqYQCcKMhJZzPoYGlozyXsMyNjrAsmBfHJAmbJXV4NPrC0rbKvayATRgGd+2+5QlcDEId0RRchJiyQJH/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378487; c=relaxed/simple;
	bh=cSh27txL7g12Strb6q9ScZqSSlVYAqRMDdbPYxuxSbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEMigNPg7iNHccQswnYw8YpSdy6piGiF4bOxSertzIIWhgRDrMCBo45cMQWUKrpMktTDsX3HcX/hIhHn034OGY+vsfxPiush5/CiOKP/AYGT9UfjOJAeSJoxSAywQRim9nNUWUcd4x0Id6+NijWRFfcf2uLye+sBxJjw0/GCrpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pzJodieH; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c14235af3so1096940a34.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744378484; x=1744983284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKN2yK5A2t8FCF5ACCCiUYzvtITcUF9NBPgqaU4hUEs=;
        b=pzJodieHa1HsIwrzs+G5Ns+QcuOUBgoYtIISRFt1kPO5+CyKaJy6mTYKdN3fNnEOIe
         udmiK0+BA8TjMP6qdSh8b4xMMkzI64DBf1YPO0J7tP0IPvqFiQO28kWI6jxkTRHz8qEL
         QU2J3qPYC8pKVd9yrA+9ErV7S9Og2UI8vz8aj2TVINB/jkilGnNVqmbyKYVQA7a8VPK6
         ZZSYFZTyNviAV5scQ2O4XREi8V+w1GBPs9eyluiagmtkOzAQuBIUhpOIuRVXxRCxKykG
         KeH5R3NEy0Kl1alrQ6isE+smoPb/0wE/NKTVsX4Ko3lpMs2FUmVwgoJ0Xkx25aNQaubx
         XPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744378484; x=1744983284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKN2yK5A2t8FCF5ACCCiUYzvtITcUF9NBPgqaU4hUEs=;
        b=Lv7aT0dsavMa2CiNcqZEdruLR5/v/h0oX628foaVJd5XxzGj2EkEVb6quel7GJidFR
         G86iGt8dwA98gJmIrPE/LcNPxn8HFKkeuJsaT20TSAGYtDjDUaCYTn+daaq4N2hbInxQ
         YsY7NPVhJLxgMdnSTRoAIvXVIQrnAf1H+oG4bGCimCg0XMOOv7TJicGpzv3ZyBMFIUwF
         4rSkJTzkl3z0sjsYIRMnYXSSvlMEL5rcSiJR0jyhUtzCGF7/IElywM0+vFMTYDM6wK3L
         qTY0iCB+y3Y8Ra/rgyeHpvkwBxNUjD/OA6+1bSQicH57iC8q/Kv9n7ByYKrQVR8cRKbX
         ANvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM1VU+61Sd73rQPpXTIVnqctXwAZfzgwA1goUVfukzwMQLZVq7aQ/9Ce7vSeqjr2ow2MMjTe41Ttw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBq20AEweqH3XIK73GeLdPlUTmoL6zO7jD3tIuw+YY1mZ6mun2
	sDsIn3mV2q7GcmhOAXtbNZaw7nNzeI1Vv3HUjNVwtpWO9fGZGm+dqQKdZ7IOYvM=
X-Gm-Gg: ASbGnct2xuRnSYfbcKqXTGzG9+SJo7m4JsAwBN7hB/wZ33JVqU8nvIhFuo6KCL/GFMX
	Zb0i5mfeGl0hdDez0Ps9YS89//DVwGlV41vunPxAupp4F8cSKgU7NXvrFNIhB5qdENlTkJHmiOK
	OOAF5c8VJ/GXINriAsFoqjEfQ53PZVscbSjV0i0EhQ4udGMBY3DTozZ8UBpO9UBx7Lxwp17fzAw
	S3zhHghbRk7tucEzv7JDDEiUAy+hUsN1oLIVqCH44vOeD2QfLBbFpCCYbiuBbBR3fZk1hP3zwdE
	GFw2TN4ePN/zJuMix/lAvJPbZq5B7mxDxPmC2CHiEBd78tKiknOKW0nEOPdcNk57Wewb2JtwuiD
	B5A==
X-Google-Smtp-Source: AGHT+IFcb3rviFsCJrfn4ipJXNeVmWfsFgxwgxvqzCDjBUYafcrhTNRMoGOOe9Z1tVQubzu82tEoJg==
X-Received: by 2002:a05:6830:61cb:b0:72b:a009:db44 with SMTP id 46e09a7af769-72e862d6ca7mr1686691a34.1.1744378484676;
        Fri, 11 Apr 2025 06:34:44 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d8fcaasm929090a34.38.2025.04.11.06.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 06:34:43 -0700 (PDT)
Message-ID: <78d17b05-3f0d-4903-afe3-8051d4bd051d@baylibre.com>
Date: Fri, 11 Apr 2025 08:34:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 8/8] iio: ti-adc128s052: Drop variable vref
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1744022065.git.mazziesaccount@gmail.com>
 <db5cb2e1543e03d5a9953faa3934d66f4621cd12.1744022065.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <db5cb2e1543e03d5a9953faa3934d66f4621cd12.1744022065.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 6:37 AM, Matti Vaittinen wrote:
> According to Jonathan, variable reference voltages are very rare. It is
> unlikely it is needed, and supporting it makes the code a bit more
> complex.
> 
> Simplify the driver and drop the variable vref support.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---

...

>  static int adc128_probe(struct spi_device *spi)
>  {
>  	const struct adc128_configuration *config;
> @@ -183,17 +173,12 @@ static int adc128_probe(struct spi_device *spi)
>  	indio_dev->channels = config->channels;
>  	indio_dev->num_channels = config->num_channels;
>  
> -	adc->reg = devm_regulator_get(&spi->dev, config->refname);
> -	if (IS_ERR(adc->reg))
> -		return PTR_ERR(adc->reg);
> +	adc->vref_mv = devm_regulator_get_enable_read_voltage(&spi->dev,
> +							   config->refname);
> +	if (adc->vref_mv < 0)
> +		return adc->vref_mv;
>  
> -	ret = regulator_enable(adc->reg);
> -	if (ret < 0)
> -		return ret;
> -	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator,
> -				       adc->reg);
> -	if (ret)
> -		return ret;
> +	adc->vref_mv /= 1000;

In other drivers, we've been doing:

ret = devm_regulator_get_enable_read_voltage(...);
if (ret < 0)
	return dev_err_probe(dev, ret, "failed to read '%s' voltage, ...);

adc->vref_mv = ret / 1000;

It can be easy to make a typo or forget to specify the voltage when creating
a .dts, so I think the error message is helpful to catch that.

And we use ret to avoid having adc->vref_mv temporarily holding a
value with the wrong units (and can make it have an unsigned type).

>  
>  	if (config->num_other_regulators) {
>  		ret = devm_regulator_bulk_get_enable(&spi->dev,


