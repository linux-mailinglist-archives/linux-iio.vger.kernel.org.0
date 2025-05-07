Return-Path: <linux-iio+bounces-19241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A3AAE123
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9C4986B2E
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445CD28B501;
	Wed,  7 May 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmvpqyfj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FF28B410;
	Wed,  7 May 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625461; cv=none; b=iGdwaq6iWg/YTKWlWveqaCaEr6odgzLobCLKa2ywKz4h1Zzld53f8Fzv40qbcIE0AStddgM87zoswEwq7jje4RvOS7rVcHwd6Ior+kAPF5ct7LHJ6dzT74dMYldeWXByYXPS0ytPOksjhQ6kaJ+9nEawRLAq04m3qvggYKI+4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625461; c=relaxed/simple;
	bh=rSpURVrjit/mrzrwpNmEyjo2cuH8soOOQFNb9VBvgGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFJpWS8nLCxDwWyChLyJXvkGMRoo+45tYrRZY7TETl0CESsFzZ5wuVWK9nqIiF/53DewTBZEnrq9YGKOjITThWPn5z3aB8CPiI8A47/6t13fXeoQ0ecUlJ+zvxPDxCL5Qfv9IqUq90EhC9Gc7ryz4iJB7xiAibYCvJztWpOvXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmvpqyfj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746625459; x=1778161459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSpURVrjit/mrzrwpNmEyjo2cuH8soOOQFNb9VBvgGc=;
  b=gmvpqyfjsBqbTYA4e1HAQ9kwmRAUwJchjJLnTkZ9OK7IUL5bjCLCXRhS
   OSPzLupdukAWA/voUtnP7uEIUtNGUW1Wh5d3DfpcfSvcbdFL64La5Ewga
   nFvtYFe90IyPutmG0EKCCn6TtSU0t6Namm1zjJ8/Ktx7RF4ycPg9L8+gy
   NNBcrHY+SAIfil1nSylRkpWgbc/Z6Zr30Ubb8Cd2GM+BifXVN5aIPm/mS
   md4bSRUnHrAajKALeXvRafEFTa9PSe0yC0PJ4PwvGGTDE4Wl+nZDAY59o
   osk+fWEa1iJ4RLvtDc0mfVh7my8RAjf1lm2AFMPHnZJgVa2/gLTv8f7Mq
   A==;
X-CSE-ConnectionGUID: tbKPqzJ6SE6IHi9rs+InfA==
X-CSE-MsgGUID: qFWHwrqMR9WPnDyTccTK8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48435696"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48435696"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:44:18 -0700
X-CSE-ConnectionGUID: s43Q+yhGTJykE/94v+uJpQ==
X-CSE-MsgGUID: 9GJaQoJrRRK3YdsAg7QJ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="141159330"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:44:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uCf4D-00000003kDn-3fUr;
	Wed, 07 May 2025 16:44:09 +0300
Date: Wed, 7 May 2025 16:44:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, alisadariana@gmail.com,
	olivier.moysan@foss.st.com, tgamblin@baylibre.com,
	eblanc@baylibre.com, antoniu.miclaus@analog.com,
	gstols@baylibre.com, ramona.nechita@analog.com,
	matteomartelli3@gmail.com, marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <aBtjqYNTJ_kFGd2a@smile.fi.intel.com>
References: <20250505092600.962675-1-j2anfernee@gmail.com>
 <20250505092600.962675-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505092600.962675-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 05, 2025 at 05:26:00PM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> for independent alarm signals, and all the threshold values could be set
> for system protection without any timing delay. It also supports reset
> input RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

+ time.h

> +#include <linux/types.h>
> +#include <linux/unaligned.h>

-- 
With Best Regards,
Andy Shevchenko



