Return-Path: <linux-iio+bounces-26506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E76C8D5CF
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 09:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752723AE925
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFA322A1F;
	Thu, 27 Nov 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/y7sx6v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8F31DDB7;
	Thu, 27 Nov 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232641; cv=none; b=cy+figEWh3gMv8oAhQRWOIZetjiNk8CtvsPAeK4gHX7CMkPlrPDD8ozpJhn+a+G146PjFIquwLqBOWjvgHlz0SBJZW3oLQqmIqh1PHF2wl6knF8UopQszwRgeftoeU7IrJUnvE5cVH2UmaMGOzJ+hxU/TKauNUa98N+ITNBGZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232641; c=relaxed/simple;
	bh=wN+SDkJtEzJZEZ1ON1s5JRaC0teZ4qPzw704oISKlBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I91pvBCnomkhLVvFvnC+LnppcyjinO+QIwIOZzkGBKoxJ6ou2bwCMacADdlZJGGmI++++hUqql1/jp66ynrZBAQxpQsgpOZrqB1/v2eIqskE7e+qrylRnM7n2HJMfC+LD8z1o93h/DVRYP20xFt6Yemu7nn/CFI38IiTlJ2y//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/y7sx6v; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764232639; x=1795768639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wN+SDkJtEzJZEZ1ON1s5JRaC0teZ4qPzw704oISKlBU=;
  b=K/y7sx6vRjb6wIVrBNnWQdpdeRDGosShDtvGmZG6NvX0/dvVhfjYCvkx
   BRGqgWDXAH/l0qmo2f9IQmLSrq6/3fraqW5pxKmQVLPGJiep2c28/nB66
   rRwPGkjU6O/3kqp7NbPZBhK7pOOFnLv7X6HPEjqVxRaOYMrQFwKfPZeWU
   ZAX8aErOO1A4Jlgb1l6wKM1Cd0RqxA6yPCgaP94qlcN/+beZ7fXLUWWyC
   2privGda5gVkqBcnOt+MVOCbt0REn+l/cGCT6gtyAvc0ZKKOdqYs0jSLI
   PpcJ2pdIZo6QuG5v8B6IWT1e6HGcM6sPmHCrE0kiA91YfVf9ZwjINn8EZ
   A==;
X-CSE-ConnectionGUID: X9NlB8b1SvmgA7pwsh4EhA==
X-CSE-MsgGUID: ECiJ7si/RXOybvZPXzM6ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="65282952"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="65282952"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 00:37:18 -0800
X-CSE-ConnectionGUID: UBXKB2MNTgGvWMF4PmJi+Q==
X-CSE-MsgGUID: 9p6dianJSCuJ09mmY9AuhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="224126214"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 00:37:16 -0800
Date: Thu, 27 Nov 2025 10:37:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno S? <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSgNuVyyA6AtxtKs@smile.fi.intel.com>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
 <aSRF-DL3rKjyFleg@smile.fi.intel.com>
 <aSSV4lxzatAFds5e@lipo.home.arpa>
 <aSSm3JMY3DSg1Nns@smile.fi.intel.com>
 <aSTJML3fxp0sSeCq@lipo.home.arpa>
 <aSTiFxAolJ0JeUTj@smile.fi.intel.com>
 <aSf3RUeghPcC80VG@sunspire.home.arpa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSf3RUeghPcC80VG@sunspire.home.arpa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 09:01:25AM +0200, Petre Rodan wrote:
> On Tue, Nov 25, 2025 at 12:54:15AM +0200, Andy Shevchenko wrote:

...

> > > > > > So, why can't regmap SPI be used?
> > > > > 
> > > > > there are no registers, no memory map, just a 'start conversion' and the
> > > > > equivalent of a 'read conversion' command.
> > > > > any reason one would use the regmap API in this case?
> > > > 
> > > > At bare minimum the commit message should have a justification for the choice
> > > > explaining all this.
> > > 
> > > I had the justification in the cover letter instead, my bad, will include it in
> > > the commit message instead.
> > 
> > It's good to have in both.
> > 
> > > > Ideally, try to find a way how to use regmap API. We have several weeks of
> > > > time for this exercise.
> > > 
> > > you did not mention why use an API designed for devices with registers and a
> > > memory map on an IC that has neither.
> > 
> > The regmap provides several facilities that we would like to use in the drivers:
> > - the generic interface to access to the HW
> 
> in general I agree that having bus functions behind an abstraction layer can lead
> to cleaner and less duplicated code in the driver.
> 
> however, afaict in this case I still have to use the exact same low level i2c/spi
> accesses and hide them behind a regmap_bus instead of an _ops struct.
> plus there seems to be duct tape to make things seem to be what they are not.
> so the complexity would just go up a notch.
> 
> sorry but I feel that this regmap iayer would not be a clean implementation.
> I might change my mind in the future of course.

OK.

> > - the common locking schema that allows to share the same regmap among
> > different drivers (depends on the functionality of the parts of the HW)
> 
> is it a good idea for anything external expecting a real regmap to interact with
> a driver that was made to mascarade using one, lock notwithstanding?
> everything about this particular driver is standalone.
> 
> > - debugging facilities are available out-of-the-box
> 
> in these cases I just use a signal analyzer and compare with the driver's output.
> just out of curiosity, you got any pointers on a non-blocking (asynchronous) bus
> transfer debug facility?

I am not sure I got the question right. The regmap has a trace events for read
and write, so it dumps all data goes on the bus. This is done synchronously and
it blocks for a few microseconds to collect the necessary (binary) date in the
trace buffer. I don't think this affects the timings of the real transfers on
the slow busses like SPI or especially I²C.

> > We have drivers in the kernel with two buffers in the same structure.
> 
> yup. some __align twice just like in my example, some __align just once, some use
> a simple buffer placed on the stack with no apparent alignment when sending the
> data.
> 
> I've been told during an older review that both buffers need to be aligned due to
> DMA-related requirements.

Correct, and this should be done for the buffers that are subject to DMA, PIO is
fine without that. Consideration of Tx/Rx split varies, indeed. And I'm not sure
that the authors of the drivers fully understand when and what alignment is
required. Jonathan once explained to me why only a single alignment is good and
second is not needed, but I forgot that, can't reproduce right now. It's
available on lore archive somewhere.

> as I mentioned before, in my case the SoC's spi driver always uses PIO mode even
> if DMA is also implemented. so testing my code always works no matter the alignment.

[..]

> > > 	struct {
> > > 		u32 chan[2];
> > > 		aligned_s64 timestamp;
> > > 	} scan;
> > > +	u8 spi_tx_buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> > > 	u8 buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> > > };
> > You told you read books about C language...
> > 
> > Alignment is a property of a single member and a data type in general. Each
> > field of each data type may have it's own (non-default) alignment along with
> > the object alignment.
> 
> I have a hard time following this paragraph so I'm forced to use my 'sorry
> English ain't one of my first languages' excuse.

OK. I forgot the context of the above, TBH.

-- 
With Best Regards,
Andy Shevchenko



