Return-Path: <linux-iio+bounces-16857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18892A61926
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 19:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F073BCAAC
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE276202C39;
	Fri, 14 Mar 2025 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKb7g13u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7A133987;
	Fri, 14 Mar 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975998; cv=none; b=qWCmRpz5r/WX6vARZLfPS2NAgyAisyYk4uXTKKFcfBOsYAcILXZx6M66JKq9rszVFoynJwdLcHvOlDLf6ZMeeOcJG4Xu1R/c4C11+eew0/eTViRmHljqBiVEqCQ1tnC71wGz2lepJ5NQLG61vubePEjpib7+36Ims1osZm+KaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975998; c=relaxed/simple;
	bh=MEOmtqTEiVJQr927TcxuyiQEiUmBPWzmltaQ8JvFgLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGVpD3Ct1/zIvZQY1khlOoZixvJxXmympz66XJXRtnSRM2t6H2tRkEUylhdPINUPCr0iekJ/qQH1O945rcMf/fL6YCXLgEWpKxdFlO4SBLhwAiEWJ7aOOKvvQDbOxqnh2R3c4qYYUdm9B1tujkzZxNe4YNHPxZ6TrfzzWS85yXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKb7g13u; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2c663a3daso489435966b.2;
        Fri, 14 Mar 2025 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741975995; x=1742580795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRXcmIk1FrJUoiaKnTEHuirTRRO0REhDyJUvBh6x6zI=;
        b=dKb7g13u+XI87wqi+HOp5A4uWbdGKosQ77IAYAw/wEl42N1mWwK3Ps944bWYMU4f7w
         Z3hjyaBaZwY1/T6aXLyfEg4paIxPz/hrGEWWUph/ACYDUyts9Il9Umduk9IxZ7hjtrid
         j7BQ9+8fkbgqVmZS2f4vdQXYNy6mTP+ySisP1fosAN1LX+RKiDQFOpP1hHiOi7IURytH
         nfrevjAr754dWwXqf72OnQ7O+VQm2qEtPdo9FBV72PzzOFeftibc/uBhgkyls73tWyiC
         2K3L5c2F+atKIqNr9+VQl/kdDUVbDqoWrA42rXJ5A+mengTgNj5RuLwWDr5BEcgWaVIO
         YLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975995; x=1742580795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRXcmIk1FrJUoiaKnTEHuirTRRO0REhDyJUvBh6x6zI=;
        b=MoSpjrSBfZuCX834TC8503d8NbfsoDiR1v0xlL5ZZ/hkFFZUQlKeCEw1lj94BCscWI
         4TYNewqUaotrfv4FMguVF9b2dXwZkC9lvirgt1/hc+W1Q+9HhPkDj/VIv5aV1Zg0KsNJ
         10qIjDMcEEDsp+Dbq2KPLP/OCr9FUMcViNmsxckBuAWgpeICT9QBVZNK5RLDDLAYZo6Y
         DWDcIw2sYF4J2eWytX/GvEn338JeT+UFrMrs31mAzzWypB1UJ+TspODlLIB1Wi+kBEsT
         qbqvZLMo0J0TYdXFwLb7KMSD8DHx6PhQCvfVugcayugUrjxXmmJksMLHIjKvXr+e1EAD
         +G+A==
X-Forwarded-Encrypted: i=1; AJvYcCVQF04bKZdo4bQwIlFRSdTKK1sW20Xo8az+nQbDSurV/0weTWNxC+GqqDvEyTS7n3wTy13vMZTN/d6rb4VP@vger.kernel.org, AJvYcCWLRzYYReNdkLU5AK4TUNHVr+HCsvIWxYRxrgIeiFzrYez9nxFGyPxx+PgGintDy6hXL7V6z/eX/9+0@vger.kernel.org, AJvYcCXjCnOL8xGDiBif26Tl4FC1+tnxwZqXMeXIfLMuMB12niri3NCrp/NFz+u6Kcq/dYN631Jmw/eL6cxP@vger.kernel.org, AJvYcCXqmPQVPZ1YUpo78crD4JPxg2zqgyokE56ZNKUweti7jVhqlTJAjOehcjmxncd2REUlSEd51cjBupMd@vger.kernel.org
X-Gm-Message-State: AOJu0YyIE/wfgVuMMVpP8GisLE+1g7LVrbT9Z+XOaFoKz3+tfUmqUAn5
	LxG8/0ndN3Oag4tiWR3wecCMa2Pl51+yPCICKA6pQuTnaHGrd+W3
X-Gm-Gg: ASbGncv3UX2FDxI6duASgEKc0f6DA1+y17fWWQa2V4OaFXQGuTT5mVfF3HhP6Yb2tuC
	PgrjAXwBA3TKlwApBe5aLJzs8WhP4G4uwA5+BorX8t58Eh/b68+Sw1AE10K5ZVrH8pY1n5bKnW+
	x67U8dnYShHdi3XO1KaY7tGMWQWgUbn+0Ff6Y0BeLJzWF7SEhbegAzeG+jaqsd9QzJ0YToPqpWh
	aIqCQewZYn7HWoQpl5uPsem/33dZfeXgGKm9vipnWN4kX/PIh0Eas3cc/YpSilmhCijuE8wFOOl
	ub1UwQp2ajvji6G5/nb9F92p5e32RVE5THQFixPbJ7Iqg7yrWim4N6VAEaSES7zW
X-Google-Smtp-Source: AGHT+IEjf0PtfzbVYlpokTFdwyHVVJhkNzfonJaVRGcGAd8ZFMzZDsbK/40bHr1xYluNrS/Qd7YYpw==
X-Received: by 2002:a17:907:a08a:b0:abf:4da0:28e8 with SMTP id a640c23a62f3a-ac330183f41mr402841166b.17.1741975994455;
        Fri, 14 Mar 2025 11:13:14 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeb24sm255764366b.9.2025.03.14.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 11:13:14 -0700 (PDT)
Date: Fri, 14 Mar 2025 19:13:11 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Message-ID: <c62l6jv5vgsxnbipw7jar6tikjavwybdxaurz7hkdowbamc7ic@ak2rva3ujmaa>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
 <CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
 <e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
 <20250310195416.6d8c64f2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310195416.6d8c64f2@jic23-huawei>

On Mon, Mar 10, 2025 at 07:54:16PM +0000, Jonathan Cameron wrote:
> On Sun, 9 Mar 2025 21:49:24 +0100
> Jorge Marques <gastmaier@gmail.com> wrote:
> 
> > > > +.. list-table:: Driver attributes
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Description
> > > > +   * - ``in_voltage0_raw``
> > > > +     - Raw ADC voltage value
> > > > +   * - ``in_voltage0_oversampling_ratio``
> > > > +     - Enable the device's burst averaging mode to over sample using
> > > > +       the internal sample rate.
> > > > +   * - ``in_voltage0_oversampling_ratio_available``
> > > > +     - List of available oversampling values. Value 0 disable the burst
> > > > +       averaging mode.
> > > > +   * - ``sample_rate``
> > > > +     - Device internal sample rate used in the burst averaging mode.
> > > > +   * - ``sample_rate_available``
> > > > +     - List of available sample rates.  
> > > 
> > > Why not using the standard sampling_frequency[_available] attributes?  
> > Because sampling_frequency is the sampling frequency for the pwm trigger
> > during buffer readings.
> > sample_rate is the internal device clock used during monitor and burst
> > averaging modes.
> 
> For an ABI that is very vague and the two use cases seem to be logically
> quite different.
> 
> Seems that for each trigger we have an oversampling ratio controlled number
> of samples at this rate. It is unusual to be able to control oversampling
> rate separately from the trigger clock, hence the lack of ABI.  If
> we add something new for this it should something relating to oversampling.
> oversampling_frequency perhaps.
> 
> For monitor mode, it is tied to the sampling frequency for most devices.
> But there are exceptions.  E.g. the max1363. Trick is to make it an event
> ABI property and hence under events/ rather than in the root directory.
> 
> In this case you'll have to store two values and write the appropriate
> one into the register to suit a given operating mode.
> 

If doing buffer captures with oversampling enabled, both sampling
frequencies have an impact:

e.g.,
oversampling: 4
sample_rate: 2MHz
PWM sampling frequency: 500KHz

PWM trigger out (CNV)   |       |       |       |       |
ADC conversion          ++++    ++++    ++++    ++++    ++++
ADC data ready  (GP)       *       *       *       *       *

For monitor mode, it will constantly be doing conversion to check for
threshold crossings, at the defined sample_rate.

I like the idea of having the device's sample_rate as
conversion_frequency.

> > 
> > > > +
> > > > +Threshold events
> > > > +================
> > > > +
> > > > +The ADC supports a monitoring mode to raise threshold events.
> > > > +The driver supports a single interrupt for both rising and falling
> > > > +readings.
> > > > +
> > > > +During monitor mode, the device is busy since other transactions
> > > > +require to put the device in configuration mode first.  
> > > 
> > > This isn't so clear to me. Is this saying that events do not work
> > > while doing a buffered read? Do you need to do need to read the
> > > in_voltage0_raw input to trigger an event?
> > >   
> > No, the device monitor mode and trigger mode autonomously samples using the
> > internal clock set with the sample rate property.
> > I rephrased that to:
> > 
> >  The feature is enabled/disabled by setting ``thresh_either_en``.
> >  During monitor mode, the device continuously operate in autonomous mode until
> >  put back in configuration mode, due to this, the device returns busy until the
> >  feature is disabled.
> > 
> > The reasoning is that during configuration mode no ADC
> > conversion is done, including if the previous mode was autonomous.
> > If instead of return busy the driver hided this and resumed monitor mode
> > after the access, a hidden (to the user) monitoring down-time would and
> > thresholds crossings could be lost, undermining the feature.
> 
> hmm. This is a trade off between usability and precise matching of expectations.
> From your description does monitor mode only trigger if the threshold is
> crossed or is it a level comparison?  If it's level I'd consider the
> option of brief disabling.  Unlikely to be a problem interrupting things
> in vast majority of usecases. Documentation can then express this issue.
> 

The gpio asserts when the threshold is crossed, and desserts when it is
back in bounds.
The interrupt controller should be configured to detecting rising
edges, to not call multiple irq_handlers for the same crossing.
If the interrupt controller is set to trigger on level,
multiple irq handler calls will occur before being able to access
the device register to disable the GPIO.

Jorge

