Return-Path: <linux-iio+bounces-14253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB306A0AB50
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DAF164CD8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77B1C07D6;
	Sun, 12 Jan 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b69ChCjO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFF1BEF98
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736703712; cv=none; b=Wop48Lz/h1f3L0mbvBKI5k03fkEgYqaiDMM9tvxIRfaOo87T3R6DRlLE/V8ZBRNwCD4lsoBdq8Hm1nl9m671nXGAvCbnEdsUfsl/KydutaRpI9yTcUrSVmrKdyMV61Rj5qPSAtGzGf/b/qVIA6DHuW9YPyMhTkkBOWqV+8RRhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736703712; c=relaxed/simple;
	bh=wNL9EWWxbx86cZ6hdhNgs1lrQ3Qcf+AyzUe4Ft3AEjE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sMjtqTsFJzYxhtxo2MMEQV3LM6Swrsrx0K97z9TM7UReyIUp0+uu7JmaxFdwuWX57iAsgtGxT38xJOtsg8BguZQ1Qbq9GXZIFG+sX+gLln9V1uhd93uL6E8FkmuzI+WFyZQUH1DaVCjhPFef/3ezynHxO6azBl7EAIbrnjPfJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b69ChCjO; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba559611aso958624b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 09:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736703710; x=1737308510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ArKjTB+73Y+HjF446z/Wou/JDoa0n5FHpin4ufNoGsM=;
        b=b69ChCjOFVIuvi7DQvyd8x+tZw54VhEDJZOe+/iMYDNAfnBV7EOuBhRkg444SejGrE
         Dw9f/jdI0PNABeBTPS4kpr+qZkV2DAl0i/+C8xR+2H/VPituJrv+tW41XJL1BLx4JkZg
         dHJXFVJ8ldbdeB1fcIoHvn1WPxV+D9Ff+rmMtd4/9JTuupIW/Luh4SkoOpFwcSWzjT0e
         IWDALxBYqQ0MZZJbKMFD4rfXeBpx4Y13/ami2N+FsMSmRQFnupfM9YXyqVEDLUlZUlCX
         i+oGCtSa0Mz9gUhFzBE+2jDmSpyvvIR86le8zVIc0tFVv2QYuftTfYnBbNOPha7vkAsI
         qPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736703710; x=1737308510;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArKjTB+73Y+HjF446z/Wou/JDoa0n5FHpin4ufNoGsM=;
        b=QtxhQ3VLDd04AabVSHeu9/SZgmX+wk6wn1guDH7dUdSR222Jq0+JMfd3p+iypWyAuW
         ZDELO4H7fG+mwxggD+rqXipB/2O55n2ibBSs0mDZzl/iJYtCxUvQ4gVmwITTJA+izrD/
         RGoWmQVpuzMvFkaCrKPjeJB7quBhBihCk1ZlALCn1+dgxylDjGlcbTUgeWrWml1lEDuh
         uFKMd4UMy/AO/jNIkRk998/JLybMmXO3mBJZr/W0pJUbVxkigPkf28QRgk431a0HIKjD
         til8eZL+LNjXDyEWLgFXZzh6sZh4tOnxO18wEKufq85kX53xutKKInU4gCU8gH+enStY
         eFBA==
X-Forwarded-Encrypted: i=1; AJvYcCWRmD8iNTOhc5uoaXxIfN22WoZ7xW/rNOX7843jOUkeLOw3RQ+k0IY/ciOEnkttDyILR32NDnuoOno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyVMLdE6QkhouAigAANKKItzSUa4PFCk/zpj1eTrljXVBfnnMt
	o5AwBHpjMqM3vrjO1PxDHTEcUzz4LNYlqfteHkw0CLTj4sZDvB5o/3fal7cHqE8=
X-Gm-Gg: ASbGncujWR3XEkNSX40QrmZerCCj1WMR/vUTpd8fiZvaSwPSlrn6Gqtiog9tafqB12R
	fLNkM6PJTMx3D49M3pWbvtbCWVBLI6dDq0X6neRvwVzZLacvcAMEJExarGPTd7l0R2PkAwFudSU
	NlGcpY6o74RNvyP3oMG+Z0tYpTWD6vsZ+A3cHpKVNSjE7TbU3eiFSa7tAwBFNoc+gm3QsMm+7Op
	/BjChIFWQ3QoagF7jr1Zir5YxaeTjTK5X4oIHb5NeLWs2MqAK97oRS2bEZC+hL/1SjqXPlhmsla
	qxq4E0RVK7yGVSLfhw==
X-Google-Smtp-Source: AGHT+IFeOjgbNEeqlLTFHVGpQVSaVjwHjdfA9O6/RDO9igwRo3WhEU9uzIvh7uEnRx9kF5ngRIcovQ==
X-Received: by 2002:a05:6808:3091:b0:3e7:61e6:8113 with SMTP id 5614622812f47-3ef2ecb2073mr10357428b6e.23.1736703710182;
        Sun, 12 Jan 2025 09:41:50 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882624f98sm2533398eaf.1.2025.01.12.09.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 09:41:48 -0800 (PST)
Message-ID: <302392c6-88b6-4ed5-8577-9f7d33b5fbf2@baylibre.com>
Date: Sun, 12 Jan 2025 11:41:47 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/15] Documentation: ABI: add wideband filter type to
 sysfs-bus-iio
From: David Lechner <dlechner@baylibre.com>
To: 8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <40707fa904ba7b1659554747ff7520139dd6f94e.1736201898.git.Jonathan.Santos@analog.com>
 <8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com>
 <Z4L1qrqHBUE5JGdX@JSANTO12-L01.ad.analog.com>
 <652a80dd-e951-4505-8e13-b5198c66c403@baylibre.com>
Content-Language: en-US
In-Reply-To: <652a80dd-e951-4505-8e13-b5198c66c403@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/25 11:39 AM, David Lechner wrote:
> On 1/11/25 4:50 PM, Jonathan Santos wrote:
>> On 01/07, David Lechner wrote:
>>> On 1/7/25 9:24 AM, Jonathan Santos wrote:
>>>> The Wideband Low Ripple FIR filter is used for AD7768-1 Driver.
>>>> Document wideband filter option into filter_type_avaialable
>>>
>>> s/avaialable/available/
>>>
>>>> attribute.
>>>>
>>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>>> index f83bd6829285..c4c21a7bfba1 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>>> @@ -2291,6 +2291,8 @@ Description:
>>>>  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
>>>>  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
>>>>  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
>>>> +		* "wideband" - FIR filter with wideband low ripple passband
>>>
>>> I think "fir" would be a more specific filter type name than "wideband". (i.e.
>>> there are wikipedia pages for sinc and FIR filters, but not one for "wideband"
>>> filters)
>>>
>>
>> Isn't "fir" a bit too generic for this case? Since Wideband here is a class of a FIR filter.
>> Maybe something like "wideband-fir" or "fir-wideband" would work better?
> 
> For this particular chip, no, there is only one FIR filter option on the chip,
> so having additional qualifiers doesn't really make a difference.
> 
> If we can find a chip that has more than one FIR filter option, then we could
> use that to figure out what additional classifiers are might make sense.
> "fir-wideband" would only be useful if the same chip also had a "fir-narrowband"
> option. But we might find that instead the chip is actually "fir-type1"
> "fir-type2" or something like that.
> 
> (FWIW, my signal processing textbook describes Type I, II, III, IV FIR filters
> but doesn't say anything about "wideband" FIR filters.)

Oops, didn't read Jonathan's response first, so disregard this comment.


