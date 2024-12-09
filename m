Return-Path: <linux-iio+bounces-13285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3AC9E9C9A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 18:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD914281FC1
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB7153808;
	Mon,  9 Dec 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lgmtZFvm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BD14AD22
	for <linux-iio@vger.kernel.org>; Mon,  9 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764034; cv=none; b=oDy1VWwwTWRtiMdDUDeP1YXFIq0d9mNUD2Wq8hJClKfh5SWyK1/ujvYW8+fpzcCtwHDPfyBlcqne7m8vtphH3dj7bP6WAUHq3GZ0ODtsjcTb/tT+opXp5gTFn0sPssKUbrAWfeNIhK5Au0h2KVZQnaBpmfyVwptzLmF6YR63DJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764034; c=relaxed/simple;
	bh=6QHNFoOyCLLCOprlGxwgr4wtXY/9BMMhCylqPIU9iec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCsMqoje7hJ5mQlIyzEAkyJUgtok4+P6Xsrkz4VjI6VccteZsa+ro0L0We7zXf2l9tr/WWo4Zhg6sAo/c0mDWaQeCKTarXndUIBRDqnseewlKobStZbjI1kemPOxDrR6mXVDlgb/O5BczW2ETuGnMfIlvYyAtHUC1iK1IUSQi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lgmtZFvm; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71ddeb7f85eso448638a34.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Dec 2024 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733764030; x=1734368830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts2tIWXtXU2E7gTgnS4zrXEWacYOhqUWs3qs84T0QwA=;
        b=lgmtZFvm54fQTMIg4rf9hMBLTNpe5tf0wS4PQPiWCsc7rG1I9xPYjIpI2pSwHVHUx/
         KJKCjRVf5z/YcB7b8ieZyWpxb2+hEVWxrwqkaN5EVsQg5UQ7GtP//z67vL6y/TcO1jrr
         G3zEIIGaWrpftBb5OPtRQoaRtofFBDUiulCZLWBwrnPIY/D1pRX5hcBTI4W8niOZfD+0
         MK65xljLXgPFcivcKuaivGJNlpoci65r5s9On9Yp8pLbHqFxhrSV3oLJahZbZsl93wby
         w3NCPv4wd8Xlz7JM86lmjNsn2IQ4eeK5+JZStx1bKpaZTiDZdVhJ9BMhXWn+4VwIg/Cw
         Op4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764030; x=1734368830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts2tIWXtXU2E7gTgnS4zrXEWacYOhqUWs3qs84T0QwA=;
        b=O2UW7xeVAG5YORUsZnWgAdP9cCfdHPOgI5jARdqfHIud8Z8gEz7RDHRPzq4vBbxfTC
         OwSsFUCmjT06DTh5KL6ugablPFi43km5p1HqIwA9pj/x66OiEaRL/xDe3ZOw7D7EChfD
         E1p069D+pdlr6h3L0z2dTs9p2ktYLklny3+qzR4DXWU/BpowzETDHU9IEVcTL0IlVear
         n3DGUS+XjGA+RKBsNn2agxsZ0nTEwvzMBKvBQwipB20GxngnY0p2Goh0aB3OxmmhO47h
         f83HRKJHrcbnzoG2XWF3XRZTX+1ZZlmytfiBu9GuWAWaSmsV1yaZ+sre01FkipLMdGMt
         G+0w==
X-Forwarded-Encrypted: i=1; AJvYcCW2kWJRzl42/902Ud+Bdt7eyrjOkXrWJTA7XFFU8awT6NKgLtwhcqS3ehkuqwk2Zgav3b79Q6RUx+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rzra129HMv4tcxNcFtjsAKSXvpbySZuHEOaSTAkLyNZO17pJ
	XoW3EXPO0nxGtvxtKsbP7NseJ59NKh7vYP4ZTf2KDvRXkeKk4OaDzkQ+Os/MVFE=
X-Gm-Gg: ASbGnctY0jbg3QrzUvsJs4IXgfue5V1iZEFz1+2hjMcglNxv7vgKe/QgQXmRKLqmGqz
	8Wp/rzOF6nfRH39Mk7y2/hzjJTC3RRlw0iaO6/uZd9BirxGJB8WeR/EYUqhDyhU3tCjGLhaOS/D
	u0WPLe+0KG2+yO/mnCDYSf2VI6pPssXk+c+Layo32NFK06+rlpyAfXiHOyiwta1auJT6ejDS8zB
	1u6FrXcdyCuFp4KwTs1sdUoJzcSIPo+u2He2FHwyzUHhG59epN5dZV/7ps4MFOoZmBKw1byTg5y
	sQqG1Kq7jOo=
X-Google-Smtp-Source: AGHT+IFr1v3eMTCDoHKwzSdd6E2ceD6LV8bAwZtXDNnskXWEMJJtepd+JZw7mMw4KfxBhmpg8tG+ng==
X-Received: by 2002:a05:6830:f83:b0:71d:62bc:85ec with SMTP id 46e09a7af769-71e021cf6a1mr981278a34.13.1733764030327;
        Mon, 09 Dec 2024 09:07:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dfd1dad2asm232242a34.41.2024.12.09.09.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 09:07:09 -0800 (PST)
Message-ID: <09902fa0-5a83-4d9b-aa86-f4ee7c0a46d0@baylibre.com>
Date: Mon, 9 Dec 2024 11:07:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] iio: adc: ad7192: Add sync gpio
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20241128125811.11913-1-alisa.roman@analog.com>
 <20241128125811.11913-4-alisa.roman@analog.com>
 <20241130183839.1fd5884f@jic23-huawei>
 <6435f696-40fe-4ff9-ae76-1f121fe7604f@baylibre.com>
 <20241208184337.79c701db@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241208184337.79c701db@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/24 12:43 PM, Jonathan Cameron wrote:
> On Mon, 2 Dec 2024 16:21:43 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 11/30/24 12:38 PM, Jonathan Cameron wrote:
>>> On Thu, 28 Nov 2024 14:55:03 +0200
>>> Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
>>>   
>>>> Add support for the SYNC pin of AD719x devices. This pin is controlled
>>>> through a GPIO. The pin allows synchronization of digital filters and
>>>> analog modulators when using multiple devices.
>>>>
>>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>  
>>> Hi.
>>>
>>> Like all userspace ABI, this needs documentation.
>>>
>>> It's an unusual feature, so some usecases would help.
>>>
>>> It is also cross multiple devices which makes this odd as only one device
>>> can presumably acquire the gpio?
>>>
>>> An alternative would be to look at how to do this with a 'wrapper' sort of device
>>> so that we have one instance to which this applies.
>>>
>>> I'm not sure that helps that much though as we'd still need some for of
>>> 'I'm setup for all channels, now you can go' ABI.
>>>
>>> Jonathan
>>>   
>>
>> Giving userspace direct control over the /SYNC pin without coordinating
>> with the rest of the driver does seem like it could be asking for trouble.
>>
>> It seems like the only time you would want to actually toggle the /SYNC
>> pin is when starting a buffered read.
>>
>> 1. Deassert /SYNC so that no conversions can be triggered.
>> 2. Enable buffered reads for all chips connected to the same GPIO.
>> 3. Assert /SYNC to start all conversions at the same time.
>>
>> So it could make sense to integrate this into the buffer pre/post enable
>> callbacks somehow instead of adding a new sysfs attribute.
>>
>> For the "wrapper" device, maybe we could do something with configfs to
>> enable dynamically connecting multiple device instances? We might not
>> need to actually create a separate device in sysfs, but just do something
>> so that enabling a buffered read on the first chip will enable buffered
>> reads on all of the chips in the group.
>>
>> It seems like we have some other chips that are currently being worked on
>> that also have the possibility of some sort of multi-chip synchronization
>> like this so it would be nice to come up with a general solution.
> 
> Most of the multichip cases we've had before have been chained, rather
> than separate data interfaces, hence I don't recall us needing something
> like this before.
> 
>>
>> Another use case for a general synchronized buffered read/write between
>> multiple chips would be the AD3552R DAC. Recently, while adding support
>> for an IIO backend for this chip, we saw that the AXI DAC backend has a
>> synchronization feature like this where you set an "arm" bit on all AXI
>> DAC instances. Then when you enable streaming to the first chip, it also
>> triggers all of the other AXI DAC blocks to start streaming at the same
>> time. We ended up not implementing that feature since the IIO subsystem
>> doesn't really support this yet, but could be a good one to look at as a
>> similar feature with a different implementation to help us find a general
>> solution.
>>
> This feels like a case where we need a prototype to poke holes in.
> It's not totally dissimilar from the hardware trigger stuff that
> exists in a few devices. Some of the stm parts for instance where the
> triggering is entirely within the chip.  Maybe we could make something
> like that work.  So the driver instance that has the sync pin registers
> a trigger that the other devices use.   It's a bit ugly though and we'd
> still need a dt-binding to let us know 'which' devices are connected
> to that sync pin.
> 
> Jonathan
> 
> 

A shared trigger was one of the ideas that crossed my mind as well.
Are you suggesting that the "main" chip would have the sync-gpios
property in it's .dts node and then the other chips would have a
trigger-sources = <&main_adc>; property instead of the sync-gpios
property? (FYI, trigger-sources/#trigger-source-cells are becoming
are becoming general properties with the SPI offload work I have
been doing, so should be available to use soon-ish).

Now, to try to poke a hole in this idea...

It seems like most (all?) triggers are set up to trigger an individual
sample. But in this case, the /SYNC pin would just be triggering the
start of a buffered read, so triggering multiple samples. Does this
still fit within the definition of a struct iio_trigger?

One way to possibly make it work without a struct iio_trigger could
work like this:
* During probe, "main" chips sets /SYNC so that chips won't sample
  data.
* Set up and enable a buffered read for all non-main chips that have
  the /SYNC pin connected to a common GPIO. Chips don't actually start
  sampling when buffer is enabled due to /SYNC pin state.
* Enable the buffer on the "main" chip last. This changes the /SYNC
  pin state in the buffer pre/post enable and all chips start
  sampling at the same time.
* Read from all buffers for as long as you want.
* Similarly, to stop, the "main" chip should have it's buffer disabled
  first, which changes the /SYNC pin state causing all chips to stop
  sampling.
* Then other buffers can be disabled.

Alternately, we could have a struct iio_trigger and expose control of
the /SYNC pin state as a sysfs attribute on the trigger. This would be
more like what Alisa-Dariana has proposed already.

It could work like this:
* Set up and enable a buffered read for all chips that have the /SYNC pin
  connected to a common GPIO. Chips don't actually start sampling when
  buffer is enabled due to /SYNC pin state.
* Write to a new trigger sysfs attribute to start sampling on all chips at
  the same time.
* Read from all buffers for as long as you want.
* Write to the trigger sysfs attribute to stop sampling on all chips at
  the same time.
* Disable buffers on all chips.


