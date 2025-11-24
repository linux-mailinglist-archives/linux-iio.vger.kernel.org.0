Return-Path: <linux-iio+bounces-26439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC07C82C0A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38C33AD324
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 22:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2062F12B6;
	Mon, 24 Nov 2025 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AD3fgq99"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAE274FEB;
	Mon, 24 Nov 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024862; cv=none; b=ZHXXIdUbZoQ/i64ixGKHIb5vn/k9br7V0y6BvNE04TSzIOOcl9xn5VxLQO8Kmj5d1b5sp9EKuQ6IKngHGy/Kpd9Rqv41OFHM8S/PlLTwcv3nMrp3lQ8jksBbcw429EpPhwiSMIERjige3eY7Dc9jxM7slZyTKJld9l4/XmwO1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024862; c=relaxed/simple;
	bh=AzRUifYLrM+cB3aAMES2FpiiW0RYMnzFxQ5EUxME5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD7FJFSYoaebl7vFSPpb1QJSXL1BkyZwkG2a/uZ+k/r91Ce8tP2AAOp5zCKqa8DRNfq4fM2hHV6gnqZwtmaoC8l9IGuQn+yX2+J9t71sb93AKFiQ+dxfBV1CNYcOMpiB4Gr4m2TQg6alV8zQ9d/wZ2G9ZoUUB9TzvO6Kygbwe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AD3fgq99; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764024861; x=1795560861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AzRUifYLrM+cB3aAMES2FpiiW0RYMnzFxQ5EUxME5R8=;
  b=AD3fgq99HDvwB6lTe9lJ4PI8Cj8ePvpMI0EoGKPGLRHXlVWSgIXPxIkF
   VyEarEM4x5DYo2Fs1XPsVnKw5WPQ7qu2pdo3cOoirZj4oqYi9faeCXQsu
   LRb8ZBlOXB9Q9OEtQKP0BpTlM+smqF5w0gzRlURdNNTIjW1FcWpFQkVE3
   oW8CKjwApqmPeKSGuqwzdnNscRvaIuyOHjuQYjJB1kr13p0pLYvJOzJN+
   FdTFCA4gDmvBjLEfkia8um+vO6YQvg/h4hOXHH8NzCJajznNFfTTxqKWP
   lbQsJbw8gecZQN+1KNjtj/pQvfhrDyJIaPSHHXvMSTa1PNgp5QFqIvwno
   Q==;
X-CSE-ConnectionGUID: i2/CX6hqR8myt1fr394ZnA==
X-CSE-MsgGUID: 00RivnjDTICSfhUZTnFIXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="66067367"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="66067367"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 14:54:21 -0800
X-CSE-ConnectionGUID: 13jYHsYsQ8+ni+KIRodaeQ==
X-CSE-MsgGUID: DdfFKowCQY6sJMrK2TQpNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="223123563"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 14:54:18 -0800
Date: Tue, 25 Nov 2025 00:54:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSTiFxAolJ0JeUTj@smile.fi.intel.com>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
 <aSRF-DL3rKjyFleg@smile.fi.intel.com>
 <aSSV4lxzatAFds5e@lipo.home.arpa>
 <aSSm3JMY3DSg1Nns@smile.fi.intel.com>
 <aSTJML3fxp0sSeCq@lipo.home.arpa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTJML3fxp0sSeCq@lipo.home.arpa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 11:08:00PM +0200, Petre Rodan wrote:
> On Mon, Nov 24, 2025 at 08:41:32PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 24, 2025 at 07:29:06PM +0200, Petre Rodan wrote:

...

> > > > Why explicit assignments? Is it related to some HW register?
> > > 
> > > no registers, I just need to ensure the two arrays
> > > 
> > > static const char * const abp2_triplet_variants[ABP2_VARIANTS_MAX] = {
> > > 	[ABP2001BA] = "001BA", [ABP21_6BA] = "1.6BA", [ABP22_5BA] = "2.5BA", ..
> > > 
> > > static const struct abp2_range_config abp2_range_config[ABP2_VARIANTS_MAX] = {
> > > 	[ABP2001BA] = { .pmin =       0, .pmax =  100000 },
> > >    	[ABP21_6BA] = { .pmin =       0, .pmax =  160000 }, ..
> > > 
> > > keep being consistent and are resistant to later editing.
> > 
> > So, if it's pure software numbering, just drop assignments in the enum.
> 
> so you want the consistency check to be dropped? we have data in two
> different arrays and they must be kept in perfect sync. if I were to remove
> the assignments someone comes a few years in the future, inserts a new device
> in the abp2_triplet_variants array at position 84 out of 113, also inserts a
> new {pmin, pmax} into the abp2_range_config array accidentally at position 83
> and the compiler will be none the wiser.

That's why enum is there. Had I told you to remove it? No! enum should stay
as well as the explicit indexed assignments, assignments in _enum_ should go.
Just look around how other drivers do with enums which are not related to
the HW registers.

> just the day before I had to remove
> a variant because of a typo in the datasheet. I cheat and use a script to
> generate the structs [1], but if I had to modify them by hand, the
> assignments would make sure I delete the proper line.
> 
> am I proud of this? no, and I told you my preference. this is just a
> compromise that uses the non-specific match function and still provides a
> guardrail for future editing.
> 
> [1] https://codeberg.org/subDIMENSION/lkm_sandbox/src/branch/main/honeywell_abp2030pa/scripts/parse_variants_table.sh

[..]

> > > > So, why can't regmap SPI be used?
> > > 
> > > there are no registers, no memory map, just a 'start conversion' and the
> > > equivalent of a 'read conversion' command.
> > > any reason one would use the regmap API in this case?
> > 
> > At bare minimum the commit message should have a justification for the choice
> > explaining all this.
> 
> I had the justification in the cover letter instead, my bad, will include it in
> the commit message instead.

It's good to have in both.

> > Ideally, try to find a way how to use regmap API. We have several weeks of
> > time for this exercise.
> 
> you did not mention why use an API designed for devices with registers and a
> memory map on an IC that has neither.

The regmap provides several facilities that we would like to use in the drivers:
- the generic interface to access to the HW
- the common locking schema that allows to share the same regmap among
different drivers (depends on the functionality of the parts of the HW)
- debugging facilities are available out-of-the-box

> I also have a bughunt in the spi-omap2-mcspi driver related to improper CS
> delays in queued transfers, regmap will probably just be an extra layer of
> abstraction I will have to go thru :/

[..]

> oh, and
> 
> struct abp2_spi_buf {
> 	u8 tx[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> };
> 
> static int abp2_spi_init(struct device *dev)
> {
> 	struct spi_device *spi = to_spi_device(dev);
> 	struct abp2_spi_buf *buf;
> 
> 	buf = devm_kzalloc(dev, sizeof(*buf), GFP_KERNEL);
> 
> > Using devm_*() here is most likely a mistake. What is the object lifetime in
> > comparison to the used device?
> 
> I did think that placing this into the abp2_data struct would be a better
> idea, but I was not sure how to handle the alignment issue since there is
> already the read buffer there:

We have drivers in the kernel with two buffers in the same structure.

> #define ABP2_MEASUREMENT_RD_SIZE 7
> 
> struct abp2_data {
> 	struct device *dev;
> 	const struct abp2_ops *ops;
> 	s32 pmin;
> 	s32 pmax;
[..]
> 	struct {
> 		u32 chan[2];
> 		aligned_s64 timestamp;
> 	} scan;
> +	u8 spi_tx_buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> 	u8 buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> };
> 
> how do I make sure both 7byte buffers are aligned? can I __align twice in a
> struct as above? or should I align only the first buffer and make it 8bytes
> long?  I had a close look and even if the SoC's SPI driver supports both DMA
> and PIO, I've seen it pick PIO every single time while talking to my pressure
> sensor.

You told you read books about C language...

Alignment is a property of a single member and a data type in general. Each
field of each data type may have it's own (non-default) alignment along with
the object alignment.

...

Homework:
Why do we need both to be aligned? Do you get the idea what is this all about?

-- 
With Best Regards,
Andy Shevchenko



