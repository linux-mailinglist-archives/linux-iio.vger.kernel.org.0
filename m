Return-Path: <linux-iio+bounces-17887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7CA82D3A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 19:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBF517FC5F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08E270EDF;
	Wed,  9 Apr 2025 17:07:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C83595C;
	Wed,  9 Apr 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218471; cv=none; b=AFIF/He7wm+/G8saP4lnoubopReE0Q3kELjVPwiFjYLFHNlZUGHG3t/XArVHt6rVJuDtN8y3a3ys8qNtI2Iz+iRX62NfQjg2F/NmKyTOYpmhNKKbNgA4hAcf6a2u7Cgub4DnZQhzEYtA3GajkVd/a3LT0E6bKSaWMOn1ivCZ7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218471; c=relaxed/simple;
	bh=5KdC9UJi/G+Mbx+/YKkMbJ5CpyMBOiyE15pwvCv36as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bps/F4mK+WheeS0/amzqAIV8YT+TTS0F8cQ+szG8tEysPryb6ipi4Ht1H5ADXs+n76GjRflds/d3garqE5c7vn6dbpbe0UqjYCG8pSF2om0mmf0Hd5CJ99bJVQpjxzlZS8kNBrkcXecVxRUsMaWLhk58o+y805JNvveqH6VpU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: HhqECDI+TMCLK8l9AzpW7A==
X-CSE-MsgGUID: 2D8M2a0zRDuua/+M/nowWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56372545"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56372545"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:07:49 -0700
X-CSE-ConnectionGUID: yGr5e5YxSkKbytzGsMXyrA==
X-CSE-MsgGUID: 9eyaHSfMSKq6x3B9l9oeBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128625028"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:07:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u2Yts-0000000AnwL-088Z;
	Wed, 09 Apr 2025 20:07:44 +0300
Date: Wed, 9 Apr 2025 20:07:43 +0300
From: Andy Shevchenko <andy@kernel.org>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: inv_icm42600: switch to use generic
 name irq get
Message-ID: <Z_apXw_HoD0EHHY-@smile.fi.intel.com>
References: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com>
 <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-2-dab85a0a7c2b@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-2-dab85a0a7c2b@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 05:14:32PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Use generic fwnode_irq_get_byname() for getting interrupt pin using
> interrupt name. Only INT1 is supported by the driver currently.
> 
> If not found fallback to first defined interrupt to keep compatibility.

...

> -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  			    inv_icm42600_bus_setup bus_setup);

If you use 100 limit, it fits now on one line.

...

> -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  			    inv_icm42600_bus_setup bus_setup)

Ditto.

...

> +	struct fwnode_handle *fwnode;

Do you need to include property.h?

...

> +	/* get INT1 only supported interrupt or fallback to first interrupt */
> +	fwnode = dev_fwnode(dev);

> +	if (!fwnode)
> +		return -ENODEV;

Unneeded check, the below will do it for you,

> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0 && irq != -EPROBE_DEFER) {
> +		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\n");
> +		irq = fwnode_irq_get(fwnode, 0);
> +	}
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");

...

> -	return inv_icm42600_core_probe(regmap, chip, client->irq,
> +	return inv_icm42600_core_probe(regmap, chip,
>  				       inv_icm42600_i2c_bus_setup);

This is now one line (81 characters which is fine independently on your choice
of the limit).

...

> -	return inv_icm42600_core_probe(regmap, chip, spi->irq,
> +	return inv_icm42600_core_probe(regmap, chip,
>  				       inv_icm42600_spi_bus_setup);

One line.

-- 
With Best Regards,
Andy Shevchenko



