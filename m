Return-Path: <linux-iio+bounces-13791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5C9FC559
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 14:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF0163E31
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB61A841F;
	Wed, 25 Dec 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIxTLzau"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4841804E;
	Wed, 25 Dec 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735133694; cv=none; b=QhqRfZ3vHAwtoMQu/NcWVcjSjnZj7RoqDwhdJSKEfOTbCPemYO+OXtwWxzhv1vspyZwFhXD3qYatPg6fFggeahy5W/LZ5OgtW8apSfsrPsqRieTWAnl8NmUNXzMlGbuyc76lON+MrPxUqLK/ctTPCtXxqo62L4F/3Zb5TZ88xeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735133694; c=relaxed/simple;
	bh=mcDs+39afJXtyJvkajVcjX3T0LD00FXJS24cWI+9CMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJEf7NViuzm1NQNMOSHP+w1o0ai1HwywgHBteV0dx9CTByevP1qbPGJjfPSQfnm4SWVPyuEj7H7uJTHsSbjN+9svD+V/HEl3JxF1xxY70mTZVFGWA/rCPex95zLVwIhKYF9ALTj5AS1V+pEPIQnbldeU4iYpEPs2EoixIEcel/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIxTLzau; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735133692; x=1766669692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcDs+39afJXtyJvkajVcjX3T0LD00FXJS24cWI+9CMg=;
  b=eIxTLzaudWu+i9ZMr8iSMQ6+UlDo4299lzKAAJK0wh+sGk/a4B9aGb8/
   Mctnh/dglukKlU3TkTQeZToxYASu1y8C4HSN5y6/HmxLZv1ERawSNW4cm
   qKjW3kBIOSDt8oBtZlR7Jsv/6NhzINcehgQNzJ/MCmM1Ggb9ANA/h61WO
   VdlEboidPXynTjfouxys3ve0rjLzVMumo6CDC1dkI7vEFQSe/bOERW2qw
   cg9E1ffzQSWJ9xYaMN4MRqZirl7grlcHNUdnRB6Covy8WqTeUd5Bi0zl4
   ZdEK2yuvSOxg7GRpo06U7kF4kdenYfKH+cUbFwWahTKbAk5zJsuHRtDSp
   g==;
X-CSE-ConnectionGUID: m1AHpY7wQrGzbwWrlBF4GQ==
X-CSE-MsgGUID: 7AC7vA2BSpq8dMG5J/P7lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="47000922"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="47000922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 05:34:52 -0800
X-CSE-ConnectionGUID: dbcoKQ97SSCquqjqWs/QFg==
X-CSE-MsgGUID: bc4QqcAXTv2F1gPSZUcOLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="99812092"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 05:34:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tQRXA-0000000C8RA-37s6;
	Wed, 25 Dec 2024 15:34:44 +0200
Date: Wed, 25 Dec 2024 15:34:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Andreas Dannenberg <dannenberg@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Message-ID: <Z2wJ9BLsrLeDD-zb@smile.fi.intel.com>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
 <20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
 <Z2rRnBGd4qqJXAb5@smile.fi.intel.com>
 <PN0P287MB2843562E6C965196D05E2BCFFF0C2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0P287MB2843562E6C965196D05E2BCFFF0C2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 25, 2024 at 09:56:36AM +0000, Hardevsinh Palaniya wrote:
> > On Tue, Dec 24, 2024 at 11:43:16AM +0530, Hardevsinh Palaniya wrote:

...

> > > Add Support for OPT3004 Digital ambient light sensor (ALS) with
> > > increased angular IR rejection
> >
> > Missing period here.

> > > The OPT3004 sensor shares the same functionality and scale range as
> > > the OPT3001. This Adds the compatible string for OPT3004, enabling
> > > the driver to support it without any functional changes.
> > >
> > > Datasheet: https://www.ti.com/lit/gpn/opt3004
> >
> > >
> > 
> > This blank line is not needed.

You left two above comments unanswered while Acking the rest, it's a bit confusing.
Are you agree on them or not?

...

> > >  static const struct of_device_id opt3001_of_match[] = {
> > >       { .compatible = "ti,opt3001", .data = &opt3001_chip_information },
> > >       { .compatible = "ti,opt3002", .data = &opt3002_chip_information },
> > > +     { .compatible = "ti,opt3004", .data = &opt3001_chip_information },
> > >       { }
> > >  };
> > 
> > I'm always puzzled why do we need a new compatible for the existing driver
> > data? Is this hardware has an additional feature that driver does not (yet)
> > implement?
> 
> OPT3001 and OPT3004 sensors are functionally identical, and there are no
> additional features in the OPT3004 that require separate handling in the driver.
> 
> The new compatible string for the OPT3004 is being added, which will allow the
> driver to recognize and support this sensor in the same way it handles the OPT3001.

But why? I understand if you put two compatible strings into the DT to make it
explicit in case of the future developments of the driver, but new compatible
in the driver makes only sense when you have either quirk(s) or feature(s) that
are different to the existing code. Since you haven't added either, what's the
point?

-- 
With Best Regards,
Andy Shevchenko



