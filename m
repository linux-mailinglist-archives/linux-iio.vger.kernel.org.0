Return-Path: <linux-iio+bounces-17775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD76A7E6E8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B52F3A603B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232A207DE5;
	Mon,  7 Apr 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmPBbxrI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040B2080F6;
	Mon,  7 Apr 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043345; cv=none; b=rNAJSXymeMABGRbXITT3btUm4kxssylYfPiKmnjMiwpzsJa46OyZZ6IqcJlfgIbl4BF96ysPpTRYbQyJgVlqA2bsQZj13HhNRYPSwgtbDSmO5X3fgpwtldHD4bBR/f0JDDK3MGUkPLKkW70VbLEEUrYbHE5o0+ccjehvrhPiK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043345; c=relaxed/simple;
	bh=KtIHOdNQKeMynxFwL02h0pMa0qsdkuY3JZlKmiGo5l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbbultQqzm0rF3SXBJtZ6IFUjGUbdhdH/RizvJaqjNLfy7q69JLTxG+oWnhxkR9fgsc7cds7cQLdshA2EIBpjORSJv35RFzaZwdl3Zc/0vVoM1aFBYCpnYyv3/mOvP9SeXNYD1GsFzdVR60z70VASpd6NJnVl6yFpAz587CURws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmPBbxrI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso773331466b.3;
        Mon, 07 Apr 2025 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043341; x=1744648141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOAmmXD6a9+F3mQcnE9I9soTRC0wndr3lQnE5zhuRho=;
        b=jmPBbxrId7UkcGjRevVsI+QWpY7L9ru1qwXMdzaqZej2tHGAvJcJmrv8SI4RSeT+3g
         TYfigFTW0e85qZeOwovgJH3+gHxae7+3v9YSGpm+6Ci4HEbzkbxMLVj63IhqixgzYYft
         vmV24RgtFeA3SYDg0PN/u7rhS+f8OrTlKPpATk+p0TuypIbsp/Gp9l9+gy7x51U3vldP
         6N7sTRpbCqhLElrDcouitubaTX+Dx+ODeOHBA4O2W5O3jQbXa9hLr2VLAZBXSTdU6Szv
         xwuUYz0v8GKiwLgm5qYy5fCqyvDvXyvQc82gShi3ZHGBxl0L8kVw0mhnbp6f9sWjMjQ1
         ZyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043341; x=1744648141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOAmmXD6a9+F3mQcnE9I9soTRC0wndr3lQnE5zhuRho=;
        b=hKgB9BYAUSOrAEsCr7LCr9D1kzjL1Pkx9ddNZkOyscnuZiM4H01X3PSa+x+iDf775s
         cmoFI5BRhZP94m3fQ7mki1/K1zU7f/kOmfHSDjoz4QwErAUbbJQ3+EjMa9UbTa2yqPOQ
         NT3so08tw7GaPA6xhURVJ1ubmTyspfb/Xh1kcvgHGbUKGOfpFABvxuyXmmv/cgdUvQaf
         BNxRgAFNW/x+aSznmZ/9TSMmrkI1V1lAOWhWIXOL0PWfJCr/ZBlyXymu9hJP7Ko1I94c
         Uo9iHy5iTxbHahqvYu0mIsAyZuA2prwQ/0R+d/CLw7mjhppqCHHZeRFT+9M009x9RTGn
         /dkA==
X-Forwarded-Encrypted: i=1; AJvYcCUz2kmZOEb1UFn/o5TN7M4lol7j/fyLsHcJgl+6BmGDpCIKTZuSyQsdSC9GaRO/9+/NxWatATrbOJ4=@vger.kernel.org, AJvYcCV2RprgdcC1qz2k1rndxm+qzoSwdoAPa5y/XWvo8Fdoj3JLcmjbgCncxpFtB97vApGZTfXERIjLxutrPVGZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxOk940LeqUfhlbHSpsyLxxnipu4iClBd/KQDlXhI64B7DniUw6
	pcsStORiIq6UFoVCGuSET4bnTTEglbEiIPdSp0pJ/bsZT3E7IZMR
X-Gm-Gg: ASbGnctV4kHx9GGUrRrxJBTaT1dk4A6I0ro8NHPB7qjJAnMrFeFp+mlmy/4fivzz4xw
	mtku24fIKhTDzRZO5BTWtnydXVY8TWubaqmT6hcsOgSdxA79wYMEEW67vp76TSfP+Sv+Mic28DQ
	Q19wdncbImORdnB6HErPxJ4FstIZBrS0WqFbgBXJvLKEsKTGavTBfYGeCzZfhM8mKBLx6+4yHeg
	eaktHxdx2iIPHcytc5Ah39VqVPVLkMDezxTRCA5Em7DJokDoCRJ41RAMxvYXLlnTc6oN4h5UT63
	U/riEc4im3QHT4S0vhlHaWgvgwkZ+osGClJjwHgks+h1SkD9S54jAgAMcJo258ShEiDWHuXUnBB
	u
X-Google-Smtp-Source: AGHT+IGFCBfX6MFbschDUpTHL781sREb6VncER7eE4TYc6/FqW9T1YIyfp43cciblSp5pAe/UeO71A==
X-Received: by 2002:a17:906:6a2a:b0:ac7:37da:cd46 with SMTP id a640c23a62f3a-ac7e77b0160mr805873666b.49.1744043340674;
        Mon, 07 Apr 2025 09:29:00 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c018691csm770464766b.150.2025.04.07.09.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:29:00 -0700 (PDT)
Date: Mon, 7 Apr 2025 18:28:57 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <c53je4hfe76lergtxq2fhoouuer5upla34jd2sq5sdg3kw3rsk@6pjgmuevotnc>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
 <20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
 <20250330181320.0ec4351c@jic23-huawei>
 <3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
 <20250330185353.150fc33a@jic23-huawei>
 <hf5dwxs62oof3gom43c6rkdsq3gky6eplxej627t46ktt5blfr@kpmjpxku4inc>
 <20e8538f-7a73-42a5-87b1-0c04b54375c6@baylibre.com>
 <pzqfq3w3phov244vnuxpl3t3bololdb3uqyx25ekvg3wzvbco3@jrokyjyc57fl>
 <20250406112551.62dab974@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406112551.62dab974@jic23-huawei>

On Sun, Apr 06, 2025 at 11:25:51AM +0100, Jonathan Cameron wrote:
> On Thu, 3 Apr 2025 10:35:48 +0200
> Jorge Marques <gastmaier@gmail.com> wrote:
> 
> > On Wed, Apr 02, 2025 at 03:27:51PM -0500, David Lechner wrote:
> > > On 4/2/25 8:47 AM, Jorge Marques wrote:  
> > > > On Sun, Mar 30, 2025 at 06:53:53PM +0100, Jonathan Cameron wrote:  
> > > >> On Sun, 30 Mar 2025 12:34:39 -0500
> > > >> David Lechner <dlechner@baylibre.com> wrote:
> > > >>  
> > > >>> On 3/30/25 12:13 PM, Jonathan Cameron wrote:  
> > > >>>> On Fri, 21 Mar 2025 15:50:02 +0100
> > > >>>> Jorge Marques <jorge.marques@analog.com> wrote:  
> > > 
> > > Once you dig into it, the current situation is even more complicated than
> > > I expected. :-o
> > > 
> > > This reply has ended up being mostly a brain dump of my observations. I hope
> > > it isn't too confusing. Consider this more of a brainstorm on a future
> > > documentation page on sampling rates rather than commenting on what to do
> > > on this particular patch. :-)
> 
> I think it's worth mentioning that the original oversampling attributes were
> IIRC (note I could be wrong) on self clocking devices such as accelerometers,
> at least sometimes with a hardware FIFO involved. In some cases even then
> the conversions are bursted. In others I think (though can't find an example right
> now) they are dumb enough that if you enable oversampling it clocks the same
> as without. (the 'stretched case below).  A lot of the datasheets are very
> vague!
> 
> 
> > > 
> > > ---
> > > 
> > > To make sure we are clear, I think we need to define some precise terminology,
> > > especially with regard to "sample rate" since that can be used to mean a
> > > lot of different things.
> > > 
> > > There is the "IIO sample rate" (could also call it the "effective sample rate")
> > > that is the rate that we push one complete set of data to an IIO buffer. In
> > > many cases, this would be the frequency of the hrtimer trigger that is configured
> > > as the trigger for the iio:deviceX.  
> > 
> > Yes.
> 
> I'd be tempted focus more on the fully self clocked devices with a dataready signal.
> Bringing in the different clock domain of a hrtimer trigger or similar adds
> yet another layer of complexity.  You get into that below.
> 
> > 
> > > 
> > > On the other end of the spectrum, we have the "conversion rate" which is the
> > > rate that individual ADC conversions can happen.  
> > 
> > Yes.
> > 
> > > 
> > > What I had not seen before, but now I see in existing drivers, is that these
> > > may actually be completely independent. In other words, the hrtimer trigger
> > > only triggers reading the most recent set of conversions and conversions are
> > > driven by a completely separate trigger, generally some sort of clock in the
> > > ADC itself.
> 
> That is 'sometimes' the case.  Often on devices that provide a dataready trigger
> as well (but were we might want to sample much slower, or where some designer
> didn't wire the pin up).  Note the sampling frequency in question here is that
> of the trigger. If the device is self clocked then it typically also provides
> a sampling frequency attribute to describe what it is doing.
> 
> In other cases the hrtimer trigger is starting a conversion (or burst of conversions
> as appropriate).  In those cases if the device provides a sampling frequency
> it is a bound on how fast it can be driven.  That is effectively the same as
> the previous case as if we are sampling latest value, there is no point in
> going faster than the device sampling frequency (hence no different ABI).
> 
> > > 
> > > So I think we should expand the diagrams below to show more layers for the
> > > completely general case.
> > >   
> > > >>>>     
> > > >>>>> Some devices have an internal clock used to space out the conversion
> > > >>>>> trigger for the oversampling filter,
> > > >>>>> Consider an ADC with conversion and data ready pins topology:
> > > >>>>>
> > > >>>>>   Sampling trigger |       |       |       |       |
> > > >>>>>   ADC conversion   ++++    ++++    ++++    ++++    ++++
> > > >>>>>   ADC data ready      *       *       *       *       *
> > > >>>>>  
> > > 
> > > For terminology, let's call this "burst mode" oversampling (maybe also
> > > referred to as "triggered mode" in some data sheets).
> > >   
> > > >>>>> With the oversampling frequency, conversions can be evenly space between
> > > >>>>> the sampling edge:    
> > > >>>>
> > > >>>> I'm not sure what this second example is providing.  Are you suggesting
> > > >>>> that if we don't provide oversampling frequency we should assume this
> > > >>>> pattern?  i.e. it is the default?
> > > >>>>     
> > > > 
> > > > The default is to do the n-conversions sequentially (n*t_conv),
> > > > "left-aligned" as in the diagram above.
> 
> Hmm. What's the default if we don't provide information on the conversion sampling
> frequency?  I don't mean what is most common or what does a particular device do,
> just the default from an ABI point of view.  Either default is no information
> or it is is 'evenly spread'.  
> 

The default is no information for sure.

> > > > The main application for oversampling is to average out the noise over a wider
> > > > bandwidth.
> > > > 
> > > > I looked into some of the drivers with oversampling and the supported devices
> > > > datasheets:
> > > > 
> > > > * ADS1298: Single field for sampling rate and oversampling,
> > > >            I assume the values are the maximum values that the
> > > > 	   oversampling time does not exceed the sampling period.
> > > > * RTQ6056: Field for oversampling and conversion time,
> > > >            maximum sampling period is roughly n*t_ovr.
> > > > * MCP3561: Field for oversampling and conversion time.
> > > >            maximum sampling period is roughly n*t_ovr.
> > > > * AD7380:  Field for oversampling and fixed conversion time,
> > > >            3 MSPS for the AD7380 and 4 MSPS for AD7381,
> > > >            maximum sampling period is n*t_ovr, e.g. f_samp=(6/4MSPS).
> > > > 
> > > > None will or claim to stretch over the sampling period the oversampling
> > > > conversions, but rather, do the n-conversions at oversampling rate,
> > > > providing the conversion as soon as it is ready and idling until the
> > > > next edge of the sampling frequency.
> 
> > > >   
> > > >>>>>
> > > >>>>>   Sampling trigger |       |       |       |       |
> > > >>>>>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
> > > >>>>>   ADC data ready         *       *       *       *       *
> > > >>>>>   
> > > 
> > > And let's call this one "continuous mode".
> > > 
> > > But as we will see, both of these are a bit ambiguous in their current
> > > form. The complete picture is a bit more nuanced.
> > > 
> > > ---
> > > 
> > > Let's take the RTQ6056 case (since I actually looked at that one before
> > > as inspiration for developing another driver).
> > > 
> > > The chip itself is programmable and can operate in either a burst/triggered
> > > mode or in a continuous mode. However, the way the IIO driver is implemented,
> > > it is configured in continuous mode to trigger ADC conversions. But uses an
> > > independent IIO trigger that triggers reading sample data.
> 
> Hmm. To me it looks like that driver should provide at trigger given there
> is a conversion ready interrupt.  I guess the author didn't care for their use cases.
> 
> Ideally it would do triggered capture if using an hrtimer trigger and
> continuous mode only when using it's own trigger. That way data is captured
> only when required. Would get fiddlier though if events were supported (which
> they aren't currently)./
> 
> > > So from the point of
> > > view of the data in a buffered read, it looks like burst mode. But the value
> > > of the sampling_frequency attribute (the ADC device attribute, not the hrtimer
> > > trigger attribute) is for the hardware continuous mode.
> > > 
> > > Hardware:
> > > sampling_frequency   |       |       |       |       |
> > > ADC conversion       + + + + + + + + + + + + + + + + + + + +
> > > ADC data ready             *       *       *       *       *
> > > sample number              S0      S1      S2      S3      S4
> > > 
> > > IIO:
> > > hrtimer frequency               |                     |
> > > I2C read                         *                     *
> > > push to buffer                   S0                    S3
> > > 
> > > The IIO (hrtimer) trigger only reads the most recently available data, it
> > > doesn't trigger any conversion. The clocks are asynchronous.  
> > 
> > That implementation sure works for low-speed converters where power-consuption
> > is not a concern.
> 
> For this particular device it looks more like a stop gap to keep the driver simple.
> Maybe there is some other reason fitting it into a more conventional model
> doesn't work.
> 
> > 
> > > I think adding an oversampling_frequency attribute to this driver could make
> > > it easier to used/understand since oversampling_frequency would be exactly
> > > the "conversion rate". Compared to the current situation where the "conversion
> > > rate" is the sampling_frequency / oversampling_ratio.  
> I hope sampling_frequency * oversampling_ratio or that is broken.
> 
> Sampling frequency is always meant to be the rate at which a device can provide
> data (either exact or maximum if using another trigger).
> 
> > 
> > I agree.
> > Applicable only for devices where sampling_frequency and
> > oversampling_frequency are detached.
> > Devices that provide a value for the fixed oversampling_frequency
> > frequency could have the attribute as read-only (e.g AD7380).
> 
> RO indeed makes sense where it is fixed.
> 
> > 
> > > 
> > > It is also interesting to consider that if someone decided to add SPI offload
> > > support to this driver, then there would be the possibility of using burst/
> > > trigggered mode or continuous mode and might want to support both even. In
> > > fact this is exactly the possibility we have with ad7606 that I mentioned in
> > > a previous reply. So we might even need an oversampling_mode attribute to allow
> > > selecting one or the other. But that is something to save for a ad7606 patch
> > > series.  
> 
> I'm on board with the reasoning for switching between them mentioned above based
> on trigger but if you are doing SPI offload then either:
> 1) Drive the SPI offload from the alert signal and run the device in continuous mode or
> 2) Drive the SPI offload from an external signal and use triggered mode.
> 
> I'm not seeing a usecase for running continuous against an external signal when
> we care about performance. That's kind of the worst of all possible worlds as
> we are reading data we don't care about so wasting power, or getting weird
> beating pattern issues against the internal clocking.
> 
> 
> > 
> > For AD4052:
> > 
> > * iio raw read is the usual low-speed, CNV->DRDY->Read.
> > * iio buffer: uses offload, samp_freq is PWM node freq.
> >   - iio triggered buffer: not included on proposed series,
> >                           but doable as a fallback if offload
> >                           not available.
> 
> I'd do that via the same path as raw read if anyone wants it.  In theory you could
> time off the PWM if you routed that to an interrupt but that is nasty.
> 
> > * iio events: monitor mode, device exits monitor mode on event
> >               (device specific behaviour, cannot be changed),
> >               the irq is propagated as iio event.
> > 
> > iio oversampling changes the iio raw and iio buffer readings behaviour
> > (takes longer to get a sample out).
> > 
> > > 
> > > ---
> > > 
> > > Another driver probably worth considering is ad4030. In this one, there is no
> > > internal clock to drive conversions. So, for oversampling, the sample rate is
> > > just "as fast as possible" (currently bit-banging a GPIO). So it doesn't actually
> > > have an oversampling frequency.
> > >
> > >
> > > If someone ever decided to hook it up to some hardware that could actually
> > > trigger a finite number of pulses at a specific rate, then this new attribute
> > > for oversampling_frequency would become useful. For this particular driver,
> > > the presence or absence of an oversampling_frequency attribute would have
> > > a meaning, but I don't think this generalizes to other ADCs.
> > >   
> > 
> > The hardware is the usual CNV trigger, so it is not really about hooking
> > up more hardware, but changing the behaviour
> > (takes n-CNV triggers to get a sample out).
> > 
> > The AD4052 also supports what you described, it is the "Averaging Mode" (p.31),
> > while the implemented uses the "Burst Averaging Mode" (p.32).
> > In the "Averaging Mode", effective sampling rate is
> > sampling_frequency / oversampling_ratio, while in
> > "Burst Averaging Mode" is sampling_frequency.
>  
> > So, in "Burst Averaging Mode", the oversampling_frequency is *detached*
> > from sampling_frequency.
> > 
> > The driver could hide away the effective sampling frequency discrepancy
> > by reading the state and scaling sampling_frequency based on
> > oversampling_ratio, exactly like RTQ6056.
> 
> Agreed. It would need to do that.  Simple code that isn't messing with oversampling
> ratio expects data at 'sampling_frequency' HZ. We need to maintain that.
> > 
> > > ---
> > > 
> > > AD4695 is an interesting case to consider as well. When used without SPI offload
> > > support, we actually don't allow oversampling currently. If we did though, it
> > > be similar to the ad4030 in that we could either make it "as fast as possible"
> > > by banging a GPIO or the CS line depending on how the chip was wired up. Or it
> > > could use some specialized hardware to generate a pulse train to actually get
> > > a known conversion rate.
> > > 
> > > For now though, oversampling is only implemented when using a SPI offload.
> > > It works like this:
> > > 
> 
> Channel		1   2       3 1   2       3 1   2       3
> OSR		2   4       1 2   4       1 2   4       1
> Trigger		| | | | | | | | | | | | | | | | | | | | |
> ADC Conversion	+ + + + + + + + + + + + + + + + + + + + +
> ADC data ready	   *       * *   *       * *   *       * *
> IIO sample                   S0            S1            S2
> 
> > > 
> > > In this case, there isn't a "sample" trigger that triggers a burst of
> > > samples. Rather, there is only a "conversion" trigger that triggers
> > > individual conversion. In other words, we would call this "continuous mode".
> > > And it also shows that some chips allow individual channels to have
> > > different oversampling ratios.  
> > 
> > I find this "continuous mode" name confusing, maybe stick with
> > "averaging mode", where each CNV pulse triggers a conversion and
> > "burst averaging mode", where a CNV pulse triggers a burst of
> > conversions.
> 
> Naming is tricky but agreed that 'continuous' means far to many things.
> 
> > 
> > > 
> > > In this case, it would be nice to have an oversampling_frequency
> > > attribute as well because it would exactly correspond to the conversion
> > > rate. Currently each channel has a sampling_frequency attribute that
> > > is oversampling_frequency / oversampling_ratio (same as RTQ6056).  
> > 
> > I don't mind that, is the "hide away" I mentioned earlier.
> > I believe that, when oversampling is a driver feature,
> > oversampling_frequency is either:
> >  * The RW conversion frequency:
> >    - averaging mode:       oversampling_frequency, sampling_frequency,
> >                            and oversampling_ratio affect each other,
> >                            due to "hide away" logic.
> >                            One CNV one conversion.
> 
> I'd expect oversampling_frequency to be the dependent one here (so RO)
> In theory we could allow them all to be written but sometimes it is easier
> to just set a precedence (which also has to be what was defined first)
> 
> >    - burst averaging mode: sampling frequency and conversion frequency
> >                            are detached, doesn't need "hide away" logic.
> >                            One CNV one sample.
> 
> For this one RW makes sense.
> 
> >  * The RO conversion frequency with the role of maximum conversion frequency.
> > 
> > > 
> > > ---
> > > 
> > > So my conclusion here is that the new proposed oversampling_frequency
> > > attribute has nothing to do with "burst mode" or "continuous mode" it
> > > has the same meaning in both cases.  
> > 
> > It depends if it is detached from sampling_frequency or not.
> > If the norm is to "hide away" with extra logic in "averaging mode",
> > they become interdependent.
> > If sampling frequency and conversion frequency are detached from each
> > other, oversampling_frequency for sure needs to exist.
> > 
> > >                                     It is effectively the rate for
> > > individual ADC conversions.
> > >   
> > 
> > Yes.
> Agreed. It is a useful thing to expose even when RO.  When it is
> independent (subject to limits is fine) of sampling_frequency
> and oversampling_ratio then it should be RW.  'Maybe' there will
> be other cases were RW makes sense but I'm not yet seeing them.
> 
> Jonathan
> 
> 

All things considered, I believe the appropriate ABI documentation is the following


  What:                /sys/bus/iio/devices/iio:deviceX/oversampling_frequency
  KernelVersion:       6.15
  Contact:     linux-iio@vger.kernel.org
  Description:
           Some devices have internal clocks for oversampling.
           Sets the resulting frequency to trigger a conversion used by the
           oversampling filter.
           If the device has a fixed internal clock or is computed based on
           the sampling frequency parameter, the parameter is read only.

If that's ok I'll resubmit the patch including only this commit,
and then focus on submitting AD4052 driver V2 series.

Jorge

