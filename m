Return-Path: <linux-iio+bounces-25851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF6C2C791
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C123B9548
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141A30C610;
	Mon,  3 Nov 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X2Q5KfRZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF22836B1
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181166; cv=none; b=HnoLLO3woUX6QJg7iqsS1PstxhR0oiAT2WK6ry9k3kX0GxCWZp/UuSgIkpkLdSkrQOl22eXhwmyXkZp9JqRgMn/Ck5vWQ0aU6pzcISd6+zmdznK4yLKrNCe6DR83JxFri2wC+EhUmpNf5rqckqwSEAnNRFqWZj5f1dw5v/9ekLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181166; c=relaxed/simple;
	bh=fs/2by/S27WDPm0ilbh5zFhuJpMec2Iy6t4szQvymlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4RuVMkGx+BFL/r3D29PAjTbZwpWywq1KQpBBCtDrSltjgJvbD1b46A6AAV+73meSlLEGOg8wcIyMwshf+SLjF3yHqLbfq/etoVF+CBrqLe5Pm+JNqLPiYyMitSpdCyqHeTP7gvfhrxzi7zgnm4li3TWEJRfCI5gzfAqbh0MfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X2Q5KfRZ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c284d4867eso1210632a34.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 06:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762181163; x=1762785963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDHP+mLFk92r6h7AxBTCn7EZSCxWKQie4OhNqh3d/ww=;
        b=X2Q5KfRZ0QP0bfsCV9/RJeH6irH9sQBy1Z9KMVKRv/bN2s8omz7llSIkykkMVo/r8m
         f4mJD5EogbOB10+6CwXxzoEujkK4h66PyejIE1ow47NBmL2gyZlEsVjlYNUkrwwnARgX
         esVO1UpaduvKFX7ffsNK9i9KP9XqLcyxCqu8hrP/sZHFea2zeqxRRzlYubY7IJZU881u
         q8HEOLWGoAG580qOzQkbFPyOLzZQmTmGfBmNtPcUsZOxz4rC8/uel0Io5FXWP9eb4GfL
         YjZtr+iFc27//7b30bguUC89ITZtAvF4euKv4RI9TQFGqNF0zyi5apiCoRrScSvyOOWE
         egcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181163; x=1762785963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDHP+mLFk92r6h7AxBTCn7EZSCxWKQie4OhNqh3d/ww=;
        b=IZvzS67TBBpENUmOwB+PKcpUeGIlEZAmnqSKvtgG+x94AJBA7e0TpKf9rw3O2xaGLl
         xdTKCay24BYQxj4dvzvenivXOBOZUtbsM1NHwzWoHzkc1i8tRViCtUMwlvMUn8w1XYje
         okX85dzOrZQXK3j8n6wXHelC1wR/BhdFaPLEQn4ivdOqgzGA6iA1JJY2a/n2mqfKckF4
         els3bOrvjR5KeSvL8rhooEc1FB3I9LoyPl4hFKVkoM2nqkbfZ2hqU7btnHnDyPyJRD2e
         wusQNMIZjWu5Jorin0xlShE0fD7qV7TqVSaFSB4OaEGgh6N9XH4dKeRMqX5vy01G90ba
         u4kw==
X-Forwarded-Encrypted: i=1; AJvYcCXS6Ds6jzqUvPzH/rcpszdOS8fyLLLGmO8HzJluZOZgymxjYhprpKF+ge2PkUcswXC4smshKC0Uq54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hL/zoCT4mYFy1cJj+4bBPKnwAqI3APEah2SKusfDCC5MGl3P
	vuFqpCzuapRwdQj4Obs2gvm17pU5sgE1iPV70V3WWzk+QTDtS+gju+XNDyGaYVvOIxE=
X-Gm-Gg: ASbGncsS0R1RgIqpNJvbfvi94+DFoNJaPyyMnXAoySWI0MPr7ckzCBlcOvGEq78FFZB
	rqHWkwiyGkH+LOlqKSEbSHvxkweWSXKPmWqtVGMOAD7y/zLxcOC8Qhhs4M8EX4ai8jKJSefMzPE
	7QkqV0xmY04PVtLzVDVOFeWKJDlarX1yb47OOTcyIWh0qEY/0gPnMs8WuWT6aHkon2WLKFM0Z7d
	l8NP71rltFDbaTQ98g7vaKGGyToSNW8alrKegZ0G3vEvINtyySi0jVfcmulh8m2F7Tx5J35us7n
	1qLOhGVbKD19qBG/ZteygcndEiyIZscrUh8gRVhmhFI0uxSVqvfx9wDdOPRXiQbBYffDY6er9t+
	ikH9UGfxqLFZ1KVtXVwNyyRxzQgJefoLYyPSmzM9+c3SD9LcL8j3XVeNhrPBEXIwjop3gfZUkyB
	+6J5M9WvhYkCFdg7lmXL1rHJDrER7HUf6UVBo4ZGxV74GEHvgAgC/2eR5+kdqhpKKzuBG7vlY=
X-Google-Smtp-Source: AGHT+IHncJLjW6SAXBWAuFDI30CJXo0InftwPdqGHG+Ii4HqdxDcuIic/Wojt73xZVCmFH2UZVHohQ==
X-Received: by 2002:a05:6830:4422:b0:760:6ff1:2995 with SMTP id 46e09a7af769-7c6967dc593mr6819660a34.30.1762181162575;
        Mon, 03 Nov 2025 06:46:02 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c9:fd3e:34ae:9253? ([2600:8803:e7e4:500:37c9:fd3e:34ae:9253])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2474ae7sm180122a34.14.2025.11.03.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:46:02 -0800 (PST)
Message-ID: <c365b17c-de18-4718-8d51-fa1d93236d90@baylibre.com>
Date: Mon, 3 Nov 2025 08:46:01 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
 <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
 <20251027140423.61d96e88@jic23-huawei>
 <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
 <ca6760182b4662c96df6204bae903d8affa6a8e3.camel@gmail.com>
 <aQisqe5EWARTwpQq@debian-BULLSEYE-live-builder-AMD64>
 <1c3712b9b5313ed6c9d07c1acbc9b918a4883056.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1c3712b9b5313ed6c9d07c1acbc9b918a4883056.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/25 8:30 AM, Nuno Sá wrote:
> On Mon, 2025-11-03 at 10:22 -0300, Marcelo Schmitt wrote:
>> On 10/30, Nuno Sá wrote:
>>> On Wed, 2025-10-29 at 15:11 -0300, Marcelo Schmitt wrote:
>>>> On 10/27, Jonathan Cameron wrote:
>>>>> On Mon, 20 Oct 2025 16:15:39 -0300
>>>>> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
>>>>>
>>>>>> AD4030 and similar devices can read common-mode voltage together with
>>>>>> ADC sample data. When enabled, common-mode voltage data is provided in a
>>>>>> separate IIO channel since it measures something other than the primary
>>>>>> ADC input signal and requires separate scaling to convert to voltage
>>>>>> units. The initial SPI offload support patch for AD4030 only provided
>>>>>> differential channels. Now, extend the AD4030 driver to also provide
>>>>>> common-mode IIO channels when setup with SPI offloading capability.
>>>>>>
>>>>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>>>>>> ---
>>>>>> New patch.
>>>>>> I hope this works for ADCs with two channels. It's not clear if works as
>>>>>> expected with current HDL and single-channel ADCs (like ADAQ4216).
>>>>>>
>>>>>> The ad4630_fmc HDL project was designed for ADCs with two channels and
>>>>>> always streams two data channels to DMA (even when the ADC has only one
>>>>>> physical channel). Though, if the ADC has only one physical channel, the
>>>>>> data that would come from the second ADC channel comes in as noise and
>>>>>> would have to be discarded. Because of that, when using single-channel
>>>>>> ADCs, the ADC driver would need to use a special DMA buffer to filter out
>>>>>> half of the data that reaches DMA memory. With that, the ADC sample data
>>>>>> could be delivered to user space without any noise being added to the IIO
>>>>>> buffer. I have implemented a prototype of such specialized buffer
>>>>>> (industrialio-buffer-dmaengine-filtered), but it is awful and only worked
>>>>>> with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree). Usual
>>>>>> differential channel data is also affected by the extra 0xFFFFFFFF data
>>>>>> pushed to DMA. Though, for the differential channel, it's easier to see it
>>>>>> shall work for two-channel ADCs (the sine wave appears "filled" in
>>>>>> iio-oscilloscope).
>>>>>>
>>>>>> So, I sign this, but don't guarantee it to work.
>>>>>
>>>>> So what's the path to resolve this?  Waiting on HDL changes or not support
>>>>> those devices until we have a clean solution?
>>>>
>>>> Waiting for HDL to get updated I'd say.
>>>
>>> Agree. We kind of control the IP here so why should we do awful tricks in
>>> SW right :)? At the very least I would expect hdl to be capable to discard the
>>> data in HW.
>>>
>>>>
>>>>>
>>>>> Also, just to check, is this only an issue with the additional stuff this
>>>>> patch adds or do we have a problem with SPI offload in general (+ this
>>>>> IP) and those single channel devices?
>>>>
>>>> IMO, one solution would be to update the HDL project for AD4630 and similar ADCs
>>>> to not send data from channel 2 to DMA memory when single-channel ADCs are
>>>> connected. Another possibility would be to intercept and filter out the extra
>>>> data before pushing it to user space. My first attempt of doing that didn't
>>>> work out with upstream kernel but I may revisit that.
>>>
>>> I'm also confused. Is this also an issue with the current series without common mode?
>>>
>>> If I'm getting things right, one channel ADCs pretty much do not work right now with
>>> spi offload?
>>
>> Yes, that's correct. It kind of works for single-channel ADCs, but half of the
>> data we see in user space is valid and the other half is not. For two-channel
>> ADCs, everything should be fine.
> 
> To me that is something that does not work eheheh :). I mean, going with all this trouble
> to sample as fast as we can just so we have to discard (or mask out) half of every sample
> in userspace (even though I can imagine we still get better performance vs non offload case).

If we are getting extra data to userspace, then either we aren't creating the
SPI message correctly and telling the controller to read too much data or
the HDL is broken.

> 
>>
>>>
>>> If the above is correct I would just not support it for 1 channel ADCs.
>>
>> Currently, it's just one part that is single-channel (AD4030). If patches 6 and
>> 7 were accepted, it would be 3 single-channel parts supported. I can add an `if`
>> somewhere to check the number of channel, but it will eventually have to be
>> removed when HDL gets fixed.
> 
> I would probably do the above or maybe we just need to push for an hdl fix or some
> final conclusion (like if they cannot fix it for some reason) and act accordingly.
> 
>>
>> Or, if HDL can't be fixed, then we'll need the `if` now and something else
>> latter to filter out extra data before pushing to IIO buffers as mentioned
>> above. Though, this scenario seems odd to me as I think the HDL wouldn't be 100%
>> compatible with single-channel AD4030-like parts. We would be writing code to
>> support AD4030 _and_ a peculiar data stream from this specific HDL project?
>>
>> My suggestion is to apply all patches except patch 8. IMHO, SPI offload
>> single-channel ADC support is broken due to HDL IP data stream not being
>> compatible with single-channel parts. That's not a Linux driver issue.
> 
> Well, it's not a SW issue but we are driving the HW and we know it's broken so I
> don't see a point in having something that does not work. Given that this is so
> connected to the HDL part of it I'm not sure it's fine to ignore that offload does
> not work for 1 channel parts. 
> 
> Anyways, it's odd to me but ultimately if Jonathan is fine with it, I won't object :)
> 
> 
> - Nuno Sá

If single-channel parts currently don't work and two-channel parts need [1] or
a hardware descrambler to work with a single data line, then it sounds like we
are blocked here until the HDL is improved or [1] is merged.

[1]: https://lore.kernel.org/linux-iio/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com/

