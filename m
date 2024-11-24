Return-Path: <linux-iio+bounces-12594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449149D7712
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060E2283A23
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8AF14B06C;
	Sun, 24 Nov 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RvuYdECE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC26F06D
	for <linux-iio@vger.kernel.org>; Sun, 24 Nov 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471291; cv=none; b=PFdWkTjzwavXB2uxsX7OvBejRBopnh/c4O/66ShF+B5sZhOC/Dc1NLzVu7dhiPih4m+0qiy4ywYqrZzd7Ky6+25q1XWG0kJt10VaZkyM5pxIxyuIeDKmrMXGLIsslA7pA3osi+stn7aKR/r9B3lYjCEa1TAhkFJYu45JUjOXVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471291; c=relaxed/simple;
	bh=OQHYaEGK/MoxESKfRrNIDMATBe/YMo0NdUaLUPjFGl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PewMyCuYBnAubvNT2ji82nKfRMfwUyNlVWAqTLCvVvG02VpQcajPI18ondaupwMuBS7HoeLN+vRtW1DLQ0fHK5zNnzE6G6xEm4HBHzhSj7UnYECkLmMdxtcKxqI+KCvcuuJmd7hSG/fHypjBZY7QOl11tSfBhFYSkeijm6Lp/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RvuYdECE; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2689e7a941fso2232174fac.3
        for <linux-iio@vger.kernel.org>; Sun, 24 Nov 2024 10:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732471286; x=1733076086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D36DzTxorADSkSUVJgapxuTWO26Thyjrj4okdQAgDkQ=;
        b=RvuYdECEnMYurSSb5+RqqhdTw51LDm8knXJal6SdxIP6woFJPoyBRPBEEhzkqteco2
         AASd3Ds/iPD3SnFoERXVWWaX8uCmnsby9cdz3BGYvsSvT2JYwBWmtiVykVzHXyU1WxCT
         d7zWD1LRUuGRq6tO2tEvLTdwt0FIa1HT9/sRVSAYZRG4TTIAHyaSoAJgBAmOSNq7SpCM
         S+dlv1235fmFE67hTtBJeYqJxwXR5emeadOGxtT8+hxsPJf0cifPUVQ5hmekcKIGHcdj
         bF9Ojyz5wKLcwLS0ks8syEczRweormROG1GMupMkaUZY/N9d4f2FDhdcHTTvjPFr6DFg
         Vu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732471286; x=1733076086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D36DzTxorADSkSUVJgapxuTWO26Thyjrj4okdQAgDkQ=;
        b=NlBpmCS9l+7w96uUtYqTEwDyXrZJN/oxVVSzPbwNmpxABAYFTrdChUnabtRKvvIBba
         l56UM3tVF078G2FNurGZtNIFElQN+3ycv28hf1WvhH7tS9acRlew1BTt9SHLWlJ3UmiS
         cN9xvvMRQAVAaaWHFN8N2HIrtkKwpFIYkOXMY4QLkhjGDRj5lP7bRlEMrYleWrIh34b2
         0fwIsoK76rePpVsXJiaFE1lM/SdlycJff/hmMjuDGqJ7bT0SuHCxTEJ0NHWtmavhWfZ+
         bqIYlzeJhzMJUM9cZMux95ch5Pf9njh8lha2KFsMdq+zJbNJ17DJJMOMGSTsvL5yenoR
         oTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzc27g1ZImObvrAp7Lmt2RECsJ9WFDf8M4dNvElM5hXPtQc8dBTIHyqPEdmU7W93F8c9QycvOUS94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzS8OiG/8HUqHkOG+2Baz/AXeLe2IyHEZRSPRSTSL/JN9o8VQ4
	VUojX/j8tYjWVi2ul7qG/JKrlQu7PPGdyekdnWz2kQYW/FC9CoqfvQXdKOskuBM=
X-Gm-Gg: ASbGncsSydO94wbkI+NyQPObDtrvXx46S6F0YRliZdbZkAWVnNzKcmTBQ5+Seixn6Hu
	7oqVxmKzGOi+wOpqC5a3lFROrS6OAvmMpkiLUJgYGf7pKXyx/GIuJ1D3+wjhZXbp93PDfpy4yqB
	mDW7KIPc1ZZi5YmcUWTYCZPjhhhFsQWRy/YavOcla2PnvexnPFj7cUfWY49Fa1eLqWwKJnVXa8G
	m4NK+s8nBCmHky3ClCog5uPQbjx7yU/oHO58KM8vijzGWOLHDPjr7v1jf80cpJo+cj0Dq/xUnjl
	vA2k8z1ACTU=
X-Google-Smtp-Source: AGHT+IFqrJucfpOTPI7q0bEc9jBm0hS0kXQuiS/iMtoAArPnMeQPf5AM8u1ip+GVY/H8ytVpgKSYVw==
X-Received: by 2002:a05:6871:3147:b0:296:9625:3357 with SMTP id 586e51a60fabf-29720adae7fmr7346877fac.1.1732471286146;
        Sun, 24 Nov 2024 10:01:26 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d5e2fa6sm2314970fac.20.2024.11.24.10.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:01:24 -0800 (PST)
Message-ID: <22bc45a0-9d14-480a-bcce-bae394166967@baylibre.com>
Date: Sun, 24 Nov 2024 12:01:23 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] spi: add basic support for SPI offloading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-1-bea815bd5ea5@baylibre.com>
 <20241124163241.4699161f@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241124163241.4699161f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/24 10:32 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:18:40 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add the basic infrastructure to support SPI offload providers and
>> consumers.
>>

...

>> +	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
>> +	if (!resource)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	resource->controller = spi->controller;
>> +	resource->offload = spi->controller->get_offload(spi, config);
>> +	ret = PTR_ERR_OR_ZERO(resource->offload);
>> +	if (ret) {
> Why not simply
> 	if (IS_ERR(resource->offload) {
> 		kfree(resource);
> 		return resource->offload;
> 	}
>> +		kfree(resource);
>> +		return ERR_PTR(ret);
>> +	}

Hmm... maybe somewhere along the way ret was being checked again
after this, but doesn't to be the case anymore.

>> +
>> +	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	return resource->offload;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_spi_offload_get);
> 
>> diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
>> new file mode 100644
>> index 000000000000..81b115fc89bf
>> --- /dev/null
>> +++ b/include/linux/spi/spi-offload.h
> 
>> +
>> +MODULE_IMPORT_NS(SPI_OFFLOAD);
> 
> This is rarely done in headers. (only pwm.h does it I think)
> I'd push it down into code that uses this.

Yes, it was Uwe that suggested that I put it in the header. :-)

Are there any unwanted side effects of having it in the header?

> 
> It might be worth splitting the header into a spi-offload-provider.h
> and spi-offload-consumer.h with a common spi-offload-types.h included
> by both.
> 

