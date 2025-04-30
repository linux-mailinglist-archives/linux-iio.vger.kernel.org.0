Return-Path: <linux-iio+bounces-18902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CCEAA4F34
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A793BDA64
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295261AF0AF;
	Wed, 30 Apr 2025 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1iUsR0Y3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842D19F487
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025008; cv=none; b=NNahA+tBKHd9FLCTG1fXggYI7iCaUjAhPbtkQqhCI7qGfzMxMmVGjwLvI/bY+0P/j9l9g/Qqaej/j1gky4IvhNLDWkoRVTa2C4QWtNRc53Dp2ITjEOhva7n7l0OV+Q78hPzO3uAD6fbV1SF4G4vB+FvPs5WbG1+03vkzWz/viZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025008; c=relaxed/simple;
	bh=2NcOLfzZKue6h2awXGoXt4niifDn/e+a1VZPDlSG97o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaGIOK8zqOtg9sI66l+aEJzuLcNC3hN3Irk8ojiLS0d+gI/vw2HnhGAdzsmlcUCTxOhdE4pEQO0Cy9BejxYkuB8lt6sagNS1EqUDcbEwUz2FBVJ1XCZa+tVUwmjGHPX8EQSNqYJq34SbyiMunZMy357+7Nqef92a5nYIG8ujuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1iUsR0Y3; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c759bf1b2eso4334538fac.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746025006; x=1746629806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sk93f/QmfWRFnir5kQcAvlAIOBCq59GYkwRW++xpxLQ=;
        b=1iUsR0Y3hX0/HHa00t77cOkQ+I+QktEI9Fq6epgrW8Hm915ukNUi0oYIul+88EsxiI
         ybsYBcKiHl28aLYStRJKuRlszVK9gVi2q2x/I+InHeJfOFzP7IiBVqnPC7jrHs7WvliA
         rbKpaIqh9KO4cxUiLSkEjzXvt5wmOUbdYdIi8KqqCRdxTYUaFwgnpl1tl6HszIOlw6FX
         TaNP9kVjVHkZK+In5HNx8yJSsjIXORn//bDHHS9eChWEA6tmvb9rgdJ/GqUzrSmn3uYk
         3rSZ7K2rIeha+4E9zi+WMgitKzjCT7Lyjc/JRlCFznHcJsBPgP3X6i2T/aZGj7e4AkIK
         q+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025006; x=1746629806;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk93f/QmfWRFnir5kQcAvlAIOBCq59GYkwRW++xpxLQ=;
        b=B+LcMNYwpdUaXTD40cc7sySijt8GwBn59wGB5PN3Oei3sAuaW9osVbQgH33qBeCa1K
         MTZopmV2R50fNOUVyCx1KfU5DDs13RvCAh7Vlz+YiVttvx5+XdgUMQv8xOTzZAmmMma4
         YmcRBmrqHIOdqnhlHMuh4F1XTVdHRmOKd4OVW/fGvSKKCoKhw3rhiRKa0Q2I6/yCfLO3
         /i04Cw7pCtlc2af6VqwLuIfa3uwhScAmEvIgcqchMOkKBLIkRNALsqTe+aKYauGujADm
         VTPCtUn9c5IWO991iJx/U11R7VqN+QJOu2tFBwtf+c91iLcdjJS8513Nq0SFu0zoBNpe
         4htg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7HhdhPz4OUr6yxyIGG3eQkCSY432JavhdKyA9FnrFRSgvF2zvuXFmFLBKRaw0BSc7dV5Cmbc4ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBJ1fVvVcHYH20f8FVpSKo0WUTbN5h6k12fLtuwfiyJc4nE5e
	mft97Vh99GRLBeUTajcfMQ/wCZ7Z/7YP/mkBVMEAWsg95tmjIHI5bdZEhD1zN8w=
X-Gm-Gg: ASbGncuQustyrrqBSFU5a+sgQ+gLemNdSE/e7YHvHE0WXcrYqC+Cxqjj2ttCpeUZ2mF
	SVwVj8jrqUFiqQRetdKUubl1n/MVr99yHPh9zAUA66vF61TFBJWhbZs2IzfqQagJXyEAUgln82o
	6kWiguv27zBSJx8v/Z+eOvQPmhFqI8Kg/avnH+k67orYVROJgj8llqx8P66KaFZlQNWJliW2szq
	JUpim6Hm8JCcVTAnJq9Ekz1dfmss7sikCg/oxkpKXSiDOnILXqCNMKlvXFQm1sZe3Y0AABmE0K4
	6eyRpvj1flFj3DOwMThcvooIxvlHH+O9QDjGNC7H+E8sUNExlWyvML5HfsR8YBkEs3UHXn/VNKv
	tA2HjnMEcdX0O2yM=
X-Google-Smtp-Source: AGHT+IEKD9KMxxcH3+s+rQUgR1CdT0kXIMoJRPA9zp3G4pnlVTK9HHZKKfZE0x8ViCpn6Iz77Q3PaA==
X-Received: by 2002:a05:6870:e98e:b0:2bd:455e:c22e with SMTP id 586e51a60fabf-2da69f21801mr1756582fac.19.1746025005850;
        Wed, 30 Apr 2025 07:56:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60686eec865sm808691eaf.22.2025.04.30.07.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 07:56:44 -0700 (PDT)
Message-ID: <896023ae-c279-4201-a7a8-dfd9b33fe0e5@baylibre.com>
Date: Wed, 30 Apr 2025 09:56:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Documentation: ABI: IIO: add calibphase_delay
 documentation
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
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aBI3eUPirZEXpZgG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/30/25 9:45 AM, Andy Shevchenko wrote:
> On Wed, Apr 30, 2025 at 09:21:28AM -0500, David Lechner wrote:
>> On 4/30/25 12:40 AM, Nuno Sá wrote:
>>> On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>
>>>> Add new IIO calibphase_delay documentation.
>>>>
>>>> The delay suffix is added to specify that the phase, generally in
>>>> radiants, is for this case (needed from ad7606) in nanoseconds.
> 
> ...
> 
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibphase_delay
>>>
>>> Not sure if I'm too convinced on the _delay suffix
>>>
>> Phase is measured in radians, not seconds, so it seems wrong to use it here.
>>
>> https://en.wikipedia.org/wiki/Phase_(waves)
>>
>> And the delay here is with respect to individual samples in a simultaneous
>> conversion without regard for a sampling frequency, so I don't see how we could
>> convert the time to radians in any meaningful way.
> 
> And how this delay is aplicable to the phase in the hardware? Sounds to me that
> HW has some meaningful way of such a conversion?
> 

It is a calibration to account for a phase difference between two input signals.
This is a simultaneous sampling ADC, so all channels normally sample at exactly
the same time. This phase delay calibration factor can introduce a small delay
on an individual channel so that it starts it's conversion some microseconds
after the others.

There is a nice diagram here:

https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf#%5B%7B%22num%22%3A113%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C34%2C594%2C0%5D

To convert the phase delay to a phase angle and back would require also knowing
the frequency of the input voltage signals.

