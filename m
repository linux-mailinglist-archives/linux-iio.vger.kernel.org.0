Return-Path: <linux-iio+bounces-17546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F6A7904C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F521891D21
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E92376EA;
	Wed,  2 Apr 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMkXCd+2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A71482E8;
	Wed,  2 Apr 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601682; cv=none; b=nVAJQBmT4VOBTZiolyb+57d5rGPrJhHFRLvrvUbCvIITKKNE2VuQZltSuIMEedCC82+7NWqRQKCuhBvcurIllCjStllo/mSNxGS2WTcb//t/q93h0AR0o9Kg1ZiGCr7Ol8LywQWvBQCQG1RjUHRATJ0S6GfvWjy4RoqcnN73LO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601682; c=relaxed/simple;
	bh=5pqg6zLhqWbrQmhj97oaIcUUXVatkXyao95j23cFGmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqGErPGK3cq5rQBLab2Fi953AMkH8LnSKc+Fx/f1o95cOm1L0oOUWGQOmOJSASLVXvHcbMigR4mAW7tWYJW0qomPwaOoKdwDu2+fXj1sEJIOxUoeNV5/izd3VOS6qOxGUV7Y8RnyTuC/KsLsJ+3GvCgOTZwQiWk3vHoOqEfeL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMkXCd+2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso48328385e9.0;
        Wed, 02 Apr 2025 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743601679; x=1744206479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GvygB/hI1tANg+GoFEGc0RzG7ale6p40r0YnprvJT4=;
        b=HMkXCd+2bNj7y5RCbkwg9j67qzAbI9+elhO+ippqg4HHkfTCkWQf/Zm7BJea0GWBEL
         6UhkrKROV1+24Pt4sRp0uFVuYcf8N31A9Um9zJ86ROckW48Ft+HhLHaQn+xVNj5b9Pvo
         /nYmx7FB2SrBIyO3Ujvwogq2MyCEJKE9a3nXi8DiEavvAEBqKR1Ii7xBnAWkqk6/GeE4
         tEfg7n1J75KXX53CBzgouhrLxtfRRRE7LouVyS6C7iOs4DQqueM2doPaPOsiarNKchIs
         VQXMhSVu1FGVmg295ZmL17PkVrXOWdC9wa1ANkhr4JnLPnrxOVB1et3vZytVgp7JwGNb
         dbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743601679; x=1744206479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GvygB/hI1tANg+GoFEGc0RzG7ale6p40r0YnprvJT4=;
        b=awTlOCfrQynOdMfXrSYiqYA5AABVzhYJ1FPq+MCG7DOBtUAzE9RUdJyJvciurn5dxy
         Ba/UpgjY3VD1eyt2gxS3Bnb5+mAHwUbjkfdLV9vXfZPNOTU8Dta3cOB7EQ0rRInY79j2
         izp81ZoiaNp+t05u6OFJKvIKL8hfeE+C84mPqZusXkAG9gEqyEMaC7aiyLotgKSZmmsw
         F31wB7HVdP21rFw7/V7e3U6gl0dic1C2icimESjp6ab/xf4Y6JVwpYIEcJbwuThSdiSR
         qDB9TpLRH9m0uNjTIvHb5ObuOMdJ/tmCOsPIfqTLNgths6YyefBTL4DzBiJI6euS3n8f
         VICA==
X-Forwarded-Encrypted: i=1; AJvYcCUjJ3FWJsTXBkEqOJQ86+ANAttyHF4wW2HJMxST71ECiaLxuT6BqcQ6y5X8sY5DUWBN9SyTTkpopI0=@vger.kernel.org, AJvYcCWA3OOC4CFNFrrbAd1ZOoNyZmR5WBxTy4rxlITpE5IckjwIWX3neSPIGZ5cBuKA8EkA32F3pyH+kzYylJ2s@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJlYofivgKOrMCLK6O1L9MQboisOvzYyseLZ0/LfHf27UbDm4
	1s7ZsoXGzTLpPVoYM4PTBS2kwrvmdgXRPPMN2asJ3GIIZxqcB5FUVUfsuOypzZ0=
X-Gm-Gg: ASbGnctXH9a6bf2d2Bc5j3JosdCM0TawKApC9GM3p3LEKwZzq8kXULYnUlaEf2H22i3
	VAGTXHrOofbwluPcgCXm2uoQJDzahJ9/nhvWnwFdL20LSjzwojResGjhXtPKwAWQc5Fz9rjUgJY
	+uNllk7feMoq/90DuLsSMMJY3LMZ7VowOM9pf5CdqrbcjZC/Lr/qd5digkKEKl/tcHjJtlsRxdN
	tt+KezDJzA2u5m/+/Yg/ch0iFdxGkWc3TaWSvsjSQHH48GKeHpk0JulhgVd3vGsBUQF9iAeOVRn
	+CZoXfeVTfkKP8LjanmeRoVd8IUw+Smldjk7OLQh63gLCU293rvYkL8fjqAjRJS7hQ==
X-Google-Smtp-Source: AGHT+IGl4MZkNlpKmbKWA5jBFCDxv2JNwtgWMI7aoRPnkdjFSVrOyvGCGzwNLc162ecScG4L5eLlrg==
X-Received: by 2002:a05:600c:c0d:b0:43d:cc9:b0a3 with SMTP id 5b1f17b1804b1-43db62bd1c3mr160799005e9.22.1743601678916;
        Wed, 02 Apr 2025 06:47:58 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb61369d9sm21209685e9.34.2025.04.02.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:47:58 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:47:55 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <hf5dwxs62oof3gom43c6rkdsq3gky6eplxej627t46ktt5blfr@kpmjpxku4inc>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
 <20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
 <20250330181320.0ec4351c@jic23-huawei>
 <3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
 <20250330185353.150fc33a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330185353.150fc33a@jic23-huawei>

On Sun, Mar 30, 2025 at 06:53:53PM +0100, Jonathan Cameron wrote:
> On Sun, 30 Mar 2025 12:34:39 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 3/30/25 12:13 PM, Jonathan Cameron wrote:
> > > On Fri, 21 Mar 2025 15:50:02 +0100
> > > Jorge Marques <jorge.marques@analog.com> wrote:
> > >   
> > >> Some devices have an internal clock used to space out the conversion
> > >> trigger for the oversampling filter,
> > >> Consider an ADC with conversion and data ready pins topology:
> > >>
> > >>   Sampling trigger |       |       |       |       |
> > >>   ADC conversion   ++++    ++++    ++++    ++++    ++++
> > >>   ADC data ready      *       *       *       *       *
> > >>
> > >> With the oversampling frequency, conversions can be evenly space between
> > >> the sampling edge:  
> > > 
> > > I'm not sure what this second example is providing.  Are you suggesting
> > > that if we don't provide oversampling frequency we should assume this
> > > pattern?  i.e. it is the default?
> > >   

The default is to do the n-conversions sequentially (n*t_conv),
"left-aligned" as in the diagram above.
The main application for oversampling is to average out the noise over a wider
bandwidth.

I looked into some of the drivers with oversampling and the supported devices
datasheets:

* ADS1298: Single field for sampling rate and oversampling,
           I assume the values are the maximum values that the
	   oversampling time does not exceed the sampling period.
* RTQ6056: Field for oversampling and conversion time,
           maximum sampling period is roughly n*t_ovr.
* MCP3561: Field for oversampling and conversion time.
           maximum sampling period is roughly n*t_ovr.
* AD7380:  Field for oversampling and fixed conversion time,
           3 MSPS for the AD7380 and 4 MSPS for AD7381,
           maximum sampling period is n*t_ovr, e.g. f_samp=(6/4MSPS).

None will or claim to stretch over the sampling period the oversampling
conversions, but rather, do the n-conversions at oversampling rate,
providing the conversion as soon as it is ready and idling until the
next edge of the sampling frequency.

> > >>
> > >>   Sampling trigger |       |       |       |       |
> > >>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
> > >>   ADC data ready         *       *       *       *       *
> > >>  
> > > In general this patch needs to go in with the first driver using it.
> > > I don't think we have any such driver yet?
> > >   

The AD4052 family that I will re-submit exposes this feature.
The AD7606c that David is working on can also expose.
I can add this patch to the AD4052 V2 series.

> > >> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > >> ---
> > >>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
> > >>  1 file changed, 17 insertions(+)
> > >>
> > >> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > >> index 33c09c4ac60a4feec82308461643134f5ba84b66..2317bacf6a2884691a08725d6f01d18555a96227 100644
> > >> --- a/Documentation/ABI/testing/sysfs-bus-iio
> > >> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > >> @@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
> > >>  Description:
> > >>  		Hardware dependent values supported by the oversampling filter.
> > >>  
> > >> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> > >> +KernelVersion:	6.15
> > >> +Contact:	linux-iio@vger.kernel.org
> > >> +Description:
> > >> +		Some devices have internal clocks for the ADC oversampling.  
> > > I wonder if we can hint at your diagram above?
> > > Maybe
> > > 		Some devices have internal clocks for the ADC oversampling allowing
> > > 		the over samples to be bunched up, rather than evenly spread over the
> > > 		period set by the sampling frequency.
> > >   
> > >> +		Sets the resulting sampling frequency to trigger a conversion
> > >> +		used by the oversampling filter.
> > >> +		Can be used to evenly space conversion between the sampling edge
> > >> +		on some devices.  
> > > I'd skip this last line, or maybe say something like:
> > > 
> > > 		If not provided, the default assumption is that the oversamples
> > > 		are evenly spread over the period of the sample.  
> > 
> > Does that mean we should go through existing drivers and add this new
> > attribute if appropriate? For example, ad7380 comes to mind. It has a
> > fixed-rate internal clock for oversampling, so would have a read-only
> > oversampling_frequency attribute.
> 
> Good point.
> 
> It is possibly a useful thing to do if that fixed rate clock is not
> jut the appropriate fraction of the sampling_frequency clock.
> 
> Requiring drivers conform provide a new ABI is a non starter though.
> 
> I guess rewrite the above suggestion to be more vague.
> 
> 		If not provided, either over samples are evenly spread over the
> 		period of the sample, or no information is available.
> 

I believe removing the paragraph is better, because the statement is false
most of the times. As investigated above, the norm is to bunch up the over
samples to the left (n*t_ovr).

My original paragraph was to nudge the user that he can adjust the
number of samples and conversion period to achieve evenly spaced,
but now I would rather not include this statement.

> Or just don't have anything for that last sentence on basis if no
> rules set there are no rules.

Agreed

> 
> Jonathan


> 
> > 
> > >   
> > >> +
> > >> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> > >> +KernelVersion:	6.15
> > >> +Contact:	linux-iio@vger.kernel.org
> > >> +Description:
> > >> +		Hardware dependent values supported by the oversampling
> > >> +		frequency.
> > >> +
> > >>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
> > >>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
> > >>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> > >>  
> > >   
> > 
> 

