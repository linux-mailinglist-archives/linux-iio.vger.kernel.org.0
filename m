Return-Path: <linux-iio+bounces-499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8587FE027
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 20:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC54B20E33
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605875DF24;
	Wed, 29 Nov 2023 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="c/+8u4YQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E7D5E;
	Wed, 29 Nov 2023 11:12:55 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 396B328EE6F;
	Wed, 29 Nov 2023 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701285174;
	bh=xiXoHUFxOf2VpMnPxdPWZok2lzoqqKH4KbvpI0hmZCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c/+8u4YQUBewn/6pZpzPocLAKHOCW3HtaP0idL8WBy3zYF9Ey2jzHseXZGo2XoG4I
	 V/byl8oCNX8T7F6YGWKoXV2aHK4OWF4pp8jgaWHK0y/YZT2qz5OV/2bpwX+b9fQpt5
	 ANQOaXsdvvKV9uo+Vku+/6HYcji8lqmfLsDMEm+8=
Date: Wed, 29 Nov 2023 21:12:52 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZWeNNMfqKquDYI9X@sunspire>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdzz7VzCW5ctend@smile.fi.intel.com>


hello!

On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 29, 2023 at 07:04:12PM +0200, Petre Rodan wrote:
> > Adds driver for digital Honeywell TruStability HSC and SSC series
> > pressure and temperature sensors.
> > Communication is one way. The sensor only requires 4 bytes worth of
> > clock pulses on both i2c and spi in order to push the data out.
> > The i2c address is hardcoded and depends on the part number.
> > There is no additional GPIO control.
> 
> ...
> 
> > v6: modifications based on Andy's review
> >     - use str_has_prefix(), match_string() instead of strncmp()
> 
> And why not using the respective property API for that case where
> match_string() is used?

I'm lost again.

437:  ret = device_property_read_string(dev, "honeywell,pressure-triplet",
					&triplet);
[..]
455:	ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
						triplet);
		if (ret < 0)
			return dev_err_probe(dev, -EINVAL,
				"honeywell,pressure-triplet is invalid\n");

		hsc->pmin = hsc_range_config[ret].pmin;
		hsc->pmax = hsc_range_config[ret].pmax;

triplet is got via device_property_read_string(), is there some other property
function I should be using?

> I'm also a bit tired to repeat about:
> - capitalization and punctuation in the multi-line comments;
> - broken indentation is some cases.

sorry about that. I removed all comments you complained about.
just to simplify the process.

> Otherwise it's a good stuff, I leave it now to Jonathan.
> 
> ...
> 
> > +	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
> > +		      hsc->outmax - hsc->outmin);
> > +	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_dec);
> > +	tmp = div_s64(((s64)hsc->pmin * (s64)(hsc->outmax - hsc->outmin)) *
> > +		      MICRO, hsc->pmax - hsc->pmin);
> 
> Why not put MICRO on the previous line?

oh well, from the review I understood you were asking for the replacement of
NANO with MICRO on the previous instruction and it did not make much sense ( units
are in pascal and we need a kilopascal output to userland)

now I understood it's an indentation request. however moving MICRO will cross
the 80 column rule. but if there will be yet another modification request I'll move it.

cheers,
peter


> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
petre rodan

