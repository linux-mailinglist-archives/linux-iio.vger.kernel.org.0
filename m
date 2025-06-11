Return-Path: <linux-iio+bounces-20484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C00AD60A0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB01BC26DF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E22417C8;
	Wed, 11 Jun 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hojascee"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40919A;
	Wed, 11 Jun 2025 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675790; cv=none; b=omcPfXVEPBgtge+BLf9Gs/Pkb+eIbJWoIie5JgmuPJ6Y3eVvZOr25fQt7RkwyyxERSPxfbKzgDFv5J1J+aFvPo01swPsiT4S9o1qAApNar8WAGApje1oBo8SxMkESmGeWtPVy1yut8PEdndv6E3ltrljr670I+fAP3FJUmpg3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675790; c=relaxed/simple;
	bh=uhaxMZ7pEvrEqe0KuIX5jDb9dCyw5EALuBZfNdz+7aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeD27LIiMzlTRdqpsUn58mf6327ffes/q60TfQFKtEbVigLtwp7EM0uhQCiFE1nn/mXPUIML/qzr0c5LYhRr6pno1BlYA6VkPP+fgFNGPSc+vahq+1q3OHR1L+Y6tjv6WNtOfzLjLVfXzgaBps5myA/29j0l+tJmzDkavMwGnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hojascee; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742caef5896so352515b3a.3;
        Wed, 11 Jun 2025 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675788; x=1750280588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUQvYGXAJM9vFj/+RVHEyx0Hqdg+1ObhRxvVS6G9TV8=;
        b=hojascee9YJHkqUhFleUbJlOoi313xMWxXntZazRUw7xI0Wk21NiovQWUWdXDtb10V
         rTT3fPM7fthcJq4Vt+E9W7ErKIGIx4GM+0feNbWDaB4JjU64/Pi4pWje5KqQaE6kKsZX
         2j7RrBh9ZSvq1tk/0z2kIHN4tLnkkKmz9+Ctu/IWcNRgGS029ZupNpCaDGHZf1GGlcZU
         yKkQFQE/22NANbrX1FHZtMoMJCeyKtexf4xf49EhkOI6sXg2ZbFHF2iBLSaLnNgXnBlv
         l7pO6HFk2ryoFvc0wE4NUFVPBOGlEIyTtaa/8XlF7YDppZpp25m3gMgYT8Tmq9zQEeKZ
         kc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675788; x=1750280588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUQvYGXAJM9vFj/+RVHEyx0Hqdg+1ObhRxvVS6G9TV8=;
        b=IsF59amE5Hc30nMJEvjMsHP+7YECspneAM1T7RGwRNUutXl32D9EV+ZIW5uxxnW32O
         hXk2RyJ273JC6efKx2w4tkQSgp/qJKEyIf/q6f20xRryu3a8YYySdqTIOjs5TjYC+flX
         y1no8bsnIobV5xxa3j6Fmx6VrsiawTaVFf50KlSgoOBcVxU3BjDsms794roF0U+bn5ur
         GFcNk0sZ/18t0d0Up9rvJ1DUcAeboS77p0HTqpclHNXnHDbCyTnW8R098oMHLuCYbuAT
         Gd1+08FlcTTQ6MPGAZ/6z18iEs6tL49/nVbASN66DalqAQAt+azr3/Bsld6OrfpA2pOH
         +MGA==
X-Forwarded-Encrypted: i=1; AJvYcCUiVCu24aIXMWFVl9pWtoKf+eSdFKYQS5PKO+d5qYsNsGGbi+wD+6CTcviIQpDRRmiJ9EgQqxx2Mx0JgA==@vger.kernel.org, AJvYcCV+t+v8EGt1haZywHJFyHvFHFcHdU+n9RFWgEFQBWhwGH0UrZQnX9e6cVtkOzQNR8vnnP9wy6GDq3nu@vger.kernel.org, AJvYcCVYhQ0kk4KFRmQUtbHAugOquaJd+CvpsowVD/MnlguM7V6BbBsv16P23Oytp7KaoSNKRt8Gl5dsEBa0D/A8@vger.kernel.org, AJvYcCWJ0TTb1bZehm09S48NOiVo1N8guwItgni+vd+PEigiuswgWktuz2u/n6rpy2Bkp87nZEiZ8X6w1Irt@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYCA3R7wMSEroNXbVdn1Ut3SecVZ4HljiYCUxoCYhSjKbaQeO
	sTyIvWvRzqwnGByT1ULZ8v07QnrvtrGS/kafmILpBES3qX3eGVYX5zfH
X-Gm-Gg: ASbGncsruh4h2QOZMWp2zkaX+ejL2nolJH9+i+9a2h9b4LQiJehRMJjsKj8mVtdGAde
	0SRnkdA+/Dy8XtyrDaCZmvGf/uhhDViC5tdnYJHpAb1hQcmChdP5oJsLFBdIqnMDfYk0aLMlKbX
	obX/AhLcQgWFiCnKjqhvSErG4Nv9I+nuhahlkx2mfHzllSxxmid9qoEeteaAvOcT8lGDZ5rvw/F
	/jZCop4jRn4bVfnEBy8dA/30qDzy4bH0n4phfCVC7Nn02oon6flEZv0lI0MHx+pe829mUS5K4tC
	z/zQt06FeDqJtxQU48yvJC2NCC7RiZ8mfb1YDyYnPNluS79SDs3ioE/rGFdL0+dZQYtGOiw=
X-Google-Smtp-Source: AGHT+IHlK8nHYrKD/bCEgRio+M7EtJzGL+GvmhPnyqnoxAK7qV/Wtjitblya1OljGJE7+lGZIlIjGA==
X-Received: by 2002:aa7:8882:0:b0:73d:ff02:8d83 with SMTP id d2e1a72fcca58-7486cb21c08mr7368322b3a.3.1749675788093;
        Wed, 11 Jun 2025 14:03:08 -0700 (PDT)
Received: from localhost ([2804:30c:4000:5900:b4c4:6073:1a92:4077])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748808962b3sm6396b3a.61.2025.06.11.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:03:06 -0700 (PDT)
Date: Wed, 11 Jun 2025 18:04:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aEnvcaP2ZNPLhzXi@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
 <aEifWXPV1nsIyWbT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEifWXPV1nsIyWbT@smile.fi.intel.com>

On 06/11, Andy Shevchenko wrote:
> On Tue, Jun 10, 2025 at 05:31:25PM -0300, Marcelo Schmitt wrote:
> > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > 
> > The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> > analog to digital converter. The AD4170 design offers a flexible data
> > acquisition solution with crosspoint multiplexed analog inputs,
> > configurable ADC voltage reference inputs, ultra-low noise integrated PGA,
> > digital filtering, wide range of configurable output data rates, internal
> > oscillator and temperature sensor, four GPIOs, and integrated features for
> > interfacing with load cell weigh scales, RTD, and thermocouple sensors.
> > 
> > Add basic support for the AD4170 ADC with the following features:
> > - Single-shot read.
> > - Analog front end PGA configuration.
> > - Differential and pseudo-differential input configuration.
> 
> ...
> 
> > +	return spi_write(st->spi, st->tx_buf, size + 2);
> 
> ... + sizeof(reg) ?

The size of the specific ADC register is stored in the size variable.
The result of sizeof(reg) can be different on different machines and will
probably not be equal to the size of the register in the ADC chip.

> ...
> 
> > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > +{
> > +	/*
> > +	 * The use of static_assert() here is to make sure that, if
> > +	 * struct ad4170_setup is ever changed (e.g. a field is added to the
> > +	 * struct's declaration), the comparison below is adapted to keep
> > +	 * comparing each of struct ad4170_setup fields.
> > +	 */
> 
> Okay. But this also will trigger the case when the field just changes the type.
> So, it also brings false positives. I really think this is wrong place to put
> static_assert(). To me it looks like a solving rare problem, if any.

I think it is unlikely that struct ad4170_setup declaration will ever change.
The fields match the registers that are associated with a channel setup and
the their types match the size of the respective registers. So, I do agree
that triggering this assert would be something rare.

> 
> But I leave this to the IIO maintainers.
> 
> In my opinion static_assert() makes only sense when memcmp() is being used.
> Otherwise it has prons and cons.

I think the most relevant reason to have this static_assert would be to keep
some consistency with ad4130, ad7124, and ad7173, but no strong opinion about it.
Actually, I don't get why static_assert() would only matter if memcmp() was
being used. Would it be better to not bother if the fields change type?

Anyway, I'll go with whatever be IIO maintainer's preference.

> 
> > +	static_assert(sizeof(*a) ==
> > +		      sizeof(struct {
> > +				     u16 misc;
> > +				     u16 afe;
> > +				     u16 filter;
> > +				     u16 filter_fs;
> > +				     u32 offset;
> > +				     u32 gain;
> > +			     }));
> > +
> > +	if (a->misc != b->misc ||
> > +	    a->afe != b->afe ||
> > +	    a->filter != b->filter ||
> > +	    a->filter_fs != b->filter_fs ||
> > +	    a->offset != b->offset ||
> > +	    a->gain != b->gain)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> ...
> 
> > +	/*
> > +	 * Some configurations can lead to invalid setups.
> > +	 * For example, if AVSS = -2.5V, REF_SELECT set to REFOUT (REFOUT/AVSS),
> > +	 * and pseudo-diff channel configuration set, then the input range
> > +	 * should go from 0V to +VREF (single-ended - datasheet pg 10), but
> > +	 * REFOUT/AVSS range would be -2.5V to 0V.
> > +	 * Check the positive reference is higher than 0V for pseudo-diff
> > +	 * channels.
> > +	 */
> 
> Right, the Q is, can refp contain an error code here, rather than negative
> value? The code above hints that in some case it may, but are all those cases
> were caught up already? (Comment can be extended to explain this)

I don't think refp can contain an error code at this point. All regulators are
read at ad4170_regulator_setup(). After that setup,
st->vrefs_uv[AD4170_<SUPPLY>] will either contain the voltage read from the
regulator framework (which is >= 0) or -ENODEV. Then, we check the supply value
at the beginning of ad4170_get_input_range() (this function) and error out if
the value is -ENODEV. Will extend the comment to explain that.

> 
> > +	if (refp <= 0)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "REF+ <= GND for pseudo-diff chan %u\n",
> > +				     ch_reg);
> 
...
> 
> > +	/* Assume AVSS at GND (0V) if not provided */
> > +	st->vrefs_uv[AD4170_AVSS_SUP] = ret == -ENODEV ? 0 : -ret;
> 
> -ret ?!?!

That's because AVSS is never above system ground level (i.e. AVSS is either GND
or a negative voltage). But we currently don't have support for reading negative
voltages with the regulator framework. So, the current AD4170 support reads
a positive value from the regulator, then inverts signal to make it negative :)

> 
> Even if you know that *now* it can't have any other error code, it's quite
> fragile.

Yeah, I guess ADCs that can take bipolar power supplies are not that common.
I couldn't think of any better way to have that, though.


Thanks,
Marcelo

