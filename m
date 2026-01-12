Return-Path: <linux-iio+bounces-27657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A23D15114
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 20:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF29030433D1
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5F324B0A;
	Mon, 12 Jan 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gk4PYzyh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28833242C0;
	Mon, 12 Jan 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246539; cv=none; b=p0wUqHuO0IsWjfpI1YsMRvJMuMH0SWhMU1KvAgbOuRersKse/a8yD4vv8NTx4LGx5tZwgjG3//XiXLZJ9EJ4NVEfwFIGhBFcxmNMHKc6WmXL+6qctlbmnsFpHfN1LqFVk2XciErabbc7js4sCucc2wrFmq1mB3WMFafLfe6JQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246539; c=relaxed/simple;
	bh=dwnfhhlWwjKBzZ/++zJtBbcRr4tEH0QKns5wtabi5Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO86dwS1x7aykmXIHeP+h6VFpjW84b6/FaDM9Qnz5Z8D63eL73oIk3HcLbIrdqRaMgg4bWYD6bqsk9DLOWjm4c0IfHjW4KFHIrCq/5ociU+cYcYaE49/4I17zttrySVhJo31uxoDe4ZrZ/zmFsmdUMAN+huod1Mm21PR7Gfhn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gk4PYzyh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768246538; x=1799782538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwnfhhlWwjKBzZ/++zJtBbcRr4tEH0QKns5wtabi5Lc=;
  b=Gk4PYzyhbu8xLjFxLRD+DMknoSilGNPgOeXtGC+kjSEOZUTAEqI9Mgx3
   Q6ooGn8GnQsmux3XQyruhMR4em+KPj52F/quy4yzJO87HdEJUYe0uYtO2
   cuOvnZL3kQWhUrFoH6d2UWRSxffdizycs169pklZvKpm1ckEYe0VtUHvY
   2r0n0kSXgsSpiaYZ7r77HMnG53IQMymq39f2S+xWjkeU8GCAbmkF2gkWn
   N6nu140aqlC3TLu8t0d7Zyi4yfI3tlekRpIXogm7bFnG6oM3e+1aHQYTa
   JfEGkY1hFNpHa+O+kojn3yrou4BxVbu0EznSdv6WZ7Yiz5tSL7PB9nIS+
   A==;
X-CSE-ConnectionGUID: yiARljkAQPSeZ/raHA/pUw==
X-CSE-MsgGUID: 5Z5koySvRjilCVjZ2bbjTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="68533984"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="68533984"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:35:37 -0800
X-CSE-ConnectionGUID: Zviq7gKNSJqaRdB8e32U5A==
X-CSE-MsgGUID: ymTWk6OkRX6QRA5xQm/dUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="204577132"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:35:34 -0800
Date: Mon, 12 Jan 2026 21:35:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <aWVNBPfv-R5erugo@smile.fi.intel.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
 <aWVGZWg7zLpeG3Kz@smile.fi.intel.com>
 <22a6a28c-0f03-4571-b2a0-8c9b82788b68@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a6a28c-0f03-4571-b2a0-8c9b82788b68@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 07:11:26PM +0000, Mark Brown wrote:
> On Mon, Jan 12, 2026 at 09:07:17PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 12, 2026 at 11:45:21AM -0600, David Lechner wrote:

...

> > > +	/* Multi-lane SPI controller support. */
> > > +	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> > > +	u32			num_tx_lanes;
> > > +	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> > > +	u32			num_rx_lanes;
> 
> > This adds 72 bytes in _each_ instance of spi_device on the platforms that do
> > not use the feature and might not ever use it. Can we move to the pointer
> > and allocate the mentioned fields separately, please?
> 
> Do we have real systems where we have enough SPI devices for anyone to
> care?

Define "enough" :-) To me even dozen of devices is enough (it gets almost a 1kB
of space) esp. if we are talking about quite low profile embedded systems.

-- 
With Best Regards,
Andy Shevchenko



