Return-Path: <linux-iio+bounces-6185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C3904B53
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 08:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6567228421D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 06:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EC413C682;
	Wed, 12 Jun 2024 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/KRC5yP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C9137760;
	Wed, 12 Jun 2024 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172427; cv=none; b=j6Z9bcTrv11eQlh+RDTuPo/z7uDv+NWqUOwvzfvi/y90jLRWiWCCh3spUBevI16DbvaB2ZT5rgYj98//m1IZ8q+gOnR324+HdwFyuDOCHtuhza5IhbmkLbnH5Bp9xwqZ85qSDyECWETLmnhoI16dlmq6qw+rbPpOU/GfoXm80gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172427; c=relaxed/simple;
	bh=V+VtcDKehDg+XGeapL2ycNNuuLj1XBVLl3z15ff2BMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdOweSHxKXCc2fzWPXoXqJQf1OyYJFgDdCoz59FXsS9qc+IHdLTbzqYIrdoVRNuumdCl+Aj2gSwJyzXRKdPcCT9xkG8UNHTTX07QNzptTc8RV6lP0FmRRxKgpGfGHcr8gHeb44ApapDGogDgq6AdX/KSrXN0IhNiksps9vniHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/KRC5yP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso3839698e87.0;
        Tue, 11 Jun 2024 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718172424; x=1718777224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+MuZO7Xor+xkcjHeUgTwAiU3h8NYp0iOQXXGvr4MDM=;
        b=m/KRC5yP33zqzlJJeUZEI40HJBTVklsYb7lZVSSccEm8LOKvOYNnjF+4oPGUlHWa4g
         FQ29M/fLySUxU7PcKzlsiqKTBpa5eWNPc3F1OYsNf9DIMG+a8ZzDHm62SW743wg5Bxek
         vJo77KtnMY37FbITOWRdd0wZWWD7UZMaqnxBwMEYyCn8Zk2JdrEUMIxZkkN6fOuWeWaD
         BE7XoYHR0a7070veXs+DZrkJJlsOaR2DXxnQZBHEIJesSvJnp+e68ooogFwzIBuD3cwI
         ZVUFyvDwd556eq0k+bpAacCeLbUUG4MdneODl3JvrNDQ4+ABVAsne2sQhtCsL60oU3aS
         UUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718172424; x=1718777224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+MuZO7Xor+xkcjHeUgTwAiU3h8NYp0iOQXXGvr4MDM=;
        b=CtDHCCtkIadLPV685yb0MBZGsLIFED31Bqt8kREVq2CFPNXZh/f2Pks8/vaOPpUSYV
         KxoVi6CwmpQe+4rrLotQJ12f0KYPnX1QCx4U4Ssvy5UGTVxir5f5PRuKn5Eq0RyBOgU9
         Fdy84tUDk3xUilhJPf4w1hZVPrTrKHEFjDZT0eD5T+U3VIzQk78Xp+I5ETO9RmM7kfC2
         wjYvMQxfFM5v2uYvsLr16E7l5vSq/3zc75tA0irl6cYK4bE4xcyJdtL9RZ8mlzrcg/ki
         iEbla4mXPc0EmoBSM9hSKCFVPrvg++P7T03HKDJYUe69IdpnoMKsMm0C1MT1bLv5vqJE
         EQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGrw4EHYattsMUtfTdH7rXjONQOVdQJ/JKnoTdlloajuxD++nHX70cx0mzCXudOgD0IvrtST5Z8xXfv4bFauEaZwX+yQY7XOmi7Vniv1d5bT1UDinYhyRAnscg7Wdc6rbP0XoCoTO12tMZ+r3ghH+TpRBQV9bz0Lzbc3h1NFPVpEKt+A==
X-Gm-Message-State: AOJu0YzYunD0Yzt4b0T3RBB/K/1tmSA8oJy7VV8t8SfWQSApuCrAR3WW
	/ugVac4/KA4hErsWxL8FztqyAhkN4aDatZqZLvu/OIeww0/aGhNL
X-Google-Smtp-Source: AGHT+IH681YlFGeuqiX78zzXEw57ln5oqtxrcjvcxxRLHyWBpNRp9Piq4PLI9snx3C29hUPSeQFXeQ==
X-Received: by 2002:a05:6512:401c:b0:52c:910b:9c87 with SMTP id 2adb3069b0e04-52c9a3df0f2mr497275e87.36.1718172423352;
        Tue, 11 Jun 2024 23:07:03 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c9690f0fbsm364943e87.56.2024.06.11.23.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 23:07:02 -0700 (PDT)
Message-ID: <c9c0d585-617d-4181-afa2-c5743848f5c9@gmail.com>
Date: Wed, 12 Jun 2024 09:07:01 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, lars@metafoo.de,
 krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org,
 ivan.orlov0322@gmail.com, javier.carrasco.cruz@gmail.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
 "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
 <20240606162948.83903-2-muditsharma.info@gmail.com>
 <20240608172227.17996c75@jic23-huawei>
 <CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
 <20240611181407.00003f61@Huawei.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240611181407.00003f61@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/24 20:14, Jonathan Cameron wrote:
> On Mon, 10 Jun 2024 08:58:44 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> la 8. kesäk. 2024 klo 19.22 Jonathan Cameron (jic23@kernel.org) kirjoitti:
>>>
>>> On Thu,  6 Jun 2024 17:29:42 +0100
>>> Mudit Sharma <muditsharma.info@gmail.com> wrote:
>>>   
>>>> Add support for BH1745, which is an I2C colour sensor with red, green,
>>>> blue and clear channels. It has a programmable active low interrupt
>>>> pin. Interrupt occurs when the signal from the selected interrupt
>>>> source channel crosses set interrupt threshold high or low level.
>>>>
>>>> This driver includes device attributes to configure the following:
>>>> - Interrupt pin latch: The interrupt pin can be configured to
>>>>    be latched (until interrupt register (0x60) is read or initialized)
>>>>    or update after each measurement.
>>>> - Interrupt source: The colour channel that will cause the interrupt
>>>>    when channel will cross the set threshold high or low level.
>>>>
>>>> This driver also includes device attributes to present valid
>>>> configuration options/values for:
>>>> - Integration time
>>>> - Interrupt colour source
>>>> - Hardware gain
>>>>   
>>
>>>> +
>>>> +#define BH1745_CHANNEL(_colour, _si, _addr)                                   \
>>>> +     {                                                                     \
>>>> +             .type = IIO_INTENSITY, .modified = 1,                         \
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                 \
>>>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
>>>
>>> Provide _SCALE instead of HARDWAREGAIN
>>> As it's an intensity channel (and units are tricky for color sensors given
>>> frequency dependence etc) all you need to do is ensure that if you halve
>>> the _scale and measure the same light source, the computed
>>> _RAW * _SCALE value remains constant.
>>
>> ...Which is likely to cause also the integration time setting to
>> impact the SCALE.
>>
>> You may or may not want to see the GTS-helpers
>> (drivers/iio/industrialio-gts-helper.c) - which have their own tricky
>> corners. I think Jonathan once suggested to me to keep the
>> HARDWAREGAIN as a read-only attribute to ease seeing what is going on.
>> For the last couple of days I've been reworking the BU27034 driver to
>> work with the new sensor variant - and I can definitely see the value
>> of the read-only HARDWAREGAIN when we have per channel gain settings +
>> integration time setting which all contribute to the scale...
> 
> I'm wondering if that was good advice, but it's definitely better
> than letting userspace control the gain and integration time separately

I woke up last night at 03.14 AM thinking of this :rolleyes:

> as there is no sensible way to know how to control that beyond -

I agree and disagree :)
I agree that it is simpler to just change the scale when readings get 
saturated - or when more accuracy is needed. Hence, implementing the 
scale change as is done now makes very much sense.

However, I can imagine that sometimes the measurement time plays a role 
- and people would like to have more fine grained control over things. 
In that case, if driver only allows changing things via the scale, then 
the driver is probably doing autonomous choices regarding the 
integration time - which may not be optimal for all cases (*citation 
needed).

As you may remember, I implemented the ROHM RGB and ALS sensors (the 
BU270xx series) so that the integration time can be set as well as the 
gain. These sensors (at least the BU27034, don't remember all the dirty 
details of the RGB sensors) had per-channel gain and a global 
integration time settings. Hence, the scale can be set separately for 
each channel. I invented a restriction that setting the per-channel 
scale tried to maintain the integration time and change the gain - but 
if it was not possible, the scale change changes also the integration 
time in order to yield the desired scale.

Problem was that the integration time was a global setting, and changing 
it for one channel results scale change also on the other channel(s).

To mitigate such side-effects I implemented logic that the scale change 
for other channels (caused by the integration time change) is 
compensated by changing the gain for these unrelated channels. Eg, if 
scale change for channel #1 required doubling the integration time - 
which effectively doubled the "gain contributed by integration time" 
also for the channel #2 and #3 - then the HARDWAREGAIN for the unrelated 
channels #2 and #3 is halved in order to keep their scale unchanged. Great.

Except that this is not always possible. The HWGAIN for these unrelated 
channels may have been already set to the other extreme, and further 
reducing/increasing is not possible. Or, there may be unsupported 
multipliers (gaps) in the gain range, so that setting the hardwaregain 
to required value is not possible.

Here I just decided to return an error to caller and disallow such scale 
change.

This is very much annoying solution but I ran out of good ideas. Adding 
more logic to the driver to work around this felt like asking for a 
nose-bleed. I was sure I ended up adding a bug or two, and resulting 
code that was so hairy I could never look at it again :) We can call 
that as an unmaintainable mess.

Still, what makes this even more annoying is that it might be possible 
to support the requested scale by selecting yet another integration 
time. Eg, imagine a situation where we have 2 channels. Both channels 
support gains

1x, 2x, 8x, 16x, 32x. 4x is not supported.

Let's further say we have integration times 50mS 100mS, 200mS, 400mS - 
causing "effective gains" 1x, 2x, 4x and, 8x

Now, say channel #1 is using gain 2x, channel #2 is using 8x. 
Integration time is set to 400mS.

Assume the user would like to double the scale for channel #2. This 
means the "total gain" should be halved. The HWGAIN can't be halved 
because 8x => 4x is not supported, so driver decides to drop the 
integration time from 400mS to 200mS instead. That'd do the trick.

Then the driver goes to check if the channel #1 can maintain the scale 
with this integration time. Gain caused by integration time is now 
halved so HWGAIN for channel #1 should be doubled to mitigate the 
effect. Well, the new gain for channel #1 should now go from 2x => 4x - 
which is not supported, and the driver returns error and rejects the change.

Still, the hardware could be set-up to use integration time 50mS 
(dropping the gain for channels from 8x => 1x eg. 8 times smaller), and 
channel #2 HWGAIN go from 8x => 2x (4 times smaller) thus doubling the 
scale. The channel #1 wants to maintain scale, so HWGAIN for channel #1 
should go 8 times greater, from 2x => 16x which is possible.

To make this even more annoying - the available_scales lists the 'halved 
scale' for the channel #1 as supported because there is a way to achieve 
it. So, the user can't really easily figure out what went wrong. Having 
the read-only HARDWAREGAIN and knowing the gains sensor's channels 
support would give a hint - but this is far from obvious. listing the 
supported hardwaregains might make things a bit better - but using the 
standard "available" entry in sysfs might make user to assume setting 
the hardwaregain is possible.

We may invent a new entry to list the supported hardwaregains - and I 
believe adding the logic to find supported gain-timing combinations is 
then easier (and less error-prone) in user-land applications than it is 
in driver - but I am wondering if it actually would be better just allow 
setting both the hardwaregain and integration time individually for 
those applications which may care... Well, I am probably just missing 
some culprit supporting setting the hardwaregain causes.

I believe there are many use-cases where it would work if we just 
allowed the channel #1 scale to change as a side-effect of changing 
channel #1 scale. Still, I am very reluctant to do this as there could 
be different type of data coming from these channels, and different 
consumers for this data. Allowing another application to unintentionally 
change the data for other app would in my opinion be very nasty.

The problem is not exactly urgent though and I am not working on an 
application suffering from it. But it managed to interrupt my glymphatic 
system while it was cleaning-up my brains last night. I will use it as 
an excuse if you find any errors from this babbling :)

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


