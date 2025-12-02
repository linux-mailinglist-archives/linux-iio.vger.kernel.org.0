Return-Path: <linux-iio+bounces-26635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A15C9BDD9
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45AD74E3640
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B5229B18;
	Tue,  2 Dec 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2KnsODR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA52AE70;
	Tue,  2 Dec 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687234; cv=none; b=Imiqnxogy72O6M2fBGvC+n+t21cIDtOmUJDIisfovWUj7hUNOPy6hGEdr0gdJIPtmAZyjstuGWjcGV9LS0DwxAyR+VubFN0PqWgi2bMZyCDlg3pDy4O3XitGLoA8VDqsDyPuRgj9cecMl/P2qdjqJCAC23ujEuCdcLhCumcwPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687234; c=relaxed/simple;
	bh=ZGt1Pe5JR1YW4m3BQHJHhBk4Rci2V5m+VGZ9lqChVzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NykmMk3Or8fV/mpICPEvbQg0vRUxPt6pHic3bIrbmTwHpl4Mqvx6Z9ojvVWQ4mMovETV+CiwMaZSUhwMUjttrslF8pznqFtBdOMV56GujGypkFq/SnDRd/iGCge/9kjAo3yYBHFvmv+MQ0u/oWRbBr6NhWSDbc1SXwD23P45CrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2KnsODR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764687234; x=1796223234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZGt1Pe5JR1YW4m3BQHJHhBk4Rci2V5m+VGZ9lqChVzA=;
  b=n2KnsODRbhIGHEI/4XRplNyLlw+QhPyV3K6tzcxEUEW4nBs4GVn9K//a
   wlo39+gm1rO09iNRwVhylFW157xZnGX9xECGkXmORG1VqyIhcP1jKGsq9
   Zr7vIPCtrEZdJk5dZ381cpDxySrDlaza/pP1nTRo83WRNuYawFSm4+EEa
   hYWllMmc3EzI/HGrEnGjMVFTkyAym+k0JbYWihGMGFE5PQKP8SvxtoQEP
   VEUOw2/6P8JThybq/DQPoyeWkUIbbmLT71mD6TDMMhC1eXrQGCtg4InU5
   fk+m/IkNSDsZrw0SJG8P4lvmY+OPo/u2xouNV/f4k/eI1iXmSJCKQl+e4
   Q==;
X-CSE-ConnectionGUID: 88KZdDC5RKK6ThtQc66rwg==
X-CSE-MsgGUID: 48f0rJc2QC6QXB++fJLo/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66369736"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66369736"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:53:53 -0800
X-CSE-ConnectionGUID: MxRLgOfaTTKqtmrCmYRNhg==
X-CSE-MsgGUID: 4KaIYwXlRomnuCRb8sYZjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194276740"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:53:49 -0800
Date: Tue, 2 Dec 2025 16:53:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/7] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Message-ID: <aS79ex5Konr_EeMA@smile.fi.intel.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 08:20:42PM -0600, David Lechner wrote:
> Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.
> 
> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
> reading from simultaneous sampling ADCs that have a separate SDO line
> for each analog channel. This allows reading all channels at the same
> time to increase throughput.

...

> +static u8 spi_engine_all_lane_flags(struct spi_device *spi)
> +{
> +	u8 flags = 0;

> +	int i;

Why signed?

> +	for (i = 0; i < spi->num_data_lanes; i++)
> +		flags |= BIT(spi->data_lanes[i]);
> +
> +	return flags;
> +}

...

>  static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
> -	struct spi_transfer *xfer)
> +				struct spi_transfer *xfer, u32 num_lanes)

Side note: this bool parameter makes code harder to follow. And now we have
pointers and integers/booleans to be interleaved. Perhaps reconsider the order
of the parameters (and ideally get rid of boolean by making two distinct
functions?).

...

>  	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
> -	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {

But this includes v0 as well!

>  	}

-- 
With Best Regards,
Andy Shevchenko



