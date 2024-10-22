Return-Path: <linux-iio+bounces-10943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED449AB473
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8601A284F22
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A21BC067;
	Tue, 22 Oct 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJSooZUE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91EF256D;
	Tue, 22 Oct 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616051; cv=none; b=FSManAzXfl5xcBIlewrZsxW0+6KH3x84p7uG757soA2EdYhZPU12KNuqFVuQnMSf1ALFg9WPmW8YmN1u+Qxs+PxRBeXFjK8MNhiwUOyeYCiqMWIQOUMWNZucDekkqXp7SSKvrN4p22GF/hUZqmZmZXmIVKUBYAwhB6WS4M0Nj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616051; c=relaxed/simple;
	bh=21FGDlkDZDMyZ5GJ6BJz6Gt8X4VrzWOYX6AaQwHE7IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE/kvF2zDE530RqBNzQOi1j2xvvun0Sn04i0CPQB3oy67w4gqG//5NIx69a5yXignVuYg59jNsh3ZrZkRGM4y5XOkUHxWgQGFnfNIi6t69xoyzFe/Bs3F9ZR2Voe0ieniNpIkDDQS7grxQRbXGHfkrcdqTLUySQv7RDmHn077l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJSooZUE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729616050; x=1761152050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=21FGDlkDZDMyZ5GJ6BJz6Gt8X4VrzWOYX6AaQwHE7IY=;
  b=LJSooZUECVCZNtwLe94I02NTTQyeuqOb1FFrpGcUBJwbSPwVGCwvArMF
   QMjccfbQ4qPY9k31Cs1geASWfVljjE79eNUF7Uk8y4Z62b3e950UjGk7L
   7HgbeNu16XDb4wSDqzBPyXXrYeVu8pprrndTmt4bSCpky9d4oYaOVSkQx
   BfYhPgA91n7ftRoNwIuSHEsxdTS5zQY2AXNKOXc0HrXYXwlUMMWyoCI8X
   f01S6sNha6MSjBWDSxGOmoqFmI5V/1UHJyldPVJLA9eivNYWQl8reJROm
   JvSwYnlqr2g3VCyRgjck9NpvP164h56+JOs9QKUQUjs43aF3z6f09CyPK
   g==;
X-CSE-ConnectionGUID: QJKsr1GoQiahiMjtaq/nsw==
X-CSE-MsgGUID: o+UFr4bNQGetv/GVgNzuag==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33092301"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="33092301"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:54:09 -0700
X-CSE-ConnectionGUID: eEdBCSfSRS2QY5tcIcJjHw==
X-CSE-MsgGUID: wDFEbFreQGieR2D1CE4V0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110751317"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:54:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t3I8x-00000005vZC-1mSW;
	Tue, 22 Oct 2024 19:54:03 +0300
Date: Tue, 22 Oct 2024 19:54:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justin Weiss <justin@justinweiss.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	Alex Lanzano <lanzano.alex@gmail.com>
Subject: Re: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
Message-ID: <ZxfYq1Eo2xhVhIei@smile.fi.intel.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
 <20241020220011.212395-5-justin@justinweiss.com>
 <87msiwm90s.fsf@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msiwm90s.fsf@justinweiss.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 22, 2024 at 08:50:43AM -0700, Justin Weiss wrote:
> Justin Weiss <justin@justinweiss.com> writes:

...

> The ACPI IDs with device pointers are here:
> 
> > +static const struct acpi_device_id bmi270_acpi_match[] = {
> > +	/* OrangePi NEO */
> > +	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
> > +	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
> > +	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> > +	/* GPD Win Max 2 */
> > +	{ "10EC5280", (kernel_ulong_t)&bmi260_chip_info },
> > +	{ }

Cool! But please, keep them alphabetically ordered by ID.

Can we push OrangePI NED to go and fix ACPI IDs eventually?

> > +};
> 
> I pulled DSDT device excerpts for the GPD Win Mini (which uses the
> BMI0160 ACPI ID, even though it has a bmi260) and the OrangePi NEO
> (which uses the BMI0260 ACPI ID).
> 
> I couldn't find a shipping device with a bmi260 using the 10EC5280 ACPI
> ID. Some prototype devices with the bmi260 may have used them:
> https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/
> 
> I can remove that ID from this changeset for now.

Yes, please do not add anything that has no evidence of existence in the wild
or approved vendor allocated ID.

> GPD Win Mini:

Add short parts of these to the commit message, or better split these to two
patches each of them adding a new ID to the table.

See below what I do want to see there (no need to have everything),
i.e. I removed unneeded lines:

> Device (BMI2)
> {
>     Name (_ADR, Zero)  // _ADR: Address

My gosh, can this be fixed (seems rhetorical)? The _ADR must NOT be present
together with _HID.  It's against the ACPI specifications.

>     Name (_HID, "BMI0160")  // _HID: Hardware ID
>     Name (_CID, "BMI0160")  // _CID: Compatible ID
>     Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>     Name (_UID, One)  // _UID: Unique ID
>     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             I2cSerialBusV2 (0x0068, ControllerInitiated, 0x00061A80,
>                 AddressingMode7Bit, "\\_SB.I2CB",
>                 0x00, ResourceConsumer, , Exclusive,
>                 )
>             GpioInt (Edge, ActiveLow, Exclusive, PullDefault, 0x0000,
>                 "\\_SB.GPIO", 0x00, ResourceConsumer, ,
>                 )
>                 {   // Pin list
>                     0x008B
>                 }
>         })
>         Return (RBUF) /* \_SB_.I2CB.BMI2._CRS.RBUF */
>     }
      ...
> }
> 

> OrangePi NEO:

Same comments for this device.

...

> > +static const struct acpi_device_id bmi270_acpi_match[] = {
> > +	{ "BOSC0260",  (kernel_ulong_t)&bmi260_chip_info },
> > +	{ }
> > +};
> 
> I can't find any evidence of BOSC0260 being used, besides existing in
> the Windows driver. As suggested in an earlier review, I added it here
> to encourage people looking at this driver in the future to use the
> correct ACPI ID.

Are you official representative of Bosch or do you have a proof by the vendor
that they allocated this ID? Otherwise we may NOT allocate IDs on their behalf
and has not to be added.

-- 
With Best Regards,
Andy Shevchenko



