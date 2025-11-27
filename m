Return-Path: <linux-iio+bounces-26508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 338DBC8D738
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 10:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D56034E310C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85132693F;
	Thu, 27 Nov 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neAZqZMk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B6324B3E;
	Thu, 27 Nov 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234817; cv=none; b=gkbxkjsGBM1sSFhntIlnngpqZeV7qFizDar+Ib+IlvvNG6ptSkwykOf3fVLdFfCkD8S+WtCoA2mNii2W1Nx294rz1ecJSobyNjne0+FVr1L2KIWD+IIeJh+89ca5rUa0res0SJjrWpGNMtKN7gz2m1yLfla6vmiyuxY9L2z0dK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234817; c=relaxed/simple;
	bh=cKdL2H/gzkdREhzKX5xZ70302U29ENjlVJraDL5JMt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oieXtf3fxOFxbRUwIlANI5qpueq/Kc8LNqkvjLA2X4evreg6DrbzM249ppnv2zSUzHEYVC6NdCxXJblTLloBkg5D7uk6A9nppfkeWbdZXyGFvY3CdHk+J/9jDPmpzdU3Z5d28kz3W0XhjYXcLCS9MamGM7WpmGwPdBQWTxdQXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neAZqZMk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764234816; x=1795770816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cKdL2H/gzkdREhzKX5xZ70302U29ENjlVJraDL5JMt4=;
  b=neAZqZMkAcrVUafh9gR6+YsP4Y/HJXjYA6n5Vvma+a2xspENvCYk1NFz
   aOq2VYdiCZU2s5Ro/WHaMuWfelGVBzDB/YtzQQLrp924IF3YE5oSrmcjx
   HCAC7Zg5Vg/Z/ZStnwq6wzBYlBl14f745vjqwRBXmlM8nD3Fb70lknCL9
   ne4A/sOyAMLc6PhjYWQeCr00O7yir4gRQB9y2rSDQZGN6un4ZQ9s+IOak
   PQvMPUmKCdipbXTIVXBlf3LON5eH11U44+Lx/4aY0Cueqv8dnpg2nWSsg
   z2awPgnvqoKvcTZ0gFAF6z2dyOi/C/PxI1b/fW8o6cwjK1x6vqUhkEJOm
   A==;
X-CSE-ConnectionGUID: OzH5q0SaSX2ugLMWbDEbvA==
X-CSE-MsgGUID: li5iMOq0SmShEZ/anooELw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66239619"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66239619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:13:35 -0800
X-CSE-ConnectionGUID: q/HvfYtXQE2IY5h92kmCLg==
X-CSE-MsgGUID: TU5FtwY1S0KoSg4YtyvHPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="197668572"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:13:30 -0800
Date: Thu, 27 Nov 2025 11:13:28 +0200
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
Subject: Re: [PATCH v2 7/9] iio: adc: ad4062: Add IIO Events support
Message-ID: <aSgWOBJip9DK2SF6@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-7-a375609afbb7@analog.com>
 <aSQ0aM2u49qzIZDm@smile.fi.intel.com>
 <zzrtxpcxzqcjxhxmp5miov4f3kx5i3fpzmrt55azvktkgowejm@n6ofgzoaxoxb>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zzrtxpcxzqcjxhxmp5miov4f3kx5i3fpzmrt55azvktkgowejm@n6ofgzoaxoxb>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 04:00:36PM +0100, Jorge Marques wrote:
> On Mon, Nov 24, 2025 at 12:33:12PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 24, 2025 at 10:18:06AM +0100, Jorge Marques wrote:

...

> > > +static int __ad4062_write_event_info_value(struct ad4062_state *st,
> > > +					   enum iio_event_direction dir, int val)
> > > +{
> > > +	u8 reg;
> > > +
> > > +	if (val > 2047 || val < -2048)
> > > +		return -EINVAL;
> > 
> > There was already magic '11', perhaps define it and use there and here?
> > 
> > #define x11	11 // needs a good name
> > 
> > 	if (val > BIT(x11) || val < -BIT(x11))
> > 	
> Not magic number, but max and min signed 12-bit, maybe
> 
> 	if (val != sign_extend32(val, 11))

If you go this way, the 11 still needs a definition.

> 		return -EINVAL;
> to not look like magic numbers, or 
>   	if (val < (-BIT(11)) || val > BIT(11) - 1)
>   		return -EINVAL;
> For Hysteresis I will change from
> 
> 	if (val >= BIT(7))
> to 
> 	if (val & ~GENMASK(6,0))

Not sure about this. If it's a HW-based limit, the

	val > (BIT(x) - 1)

says that this is limited by x-bit size of the register (field).

So, I leave it to Jonathan (my personal preference here is BIT(x) - 1 approach).

> I believe iio only passes positive to the hysteresis, but is a little clearer.
> 
> > > +	if (dir == IIO_EV_DIR_RISING)
> > > +		reg = AD4062_REG_MAX_LIMIT;
> > > +	else
> > > +		reg = AD4062_REG_MIN_LIMIT;
> > > +	put_unaligned_be16(val, st->buf.bytes);
> > > +
> > > +	return regmap_bulk_write(st->regmap, reg, &st->buf.be16,
> > > +				 sizeof(st->buf.be16));
> > > +}

-- 
With Best Regards,
Andy Shevchenko



