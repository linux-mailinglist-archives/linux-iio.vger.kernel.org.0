Return-Path: <linux-iio+bounces-12810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D49DE863
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C3CB21D9B
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9062557A;
	Fri, 29 Nov 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cunP/LkB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8F1EF1D;
	Fri, 29 Nov 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890318; cv=none; b=Y5tbRSKgiqDpqw62CmXvgXdmQWiLuN1Ppa5flKV/laqioXXM7yi3YpImcP1gcyvsHrx8qS0brZ+4HSXUTke/qbcLwbVF3seAFhiMcoconSzFa05x4xAx/5kqKJHTJLuXvXc2iKmDzzLRP6oRCm9njHcKOG5ra2r56cSY8jll1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890318; c=relaxed/simple;
	bh=mFT6ar9zkgBbtQnta5Ao8zO4X9iU6Aq2Jw2N38M+ReY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH3QCsSG6dE2UbnjeYTKKsCOZDckkyaZZpKM4bOlGOR80FRvPVcZEdoX1Cl3wqiq3vxkXO1SZbrD/93I6gfKTDnB5A0cK7H3n8D7Kwa/fu1WylPaUeiw2FH4WrmsvCE3K1W0mdrF2wO8B2vcQJPeqwEjMIh1CNhTlssj3noTGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cunP/LkB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732890317; x=1764426317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFT6ar9zkgBbtQnta5Ao8zO4X9iU6Aq2Jw2N38M+ReY=;
  b=cunP/LkB+sCcgc7XivZ/WQSV54eAPp4GV0GRB5++W2np4pmx7YaQK7ie
   bTgveBRV411W8+zP3wZt0hIyVCncjhlkMODPfS7WUAWl517MGHPEYCsGk
   rjZ58PgyliwOy2jc9+lG8I6+S/h4BV52u8CDFyY5tkNVIiprLickiWC/v
   RGZf9K9WcorZSdrJDiliaVRVZx+itFCF12hkYkDP6qPOKGbK/ppD/QcpY
   Jgbvm63SgE3v2fz26lUd7CONzOZKkwxYB6FbGdYOIFvPcWB4YBcV11FT5
   tQfjQh3xWCSOiF4DjaHM9QRTfBJblZuHbz3PNkFUmN20OA3aNtFioXIBx
   A==;
X-CSE-ConnectionGUID: rC0C+IHoQ0egnywnCspx5w==
X-CSE-MsgGUID: Pqv16MF/StKS0E8HmODPlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="50649009"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="50649009"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:25:16 -0800
X-CSE-ConnectionGUID: dk9HYf3TRuymKWvAe4pmkw==
X-CSE-MsgGUID: wWjYr6TJR1WBkcaeWBGxdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="92972808"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:25:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tH1vh-00000002GC9-0Qfo;
	Fri, 29 Nov 2024 16:25:09 +0200
Date: Fri, 29 Nov 2024 16:25:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	0001-iio-light-Drop-BU27008-and-BU27010.patch@mva-rohm.smtp.subspace.kernel.org,
	0002-dt-bindings-iio-light-Drop-BU27008-and-BU27010.patch@mva-rohm.smtp.subspace.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Drop BU27008 and BU27010
Message-ID: <Z0nOxEtNk6APoNo0@smile.fi.intel.com>
References: <cover.1732819203.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732819203.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 28, 2024 at 09:34:54PM +0200, Matti Vaittinen wrote:
> Drop the support for ROHM BD72008 and BD72010 RGB sensors
> 
> I accidentally hit a BU27008 data-sheet which had a big red text saying
> "Obsolete". After a few queries I received a word that the ROHM BU27008
> and BU27010 RGB sensors were cancelled and never entered mass production.
> Supporting not existing hardware makes no sense, so it's probably best
> to drop the drivers and dt-bindings.
> 
> There is still a RGB sensor from ROHM called BU27006.
> https://www.rohm.com/products/sensors-mems/color-sensor-ics/bu27006muc-z-product
> Based on a quick glance this should be very similar to the BU27010. If
> someone wants to create a driver for this, then the bu27008.c might be
> worth looking at.
> 
> As writing of this I don't have the BU27006 at my hands, and when I
> asked about creating a driver for this IC from the HQ ... I got an
> impression that at the moment ROHM rather pays me for doing something
> else. So, currently I have no plan to add support for the BD27006.
> We can always dig the bu27008.c from the depths of the git, if it later
> appears such a driver would be a good idea.

The best series ever from you, Matti, on which I have
not a tiny disagreement with!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



