Return-Path: <linux-iio+bounces-16778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8ACA5F5F4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF5217B3FD
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6F267AF3;
	Thu, 13 Mar 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUOQWDVp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463B267721;
	Thu, 13 Mar 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872590; cv=none; b=buS6rXhtfyorUufdFA9R1AAsEgzUeczMGhUkc/x/rscN9k9g/HUhimL6xRzBWz2i9C7Oe+uT2dhZ6XQlW4+98Cf5aYTsQTK41mqyO23mEWUXn9MZ4v/V8DZOR4Bx+uJmDFmj4U/2d2BVSx8CgNLIFXstajIdMIfoAczJ0rDLyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872590; c=relaxed/simple;
	bh=3R5NqPG75eCifry1xE8jCo+Ba/RPNsND3Th6ewF0DW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbJBe+/PMZmtXxKsJhn18ZUxwtkuvjw6WbOJVK15ot0cM6E8aRcpx8cvDpAXWdoLqojrWFy+QexSMiL2HEx4Fd9h4XW+FA8tbPNPiATRpf6fVFsB00c5giWV6Ql4ehLdZLW2mFKIe+CRNE+CN70NxFgEb6xGRopk+tre5M+qo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUOQWDVp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741872588; x=1773408588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3R5NqPG75eCifry1xE8jCo+Ba/RPNsND3Th6ewF0DW8=;
  b=LUOQWDVpcOi8PI2qbyByY+2qScKBOOZtthpREA7utobv+e4OSJ9vhNSy
   pYTVOP2t+jxFIuYYwDYJ8rF7EujzPCkqTyjUwbwv1AALqiB5O5vO5InMp
   Sr1Ij9n8iQoe1rHbCS7orbAiFaCcnpPdld8YplDbk/ZSiYbedVwldkH13
   4K756Ohf1jMeQ+rx7Zu9U+QMd9Tw+jcy0O8o/W5u58Nsn/Y0W7RoN7/aB
   Mlvpqqtr9Isa/ebhOt5eQ5EddubBZhhN6WQhY1KNoEdz4MOca5RO4sax0
   BNvSwae4hDe49XBZEqxYoHT9vpTgpuCvIMZop4JjI8IpDZrT82sPKe0PZ
   Q==;
X-CSE-ConnectionGUID: AmIDVn6mT9Sd1lrJ62tyPQ==
X-CSE-MsgGUID: v/kLCct7RkyfoMQuyGhNrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43119151"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43119151"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:29:47 -0700
X-CSE-ConnectionGUID: 04qS8wQPRn6wZVe4oTPTzg==
X-CSE-MsgGUID: 4xEfR6NSTcGJ84TSNnC6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120669500"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:29:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsid0-00000002BNc-0muS;
	Thu, 13 Mar 2025 15:29:38 +0200
Date: Thu, 13 Mar 2025 15:29:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <Z9LdwUVBOEx-Tbvr@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <c8899e8c535a1d93cd7588b7c160eb0fae5d26d2.1741849323.git.mazziesaccount@gmail.com>
 <Z9LQFqSweiV-zT3b@smile.fi.intel.com>
 <bca95d63-fb6e-4d6c-8ab6-df67f0e697e6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca95d63-fb6e-4d6c-8ab6-df67f0e697e6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 03:17:27PM +0200, Matti Vaittinen wrote:
> On 13/03/2025 14:31, Andy Shevchenko wrote:
> > On Thu, Mar 13, 2025 at 09:18:18AM +0200, Matti Vaittinen wrote:

...

> > > +	num_chan = iio_adc_device_num_channels(dev);
> > > +	if (num_chan < 1)
> > > +		return num_chan;
> > 
> > This is really interesting code. So, if the above returns negative error code,
> > we return it, if it returns 0, we return success (but 0 channels)?
> 
> Yes. I don't think it's that interesting though. Checking the devicetree
> succeeded while no channels were found. I think returning 0 is very much
> aligned with this.

Right, but as I suggested, let's follow already established APIs that return
-ENOENT and never 0 in similar cases.

> > Shouldn't we do *cs = NULL; at the case of 0 channels if it's a success?
> 
> I suppose you're right.
> 
> But, as you pointed out in review of the 05/10:
> > Usually in other similar APIs we return -ENOENT. And user won't need
> > to have an additional check in case of 0 being considered as an error
> > case too.
> 
> I don't know whether to agree with you here. For majority of the ADC
> drivers, having no channels in devicetree is indeed just another error,
> which I think is not in any ways special.

So...? (I see below your answer :-)

> However, for 33,3333% of the users added in this patch, the "no channels
> found" is not really an error condition ;) The BD79124 could have all
> channels used for GPO - although this would probably be very very unusual.
> (Why buying an ADC chip if you need just a GPO?). Still, this wouldn't be an
> error. (And I need to handle this better in BD79124 probe - so thanks).

ENOENT check is again established for optional/not_found cases.

> > (Under success I assume that returned values are okay to go with, and cs in
> > your case will be left uninitialised or contain something we don't control.
> 
> I see your point although I wouldn't be concerned with cs not being NULL for
> as long as number of channels is zero.
> 
> Anyway, I think it makes sense to simplify ~67% of callers by returning
> -ENODEV if there is no channels. The remaining ~33% can then check for the
> -ENODEV and handle it separately from other returned errors. So, thanks.

Not at all!

-- 
With Best Regards,
Andy Shevchenko



