Return-Path: <linux-iio+bounces-27935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82073D3A076
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A065031BDDF4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1CD3382C1;
	Mon, 19 Jan 2026 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvQ5UY4V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C082DC76D;
	Mon, 19 Jan 2026 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808683; cv=none; b=hTTZ74HwP5WpNBaSLFoNjbM/y6NEhg2OXGS4eKhVjyCFXYCMO3bCfvvCt7DEXPIlm/augm3EAnedgfzqGAWL6hG5ovpCtrwH3mkdAUFwACcAF0BljGJJvpe0HFRP2RmBPP5H97tv4w+/qU3blhNppAm+f1KSzH93JyoUZ8LHHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808683; c=relaxed/simple;
	bh=BIo0jKLKMFAIDPL909fz1ND66fdoRIf541c3b307ars=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7CwlFFVrhuAX0tCqYMyxFeGc6i22uQH8suVrkB+vJnwHGGGz5pNvSdhjHDuykby7xnDWjlsSrJ/vLxSNn1++aoU3uDgRIe2PgSKhV+BQqBm0yy9v7ObTeSaJOlh7N+5CyY7vWwdHs7hsWQ7pgFqA2jqz6R8Z+Zr1+UCqces1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvQ5UY4V; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768808682; x=1800344682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BIo0jKLKMFAIDPL909fz1ND66fdoRIf541c3b307ars=;
  b=cvQ5UY4VQYVJu2vC8zgl/yqtCHepaO5N7aDygkQ77rtUcLxzXK/aEi8N
   0dG5ZzVWAB0OUkgiFTsM//7OvqvlmavAkWvejqNvkaWwqiIrOEB0CCbQg
   Otnpmnyk+3oHT7QpP+YM/cW4cvRLqO7mteipUwWVVCLZJ98df+PqlC3gR
   xG1AM97yXsuTBXtXRTYrJZzZuYB5qNMFjc5MeDsYKz0sVHNfByq55N1Ht
   0/G4II0FafjuDoHMGroCbDtA/qA2q5BOqXnm4s5pc0+/tCOTluaZAHw0F
   kJ+P4/m+2tG2tsp7iCar/7veDgV58nUddDL8TcYDy1YORVATtyzV6kEpq
   w==;
X-CSE-ConnectionGUID: 3Xwd6yS2TeqfX1fYjDV2EA==
X-CSE-MsgGUID: LmRXR7mBRaeARW2v/BDFOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70102679"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="70102679"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:44:42 -0800
X-CSE-ConnectionGUID: XlhRqnxOSaaCa5PXP0aiaw==
X-CSE-MsgGUID: Gftq0feoT9yh5s4avZC4kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="204947944"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:44:39 -0800
Date: Mon, 19 Jan 2026 09:44:35 +0200
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
Message-ID: <aW3g4zg3cRQRPD8R@smile.fi.intel.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
 <aWVGZWg7zLpeG3Kz@smile.fi.intel.com>
 <22a6a28c-0f03-4571-b2a0-8c9b82788b68@sirena.org.uk>
 <aWVNBPfv-R5erugo@smile.fi.intel.com>
 <8e12d2a5-3780-45af-a70c-4c112184fcc6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e12d2a5-3780-45af-a70c-4c112184fcc6@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 16, 2026 at 05:12:09PM -0600, David Lechner wrote:
> On 1/12/26 1:35 PM, Andy Shevchenko wrote:
> > On Mon, Jan 12, 2026 at 07:11:26PM +0000, Mark Brown wrote:
> >> On Mon, Jan 12, 2026 at 09:07:17PM +0200, Andy Shevchenko wrote:
> >>> On Mon, Jan 12, 2026 at 11:45:21AM -0600, David Lechner wrote:

...

> >>>> +	/* Multi-lane SPI controller support. */
> >>>> +	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> >>>> +	u32			num_tx_lanes;
> >>>> +	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> >>>> +	u32			num_rx_lanes;
> >>
> >>> This adds 72 bytes in _each_ instance of spi_device on the platforms that do
> >>> not use the feature and might not ever use it. Can we move to the pointer
> >>> and allocate the mentioned fields separately, please?
> >>
> >> Do we have real systems where we have enough SPI devices for anyone to
> >> care?
> > 
> > Define "enough" :-) To me even dozen of devices is enough (it gets almost a 1kB
> > of space) esp. if we are talking about quite low profile embedded systems.
> 
> We could make it u8 and save the same amount (on 64-bit systems) while avoiding
> the extra complexity of separate allocation.

Have you run `pahole` on this, btw? How big is it right now and do you fit
(aligned) with cache lines with this fields?

> I'm not particularly keen on requiring `/bits/ 8` in the devicetree though since
> it is unusual and often trips people up.

It can be transformed (to a smaller one) after reading
to a local (bigger) array.

-- 
With Best Regards,
Andy Shevchenko



