Return-Path: <linux-iio+bounces-25996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B201C3D065
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 19:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9B418874D8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66EF334370;
	Thu,  6 Nov 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfNd2SQo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0A345739;
	Thu,  6 Nov 2025 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452556; cv=none; b=Nj7o7bTAk+8w5cRyyZI0opiT66ZmzplccPQY4jRQMkcNXaMew3wwBKmOD/7c9hNeVwscVsF+BkccEB0662UhMS9A5nOSri4N1RqPo4tGD+rL4Ij95qlUG7QDhZyj043xtiIKbZoA9B8mKBXuELf+qb3ZFCBlCFSbL2vqgsHsyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452556; c=relaxed/simple;
	bh=hNzyfl0CnHrlr88t5Dg1HkyarJxi7c/5/NL1D8g3N7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1LBama2npCVHvozNIDcvmN4yYJGuI4UGFKBXG5+9iEN5OINOJlbWgAcmQVOzlA5m9uiGCt8qpExHhIAr3o2xrRuLfYJWkV5cvax2I3CsNUhTM5xGPg2UNRs50qFzh7f1I8o7vOIg6Si1ovL81ih7rtU7MuyIJRD6ro5YYntsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfNd2SQo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762452555; x=1793988555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hNzyfl0CnHrlr88t5Dg1HkyarJxi7c/5/NL1D8g3N7A=;
  b=QfNd2SQos7uHJ5CW/IqG/1FXbrUAaDdmw73WKwavKki1h2Xj1v6TZ2ZA
   hsl9wdnmONCpgOAn8D6Z65X04/8nLMF0eGCN3kZEnfXCfWTR4j4IMxy8a
   4Y/CffO2v+TbKC09QY1MkGyzhEgH4C9ERcuwZUq+zeZ/86/QsZPpK+peF
   XCGW1GWtT6ae0dDNEvIUx0XvZw4BF86lvsmMTa8AznG3skAVYvIYrVNo1
   vuXaUazsJ2IegLprFaeo/oQERD+CdeGcapxB1RyxzLFhJR+zZhQaoBmdL
   2Xa3tF98U3kayq0tVAoyqiSGO91m4wWbvHXeDvzC09n4bBSp7rxXsFA3m
   w==;
X-CSE-ConnectionGUID: kiaYowzSTH6xeCeuUm1sfw==
X-CSE-MsgGUID: ym5gAyPPSDGu48yD2F+vrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75209272"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="75209272"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:09:03 -0800
X-CSE-ConnectionGUID: FzAEk+tzRRa4MGEMkF8Utw==
X-CSE-MsgGUID: 4yTwBhVVSeKvMVDN3eYg4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187666481"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:09:00 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH4Pp-00000006DTl-2F1u;
	Thu, 06 Nov 2025 20:08:57 +0200
Date: Thu, 6 Nov 2025 20:08:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] regulator: Support the LTM8054 voltage regulator
Message-ID: <aQzkOQM6j6Q0sCJE@smile.fi.intel.com>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-4-fd1feae0f65a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-ltm8054-driver-v3-4-fd1feae0f65a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 03:11:49PM +0100, Romain Gantois wrote:
> Add a stub driver for the  Linear Technology LTM8054 Buck-Boost voltage
> regulator. This version only supports enabling/disabling the regulator via
> a GPIO, and reporting the output voltage level from the resistor divider
> values given in the device tree.

...

The blank lines below are in strange places.

> +#include <linux/array_size.h>
> +#include <linux/device.h>
> +#include <linux/device/devres.h>
> +#include <linux/device/driver.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +
> +#include <linux/errno.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#include <linux/regulator/consumer.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/types.h>

I expected to see

#include <linux/array_size.h>
#include <linux/device.h>
#include <linux/device/devres.h>
#include <linux/device/driver.h>
#include <linux/dev_printk.h>
#include <linux/err.h>
#include <linux/errno.h>
#include <linux/gpio/consumer.h>
#include <linux/math64.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/platform_device.h>
#include <linux/property.h>
#include <linux/types.h>

#include <linux/regulator/consumer.h>
#include <linux/regulator/driver.h>
#include <linux/regulator/of_regulator.h>

...


Other than above LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



