Return-Path: <linux-iio+bounces-15281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE934A2F3E9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E485163F61
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E791E1C22;
	Mon, 10 Feb 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeBETZeE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9A156C6A;
	Mon, 10 Feb 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205918; cv=none; b=LtZughdLW1fkY+VJ+0g2HY7bMjtcyizjmGu3LJUX7btg5CrvrbVjLmXbzju/6rRa7rPj/No76rUbj++Zlk4RdkFXKp0nA7Fk7+QHGUt6hJobWcwUPnuT0dsYCJV9y+Cw379S6qcsWXBzMMcdL8dDbPU4eYNEkTicUEFpN/0fUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205918; c=relaxed/simple;
	bh=uWyvUsNMkIe7l8IREjf+iJ3w3iqoYDrAc20cPTNGVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT/hInj5wVWYblrgE+zek0BcsLiGFvjBR5EXAdYfsLEK65mJziI8klNzQYMlINRy5s7c+Idjg8bLqr7N0EFAx6f8gHWNjr8LNavkYXxKjAsy6qzS34Z9LLN2XqG7aSfkNCvucId1KRUj8BNAAGSSHi9XfCJZ1/chndA1hihaCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeBETZeE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739205917; x=1770741917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uWyvUsNMkIe7l8IREjf+iJ3w3iqoYDrAc20cPTNGVnQ=;
  b=PeBETZeESoHelGvy+cX5Bt9hnrhCgMX1b3H/osflfY62rTtg5GmALOIT
   R4Uzov6olRQkMkIKH+yx12YFr/pJQ4XdBjKTIchlbyTZd7xPowFT4TP5J
   /cyZovlUn1xMg4KHPlhglraSWjuJOpAW9xAK6ud+U9qYr7Ai7kFYZOTpq
   qptsPoDYKnJRlXG3IFxwmrMUMlD03S0cJG63fWXH5+00QCBrazhNgnrdQ
   pVw7b/M3of7kGdYaCp/8AdDbiFgishy5iipZhxkAhrDPHFc0WaArkSvYs
   N4u+WsfiABR9CXBiUa8HN1pWl8teSLhR1SjhPoP9zv5mWvkngCjn1Lf5H
   Q==;
X-CSE-ConnectionGUID: GNn+zzo+SO6E5RR7yGvs0A==
X-CSE-MsgGUID: uFSNj7NLQ++zpRQm1P9nmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43557632"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="43557632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 08:45:16 -0800
X-CSE-ConnectionGUID: cKWTUrckQNaRtUM1fN4juQ==
X-CSE-MsgGUID: KVe2obcwSierHj2UNINipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112088897"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 10 Feb 2025 08:45:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9563F2F2; Mon, 10 Feb 2025 18:45:10 +0200 (EET)
Date: Mon, 10 Feb 2025 18:45:10 +0200
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
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <Z6otFlsmEikIbI__@black.fi.intel.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 07, 2025 at 02:08:58PM -0600, David Lechner wrote:
> Add the basic infrastructure to support SPI offload providers and
> consumers.
> 
> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
> 
> SPI controllers with offload support need to implement the get_offload
> and put_offload callbacks and can use the devm_spi_offload_alloc() to
> allocate offload instances.
> 
> SPI peripheral drivers will call devm_spi_offload_get() to get a
> reference to the matching offload instance. This offload instance can
> then be attached to a SPI message to request offloading that message.
> 
> It is expected that SPI controllers with offload support will check for
> the offload instance in the SPI message in the ctlr->optimize_message()
> callback and handle it accordingly.
> 
> CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
> consumer and provider drivers should `select SPI_OFFLOAD` in their
> Kconfig to ensure that the SPI core is built with offload support.

(I know that this is now in SPI tree, but still we have time to address something)

> +++ b/include/linux/spi/offload/consumer.h

> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + */
> +
> +#ifndef __LINUX_SPI_OFFLOAD_CONSUMER_H
> +#define __LINUX_SPI_OFFLOAD_CONSUMER_H
> +
> +#include <linux/module.h>
> +#include <linux/spi/offload/types.h>
> +#include <linux/types.h>

> +MODULE_IMPORT_NS("SPI_OFFLOAD");

This diminishes the point of the namespaces. Anybody who includes a (dangling)
header gets namespace imported, which is not good. Same for other globally
visible headers.

(This is the main concern of this patch).

...

> +#ifndef __LINUX_SPI_OFFLOAD_TYPES_H
> +#define __LINUX_SPI_OFFLOAD_TYPES_H


+ linux/bits.h

> +#include <linux/types.h>
> +
> +struct device;
> +
> +/* Offload can be triggered by external hardware event. */
> +#define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
> +/* Offload can record and then play back TX data when triggered. */
> +#define SPI_OFFLOAD_CAP_TX_STATIC_DATA		BIT(1)
> +/* Offload can get TX data from an external stream source. */
> +#define SPI_OFFLOAD_CAP_TX_STREAM_DMA		BIT(2)
> +/* Offload can send RX data to an external stream sink. */
> +#define SPI_OFFLOAD_CAP_RX_STREAM_DMA		BIT(3)

> +/**
> + * struct spi_offload_config - offload configuration
> + *
> + * This is used to request an offload with specific configuration.
> + */
> +struct spi_offload_config {
> +	/** @capability_flags: required capabilities. See %SPI_OFFLOAD_CAP_* */
> +	u32 capability_flags;
> +};
> +
> +/**
> + * struct spi_offload - offload instance
> + */
> +struct spi_offload {
> +	/** @provider_dev: for get/put reference counting */
> +	struct device *provider_dev;
> +	/** @priv: provider driver private data */
> +	void *priv;
> +};
> +
> +#endif /* __LINUX_SPI_OFFLOAD_TYPES_H */

-- 
With Best Regards,
Andy Shevchenko



