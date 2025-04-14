Return-Path: <linux-iio+bounces-18091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF43A88785
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD483AB7D2
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5362749EA;
	Mon, 14 Apr 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROUdZb/A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956171A9B48;
	Mon, 14 Apr 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645061; cv=none; b=eaVv2Ll58/yvhaYjArbNGuB0yLtFY8DHJ6dqADcfonDq8IPwLzoGm/itm/ZGxTRRuzQ+5cJsklW5k5SkAZ6CCrjs//AihlgnWsfqyMFAyCWFzMP8Dw2ebUfC5nlDBgyGKyOgL0DBCeCDsdwdQNBFSqWCXlez4mxEk2tX22j8qD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645061; c=relaxed/simple;
	bh=9eA0G2YnsWGbHG56g49nbEXD6xFoAGUKbnrZB7bpMaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMsnB9wPlElG6hRi60uEYBBu/dAaI2Oc5svpsBrPm2KbN9ZGV+M4FyjAgSOb2/fqSOflJPxL+c/uRgzG2mabVCRpQVPKBdAoFZbbFLCYLf4fZVKFe2YPp6CQ8xS3jkHuiMQzDuwZqR/GCtNcHB8M/fFkeif3wnJPcZrjtnkFtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROUdZb/A; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso3506680a91.1;
        Mon, 14 Apr 2025 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645059; x=1745249859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mokm6ZH48h5sXQ5iAT2NSE+CCCr/3eOYDxIfr/1engI=;
        b=ROUdZb/A7gBJBzaGTOQa37RaWCxJSfLBTZ6YRoTom7zwiD0ddOafdsZtJ6Fe2QYGqB
         iutwSPIyC/EMF0avAQ9kaAPSx9mQ0yS0jWyyfox4Wpg2cSx/LbuI5+c5/0SNgfZwiZot
         hjcufoxftlg0C75kBlQZtAWgtJPQzh0ZfJo6+sMOcOIirxFcEMUbIh3Z5sUdAjjmQLiW
         vYuieKgANvTYe/goWkQy83o0GjnUXQGu6/PTphfrRVLhFiAfwuwN+qDVn5j3Jc1bsqTw
         rtCL8pfS9tlDAhjIgMWN/zhOxh2eJkmpnomP39IOap55Goh9vCZyOFajYeW17prW/g5k
         JPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645059; x=1745249859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mokm6ZH48h5sXQ5iAT2NSE+CCCr/3eOYDxIfr/1engI=;
        b=vNul2fgg1QetpxYF1tP8KPsZ/BIaRQ6jvMll6r118sfd8iOy59hlGgASI5GTad0zmC
         GaMVZ9fLViufsMch7wtof/hIQs9uSj3CDIF5/rdHfjNX0tFYS7h8yK3ioP8+0ni78bR8
         PkAW4wIFr9O5S2DwdoIq8sHRp/FvgcFUrg3oCtaqEWOL5C8tQ054N2hjPXQUM506eTR1
         BjUTvjsO17FEgLJMIGrccHvftdhZra2KYnzLmfPCMP5PODsVTdUPXkjEcYLXKTb97N1M
         H8fTDf5fK8fEFRLFmNINesK1Mf9WD5+8dW0u0gqp82QGf/pL7Uth7ELHDUvyzJkuu4ms
         IEXg==
X-Forwarded-Encrypted: i=1; AJvYcCUpi/071cVygeuVu60tbuwCLb8k7jEC2HwgTduXhiZuBZJmOYhDfokh9L0+WzzQZiVlM8RvqDh8z0Yd@vger.kernel.org, AJvYcCVFkLx5wKxixYXaA3IgRoBfqqE3hn7ENVGuiH/f+wSuVWhVAxXRGZwtDuCPTXOpC5jZuXGQUKH0EbVkTZr6@vger.kernel.org, AJvYcCVV7F+oOAlCniZXKHv632MffdXDt6bgzxSGjgr22rJGsJcehJee+e0pGrW5aKq9aDNC6algI6JMCOma@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10j0Ipn7Cul/2ZJqF0AZs8Q5Ox0lYrgAZyJRHFV9KBgsr9vQQ
	WUBHcy2HvDlAsOJlzHvQPuw7LaYC+p70DeJhQCKUAFNFZqtRb0H2
X-Gm-Gg: ASbGncu3BqpTfiXLYVghSOek0WmhR4gi50QASflI57wCdrvhQ3+N67n9BryIWjtn/qT
	npcpH3V6rRM2E3YI8BBMf2jUYFj4/h5LGHz3YWCd36Fb7MOxpt1ggFeVglRCdyuI+QgVio9Ao5Y
	VTrf/5r0Td2+DxZVRq7m6at0s68qWTUFfcjAt0L0iRYlVqQxi4NgtwIvum1eVjVC5dZJV2bn83p
	WLBYT/PPol0vOhl4rqRTnx319m9EUr7OmllKc0jGPW1x9fp5g3OScE51HAyLG+WNeGDzKy5Rihx
	bovYsNwFOI6vSCphIHPorUrHMy5Pd2HrA965K9Asx42PSuMCEosZFnFq77Q=
X-Google-Smtp-Source: AGHT+IGZsxgQ60vAJuvwxmwilDb8mJqLVo6mioN8QshkEcroQC5a2lPwjRGuXJKzKyRTL3DGpS4BOw==
X-Received: by 2002:a17:90b:2891:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-308237ce138mr14871891a91.30.1744645058550;
        Mon, 14 Apr 2025 08:37:38 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-306dd2fe1a4sm6679448a91.0.2025.04.14.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 08:37:37 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:38:46 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 7/7] iio: adc: ad4170: Add support for weigh scale and
 RTD sensors
Message-ID: <Z_0sBomGtMKXysgJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <56e76070b72d15950bf1fb01e68e94c42e79905b.1744200264.git.marcelo.schmitt@analog.com>
 <149672e84f09fb178c90856920e3cfd4f140529d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149672e84f09fb178c90856920e3cfd4f140529d.camel@gmail.com>

...
> > +static int ad4170_setup_rtd(struct ad4170_state *st,
> > +			    struct fwnode_handle *child,
> > +			    struct ad4170_setup *setup, u32 *exc_pins,
> > +			    int num_exc_pins, int exc_cur, bool ac_excited)
> > +{
> > +	int current_src, ret, i;
> > +
> > +	for (i = 0; i < num_exc_pins; i++) {
> > +		unsigned int pin = exc_pins[i];
> > +
> > +		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK,
> > pin);
> > +		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK,
> > exc_cur);
> > +
> > +		ret = regmap_write(st->regmap16, AD4170_CURRENT_SRC_REG(i),
> > +				   current_src);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (ac_excited)
> > +		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
> > +					  num_exc_pins == 2 ? 0x2 : 0x3);
> > +
> > +	return 0;
> > +}
> 
> In the above I do not see any explicit GPIO configuration which makes me wonder
> if having the RTD is mutual exclusive with having GPIOs?

For RTD sensors, it's recommended to use a different excitation mechanism which
is configured in CURRENT_SOURCE and MISCELLANEOUS registers. The current source
for RTD sensor excitation could come from a GPIO, but only implemented support
for outputting the current from an analog pin. Will handle the case of using
GPIOs in v2.

> 
> > +
> > +static int ad4170_setup_bridge(struct ad4170_state *st,
> > +			       struct fwnode_handle *child,
> > +			       struct ad4170_setup *setup, u32 *exc_pins,
> > +			       int num_exc_pins, int exc_cur, bool
> > ac_excited)
> > +{
> > +	int current_src, ret, i;
> > +
> > +	if (!ac_excited)
> > +		return 0;
> 
> Same as above, if !ac_excited, can't we use the GPIOs? because
> ad4170_validate_excitation_pins() just unconditionally sets
> AD4170_GPIO_AC_EXCITATION. Or maybe this DT property is only adding
> complexity... See below

I see, maybe AD4170_GPIO_EXCITATION would better describe the function. 

...
> > +
> > +			st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
> > +			st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
> > +			st->gpio_fn[1] |= AD4170_GPIO_OUTPUT;
> > +			st->gpio_fn[0] |= AD4170_GPIO_OUTPUT;
> 
> Not sure if you gain much with having the funcs OR'ed like this... If I'm not
> missing nothing it's only about logging in ad4170_validate_excitation_pins()?
> It's up to you but I would consider using bitmaps (unsigned long) for this and
> just test the bits.
> 
Ah, yes, a bitmap is what was trying to do but misimplemented it.
There are 4 possible functions for AD4170 GPIOs.
(1) Power-down switches (currently not supported);
(2) External sensor excitation;
(3) GPIO;
(4) CHANNEL_TO_GPIO (not eager to support that).

If a GPIO is used for external circuit excitation, we don't want to export it as
a GPIO. If the GPIO were set a power-down switch we would also not expose it.

...
> > +
> > +	ac_excited = fwnode_property_read_bool(child, "adi,ac-excited");
> > +
> > +	num_exc_pins = fwnode_property_count_u32(child, "adi,excitation-
> > pins");
> > +	if (num_exc_pins != 2 && num_exc_pins != 4)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Invalid number of excitation pins\n");
> 
> Can't we assume that a valid num_exc_pins property means ac_excited = true?
> Because that looks to be the logic in ad4170_validate_excitation_pins().

Unfortunately, no. The user may want and set AD4170 to DC excite the external
circuit. They may want to use the same set of excitation pins, but not enable
channel chop or output current chop (leading to DC excitation). Well, we may
choose to not support the DC case in the driver I guess, but since this is
already fairly complicated, why not going an step further to support it fully?

> 
> > +
> > +	ret = fwnode_property_read_u32_array(child, "adi,excitation-pins",
> > +					     exc_pins, num_exc_pins);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to read adi,excitation-pins\n");
> > +
...
> > @@ -2081,6 +2412,10 @@ static int ad4170_parse_firmware(struct iio_dev
> > *indio_dev)
> >  
> >  	/* Only create a GPIO chip if flagged for it */
> >  	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
> > +		for (i = 0; i < AD4170_NUM_GPIO_PINS; i++)
> > +			if (st->gpio_fn[i] != AD4170_GPIO_UNASIGNED)
> > +				return 0;
> 
> I think you could improve this... You're taking an all or nothing approach.
> IIUC, we can have cases where only two GPIOs are in use which means we could use
> the other 2? There the gpiochio init_valid_mask() call that you could
> potentially use.

Isn't gpiochio init_valid_mask() only to distinguish between GPIOs that can
(or cannot) be used as interrupts? Not sure AD4170 GPIOs can be used for
interrupts at all (think they can't) so didn't implement init_valid_mask().

Thanks,
Marcelo

