Return-Path: <linux-iio+bounces-24086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C35B56761
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577B5189AEB5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFA238142;
	Sun, 14 Sep 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou2ulugE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC7233149
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757841911; cv=none; b=SKOckW6DcUuGl81MYgtCJy4vu11W6qFl61r3QmUHvKbk8xnB0LTpHqYI37RNewP+BeJL1mLvqX2I8Uwsa2LAm62FEjer0SuQg7ydRz+2W/BHLMHUDv1jyJ+F5/0mtDs4KjkouMIgW9ElpZgf6HtiGcR2SR3wbqV9OAxCc5LJggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757841911; c=relaxed/simple;
	bh=+4rCll//JnoBBbuxAXcj/sXjckzLz0gNp0tqg1XIkys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+h2wnrUcOnCKIO5VA1+ot7w4cO9l6dVC9WMZ4t7h6JUSvpz57RmGOpGSBY36gfyayD/7LxiIDHMS9cZGbnXAwVsw8ZP2FAAN7Aj9Ic7qbFqRG6+rBcmO8Pzx1a30y/HlYS9TVMrxiwqL8lbuKcoRWYcJlx8Ja+hA5vno9lkR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou2ulugE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5725e554ec1so622776e87.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757841908; x=1758446708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ho58j4q8V+4E8zb9CufZ62itbJsz3Kolr/iP45Pw0Rc=;
        b=Ou2ulugEbuNt8gwKSxoQkbh5M4n34ZRR3/ZDIZ5cHlHNRYeQBYHALfXK9DRrBY4iMz
         H38ZWIiQg4U61NU2YFwIADh86IdCr27GD4JJXwOOf9WlHT6OKgwjJKKmaa4G9ehHWUvf
         ePMGvobZWCp6JNqfjvUpXGDQvP2J2pVFdZzwqL78nudqx82gBKOvNvldXLpnbBUXWeqJ
         pbD8rpXsXXRtfOGn9PBpvwGCHH8hLoMJnwuSCDSbspHRW74dgJMEJ39gH+QD8poYtEfG
         v2vSYpOjobnF31Njp2cBVmP80vMxnJ/gVDq6v9LFu+/shNgPHNyOO42sSTjdS585T6ah
         p3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757841908; x=1758446708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ho58j4q8V+4E8zb9CufZ62itbJsz3Kolr/iP45Pw0Rc=;
        b=DpH6zZ/3d71RUeP4EM30jsLu3kmWFsie20kPGJYUX461HQgLD8OZrl8/yVeW4UoQXg
         6hRYmLbXMG/XqpHUomlvXXH0EvYikMme50T0d7GzqtVIfNQ6aL6pI0TdTTJiw8Ta0H1P
         YBKbwbL7ub7s6/8DqsZ/Tf9hi+d1v9rEJpvXdbqwe3mTN+6ixvT0pR44LoDq2fHDmmlG
         jXXA4o9z/f465U1U1HVBzJC7aikZvSB1+P9MLAo44EwXZcisjAYMXYb0f0e/LdT9Lbpx
         8w888rxqIc7XBV7JGpeZAjWFk+QymSNT6gSE0PKZZVHK5RVeg7Vpa6129ExdUD1T6J8S
         uMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWmfwnRtObgccUioAcY8MLfyfUzl0NjxJSLesFvqFbnYLSyuZ5E2LdmGLP8zJAV+VKcfiK5bmNEFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjwcIhxAFd/BoRHCt8MkA7jZUUgus3ec/tKVPciRN2N8XShr4
	LMie+Yve57Wnd9SC+K+GC2yNsvJH50478P8j5JAxCIH8nheq0cPFCwyT
X-Gm-Gg: ASbGnctZwZ3sRIViNw7M45WN1zfTIw5XzwLs/A857ZXtPGw1WYEiiaTqLFGNQguLKi7
	twp940XfoVvjoVUAsiKTbUAffIcYlhZ7RjEI8bSga/Z02tVg9GzMtRinBNZBdl1k1Xki94mNMl/
	QHMWIpyys85h2oTflmfDh0tLnguq1QGA+kYdblb5q8hR/R+8GLMbZe756WkXq9hG1j38rRi1XMI
	WBhfewQ6TwwN8r56oeCA+S7gKBwsWCgt+ZWjncugy2fvACb7LejueCQQ0MiGDIU/554qzB7Bndu
	JPuDrWjSjNQ4b+lgcqT+uzt/+JOkDQR+ADV4aXS0Eggpm6+MZg8wpRacDtq6LoOuGifjLSV8+W0
	YHY/mtMHa3eWvPFIgWI7WyUMR9QT4wRIYF8667GXFhCvnvEfmWkR4DRGA/i7oDR5vYVJFKUsSky
	u3niVcO4WUl+inLa4=
X-Google-Smtp-Source: AGHT+IGAdpstb81hppchzd4Q1HxoZsk6kfcEpq+JyA9XWnS84y0k2oKP6wonMMCI2UNWVAsmaWZNPQ==
X-Received: by 2002:a05:6512:140d:b0:55f:7050:9550 with SMTP id 2adb3069b0e04-57050440100mr2502409e87.38.1757841908140;
        Sun, 14 Sep 2025 02:25:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm2721362e87.25.2025.09.14.02.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 02:25:07 -0700 (PDT)
Message-ID: <7c1cd888-539e-42f9-8333-a68044257531@gmail.com>
Date: Sun, 14 Sep 2025 12:25:06 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
 <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
 <20250910184619.0303163d@jic23-huawei>
 <d586b4a3-8fb8-45b5-a5a6-5bee8d366879@gmail.com>
 <20250913132438.11d14416@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250913132438.11d14416@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/09/2025 15:24, Jonathan Cameron wrote:
> On Thu, 11 Sep 2025 08:13:03 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Morning Jonathan,
>>
>> On 10/09/2025 20:46, Jonathan Cameron wrote:
>>> On Wed, 10 Sep 2025 14:24:35 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>>>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>>>
>>>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>>>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>>>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>>>
>>>> The IC does also support CRC but it is not implemented in the driver.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> Hi Matti,
>>>
>>> A few trivial things that I'll tidy up if nothing else comes up (I might not
>>> bother given how trivial they are!)
>>
>> Thanks again!
>>
>>> Also one question. I couldn't immediately follow why any random register
>>> read is sanity checking if an ADC pin is configured as GPIO.
>>>    
>>
>> Ah. Valid question! I see my comment below is partially wrong.
>>
>>
>>>> +/*
>>>> + * Read transaction consists of two 16-bit sequences separated by CSB.
>>>> + * For register read, 'IOSET' bit must be set. For ADC read, IOSET is cleared
>>>> + * and ADDR equals the channel number (0 ... 31).
>>>> + *
>>>> + * First 16-bit sequence, MOSI as below, MISO data ignored:
>>>> + * - SCK: | 1 | 2 |   3   |    4   | 5 .. 8 | 9 .. 16 |
>>>> + * - MOSI:| 0 | 0 | IOSET | RW (1) |  ADDR  |  8'b0   |
>>>> + *
>>>> + * CSB released and re-acquired between these sequences
>>>> + *
>>>> + * Second 16-bit sequence, MISO as below, MOSI data ignored:
>>>> + *   For Register read data is 8 bits:
>>>> + *   - SCK: | 1 .. 8 |   9 .. 16   |
>>>> + *   - MISO:|  8'b0  | 8-bit data  |
>>>> + *
>>>> + *   For ADC read data is 12 bits:
>>>> + *   - SCK: | 1 .. 4 |   4 .. 16   |
>>>> + *   - MISO:|  4'b0  | 12-bit data |
>>
>> This is not 100% true. I overlooked the ADC read "status flag" when
>> adding this comment for the ADC data reading.
>>
>> This should be:
>>
>>    *   For ADC, read data is 12 bits prepended with a status flag:
>>    *   - SCK: | 1 |      2      | 3  4 |   4 .. 16   |
>>    *   - MISO:| 0 | STATUS_FLAG | 2'b0 | 12-bit data |
>>
>> The 'STATUS_FLAG' is set if the input pin is configured as a GPIO.
> 
> That's good additional info, but I'm still struggling on why
> we are effectively providing a 'debug' check in ever register
> read. My assumption is that it should never fire unless you have
> a driver bug?

Yes, a driver bug or someone accessing the ADC outside the driver.

I kind of agree the check shouldn't be needed - but I've seen quite a 
few driver bugs during my career. XD The check is _very_ light weight 
compared to the SPI access time - but you're right that it is done at 
every ADC data read - which is 'hot path'. As a result, I am not sure 
whether to leave or drop it.

Yours,
	-- Matti

> 
> Jonathan


