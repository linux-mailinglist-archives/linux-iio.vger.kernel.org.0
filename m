Return-Path: <linux-iio+bounces-15346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2072A30E77
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 15:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45A1166C7F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BD2505DC;
	Tue, 11 Feb 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpE1hIUx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E924C694;
	Tue, 11 Feb 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284543; cv=none; b=D55pr56u9b6oYN48uWqR8TKldUIUnVh0rNwmufRCyY4iW8/+RF2nflfmKuPPVQPSLnjckIwuKH2GMtvn+a4cB3AI0SX6wBYwPAYo5E6v1q0ANx437PNU9OLXhENlb7SNepo3Wz0ea0Rgww92qnAaTR4ShI+WGfk65sGiWvJJgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284543; c=relaxed/simple;
	bh=be5IPlcg0yWtYg4BxPhA+ASzqCK0AMCZ+Lgk+HS3Ib8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgteu+IlhHKw8RHv5O7Wv3XiUz19SNOpq07M4Ai35CP+6pJOzQr3a2cY2jkyfZAViB044EYvUKL/7VJs+yDg8O2r4EJCLZ/WuD8mwdKs16pAtB6WN8172pogKsy9QOc4IJYD5PJaWIy2QR5ceAUmeB/Ay1ou/DcSa2kWNl9GUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpE1hIUx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739284542; x=1770820542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=be5IPlcg0yWtYg4BxPhA+ASzqCK0AMCZ+Lgk+HS3Ib8=;
  b=YpE1hIUxoHVqBabrVMJBCjDt+Qe9GNM3fD9LACYI0YfXgD3jPFO64EDf
   RH4JPk+k7i2OD5Nl4OT4N1fLUJiUloRFlzfb7cQFKFXj+LpgMPMeiCgiA
   MIBTT35H9ywYZvWChf8W2i4Evs0di17HQsFWVAeYfAL4Rek9csrLLgCoh
   737J0Q0jp1Pf1ev8pa/5GXIXLk+pGU8Sjss/rrcu6GZdjTOppNQ3pwo7r
   HA7l4vlCexzN1CWjcT3IXtTASuMK+UwBUG1UHVCIBqeijFs94wTR9trHC
   ul1fXQpgOibGCUfMV+88xzVJYIrmXLxj0/D6nML5SPe7Gkd/cyth++shr
   Q==;
X-CSE-ConnectionGUID: 6z3d6f5KRJ62lqdqhIGl7Q==
X-CSE-MsgGUID: lsFTbF4XRDONnEns0VGWrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="65260307"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="65260307"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 06:35:41 -0800
X-CSE-ConnectionGUID: sldVeuXkQfGDCtT2EtCQig==
X-CSE-MsgGUID: GSE/MADUQhK9nwiEDeAZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113012472"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 06:35:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1thrMM-0000000AWv7-1eJ9;
	Tue, 11 Feb 2025 16:35:34 +0200
Date: Tue, 11 Feb 2025 16:35:34 +0200
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
Message-ID: <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
 <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 04:31:45PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 04:29:33PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 04:20:50PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 11, 2025 at 01:00:08PM +0000, Mark Brown wrote:
> > > > On Mon, Feb 10, 2025 at 10:33:31PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Feb 10, 2025 at 05:48:00PM +0000, Mark Brown wrote:
> > > > > > On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:
> > > > 
> > > > > > > In this case, we specifically split up the headers so that the only time you
> > > > > > > would ever include this header is if you need to call functions in this
> > > > > > > namespace (i.e. struct definitions are in linux/spi/offload/types.h which
> > > > > > > doesn't import the namespace). So this doesn't actually seem like a problem
> > > > > > > to me.
> > > > 
> > > > > > Indeed - I can't see any case where a user would need the header without
> > > > > > needing the namespace.
> > > > 
> > > > > You are looking from the other end. What I'm telling is that anyone who adds
> > > > > a header, automatically gets a namespace. What's the point to have namespace
> > > > > if it won't easily prevent from (ab)using it in the code. I consider putting
> > > > > MODULE_IMPORT_NS() in the headers a bit weird.
> > > > 
> > > > Sure, but there's no case where anyone should ever be adding the header
> > > > without adding the namespace which does rather sound like the sort of
> > > > thing where you should just move the namespace addition to the header.
> > > 
> > > $ git grep -lw MODULE_IMPORT_NS | wc -l
> > > 651
> > > 
> > > $ git grep -lw MODULE_IMPORT_NS | grep '\.h$'
> > > 
> > > drivers/base/firmware_loader/sysfs.h
> > > drivers/iio/adc/ltc2497.h
> > > drivers/pwm/pwm-dwc.h
> > > ^^^ These ones are probably fine as they are not in include/
> > > 
> > > include/kunit/visibility.h
> > > include/linux/module.h
> > > include/linux/pwm.h
> > > 
> > > I believe these three are misuses of MODULE_IMPORT_NS(). Because one may add
> > 
> > _Two_, of course, module.h provides the macro :-)
> 
> And after looking into include/kunit/visibility.h it becomes only a single one.
> So, PWM is abuser of MODULE_IMPORT_NS() and this series added one more.

> > > a header just as a "proxy" one (copy'n'paste, for example) and we know that is
> > > real as we saw a lot of code that has semi-random header inclusion blocks.

And thinking of more realistic example when we want header and do *not* want a
namespace is the simple use of the macro / or data type from it without
actually relying on the APIs.

So, in case of the header structure like

foo_constants.h
foo_types.h
foo_api.h
foo_uplevel_something.h

The MODULE_IMPORT_NS() would make sense only to foo_api.h. And I still would
question that. As I explained that header may simply become a stale one or
being used by a mistake.

-- 
With Best Regards,
Andy Shevchenko



