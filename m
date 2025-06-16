Return-Path: <linux-iio+bounces-20697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D3ADAB10
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 10:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268B33A7B85
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977DD211A15;
	Mon, 16 Jun 2025 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMTegmHZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE023522F;
	Mon, 16 Jun 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750063675; cv=none; b=aexve3sYoh9nCIHodEsQ7EKfWidcXc+qD+L+JhUod6jBFqA4E4G2PdM1VSOpqZteUDF6KpnkryeIifEtX7/e96yROLLBXDZK2ZHdmln1EaSdXRJ07eb2OlXmwu2CmZvNDeLnz3ksCeoj0nvup8fU8atQexSjYPX4RcI79Z9MBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750063675; c=relaxed/simple;
	bh=Jmw+LF/yWtvrkBOZ2hbKLwp4rJ8jMljTl1Iw26HP98I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnJgH0aGbs7BAoLs3ahrgHzUxmrMSPmt8opNJYk6LlFy2Of7V6y8gmWi24kJgikT0iWygj400EqIyjGNAj+MwYRvZCB8ulib/rZQsPUlc079a1Ne4f+3HMCzRo1oka+8xP+XXivcD4H9CQWOxIn3ngUxhEZ8IpSVK7RCFprOxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMTegmHZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750063674; x=1781599674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jmw+LF/yWtvrkBOZ2hbKLwp4rJ8jMljTl1Iw26HP98I=;
  b=QMTegmHZ01LY5UrRRB6DlH4DCkOJnpPQ4ijSD5pMNKvHSztotNmk9Ig3
   0bL891QzCkqTT7wgikwJu+GDdE+6AAdz7qVlATaE5OCCdB4Bv285c82vd
   0Zm4b8xdt5gSD36vdYFxNMKuhkQreBzLgta5DwUlKG4xw1p5Dewqetx+u
   TCVYuQiQ9qrLgacxAcWZXw9gI+TjIdeYqd9Tl/sXdWdkpGCKj3R1DAJKE
   NqkNv2IyaIsEtw+2Yp6X5ZGIIGo/w7LYSHu62k73u+61+b8nyrO2atikL
   GPOqBsXyKhmWWn6tPjooQCJiWi5iI9RRu+5VmlZMPe+0APOMNii1w/Ir/
   g==;
X-CSE-ConnectionGUID: kC0Gih4sSHW8PnJWDm/e8g==
X-CSE-MsgGUID: knB34gDwTe6h6tgcurk7UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62472285"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="62472285"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:47:50 -0700
X-CSE-ConnectionGUID: k9Brh6RfRuyve3qjkPmnxg==
X-CSE-MsgGUID: faX8jCxLQECduLo6MltvDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="153709859"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:47:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uR5VH-000000071XI-2Sv3;
	Mon, 16 Jun 2025 11:47:43 +0300
Date: Mon, 16 Jun 2025 11:47:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
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
Message-ID: <aE_aL5dGKZeKBu50@smile.fi.intel.com>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <aEw_DcqpCpcsBGd0@smile.fi.intel.com>
 <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 07:02:28PM +0200, Marek Vasut wrote:
> On 6/13/25 5:09 PM, Andy Shevchenko wrote:
> > On Fri, Jun 13, 2025 at 02:45:22PM +0200, Marek Vasut wrote:

> > > The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
> > > which leads to bmc150_accel_core_probe() being called with irq=0, which
> > > leads to bmc150_accel_interrupts_setup() never being called, which leads
> > > to struct bmc150_accel_data *data ->interrupts[i].info being left unset
> > > to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
> > > which depends on struct bmc150_accel_data *data ->interrupts[i].info being
> > > non-NULL, and which triggers NULL pointer dereference. This is triggered
> > > e.g. from iio-sensor-proxy.
> > > 
> > > Fix this by skipping the IRQ register configuration in case there is no
> > > IRQ connected in hardware, in a manner similar to what the driver did in
> > > the very first commit which added the driver.
> > > 
> > > ACPI table dump:
> > 
> > >          Device (BMA2)
> > >          {
> > >              Name (_ADR, Zero)  // _ADR: Address
> > >              Name (_HID, "BOSC0200")  // _HID: Hardware ID
> > >              Name (_CID, "BOSC0200")  // _CID: Compatible ID
> > >              Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> > >              Name (_UID, One)  // _UID: Unique ID
> > >              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > >              {
> > >                  Name (RBUF, ResourceTemplate ()
> > >                  {
> > >                      I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
> > >                          AddressingMode7Bit, "\\_SB.PCI0.I2C0",
> > >                          0x00, ResourceConsumer, , Exclusive,
> > >                          )
> > >                  })
> > >                  Return (RBUF) /* \_SB_.PCI0.I2C0.BMA2._CRS.RBUF */
> > >              }

> > >          }

...

> > As for the solution, are you sure the line is not wired at all?
> 
> No . It is some cheap mini-laptop , I have no schematics or any other info
> really .

> Note that I am not really familiar with x86 and ACPI, so there is that.

Yes, I understand that.

You can try to monitor the /sys/kernel/debug/pinctrl/*/pins files for any
changes that might happen on the sensor events. It might (help to) reveal
the IRQ line.

> > IIRC Hans had a broken tales where it was simply forgotten, meaning
> > the Android / Windows driver simply hardcoded needed info.
> > 
> > If it's the case, it should be solved differently around PDx86 special quirk
> > driver for the cases like this.
> There are likely two issues.
> 
> First, this driver needs to handle i2c_client->irq == 0 correctly if it
> should work without IRQ line, which the driver seems to indicate that it
> does. The current crashing the kernel is not the correct way of handling
> that. That's this patch, in some form.
> 
> Second, if this laptop has some IRQ line for this chip hidden somewhere,
> then it might need a quirk of sorts, sure. Is there some way to find out,
> without taking the thing apart and poking around with a scope ?

-- 
With Best Regards,
Andy Shevchenko



