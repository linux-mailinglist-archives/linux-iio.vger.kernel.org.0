Return-Path: <linux-iio+bounces-18903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BBCAA4FBA
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 17:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E8F1C22C7C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9525DCE9;
	Wed, 30 Apr 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VezMumEH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519725C708
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025494; cv=none; b=FypqnWuvK+OgbbLDaYifjOFh1FXzWIQHSDLvHP9rUTjD3sirZ3AOf/GDwytjQgt1yLQIUEolRb2oixeWWZj2Qqe0SHOWmRW2mhtbiZL421lybQNBenKFQpjE1agQCjE1tGSw9C6Q7YlpX+jQeh9FYPf17pKE0jhkOFbcXfzMeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025494; c=relaxed/simple;
	bh=iAUBF84BT6XPeN8Y/n4Oehp+UL7zE/zH+6aZ+LiCsHc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EqVPWliWbqifoLgG2iadrNP4l9GLMv1Bb2MoMzuP09zPVjlDS3DjMIyeifFpDhxkYfGmt4zxC1tutqa4yJazujU+zks73zJp6Od8rK09w/RpON00plhE9W8M5pOyl7D26TVpCgEqIE/dsOO+lIhNSpGxXCK0uzbIPqQLP9qrvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VezMumEH; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f8d2f8d890so8841b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746025491; x=1746630291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n3T9+6PFQU7ODBU+5+B8t+gjHfIuLl3Jh/pj8rJ6DXA=;
        b=VezMumEH4PnXDpfdIiVOA8FcSVMdKGiH03QLdp2m5CaGxxYPtYQrjtwt3t0cAmix5x
         2q2rDP9CUs+5m/PybmjnrVslLmWPVZetohfDthCZhqh6DJsLgrJM2juuyGqWEyx6b9QK
         jiVmvYiNp6VqcNayES9DJnYGeRwk4GKzulrPL4l3KYL8DfTfirsMi1lbfmUHVxozphzw
         8W9uV6SpqVgGkW7pSbRWLIG3bJEYPLkKkY1rmfmFxG99w1UqboVvqBZP+TfmLt5uuDW5
         KOcSpJddBNA1BwJ7jV8FXkeE2kPrBUM9lXgf7HOrk+3ihxFCqKpKVnKBdlIXRixdZIBj
         5QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025491; x=1746630291;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3T9+6PFQU7ODBU+5+B8t+gjHfIuLl3Jh/pj8rJ6DXA=;
        b=tmQAuK1iQz6Of7VSdH5etBvMDduLNDHgSO3EtwT/jY1u4YTiqLea9jerpKo7g8qCbV
         tvuIabsLSJAvUNU4zcyjHpEsT8tuM5Q8j/FJZHTHqxLYC/w7mNGHsHfE/cqYz+1uW42J
         N63q9IQN2EFA/n1OVeSzqdXUvpeXG3mJTNbKwRKaCjj3d8mXljmnfOXL+i+Hh91qzffA
         K1K7YyClACKNV8IWwDvSyW1LW00ZReKBVOeYGd8VEjIr//ZvY5Nfu5Cbf3cpkzCG2Y+Z
         7QRKOATVf0+ck5mLJUf5x5dL3Yc1lwBhtDAtPlheUcYhRMZswB5Jk2Syo8CjD5LQEo09
         UN5A==
X-Forwarded-Encrypted: i=1; AJvYcCVzpqC2Opkf27l92VsPyGJwLIc1Ke5XlHXshAsIJ+jG7rS9HJ7jowSHvZB7/NtSvytkLtgMTjUnYRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUFkmxY2Y2xsf8ZfYDTBHm6thjRmjxZMh2nZR51gNfx5bs2Ot
	HF9QtaACsOelRN+rceMMpgNRCXlNRS5QmfgSgmIy87B1h7eQ7zS8xdyvURynj+A=
X-Gm-Gg: ASbGncvBWGrk9Q9pmey3gObbMRWDsWVl1DbS+htNZeAQ/cFdMTqmKYF5npdU8WMIp7j
	obU9ZqJQtNK6aIJ6FA6+ZGRm0J3pdVaOAmFS/ZOQrs7cv3UK0B9VBcuuz+a76tr3hsNEKa+LCXJ
	VVrKtr4cApCvk0aqzFjHTxxfnhWoC/RGL/iRkAd9Q8w25u+6ldegpKyCGmkjgELPE0KmlgAhKZh
	2xma0nOY1NanDzBnl5vDfnSMT/ZtXgAkN3FnSJFsPUWP5fw/eLL8+9t8EaV3oqoDC6JzUK4rsz3
	I9wAv/lA+PF4azxO2+afUse/ki0I/Q381aP5CPIE41VcaEmQlREUjtr1I2Y+0duq4NtuNrkTLPe
	yo5QRDxn2EOPpUA4=
X-Google-Smtp-Source: AGHT+IGzbbqKeOG5/Z3RMXw05bmJvQ6JAZJPq3w+KmxakZsKev1SHX78l6FcGWqPiLMhX3MPVZr9Uw==
X-Received: by 2002:a05:6820:3094:b0:606:107a:ebd8 with SMTP id 006d021491bc7-607d5675e89mr1620447eaf.5.1746025491559;
        Wed, 30 Apr 2025 08:04:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60686ec905dsm811235eaf.15.2025.04.30.08.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:04:49 -0700 (PDT)
Message-ID: <7fe18625-3a25-40c8-bfb7-a7a22a3eccff@baylibre.com>
Date: Wed, 30 Apr 2025 10:04:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Documentation: ABI: IIO: add calibphase_delay
 documentation
From: David Lechner <dlechner@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-1-eb4d4821b172@baylibre.com>
 <4645ae3e0c3bb1ada9d4cadce77b64fe5e651596.camel@gmail.com>
 <070b269c-c536-49c5-a11d-7e23653613f9@baylibre.com>
 <aBI3eUPirZEXpZgG@smile.fi.intel.com>
 <896023ae-c279-4201-a7a8-dfd9b33fe0e5@baylibre.com>
Content-Language: en-US
In-Reply-To: <896023ae-c279-4201-a7a8-dfd9b33fe0e5@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/30/25 9:56 AM, David Lechner wrote:
> On 4/30/25 9:45 AM, Andy Shevchenko wrote:
>> On Wed, Apr 30, 2025 at 09:21:28AM -0500, David Lechner wrote:
>>> On 4/30/25 12:40 AM, Nuno Sá wrote:
>>>> On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>
>>>>> Add new IIO calibphase_delay documentation.
>>>>>
>>>>> The delay suffix is added to specify that the phase, generally in
>>>>> radiants, is for this case (needed from ad7606) in nanoseconds.
>>
>> ...
>>
>>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibphase_delay
>>>>
>>>> Not sure if I'm too convinced on the _delay suffix
>>>>
>>> Phase is measured in radians, not seconds, so it seems wrong to use it here.
>>>
>>> https://en.wikipedia.org/wiki/Phase_(waves)
>>>
>>> And the delay here is with respect to individual samples in a simultaneous
>>> conversion without regard for a sampling frequency, so I don't see how we could
>>> convert the time to radians in any meaningful way.
>>
>> And how this delay is aplicable to the phase in the hardware? Sounds to me that
>> HW has some meaningful way of such a conversion?
>>
> 
> It is a calibration to account for a phase difference between two input signals.
> This is a simultaneous sampling ADC, so all channels normally sample at exactly
> the same time. This phase delay calibration factor can introduce a small delay
> on an individual channel so that it starts it's conversion some microseconds
> after the others.
> 
> There is a nice diagram here:
> 
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf#%5B%7B%22num%22%3A113%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C34%2C594%2C0%5D
> 
> To convert the phase delay to a phase angle and back would require also knowing
> the frequency of the input voltage signals.

Maybe calling it "conversion delay" would make more sense? Since the phase part
of it is really referring to the application rather than to what we are actually
adjusting.

