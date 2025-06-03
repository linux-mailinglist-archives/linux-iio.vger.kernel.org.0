Return-Path: <linux-iio+bounces-20176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61705ACC227
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C14916E560
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6211280CE0;
	Tue,  3 Jun 2025 08:27:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F62AEF1;
	Tue,  3 Jun 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939235; cv=none; b=hmfjjez44NT3PXL6YcLIntMHqpVLLYtkbE1EF90SXTaV3zofsRt1oYPUJK0oqP2lgudM+sxYjfuSEqZPZZSqQxwO+HM4bUAtbgMI+5bfPA+0RHxG0zQwnHKClIi+Y2vnkw8lJc9qAiUMrvMPF3z9BNLJFlhNFnajeCD4VtCyO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939235; c=relaxed/simple;
	bh=BRrKnqgLltf6ieKDODpgazGoNdNRWTnRKZsItlQWc2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4HqfFcZwwJRERBXpSObJ9wMrz7SoCNeUTLgGfXCq4DeF+9AwNjMCMNtwj8vNGSiKGbowqn7pZafw86EN/MvQ6KjkUyvne1HoUc12PKVobELhZ9ptylZWLzz1rpNQUnVDcNPPZM50ztoE4zz9U2UDuiLoEo8pela8A4+iIAbZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: gHAVPs2CSTOgDiGH5drWsQ==
X-CSE-MsgGUID: bhEds/3pTN6KmTGCAMv3HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="54632278"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="54632278"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:27:14 -0700
X-CSE-ConnectionGUID: i4BkCzHLR0Khp5rrO1zrTQ==
X-CSE-MsgGUID: FLtNlArMRwyfc5yGc8HpFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="167968931"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:27:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uMMzC-000000035FG-0tXf;
	Tue, 03 Jun 2025 11:27:06 +0300
Date: Tue, 3 Jun 2025 11:27:05 +0300
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
Message-ID: <aD6x2caTMd1eBInM@smile.fi.intel.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <e79f9a126672b33b8a7c01f650fee43a68c74029.1748829860.git.marcelo.schmitt@analog.com>
 <aD27cobHWeBX8o30@smile.fi.intel.com>
 <aD3XQfUfxIiz62ZU@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD3XQfUfxIiz62ZU@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 02, 2025 at 01:54:25PM -0300, Marcelo Schmitt wrote:

...

> > > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > > +{
> > > +	/*
> > > +	 * The use of static_assert() here is to make sure that the comparison
> > > +	 * is adapted whenever struct ad4170_setup is changed.
> > > +	 */
> > > +	static_assert(sizeof(*a) ==
> > > +		      sizeof(struct {
> > > +				     u16 misc;
> > > +				     u16 afe;
> > > +				     u16 filter;
> > > +				     u16 filter_fs;
> > > +				     u32 offset;
> > > +				     u32 gain;
> > > +			     }));
> > 
> > I think it doesn't make much sense unless one uses memcpy().
> 
> memcpy() is used to update the setups after reg write succeeds.
> Also, previously, memcmp() was used to compare setups.
> Since struct ad4170_setup has only unsigned integers (no floating point fields
> like ad7124 had [1]), ad4170 works properly when comparing setups with memcmp().
> Though, it was asked to do explicit field matching on previous reviews [2] so
> that's how it had been since then. Well, both ways work for ad4170. We can
> compare setup with memcmp(), or do the comparison field by field. I don't mind
> changing it again if requested. I guess we only need to reach an agreement about
> what to go with.

The question was "why do you need the static_assert() now?"

> [1]: https://lore.kernel.org/all/20250303114659.1672695-13-u.kleine-koenig@baylibre.com/
> [2]: https://lore.kernel.org/linux-iio/20250504192117.5e19f44b@jic23-huawei/
> 
> > > +	if (a->misc != b->misc ||
> > > +	    a->afe != b->afe ||
> > > +	    a->filter != b->filter ||
> > > +	    a->filter_fs != b->filter_fs ||
> > > +	    a->offset != b->offset ||
> > > +	    a->gain != b->gain)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}

-- 
With Best Regards,
Andy Shevchenko



