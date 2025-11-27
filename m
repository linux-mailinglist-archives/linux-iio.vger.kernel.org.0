Return-Path: <linux-iio+bounces-26509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE13C8D7F2
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 10:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C834AFC6
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1ED327214;
	Thu, 27 Nov 2025 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L55cH3Ew"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432271CEAA3;
	Thu, 27 Nov 2025 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235262; cv=none; b=Iyyk4jrNUFiROqCeQ1nug9oxETZfjI0m0v4xHDbGS/GZtetDtR+c6TaWY5ZeoLqp6jIiyQ8bvmsAzyuLHfwfAek0SJyI5mebVx2TyrseKmo8eU0m8aaub81y6nEjFxbIUPId4NoFrjAiT5Rjtx41x442w6tnRtsUq2M6hr1tR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235262; c=relaxed/simple;
	bh=sQVDTm7V9eoCg2eR6hxPIlog0wcTppn1isSj+AvHDYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTJw8To/QcYl8M51BTb2SpucJroxcMKBwSghZaTKZkBxJgxGZgd3keho3Wqd2y9FtRiL4VdJM+FIHYBxIq8CRCwNBVN2zlphqDbltx5ICHXltAoLefKVmZmn1HIjuhr54YQZM0ZfJKqn5bhHiX/xIQrLG0CsW+zsYKocWrAhGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L55cH3Ew; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764235262; x=1795771262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sQVDTm7V9eoCg2eR6hxPIlog0wcTppn1isSj+AvHDYU=;
  b=L55cH3Ew6mmTw82NuPk8z8ZPPj5A7qDfMdORcILaJHdan6MpGa3pAgDZ
   ymyQUbHW4hEngWXwSXuhUUEOgFvY0Qhcllucq16eKl9W5LZQekya/zYOv
   g6A3cmGEg3ZauzmyCGnHelUatHWKEr1pROl7gkKf8WheydAd1t49dr06g
   d04STfhZoCiwC8W6K4dkrWJ1k8G/JCPF/jz9eDIXLX4+e78lIsZJYPNyZ
   lORY/CppXK+YPwoBizze/Ige0aPhrqa1Cx1Yz7qYfwijPf7C1QkcneROw
   N+aNdmsBF/4QbymKbbcpCufguOq9VOtpw/Qfitw+Nw/CWPbj/GEh4GfKj
   Q==;
X-CSE-ConnectionGUID: OJOQcjtET0+I90xQsYRhSA==
X-CSE-MsgGUID: Hw4OFjjUTcGdMDakm30Pbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66441046"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66441046"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:21:01 -0800
X-CSE-ConnectionGUID: d2/cnP5tQfihZkSkbK4qXA==
X-CSE-MsgGUID: fPDm1rD4RMqoJx7Mj2TmzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="216538289"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:20:56 -0800
Date: Thu, 27 Nov 2025 11:20:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 9/9] iio: adc: ad4062: Add GPIO Controller support
Message-ID: <aSgX9nMBwBtAlSyj@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
 <aSQ2JUN05vmMQC1I@smile.fi.intel.com>
 <rk4hmupbrb5ugxft6upj7ru43x3z7ybrobax45rorpwbcwleh6@vzxrr3m7r6ep>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rk4hmupbrb5ugxft6upj7ru43x3z7ybrobax45rorpwbcwleh6@vzxrr3m7r6ep>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 04:55:41PM +0100, Jorge Marques wrote:
> On Mon, Nov 24, 2025 at 12:40:37PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 24, 2025 at 10:18:08AM +0100, Jorge Marques wrote:

...

> > Why can't gpio-regmap be used?
> > 
> Because the device register values (0x5, 0x6) does not fit the gpio-regmap.
> It writes the mask for high and 0 for low.
> But low is 01[01] and
>     high   01[10]
> 
> A different series would need to extend the gpio-regmap ops, but if you
> implement your custom reg read/write, then you save at most ~5 lines...
> I will add that to the commit message.

OK.

...

> > > +	return reg_val == AD4062_GP_STATIC_HIGH ? 1 : 0;
> > 
> > 	return !!(reg_val == AD4062_GP_STATIC_HIGH);
> > 
> > also will work.
> >
>  	return reg_val == AD4062_GP_STATIC_HIGH;

Hmm... This will include implicit bool->int. The !! guarantees values 0 or 1,
but I don't remember about implicit bool->int case.

...

> > > +static int ad4062_gpio_init_valid_mask(struct gpio_chip *gc,
> > > +				       unsigned long *valid_mask,
> > > +				       unsigned int ngpios)
> > > +{
> > > +	struct ad4062_state *st = gpiochip_get_data(gc);
> > > +
> > > +	bitmap_zero(valid_mask, ngpios);
> > > +
> > > +	if (!st->gpo_irq[0])
> > > +		set_bit(0, valid_mask);
> > > +	if (!st->gpo_irq[1])
> > > +		set_bit(1, valid_mask);
> > 
> > Why atomic bit set:s?
> > 
> Not needed, will use

Note, bitops are xxx_bit() -- atomic, __xxx_bit() -- non-atomic,
that's what I had in mind.

> 	if (!st->gpo_irq[0])
> 		*valid_mask |= BIT(0);
> 	if (!st->gpo_irq[1])
> 		*valid_mask |= BIT(1);

Can't it be rather something like

	for (unsigned int i = 0; i < ...; i++)
		__assign_bit(i, valid_mask, st->gpo_irq[i]);

?
This shorter and does the same independently on the length of the bitmask
(and effectively the array size of gpo_irq)

> > > +	return 0;
> > > +}

-- 
With Best Regards,
Andy Shevchenko



