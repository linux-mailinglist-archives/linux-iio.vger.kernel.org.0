Return-Path: <linux-iio+bounces-7459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B0092B1F7
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 10:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648D5280FC7
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386A152175;
	Tue,  9 Jul 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9VQouwJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615C1D556;
	Tue,  9 Jul 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513273; cv=none; b=jmy7LdjWInwdctVh8GXLe/yxjy3ie0FWKBb7kBniaAVKL9LNDMY4cOtaRdGrG9ceupB8hqeIx8YOZJVxsJaud5rJaijpHoPhsN/TDoFkAFwevEL6DRKy/nV02/OzdSDPN4eVT1JEfqHwpWKpd0Sfaw3vjJFFduMEBdpVcvG8AGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513273; c=relaxed/simple;
	bh=d2qIWg94Pgm0hhjuDcO+Aopiw+vdWMVSPCeQhYGUSBs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mp6QkecbbeHmoLwMGW3llM3FPBHCuZq4fYuJ2VCWq3dZEKWjU5fX2nVG1Z20xTEs5s8OxIRkzppolSPrRtsfCjxrY1h/jwNdH7YMpOlQfLM7uti0ntzlQAELUQtZ41ezdYJEQ1fGK4mEWZrTipVNW0LfVF9koIhevq+WXY9Yz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9VQouwJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42671a676c7so4781915e9.3;
        Tue, 09 Jul 2024 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513270; x=1721118070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Oyx6FrKL7238jfjI4xQrSfHoIpZUun53kvKziTOzlU=;
        b=Z9VQouwJrK4NQ9TludR0GoP1HdVKEL9ksLmGUDJl+NlDQEU+A29dLfqUlcimEGPgz1
         qOm7E6EYWEH6cuw/NsDRIHaX37oyZ2PdNwk47i0c5sK/tnRWAhQ2+9Q+gUoHpTqcXhqp
         0emw7MsXlp/L+Py2MObcPt9HMYfXzUsIZgFmSoRvkT2dJ2Ni0NnTxawUqwS+Ok4Z3vwG
         9jBrysYeHLh57iHVp+etbXH/hy74uM37TWq/YznRO/I6QhbEYEEoTUdcnti4SVwszlse
         qkYX+j/OzX7m6BiPKblTEW/KiAeFKU4mtol1+GHLp00hmlJWFm2HRSj8C+LrZSPnbT/e
         FeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513270; x=1721118070;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Oyx6FrKL7238jfjI4xQrSfHoIpZUun53kvKziTOzlU=;
        b=ocXyiUtr9IfxqH3NhhPt8iwDuiRudz611/OtmiypCqpQRCUKAoCz6xpO2P1NzI3dK8
         mnPKdfCPUF4qFXSpegmOvDNDKlE7CtH37HG0PS5MXaVw5kVOtKa0o1BoauEWtn+b0fnI
         aMue6/fOKljruki+EtS/P5G/q684GkewD1WA57uhrRZn72AtWyEf67S9IkTc+RTli/lv
         z2a7lokKRXfHXtDnKDInW95dbpz6xfecQoMiPc8jKUcTTm5XW2f1Klgm0kBJWSB9BIpY
         WcaWTn0mL1NjanN+n6JYzBSfs3/PZl6ZUlVZoXN4E0Ru2GosOHf7D1kw+LaTy1T8CHrD
         Zg+w==
X-Forwarded-Encrypted: i=1; AJvYcCUKuyOGnm3qWNkOj39i+G2oOY8jalk7kSUnC/enMX/+Z8jf87sYUBXqr442RIOKEAI79JJWe1r13PhPjoEQ7NrpwhshsoNOwOCuXWtyMT7oJReslh5avkqz5YYiP/Jn1MpzpFGYxO1YwiAuPO3k2kNm205Meh14zV220GIBUavRb+PEBw==
X-Gm-Message-State: AOJu0YzXEeiV3PlHN9xfj6ey3VvlNqlfJe/Lt88JBeZgZ1D9G3FBR2oO
	iQF9Sh+Sb0XJIZgTJoPCBs9iqox+xu22lHFqjVxPL6v+iwX50xjGWKTnje35
X-Google-Smtp-Source: AGHT+IEsdZTff0seLeEKmalSeHclTahjKFRJCT8BMEFjVHxoSZqlVJTz3vfZ+XNndSOkmnCEOeEEMA==
X-Received: by 2002:a7b:cb92:0:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-426706c62fbmr11566485e9.6.1720513269502;
        Tue, 09 Jul 2024 01:21:09 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0b6bsm29339845e9.3.2024.07.09.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:21:09 -0700 (PDT)
Date: Tue, 09 Jul 2024 10:21:07 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <668cf2f3ece62_1f6ba37012@njaxe.notmuch>
In-Reply-To: <20240708173439.000070b4@Huawei.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
 <20240707160442.6bab64c9@jic23-huawei>
 <668bec2a8b23a_6e037017@njaxe.notmuch>
 <20240708173439.000070b4@Huawei.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
...
> > I could add the shunt-resistor controls to allow calibration as Marius
> > suggested, but that's also a custom ABI, what are your thoughts on this?
> 
> This would actually be a generalization of existing device specific ABI
> that has been through review in the past.
> See Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> for example (similar in other places).
> So if you want to do this move that ABI up a level to cover multiple devices
> (removing the entries in specific files as you do so).
> 
I would do this in a separate commit, would you prefer it in this same patch
set or in another separate patch?

...
> > 
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/resolution_bits_available
> > > > +KernelVersion:	6.10
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		List all possible ADC measurement resolutions: "11 14"
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/integration_samples
> > > > +KernelVersion:	6.10
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Number of samples taken during a full integration period. Can be
> > > > +		set to any power of 2 value from 1 (default) to 2048.
> > > > +		This attribute affects the integration time: higher the number
> > > > +		of samples, longer the integration time. See Table 4-5 in device
> > > > +		datasheet for details.  
> > > 
> > > Sounds like oversampling_ratio which is standards ABI. So use that or explain
> > > why you can't here.  
> > 
> > I am not sure that this is an oversampling ratio but correct me if I am wrong:
> > generally by increasing the oversampling you would have additional samples in a
> > fixed time period, while in this case by increasing the number of samples you
> > would still have the same number of samples in a fixed time period, but you
> > would have a longer integration period. So maybe the comment is not very
> > clear since this parameter actually means "the number of samples required to
> > complete the integration period".
> 
> No. Oversampling is independent of the sampling period in general (though
> here the 'integration time' is very confusing terminology.  You may
> have to have sampling_frequency (if provided) updated to incorporate that
> the device can't deliver data as quickly.
> 
> > 
> > Initially I thought to let the user edit this by writing the integration_time
> > control (which is currently read-only), but since the integration period
> > depends also on the resolution and whether filters are enabled or not, it would
> > have introduced some confusion: what parameter is being changed upon
> > integretion_time write? Maybe after removing resolution and filter controls
> > there would be no such confusion anymore.
> 
> Hmm. The documentation seems to have an unusual definition of 'integration' time.
> That looks like 1/sampling_frequency.  In an oversampling device integration time
> is normally about a single sample, not the aggregate of sampling and read out
> etc.
> 
> I guess here the complexity is that integration time isn't about the time
> taken for a capacitor to charge, but more the time over which power is computed.
> But then the value is divided by number of samples so I'm even more confused.
> 
> If we just read 'integration time' as data acquisition time, it makes a lot
> more sense.
> 
I think I now get what you are suggesting, please correct me otherwise:

1. Let's consider the sampling frequency as how often the device provides
   computed ("integrated") measurements to the host, so this would be
   1/"integration period". This is not the internal ADC sampling rate.

2. I will expose sampling_frequency (RO), oversampling_ratio (R/W) and
   oversampling_ratio_available (RO) to the user, where oversampling_ratio
   corresponds to what the datasheet refers to as the "number of ADC samples to
   complete an integration".

3. When the user writes the oversampling_ratio, the sampling_frequency gets
   updated accordingly.

4. With two real examples:
    4.1. The user writes 16 to oversampling_ratio, then reads 43.478 from
      sampling_frequency: with 16 samples the "integration period" is 23ms
      (from Table 4-5) so 1/0.023 => 43.478 Hz
    4.2. The user writes 2048 to oversampling_ratio, then reads 0.34 from
      sampling_frequency: with 2048 samples the "integration period" is 2941ms
      (from Table 4-5) so 1/2.941 => 0.34 Hz

5. Do not expose the integration_time control to avoid confusion: the so called
   "integration period" can be derived from the sampling frequency as
   1/sampling_frequency.

...
> > > > +static int pac1921_update_cfg_reg(struct pac1921_priv *priv, unsigned int reg,
> > > > +				  unsigned int mask, unsigned int val)
> > > > +{
> > > > +	/* Enter READ state before configuration */
> > > > +	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > > > +				     PAC1921_INT_CFG_INTEN, 0);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Update configuration value */
> > > > +	ret = regmap_update_bits(priv->regmap, reg, mask, val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Re-enable integration and reset start time */
> > > > +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > > > +				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	priv->integr_start_time = jiffies;  
> > > 
> > > Add a comment for why this value.
> > >  
> > Could you elaborate what's confusing here? The comment above states "reset
> > start time", maybe I should move it above the assignment of
> > priv->integr_start_time? Or it's the use of jiffies that it's confusing?
> 
> Why is it jiffies?   Why not jiffies * 42?
> I'm looking for a datasheet reference for why the particular value is used.
> 
I used jiffies just to track the elapsed time between readings. Something I am
not considering here? Of course jiffies granularity might be larger than the
minimum sampling frequency. Is there a common better approach?

...
> For future reference, no need to acknowledge stuff you agree
> with.  Much better to crop to the places where there are questions or responses
> as it saves time for the next step of the discussion!
Ok....oops!

> 
> Thanks,
> 
> Jonathan
> 

Thanks,
Matteo

