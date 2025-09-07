Return-Path: <linux-iio+bounces-23857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E67B47B62
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC66189FF22
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015A26F29F;
	Sun,  7 Sep 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He3WXDuW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B555C88;
	Sun,  7 Sep 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757248917; cv=none; b=DO5k9DQ4THPrNBE7TyyC/nshDBQqJSjokMFZgrw1XlvGRNbyYf3yhkgVHokBIewc5j8pXoqp9vITGS1obLlZToVzHATxRWVsoSH/Za/1CaJrSvjtt21MFyVoQXUGj3vGUPJKheNkEl0R8Kwthc+lr475INWKVv/WX0EoLebyb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757248917; c=relaxed/simple;
	bh=SnHjhs2yApPbBCCwhqp/mqzVT1uN/mjFIYxuY+jSiZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uS62QN/yVgSvkSRz38F8/IZzgjqxq33I+pSEAZb4s/rSEBaaKfbUt6POD3Kht9C1AUTmRK5TnFv0j2bcOjdRq78PnLsLPZpfEMhyTSSkbdkTZ1urPXl85PdLW66slD25BjWJbg4JLMJce2RlSkNy+Ezm/Hbwjd7YkJYegbtwG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He3WXDuW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-337e1ce5dd1so26888811fa.3;
        Sun, 07 Sep 2025 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757248913; x=1757853713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=En4pEgo3HzN81VOXQC3uWh3DV4FBwtg/Su3ZTWTLHHg=;
        b=He3WXDuWYIa19HQIiyPhx13O7m9oHdhduONRqMxEwKBfXLY6Sh95Ov2nT/GYA7YRHu
         cba7enNe0hIWud35WNmAZkcLOa0rcrwBohTPplTx9TVWJLid+o5JAh5nHqTZU5eNgG1x
         7q0Zg/kBV2xTFJgf8zL0VpOdnDEoR0TDhkNg3W5wDLRDpsllltxLsony0aFTx1sIymjO
         teRmtgOJp3qpLqkzSLnyBe50/UPhAz5scPqxGHXntXQfkzgifozrR9HROGvr8MFu8f08
         GWOzQEkWiuPNPJLrmQvD6ZnVIEgMgwbqBd5Hoph+vWCpMc392d/Xl7hXarC1k7W/MIky
         R5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757248913; x=1757853713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=En4pEgo3HzN81VOXQC3uWh3DV4FBwtg/Su3ZTWTLHHg=;
        b=LWr69nYjdEiOjeaK36DKKxr4BmKL0t7g94bkoqAuRD5YZNzp+CIkhOx5RdbZym6JgX
         GSHWkcdIMGmS71MHcjsRKyZKYeGX2WYYa1N6Qid0vPLwWCVtySKK+Oc42GIho3yDQJRO
         kAV/8cz2JylSXfAWFJWOB8YsFAFD2km9AiVcrp5MrZ2BhmdBfZ2yhol4wFf6iiYzxa/Z
         EuTbQAcVs2xKVJXRTXC5xcKjvkSQB61oicrnAY+AJELfTnUJl1KBT2ppF8SkNr136Q+R
         yo5SNVrnVFRZcPDxLOmhREWqpLXWFolwlcUlg+GQbdnjh1gCVSoHNlJZy1qpd+kVki2D
         x59Q==
X-Forwarded-Encrypted: i=1; AJvYcCU58SEgW9GJ9lf8rrGbhiC6oUmWRViUgrqQ9Ns+A3kiNxcm3Yhi+FYQJdUMMVsxKAnFddbCu4AL/k3Gug==@vger.kernel.org, AJvYcCUMBtm6w34lt2DGQBSCoenxfXWbrBX4O+dEsQOhhi2uTcNt6IhwGbNIBEcoMB8DLY98/yDuDwjeOBtP@vger.kernel.org, AJvYcCW0E33OaPDzlBNv86vwKtzHGl+qgyTZNTLoUGxngyRWjzOx+aJd9qpZCJu/gHAFCJ7c1xfmbjla21bGbCne@vger.kernel.org, AJvYcCXZ6yhTUDG9zS41hQT7nAQLP409UmO79GXotZZP+o2cwJWM4Bjlgw2G3+1lZnKfOIEQo9YGhKuJwTC3@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGPiDcyEiTvPyDOwNYtWVcwdpq0YUNW1B8Q0QuQMxtIjRNtwx
	RFi8JmvvZATlalk8lfoajSDktwIcgK2H1xQxPW8CuDVNyFbCORJ4mZep
X-Gm-Gg: ASbGncuYMOtPjBkcR5SXVggOZVplcBN0qDoO80v5UWw82Nse2Qi9fzZ+30ArTzHoob6
	6c5ukv5aS4kqxamWcP624Rm0OWGg8TuOI7Pp92rbXQKQGSZ3zjV/AXMmgAuE7cL0VJEsikjF2CC
	aecLpWIpdfblGZ9GnBlU9gP/rnPfbBSWvRi6uwPhSbjjXUNrx1OlsRcpTuvOV02lzhCt8iqWi4L
	TNeC8Sa2ufE+45KjLnO+j8lxyRf6+nCBIxQb/4q9XD40cpK8SEWPYbm1r4a9Nc4Z23oGFOKdE0V
	hcY+ggzDCAbJHjUvlJ8D2+exF0yl+znc4kZrqX6lQWrrUr6cjkHhpP2j+lu786i/FzHnvFNn+ff
	DaYWJW+3/3YGe7Io8E6KT5zn2bjpO+OdBn4sWAcmIeJttBtaSjlPymhQ2hVv3qvGDrSyYiXFoz/
	Fwv3o1FvtVUJiJcmE=
X-Google-Smtp-Source: AGHT+IGIVc7DdUcow7qdN0jKbRXTXIAiOaBlx1JI72g5IVucoKwojWQtzdcnKlAJrBM/N5ve3UFaYg==
X-Received: by 2002:a2e:a54e:0:b0:339:1ceb:33db with SMTP id 38308e7fff4ca-33b608c5982mr12243511fa.38.1757248912796;
        Sun, 07 Sep 2025 05:41:52 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c5030csm29410381fa.9.2025.09.07.05.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 05:41:50 -0700 (PDT)
Message-ID: <ecd6cf45-0d60-4f88-a24a-14a5b84c4007@gmail.com>
Date: Sun, 7 Sep 2025 15:41:49 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Pop Ioan Daniel <pop.ioan-daniel@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756988028.git.mazziesaccount@gmail.com>
 <facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
 <aLmVzDB4bk-z5d16@smile.fi.intel.com>
 <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
 <d9aa680f-0664-4caf-b885-92c3fce6c7a4@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <d9aa680f-0664-4caf-b885-92c3fce6c7a4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2025 16:18, David Lechner wrote:
> On 9/5/25 12:41 AM, Matti Vaittinen wrote:
>> Hi dee Ho Andy!
>>
>> Thanks again. I really appreciate the effort you put in these reviews! :)
>>
>> On 04/09/2025 16:36, Andy Shevchenko wrote:
>>> On Thu, Sep 04, 2025 at 03:36:46PM +0300, Matti Vaittinen wrote:
>>>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>>>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>>>
>>>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>>>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>>>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>>>
>>>> The IC does also support CRC but it is not implemented in the driver.
>>>
>>> ...
>>>
>>>> +/*
>>>> + * The data-sheet explains register I/O communication as follows:
>>>> + *
>>>> + * Read, two 16-bit sequences separated by CSB:
>>>> + * MOSI:
>>>> + * SCK:    | 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
>>>> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
>>>> + *
>>>> + * MISO:
>>>> + * SCK:    | 1 .. 8 | 9 .. 16 |
>>>> + * data:| 8'b0   | data    |
>>>> + *
>>>> + * Note, CSB is shown to be released between writing the address (MOSI) and
>>>> + * reading the register data (MISO).
>>>> + *
>>>> + * Write, single 16-bit sequence:
>>>> + * MOSI:
>>>> + * SCK:    | 1 | 2 | 3   | 4     | 5 .. 8 |
>>>> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
>>>> + *
>>>> + * MISO:
>>>> + * SCK:    | 1 .. 8 |
>>>> + * data:| data   |
>>>> + */
>>>
>>> I don't know how to read this comment. In the monospace font the whole block
>>> looks like a mess.
>>
>> What do you mean by a mess? Don't you have the '|' -characters aligned? That's very odd because they are aligned for me. Or, is this otherwise unclear?
> 
> I find these diagrams very hard to read as well. I would just drop this part
> and let people look it up in the datasheet. I don't think it adds anything
> essential to understanding how the driver works.
> 

I am a bit reluctant to drop this because I don't see public data-sheet 
anywhere... :/ I think explaining the protocol is somewhat useful so 
readers can understand why we have custom regmap read/write functions, 
and hopefully also the I/O and RW bits.

I am all for improving this documentation though! Starting by dropping 
those tabs, and seeing if I can think of something else too :)

Yours,
	-- Matti


