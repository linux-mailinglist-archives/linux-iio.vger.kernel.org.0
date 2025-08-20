Return-Path: <linux-iio+bounces-23071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC318B2E100
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1634EA261D9
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA6322A13;
	Wed, 20 Aug 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frL5AAR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C22E8B81;
	Wed, 20 Aug 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702559; cv=none; b=diLfxqVIsbDlthqsvNr/GiW6spNXvYezUISrqHd0TnOZHA9aLvm7qfLEZlFd+5JOCxvsinA5WWLTyAf0DWiKMzs2YIzzH+Bk+WtR4nPNxH21A9AtlHnc40HISaW6cVnXc5jraPkCyZd+AWN9RPDuIbuUkYS9f1V0t/wzo7Nm6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702559; c=relaxed/simple;
	bh=LCVLvmXp8GhH3jfjnnZtTRaXTBMo68xWvBNThq4DNP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvJO/h63u8YIbLRm/gvST4ZAqYblq4hdR5XJmM2RzDdeABXTUCOIqqgX7gYGD4sJmCUP7ZtPtjkAmT0Fleut6zz4bCle7qPkoSKLsjlz5kHNfSVrXuUPk7GRQq+S3FmimKagCf/iVRh1k6iZ0XS0M+zYw8FnlzTcRb3eA6DysyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frL5AAR+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755702558; x=1787238558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LCVLvmXp8GhH3jfjnnZtTRaXTBMo68xWvBNThq4DNP4=;
  b=frL5AAR+s+aRJLkL0iBGQkDXtPXBDUhR/bYIRdeUIxxsA7YWmFawkEAf
   0hr6zVl2e/aXE4lcUlo8KCpmDvb1BT3bsi5K8xQjb7SZsmWDJYc2Mn77T
   CbCco1zDY2NgbmAnsv4OwwUyykBtv3XQHrp8Qf90wO6Encvl0KKa4Cjng
   9E/+3MeFQe6sZsfLDZDnbPlqYaBqDn8AzDCqkmPhNzoxOVzsQxfrZ6i1t
   ivMjY4VIwZyuL/8ZazXx0hf5cUcDgBJFAbUOYJyQBXuZhK7RxAw4UO18d
   AbJS20R7vxn6QnCwP41tf1OmddJui4dgb5HNvRoWuIAtry3IX+72Du4+z
   A==;
X-CSE-ConnectionGUID: LHint3cfSp6ALG7SrObX0w==
X-CSE-MsgGUID: EjLuyg6SRXa7dietz8ZNhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58070150"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58070150"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:09:16 -0700
X-CSE-ConnectionGUID: ciJw3CfvQ0+BVu5at19++w==
X-CSE-MsgGUID: xUJPfrHHRIy4TBi8Oy473A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168067907"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:09:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uokR3-00000006y2m-3mq9;
	Wed, 20 Aug 2025 18:09:09 +0300
Date: Wed, 20 Aug 2025 18:09:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: cryolitia@uniontech.com
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>,
	WangYuli <wangyuli@uniontech.com>, Jun Zhan <zhanjun@uniontech.com>,
	Niecheng1@uniontech.com
Subject: Re: [PATCH v2] iio: imu: bmi270: Match PNP ID found on newer GPD
 firmware
Message-ID: <aKXlFZmIaefBPlw0@smile.fi.intel.com>
References: <20250815-bmi270-gpd-acpi-v2-1-8e1db68d36d1@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-bmi270-gpd-acpi-v2-1-8e1db68d36d1@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 15, 2025 at 06:43:26PM +0800, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
> When they switched to BMI260 sensors in newer hardware, they reused
> the existing Windows driver which accepts both "BMI0160" and "BMI0260"
> IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
> devices, causing driver mismatches in Linux.
> 
> 1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
> BMI260 sensors to avoid loading bmi160 driver on Linux. While this
> isn't Bosch's VID;
> 2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
> 3. We're seeing real devices shipping with "BMI0260" in DSDT
> 
> The DSDT excerpt of GPD G1619-04 with BIOS v0.40:
> 
> Scope (_SB.I2CC)
> {
>     Device (BMA2)
>     {
>         Name (_ADR, Zero)  // _ADR: Address
>         Name (_HID, "BMI0260")  // _HID: Hardware ID
>         Name (_CID, "BMI0260")  // _CID: Compatible ID
>         Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>         Name (_UID, One)  // _UID: Unique ID
>         Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>         {
>             Name (RBUF, ResourceTemplate ()
>             {
>                 I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
>                     AddressingMode7Bit, "\\_SB.I2CC",
>                     0x00, ResourceConsumer, , Exclusive,
>                     )
>             })
>             Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
>         }

Everything from this line...

>         OperationRegion (CMS2, SystemIO, 0x72, 0x02)
>         Field (CMS2, ByteAcc, NoLock, Preserve)
>         {
>             IND2,   8,
>             DAT2,   8
>         }
> 
>         IndexField (IND2, DAT2, ByteAcc, NoLock, Preserve)
>         {
>             Offset (0x74),
>             BACS,   32
>         }
> 
>         Method (ROMS, 0, NotSerialized)
>         {
>             Name (RBUF, Package (0x03)
>             {
>                 "0 -1 0",
>                 "-1 0 0",
>                 "0 0 -1"
>             })
>             Return (RBUF) /* \_SB_.I2CC.BMA2.ROMS.RBUF */
>         }
> 
>         Method (CALS, 1, NotSerialized)
>         {
>             Local0 = Arg0
>             If (((Local0 == Zero) || (Local0 == Ones)))
>             {
>                 Return (Local0)
>             }
>             Else
>             {
>                 BACS = Local0
>             }
>         }

>         Method (_STA, 0, NotSerialized)  // _STA: Status
>         {
>             Return (0x0F)
>         }

...till this line is a noise.

>     }
> }

> 1. http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip
> 

Make it a Link tag.

Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip #1
Signed-of-by: ...

-- 
With Best Regards,
Andy Shevchenko



