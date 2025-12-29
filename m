Return-Path: <linux-iio+bounces-27414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95653CE726B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 16:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1852430004E2
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB28243956;
	Mon, 29 Dec 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0d2KWax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAC35965;
	Mon, 29 Dec 2025 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767020495; cv=none; b=uqwX4lBOdNJkG0Bkw7rtj/0dKAWh+iWJi5QjY9+ukwBJHz0eexaUzslQJdcRD9lqwFskF8NU5ERJqPFofPYXsTsCQ2Iv9EhzRhixclYq+tTejqi8CMARQzRa0Yisp0I8vHKdAHdSw8GMqo6tQVv5Ku7GFn3oQgSgCvcwQD2pvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767020495; c=relaxed/simple;
	bh=giwx6ZUeJkFhvjWfoHEZCkJ9gOi+3GLM08UE/eechLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbVYVwxr4QqoT4pGwkKa8olGFaXkMvnTC/SuRfv7Ff7Uh2rX1gPVNQZOvxAi889S8sFUPQHH+MsMUmbFtv9KeDn+jcYfUDQmzLV/uUKhCruoSr6GFoU6V44c7gDHHZLCrgrppzfL0/hlo2n1Ga1Wq0TGrKbkqvsHDv0rcRkxED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0d2KWax; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767020494; x=1798556494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=giwx6ZUeJkFhvjWfoHEZCkJ9gOi+3GLM08UE/eechLo=;
  b=D0d2KWaxBAhS2TCGL8sHeykKYBrtvYgHySN7mLmCvo6X4qbwj3fre6Sp
   Rrrg7iSUTmRJPYFUSNSoX5rGKNAoO7LcCBcXzF5WIQLcm4Ih11x2TNbg3
   WgokT4vPQj4lMlyjc4dI0tk32BoawFPWD7bPtzs4aW7vNbmTG1R2QhNho
   KeYvIpSwCA9NhHPrguw6cSM4xOkv7wicV4PiRS+oqmxCtFjYxn6AapXZk
   CJdfQJ3RTGDsDU8W0jsmxQo0Ck7W73EOjS+U93QT8t2zsrvPcVfYIIwbT
   0ZvU5XHhsmoG1boYViO4a7zPMmN3C5i6gYLtog0mKKsyZJKyz0Rfid7iu
   A==;
X-CSE-ConnectionGUID: EdkVU+9fRhu3pl2fpNSxNg==
X-CSE-MsgGUID: zSQ3GxtnStm5gK9aWaIpZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="68518623"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="68518623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 07:01:34 -0800
X-CSE-ConnectionGUID: h3OFWca4TQevuxL0VGcwGg==
X-CSE-MsgGUID: 0u+4anRhRqWI8ow1bmlBew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="224425086"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.31])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 07:01:31 -0800
Date: Mon, 29 Dec 2025 17:01:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aVKXyQRczcv64jUO@smile.fi.intel.com>
References: <20251207-honeywell_abp2_driver-v4-0-b52a4b96bbf7@subdimension.ro>
 <20251207-honeywell_abp2_driver-v4-2-b52a4b96bbf7@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207-honeywell_abp2_driver-v4-2-b52a4b96bbf7@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Dec 07, 2025 at 08:00:48AM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell ABP2 series of board mount
> pressure and temperature sensors.
> 
> This driver covers 113 different pressure ranges and units on
> both i2c and SPI buses.
> 
> The communication protocol involves sending two simple commands
> to the sensor and there is no register access or a memory map.
> For this reason the regmap API was not used.
> 
> The i2c address is hardcoded and depends on the part number.
> 
> Optional end of conversion interrupt control is present on the
> i2c variants of the chips.
> The EOC can also be defined for the SPI variants if a non-ABP2
> but compatible chip is to be driven.
> 
> Tested on two sensors (ABP2MRRT001PDSA3 and ABP2DANT001BA2A3).

LGTM, one minor thing below,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
> +				       dev_name(dev), data);
> +		if (ret)

> +			return dev_err_probe(dev, ret, "request irq %d failed\n", data->irq);

Just

			return ret;

as above call already prints an error message.

> +	}

-- 
With Best Regards,
Andy Shevchenko



