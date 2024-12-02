Return-Path: <linux-iio+bounces-12928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FCF9DFADA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 07:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83FD2818F2
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9D1F8EF0;
	Mon,  2 Dec 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzeHfWzk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44C1D63FA;
	Mon,  2 Dec 2024 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733122016; cv=none; b=Un18Ym+H+DejhxUeIZ2x7GvycGtOHJotvIxAXQJqUUC+tMqW79HdqLpRi5P/fM10k7wnbTYI9q3Q/GUn/DG4neKuYXIlOgbQKvXGFiFHqEHC39vyNks4u38D9MKWNWcTXWynyNDbkGs35/JG2pnB7vP2/2QMKD+Ltm6kuaNFePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733122016; c=relaxed/simple;
	bh=BGKKT4M7B0mxH9LQy3CTxmDnpSGj6ANQv/xzPYnQNCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsVI2GkAS3Bn0lnW7dmUE/UdR7rBaHegg3YxRuzZNTb0V0sEK42ccUmr3uYrSDUvKcatsCn0UtBD0GKRrGaZbH9GhlpKfEq2s31PO3o06iR2Rd6fPrKzsJWeLxQAkDIcp98y3OlFP+MfumqmoLtqsRWVlbLDkHwS8z6qX7grT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzeHfWzk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df1d1b726so4378762e87.0;
        Sun, 01 Dec 2024 22:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733122012; x=1733726812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTzKZUoU+tSJjf2CzUJWcZUzAimmxO6c48VQPd9iPRY=;
        b=fzeHfWzkmFmNod9eZj/ZhKe2nyPe0Nw4v2x+2RnjLBwyrUke1bjJy/6tODZ5kn03ue
         4gkZqYla+2B67iHMiZbTfMIwYovOkAttbQF6U/5x851UOChI+N93fGLCidi8aVuzfSbR
         eZdI9E4C0nHHoM7Fb5WUTm8iVlKD1BYLQgolJWMPmrjFfbpOwLEiTDqsuF9S8X/fQBc0
         Wzak2pjOAMlukdbq55YeQ05VAgNaB8O5Iudpo7t7XLgrLg67Io8OTpXtG6/StwEt8MF4
         e4AEVUaRh5VqCYQsuH4kxsfsIRVR2EmLGx1Ppv/rGweR2aCm6N4uqpM2CIoJWJv3kLkR
         639A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733122012; x=1733726812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTzKZUoU+tSJjf2CzUJWcZUzAimmxO6c48VQPd9iPRY=;
        b=vLJf9Kj0e51IwJwPay1eTHO4ym+SHZ2hn0KbhbiOeN+YSn4WCfLOfnu06MrsXjuNqO
         CUhfs1FxQkSUBU9HnKjpZBdDVwR6Q40jWschVw3TDztCql3vb0MV/eHAcJOXbTaGs5xi
         yvfg2W4KMjb7VkEtSeSbCJVxosnIfK8SLX/3D9zhRxHfcKrQEVSofGa1Tf9g7Ll4Abat
         WWshMEZw1jDdGbHLqBCY/H0RHDnc7/LYfQwXtCSeZLkTRHyyCZjhVHYZ5Ypu9+J4akQH
         QFKv2Zjq8yTPyUxZr5NQMizfcL9LGPQfNrFg92/OVONUpItiZVxoGV/lD9K9OMLzQCb+
         TrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzMekcGtCUcIUFY0JWCSJiH306/5PF6EB2A9Kf4gIbsJKYdUYlvR5b337m9uEUBmp2ziP6uPoMC98+@vger.kernel.org, AJvYcCWOsPApz3Y6rHY6liDmdgRukaTFFYEnZI3qtXJa8DsvUbI6KCHTVdIAqps6jrHo2BnfrH7chMbO8mQ7@vger.kernel.org, AJvYcCXPDLAmgel6WteSUFTCI/fbnbgVTJYImQpxIJV6BGnFM7ZV9V+wmrRK9j94TmfVwxAOMKOutr1WlYo7f7H+@vger.kernel.org
X-Gm-Message-State: AOJu0YzIddGfq+F/943MaZ92MO4Y+cIC9uZkwLUWb8pJu8s4dVKL4ucV
	CY2w6ntvGIrhTbkzPGxxkXlpHvbmduE8q1v624otC19tLi84F26nUmi89Q==
X-Gm-Gg: ASbGncv0kwBS3KjjSQlkJ3hM+Y6t3OqIiVXMeMAJ0VBopsvosjI8SPzzntDt25xSbwd
	cdXgAYk4sYH0rgigDXaWmk03kLzfRDeG+JU6z6FOyRQ3+eiix9vQMuvAt5qmK7cJaRQ2IVOXW4m
	wl55p6WRTGdrkU8kmj5V7ZdHDanCXJBw9ZIvi/nPfAK3wEuOfJtY/4CIKFM/sDK863WlEuw2n9O
	CBw5oecrnba5L8V81mSdspAZ9uB4SVWcIS1Lm1oQJpZws9UzWyin5I47ot4HeotolGL8mTaBhcv
	q5Br6Gj2Tg7Ww7dvWTX6mTUD2HeAAq8=
X-Google-Smtp-Source: AGHT+IGT1CTRHEZ51DGMX9V+sWOuY45xKYqAVKYGhRYRSyCDmD7rrN0ZQiHjblIK8mLkO1bisFQHpw==
X-Received: by 2002:a05:6512:3d93:b0:53d:e537:c780 with SMTP id 2adb3069b0e04-53df0104745mr11017388e87.35.1733122010882;
        Sun, 01 Dec 2024 22:46:50 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443305sm1363510e87.79.2024.12.01.22.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 22:46:49 -0800 (PST)
Message-ID: <a52bce75-c1df-453a-b54e-2dfbeb9c285e@gmail.com>
Date: Mon, 2 Dec 2024 08:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732783834.git.mazziesaccount@gmail.com>
 <9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>
 <20241130181506.27d0c72a@jic23-huawei> <20241130182628.3d35817b@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241130182628.3d35817b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/11/2024 20:26, Jonathan Cameron wrote:
> On Sat, 30 Nov 2024 18:15:06 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Thu, 28 Nov 2024 11:03:40 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Many of the Kionix/ROHM accelerometers have a "PC1 - bit" which enables
>>> the accelerometer. While a sensor configuration like ODR, g-range, FIFO
>>> status etc. are changed, the PC1 bit must be cleared (sensor must be
>>> disabled). (See the description for different CNTL registers [1])
>>>
>>> In order to ensure this the kx022a driver uses a mutex, which is locked
>>> when the PC1 bit is cleared, and held for the duration of the
>>> configuration, and released after PC1 bit is set again (enabling the
>>> sensor).
>>>
>>> The locking and PC1 bit toggling was implemented using functions:
>>> kx022a_turn_off_lock() and kx022a_turn_on_unlock().
>>>
>>> Based on a discussions [2], the IIO subsystem prefers open-coding the
>>> locking with scoped_guard() over these functions.
>>>
>>> Drop the kx022a_turn_off_lock() and kx022a_turn_on_unlock() and use
>>> scoped_guard() instead.
>>>
>>> [1]: https://fscdn.rohm.com/kionix/en/datasheet/kx022acr-z-e.pdf
>>> [2]: https://lore.kernel.org/all/20241126175550.4a8bedf3@jic23-huawei/
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> ---
>>> Revision history:
>>> v2 => v3:
>>>   - New patch
>>>
>>> NOTE: This patch uses the if_not_cond_guard() which is currently missing
>>> the iio_testing.
>>> https://lore.kernel.org/all/20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com/T/#m69982b23da9f71e72d84855b34e9b142cb3a1920
>>
>> Looks good to me.  If no one else comments, I'll pick this up when
>> I have the precursor available (so hopefully just after rc1)
> or maybe not.
> https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com/
> 
> Seems Linus is unconvinced.
> Hmmm. We might have to roll back the uses of cond_guard() entirely.
> Which will be a pain.  Ah well. Sometimes an idea turns out to not be as useful
> as it initially seemed.
> 46 instances to get rid of in the tree today...

Ouch! :( Sorry to hear Jonathan.

Yours,
	-- Matti

