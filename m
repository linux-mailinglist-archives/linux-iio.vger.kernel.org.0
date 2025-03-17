Return-Path: <linux-iio+bounces-16941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46EEA6474E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8503B1B9F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6E2253A0;
	Mon, 17 Mar 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8Qij+8Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99B2248B4;
	Mon, 17 Mar 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203668; cv=none; b=OeJJUSMvMtC1/OJtsgnWapEg2y9/zqAiJVjWW+rnIH7yMWdpBRQFiaW3ikfEOk+lIeZ0dC7gaGxVLB44pxelch6cj+rW6QA+nahcI0tXBQaBZsnxvVJgZDQWyqsBY7p4GJJwnrMl5mjhhtQI2QUQFpbVPEW03FAb6p8Fo21c+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203668; c=relaxed/simple;
	bh=dJoV1yMs920m1r9dWptgBPGSZSrP9BNdmMBKMk1MVp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOgsDYx0fBhLnzqVzeuARGO2mD/lTFt/k01papK4OWQ/u4nXAX5j2hRhpsYt6OAgmjfHqBp7z66wrACnIWVYjyUtt+lTIXenk2X6OIE6S/sttoNTN01aeSIhdY3lhIeFcV4wcoFzMaHjFQ5o400fQILZjalUdXHZ0BTIBfcO6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8Qij+8Q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742203667; x=1773739667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dJoV1yMs920m1r9dWptgBPGSZSrP9BNdmMBKMk1MVp0=;
  b=A8Qij+8QbjYROwmwmC0twC+sgZMWlCtUetQX+AKe9KepChc+PnnT/kjt
   ANvjI8tOl2MZFU36ymgiNjGggGteM8KlM9udFX592E55Wuxd3hAnYaopH
   oAFfaYlIkzHjoD0GEPkbgr3vey2K5N20VU5Fh14/CJUaxWIZrZk2X2Z7s
   kOb94hkWgC9AAbhP0cNiVpLMUgdtfQplIvna0yB62MLL79NYPK2W4lbCh
   JpvSOCBIozi1bJdZNtDFK4mWQnIDavpfOThndO7p9fWmLpDjTKTqdC9iO
   /xLPVMReXottD3jHPmTxmwJo1/cv4N2PyFmh+GP12S7lCyn7Ul47UHMr+
   Q==;
X-CSE-ConnectionGUID: yTlDwhLNRgCj2gVoQ8CAzg==
X-CSE-MsgGUID: VsYQg5tYT9+Y/FDIU1O+mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43157130"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43157130"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:27:45 -0700
X-CSE-ConnectionGUID: DNF9w2caToufAA+qjO/N8w==
X-CSE-MsgGUID: 4w/qxc07Q9GdL3t3sDcjLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="126743831"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:27:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu6kz-00000003GTc-24Ua;
	Mon, 17 Mar 2025 11:27:37 +0200
Date: Mon, 17 Mar 2025 11:27:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <Z9frCUqRTD0i1Faq@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
 <Z9LQ0O34EUM8WZku@smile.fi.intel.com>
 <20250316094112.6731bd01@jic23-huawei>
 <50b126c5-248e-4694-9782-4f28d6db5fce@gmail.com>
 <Z9fUmo5wp3EcNWzm@smile.fi.intel.com>
 <0db2a42f-d393-4e75-afbf-cf30c0e06cce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db2a42f-d393-4e75-afbf-cf30c0e06cce@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 10:42:07AM +0200, Matti Vaittinen wrote:
> On 17/03/2025 09:51, Andy Shevchenko wrote:
> > On Mon, Mar 17, 2025 at 09:11:08AM +0200, Matti Vaittinen wrote:
> > > On 16/03/2025 11:41, Jonathan Cameron wrote:
> > > > On Thu, 13 Mar 2025 14:34:24 +0200
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Mar 13, 2025 at 09:18:49AM +0200, Matti Vaittinen wrote:

...

> > > > > > +	num_channels = devm_iio_adc_device_alloc_chaninfo_se(dev,
> > > > > > +				&sun20i_gpadc_chan_template, -1, &channels);
> > > > > > +	if (num_channels < 0)
> > > > > > +		return num_channels;
> > > > > > +
> > > > > >    	if (num_channels == 0)
> > > > > >    		return dev_err_probe(dev, -ENODEV, "no channel children\n");
> > > > > 
> > > > > Note, this what I would expected in your helper to see, i.e. separated cases
> > > > > for < 0 (error code) and == 0, no channels.
> > > > > 
> > > > > Also, are all users going to have this check? Usually in other similar APIs
> > > > > we return -ENOENT. And user won't need to have an additional check in case of
> > > > > 0 being considered as an error case too.
> > > > In a few cases we'll need to do the dance the other way in the caller.
> > > > So specifically check for -ENOENT and not treat it as an error.
> > > > 
> > > > That stems from channel nodes being optionally added to drivers after
> > > > they have been around a while (usually to add more specific configuration)
> > > > and needing to maintain old behaviour of presenting all channels with default
> > > > settings.
> > > > 
> > > > I agree that returning -ENOENT is a reasonable way to handle this.
> > > 
> > > I agree - but I'm going to use -ENODEV instead of -ENOENT because that's
> > > what the current callers return if they find no channels. That way the
> > > drivers can return the value directly without converting -ENOENT to -ENODEV.
> > 
> > ENODEV can be easily clashed with other irrelevant cases,
> 
> Can you please explain what cases?

When it's a code path that returns the same error code for something different.

> > ENOENT is the correct
> > error code.
> 
> I kind of agree if we look this from the fwnode perspective. But, when we
> look this from the intended user's perspective, I can very well understand
> the -ENODEV. Returning -ENODEV from ADC driver's probe which can't find any
> of the channels feels correct to me.

Okay, it seems we have got yet another disagreement as I think this has to
be ENOENT. Because this is related to the firmware description and not real
hardware discovery path. If it is the latter, I may fully agree on ENODEV
choice. But AFAICS it's not the case here.

> > If drivers return this instead of another error code, nothing bad
> > happen, it's not an ABI path, correct?
> 
> I don't know if failure returned from a probe is an ABI. I still feel
> -ENODEV is correct value,

And I have the opposite opinion. I think ENODEV is _incorrect_ choice
in this case.

> and I don't want to change it for existing users -
> and I think also new ADC drivers should use -ENODEV if they find no channels
> at all.

Again, the problem is that you are trying to apply the error code for HW to the
information that comes from FW.

> Besides that I think -ENODEV to be right, changing it to -ENOENT for
> existing callers requires a buy-in from Jonathan (and/or) the driver
> maintainers.

Yeah, will wait for Jonathan to judge, but I think you can find rationale above.

-- 
With Best Regards,
Andy Shevchenko



