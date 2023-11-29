Return-Path: <linux-iio+bounces-489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E848D7FD8AC
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8545C282E02
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB16210EC;
	Wed, 29 Nov 2023 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="FNI4lN1j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B7CE;
	Wed, 29 Nov 2023 05:51:57 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 69B1828EE6F;
	Wed, 29 Nov 2023 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701265915;
	bh=uvNPKH/HkMehqSkicatMT25AWwf9jXqH853dzUzJVoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FNI4lN1jDG9U/Ou85SXKAxLh+wUsuBGK+zDp14jamvc8hzBWfFBVGCLwH+dQfK3QM
	 w48RmsNERSN3A4drgjPrKsZqebogbEp1XiEUOaA07kgr1KW0O4aRHhNYOrvWNY5tsJ
	 ctbLeJN9J+m2SyWBLmXOrAUVA5Ikn/wlVv0WKxMY=
Date: Wed, 29 Nov 2023 15:51:54 +0200
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
Subject: Re: [PATCH v5 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWdB-vU2MAptRk8d@sunspire>
References: <20231129070452.1521-1-petre.rodan@subdimension.ro>
 <ZWcUPkzfGqxYsysp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcUPkzfGqxYsysp@smile.fi.intel.com>


Hello,

thank you for the code review.

On Wed, Nov 29, 2023 at 12:36:46PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 29, 2023 at 09:04:49AM +0200, Petre Rodan wrote:
> ...
> 
> > +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> > +			if (strncmp(hsc_range_config[index].triplet,
> > +				    triplet,
> > +				    HSC_PRESSURE_TRIPLET_LEN - 1) == 0) {
> > +				hsc->pmin = hsc_range_config[index].pmin;
> > +				hsc->pmax = hsc_range_config[index].pmax;
> > +				found = 1;
> > +				break;
> > +			}
> > +		}
> > +		if (hsc->pmin == hsc->pmax || !found)
> > +			return dev_err_probe(dev, -EINVAL,
> > +				"honeywell,pressure-triplet is invalid\n");
> 
> This one is important. I think I told already twice that this is NIH
> device_property_match_property_string(). Please, use this API directly.

let me see if we are on the same frequency.

you told me to use match_string/sysfs_match_string.
using any of those assume having the strings in an array, which means I have to
 clutter the code with 242 extra lines in order to split up hsc_range_config:

enum hsc_variants {
    HSC001BA = 0,
    HSC1_6BA = 1,
    [ .. 115 lines skipped ]
    HSC150PG = 117,
}

static const char * const hsc_triplet_variants[] = {
	[HSC001BA] = "001BA",
	[HSC1_6BA] = "1.6BA",
	[ .. 115 lines skipped ]
	[HSC150PG] = "150PG",
};

and change my structure to

static const struct hsc_range_config hsc_range_config[] = {
	[HSC001BA] = { .pmin = 0, .pmax = 100000 },
	[ .. 117 lines skipped ]
};

just to have the privilege of using match_string() on hsc_triplet_variants.
now, which is worse for maintenance? a handful of lines of code that do a
loop of strncmp or the clutter depicted above?

I can go either way, but I want to make sure you see where this leads.

> > +#ifndef _HSC030PA_H
> > +#define _HSC030PA_H
> 
> > +#include <linux/mutex.h>
> 
> > +#include <linux/property.h>
> 
> Is not used here.

ok.
since we are here, can you please tell me how is mutex.h used outside of hsc030pa.c where it was included previously?

cheers,
peter

-- 
petre rodan

