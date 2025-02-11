Return-Path: <linux-iio+bounces-15343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5BA30E12
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE1B1662C1
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AA24CEE5;
	Tue, 11 Feb 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+30KbHg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21126BD81;
	Tue, 11 Feb 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283660; cv=none; b=kSkRjctjPITU4PfdY6ERWFKNelXQfkxRG4vji21YH2GdfLbpAUuCKFFWcW/6LQ0BUugqPHChGozh3cCbhRI4CAc9Jv4vEzZwCGP7pWrpV0XXnufJkeqRCTRF+kg4koh3xnYYUPefFjZril+cy/Kda7hx8Er4o4KhpBHzJqN7zQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283660; c=relaxed/simple;
	bh=OYsXNePOc28HVCwdFOtd1/2ZJAauSegfz82bvBw887Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKDKXqMqToBFhMqzOzn2NjQuOHcmndplSkH8Xf/cXacB7671xwecGwV2+d5wP/esFRmeX3FvK7C0qvc2mjmLUyTAdOGaAhyzYtrNCic5HnTAZtjd3jdFpOAZn7WxOPjAiKs3c0e4tqIagaAzSHZGr4KzYQYo4xSf3okTzwcll3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+30KbHg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739283659; x=1770819659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYsXNePOc28HVCwdFOtd1/2ZJAauSegfz82bvBw887Q=;
  b=J+30KbHgKTTvQYEaDG+dnZCF2E5BPmPIAW+asR+KcfjKv7cRhVwDVxBD
   1+SaMv5oizz9bBiD4k3pSiB7tuDd7l5IwWtXNPzpuL4njBBLWI5+zLs4G
   dTK0nusEPDp9u47jfdYl/caxb5Ew7D8vAUJ7nrmUcas0JNqF9pSJ/THgA
   rCxCkB7Ej/BDAoSZsol43DdylLt7KhBVw/I5nImLrovAsQYa74QURcAGE
   /peajsmam02x0ZJmzI2O83NjqzAhujwUrhsI/hhFgibKl1VEocaFDCSst
   vht0gUDfp43uPccHByNWFP5IPnS93uQz3Tr6tgwCgY0yJaC99Dqm1Nw0i
   g==;
X-CSE-ConnectionGUID: H0pWMYZRSF6AfDfOBmN6sw==
X-CSE-MsgGUID: BljAkxR6QBuNqtjyMhiZmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57441068"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="57441068"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 06:20:57 -0800
X-CSE-ConnectionGUID: hy+Y1dg0QiW7iXFxXF5slQ==
X-CSE-MsgGUID: r7ETOtSSQ6u5ydEmJV737A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113009984"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 06:20:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1thr86-0000000AWdo-1xHY;
	Tue, 11 Feb 2025 16:20:50 +0200
Date: Tue, 11 Feb 2025 16:20:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
 <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 01:00:08PM +0000, Mark Brown wrote:
> On Mon, Feb 10, 2025 at 10:33:31PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 10, 2025 at 05:48:00PM +0000, Mark Brown wrote:
> > > On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:
> 
> > > > In this case, we specifically split up the headers so that the only time you
> > > > would ever include this header is if you need to call functions in this
> > > > namespace (i.e. struct definitions are in linux/spi/offload/types.h which
> > > > doesn't import the namespace). So this doesn't actually seem like a problem
> > > > to me.
> 
> > > Indeed - I can't see any case where a user would need the header without
> > > needing the namespace.
> 
> > You are looking from the other end. What I'm telling is that anyone who adds
> > a header, automatically gets a namespace. What's the point to have namespace
> > if it won't easily prevent from (ab)using it in the code. I consider putting
> > MODULE_IMPORT_NS() in the headers a bit weird.
> 
> Sure, but there's no case where anyone should ever be adding the header
> without adding the namespace which does rather sound like the sort of
> thing where you should just move the namespace addition to the header.

$ git grep -lw MODULE_IMPORT_NS | wc -l
651

$ git grep -lw MODULE_IMPORT_NS | grep '\.h$'

drivers/base/firmware_loader/sysfs.h
drivers/iio/adc/ltc2497.h
drivers/pwm/pwm-dwc.h
^^^ These ones are probably fine as they are not in include/

include/kunit/visibility.h
include/linux/module.h
include/linux/pwm.h

I believe these three are misuses of MODULE_IMPORT_NS(). Because one may add
a header just as a "proxy" one (copy'n'paste, for example) and we know that is
real as we saw a lot of code that has semi-random header inclusion blocks.

-- 
With Best Regards,
Andy Shevchenko



