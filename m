Return-Path: <linux-iio+bounces-17560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F4A7968D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71393B4ADB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A81F12F1;
	Wed,  2 Apr 2025 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JXfaWFVC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB91DE2A5
	for <linux-iio@vger.kernel.org>; Wed,  2 Apr 2025 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625678; cv=none; b=u8xIoR2VITR0z6D0wQJ3A2VGfACQa/mlHQvcm3j4dhKc7b+PTS8RQn4xGnrzEPNEyyYtOlfmk8X+RvkjPcLQP5Gx9+C33z8YtAoJkz3CTTMc8P14/lrJBHlQL74mGIL5vsWwvRZZd2h/GjUPy3BocNroK/M5C85bvze1ndC0G70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625678; c=relaxed/simple;
	bh=iL+v0YyDgRKPSv4xdqmcB4SFH3CEqcRuTZ8liW/+9JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQYbSpnrX8GzgI2djDiAMOfMt6aE7x7GxCZ34xNRtDg95dJ79Br3gWVr/ZBeLQC0NgC0yjo6ctDRAX07HdgKayYhU5ye8Q4ov1+kv+/bLZLwX+APan92Krs+8PQTtDeB7VwS31yxW5uoHBqBh5umsb2lVSBSuM3odYJz7nGNKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JXfaWFVC; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2a01bcd0143so140998fac.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Apr 2025 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743625674; x=1744230474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bb3uLjaaplMI5rmcO3yUoLQoxyYMzts0THKqJNK384g=;
        b=JXfaWFVCyxteJrsHYCy/JNknRQPYh9ea+sHbUBl01dPwvT2CmoCMOujmRidZJP04Mg
         8RggPW7O/0Sc3f8XefW6u5TCBdJg3+jE+fiwqt0uNVAls8EmsOgRrqBOK6AwxKI0nYRM
         WHkB+6koiO7ZtvFKRfRRJMrm2CpzNsRdHC0qByWDxQWhwvMV5De1NjicLkn8dG3FYXKl
         sbNxXnRCaLRjQt4H0YJTETKJOdbIoKNh5u+zJf7A1aKbVPp+dgMghRlZ/32eGFZS/CGU
         65fgwKezAq+8D7oEhqnaJeEfq1Vv7WYpCbKtP42WQ0pchORPCd1FZDuqnIi6bJ+owkX2
         6pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743625674; x=1744230474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bb3uLjaaplMI5rmcO3yUoLQoxyYMzts0THKqJNK384g=;
        b=HvWVMrpNQiHomis8tH6W13yme9jIeysEQMwlFRnTjCfo5icyp/jRFvMbxV9YuQecJX
         8RLgdHnWCCUZ20kmG3/DVZmHLXkZf4gohZX40kbryXRRF6i4xPB+JpkmM1+Begc/dt/7
         1//8ES3QZig3SCDWUBMgklHdkkKsXqMoG1JqB/mYwEuBnfoAsiqFHrKM2WfHN9m/81X0
         6znOWCzGzDqqT7TeLz6tCt578HMvRgHInkC0QJbGzAod19Z2MjZXd/lC9pgJUjQC8W+K
         NAUgwRQTJULxiTbJjKhvY8cX+LDjqpQHt71aqzvDguHgJnnu24swEktd9I77jfOCTQ5j
         2peg==
X-Forwarded-Encrypted: i=1; AJvYcCWrSrf3VtoYyOqWF4Ofok8U90Fy0aPNS6oYzEyrKhAH5qg/tsXYBT05oQEDJQxzZ3XBgaBox1ZyA88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxo5szskC43ctKXYS0w5rYlstd+okhl5ssAzILKrAZtCND/N1
	C1dkGVos9DJT+/o9nKfsYe57YLzsgGx3S1s261ykKWsi+asGSQlGp4LUkEZi4rE=
X-Gm-Gg: ASbGncuvRJwebOjclAjwQTej1ugQcIB5mzWdGeMm60XRoWwYZMfNqPdSFMPw5hLAhIe
	ZXO5WlyeI4uptVqvl7qXwbxUAzhLs1Dvx/vBBWY+xw/XCXywnQBtqSCoUM0M2G2M7tjfVXF3aTr
	bMblKbylHm/FBqseFh4WpsHJ2Wx1P2vRqn+MUVN5D3iDgG+n2XBnPjb4rFVrIO1GvsDGGshpoTs
	Dgq5H3s3aqv9gnTOd7kCGgf7dlTZqJ0dGETHoTi8M/8om/26iJqXeMW8gg4aFiQ28ub32CGUJoG
	trw/25RpDgYLBCIZAPP1LMShOUEw2UdKeKweWdoIj6pkOX+OYT0s/+ShxjXfGimzAfgsNzT281o
	DAqhuDg==
X-Google-Smtp-Source: AGHT+IEt8RP1WvtnuTRTfpnfybVllpyHk6xGLunHxwe8XiEec7EztheZvoJ3VjB2D1Z7tNHFkLyDmQ==
X-Received: by 2002:a05:6870:e0d2:b0:29e:4d0e:a2b6 with SMTP id 586e51a60fabf-2cbcf4a1e6fmr11102767fac.10.1743625674383;
        Wed, 02 Apr 2025 13:27:54 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a4a3984sm2976967fac.17.2025.04.02.13.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 13:27:52 -0700 (PDT)
Message-ID: <20e8538f-7a73-42a5-87b1-0c04b54375c6@baylibre.com>
Date: Wed, 2 Apr 2025 15:27:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
To: Jorge Marques <gastmaier@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
 <20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
 <20250330181320.0ec4351c@jic23-huawei>
 <3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
 <20250330185353.150fc33a@jic23-huawei>
 <hf5dwxs62oof3gom43c6rkdsq3gky6eplxej627t46ktt5blfr@kpmjpxku4inc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <hf5dwxs62oof3gom43c6rkdsq3gky6eplxej627t46ktt5blfr@kpmjpxku4inc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 8:47 AM, Jorge Marques wrote:
> On Sun, Mar 30, 2025 at 06:53:53PM +0100, Jonathan Cameron wrote:
>> On Sun, 30 Mar 2025 12:34:39 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> On 3/30/25 12:13 PM, Jonathan Cameron wrote:
>>>> On Fri, 21 Mar 2025 15:50:02 +0100
>>>> Jorge Marques <jorge.marques@analog.com> wrote:

Once you dig into it, the current situation is even more complicated than
I expected. :-o

This reply has ended up being mostly a brain dump of my observations. I hope
it isn't too confusing. Consider this more of a brainstorm on a future
documentation page on sampling rates rather than commenting on what to do
on this particular patch. :-)

---

To make sure we are clear, I think we need to define some precise terminology,
especially with regard to "sample rate" since that can be used to mean a
lot of different things.

There is the "IIO sample rate" (could also call it the "effective sample rate")
that is the rate that we push one complete set of data to an IIO buffer. In
many cases, this would be the frequency of the hrtimer trigger that is configured
as the trigger for the iio:deviceX.

On the other end of the spectrum, we have the "conversion rate" which is the
rate that individual ADC conversions can happen.

What I had not seen before, but now I see in existing drivers, is that these
may actually be completely independent. In other words, the hrtimer trigger
only triggers reading the most recent set of conversions and conversions are
driven by a completely separate trigger, generally some sort of clock in the
ADC itself.

So I think we should expand the diagrams below to show more layers for the
completely general case.

>>>>   
>>>>> Some devices have an internal clock used to space out the conversion
>>>>> trigger for the oversampling filter,
>>>>> Consider an ADC with conversion and data ready pins topology:
>>>>>
>>>>>   Sampling trigger |       |       |       |       |
>>>>>   ADC conversion   ++++    ++++    ++++    ++++    ++++
>>>>>   ADC data ready      *       *       *       *       *
>>>>>

For terminology, let's call this "burst mode" oversampling (maybe also
referred to as "triggered mode" in some data sheets).

>>>>> With the oversampling frequency, conversions can be evenly space between
>>>>> the sampling edge:  
>>>>
>>>> I'm not sure what this second example is providing.  Are you suggesting
>>>> that if we don't provide oversampling frequency we should assume this
>>>> pattern?  i.e. it is the default?
>>>>   
> 
> The default is to do the n-conversions sequentially (n*t_conv),
> "left-aligned" as in the diagram above.
> The main application for oversampling is to average out the noise over a wider
> bandwidth.
> 
> I looked into some of the drivers with oversampling and the supported devices
> datasheets:
> 
> * ADS1298: Single field for sampling rate and oversampling,
>            I assume the values are the maximum values that the
> 	   oversampling time does not exceed the sampling period.
> * RTQ6056: Field for oversampling and conversion time,
>            maximum sampling period is roughly n*t_ovr.
> * MCP3561: Field for oversampling and conversion time.
>            maximum sampling period is roughly n*t_ovr.
> * AD7380:  Field for oversampling and fixed conversion time,
>            3 MSPS for the AD7380 and 4 MSPS for AD7381,
>            maximum sampling period is n*t_ovr, e.g. f_samp=(6/4MSPS).
> 
> None will or claim to stretch over the sampling period the oversampling
> conversions, but rather, do the n-conversions at oversampling rate,
> providing the conversion as soon as it is ready and idling until the
> next edge of the sampling frequency.
> 
>>>>>
>>>>>   Sampling trigger |       |       |       |       |
>>>>>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
>>>>>   ADC data ready         *       *       *       *       *
>>>>> 

And let's call this one "continuous mode".

But as we will see, both of these are a bit ambiguous in their current
form. The complete picture is a bit more nuanced.

---

Let's take the RTQ6056 case (since I actually looked at that one before
as inspiration for developing another driver).

The chip itself is programmable and can operate in either a burst/triggered
mode or in a continuous mode. However, the way the IIO driver is implemented,
it is configured in continuous mode to trigger ADC conversions. But uses an
independent IIO trigger that triggers reading sample data. So from the point of
view of the data in a buffered read, it looks like burst mode. But the value
of the sampling_frequency attribute (the ADC device attribute, not the hrtimer
trigger attribute) is for the hardware continuous mode.

Hardware:
sampling_frequency   |       |       |       |       |
ADC conversion       + + + + + + + + + + + + + + + + + + + +
ADC data ready             *       *       *       *       *
sample number              S0      S1      S2      S3      S4

IIO:
hrtimer frequency               |                     |
I2C read                         *                     *
push to buffer                   S0                    S3

The IIO (hrtimer) trigger only reads the most recently available data, it
doesn't trigger any conversion. The clocks are asynchronous.

I think adding an oversampling_frequency attribute to this driver could make
it easier to used/understand since oversampling_frequency would be exactly
the "conversion rate". Compared to the current situation where the "conversion
rate" is the sampling_frequency / oversampling_ratio.

It is also interesting to consider that if someone decided to add SPI offload
support to this driver, then there would be the possibility of using burst/
trigggered mode or continuous mode and might want to support both even. In
fact this is exactly the possibility we have with ad7606 that I mentioned in
a previous reply. So we might even need an oversampling_mode attribute to allow
selecting one or the other. But that is something to save for a ad7606 patch
series.

---

Another driver probably worth considering is ad4030. In this one, there is no
internal clock to drive conversions. So, for oversampling, the sample rate is
just "as fast as possible" (currently bit-banging a GPIO). So it doesn't actually
have an oversampling frequency.

If someone ever decided to hook it up to some hardware that could actually
trigger a finite number of pulses at a specific rate, then this new attribute
for oversampling_frequency would become useful. For this particular driver,
the presence or absence of an oversampling_frequency attribute would have
a meaning, but I don't think this generalizes to other ADCs.

---

AD4695 is an interesting case to consider as well. When used without SPI offload
support, we actually don't allow oversampling currently. If we did though, it
be similar to the ad4030 in that we could either make it "as fast as possible"
by banging a GPIO or the CS line depending on how the chip was wired up. Or it
could use some specialized hardware to generate a pulse train to actually get
a known conversion rate.

For now though, oversampling is only implemented when using a SPI offload.
It works like this:

Channel		1   2       3 1   2       3 1   2       3
OSR		2   4       1 2   4       1 2   4       1
Trigger		| | | | | | | | | | | | | | | | | | | | |
ADC Conversion	+ + + + + + + + + + + + + + + + + + + + +
ADC data ready	   *       * *   *       * *   *       * *
IIO sample                   S0            S1            S2

In this case, there isn't a "sample" trigger that triggers a burst of
samples. Rather, there is only a "conversion" trigger that triggers
individual conversion. In other words, we would call this "continuous mode".
And it also shows that some chips allow individual channels to have
different oversampling ratios.

In this case, it would be nice to have an oversampling_frequency
attribute as well because it would exactly correspond to the conversion
rate. Currently each channel has a sampling_frequency attribute that
is oversampling_frequency / oversampling_ratio (same as RTQ6056).

---

So my conclusion here is that the new proposed oversampling_frequency
attribute has nothing to do with "burst mode" or "continuous mode" it
has the same meaning in both cases. It is effectively the rate for
individual ADC conversions.



