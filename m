Return-Path: <linux-iio+bounces-6339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F101D90A67B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 09:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF791F21BEE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 07:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F7187322;
	Mon, 17 Jun 2024 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQWCdB8M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098879D3;
	Mon, 17 Jun 2024 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608088; cv=none; b=UUatXDrmsy9ZO2cJZBelq6dUNRYE4nAfj6EqL4Zi9aXKPbMZuYZZSHjuzlAZ82fUHr8WmSW9rDdiKJWxa3L4BB8ZQ7DvvS6Tb1zaEHSpsyNGX9t06ErOfXPS1qhZ5mweil1fbYkmLbeUlbqiWdP0bv4rQoK1SZsrT4nOgv5l0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608088; c=relaxed/simple;
	bh=/hV02jB8gmWed00h4zs5eMEP9wSXXhMK13AogFlkfCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kl8hFptudHDiAr/AIz6o1HoH5+f3T6Y76mb/9pgM7V8tF2TonNSWdht5mMUG7cO+1ZTsM9URBA3PsNAyY0QXEcab1AY795CKfqoica5ktkv/tneE2tPlCJmRCDNFtsgv2AvGbYn1M47MngTeR4XzxFU8fNNoWHbaE7v1CnlC70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQWCdB8M; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso55554451fa.0;
        Mon, 17 Jun 2024 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718608085; x=1719212885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoCW1BgGcZMuZF9y7iRf3s0Ub7Hp0RCpNkgiGwon8YY=;
        b=iQWCdB8M5gun4aICacS0jtzpq0isVDal6E/lHA0oLmbspn//MqFSl+lhRxVE3x4xLr
         rS7I7aTTdZvo+C2m13G9xKQaw+yPgIe4HreePQly7wtVRuVcAEe+mPmMPip6D0djbHZQ
         xTtGXYtswBCWXUtWWgyFeo9hrHIN/nxi+iWEFpH3DD8cDE4p86CDs/5ZU82+jg/aKEQo
         JgN+PYnGVWci1q7njWjCBgo//XRvG3FUKkK16/WV0uXMjruERmN9QuW3IVv3XZA4w6OK
         6fvOoQu0+XJJgyfNHGaBSafLLAAWgOUyeSkLPBfF/OuErA0ur7PyS/eFr5mBER7l/sGK
         8Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608085; x=1719212885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoCW1BgGcZMuZF9y7iRf3s0Ub7Hp0RCpNkgiGwon8YY=;
        b=E8780z5CK7lANnX06TCLoJLNdcklqmso8cXYJzPr0xU2G0xD8Hr/UCTQ+VRyVb9rCU
         +E2tt6A/lMDv3C7aVobqR1T7v5m4kQ7zgZlIxGJ9J7u+Q8pOuLXnVyhSfFSAaCV3rQ/w
         y+AfTsu1InBM23n1UfjsbBTXixwWZsZP78/8U2NZrpaD9oFU+NVowuV3ZjlVK4OrFxfO
         CTfrRaVilZM7Q9cRMq8hEgPncKq9BMu5L1rz/YZtOQG26uZqgpqe0ApSlKVF25JrcUMr
         1NfHwAi/3EiD9Icft1NvW5hhYaMexQ09QCE7ASGH7VLcLEvseBClOAiFuzs51RY5NIgU
         d7EA==
X-Forwarded-Encrypted: i=1; AJvYcCWRJxjMYvIQTaQbArPLJ1qvRZczZkDkAhohOvwsR/IHwwsuYYM/9ZyYJDw6cVjz7qeT7i0baCPnyvLtviH9D69ew6p/62RqJteh4jWtw6rL2dEt1Z2lkKsUS0uOn/KMqxdgCffuT9+dlqInQXEOW7FsddabGn0Vq0i9iRgMPm3wnhNckw==
X-Gm-Message-State: AOJu0Ywytk/wv/7TfhbJ+3hvJXp1lIFrR0+R/DponBmFPuU6iSM3jXPq
	Mo+cT2JwCOUG2ENMRdQFHDB+FmkWdixnQjcsAcMdk1NRimqFDWVe
X-Google-Smtp-Source: AGHT+IEzUUQR0RzGjaGn8edp82oyyXNbVghZFfR9mpmISEbYy2bhxagrMqm1ut1LrBI2Vqi+7pRteA==
X-Received: by 2002:a05:6512:2384:b0:52c:8a39:83d7 with SMTP id 2adb3069b0e04-52ca6e9073amr7286523e87.52.1718608084312;
        Mon, 17 Jun 2024 00:08:04 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28723d1sm1158340e87.131.2024.06.17.00.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 00:08:03 -0700 (PDT)
Message-ID: <6e5d6734-eae0-49fd-a1ed-beda00e37209@gmail.com>
Date: Mon, 17 Jun 2024 10:08:02 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
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
 <c9c0d585-617d-4181-afa2-c5743848f5c9@gmail.com>
 <20240615192348.182eb1b8@jic23-huawei>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240615192348.182eb1b8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/15/24 21:23, Jonathan Cameron wrote:
> On Wed, 12 Jun 2024 09:07:01 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 6/11/24 20:14, Jonathan Cameron wrote:
>>> On Mon, 10 Jun 2024 08:58:44 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> la 8. kesäk. 2024 klo 19.22 Jonathan Cameron (jic23@kernel.org) kirjoitti:
>>>>>
>>>>> On Thu,  6 Jun 2024 17:29:42 +0100
>>>>> Mudit Sharma <muditsharma.info@gmail.com> wrote:
>>>>>      
>>>>>> Add support for BH1745, which is an I2C colour sensor with red, green,
>>>>>> blue and clear channels. It has a programmable active low interrupt
>>>>>> pin. Interrupt occurs when the signal from the selected interrupt
>>>>>> source channel crosses set interrupt threshold high or low level.
>>>>>>
>>>>>> This driver includes device attributes to configure the following:
>>>>>> - Interrupt pin latch: The interrupt pin can be configured to
>>>>>>     be latched (until interrupt register (0x60) is read or initialized)
>>>>>>     or update after each measurement.
>>>>>> - Interrupt source: The colour channel that will cause the interrupt
>>>>>>     when channel will cross the set threshold high or low level.
>>>>>>
>>>>>> This driver also includes device attributes to present valid
>>>>>> configuration options/values for:
>>>>>> - Integration time
>>>>>> - Interrupt colour source
>>>>>> - Hardware gain
>>>>>>      
>>>>   
>>>>>> +
>>>>>> +#define BH1745_CHANNEL(_colour, _si, _addr)                                   \
>>>>>> +     {                                                                     \
>>>>>> +             .type = IIO_INTENSITY, .modified = 1,                         \
>>>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                 \
>>>>>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
>>>>>
>>>>> Provide _SCALE instead of HARDWAREGAIN
>>>>> As it's an intensity channel (and units are tricky for color sensors given
>>>>> frequency dependence etc) all you need to do is ensure that if you halve
>>>>> the _scale and measure the same light source, the computed
>>>>> _RAW * _SCALE value remains constant.
>>>>
>>>> ...Which is likely to cause also the integration time setting to
>>>> impact the SCALE.
>>>>
>>>> You may or may not want to see the GTS-helpers
>>>> (drivers/iio/industrialio-gts-helper.c) - which have their own tricky
>>>> corners. I think Jonathan once suggested to me to keep the
>>>> HARDWAREGAIN as a read-only attribute to ease seeing what is going on.
>>>> For the last couple of days I've been reworking the BU27034 driver to
>>>> work with the new sensor variant - and I can definitely see the value
>>>> of the read-only HARDWAREGAIN when we have per channel gain settings +
>>>> integration time setting which all contribute to the scale...
>>>
>>> I'm wondering if that was good advice, but it's definitely better
>>> than letting userspace control the gain and integration time separately
>>
>> I woke up last night at 03.14 AM thinking of this :rolleyes:
> 
> Ah.  I'm one for failing to get to sleep due to late night musing.
> No idea if I muse because I'm not sleeping, or not sleep because
> of musing!

Either way, not getting sleep at night is rarely amusing. :/ Sometimes 
it is actually one of the early signs of a burn out.

>>> as there is no sensible way to know how to control that beyond -
>>
>> I agree and disagree :)
>> I agree that it is simpler to just change the scale when readings get
>> saturated - or when more accuracy is needed. Hence, implementing the
>> scale change as is done now makes very much sense.
>>
>> However, I can imagine that sometimes the measurement time plays a role
>> - and people would like to have more fine grained control over things.
>> In that case, if driver only allows changing things via the scale, then
>> the driver is probably doing autonomous choices regarding the
>> integration time - which may not be optimal for all cases (*citation
>> needed).
> 
> Agreed even without the complexity you mention later- there will be cases
> where people want ugly (noisy) data quickly so will crank the gain up
> to reduce the integration time.
> How often they apply to light sensors is an interesting question.
> 
>>
>> As you may remember, I implemented the ROHM RGB and ALS sensors (the
>> BU270xx series) so that the integration time can be set as well as the
>> gain. These sensors (at least the BU27034, don't remember all the dirty
>> details of the RGB sensors) had per-channel gain and a global
>> integration time settings. Hence, the scale can be set separately for
>> each channel. I invented a restriction that setting the per-channel
>> scale tried to maintain the integration time and change the gain - but
>> if it was not possible, the scale change changes also the integration
>> time in order to yield the desired scale.
>>
>> Problem was that the integration time was a global setting, and changing
>> it for one channel results scale change also on the other channel(s).
>>
>> To mitigate such side-effects I implemented logic that the scale change
>> for other channels (caused by the integration time change) is
>> compensated by changing the gain for these unrelated channels. Eg, if
>> scale change for channel #1 required doubling the integration time -
>> which effectively doubled the "gain contributed by integration time"
>> also for the channel #2 and #3 - then the HARDWAREGAIN for the unrelated
>> channels #2 and #3 is halved in order to keep their scale unchanged. Great.
>>
>> Except that this is not always possible. The HWGAIN for these unrelated
>> channels may have been already set to the other extreme, and further
>> reducing/increasing is not possible. Or, there may be unsupported
>> multipliers (gaps) in the gain range, so that setting the hardwaregain
>> to required value is not possible.
>>
>> Here I just decided to return an error to caller and disallow such scale
>> change.
>>
>> This is very much annoying solution but I ran out of good ideas. Adding
>> more logic to the driver to work around this felt like asking for a
>> nose-bleed. I was sure I ended up adding a bug or two, and resulting
>> code that was so hairy I could never look at it again :) We can call
>> that as an unmaintainable mess.
>>
> 
> Yeah. I vaguely recall this one was a bit nasty and result wasn't
> entirely satisfying.
> 
>> Still, what makes this even more annoying is that it might be possible
>> to support the requested scale by selecting yet another integration
>> time. Eg, imagine a situation where we have 2 channels. Both channels
>> support gains
>>
>> 1x, 2x, 8x, 16x, 32x. 4x is not supported.
>>
>> Let's further say we have integration times 50mS 100mS, 200mS, 400mS -
>> causing "effective gains" 1x, 2x, 4x and, 8x
>>
>> Now, say channel #1 is using gain 2x, channel #2 is using 8x.
>> Integration time is set to 400mS.
>>
>> Assume the user would like to double the scale for channel #2. This
>> means the "total gain" should be halved. The HWGAIN can't be halved
>> because 8x => 4x is not supported, so driver decides to drop the
>> integration time from 400mS to 200mS instead. That'd do the trick.
>>
>> Then the driver goes to check if the channel #1 can maintain the scale
>> with this integration time. Gain caused by integration time is now
>> halved so HWGAIN for channel #1 should be doubled to mitigate the
>> effect. Well, the new gain for channel #1 should now go from 2x => 4x -
>> which is not supported, and the driver returns error and rejects the change.
>>
>> Still, the hardware could be set-up to use integration time 50mS
>> (dropping the gain for channels from 8x => 1x eg. 8 times smaller), and
>> channel #2 HWGAIN go from 8x => 2x (4 times smaller) thus doubling the
>> scale. The channel #1 wants to maintain scale, so HWGAIN for channel #1
>> should go 8 times greater, from 2x => 16x which is possible.
>>
>> To make this even more annoying - the available_scales lists the 'halved
>> scale' for the channel #1 as supported because there is a way to achieve
>> it. So, the user can't really easily figure out what went wrong. Having
>> the read-only HARDWAREGAIN and knowing the gains sensor's channels
>> support would give a hint - but this is far from obvious. listing the
>> supported hardwaregains might make things a bit better - but using the
>> standard "available" entry in sysfs might make user to assume setting
>> the hardwaregain is possible.
> 
> That would be an odd bit of interface indeed.
> 
>>
>> We may invent a new entry to list the supported hardwaregains - and I
>> believe adding the logic to find supported gain-timing combinations is
>> then easier (and less error-prone) in user-land applications than it is
>> in driver - but I am wondering if it actually would be better just allow
>> setting both the hardwaregain and integration time individually for
>> those applications which may care... Well, I am probably just missing
>> some culprit supporting setting the hardwaregain causes.
> 
> We could do something similar to what we did recently for a power mode
> switch on an IMU.  The interface is also less than ideal though but
> was exploring a similar problem:
> [PATCH v4 2/2] iio: imu: inv_icm42600: add support of accel low-power mode
> https://lore.kernel.org/all/20240605195949.766677-3-inv.git-commit@tdk.com/

I took a quick look at this. So, changing the "power-mode" enum enables 
doing the not-so-standard changes.

> That was much simpler than this. The device has two power modes
> (trading off power vs noise).  The lowest sampling frequencies only
> worked in low power mode and the highest only in low noise mode.
> A few in the middle were available in both modes.  We defaulted to
> choosing low power if available.  The aim was to design an interface
> where everything worked as normal if you didn't grab the 'expert'
> controls. So it defaults to a preference for low power (here
> equivalent would be defaults to lowest hardware gain) but we provided
> an ability to override - if possible. So you could specify what you
> wanted the gain to be and if that was possible whilst retaining the
> sampling frequency (here that would be the scale) then the change
> would be made. If not it wouldn't an reading the mode back (here
> that would be reading hardware gain) would return the actual setting
> achieved.  In that case the power mode setting isn't sticky. To enter
> the low noise mode you have to be at a sampling frequency where it
> is supported.  That sort of restriction might not work here.
> 
> In that case the control grabbed to override the power mode is not
> standard ABI so we an be fairly sure no normal software will tweak
> it but in the rare occasion where a user needs it the tweak is
> available.
> 
> Here we might need a similar 'out of ABI' trick to make it clear that
> scale is the main control to use.

Thank you for the ideas. Adding a entry to enable 'not standard 
settings' definitely sounds like a way to explore. I think I'll return 
to this later :)

>> I believe there are many use-cases where it would work if we just
>> allowed the channel #1 scale to change as a side-effect of changing
>> channel #1 scale. Still, I am very reluctant to do this as there could
>> be different type of data coming from these channels, and different
>> consumers for this data. Allowing another application to unintentionally
>> change the data for other app would in my opinion be very nasty.
> 
> You've lost me here.

Sorry. I did not really manage to explain it too well.

Basically, I just further pondered handling the the case where:
- a requested change of channel #A scale could not be done purely by 
changing the gain but would require an integration time change.
AND
- the channel #B gain change caused by integration time change could not 
be compensated by changing #B hardwaregain.

I was just saying that allowing this channel #A scale change even though 
it would also impact the scale of channel #B would probably be Ok for 
many users. I think that a few of the users could be prepared for other 
channels to change as well, and go read back all channels' scales after 
changing one.

Then I was further speculating that there might be cases where channel 
#A data and channel #B data were consumed by different applications. It 
was all just speculation. For example, the original BU27034 had two 
channels for visible light and one for IR. So I built an imaginary 
device which ran two different user applications, one interested on 
visible light for darkening my sunglasses and the other interested on IR 
channel and then toggling the cooling fan to keep my vacation drinks at 
optimum temperature. :)

Here, if the sunglasses application changing the scale for visible light 
caused also the scale of the IR channel to change, my fan-application 
would unexpectedly start pick up differently scaled values and the 
temperature of my drinks would be all wrong.

>> The problem is not exactly urgent though and I am not working on an
>> application suffering from it. But it managed to interrupt my glymphatic
>> system while it was cleaning-up my brains last night. I will use it as
>> an excuse if you find any errors from this babbling :)
> 
> For this complexity I definitely want a known user who cares.
> It's complex and we'd need to construct the userspace to use it.

Agreed. It's nice someone drops me back on earth when I start drifting 
too far :) Thanks!

> Gut feeling is normally people are actually cranking scaling of light
> channels up and down together as hopefully they are approximately balanced
> for 'white' giving similar scales on all sensors (by filters or fixed gains)

I appreciate your insight on how people usually use these devices :) 
It's very valuable to me.

> and people would only need to care if they were trying to measure a weak
> blue signal in a red world. If we have a case that doesn't work well
> for that sort of global scaling (I can sort of see that as a possible
> problem due to the transition states not being possible) then we
> should make sure that one works!

Yes. I think some users will eventually hit to a scale transition which 
will be NACKed by the driver. Also, I don't think this problem will be 
specific to the BU27034 sensor, but in some form this will be possible 
for many gain-time-scale type devices. I just don't have a good generic 
solution in my mind right now.

Oh, besides, it seems raining stopped. Time to turn off my computer and 
go out to the yard :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


