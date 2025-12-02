Return-Path: <linux-iio+bounces-26630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04320C9BD61
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A4D3A7C91
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFB23C4F3;
	Tue,  2 Dec 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTy0C4YL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F6221F1C;
	Tue,  2 Dec 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686699; cv=none; b=AUOmD4Ur88B0E9tkEGM6QNLAOYdwXPpy1zI0CleTfybYSFtJpySiifZqn0lyv6NjTXC0RvLse4ksXQ+KhQ+FUC73AWt0I/m8wldtoJcYGKZHPdsShWJoUdAiAPrSqgIZJgWgXmMPII5Vm26RBCx9tpYWSIhkh/HfsQSevh3n4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686699; c=relaxed/simple;
	bh=drmaHx8A3tfUo7PtrNFgvL/zaRUIypa5BMDzZXvuKsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s48cXCEWozTyPwDT3jqNcW834ruiBhlHE2BWIBlHbY4wwrITrWDzH06tMlHrmkhodIHPzsklzdV4Qe4hf4opL/jBWRoOfczaY26nzh6aoD4JOr/vVPk6waL0mtH2o1S1FzmoVmIHrkbdH6aYRb9xBkTRfIrTTcAl/onQRec97Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTy0C4YL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764686698; x=1796222698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=drmaHx8A3tfUo7PtrNFgvL/zaRUIypa5BMDzZXvuKsM=;
  b=eTy0C4YLiqp2AXBOgOVhUqbkA3qsYTBAVjLQxvOeHYPckmzOO0pXG4Y3
   Bl7TLvzxD1HZA4hkhFe4Gjqro002GiU1EtKUp4aKxx0rCGyeZDan5nntY
   9d5lcNTA1nXzKQ8wk9uB06UdRVXrzbGIJd1Ec3/Kh2gaClhupakKFxBjR
   /AWHbgepIbeL0KsUDPjzRQW4ptE2ahoemYuUFK5BT289Gi1pBYUz9WqDv
   s6Inarf9BJrLWSzI765c4rSzWMu7N4L3l3w8cITUss49uUtT6j+H+B+sE
   o6CkzVpBB2jrVqVx5oUF/NinlC9ZEglOmOzIvrFtnugmmiValkVHuLS5L
   g==;
X-CSE-ConnectionGUID: O6pyBbMER8eVTdGXO6oB3A==
X-CSE-MsgGUID: MCzNyJcZTE2KVGQ3SVoOzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66542199"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66542199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:44:53 -0800
X-CSE-ConnectionGUID: UmYuxgvTQ+uVdHnudGRgJw==
X-CSE-MsgGUID: imyvE0xcQjOgMjdd7h2rAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="231705342"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:44:51 -0800
Date: Tue, 2 Dec 2025 16:44:47 +0200
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
Subject: Re: [PATCH v3 2/7] spi: Support controllers with multiple data lanes
Message-ID: <aS77X7T50D8x6yZR@smile.fi.intel.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-2-34e05791de83@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-2-34e05791de83@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 08:20:40PM -0600, David Lechner wrote:
> Add support for SPI controllers with multiple physical SPI data lanes.
> (A data lane in this context means lines connected to a serializer, so a
> controller with two data lanes would have two serializers in a single
> controller).

I'm a bit confused. Does it mean the three data lanes require three
serializers?

> This is common in the type of controller that can be used with parallel
> flash memories, but can be used for general purpose SPI as well.
> 
> To indicate support, a controller just needs to set ctlr->num_data_lanes
> to something greater than 1. Peripherals indicate which lane they are
> connected to via device tree (ACPI support can be added if needed).

...

> +	rc = of_property_read_variable_u32_array(nc, "data-lanes", lanes, 1,
> +						 ARRAY_SIZE(lanes));
> +	if (rc < 0 && rc != -EINVAL) {

It's a dup check for EINVAL, see below...

> +		dev_err(&ctlr->dev, "%pOF has invalid 'data-lanes' property (%d)\n",
> +			nc, rc);
> +		return rc;
> +	}
> +
> +	if (rc == -EINVAL) {
> +		/* Default when property is omitted. */
> +		spi->num_data_lanes = 1;


...just move it here as

	} else if (rc < 0) {
		...

(and yes, I know that this is not so usual pattern, but it makes the code less
 duplicative).

> +	} else {
> +		for (idx = 0; idx < rc; idx++) {
> +			if (lanes[idx] >= ctlr->num_data_lanes) {
> +				dev_err(&ctlr->dev,
> +					"%pOF has out of range 'data-lanes' property (%d/%d)\n",
> +					nc, lanes[idx], ctlr->num_data_lanes);
> +				return -EINVAL;
> +			}
> +			spi->data_lanes[idx] = lanes[idx];
> +		}
> +
> +		spi->num_data_lanes = rc;
> +	}

...

>   * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
>   *	the corresponding physical CS for logical CS i.
>   * @num_chipselect: Number of physical chipselects used.
> + * @data_lanes: Array of physical data lanes. This is only used with specialized
> + * controllers that support multiple data lanes.
> + * @num_data_lanes: Number of physical data lanes used.

This split the group of cs related members. Can you move it out or explain how
does it relate?

>   * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
>   * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
>   *	(optional, NULL when not using a GPIO line)

-- 
With Best Regards,
Andy Shevchenko



