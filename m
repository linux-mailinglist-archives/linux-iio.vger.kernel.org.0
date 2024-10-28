Return-Path: <linux-iio+bounces-11484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC089B3593
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FF7B2214E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F2F1DE891;
	Mon, 28 Oct 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYGe6Fym"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0351DE3D1;
	Mon, 28 Oct 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131190; cv=none; b=eXZAYBasr9wMIuJnyF72rxjtUgh7HJiHGeflF2/1mUWvVrusx9YRE2uJBYicyoWVijH22sOYkDLxUzw12i76EAqO+8eh9U83wSbJ2p8kehU4u14iuHSH0UOgan/r44MXn7CrqHLodx9NExLcwfXlHzh6KQ8xhHE1e0fn1HW4eFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131190; c=relaxed/simple;
	bh=M0le9V9Kdnc+SoqVOHgbafA8bV44ev7rfgdQq7f2H2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvmp2HTDWTL3lghSihsA34cEwCO/LwYkGzlJhS9vvBOXlBzkn2kygWmRHEEwMcP6cK+sDpnu8zmAu4GviyH0tcs0m39U9YSxmlbUI/C1gIqZKuTfITNDfSpJuGPjYsQJJi4nzDTVQtw4JoBesgI2TquPqt5Ot7GJDR7w5xNAa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYGe6Fym; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131188; x=1761667188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M0le9V9Kdnc+SoqVOHgbafA8bV44ev7rfgdQq7f2H2o=;
  b=SYGe6FymWEYf0B/JlHLFHItK7+pdPGR8x+75GsTH8nrA1cRdxQ4nJws1
   CAIh98ooo75Uul53B41Wkswq8oYK+r0SIikvRRnmuiqHFY5tu8z8ktTok
   +B5edx/EDgVTVMF5lHOMtztXLhM0gyEjVnjgdaDZl/D5aVvbB/uqhAql7
   abiqCrmybLxPWQ5QWfz90Uh3DJe5ollGAx2xZ9c0VsM/R9baBXRo5ADHB
   QTWNjLPt/ju9RNPFhkUJF0Sn8qMjPO/TqvE2JqpTaVRk4NALc6vwJnMI1
   tKJPH+pvlh3PMRFGyZ9k04LpNtxDF4G+0wztHwUUq5N5ZK0PpiNOZkCiU
   Q==;
X-CSE-ConnectionGUID: CVYrT8BIRXyBecNTo2bfDQ==
X-CSE-MsgGUID: 1EtnO4bwS/mWsBV6wUnalA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29506433"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29506433"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 08:59:33 -0700
X-CSE-ConnectionGUID: iQc8wkRRTKWL3fpaCf50SQ==
X-CSE-MsgGUID: ov8Po5UBSmyDzG3bh9zQUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112480471"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 08:59:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5S9M-000000087nQ-3TE6;
	Mon, 28 Oct 2024 17:59:24 +0200
Date: Mon, 28 Oct 2024 17:59:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aren <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: light: stk3310: log error if reading the
 chip id fails
Message-ID: <Zx-03Era_8ulHjDb@smile.fi.intel.com>
References: <20241028142000.1058149-1-aren@peacevolution.org>
 <20241028142000.1058149-6-aren@peacevolution.org>
 <Zx-jj8FEldW6sG55@smile.fi.intel.com>
 <xcavh66uxpl2orehtlzsy4g4udr3p2yqsq5pyhmxdqdmnegsvq@jpomr2uuwspz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xcavh66uxpl2orehtlzsy4g4udr3p2yqsq5pyhmxdqdmnegsvq@jpomr2uuwspz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 28, 2024 at 11:29:35AM -0400, Aren wrote:
> On Mon, Oct 28, 2024 at 04:45:35PM +0200, Andy Shevchenko wrote:
> > On Mon, Oct 28, 2024 at 10:19:59AM -0400, Aren Moynihan wrote:
> > > If the chip isn't powered, this call is likely to return an error.
> > > Without a log here the driver will silently fail to probe. Common errors
> > > are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
> > > isn't powered).
> > 
> > The commit message does not explain why dev_err_probe() has been chosen
> > and not simple dev_err().
> 
> This function is only called from stk3310_probe, and this condition
> should propagate it's error, so it fits what dev_err_probe is designed
> for. dev_err would be pretty much equivalent just longer, like this:
> 
> if (ret < 0) {
> 	dev_err(&client->dev, "failed to read chip it: %d\n", ret);
> 	return ret;
> }

It's fine, the problem is the commit message in the patch. Please,
update the commit message accordingly.

-- 
With Best Regards,
Andy Shevchenko



