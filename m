Return-Path: <linux-iio+bounces-18522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41771A97301
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686E77AA30D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504428EA6F;
	Tue, 22 Apr 2025 16:46:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B5EC5;
	Tue, 22 Apr 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340398; cv=none; b=QtND8avdLlA1P0nVoidDBJ59orjbTVBhR5JWMjZ+mpI9cO0vm5twuq5e67g/qi8oQxiNrGo9sYm34vWqy+8j4SDOx43s9zvs256aqf95qWqXrQ/O4lcmO2OFmoEakCr8qCGbyplaZGMZkYnAs+2ycdAFIMxr47J0y/ME0oTJwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340398; c=relaxed/simple;
	bh=APY464O4qEktr3qLUXmra9T6Ngn9Z0W6MxO6bYmyA8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCOi6u6qqIC6XsKXoAfE+JKiLZlphhoSG8lSfTyguLozAbyO76ZvIE2O0jFHRmEAYfN9iH0xQQtxriU1gh92qH24mK45bFZBabrkOMTIUYfd1b286kACmte71Yf01KwIEvsTD8CZf/uYbo51ASxYMqJi9Km2RatDhnbm3gJyCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: lAR9fY7oTOewj91sitGvyg==
X-CSE-MsgGUID: XqLKaA8dRNO0z+L7zLPLfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57569423"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="57569423"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:46:34 -0700
X-CSE-ConnectionGUID: iR7O+dteTAO3FgIgZ51IbQ==
X-CSE-MsgGUID: 9/cf9DuxSlit+M+ugccYJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="155266018"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:46:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7GlQ-0000000EmZO-3qDQ;
	Tue, 22 Apr 2025 19:46:28 +0300
Date: Tue, 22 Apr 2025 19:46:28 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <aAfH5IiVBLLE95ct@smile.fi.intel.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-3-94341574240f@analog.com>
 <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
 <efec7563-9591-4539-a154-bf486d35df0e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efec7563-9591-4539-a154-bf486d35df0e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 11:37:06AM -0500, David Lechner wrote:
> On 4/22/25 10:11 AM, Andy Shevchenko wrote:
> > On Mon, Apr 21, 2025 at 12:24:54PM +0800, Kim Seer Paller wrote:

...

> >> +#define AD3530R_INTERNAL_VREF_MV		2500
> > 
> > _mV (yes, with Volts and Amperes we use proper spelling).
> 
> When did we start doing that? No one asked me to do this in any of the new
> drivers I did in the last year, so I didn't know this was a thing we should
> be doing.

I remember a discussion for one driver a year or so ago. But I can't find
quickly a reference. The rationale is to be as closer as possible to real
world (physics). And, for instance, regulator framework does that already.
It's a pity not many people aware...

...

> >> +static const char * const ad3530r_powerdown_modes[] = {
> >> +	"1kohm_to_gnd",
> > 
> > kOhm
> > 
> >> +	"7.7kohm_to_gnd",
> > 
> > Ditto.
> > 
> >> +	"32kohm_to_gnd",
> > 
> > Ditto.
> 
> These are defined by sysfs ABI, so can't be changed otherwise it would break
> userspace.

Ah, okay then.

> Comes from...
> What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode

> >> +};

-- 
With Best Regards,
Andy Shevchenko



