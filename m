Return-Path: <linux-iio+bounces-26437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D72C82215
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 19:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B57B94E3D10
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49B031987E;
	Mon, 24 Nov 2025 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQgJRgNM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F015442C;
	Mon, 24 Nov 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009700; cv=none; b=PTkzWMh6U55gseOrFcq4nKB+alx2pnBzbZ+Wd2oud3JrElZ4tRywYNrPK0YqHUGIMANnJ15rmofX6i8N2bSSHTTQlWSvDyAqFJI034YFIHSpokh7kqBK8tJl9RymqzD7q3qh3xzYhZ39uSiZMAKOI8prK8QuqgW5EDVs+BqkT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009700; c=relaxed/simple;
	bh=xDiifGEgvjDi6KwydZXLf6/JprHKgNEt1TP4N4I2Bm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRVOMZoUsLSTuDU+PSw6S9mPcomhHnUD83PZfKIkZe2cBU8O0DO25xBZpMQH5EDNewnVL5nnaKgxS7BhRPFFMo0IK/yKcDtSI+XFWyezjRdihGSNukBwMX2ICHXgswLdJR1L/Swn5cRryJrLU1OL93e/EtVR0dv6+L+L0v/h2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQgJRgNM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764009698; x=1795545698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDiifGEgvjDi6KwydZXLf6/JprHKgNEt1TP4N4I2Bm8=;
  b=BQgJRgNMQo8r+O/XDoVlSLyVE5qySEGSbXfUTIy4TT23Sul9dj8MLGv4
   UWaBh2TcshQ//XBuW9XPq5V7qvi4N9yAdAqetSQg0Ywu9+acIkAAq2kI7
   vUV/spRp+rwy4gz4It1hQVt9vIsulnhd17Mdjm5cDf5YV35mh+pR/fo9C
   w3zA2penbbXkJ/Blj6pMyTPy22PM5PjeqlMcp6xubJCy4Dga510xH9t4n
   Za4iYzXWoJcH5D6VaJ+Ufy/fF/bFr94EJIPTo1Yi3bVkL4tldI/p3yOPC
   XAm+OrLd5YUXuYxH5vzTq0FCpE/aAmnXvzm9uk6wisq+AKVIkgVxYaGXL
   w==;
X-CSE-ConnectionGUID: 45ISepUyRlWtW1NgS1qU9g==
X-CSE-MsgGUID: Vui9bSeCTeuU5fAcyZ8Z+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77490413"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="77490413"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 10:41:37 -0800
X-CSE-ConnectionGUID: 1sH49ktuSMuDfvVgvFJ7fg==
X-CSE-MsgGUID: UH0vu2X/SUSyLPDblKlTIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="223386405"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 10:41:35 -0800
Date: Mon, 24 Nov 2025 20:41:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSSm3JMY3DSg1Nns@smile.fi.intel.com>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
 <aSRF-DL3rKjyFleg@smile.fi.intel.com>
 <aSSV4lxzatAFds5e@lipo.home.arpa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSV4lxzatAFds5e@lipo.home.arpa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 07:29:06PM +0200, Petre Rodan wrote:

> thank you for the review.

You're welcome.

> On Mon, Nov 24, 2025 at 01:48:08PM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 22, 2025 at 11:42:45PM +0200, Petre Rodan wrote:

[..]

> > > +/*
> > > + * transfer function A: 10%   to 90%   of 2^24
> > 
> > Too many spaces, also this may be a one-line comment.
> 
> it was intentional to have the comment multiline.
> in case we need to add additional transfer functions in the future for
> compatible ICs the diff will be a few lines smaller.

This is just a comment, won't be a big churn to change (note, it's different
to the cases of trailing commas where it has more significant impact).

> > > + */

...

> > > +enum abp2_variants {
> > 
> > Why explicit assignments? Is it related to some HW register?
> 
> no registers, I just need to ensure the two arrays
> 
> static const char * const abp2_triplet_variants[ABP2_VARIANTS_MAX] = {
> 	[ABP2001BA] = "001BA", [ABP21_6BA] = "1.6BA", [ABP22_5BA] = "2.5BA", ..
> 
> static const struct abp2_range_config abp2_range_config[ABP2_VARIANTS_MAX] = {
> 	[ABP2001BA] = { .pmin =       0, .pmax =  100000 },
>    	[ABP21_6BA] = { .pmin =       0, .pmax =  160000 }, ..
> 
> keep being consistent and are resistant to later editing.

So, if it's pure software numbering, just drop assignments in the enum.

> I feel like I had a better implementation two years ago when I used a single
> struct containing all this information and had a custom/NIH search function,
> but you kindly asked me [1] to use device_property_match_property_string()
> instead and split my single struct into this three parts mess.

Yes, and that still stays.

> [1] https://lore.kernel.org/linux-iio/ZWcUPkzfGqxYsysp@smile.fi.intel.com/

> > Can be done easier with a macro with more robustness against typos:
> > 
> > #define ABP2_VARIANT(v)		[ABP2 ## v] = ##v
> > 
> > static const char * const abp2_triplet_variants[] = {
> > 	ABP2_VARIANT(001BA), ABP2_VARIANT(1_6BA), ABP2_VARIANT(2_5BA), ABP2_VARIANT(004BA),
> > 	...
> > };
> > 
> > but this will loose the possibility to make '.' in the name. Up to you.
> 
> thanks, but I need '.' in the name. the dot is used in the part number (and
> thus in the pressure triplet).

OK.

...

> > > +	if (data->irq > 0) {
> > > +		ret = wait_for_completion_timeout(&data->completion, HZ);
> > 
> > Where is HZ defined? Include that.
> > 
> > > +		if (!ret) {
> > > +			dev_err(dev, "timeout waiting for EOC interrupt\n");
> > > +			return -ETIMEDOUT;
> > > +		}
> > > +	} else
> > > +		fsleep(5000);
> > 
> > Better to have 5 * USEC_PER_MSEC. Also missed comment why this long delay
> > is needed (will require time.h).
> > 
> > Missed {} as well.
> 
> I'm not sure I understand where are braces needed/not needed in this context.

It's according to the Coding Style. If one branch needs that, the second must
be on par.

...

> > > +	/*
> > > +	 * status byte flags
> > > +	 *  bit7 SANITY_CHK     - must always be 0
> > > +	 *  bit6 ABP2_ST_POWER  - 1 if device is powered
> > > +	 *  bit5 ABP2_ST_BUSY   - 1 if device has no new conversion ready
> > > +	 *  bit4 SANITY_CHK     - must always be 0
> > > +	 *  bit3 SANITY_CHK     - must always be 0
> > > +	 *  bit2 MEMORY_ERR     - 1 if integrity test has failed
> > > +	 *  bit1 SANITY_CHK     - must always be 0
> > > +	 *  bit0 MATH_ERR       - 1 during internal math saturation err
> > > +	 */
> > > +
> > > +	if (data->buffer[0] == (ABP2_ST_POWER | ABP2_ST_BUSY))
> > > +		return -ETIMEDOUT;

-EBUSY as I read the comment above.

> > > +	if (data->buffer[0] != ABP2_ST_POWER) {
> > > +		dev_err(data->dev,
> > > +			"unexpected status byte 0x%02x\n", data->buffer[0]);
> > > +		return -ETIMEDOUT;

-EIO

> > > +	}
> > 
> > I am not sure the chosen error code in both cases is good enough.
> 
> I'm open to recommendations on better error codes.

See below.

> first error: chip reports it's busy 5ms after start conversion command. based
> on the datasheet the conversion should have been ready at this point in time.
> this sounds to me like a timeout error.

I think EBUSY consistent with the comment given above in the code.

> second error: status byte contains unexpected flags being set - either an
> internal error - see table above or a bus read error. yes, timeout is not
> good here but what should it be?
> 
> I'm using two conditionals because I want to log only invalid statuses and
> ignore simple 'device busy' errors.

You know the HW much better than me, so I proposed on the context I see in the
code, you may take the advice or do differently, but -ETIMEDOUT in these cases
seems to me not a fit.

...

> > > +struct abp2_ops {
> > > +	int (*init)(struct device *dev);
> > > +	int (*read)(struct abp2_data *data, const u8 cmd, const u8 cnt);
> > > +	int (*write)(struct abp2_data *data, const u8 cmd, const u8 cnt);
> > 
> > What is the meaning of const for the POD type parameters? I mean this gives
> > really a little protection if any. I do not see a point here to have them being const.
> 
> I read a few books about C programming a few decades back and there was a
> consensus on using const in function prototypes wherever a parameter was
> supposed to not be changed.  of course it's not bulletproof, but why do you
> feel I should stop following that advice for functions that are not tied to
> any pre-existing kernel API?

This is quite good advice for the pointers to the arrays and / or structures,
but for simple numbers it makes a little sense inside one small driver.
(Although, it has more sense in the generic libraries, but still.)

> > > +int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq);

You see, here I haven't commented anything as const qualifier for ops here is
very good and should be present like you have done already.

> > > +#endif

...

> > > +static int abp2_i2c_init(struct device *dev)
> > > +{
> > > +	return 0;
> > > +}
> > 
> > Is this stub required?
> 
> do I have a 100% guarantee that the kernel will not try to execute a null
> pointer function in abp2_common_probe()?

Depends on what you do with this. If you do not check at the caller, then yes,
stub is needed, but in kernel we usually do

	if (...->init) {
		ret = ->init(...);
		...
	}

> 	ret = data->ops->init(data->dev); // needed only for SPI.
> 
> later edit:
> since I will remove devm_kzalloc(), the _init will probably go away entirely
> together with the stub.

OK.

...

> > > +static int abp2_i2c_read(struct abp2_data *data, const u8 unused, const u8 cnt)
> > > +{
> > > +	struct i2c_client *client = to_i2c_client(data->dev);
> > > +	int ret;
> > > +
> > > +	if (cnt > ABP2_MEASUREMENT_RD_SIZE)
> > > +		return -EOVERFLOW;
> > > +
> > > +	ret = i2c_master_recv(client, data->buffer, cnt);
> > > +	if (ret < 0)
> > > +		return ret;
> > 
> > > +	else if (ret != cnt)
> > 
> > Redundant 'else'.

> > > +		return -EIO;
> > > +
> > > +	return 0;
> > > +}
> 
> are you implying that __i2c_transfer() errors out if the number of bytes transfered is not cnt?

	git log --grep "redundant 'else'"

will answer to this question.

[..]

> > So, why can't regmap SPI be used?
> 
> there are no registers, no memory map, just a 'start conversion' and the
> equivalent of a 'read conversion' command.
> any reason one would use the regmap API in this case?

At bare minimum the commit message should have a justification for the choice
explaining all this. Ideally, try to find a way how to use regmap API. We have
several weeks of time for this exercise.

-- 
With Best Regards,
Andy Shevchenko



