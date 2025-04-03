Return-Path: <linux-iio+bounces-17590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B18A79E48
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 10:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B638189667C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1111EF361;
	Thu,  3 Apr 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc46lm7H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91171A01B0;
	Thu,  3 Apr 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669355; cv=none; b=rNlVftbkMZlUrA1RjmzasyqihVuWyaryfIFrNTYKEIPmMF2UiqmbMOiLfJmyl3gas74deIzVQzwVhox0tzY1X3nc0o8804Ox+My8IfZd2z/4QNA/lqpGG6LqYcXFUFPwpgoYi2mF19aJTW51V527uwVPJYPN0XyYAX9LVwSN/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669355; c=relaxed/simple;
	bh=nB88aIuK+GXRGu/1hePx19gtUS3ySa203EKXV4Y3MRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTfpzZYbE2lsD7E6rgaKfyZWBN3DlTA9tPFoLbSFvkUOMtSvX6X1dEBXOPkguq8sdG49rUaKmV5fxPFnBIivj18mtN9bDCKPsBsq2WnZVPeMUo906AmkagdYsdRapkcHfNWlHWq1LYZjj9HRIKF7hTFlJEjL2aA1LyytJLBbKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc46lm7H; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso5542105e9.1;
        Thu, 03 Apr 2025 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743669352; x=1744274152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9lazPUWMeeXGDT8GL53BUL0dRgSLWRjWydFayIVnBY=;
        b=Bc46lm7HBhFQ8nWIbH+Fuq0kHRucT0ydhwkcIk3s11PQ+8Jn3D3jXlgm5nO1jhsX1V
         NpG08BLp6IS99cDW8JEydEQ5HPuijclET6rx2cIKlQPIB236bp90/WeOO7wDM1HgJYXu
         b5pVEIc3C8qfCjPttwCZAePJKe5jP4QaArHKFWZKoQWbzYzjc0JJ722RLKO5TllhMHcy
         tCj/AJTUznjEBbPGSFlFqCkVbuFe+5P7o5VOKoNnffF8qtqXmTr3MSKOGAx3R79+s1u1
         MlEMJ9T3IjPb7+YV2qjdfpfVcJNAUdKfsG5HkJxIZ5mCfyZwRZpEJLj0eag1XL25ICZT
         HrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743669352; x=1744274152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9lazPUWMeeXGDT8GL53BUL0dRgSLWRjWydFayIVnBY=;
        b=pSv+SomQJ73aZczC8iZIDptgEdKo/O0Jf2SVkZfucUqOPWne6euPkOgmOlhVpEFtU3
         2BF4rCLSWJvFpKMvgJfxzxo5oGlW1b2GEqcQDhwG9ylvDfCRBjzfwvUIn4F0DW7XQqUF
         c2Ta9Z+91BBV4Q2cK31mwPnEErSuTsVSI0mr2i5sIUomrv7ZwT6RHT1YxnvV6Wc3YDam
         nlB6a0MGWOpI887RsIT4tkNq2zEWNNe5s+F2FDK1NkOO0yMj4fAPOLrisNzFn+yn2RAY
         XemKPZw5aZjso3YRSk06PpQjXJbPspZhmhd8UI7ZbjDCCKRJJkuFPa1D2H8m8/EeZiOq
         0X1w==
X-Forwarded-Encrypted: i=1; AJvYcCXIACsLdQDoDsjeSV8DhdK6nFyKUqaxPoKXXzzEXx5ly0HD6TNpftD3Fk0m9fnR45H07zxmY9hJLjcOzQsI@vger.kernel.org, AJvYcCXipTKFB421/upMd2hllAkwYT1b4nFOyHQK3bDhqKJKpN+Zaz0Agzy5PJFu9+QvC3sQDWzCecHFTbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xQLaoXEycwSUmJc1aWVoy30ASDav3ZaGkxl3NFDH5gESYaDY
	3OHfM2hgfonaVEhAfehK9aOscyB0KDEg3qslxf+vhFcxwFWPpGN7
X-Gm-Gg: ASbGncvDBIJSvAGkNEhZBSirSpywdwVs1JRxqH7dPSppPD67z9CfKYP3Eose5FyD7Zs
	0OlzDdT0Ysrsl6qP2Dyj2qiTY9qkbSjOG7IyQKI6ToUfNRz7GjYzLZt0R7clo3P+oavgvswNXr8
	ckpKRS5jbhcAdp/Y1U3gH8ey0690sNOzoBAIujf71U5K9+XL6PveW8rQH78WflKU+XfWjJ6vlZ3
	4WQ1gWSJv0HHdfIMvRdtGpGW7cVGlQV+KA9NDRz/JFnKmnL6KieCj9jWg5OFt7UnJkarEmvNfq2
	KuymsPYvsYE+LQcDi4bO3hRHktRqAWC9UmNDZjKhr6da/yclIzSjGn3Z0nHURsXP5g==
X-Google-Smtp-Source: AGHT+IEOn4903b+1QbZsryGx30m9Q2J6NlCejhHxkm19JdjJuGO18neb4wh5B6lAbiLZXvJ55LjHaw==
X-Received: by 2002:a05:600c:1907:b0:43d:23fe:e8a6 with SMTP id 5b1f17b1804b1-43ec133ba19mr12651335e9.5.1743669351669;
        Thu, 03 Apr 2025 01:35:51 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm14873535e9.9.2025.04.03.01.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:35:51 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:35:48 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <pzqfq3w3phov244vnuxpl3t3bololdb3uqyx25ekvg3wzvbco3@jrokyjyc57fl>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
 <20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
 <20250330181320.0ec4351c@jic23-huawei>
 <3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
 <20250330185353.150fc33a@jic23-huawei>
 <hf5dwxs62oof3gom43c6rkdsq3gky6eplxej627t46ktt5blfr@kpmjpxku4inc>
 <20e8538f-7a73-42a5-87b1-0c04b54375c6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e8538f-7a73-42a5-87b1-0c04b54375c6@baylibre.com>

On Wed, Apr 02, 2025 at 03:27:51PM -0500, David Lechner wrote:
> On 4/2/25 8:47 AM, Jorge Marques wrote:
> > On Sun, Mar 30, 2025 at 06:53:53PM +0100, Jonathan Cameron wrote:
> >> On Sun, 30 Mar 2025 12:34:39 -0500
> >> David Lechner <dlechner@baylibre.com> wrote:
> >>
> >>> On 3/30/25 12:13 PM, Jonathan Cameron wrote:
> >>>> On Fri, 21 Mar 2025 15:50:02 +0100
> >>>> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> Once you dig into it, the current situation is even more complicated than
> I expected. :-o
> 
> This reply has ended up being mostly a brain dump of my observations. I hope
> it isn't too confusing. Consider this more of a brainstorm on a future
> documentation page on sampling rates rather than commenting on what to do
> on this particular patch. :-)
> 
> ---
> 
> To make sure we are clear, I think we need to define some precise terminology,
> especially with regard to "sample rate" since that can be used to mean a
> lot of different things.
> 
> There is the "IIO sample rate" (could also call it the "effective sample rate")
> that is the rate that we push one complete set of data to an IIO buffer. In
> many cases, this would be the frequency of the hrtimer trigger that is configured
> as the trigger for the iio:deviceX.

Yes.

> 
> On the other end of the spectrum, we have the "conversion rate" which is the
> rate that individual ADC conversions can happen.

Yes.

> 
> What I had not seen before, but now I see in existing drivers, is that these
> may actually be completely independent. In other words, the hrtimer trigger
> only triggers reading the most recent set of conversions and conversions are
> driven by a completely separate trigger, generally some sort of clock in the
> ADC itself.
> 
> So I think we should expand the diagrams below to show more layers for the
> completely general case.
> 
> >>>>   
> >>>>> Some devices have an internal clock used to space out the conversion
> >>>>> trigger for the oversampling filter,
> >>>>> Consider an ADC with conversion and data ready pins topology:
> >>>>>
> >>>>>   Sampling trigger |       |       |       |       |
> >>>>>   ADC conversion   ++++    ++++    ++++    ++++    ++++
> >>>>>   ADC data ready      *       *       *       *       *
> >>>>>
> 
> For terminology, let's call this "burst mode" oversampling (maybe also
> referred to as "triggered mode" in some data sheets).
> 
> >>>>> With the oversampling frequency, conversions can be evenly space between
> >>>>> the sampling edge:  
> >>>>
> >>>> I'm not sure what this second example is providing.  Are you suggesting
> >>>> that if we don't provide oversampling frequency we should assume this
> >>>> pattern?  i.e. it is the default?
> >>>>   
> > 
> > The default is to do the n-conversions sequentially (n*t_conv),
> > "left-aligned" as in the diagram above.
> > The main application for oversampling is to average out the noise over a wider
> > bandwidth.
> > 
> > I looked into some of the drivers with oversampling and the supported devices
> > datasheets:
> > 
> > * ADS1298: Single field for sampling rate and oversampling,
> >            I assume the values are the maximum values that the
> > 	   oversampling time does not exceed the sampling period.
> > * RTQ6056: Field for oversampling and conversion time,
> >            maximum sampling period is roughly n*t_ovr.
> > * MCP3561: Field for oversampling and conversion time.
> >            maximum sampling period is roughly n*t_ovr.
> > * AD7380:  Field for oversampling and fixed conversion time,
> >            3 MSPS for the AD7380 and 4 MSPS for AD7381,
> >            maximum sampling period is n*t_ovr, e.g. f_samp=(6/4MSPS).
> > 
> > None will or claim to stretch over the sampling period the oversampling
> > conversions, but rather, do the n-conversions at oversampling rate,
> > providing the conversion as soon as it is ready and idling until the
> > next edge of the sampling frequency.
> > 
> >>>>>
> >>>>>   Sampling trigger |       |       |       |       |
> >>>>>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
> >>>>>   ADC data ready         *       *       *       *       *
> >>>>> 
> 
> And let's call this one "continuous mode".
> 
> But as we will see, both of these are a bit ambiguous in their current
> form. The complete picture is a bit more nuanced.
> 
> ---
> 
> Let's take the RTQ6056 case (since I actually looked at that one before
> as inspiration for developing another driver).
> 
> The chip itself is programmable and can operate in either a burst/triggered
> mode or in a continuous mode. However, the way the IIO driver is implemented,
> it is configured in continuous mode to trigger ADC conversions. But uses an
> independent IIO trigger that triggers reading sample data. So from the point of
> view of the data in a buffered read, it looks like burst mode. But the value
> of the sampling_frequency attribute (the ADC device attribute, not the hrtimer
> trigger attribute) is for the hardware continuous mode.
> 
> Hardware:
> sampling_frequency   |       |       |       |       |
> ADC conversion       + + + + + + + + + + + + + + + + + + + +
> ADC data ready             *       *       *       *       *
> sample number              S0      S1      S2      S3      S4
> 
> IIO:
> hrtimer frequency               |                     |
> I2C read                         *                     *
> push to buffer                   S0                    S3
> 
> The IIO (hrtimer) trigger only reads the most recently available data, it
> doesn't trigger any conversion. The clocks are asynchronous.

That implementation sure works for low-speed converters where power-consuption
is not a concern.

> I think adding an oversampling_frequency attribute to this driver could make
> it easier to used/understand since oversampling_frequency would be exactly
> the "conversion rate". Compared to the current situation where the "conversion
> rate" is the sampling_frequency / oversampling_ratio.

I agree.
Applicable only for devices where sampling_frequency and
oversampling_frequency are detached.
Devices that provide a value for the fixed oversampling_frequency
frequency could have the attribute as read-only (e.g AD7380).

> 
> It is also interesting to consider that if someone decided to add SPI offload
> support to this driver, then there would be the possibility of using burst/
> trigggered mode or continuous mode and might want to support both even. In
> fact this is exactly the possibility we have with ad7606 that I mentioned in
> a previous reply. So we might even need an oversampling_mode attribute to allow
> selecting one or the other. But that is something to save for a ad7606 patch
> series.

For AD4052:

* iio raw read is the usual low-speed, CNV->DRDY->Read.
* iio buffer: uses offload, samp_freq is PWM node freq.
  - iio triggered buffer: not included on proposed series,
                          but doable as a fallback if offload
                          not available.
* iio events: monitor mode, device exits monitor mode on event
              (device specific behaviour, cannot be changed),
              the irq is propagated as iio event.

iio oversampling changes the iio raw and iio buffer readings behaviour
(takes longer to get a sample out).

> 
> ---
> 
> Another driver probably worth considering is ad4030. In this one, there is no
> internal clock to drive conversions. So, for oversampling, the sample rate is
> just "as fast as possible" (currently bit-banging a GPIO). So it doesn't actually
> have an oversampling frequency.
>
>
> If someone ever decided to hook it up to some hardware that could actually
> trigger a finite number of pulses at a specific rate, then this new attribute
> for oversampling_frequency would become useful. For this particular driver,
> the presence or absence of an oversampling_frequency attribute would have
> a meaning, but I don't think this generalizes to other ADCs.
> 

The hardware is the usual CNV trigger, so it is not really about hooking
up more hardware, but changing the behaviour
(takes n-CNV triggers to get a sample out).

The AD4052 also supports what you described, it is the "Averaging Mode" (p.31),
while the implemented uses the "Burst Averaging Mode" (p.32).
In the "Averaging Mode", effective sampling rate is
sampling_frequency / oversampling_ratio, while in
"Burst Averaging Mode" is sampling_frequency.

So, in "Burst Averaging Mode", the oversampling_frequency is *detached*
from sampling_frequency.

The driver could hide away the effective sampling frequency discrepancy
by reading the state and scaling sampling_frequency based on
oversampling_ratio, exactly like RTQ6056.

> ---
> 
> AD4695 is an interesting case to consider as well. When used without SPI offload
> support, we actually don't allow oversampling currently. If we did though, it
> be similar to the ad4030 in that we could either make it "as fast as possible"
> by banging a GPIO or the CS line depending on how the chip was wired up. Or it
> could use some specialized hardware to generate a pulse train to actually get
> a known conversion rate.
> 
> For now though, oversampling is only implemented when using a SPI offload.
> It works like this:
> 
> Channel		1   2       3 1   2       3 1   2       3
> OSR		2   4       1 2   4       1 2   4       1
> Trigger		| | | | | | | | | | | | | | | | | | | | |
> ADC Conversion	+ + + + + + + + + + + + + + + + + + + + +
> ADC data ready	   *       * *   *       * *   *       * *
> IIO sample                   S0            S1            S2
> 
> In this case, there isn't a "sample" trigger that triggers a burst of
> samples. Rather, there is only a "conversion" trigger that triggers
> individual conversion. In other words, we would call this "continuous mode".
> And it also shows that some chips allow individual channels to have
> different oversampling ratios.

I find this "continuous mode" name confusing, maybe stick with
"averaging mode", where each CNV pulse triggers a conversion and
"burst averaging mode", where a CNV pulse triggers a burst of
conversions.

> 
> In this case, it would be nice to have an oversampling_frequency
> attribute as well because it would exactly correspond to the conversion
> rate. Currently each channel has a sampling_frequency attribute that
> is oversampling_frequency / oversampling_ratio (same as RTQ6056).

I don't mind that, is the "hide away" I mentioned earlier.
I believe that, when oversampling is a driver feature,
oversampling_frequency is either:
 * The RW conversion frequency:
   - averaging mode:       oversampling_frequency, sampling_frequency,
                           and oversampling_ratio affect each other,
                           due to "hide away" logic.
                           One CNV one conversion.
   - burst averaging mode: sampling frequency and conversion frequency
                           are detached, doesn't need "hide away" logic.
                           One CNV one sample.
 * The RO conversion frequency with the role of maximum conversion frequency.

> 
> ---
> 
> So my conclusion here is that the new proposed oversampling_frequency
> attribute has nothing to do with "burst mode" or "continuous mode" it
> has the same meaning in both cases.

It depends if it is detached from sampling_frequency or not.
If the norm is to "hide away" with extra logic in "averaging mode",
they become interdependent.
If sampling frequency and conversion frequency are detached from each
other, oversampling_frequency for sure needs to exist.

>                                     It is effectively the rate for
> individual ADC conversions.
> 

Yes.

