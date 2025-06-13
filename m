Return-Path: <linux-iio+bounces-20605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A7EAD90D1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 17:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AD1E3987
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A0D1DF73A;
	Fri, 13 Jun 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LL5LRNFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C301149DE8;
	Fri, 13 Jun 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827349; cv=none; b=s9+K4iSwGzFEkmLW0/5EgBEQGqvPPWJIZyQMKbrNnmkCDw7V7BALbGXsiHQoQblsQC3Liv1TlSQNOCmqUTY+URu0vDWYIsjMKTq/IZcKl+7m8GN5gVTypHXvAmfLptwxM9zS5pBLjLeJXdbGul9pdQ3dC5uf+oTj6VMiKZ0Povc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827349; c=relaxed/simple;
	bh=+jvCD2kowkTgOqSg81LszSYq2ncrCtuKus8a/WXzonI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx+ROeslW7sgf4KE7vueXcZmvhXUGU45OAi2nz23lk5O0cwb6xT54nORShNSSXsjlF5iRjLuhe8Z1F8aSYVPZmPmFUIfzBOCGgaQDCTvhBh2AWjE77qwjsiT6qgxAzFXSwrv4GxicGbL7JJqVYV+qLrdcBB/bzQRnQ5HvG2HKUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LL5LRNFx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749827347; x=1781363347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+jvCD2kowkTgOqSg81LszSYq2ncrCtuKus8a/WXzonI=;
  b=LL5LRNFxkK+n+uDitU2AODCGcui2GZmnT9ztDi0s3cNqhlJgM+zCilwL
   EsWUaaKQeYf1kaPCBtqmNNQu+U7iG2VFYa7hzLZXlLJ38XbQ1IAa6hXGg
   lyZabSP/gD++TzF9+aVAytY7yIfj9fH1s5sm7k04ineQHoelpAbNhwLZF
   jQ04LbtKQ87vXr4m5qpSCwIa6Q7dGKWBI2vMVeuFwHFqQMbAon4uQAb0L
   U5Ycm9dFUAZgBaD9H7g51d8YHBEp7immRoYSUZjakoectbiI5HBmZLVcM
   6XAOPbHKu7n4pXBngGKq+y3W1OC5Bbbx2u7hPDgvzqKyCzU5PdtB3Rv3L
   g==;
X-CSE-ConnectionGUID: PD5xtQstS8+SBLvNza0M0A==
X-CSE-MsgGUID: fJubu7CsSyydh+wYWiQGlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="74580021"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="74580021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:09:07 -0700
X-CSE-ConnectionGUID: ImMIdTIDRsC69PqAeUGuEg==
X-CSE-MsgGUID: yEqvY+VAR7iEFMmi7VNQHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="152617176"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:09:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ61d-00000006HNs-1Z1M;
	Fri, 13 Jun 2025 18:09:01 +0300
Date: Fri, 13 Jun 2025 18:09:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marek Vasut <marek.vasut+bmc150@mailbox.org>,
	Hans de Goede <hansg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
Message-ID: <aEw_DcqpCpcsBGd0@smile.fi.intel.com>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

Strange I don't see Hans in the Cc list, so added.
Thanks for the report and patch, my comments below.

On Fri, Jun 13, 2025 at 02:45:22PM +0200, Marek Vasut wrote:
> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
> which leads to bmc150_accel_core_probe() being called with irq=0, which
> leads to bmc150_accel_interrupts_setup() never being called, which leads
> to struct bmc150_accel_data *data ->interrupts[i].info being left unset
> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
> which depends on struct bmc150_accel_data *data ->interrupts[i].info being
> non-NULL, and which triggers NULL pointer dereference. This is triggered
> e.g. from iio-sensor-proxy.
> 
> Fix this by skipping the IRQ register configuration in case there is no
> IRQ connected in hardware, in a manner similar to what the driver did in
> the very first commit which added the driver.
> 
> ACPI table dump:

>         Device (BMA2)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
>             Name (_HID, "BOSC0200")  // _HID: Hardware ID
>             Name (_CID, "BOSC0200")  // _CID: Compatible ID
>             Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>             Name (_UID, One)  // _UID: Unique ID
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.PCI0.I2C0",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                 })
>                 Return (RBUF) /* \_SB_.PCI0.I2C0.BMA2._CRS.RBUF */
>             }

These lines...

>             Method (ROTM, 0, NotSerialized)
>             {
>                 Name (SBUF, Package (0x03)
>                 {
>                     "0 1 0",
>                     "1 0 0 ",
>                     "0 0 1"
>                 })
>                 Return (SBUF) /* \_SB_.PCI0.I2C0.BMA2.ROTM.SBUF */
>             }
> 
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }

...are irrelevant.

>         }
> "
> 
> Splat, collected from debian unstable, probably not very useful:

Oh my gosh, please leave only ~3-5 *important* lines out of this, or move it
completely to the comment block (after '---' cutter line).

This is requirement written in Submitting Patches.

...

As for the solution, are you sure the line is not wired at all?
IIRC Hans had a broken tales where it was simply forgotten, meaning
the Android / Windows driver simply hardcoded needed info.

If it's the case, it should be solved differently around PDx86 special quirk
driver for the cases like this.

-- 
With Best Regards,
Andy Shevchenko



