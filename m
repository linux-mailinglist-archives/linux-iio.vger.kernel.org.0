Return-Path: <linux-iio+bounces-20183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60471ACC826
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA613A2377
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0D23535C;
	Tue,  3 Jun 2025 13:43:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB982040B6;
	Tue,  3 Jun 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958232; cv=none; b=i6vzRtm8Gujqa0NNhnt+3AAhHOOpFToR/LicL9mjdkpR3vTT0KFlIqreutRHGFO33qedQcT+710s6HaKfKJHz+HN4aGrq3ky+dBt4uYjsrUoIIbvsfd4kLrfglaWb2gKoA8E1fHcF5wozli4FnRq0QIu1XhuGIeL5+nk28+24Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958232; c=relaxed/simple;
	bh=O/9vgjzrltqM0RlHHMSySJpGp65xGYUrOzaYg0fKtq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTVn/a7ltRX1IYoSKQwzi+g+7YZy7euIMsSe5BE35ipVSJsQoAFdjFbeiR3jXB8HBSzqBha09cmgzzokYM2ZsclAef2zlvNtTgdxePCezDhkuJJMLqzztHAV8v0B9qiErdGNKFt++jBtSF3DhQxrLk4sqsgVDDddOJrqi+kQzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: ECmCQW5wS5uoVJQonQgH6g==
X-CSE-MsgGUID: tu5OPRmkQUyE3n7cpo7qWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51098931"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="51098931"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:43:50 -0700
X-CSE-ConnectionGUID: DRkJL9YPQ3+fRf/gD69gjA==
X-CSE-MsgGUID: o778+cpFTR2J40dlstcPfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144838262"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:43:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uMRva-00000003HZk-3B1J;
	Tue, 03 Jun 2025 16:43:42 +0300
Date: Tue, 3 Jun 2025 16:43:42 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v4 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aD78Di51VHxtOtJG@smile.fi.intel.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <e79f9a126672b33b8a7c01f650fee43a68c74029.1748829860.git.marcelo.schmitt@analog.com>
 <aD27cobHWeBX8o30@smile.fi.intel.com>
 <aD3XQfUfxIiz62ZU@debian-BULLSEYE-live-builder-AMD64>
 <aD6x2caTMd1eBInM@smile.fi.intel.com>
 <aD7kcFupREh4lW0s@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD7kcFupREh4lW0s@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 03, 2025 at 09:02:56AM -0300, Marcelo Schmitt wrote:
> On 06/03, Andy Shevchenko wrote:
> > On Mon, Jun 02, 2025 at 01:54:25PM -0300, Marcelo Schmitt wrote:

...

> > > > > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > > > > +{
> > > > > +	/*
> > > > > +	 * The use of static_assert() here is to make sure that the comparison
> > > > > +	 * is adapted whenever struct ad4170_setup is changed.
> > > > > +	 */
> Does the reason given in the comment justify the use of static_assert?

Should I repeat myself? It makes a little sense when no memcmp() is involved.

> > > > > +	static_assert(sizeof(*a) ==
> > > > > +		      sizeof(struct {
> > > > > +				     u16 misc;
> > > > > +				     u16 afe;
> > > > > +				     u16 filter;
> > > > > +				     u16 filter_fs;
> > > > > +				     u32 offset;
> > > > > +				     u32 gain;
> > > > > +			     }));
> > > > 
> > > > I think it doesn't make much sense unless one uses memcpy().
> > > 
> > > memcpy() is used to update the setups after reg write succeeds.
> > > Also, previously, memcmp() was used to compare setups.
> > > Since struct ad4170_setup has only unsigned integers (no floating point fields
> > > like ad7124 had [1]), ad4170 works properly when comparing setups with memcmp().
> > > Though, it was asked to do explicit field matching on previous reviews [2] so
> > > that's how it had been since then. Well, both ways work for ad4170. We can
> > > compare setup with memcmp(), or do the comparison field by field. I don't mind
> > > changing it again if requested. I guess we only need to reach an agreement about
> > > what to go with.
> > 
> > The question was "why do you need the static_assert() now?"
> 
> To ensure that the comparison function gets updated if struct ad4170_setup is
> ever modified? This intends to be similar to what was implemented in ad7124
> driver as the chips have similar channel configuration mechanisms. We also
> have ad7173 and ad4130 using static_assert for analogous purpose. There was
> also a comment about static_assert above.

Does this won;t work if you changes field types? (Assuming only integers to
integers) I believe it doesn't affect the field-by-field comparison.

The other drivers may have different approach, have you studied them? Do they
use memcmp()

> > > [1]: https://lore.kernel.org/all/20250303114659.1672695-13-u.kleine-koenig@baylibre.com/
> > > [2]: https://lore.kernel.org/linux-iio/20250504192117.5e19f44b@jic23-huawei/
> > > 
> > > > > +	if (a->misc != b->misc ||
> > > > > +	    a->afe != b->afe ||
> > > > > +	    a->filter != b->filter ||
> > > > > +	    a->filter_fs != b->filter_fs ||
> > > > > +	    a->offset != b->offset ||
> > > > > +	    a->gain != b->gain)
> > > > > +		return false;
> > > > > +
> > > > > +	return true;
> > > > > +}

-- 
With Best Regards,
Andy Shevchenko



