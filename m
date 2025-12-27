Return-Path: <linux-iio+bounces-27364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638DCDFE46
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20ED430115FE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D275D23EA83;
	Sat, 27 Dec 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehU11lE3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01953FFD;
	Sat, 27 Dec 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766848590; cv=none; b=fl7uPrIof+2RG88jANKmQrROlUaVJLLw6zMw/dYLmc6wYMRKNOlzIcXM/wyTP/SZQYFOYo0zL8iorZloj4nxlFSpqVRLqViCoEi0+JZZJZ8MIXRA5xemTliz64YbhketMLUl5Nf24aLgm7xULVNBwbTb2NhKuyaso0y3mv/fnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766848590; c=relaxed/simple;
	bh=+rLZi2iPTX2t43eFepfvGk+Luqnxm3IljjiQ/N/QqfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP1d2LIOHW5gOQnqqxaOa9HacPb8hPsFt6Sjx56r9dsPyVAF26CA1dLboQR2hmnjIDTTu64VzfSixfgt4V0vQ1Ha0LeWtLZCbo+z4CttXyN1GXb3HC2r2ZH/trylou1rkB32WVGLMqwb8aQxbHB+aN2dncpL+S4uMDgEIBk/7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehU11lE3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766848589; x=1798384589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+rLZi2iPTX2t43eFepfvGk+Luqnxm3IljjiQ/N/QqfI=;
  b=ehU11lE3RIF9TdtDPt5ibBUchU8eV/9K0C8v/A0Hnue+p+ZSq3XIL4xa
   8kHARukRYid97VNvmSMJinJYFFyRaCT7qFJ8PkGSXJODxe7cilBYkaSwb
   18zIdjxx4LGBa41fpW6eEn0iAJbQuwQ1PV9Ci2HvtQctmF6ZZTm1dbi7q
   yOVDD8kNzDSZcLHvZRQuDPdv189AX3L4B1NR4PrR8IZgFTExMihiimsxt
   Aj/BxcE4eVxa24xNqUi9OyyQIoB8M3pCGOwqPTSdOvoP2DQR35JSfTeHK
   twAC2GXViDyZRRNxNBSeqXzUdTkBpaJgfITXtvYf+RvwB4qHaK9vum24a
   g==;
X-CSE-ConnectionGUID: p73J2+a2Si2S+CrbQvHiGg==
X-CSE-MsgGUID: 5lPDXMqSTimf+WBIyqGXtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="79269552"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="79269552"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:16:28 -0800
X-CSE-ConnectionGUID: F8pPbWSeShqN4AcRn+seWg==
X-CSE-MsgGUID: y9ZgiCW5S36AqkwuzFL9iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="200586829"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:16:24 -0800
Date: Sat, 27 Dec 2025 17:16:22 +0200
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
Subject: Re: [PATCH v4 3/9] spi: support controllers with multiple data lanes
Message-ID: <aU_4RhfUlJ5R_inQ@smile.fi.intel.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-3-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-3-145dc5204cd8@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 19, 2025 at 03:32:11PM -0600, David Lechner wrote:
> Add support for SPI controllers with multiple physical SPI data lanes.
> (A data lane in this context means lines connected to a serializer, so a
> controller with two data lanes would have two serializers in a single
> controller).
> 
> This is common in the type of controller that can be used with parallel
> flash memories, but can be used for general purpose SPI as well.
> 
> To indicate support, a controller just needs to set ctlr->num_data_lanes
> to something greater than 1. Peripherals indicate which lane they are
> connected to via device tree (ACPI support can be added if needed).
> 
> The spi-{tx,rx}-bus-width DT properties can now be arrays. The length of
> the array indicates the number of data lanes, and each element indicates
> the bus width of that lane. For now, we restrict all lanes to have the
> same bus width to keep things simple. Support for an optional controller
> lane mapping property is also implemented.

...

> +#define SPI_DEVICE_DATA_LANE_CNT_MAX 8

> +	/* Multi-lane SPI controller support. */
> +	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> +	u32			num_tx_lanes;
> +	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> +	u32			num_rx_lanes;

This adds 8*4 + 4 + 8*4 + 4 bytes to the already big enough structure for
the rather rare use cases. Can we start doing it separately and use just
a pointer here?

-- 
With Best Regards,
Andy Shevchenko



