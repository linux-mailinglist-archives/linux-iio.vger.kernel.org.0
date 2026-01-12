Return-Path: <linux-iio+bounces-27655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90FD14DCA
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 20:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62F10302BD33
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE7311C17;
	Mon, 12 Jan 2026 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lrj+AdOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F827B327;
	Mon, 12 Jan 2026 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244844; cv=none; b=bmGlGWKn4UKaqRd53MjQ/JXFsnBlzEOTq1jppGGZgQGH+KgyyMFvFTW/yirqAR1TFj/q2dzwqRyqfIUppHYKzFrvhoi9rH0qU03eujjxQiEncAmcamatxOvC8kOdIREeUTBAgdU4vmzLMbByj/yGGrQCXuUQPhC5ZMGIi+tG0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244844; c=relaxed/simple;
	bh=cm8ilyUoh3xtgcTiQcIyID35hTWfERtQ+ghgLmFFgsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnBlHuI3zxromDV9rZyDxzkV6c9gWClAa4CRPO1Q4hWeNyC5RjcKqjn8tfb33IVAjj9uL9aGn05I+UeDXCqRbQRjC565d5cWdgGyETIc5HRP5zyJ7A96Aa0AUssuHM2/go1iwoILT1AB1PchulrVTXxc+1xHHrCZ9r0OGwTfcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lrj+AdOE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768244844; x=1799780844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cm8ilyUoh3xtgcTiQcIyID35hTWfERtQ+ghgLmFFgsA=;
  b=Lrj+AdOEMhAHPlYU+SUx1maJWDnObVwYWyF/kiRo8B7Sdt+kgU4bAULT
   aInse8yz+pNg3hAgITZLz5dSrKB3pdtz+Yqyu9VvKl73xYM3vJL9mmrLX
   bsyshdaRFGsS+OCo+xandhEmdPusa5ejjKh6a0HCxGfTKAZFAY3YaCvQ8
   RQSWd47Fhc1y68ZXPEJPTA0+4lyIscQ47yQ/8JoQCL5qegsak62wy0FR4
   vYvwnUoad9X1pgcAlqEpk4rh78FU/wXoeG7pjcfTVkzmmsvKN3JIFf0HB
   0xQ893j3E81LsQ4ALYk8ODf+eGN+6sWUmZdDzKpVw5Ex368h4XgT/zQz0
   A==;
X-CSE-ConnectionGUID: iCwzP5tJQp2cW2HwCVBrBA==
X-CSE-MsgGUID: RLV1EFk+TZq0k1/KFu+7HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80977507"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="80977507"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:07:23 -0800
X-CSE-ConnectionGUID: YUEhW/TRQ4Cs7p4bnqVTNA==
X-CSE-MsgGUID: oL1HEsjRR1SgYReRS84LSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="209246253"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:07:20 -0800
Date: Mon, 12 Jan 2026 21:07:17 +0200
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
Subject: Re: [PATCH v5 3/9] spi: support controllers with multiple data lanes
Message-ID: <aWVGZWg7zLpeG3Kz@smile.fi.intel.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 11:45:21AM -0600, David Lechner wrote:
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

> struct spi_device {

> +	/* Multi-lane SPI controller support. */
> +	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> +	u32			num_tx_lanes;
> +	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> +	u32			num_rx_lanes;

This adds 72 bytes in _each_ instance of spi_device on the platforms that do
not use the feature and might not ever use it. Can we move to the pointer
and allocate the mentioned fields separately, please?

-- 
With Best Regards,
Andy Shevchenko



