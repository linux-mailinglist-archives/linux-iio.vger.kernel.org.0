Return-Path: <linux-iio+bounces-16932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D8A64458
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD48C3A664F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95FD21B1B9;
	Mon, 17 Mar 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILlSOgq1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23D219A63;
	Mon, 17 Mar 2025 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197923; cv=none; b=j3+NhZwuYbzan8YijbC1Tze+hq4eJ6np2Uvq9MuUic5WKUQe120+u9y18w33k/HrbpcTFTQbHN2ABoKzXgQHEGbvdwa2cToIcB3SUvlG3o/mWfLZnSPdTPQ7nHsDmlEZeVSz2drDXS+7BYMerX33zdAKgZOUJENrNW7rfM/fk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197923; c=relaxed/simple;
	bh=ZHa6ERJ7NFArEGUz2GyKEAKlA9PEk/2XjeW1JUGRc4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFeV7Vwb9eGDSsPLrI9u2Z7QGXjVIFc4m/CZdpuLtGtbUYar3awbhKoGEEBoLPJx8thQCwrP4FbJztDDK4Qb+ThObwDH2bCDB+bozmNWUqgACyxKjag9wQKUWw23N+FMwpufAzToNTsJzD1rADFHICafV0ZAes9NijgSFKDYjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILlSOgq1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742197922; x=1773733922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZHa6ERJ7NFArEGUz2GyKEAKlA9PEk/2XjeW1JUGRc4Q=;
  b=ILlSOgq1GXMA1rw9MxMGunF+5p1yHt7xk/LcohkqJdTeBgSx/JBSjuZM
   pEIRfqRGvJqnxb144/gQt8C8eVwyo/yWFZgL7AR8moaJiSFCXsgitwFQ1
   NhQ/L8ldhunIZckZzV6ZNNdTRefBBpopuC+PXcSu6TrLdNWEyaLtE+dYq
   JixG0atp7GfOAyUHmzubuQGNBldmypC1BVx10RdIkao07HcMxkoM2ZpsV
   Bp9jNUtp7PvDfrMR+49CgytW7jgqn8yqT5wq9hehkueQE5WTvlRSovMMZ
   Zb9dbYRHQtW/5Vu/ZKwnfpNpqbfOu8C/7V1xiPMJll1OEHTqPrP0/uKsC
   Q==;
X-CSE-ConnectionGUID: kyaJYhLuRWWxwOyHNfo1ow==
X-CSE-MsgGUID: V2613K45Qq6shAs2lfD82w==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="68638749"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="68638749"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:52:01 -0700
X-CSE-ConnectionGUID: vBGt1R1iRZmxKRlgsciK1g==
X-CSE-MsgGUID: ZjVdBA2qRUKjxLSCoLq+qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122375993"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:51:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu5GM-00000003FCZ-2dgX;
	Mon, 17 Mar 2025 09:51:54 +0200
Date: Mon, 17 Mar 2025 09:51:54 +0200
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
Message-ID: <Z9fUmo5wp3EcNWzm@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
 <Z9LQ0O34EUM8WZku@smile.fi.intel.com>
 <20250316094112.6731bd01@jic23-huawei>
 <50b126c5-248e-4694-9782-4f28d6db5fce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b126c5-248e-4694-9782-4f28d6db5fce@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 09:11:08AM +0200, Matti Vaittinen wrote:
> On 16/03/2025 11:41, Jonathan Cameron wrote:
> > On Thu, 13 Mar 2025 14:34:24 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Mar 13, 2025 at 09:18:49AM +0200, Matti Vaittinen wrote:

...

> > > > +	num_channels = devm_iio_adc_device_alloc_chaninfo_se(dev,
> > > > +				&sun20i_gpadc_chan_template, -1, &channels);
> > > > +	if (num_channels < 0)
> > > > +		return num_channels;
> > > > +
> > > >   	if (num_channels == 0)
> > > >   		return dev_err_probe(dev, -ENODEV, "no channel children\n");
> > > 
> > > Note, this what I would expected in your helper to see, i.e. separated cases
> > > for < 0 (error code) and == 0, no channels.
> > > 
> > > Also, are all users going to have this check? Usually in other similar APIs
> > > we return -ENOENT. And user won't need to have an additional check in case of
> > > 0 being considered as an error case too.
> > In a few cases we'll need to do the dance the other way in the caller.
> > So specifically check for -ENOENT and not treat it as an error.
> > 
> > That stems from channel nodes being optionally added to drivers after
> > they have been around a while (usually to add more specific configuration)
> > and needing to maintain old behaviour of presenting all channels with default
> > settings.
> > 
> > I agree that returning -ENOENT is a reasonable way to handle this.
> 
> I agree - but I'm going to use -ENODEV instead of -ENOENT because that's
> what the current callers return if they find no channels. That way the
> drivers can return the value directly without converting -ENOENT to -ENODEV.

ENODEV can be easily clashed with other irrelevant cases, ENOENT is the correct
error code. If drivers return this instead of another error code, nothing bad
happen, it's not an ABI path, correct?

-- 
With Best Regards,
Andy Shevchenko



