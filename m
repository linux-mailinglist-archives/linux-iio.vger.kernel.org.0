Return-Path: <linux-iio+bounces-15282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897AAA2F448
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69E218842EC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC7255E28;
	Mon, 10 Feb 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wnkcrlre"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D192586D8;
	Mon, 10 Feb 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206344; cv=none; b=UPz1pxo+8i5K+iNBLfo+M/bdp0RcqVzBPMXDUTBMEdwKnaSrodySFDWK6ALDhw4Y/9Foso6RN0NnSGR11hfL/+NhkfbKuzpswdgyaXr7wVus70VytwcWH5w0B9mBNyusxK5reNmYXoGbcPGsO2FmKxJ9vApE801qVluEgKmrul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206344; c=relaxed/simple;
	bh=Fq0nz+qJpFshRjC9OyZc9Qy66WzrIAZthe2Fsrt5qak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxWrAYrjTMxqNkiSa0wI1RmuXlUSiRtKM9FLFkxyvZgwKB8c/EqRXuxVUuAE3AaAak/HGJW53jkksJHz4XHUn9bDnGnQ+OyB7yvI8KrIb7y+DNAkejR4kSTE7jf6x5AVHhIbKeXmzZKG80eg/D2QzZbkF9bSGtYQetPC0mykuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wnkcrlre; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739206343; x=1770742343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fq0nz+qJpFshRjC9OyZc9Qy66WzrIAZthe2Fsrt5qak=;
  b=WnkcrlreHqfO+qwoK/P5y5xwFVVMn478zKm2SkDgQL0UqLO1JKiNA3Zo
   pNvAEs53fJixsY24AkWB2yIoe8SRkSoCbF9w3mMHhL9yBmtPC44/UQmLO
   CCnL6cFzPops7cDdFnEg0HB9WD+mEbP9JHxE5/7hoF/piLYo4jltUTIBF
   aZrCXKkrNDuKn0EiUD5C09fPufBlHeD+tNjJXV4zPIrxVNf4vI9HI3U4y
   iITad0mrxfNv/Fyah0i//V9TKFqYmk9ualoEu5CRzYXAu5Y0uTEZW8BlP
   3UM6a3XeqangCjragomjU96NWKmdUFgIeUwNV/rGG92pHGpDzor7WHe+b
   A==;
X-CSE-ConnectionGUID: nZ88tRsfRc+/WJn2YJtKBQ==
X-CSE-MsgGUID: qdfmsfdsSxSsdUzSkn8WKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57334255"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="57334255"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 08:52:21 -0800
X-CSE-ConnectionGUID: tdRaJw2FRe6OqFX167lc9g==
X-CSE-MsgGUID: 5tCAIJnSRUWFzFUo1rA+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149431797"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 10 Feb 2025 08:52:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 45C362F2; Mon, 10 Feb 2025 18:52:16 +0200 (EET)
Date: Mon, 10 Feb 2025 18:52:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v8 04/17] spi: offload-trigger: add PWM trigger driver
Message-ID: <Z6ouwG98_kIY0FxZ@black.fi.intel.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-4-e48a489be48c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-4-e48a489be48c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 07, 2025 at 02:09:01PM -0600, David Lechner wrote:
> Add a new driver for a generic PWM trigger for SPI offloads.

...

> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/offload/provider.h>
> +#include <linux/types.h>

You probably want also to have (in the comments the examples of the users)
device.h // dev_*(), devm_kzalloc()
err.h // EINVAL, PTR_ERR(), ...
math.h // DIV_ROUND_UP_ULL()
module.h // MODULE_*()
property.h // dev_fwnode()
time.h // NSEC_PER_SEC

> +struct spi_offload_trigger_pwm_state {
> +	struct device *dev;
> +	struct pwm_device *pwm;
> +};

-- 
With Best Regards,
Andy Shevchenko



