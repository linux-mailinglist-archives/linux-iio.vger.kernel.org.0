Return-Path: <linux-iio+bounces-11438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DA9B2B80
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4ABB20E38
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B981CCB57;
	Mon, 28 Oct 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggTIAbuB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942B1CCB28;
	Mon, 28 Oct 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107423; cv=none; b=kKJ+GA17lngxwRuGzNzKmAH0zvqnhX0kNBtJSYDCeI9nwsjyJVgyOe8XjIztvb89spdXEeFC38DpFk5E+4N2EFAzF1TDzsLSPnGKXyTyTQA6Ppp38hzQjCyxqkmzjDJkI+95mBkQf+Er7XFf6HIrWR0IXIAJE2bkLw94UF/t4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107423; c=relaxed/simple;
	bh=AQpFAUFMN9fT2UFJfBD3Pc/GTLjWtryKsST2A/ZAihQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwLhpB0YZIpcD+D27NT84QFDysyR/BiRwVjRwXQBerc4IM/rv4J9e8lr1hJaC78XMfFxag8WHv8h6j6VjJpGthxciS3i5QE27tpvKieDlwUB53WDBNGddwO9GSQ4trXZSdtWXVKL4kmYsv+M/SwOP7oDf4GHDrI9zYyPfrKqxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggTIAbuB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730107421; x=1761643421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AQpFAUFMN9fT2UFJfBD3Pc/GTLjWtryKsST2A/ZAihQ=;
  b=ggTIAbuB54k+ryf2wAL5pFJE3/UIkXUIuUC0On4EcvnRfdJSj/A2t44B
   IGx3gIud5yyx8reKfYmm90xdBRrK1EREc9e2RD1tNbbsdy2m6B1XCqdr8
   Fg2lZ005/CatqSTJ7naCzfrRiePSz3/23JobhOjFBiiK47ngHT1TxzbLv
   xe79i9qY9+6END6BKoteAyOvwU5otUXFeNF5iVgtMiGGG9QgyyNOYFyNc
   bjXxZ46J6PnQNfqLPoC4WtK6ctcEp3m/ktWqKMHPwiNuhzPqowLmPuAAn
   rG+XlvSon4Z/Fwla103p9xYuCnewCDlO961CHU7KP6oAQPqPqHymaxm+O
   Q==;
X-CSE-ConnectionGUID: bQVr1pyoSkyJsF2uCeKlHA==
X-CSE-MsgGUID: pWjex6CdQuyt3pjt39LvIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29800849"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29800849"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:23:40 -0700
X-CSE-ConnectionGUID: bF0ngyVZRy2WzlqienXeCQ==
X-CSE-MsgGUID: v7OirsapSKa8eupQXXXLLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="82378578"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:23:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5LyJ-00000007tKG-0OJp;
	Mon, 28 Oct 2024 11:23:35 +0200
Date: Mon, 28 Oct 2024 11:23:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Subject: Re: [PATCH v4 4/4] iio: imu: bmi270: Add support for BMI260
Message-ID: <Zx9YFjHVDhwz58Mc@smile.fi.intel.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
 <20241027172029.160134-5-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027172029.160134-5-justin@justinweiss.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Oct 27, 2024 at 10:20:25AM -0700, Justin Weiss wrote:
> Adds support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
> driver. Setup and operation is nearly identical to the Bosch BMI270,
> but has a different chip ID and requires different firmware.
> 
> Firmware is requested and loaded from userspace.
> 
> Adds ACPI ID BMI0160, used by several devices including the GPD Win
> Mini, Aya Neo AIR Pro, and OXP Mini Pro.
> 
> GPD Win Mini:
> 
> Device (BMI2)
> {
>     Name (_ADR, Zero)  // _ADR: Address
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
>     ...
> }

LGTM from ACPI ID perspective,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  static const struct spi_device_id bmi270_spi_id[] = {
> +	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info},

Missed space.

>  	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
>  	{ }
>  };

-- 
With Best Regards,
Andy Shevchenko



