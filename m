Return-Path: <linux-iio+bounces-23985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF1B533B5
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 15:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980D8A820C6
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD732ED23;
	Thu, 11 Sep 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hGfBaghF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74732CF6D
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597171; cv=none; b=PnfXDmXL1KTxBLYowmFIeXQ/6hXGz7sSQYem5TYXPcy9nIiPz1hYzxI9LmKSz14Am1Y6VFclnFgOJ45dQF5h07GjpofqDL9hiiJCOz9Gbx9EQGUzZSN1LccDoSR4OJxv0eQPrtobnh4Rt6U/JUTLYG+PIYal9LOfV6pCd5CJhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597171; c=relaxed/simple;
	bh=M1LYunffuVeDHmWNDQ+oMBlOG3SDCCt4WC6SDVLqx2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp84jTeFb39AW7nXzjkr8D0wAO/3VNnTCrdySojFGlq/lyfFP32sOquA1b+ITG15I7EA1eU7U7tfRC0yjCPxwyfWo0jg8mgPOFpnEORY9XVZNoIa6p7dK4F3U6Ig5E0NRLtcH1MYBea6pynqPqEpsQkVZPdZD8IVhKQIIlB2ZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hGfBaghF; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-62189987b54so383767eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757597168; x=1758201968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doXLtB9djik8VUwa0G7u1GLCJ7g4vB7KCBCvKf56es4=;
        b=hGfBaghFgoo+BzaulqTETY1/N3Djlk4XatjZpzRlZXIvKjFAIhF2db2Ni5iMnyPSuN
         Znb/sKWwuCl9nDGMLwnznlsMU5d+sb9FrZxSTzMt58DbIbAovP2ELqrKunyJLLl/tMrY
         A+jKvNPEDZ2dGhnCNXUF1ohF1OuaJnrNAo9XPh3y97znXlqnf0Zf4KmEsS35hMUAmjTx
         a2oz4lMe3FzkJe1sO6kHR8T3CY44VYPhFOpGcMLCg6bejWanKppXBtbLkKRV048UPZb6
         F8/AOvyQ+FP2d+/DOd3JbLLTmVexWLJeLlwt8U/VsuZozb3rQTwS2ooXm6BP4spSIIRS
         Cuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597168; x=1758201968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doXLtB9djik8VUwa0G7u1GLCJ7g4vB7KCBCvKf56es4=;
        b=F+A8UgD23PylkglXnYSCd6gV6kBzrncne24aS3OuNfYURYDdWJrGgMovf5K4F8KzJp
         KQ5b8yF4bckB1ZPt+gohFd8BfRD3ncp5tfkXv4u+TEqh+doCgHOkvgUev/NSWKv8fFqF
         FRw6cFz2m1WyGRgHQJdxBty+OZKmxb4B2tnC2GfJkgifxrRiQLz6re7ffi4vtC5jbUw9
         dUa7xZjU7WYTyROBSTm3wc4tSBj+HarLbCiJrMW/1ggj7QshpB74X0KzZPK7l8G8sOFW
         UI3VOnVTF2xY1wAqb7Krb5fsAV6A2/csOBJxKLaG5eiuz5uZmFLqfAD87sXFSIDRTxYY
         +mBg==
X-Forwarded-Encrypted: i=1; AJvYcCWV4DU3wkff1AYiOXde/FMtLByubLo2I3RpBr3odY6+RWuq0gca2ePvTUistwx7SI70uAqlS+Nr6UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhYCIor2BMdKmeQdtVQJnmLLezA+4szab6YBCJoudQW3Uqvxs
	8r4vHRpyTNJPEzFKSGai7tKM6rPfhX9QBpIM2ygzQObV+HY2XGjdtwjTvhUG77f10PU=
X-Gm-Gg: ASbGncvI/vPykZXhzcBFbXKieu6Lus3BBgkEwnl+fm8+7ILLgrcgRJFmv7bXzhvY7vH
	N4Gbf0dsdce3xk2BTs3DM6hVZPmu4pt9IetTKq80aaiIZPn4iDAV0ttgkD8Jvb73hio3XqBR30M
	Epz2dY3ebNEBlo5SSfhGkthRsrshfs6gSGBcNg/nXqMzegKpgIyxoNmYu9G8qETMQyF8/kliXHk
	4JaPQPwm1uc+fLV/MrucXbnAJZzxOtKwju4nmkoBrGD4uoTXI9/VwQacKJfZe4Ix3HV1Onjf7hO
	q6YT2usUXrXvGIGPjx3nJBYpayjYklXdoYLLIGMd/Ubed4XQRLkf3SNv8o76ihd9G1V9k2TLykq
	wO2Xaw5XYFvlRPhKmpxzFABuFj3ZbyzZ3GDUHn07DuLlltLsRJrT4JXWlFE41/QpN4QU903l1G/
	P5o3nAk1lZnA==
X-Google-Smtp-Source: AGHT+IGewbzhtIZHb9eUyQRJcGNAmv7FjLag6+AtUsiw9MhsNcbjBVwyMYuFzvaZWeOFJGfwdTLRbw==
X-Received: by 2002:a05:6820:1ca6:b0:621:b76e:66b9 with SMTP id 006d021491bc7-621b76e6989mr660188eaf.3.1757597167898;
        Thu, 11 Sep 2025 06:26:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a3a8csm347330a34.21.2025.09.11.06.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:26:07 -0700 (PDT)
Message-ID: <c746e72c-dbd9-4afb-9da4-5d13733fd561@baylibre.com>
Date: Thu, 11 Sep 2025 08:26:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 s32@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
 <20250910155759.75380-3-daniel.lezcano@linaro.org>
 <20250910183212.6640e662@jic23-huawei>
 <b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/25 7:55 AM, Daniel Lezcano wrote:
> 
> Hi Jonathan,
> 
> thanks for the review
> 
> On 10/09/2025 19:32, Jonathan Cameron wrote:
>> On Wed, 10 Sep 2025 17:57:56 +0200
>> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
> [ ... ]
> 

...

> 
>>> +    indio_dev->name = dev_name(dev);
>>
>> This should be the 'part number'.  That is a little ill defined
>> for a SoC integrated ADC, but generally not what we get from dev_name()
>> on the platform_device.
> 
> Sorry, I don't get the comment. If I refer to the different drivers there is not consistency with the iio_dev->name.

dev_name() will be something like adc@12345678 from the devicetree,
so not the "part number".

> 
> rtq6056.c:      indio_dev->name = "rtq6056";

This style is preferred if there is only one supported part.

> rzg2l_adc.c:    indio_dev->name = DRIVER_NAME;

We try to avoid using a macro for the driver name like this.

> sc27xx_adc.c:   indio_dev->name = dev_name(dev);

Looks like we missed catching this one in review.

> mt6359-auxadc.c:  indio_dev->name = adc_dev->chip_info->model_name;

This is preferred if there is more than one part supported in the driver.

> mcp3911.c:      indio_dev->name = spi_get_device_id(spi)->name;

This is fine too in cases where there isn't chip_info.

> 
> Are you suggesting to use the compatible part number ?
> 
>     indio->name = "s32g2-sar-adc";
> 

That works.


