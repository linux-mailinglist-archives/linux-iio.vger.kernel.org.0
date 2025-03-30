Return-Path: <linux-iio+bounces-17371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C2A75B6F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3E71884AA5
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1C1DB13A;
	Sun, 30 Mar 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w2mwmBur"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063D1AF0B4
	for <linux-iio@vger.kernel.org>; Sun, 30 Mar 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356086; cv=none; b=TBSbt0Np1+zVzY0tNZ8vFWNsPAuZKcNNnVTa3WUhx7tLntK43w+4vzyoBu7XkPRRcPdCNrpapf1LrdsRPiXiBtnUlvp25J+84yfgdJj6jMUNGADJHt1W0Rkz57PAovzg2LOP2cQrSn2nvdb5elhmTU4eG6BvWK+VKRK/p6Tu6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356086; c=relaxed/simple;
	bh=5U4Clltkv80WoyfzgJ6eTMysFZQXQPuuPC+tduvLBCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbR6l4VSY4q2LBT8iEWR7MId6aWW1ul9kjN8MEteQDiK8QCc7judPs08UWLnjBYnm0gsJfqOWZjrVMyZxaudnIQdwL+IUB5oQElgomYVM7W9yWXSbRvz54ZYZfdNWBEwAb8VBC9wibafgItE+mbuXGBUbyuWle2LdmllYIcfDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w2mwmBur; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fe9fe62295so1100139b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 30 Mar 2025 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743356083; x=1743960883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBuISF6jbYBXth4JoPLKPG1nY0sGBae58GEnveT2Zws=;
        b=w2mwmBurSdjQDXRwGxtElR+z9AzymUcuB9lGPfUOc+5shelRZFWOwVuadd9kD4rGCw
         90nIkPQ325AAP8Tmp9pfv41W3hVLPf/UbG2iYUSZx5AxK6DfyICKbK021QbZhicoSahA
         OGuR9hqcwyKU1Sq2n4BCsFwL4IOInPru53h11BvENfTyji1peCDziJ+on2yaZQMcMlf7
         38/dxrhe+VYyzXZcNy8IJ3N4i3UNrIriMBA5dlOcJPmN5c+X9omKUDEPrLeardA2GtTs
         ib1pSJddTVmAewtkoYQWCQ+V7VtSWOQoMWoyU0yyv1q76Ut7Hi1bAtp5X6c751saopmK
         4OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743356083; x=1743960883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBuISF6jbYBXth4JoPLKPG1nY0sGBae58GEnveT2Zws=;
        b=Xi376mDjszaFQlcp8ec/aToAZFfs9Cx6icgpjgRWoQxSrtZBxXUfD+aznqI3AG7E44
         guzIbKFCkZDs3wlpOEnaDpdABnfdG75O2ZQnhbMa2t74I6P/6igAK/tf8Zivp1d+UTz4
         wTgZTOEPa9EpjWZTZg1yMdKHD0zcRZVLh7crYtnyH860M0MDKjYo277fXcfw9GZPdYML
         fv8C7t5COBP9WEZ63/oolBoS2T1fYC1sXZajyP2dgl8jQM5WnnECn1Q089JXrxZD2kJ/
         SSA+IyEjQnM61rgrGKJ7xAD9jYQyGlKnDRy7CtBl4Lmatd5zFRtq8YiHHxykmYvdK++9
         QYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKmivR0MQWwjKA++Y/Wdtcn1LDFK0H3CZuPwAKX3DmHmEeZhmXwR/y7Z31Oz98FXYGIQGTjawHWQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUyeUTWysuGQ0ELWBEUrEatgi79lxTQBVGlQ6qs0NyWm8rI7Q
	S3XJo6F5DwciVfRJyDXJzzpFBqWYvCCN9x/JJjpDwum58uHQVSs2aRBBpiDYeZh/Q5tB2p8It9X
	vqTs=
X-Gm-Gg: ASbGncsXYfKandnZuut2VkWkoZ60hBzRKdm0wH2r/Op7sYv7HTTBxyNv8596A7+wDJF
	Lix9Ujt6HW7r53430Y5YFzqtHw3QCewMF3Ii9DukhY1m2px5ezSajjSffRi2N04ZYjxApBeIuml
	uf5miQ4eIb2P7zIp8ZvCNhZ9zDUYP7xRQAPPRv+GIcPaZIxJGqEYH978aCZTqd7rWcUppjzvwiX
	polfrBBOfnUltuUzwYihxqeGk4Uvc8Gh5Ht6k6+slolHODJwWJWv1PntrZthdHm3pojWNSR6Wfp
	I2Soo3lWpGz40M93IJ4wYUISuL29dgOKFPggWJLamnNlcm+6AyOjTecAmoxhb7hcFZ2FYY6TTUQ
	c1ZRQ0g==
X-Google-Smtp-Source: AGHT+IFKNqyLxoS7q9afhTJ9PDwxwlzxNhC+QwhLSfePM4OfbMQPkD2Wtprcexa5g1W4C6bNtwH9Ug==
X-Received: by 2002:a05:6808:2e4b:b0:3f6:ab0d:8dc0 with SMTP id 5614622812f47-3ff0f59b9famr4159919b6e.24.1743356082956;
        Sun, 30 Mar 2025 10:34:42 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-602845027b6sm1197779eaf.16.2025.03.30.10.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 10:34:41 -0700 (PDT)
Message-ID: <3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
Date: Sun, 30 Mar 2025 12:34:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
To: Jonathan Cameron <jic23@kernel.org>,
 Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
 <20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
 <20250330181320.0ec4351c@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250330181320.0ec4351c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/25 12:13 PM, Jonathan Cameron wrote:
> On Fri, 21 Mar 2025 15:50:02 +0100
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
>> Some devices have an internal clock used to space out the conversion
>> trigger for the oversampling filter,
>> Consider an ADC with conversion and data ready pins topology:
>>
>>   Sampling trigger |       |       |       |       |
>>   ADC conversion   ++++    ++++    ++++    ++++    ++++
>>   ADC data ready      *       *       *       *       *
>>
>> With the oversampling frequency, conversions can be evenly space between
>> the sampling edge:
> 
> I'm not sure what this second example is providing.  Are you suggesting
> that if we don't provide oversampling frequency we should assume this
> pattern?  i.e. it is the default?
> 
>>
>>   Sampling trigger |       |       |       |       |
>>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
>>   ADC data ready         *       *       *       *       *
>>
> In general this patch needs to go in with the first driver using it.
> I don't think we have any such driver yet?
> 
>> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 33c09c4ac60a4feec82308461643134f5ba84b66..2317bacf6a2884691a08725d6f01d18555a96227 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
>>  Description:
>>  		Hardware dependent values supported by the oversampling filter.
>>  
>> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
>> +KernelVersion:	6.15
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Some devices have internal clocks for the ADC oversampling.
> I wonder if we can hint at your diagram above?
> Maybe
> 		Some devices have internal clocks for the ADC oversampling allowing
> 		the over samples to be bunched up, rather than evenly spread over the
> 		period set by the sampling frequency.
> 
>> +		Sets the resulting sampling frequency to trigger a conversion
>> +		used by the oversampling filter.
>> +		Can be used to evenly space conversion between the sampling edge
>> +		on some devices.
> I'd skip this last line, or maybe say something like:
> 
> 		If not provided, the default assumption is that the oversamples
> 		are evenly spread over the period of the sample.

Does that mean we should go through existing drivers and add this new
attribute if appropriate? For example, ad7380 comes to mind. It has a
fixed-rate internal clock for oversampling, so would have a read-only
oversampling_frequency attribute.

> 
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
>> +KernelVersion:	6.15
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Hardware dependent values supported by the oversampling
>> +		frequency.
>> +
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
>>
> 


