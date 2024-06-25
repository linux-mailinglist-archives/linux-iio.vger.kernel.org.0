Return-Path: <linux-iio+bounces-6915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491EA916EAE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3A11F227A2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EFC16FF59;
	Tue, 25 Jun 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LododlXE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62E17624B
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334804; cv=none; b=LXAnDAwIj42Wyw8RGM/bxlPBFtar560Go68L8x09mJyqKXaK27XtPs4bdrBVOMi9OXivwgNkkVooU9+kmzzdcvrKlmEANIokzFoepriPmzAhiZQ2kDzGDoMZI4IZmpudKJG8m9dGe2pKsAddNgYwxOIo7xzcSKPM5SGZxlIY7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334804; c=relaxed/simple;
	bh=c69UeNsbBXYB+FXw5XwrxO/smJEaHUULsm7ttMq/Tvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awGD5Niq6MY9zrU09fEXP1IbFuWUihUz1lmQszgNyRMHOBCupnVn3+vzn2U/n404t85y1V1Sw2XdZrJaKDNDA7ayQDjB8D+RTxdV+/w7J4aFv0z5be3uAko3nEi3JNjBSmA3FOfdjCAQqoSYcy0ACbowIiJAi8bF89JEzFJ8ETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LododlXE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-366df217347so3037834f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719334800; x=1719939600; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKhLA/uuVpBLqDNuK6HoaxS7wD29CsICGUEF4cAMpms=;
        b=LododlXE/V884i9p2+T+JsNxhMvgqXkBxIKhEzMS6Ii+c38fAt4eNu8h2U0hbyHSJF
         fdEethm94nztDxUqa6uGzrMPsOBjdDLQptgyddmax0VD/i6nzOtVLKhhWGJ70hZ5kD1s
         Nw9bNtpKF+cezIYyQgXqtF3BI1Ql7DW0QzQcVxjOkZ4nhVV476G/RwMWhiCvn7yYLKQF
         oTilxvlgKVVWJX1WfQT6kDQ6uW2InXCgpwDdgAFELlOe5rfWWZenSug451S+VkIlonfC
         PJ9YSddQ8P5USQ6tP2TQ/a366NUKrvBUoqvFbN2t2YlDRmW9ooln0JuLUG4LfD3beFBO
         Y2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334800; x=1719939600;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKhLA/uuVpBLqDNuK6HoaxS7wD29CsICGUEF4cAMpms=;
        b=MvyvLyU4yQJEDGauFWcNnhTNete2yulphDXyuGc7GTcFnPFCEUjAs5JW32WHypecb1
         aJCT0m1xN+w+SDmCHk+C/utWDgrIkCsbsAU5OW18/4xHeS1q+kUs6dk6afI9WLeOb2gL
         JyMwjZlOMra5OUuUO+havXAQSlm37qgO6hBX5E6Mxe3MfxNhdVBRChE8OkZ9faWJpoy4
         xlshOp9K0GaUE3mXzHjx4n7oWBeJAHD/ulb5PuSq5fOfUwDS6CNIsrIWyig952zxN4TJ
         /+33BovhJZKZ/oGu4VO82FDGLYjn4lpsurb0LWJo+lC/10xBAdUxRqcUIiR3yur75DL/
         u1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXDlQSRKIQXVlcAqRGxbpscKxr9hYXz8hc0hX/mewsSxi4wVI3wKyfU6F9cW2/k1ZoMHFOKRi0ntTFvbGodGnCQDGdM0JdxRHkN
X-Gm-Message-State: AOJu0Yzqsn2wU3PonnH/g8Y8luV+kWc7mCOZxe+bY//PH/9WIX5YV0Oq
	t0dWIUy1xngdpS7cvvbXjZZLBk4YirkFBmyf0zvw/xxpitXvrH5FqZVWrCrjZUY=
X-Google-Smtp-Source: AGHT+IGuDftD/fHoijaVLzFccwmGUpMG5buqZhT6v/Ke1w4CDd5JIUPcSTNtgPBRlJeit4/74Hb6Nw==
X-Received: by 2002:a05:6000:154d:b0:362:5816:f134 with SMTP id ffacd0b85a97d-366e9463da3mr7697083f8f.13.1719334800016;
        Tue, 25 Jun 2024 10:00:00 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b30c:4c5e:f49e:ab33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638301cffsm13399466f8f.10.2024.06.25.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:59:59 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-iio@vger.kernel.org,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
In-Reply-To: <190ccd62-0803-46fa-87ee-0f9cef5a784e@baylibre.com> (David
	Lechner's message of "Tue, 25 Jun 2024 09:52:30 -0500")
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<20240624173105.909554-3-jbrunet@baylibre.com>
	<04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
	<1j4j9hift4.fsf@starbuckisacylon.baylibre.com>
	<190ccd62-0803-46fa-87ee-0f9cef5a784e@baylibre.com>
Date: Tue, 25 Jun 2024 18:59:58 +0200
Message-ID: <1jr0clgdpt.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 25 Jun 2024 at 09:52, David Lechner <dlechner@baylibre.com> wrote:

> On 6/25/24 3:31 AM, Jerome Brunet wrote:
>> On Mon 24 Jun 2024 at 17:51, David Lechner <dlechner@baylibre.com> wrote:
>> 
>>> On 6/24/24 12:31 PM, Jerome Brunet wrote:
>>>> Add support for the HW found in most Amlogic SoC dedicated to measure
>>>> system clocks.
>>>>
>>>
>>>
>>>
>>>> +static int cmsr_read_raw(struct iio_dev *indio_dev,
>>>> +			 struct iio_chan_spec const *chan,
>>>> +			 int *val, int *val2, long mask)
>>>> +{
>>>> +	struct amlogic_cmsr *cm = iio_priv(indio_dev);
>>>> +
>>>> +	guard(mutex)(&cm->lock);
>>>> +
>>>> +	switch (mask) {
>>>> +	case IIO_CHAN_INFO_RAW:
>>>> +		*val = cmsr_measure_unlocked(cm, chan->channel);
>>>
>>> Is this actually returning an alternating voltage magnitutde?
>>> Most frequency drivers don't have a raw value, only frequency.
>> 
>> No it is not the magnitude, it is the clock rate (frequency) indeed.
>> Maybe altvoltage was not the right pick for that but nothing obvious
>> stands out for Hz measurements
>
> I'm certainly not an expert on the subject, but looking at the other
> frequency drivers, using altvoltage looks correct.
>
> But, we in those drivers, nearly all only have a "frequency" attribute
> but don't have a "raw" attribute. The ones that do have a "raw" attribute
> are frequency generators that use the raw attribute determine the output
> voltage.
>
>> 
>>>
>>>> +		if (*val < 0)
>>>> +			return *val;
>>>> +		return IIO_VAL_INT;
>>>> +
>>>> +	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */
>>>
>>> Shouldn't this be IIO_CHAN_INFO_FREQUENCY?
>> 
>> How would I get raw / processed / scale with IIO_CHAN_INFO_FREQUENCY ?
>> 
>>>
>>> Processed is just (raw + offset) * scale which would be a voltage
>>> in this case since the channel type is IIO_ALTVOLTAGE.
>> 
>> This is was Processed does here, along with selecting the most
>> appropriate scale to perform the measurement.
>> 
>>>
>>>> +		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
>>>> +		if (*val < 0)
>>>> +			return *val;
>>>> +		return IIO_VAL_INT_64;
>>>> +
>>>> +	case IIO_CHAN_INFO_SCALE:
>>>
>>> What is this attribute being used for?
>> 
>> Hz
>> 
>>>
>>> (clearly not used to convert the raw value to millivolts :-) )
>>>
>>> Maybe IIO_CHAN_INFO_INT_TIME is the right one for this? Although
>>> so far, that has only been used with light sensors.
>> 
>> I think you are mixing up channel info and type here.
>> I do want the info
>>  * IIO_CHAN_INFO_RAW
>>  * IIO_CHAN_INFO_PROCESSED
>>  * IIO_CHAN_INFO_SCALE
>> 
>> I want those info to represent an alternate voltage frequency in Hz.
>> I thought type 'IIO_ALTVOLTAGE' was the right pick for that. Apparently
>> it is not. What is the appropriate type then ? Should I add a new one ?
>
>
> The documentation at Documentation/ABI/testing/sysfs-bus-iio explains
> what the combination of a channel type and info means.

Oh missed that, Thx

>
> For example, out_altvoltageY_raw is defined as it used for the frequency
> generator case that I mentioned above. in_altvoltageY_raw is not defined
> which means probably no one has needed it yet. But it would still be the
> voltage value, not the frequency.

Got it. So the type I picked is wrong for sure.
So, maybe I need something new to measure a frequency ?

>
> There also isn't a in_altvoltageY_input defined ("_input" is the sysfs
> name for IIO_CHAN_INFO_PROCESSED). But in general, "input" (processed) in
> IIO just means the value in standard units instead of a raw value. It
> doesn't mean that any extra signal processing was done. And "scale" is
> just a way to convert "raw" to "input" (processed). So channels will either
> have "raw" and "scale" or only have "input" (processed), but not both.
>
> Could you describe at a higher level what the use case for the various
> values being exposed here are? I think that would be helpful in figuring
> out where they actually fit in to the standard IIO attributes.

So as discussed in the cover letter, This HW used to be driven by a driver
living in drivers/soc/amlogic/meson-clk-measure.c .
It provides debugfs entries to observe the rate of 128 system clocks.
It was fine until now and mostly used for debug in userspace.

To solve a problem with implementing eARC support in ASoC, I need
another driver to access the measurements, as simply as possible.
IIO provides an interface like this and the HW actually does
measurements so I seems like a good fit. I've got it to work
and happy with the result, both on the IIO and ASoC side.

What is really important to me is the information provided with
IIO_CHAN_INFO_PROCESSED, because the algorithm will adapt the scale (the
duration the clock is observed for) to not overflow the output and get the
best precision achievable. It is a compromise really. Consumer do not
have to worry about it, they'll get Hz.

I'd prefer to avoid having that algorithm (duplicated) in the consumers,
especially if it is a driver.

I've provided RAW and SCALE because it is cheap and easy to do TBH.
I can live without it. It is meant for consumers (if any?) that would
know better, like want to prioritize speed over precision.

Eventually that driver could evolve and also provide duty cycle
measurements, which is another reason why I think IIO is a good fit for
it.

>
>> 
>>>
>>>> +		*val2 = cmsr_get_time_unlocked(cm);
>>>> +		*val = 1000000;
>>>> +		return IIO_VAL_FRACTIONAL;
>>>> +
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>> 

-- 
Jerome

