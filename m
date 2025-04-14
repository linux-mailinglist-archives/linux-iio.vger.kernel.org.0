Return-Path: <linux-iio+bounces-18072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF98A879F0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B5A3B100D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55033259483;
	Mon, 14 Apr 2025 08:14:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274B2F42;
	Mon, 14 Apr 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618459; cv=none; b=YX+2SLVh0Z9J5hMrpgOflyjAwJ8U8BgC2baohfGOliHRoypUOj4s+QF5LD/4OplGj0PEqcV6hyZX3QG6i14GFUZxgpuigU2wSrKFNLHQa5GHyK0EYUx8OdXmgfQwG/e9oabzuraj4rbAjAzJd1GCzlThHKCooryCU1rTO1ky8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618459; c=relaxed/simple;
	bh=J6Trq140Q0iTkvxaPJrRDVWEuf7oXfIoFVDn2k/JM7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZiEG3C2FZhZS74UflZQ3MQc5coTRYhgsoQlv4o7sxGC75dZp5lygpBIHdZ5hKhsVr1b1uuIa5Wb2ObFNL/gnP7EkF944qMj8JeVhghqQ/pjnjbzVTRhASIWhySS2O54w3YtUpnkZhOY8hnR4+zB5lcFYsCm+qd81jkOsX1NiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: J7aHdhggRdy8TUqz5+ZPLQ==
X-CSE-MsgGUID: YtsY+YGRSj+7WnQifhOcXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="63480395"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="63480395"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:14:16 -0700
X-CSE-ConnectionGUID: FDZb4DZwSoSYTIUFIHqiiQ==
X-CSE-MsgGUID: f1gDqjpoRwCHdDgMXxyQhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="134903477"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:14:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u4ExG-0000000CAqe-20vX;
	Mon, 14 Apr 2025 11:14:10 +0300
Date: Mon, 14 Apr 2025 11:14:10 +0300
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
Subject: Re: [PATCH v4 2/2] iio: imu: inv_icm42600: switch to use generic
 name irq get
Message-ID: <Z_zD0uvJn_Fz1SOF@smile.fi.intel.com>
References: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
 <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-2-19e4e2f8f7eb@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-2-19e4e2f8f7eb@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 10, 2025 at 05:39:41PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Use generic fwnode_irq_get_byname() for getting interrupt pin using
> interrupt name. Only INT1 is supported by the driver currently.
> 
> If not found fallback to first defined interrupt to keep compatibility.

...

> -	return inv_icm42600_core_probe(regmap, chip, client->irq,
> +	return inv_icm42600_core_probe(regmap, chip,
>  				       inv_icm42600_i2c_bus_setup);

It's only 81 character, I doubt it will be a problem to have it on one line.

...

> -	return inv_icm42600_core_probe(regmap, chip, spi->irq,
> +	return inv_icm42600_core_probe(regmap, chip,
>  				       inv_icm42600_spi_bus_setup);

Ditto.

-- 
With Best Regards,
Andy Shevchenko



