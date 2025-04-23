Return-Path: <linux-iio+bounces-18569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A5A995BF
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D2E4652F5
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA228935A;
	Wed, 23 Apr 2025 16:50:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93E281370;
	Wed, 23 Apr 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427003; cv=none; b=e1gCJ/oQmQtWfMNoefcJQYCMzF5NwrMNbMG7IMmCiR4wWBYuY7bbtvvGyeRsZ1/uyIupD3KKjK4jqI0a34+eWeGIiyYxNqNyNB3RhRbyTsDE+6sEWL9KzdthQL01XKeFcFNBF+jZ1qXarlZegbgnpCpvYH1dDVKEZXRkxH1MVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427003; c=relaxed/simple;
	bh=mY5sZHDaswNsIgwfJ8BteQ8fZ+98rk83BFbzY0ojD7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMBift69EMGLdgXV+oI0mdPF8M9syXOvubzFkrdI49nhh1Jes+EavKsuDNBqqtAZfjjrJKuy+ylnrQRtC9J3e+KLWq5nOapHoYokBQ2HYV1EfHz/Y0D3zLY6+fT2OtnYyI1uyCcK9w2NTOeAD7KFBnYPC/Rq7FqaoGdhbLFUxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: sSEEds9ZTyGuVxpfhXyWIQ==
X-CSE-MsgGUID: oS201oRSSJSoUHvJpsaFLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64557252"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="64557252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:50:01 -0700
X-CSE-ConnectionGUID: JE9z3CBoRweY4P2iutWSkg==
X-CSE-MsgGUID: quQk4Vv+REmQe3A97QDIOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137448586"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:49:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7dII-0000000F7YU-3rql;
	Wed, 23 Apr 2025 19:49:54 +0300
Date: Wed, 23 Apr 2025 19:49:54 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <aAkaMp9R_ukoW-RQ@smile.fi.intel.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-3-94341574240f@analog.com>
 <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
 <PH0PR03MB71410D0F7716DAB4A2103AA1F9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB71410D0F7716DAB4A2103AA1F9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 23, 2025 at 07:53:37AM +0000, Paller, Kim Seer wrote:
> > From: Andy Shevchenko <andy@kernel.org>
> > Sent: Tuesday, April 22, 2025 11:11 PM
> > On Mon, Apr 21, 2025 at 12:24:54PM +0800, Kim Seer Paller wrote:

First of all, there are a lot of comments left without replies while some of
them commented as "agree I will follow your advice". This is confusing. The
rule of thumb is to not reply with positive at all, just only for the things
that you want to clarify. And with that remove a lot of unneeded (you agree
with) context!

...

> > > +		st->vref_mv = range_multiplier * vref / 1000;
> > 
> > MILLI?
> 
> Yes this is milli, will change this also to vref_mV
> 
> 	st->vref_mV = range_multiplier * vref_mV / 1000;

Ah, I was not clear enough, MILLI in capital letters is defined constant which
you may use instead of 1000.

...

> > > +	vref = devm_regulator_get_enable_read_voltage(dev, "ref");
> > > +	if (vref < 0 && vref != -ENODEV)
> > > +		return vref;
> > > +
> > > +	has_external_vref = vref != -ENODEV;
> > 
> > Wouldn't be better just make this 0 when it's == -ENODEV and check just the
> > value without having this additional boolean variable (note, I haven't checked
> > the meaning of Vref == 0 in case it's possible in real life and hardware behaves
> > adequately)?
> 
> I think it could be simpler to set vref to 0 when it's -ENODEV and check its value directly
> without having additional boolean variable. I'll try this approach.

But double check that hardware doesn't support Vref == 0 in real life.

-- 
With Best Regards,
Andy Shevchenko



