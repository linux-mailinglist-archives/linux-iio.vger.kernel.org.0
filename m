Return-Path: <linux-iio+bounces-6150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC59022CA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A64F2855E6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34134824BC;
	Mon, 10 Jun 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XNFnJczH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92B74048
	for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026861; cv=none; b=NB7TYReYnmnQf11zn7rXifH67dYA3dpirH8qMBgb9WsUvgzmn8kvz1nJ2nvgaHP6rqlU7vQ24PQIVsvkK9lFu5RVfmYofu01skelQ/vW6ZBWkXpijxV7qHvetWYAvmcbuBThY9lxJCxpog189ps7sBGEzj8DG1o1Z9nRV9u0vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026861; c=relaxed/simple;
	bh=IHIUW+O5SruheAsKXKeG18KB+xoYjtu8WU6lClaG8FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBirEb0Wm6wBNVpHmg4qEZSyorj8MPW2LOda5snBp5Zc85Hi7+u7fO5Gd+OHbA0MAyigH9uOla+toh6kJURMQN0eriZuAxSe1YlEcQqGbStTDhDgOwqG2OoEWpgfF/xJBXWOmL4bCc+RLA1WelOZOsj8spY5ulud94TRKmEmWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XNFnJczH; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-250c0555a63so2154495fac.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2024 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718026858; x=1718631658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDG2nxV8ZPl1b2CwR6DrsnQRSq1ctUVW1/oMRxru1WE=;
        b=XNFnJczH39p79SDaOOFwm5ejocyi2jZsJZHWPJ2Mo1cilAEhCuZ+GfPda5/45O5cxL
         +vVBNzZ3tUCKIASqrdowmJ9LhAYlHDzvLfuDC7oYtK1Z7cLEILHXCagZ2rQhUER264+N
         P0rEHsYiLGUETZUVFTfUVDpTCOQBoCp4YeZTGY25PpOUm/klNyA9+yMnr2+kfR6yB7QT
         Yken7LjsqxjamG6N1FhsAQJ0KsfAgolaKee6YlOOAVuNUIS3iG2qtFCN/v7zkR3P791m
         7sNHhGBSacJw1X2xbGQbMV8cgdomKwRbiATnFtqxB0BlM2d7vjIBBw0e6nPBqxSqs9mq
         AWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026858; x=1718631658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDG2nxV8ZPl1b2CwR6DrsnQRSq1ctUVW1/oMRxru1WE=;
        b=P13hvR+W/UiFDgNaVMtIjVz1h43CSO4WSRTeK9wSIbrC0YmoL2RbH6+Wb3gFT3FlkB
         Alsrc7ssmsiV5+awwPgN6wD5o44j5qM2YaxQVTlErLDOA5fU/fo1sWgzAvZODLF13+m3
         pcra6gIBhplGMW287j2vvXMWgHla8qHT/5BynjdjeHN97feWGDDdx/+k9YEYA3jW+6lu
         xutPVH06NUpT97Ga9iJWLseKbj/ePnxlEm6RxPlXVYz5ACMvruPKCHi+AbaABlH6uOZC
         alIYzcyKU0JXTZ3o4lxUy8T07fxrcsXy1LKjimYGXZIqNpQuJkej6bBY0MYIWCWJ2dbK
         9tmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZPIWPP21UFzMe8dWOu3VF4IDEDb+zfyyWXx06TzVgXJ6n409Ab7vfbFr3jTp9emWoM1FjUhwMspHAj7CTbZYV7yua4EypDIQx
X-Gm-Message-State: AOJu0Yw/Unho0zlvaHV/mlyt8563d+V7uygpxQ8WFcKwqI2HvI+icWx5
	BI71LMmcDNcQ0b75z4hyJWJoVGyM2V51kI3CfG/uJKBU83fnqE1LzsruiJ6R39g=
X-Google-Smtp-Source: AGHT+IFYTklYQEGqN5Rpab7SF59DyTOKjZknIHz49GqfApCvhPO/U+G5aBhz8l4Aqt4IgLOznMG/Kg==
X-Received: by 2002:a05:6871:608:b0:254:ca65:1ed3 with SMTP id 586e51a60fabf-254ca6536efmr2782598fac.2.1718026857755;
        Mon, 10 Jun 2024 06:40:57 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-254d7f33351sm259822fac.46.2024.06.10.06.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:40:57 -0700 (PDT)
Message-ID: <adc6cba9-2e79-475f-9c24-039fe9d3345d@baylibre.com>
Date: Mon, 10 Jun 2024 08:40:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] Add support for AD411x
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 9:53 AM, Dumitru Ceclan via B4 Relay wrote:
> This patch series adds support for the Analog Devices AD4111, AD4112,
>  AD4114, AD4115, AD4116 within the existing AD7173 driver.
> 
>   The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications. They integrate an analog front end suitable for processing
> fully differential/single-ended and bipolar voltage inputs.
> 
> Particularities of the models:
> - All ADCs have inputs with a precision voltage divider with a division
> ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
> shunt resistor.
> 
> Discussions from this patch series have concluded with:
> -Datasheets mention single-ended and pseudo differential capabilities by
>  the means of connecting the negative input of a differential pair (IN-)
>  to a constant voltage supply and letting the positive input fluctuate.
>  This is not a special operating mode, it is a capability of the
>  differential channels to also measure such signals.
> 
> -Single-ended and pseudo differential do not need any specific
>  configuration and cannot be differentiated from differential usage by
>  the driver side =>
> 	offer adi,channel-type attribute to flag the usage of the channel
> 
> -VINCOM is described as a dedicated pin for single-ended channels but as
>  seen in AD4116, it is a normal input connected to the cross-point
>  multiplexer (VIN10, VINCOM (single-ended or differential pair)).
>  This does not mean full functionality in any configuration:
>  AD4111:"If any two voltage inputs are paired in a configuration other
>  than what is described in this data sheet, the accuracy of the device
>  cannot be guaranteed".
> 
> -ADCIN15 input pin from AD4116 is specified as the dedicated pin for
>  pseudo-differential but from the datasheet it results that this pin is
>  also able to measure single-ended and fully differential channels
>  ("ADCIN11, ADCIN15. (pseudo differential or differential pair)";
>   "An example is to connect the ADCIN15 pin externally to the AVSS
>    pin in a single-ended configuration")
> 
>  As such, detecting the type of usage of a channel is not possible and
> will be the responsibility of the user to specify.
>  If the user has connected a non 0V (in regards to AVSS) supply to
> the negative input pin of a channel in a pseudo differential
> configuration, the offset of the measurement from AVSS will not be known
> from the driver and will need to be measured by other means.
> 
> Datasheets:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
> 
> This series depends on patches:
> (iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.)
> https://lore.kernel.org/all/20240330190849.1321065-6-jic23@kernel.org
> (dt-bindings: iio: adc: Add single-channel property)
> https://lore.kernel.org/linux-iio/20240514120222.56488-5-alisa.roman@analog.com/
> 
> And patch series:
> (AD7173 fixes)
> https://lore.kernel.org/all/20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com/
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>



