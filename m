Return-Path: <linux-iio+bounces-26507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EDC8D6B9
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 09:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5090D34EA19
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7488325704;
	Thu, 27 Nov 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqKhSlh0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749323233F4;
	Thu, 27 Nov 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233914; cv=none; b=KKbWqdI9+7CqudPZ7cgaJ8J47g0xuF7e/PRtj8vMhGlDOQXwcAt1cRneNfDmqC2Qe/nxztavP/mkpWi9zZYoJYHgzd9OC2Kr8pdzMIfmnwOTcNJF8w9BCAqvtA8M2axgfGC/SVQ/q5pcRMp4e00cQrYHsT0F4qajxt6ExPQnvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233914; c=relaxed/simple;
	bh=vwXSsq/ZnzV2AnxGukvGYUkfZ29XaLCdlMJicbSxQyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7e0zD6Y59nvpmr/VScfmNMZCZ9xc73ihZUykfqrcPfalnOS6bD2Jc0zhTq+PEH+6TTiFlbvgLJawVbImZdXfb94qaOQfL4jxVcYeADTZqtpdkhYlrTeA6WlwnaG/jvC9KGy73o/ZrUSbsH/QHouR5kTl5UwdTfsxMPs8+LErAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqKhSlh0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764233912; x=1795769912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vwXSsq/ZnzV2AnxGukvGYUkfZ29XaLCdlMJicbSxQyo=;
  b=gqKhSlh0agGXkU+hqzY/4FSEhQ+RL3IOj9fl1tzjFKwt+Uc0/p05H3A7
   igaafgKSRcsPbd0ASiRI2pYH0GPHMzIzydQ5e0mO111j3sWblXL6YCXpU
   Pq44WyLO12ZY9qTu0SZhzOXjgM4BpflFonJ9YiBsvrMnvfdjl21c5GeuM
   HamUGlvOJknjXKBdX305C33BXNJJs/eyb5VjdUp8+0P/DpQBzm9V4ENCo
   kDKnnDGDrtPqTL9e2Y88Mph2bHteW7WYmLwn2xtDfOoOfoq1uHFw+5MVO
   yrzJSF+YGSvgzPQBKdAdEH96A3qUT1tAKRRVZ+PIzo/YHDwma8YhOnu9L
   A==;
X-CSE-ConnectionGUID: mRyFjviqQmyASsti1Z9eKw==
X-CSE-MsgGUID: zg5zHR55RYe4Z2SCOVFQ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77381680"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="77381680"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 00:58:31 -0800
X-CSE-ConnectionGUID: oerc/rXlTwytrckP62lLig==
X-CSE-MsgGUID: TjZcryxGQpuM2eNKo5Unyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="198122552"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 00:58:27 -0800
Date: Thu, 27 Nov 2025 10:58:24 +0200
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
Subject: Re: [PATCH v2 3/9] iio: adc: Add support for ad4062
Message-ID: <aSgSsGSUuBtMOuro@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-3-a375609afbb7@analog.com>
 <aSQxiSoZcI_ol3S5@smile.fi.intel.com>
 <aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 12:40:00PM +0100, Jorge Marques wrote:
> On Mon, Nov 24, 2025 at 12:20:57PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 24, 2025 at 10:18:02AM +0100, Jorge Marques wrote:

...

> > > +#define AD4062_MON_VAL_MAX_GAIN		1999970
> > 
> > This is decimal...
> > 
> > > +#define AD4062_MON_VAL_MIDDLE_POINT	0x8000
> > 
> > ...and this is hexadecimal. Can you make these consistent?
> > Also, is there any explanation of the number above? To me
> > it looks like 2000000 - 30. Is it so? Or is this a fraction
> > number multiplied by 1000000 or so? In any case some elaboration
> > would be good to have.
> > 
> Since this is not a magic number, I will use directly below.
> It MAX_MON_VAL/MON_VAL_MIDDLE_POINT = 0xFFFF/0x8000

Okay, at least it will explain the value.

...

> > > +	if (val < 1 || val > BIT(st->chip->max_avg + 1))
> > 
> > in_range() ?
> > 
> > 	in_range(val, 1, GENMASK(st->chip->max_avg, 0))
> > 
> > if I am not mistaken. Also note, the GENMASK() approach makes possible
> > to have all 32 bits set, however it's most unlikely to happen here anyway.
> > 
> Sure, but requires locals to not trigger suspicious usage of sizeof.
>   	// ...
>   	const u32 _max = GENMASK(st->chip->max_avg, 0);
>   	const u32 _min = 1;
>   	int ret;
>   
>   	if (in_range(val, _min, _max))
> > > +		return -EINVAL;

It's fine.

...

> > > +static int ad4062_calc_sampling_frequency(int fosc, unsigned int n_avg)
> > > +{
> > > +	/* See datasheet page 31 */
> > > +	u64 duration = div_u64((u64)(n_avg - 1) * NSEC_PER_SEC, fosc) + AD4062_TCONV_NS;
> > > +
> > > +	return DIV_ROUND_UP_ULL(NSEC_PER_SEC, duration);
> > 
> > Why u64?
> > 
> > The DIV_ROUND_UP_ULL() seems an overkill here. Or do you expect duration be
> > more than 4 billions?
> > 
> This is necessary since at fosc 111 Hz and avg 4096 it does take longer
> than 4 seconds, even though I do timeout after 1 seconds in the raw
> acquisition.

Values above NSEC_PER_SEC+1 do not make sense (it will return 0),
and that fits u32. Can you refactor to avoid 64-bit arithmetics?

> > > +}

...

> > > +static int ad4062_soft_reset(struct ad4062_state *st)
> > > +{
> > > +	u8 val = AD4062_SOFT_RESET;
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(st->regmap, AD4062_REG_INTERFACE_CONFIG_A, val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Wait AD4062 treset time */
> > > +	fsleep(5000);
> > 
> > 5 * USEC_PER_MSEC
> > 
> > This gives a hint on the units without even a need to comment or look somewhere
> > else.
> >
> // TODO
> Since the device functional blocks are powered when voltage is supplied,
> here we can stick with the treset datasheet value 60ns (ndelay(60)).

Add a comment and it will work for me, thanks!

> > > +	return 0;
> > > +}

...

> > > +static const int ad4062_oversampling_avail[] = {
> > > +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,
> > 
> > It's not easy to count them at glance, please add a comment with indices.
> > 
> Ack, will use
>   static const int ad4062_oversampling_avail[] = {
>           BIT(0), BIT(1), BIT(2), BIT(3), BIT(4), BIT(5), BIT(6), BIT(7), BIT(8),
>   	BIT(9), BIT(10), BIT(11), BIT(12),
>   };

Of course you can use bit notations, but what I meant is to have

	1, 2, 4, 8, 16, 32, 64, 128,		/*  0 -  7 */
	256, 512, 1024, 2048, 4096,		/*  8 - 12 */

(or something alike).

> > > +};

...

> > > +static int ad4062_get_chan_calibscale(struct ad4062_state *st, int *val, int *val2)
> > > +{
> > > +	u16 gain;
> > > +	int ret;
> > > +
> > > +	ret = regmap_bulk_read(st->regmap, AD4062_REG_MON_VAL,
> > > +			       &st->buf.be16, sizeof(st->buf.be16));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	gain = get_unaligned_be16(st->buf.bytes);
> > > +
> > > +	/* From datasheet: code out = code in × mon_val/0x8000 */
> > > +	*val = gain / AD4062_MON_VAL_MIDDLE_POINT;
> > 
> > > +	*val2 = mul_u64_u32_div(gain % AD4062_MON_VAL_MIDDLE_POINT, NANO,
> > > +				AD4062_MON_VAL_MIDDLE_POINT);
> > 
> > I don't see the need for 64-bit division. Can you elaborate what I miss here?
> > 
> > > +	return IIO_VAL_INT_PLUS_NANO;
> > > +}
> > 
> Can be improved to
> 
>   static int ad4062_get_chan_calibscale(struct ad4062_state *st, int *val, int *val2)
>   {
>   	int ret;
>   
>   	ret = regmap_bulk_read(st->regmap, AD4062_REG_MON_VAL,
>   			       &st->buf.be16, sizeof(st->buf.be16));
>   	if (ret)
>   		return ret;
>   
>   	/* From datasheet: code out = code in × mon_val/0x8000 */
>   	*val = get_unaligned_be16(st->buf.bytes) * 2;
>   	*val2 = 16;
>   
>   	return IIO_VAL_FRACTIONAL_LOG2;
>   }

Much better, thanks!

...

> > > +static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int, int gain_frac)
> > 
> > Forgot to wrap this line.
> > 
> ack
> > > +{
> > > +	u64 gain;
> > > +	int ret;
> > > +
> > > +	if (gain_int < 0 || gain_frac < 0)
> > > +		return -EINVAL;
> > > +
> > > +	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
> > 
> > > +
> > 
> > Redundant blank line.
> > 
> Ack.
> > > +	if (gain > AD4062_MON_VAL_MAX_GAIN)
> > > +		return -EINVAL;
> > > +
> > > +	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL(gain * AD4062_MON_VAL_MIDDLE_POINT,
> > > +						 MICRO),
> > > +			   st->buf.bytes);
> > 
> > Also in doubt here about 64-bit division.
> > 
> This can be slightly improved to
> 
>   static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
>   				      int gain_frac)
>   {
>   	u32 gain;
>   	int ret;
>   
>   	if (gain_int < 0 || gain_frac < 0)
>   		return -EINVAL;
>   
>   	gain = gain_int * MICRO + gain_frac;
>   	if (gain > 1999970)

But this magic should be changed to what you explained to me
(as in 0xffff/0x8000 with the proper precision, and this
 can be done in 32-bit space).

Or even better

	if (gain_int < 0 || gain_int > 1)
		return -EINVAL;

	if (gain_int == 1 && gain_frac > 0x7fff) // did I get this right?
		return -EINVAL;

>   		return -EINVAL;
>   
>   	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL((u64)gain * AD4062_MON_VAL_MIDDLE_POINT,
>   						 MICRO),

...with temporary variable at minimum.

But again, I still don't see the need for 64-bit space.

>   			   st->buf.bytes);
>   
>   	ret = regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
>   				&st->buf.be16, sizeof(st->buf.be16));
>   	if (ret)
>   		return ret;
>   
>   	/* Enable scale if gain is not equal to one */
>   	return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
>   				  AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
>   				  FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
>   					     !(gain_int == 1 && gain_frac == 0)));
>   }
> 
> To provide the enough resolution to compute every step (e.g., 0xFFFF and
> 0xFFFE) with the arbitrary user input.

...

> > > +static int __ad4062_read_chan_raw(struct ad4062_state *st, int *val)
> > 
> > Can be named without leading double underscore? Preference is to use
> > the suffix, like _no_pm (but you can find better one).
> > 
> Since there is one usage of this method, can be merged into ad4062_read_chan_raw.

Good choice!

...

> > > +	struct i3c_priv_xfer t[2] = {
> > > +		{
> > > +			.data.out = &st->reg_addr_conv,
> > > +			.len = sizeof(st->reg_addr_conv),
> > > +			.rnw = false,
> > > +		},
> > > +		{
> > > +			.data.in = &st->buf.be32,
> > > +			.len = sizeof(st->buf.be32),
> > > +			.rnw = true,
> > > +		}
> > > +	};

> > > +	/* Change address pointer to trigger conversion */
> > > +	ret = i3c_device_do_priv_xfers(i3cdev, &t[0], 1);
> > 
> > Why array? Just split them on per transfer and use separately. This gives a bit
> > odd feeling that the two goes together, but no. They are semi-related as we
> > have a special condition after the first one.
> > 
> For this commit sure, but in the next a fallback method is introduced
> for when the gp1 gpio line is not connected.
> There are two register to trigger and read samples:
> 
> * write CONV_READ -> read dummy value - [conversion] -> read value -> [conv ...
> * write CONV_TRIGGER - [conversion] -> read value -> write ...
> 
> The first allows almost twice the sampling frequency, but does not work
> with the fallback because In-Band-Interrupt for CONV_READ are not
> yielded.

Do you mean that the same array is reused differently? If so, then okay.

> > > +	if (ret)
> > > +		return ret;

...

> > > +	fsleep(4000);
> > 
> > 4 * USEC_PER_MSEC, also would be good to add a comment for this long delay.
> > 
> Will add
> 	/* Wait device functional blocks to power up */
> Based on hardware tests, I can drop to 2 * USEC_PER_MSEC, lower than
> that the device is not ready to switch to acquisition mode for
> conversions.

Good!

-- 
With Best Regards,
Andy Shevchenko



