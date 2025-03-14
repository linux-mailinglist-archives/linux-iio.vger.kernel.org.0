Return-Path: <linux-iio+bounces-16839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716DA613AC
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 15:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7EC171748
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B76E1FF5FB;
	Fri, 14 Mar 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNekU5Gp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA51FBC94;
	Fri, 14 Mar 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962803; cv=none; b=OfX43w3TTdO1pXBfmrMUsKK9j5kVBJ9DuBX08rJuiSeZequu9EbDAyMTm4PJrauwMcb1e7oQCXqgY2TzHMuSaH17bAGFMiUTSFPhK1UhNru/gkx/UMeelnFpVo3XeoVpvyWWbvovQoMcu+qukoBYQhCLQhW+IGvF4aB51DROV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962803; c=relaxed/simple;
	bh=2l2M+Ak4AlHIp5/GSw9fFLag+cjooSbg7obGOnvCbSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpzZK1xOvBs6wRFKSc0w71UBD+vzRxmVylZECAzhQd2ia28D5p5p0+k8qNwtZaIM21iA9kqmkScp4DIM2nPxAHAhI/qtWNgH4Zj1XtKUgZpOjflXsGK7TPb/99Cwc5cZDjCsWKpVWJh8UY18JVesm97dk30sga3nNddiAWdE1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNekU5Gp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741962802; x=1773498802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2l2M+Ak4AlHIp5/GSw9fFLag+cjooSbg7obGOnvCbSw=;
  b=SNekU5GpZvLtxyNuCBg6OnQW1OAIHdV1HrAzNlJ/FwZRDbZYrLcrLGYZ
   bAUHbyoWEGEvv/5aX5GEtzbbIMPMZDvrPMfxdFVD9+1LDRf9RJIZLgZUk
   REo8MLxQxTNNg4lfz4n8/gUcPKWYrhcWTXis6TWEl0EO9OST0sG7q5lzL
   A31HnhFl8Z/D780zXj2iCeIj1gyFZpWxSfpC01sO3AOcQcimE2hnyT0rY
   OaUoyvc5p30KvgkbSuF8y8YgbkfA+sP+mnGbUcMJPAPlHNP2PvIKsDmsU
   QbLy5aN66z9d2OSuLJ+R3SiWZv9e1izEqAB0GWwSUXMMgME3B8hhcHVl6
   Q==;
X-CSE-ConnectionGUID: 1/CcTZjyQoiiF56oT1HB4A==
X-CSE-MsgGUID: Q66CSkMJTQWCl/lou6LyIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="60514134"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60514134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:33:21 -0700
X-CSE-ConnectionGUID: xos2mf6kQQ6CDfJYe8pDaw==
X-CSE-MsgGUID: rLYeVOueQGu4ZNuK6jIhbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126346282"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:33:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tt665-00000002U7G-3ymC;
	Fri, 14 Mar 2025 16:33:13 +0200
Date: Fri, 14 Mar 2025 16:33:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z9Q-KcadLHdDLxVc@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
 <bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 14, 2025 at 09:31:58AM +0200, Matti Vaittinen wrote:
> On 13/03/2025 15:19, Andy Shevchenko wrote:
> > On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:

...

> > > +#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
> > > +#define BD79124_LOW_LIMIT_MIN 0
> > > +#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)
> > 
> > These masks are not named after registers (or I don't see it clearly),
> 
> Naming is hard. I usually try to make a balance between:
> 
> 1) using names which explain the purpose when seen in the code (at call
> site)
> 2) keeping names short enough
> 3) following the naming convention in the data sheet
> 4) maintain relation to the register.
> 
> I put most emphasis to the 1, while 2 is important to me as well. 3 is
> _very_ nice to have, but it is often somehow contradicting with 1 and 2. 4
> is IMO just nice to have. The register is usually clearly visible at call
> site, and if someone adds new functionality (or checks the correctness of
> the masks/registers), then 3 is way more important.
> 
> I am open to any concrete suggestions though.

From my point of view the starting point is 3, then one may apply 2 and 4,
the 1 may mangle the name so much that register data field name becomes quite
abstract.

> > it's
> > hard to understand which one relates to which register. Also, why not using
> > bitfield.h?
> 
> I saw no need for it?

Hmm... Okay, I think Jonathan will ask that if really needed.

...

> > > + * These macros return the address of the 1.st reg for the given channel
> > 
> > first
> 
> Huh?

Replace "1.st" (which seems not a standard representation of it) by "first".

> > (and missing period at the end).
> 
> Ok.

...

> > > +#define BD79124_GET_HIGH_LIMIT_REG(ch) (BD79124_REG_HYSTERESIS_CH0 + (ch) * 4)
> > > +#define BD79124_GET_LOW_LIMIT_REG(ch) (BD79124_REG_EVENTCOUNT_CH0 + (ch) * 4)
> > > +#define BD79124_GET_LIMIT_REG(ch, dir) ((dir) == IIO_EV_DIR_RISING ?		\
> > > +		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))
> > > +#define BD79124_GET_RECENT_RES_REG(ch) (BD79124_REG_RECENT_CH0_LSB + (ch) * 2)
> > 
> > Don't we want to have something in bitfield.h for arrays in the register, i.e.
> > when register(s) is(are) split to 2+ bits per an element in an array of the
> > same semantics. Would be nice to eliminate such a boilerplate here and in many
> > other drivers.
> 
> Not necessarily a bad idea. Still, I am not willing to expand this series
> any more - currently there is 10 patches, 2 of which are directly related to
> the BD79124. I don't want to delay this driver for another cycle due to
> added helpers.

It was just a side note. Consider as a poll for opinions.

...

> > > +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
> > 
> > You should use .set_rv()

...

> > > +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> > > +				    unsigned long *bits)
> > 
> > Ditto, .set_multiple_rv().
> 
> As you know, this started at v6.14 cycle which is still ongoing. I don't
> think .set_rv() and .set_multiple_rv() are available?

You mean that you are still hope to have this series to be squeezed for
v6.15-rc1? That's not me who decides, but if not, those APIs will be part of
the v6.15-rc1 (at least they are pending in GPIO subsystem).

...

> > > +struct bd79124_raw {
> > > +	u8 bit0_3; /* Is set in high bits of the byte */
> > > +	u8 bit4_11;
> > > +};
> > > +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
> > 
> > And how this is different from treating it as __le16? Needs a good comment
> > about bit layout.
> 
> You don't think:
> >> +struct bd79124_raw {
> >> +	u8 bit0_3; /* Is set in high bits of the byte */
> >> +	u8 bit4_11;
> >> +};
> suffices? It's hard for me to think how to explain bit layout more
> explicitly.

I do not think it suffices. It's hard to decode what you meant by the naming
and the comment. Actually it even confuses me.

> This was discussed during the RFC review. I explained the rationale why I
> rather represent this as two 8 bit variables than le16 with (mysterious to
> me) shift. As a result, Jonathan told me he's not feeling (too) strong about
> this (but also warned we may see follow-up patches converting this to le and
> shift - which, by the way, is harder for me to understand).

If you want to leave them, the good comment needs to be added for both
1) explaining bit layouts;
2) why __le16 is not being used.

...

> > > +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
> > > +				    unsigned int val)
> > > +{
> > > +	struct bd79124_raw raw;
> > > +	int ret, tmp;
> > 
> > > +	raw.bit4_11 = (u8)(val >> 4);
> > > +	raw.bit0_3 = (u8)(val << 4);
> > 
> > Why casting?
> 
> To make it clear storing unsigned int to u8 is considered to be Ok. I can
> drop it though if you feel strong about it.

In C (not C++) explicit casting is a point to stumble over and check if there
is any problems or call for asking the question "Whu?!"

...

> > > +	ret = regmap_read(data->map, reg, &tmp);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	raw.bit0_3 |= (0xf & tmp);
> > 
> > GENMASK() ?
> 
> For me 0xf is both shorter and clearer. (For me 0xf - or, 0x0f if you like,
> 0xf0 and 0xff are clear by a glance).
> 
> I can go for GENMASK() if it is absolutely required, but for me it is in
> this case just making this harder to read. I like GENMASK() for something
> like 0xe or 0x60 though.

It makes code inconsistent and one letter is not so visible. Ideally it should
be a definition with self-explanatory name.

> > > +	return regmap_bulk_write(data->map, reg, &raw, sizeof(raw));
> > > +}

...

> > > +	case IIO_EV_INFO_HYSTERESIS:
> > > +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
> > > +		val >>= 3;
> > 
> > Second time I see this. Perhaps you need a macro to explain this right shift?
> 
> Not really sure about this. I think it's kind of obvious why this is shifted
> - and in case it's not, there is a comment explaining it.
> 
> I could have a macro like REGVAL2HYSTERESIS() - but I don't think it is a
> great idea, because then anyone interested in understanding the value read
> from register would need to dig out the macro to find how value needs to be
> converted. Doing the shift here shows the register format to a reader right
> away - and honestly, it should be pretty obvious to the reader that this
> shift converts register value to proper format.

These shifts are not a big issue, so whatever you choose / chose.

> > > +		return regmap_update_bits(data->map, reg, BD79124_MASK_HYSTERESIS,
> > > +					  val);
> > 
> > Can be one line.
> 
> I still prefer to have lines < 80 to make them fit my terminal.
> I think we have discussed this before. I don't think we will agree on this
> as I have a very real reason for short lines. It does directly impact on my
> daily work. I don't think you're going to like it no matter how I explain
> this.

IIRC this takes 82 characters.

Yes, we discussed and I see no issues to avoid uglifying / adding unnecessary
lines to the code. We can continue arguing, but this what I think and I don't
know what argument may change my opinion. Apparently this is on maintainer's
field now to decide.

-- 
With Best Regards,
Andy Shevchenko



