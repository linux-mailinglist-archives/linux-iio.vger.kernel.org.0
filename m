Return-Path: <linux-iio+bounces-26775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DEACA5853
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 22:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01EB030AFFC9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631373271F5;
	Thu,  4 Dec 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwRTeMzq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE02F513
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764884264; cv=none; b=d2s5UquqE4U5yARYv8BL4HmdN3c/nJRTRGN2yOL51yAqTwJ1ONz2hGUTCczLAKQkHBXozLTpcBSIEBLz5KyN4jY0C1Uehagi0m1fa7qvSTCFHQXBr/MYuPvpglvPcNXoysKU773s7zpLPKS5ZLrG/nNgVJDNa8RHf5NLr2extRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764884264; c=relaxed/simple;
	bh=lYNQiNuadEYXpG72dttBVTjdVbn+hP/2DA42npo14Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVvs8eKS7sj318IQHM6WgrYki6YyOEllvaU/8eTaaMzOQZWqvs9E7KySYIQu3hyffkJRshIBycFLppxe+WaxnaIFxiET5hIn0mUnBbOJJDhKXEJ+IJbs97z4qO9cLX782c5QtFHx8E62zCpd/rFTUk10rtpyX36ey74+h6Owngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwRTeMzq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47774d3536dso13795665e9.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764884260; x=1765489060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faohLWgI8UwyqQwv1dWb6IoMX/UJWOFG3EcvY/0BmD8=;
        b=VwRTeMzqF5Jf8HBX4Yo6aIWmU8QpEc6zHgB4Q3E9yVYfNDa5JOs5FHunUD0OwlXkaM
         K9rDpDIHiNN5b+WXDNte1tnvrghD7pv2qnbZ0Zpy1KdOyt3cXSyJm0y+zu5fNNn2P96Y
         MQbZvHdTAfGtH3f3OC0W6r4NeSaJBR6Jqpeawyca277E2xlhtPq6MYfbz3wEwUmykBv9
         b3q6R98xfyGRi92jGt5XgyVCLtMs/8V2gZw5/BfraHcR4AF1NAqZITwIIdxf5qHC1dQu
         RalAtAZ4bTXUZyZ4DUgxhbFm6EPr7pTrQXXR6OZTQW41sHHrcomEhvxd1bhHeHEdptVm
         jZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764884260; x=1765489060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faohLWgI8UwyqQwv1dWb6IoMX/UJWOFG3EcvY/0BmD8=;
        b=Y9Xl/v+PUWBVfXFSIA2vD9JV3CuOPzZxn4Zn7BwWkiUXFcHcSSoVjmnsLbzps44FKe
         2qSS9hKsmag7mrUrGfSPLlIwHczYItKtIM13M5bY1L9Qc5wrv16Xe5WLiakeCpFt9Izj
         mE2zGtnN0P5R45yk/atu2RjuAWgG89NQluu1mJ7Ztl7Bs9bHO5wQ1GUJ/s7fDOMWwk67
         uCHTDuTxqEXBbC10QTOIIbtmy2NN7t0QwWs3EQCy7heLWZfZ2Iozqq0x57tvZxaoA9JV
         Xt2VTau7gowSwN9Xl3wIf11PAHvmUTPibRv5R7Cz47I1Ti680RLHMXqPQcbCjv++oQiZ
         mV6A==
X-Forwarded-Encrypted: i=1; AJvYcCUR2IipWvv3pPz36RIcMk3Q7Mp6LKOKsgGbaQA0JAmiZcRYaMIITUCheQeHz4TiWwBn17M1XGmfmVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgHct2nKJ0OGnAopdoRHAB3yrSUPCjKo1op73HDMapQz3Aym/
	vUTCdAWGBEDZGp19PCT2/MlDyeJi/KRuGvzrHf6IxiCmyjHC8pxtedGD
X-Gm-Gg: ASbGncuWEtkkbWzr+VfflVSUrTp/1JefSFc210dDg2U/kgdqAEZpy99y0ju9myI7c7n
	49Y2Sc9dyBGIVk3Ofz3bFDpj3vaEsjGhEz0AoqU44WDsO5KGpZ80/ss4g/qTrW++2OgKirbOkuN
	1DK96/HQs1nqAjfSz3ypKCMHg6wUi0munWhmQsGmDFdvC0qv/0lQG7LxytgrHYQvvAcTpkTMELX
	2rfdou01+IufkudcUAXcy9igngUuXPR8LA5I0yZe80sIxjJ1RfzonfIxVlW1oY90wl1saSFEnJQ
	zgvJpIxOhstTKsdb/E2JMBYqmSdkkUs2L4eiN95jd4KDpxfTkf2UOJH5U4ywvdbbb6SeogxzkxR
	0jK7JF36jusAXDt3PQE1Z7HzCEa0kLspx3EaH5xKO21iptYJSzRZniLw9pa3j02tsmizwpFdqxV
	DfYToDOyC+i5M29wjklPIWNhAFuhLVE3XbqAjTbII9l6Rvkwjg5XzIGmr1IhZOeUb+lqI=
X-Google-Smtp-Source: AGHT+IEkN4TPxcT2yhSxBgmIGuCvkZq6whVfpfvXJxHLVTgmdSpVE9imgTzvn+3e+lYgcpRI7M9hyg==
X-Received: by 2002:a05:600c:3151:b0:479:255f:8805 with SMTP id 5b1f17b1804b1-4792eb10e97mr50091355e9.4.1764884260202;
        Thu, 04 Dec 2025 13:37:40 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:9c51:c3b7:65d6:48d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310a6db3sm52802675e9.1.2025.12.04.13.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:37:39 -0800 (PST)
Date: Thu, 4 Dec 2025 22:37:38 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/9] iio: adc: Add support for ad4062
Message-ID: <fue274bpfgsytm5z25rdsawbfa2s4vu4ypoqrrmrx5dfe2jgdq@ocjqribzo5mn>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-3-a375609afbb7@analog.com>
 <aSQxiSoZcI_ol3S5@smile.fi.intel.com>
 <aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
 <aSgSsGSUuBtMOuro@smile.fi.intel.com>
 <zryqws2h2i4duejczo2rptwhlzhile7fa7brriqh2hmtarwjxn@cr2cyzymwpav>
 <aSn3PthKIvFAhDS6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSn3PthKIvFAhDS6@smile.fi.intel.com>

On Fri, Nov 28, 2025 at 09:25:50PM +0200, Andy Shevchenko wrote:
Hi Andy,

> On Fri, Nov 28, 2025 at 07:50:02PM +0100, Jorge Marques wrote:
> > On Thu, Nov 27, 2025 at 10:58:24AM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 26, 2025 at 12:40:00PM +0100, Jorge Marques wrote:
> > > > On Mon, Nov 24, 2025 at 12:20:57PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Nov 24, 2025 at 10:18:02AM +0100, Jorge Marques wrote:
> 
> >   static int ad4062_calc_sampling_frequency(int fosc, unsigned int oversamp_ratio)
> 
> Shouldn't fosc be unsigned?
> 
Yep
> >   {
> >   	/* See datasheet page 31 */
> 
> It's fine, but better to add a formula here or more information about
> the calculations done in the function.
> 
> >   	u32 period = NSEC_PER_SEC / fosc;
> 
> period_ns ?
> 
> (We usually add units to this kind of variables for better understanding
>  of the calculations)
> 
Ack.
> > > >   static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
> > > >   				      int gain_frac)
> > > >   {
> > > >   ...
> > > >   
> > > >   	if (gain > 1999970)
> > > 
> > > But this magic should be changed to what you explained to me
> > > (as in 0xffff/0x8000 with the proper precision, and this
> > >  can be done in 32-bit space).
> > > 
> > > Or even better
> > > 
> > > 	if (gain_int < 0 || gain_int > 1)
> > > 		return -EINVAL;
> > > 
> > > 	if (gain_int == 1 && gain_frac > 0x7fff) // did I get this right?
> > > 		return -EINVAL;
> 
> > gain_frac would be 999999 max, or 999970 for the limit that fits in the
> > register after the math. I think > 1.999.970 is self explanatory.
> 
> On the place of unprepared reader this is a complete magic number without
> scale, without understanding where it came from, etc.
> 
> So, can you define it as a derivative from the other constants and with
> a comment perhaps?
> 
(my proposal is after all your comments below)
> > > >   		return -EINVAL;
> > > >   
> > > >   	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL((u64)gain * AD4062_MON_VAL_MIDDLE_POINT,
> > > >   						 MICRO),
> > > 
> > > ...with temporary variable at minimum.
> > > 
> > > But again, I still don't see the need for 64-bit space.
> > 
> > Well, by dividing mon_val and micro values by a common divisor the
> > operation fit in 32-bits:
> > 
> >   static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
> >                                         int gain_frac)
> >   {
> 
> 	/* Divide numerator and denumerator by known great common divider */
> 
> >           const u32 mon_val = AD4062_MON_VAL_MIDDLE_POINT / 64;
> >           const u32 micro = MICRO / 64;
> 
> Yep, I suggested the same in another patch under review (not yours) for
> the similar cases where we definitely may easily avoid overflow.
> 
> Alternatively you can use gcd().
> 
> >           put_unaligned_be16(DIV_ROUND_CLOSEST(gain * mon_val, micro), st->buf.bytes);
> 
> Btw, I think you can move this check up and save in a temporary variable which
> might affect the binary size of the compiled object as accesses to the gain_int
> and gain_frac will be grouped in the same place with potential of the reusing
> the CPU register(s)..
> 
> >   }
> 
I believe this is clear and fits all points:

 	/* Divide numerator and denumerator by known great common divider */
	const u32 mon_val = AD4062_MON_VAL_MIDDLE_POINT / 64;
	const u32 micro = MICRO / 64;
	const u32 gain_fp = gain_int * MICRO + gain_frac;
	const u32 reg_val = DIV_ROUND_CLOSEST(gain_fp * mon_val, micro);
	int ret;

	/* Checks if the gain is in range and the value fits the field */
	if (gain_int < 0 || gain_int > 1 || reg_val > BIT(16) - 1)
		return -EINVAL;

	put_unaligned_be16(reg_val, st->buf.bytes);

Explains 64 value. Checks if is in range [0, 2), then if fits the
register field for corner case of range (1.999970, 2) (0x10000). Full
formula is in the previous method ad4062_get_chan_calibscale.


> > > >   			   st->buf.bytes);
> > > >   
> > > >   	ret = regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
> > > >   				&st->buf.be16, sizeof(st->buf.be16));
> > > >   	if (ret)
> > > >   		return ret;
> > > >   
> > > >   	/* Enable scale if gain is not equal to one */
> > > >   	return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
> > > >   				  AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> > > >   				  FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> > > >   					     !(gain_int == 1 && gain_frac == 0)));
> > > >   }
> > > > 
> > > > To provide the enough resolution to compute every step (e.g., 0xFFFF and
> > > > 0xFFFE) with the arbitrary user input.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
Best Regards,
Jorge



