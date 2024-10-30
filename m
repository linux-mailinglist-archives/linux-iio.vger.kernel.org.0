Return-Path: <linux-iio+bounces-11621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71379B669C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 15:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88341C213A3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB241F471A;
	Wed, 30 Oct 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBBZdaEN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B301EF92C;
	Wed, 30 Oct 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300171; cv=none; b=MhKQ5YPZaMq1Bw5kLsTlvfnFBYPnzUHMXuYnvNnuCFauvh8kbojGMo5Hrm/Z5Gz5aJfl55zlkTFYDK6HJ/1jJ+hlKnRhDXt/rXiMHRkJs2KB8Y7gedD/cXWx/hEsFlTGP42yZv2L7kzPcmVdbnc7oSf4K8AXorLUYePqm+7BkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300171; c=relaxed/simple;
	bh=PJgQRoa9dILAfNfnvnH/aiHEDJBY/XzwXb7TDFNXcbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuS9FRi13C6v5Xspk/+uY56of9Aze3+zRGJY9cmRSfo+UPN+HW6+W3TrQ9l/CtgLDO69/lvldBphLz9bKTpXWOnCror3cJgtYOFr6zK1W7fvfsmB/2wPYS0C38rLknYxj972NX4HtlOQNOKm1d/DVf1t7ehUPvrMy1iBLA57vcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBBZdaEN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730300169; x=1761836169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PJgQRoa9dILAfNfnvnH/aiHEDJBY/XzwXb7TDFNXcbI=;
  b=IBBZdaENrnhbsTlYneKmZp4Imd7g0Gwlh4lZZJJd8iFOo4oFWtg5erl6
   S8F+HCZjy9xUQUfIKSk0139nuf8R5i7n6Wwwn8TxJHLGLt76YseedRNCU
   C2nJk+AgNf6EPIDP3lnKPlDwKZj/F+wHmCuxATcV+yF677/NNegrtYdjc
   HDK2pnRDpX4K7a9zcK/CHB41JREdzKB0ZEVlT0rR98PNlDp7BVza2z/s3
   TIBZZBQKGfG1lUXR3tf6gr7+YUSRn/p9qbbkmTmRQjTv2814IdPz6UUDh
   qZ1FSzUUJ+dw2OKUHnb40VQkzdy8SQdn2QVXw4JcC0fuq3fej4Oezdl52
   Q==;
X-CSE-ConnectionGUID: pfab72t5RmW1TQEtaUYu5g==
X-CSE-MsgGUID: bw52Ja7eQwWQmq1+T1gUeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="17649858"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="17649858"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:56:08 -0700
X-CSE-ConnectionGUID: 0xKPsEU0S7aiJfh1R0Wc+A==
X-CSE-MsgGUID: yADDrZNsTRaxdq4D7dk97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82756096"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:56:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6A78-000000094Vj-1vpg;
	Wed, 30 Oct 2024 16:56:02 +0200
Date: Wed, 30 Oct 2024 16:56:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 00/24] iio: Clean up acpi_match_device() use cases
Message-ID: <ZyJJAl8AalZG9Zo9@smile.fi.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
 <a72e0950-be11-45a3-8387-5b51b9a2e78a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a72e0950-be11-45a3-8387-5b51b9a2e78a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 29, 2024 at 08:34:48AM +0200, Matti Vaittinen wrote:
> On 24/10/2024 22:04, Andy Shevchenko wrote:
> > There are current uses of acpi_match_device():
> > - as strange way of checking if the device was enumerated via ACPI
> > - as a way to get IIO device name as ACPI device instance name
> > - as above with accompanying driver data
> > 
> > Deduplicate its use by providing two new helper functions in IIO ACPI
> > library and update the rest accordingly.
> > 
> > This also includes a rework of previously sent ltr501 patch.
> > 
> > Besides that there ie a big clean up for the kxcjk-1013 driver, started
> > with the revert of the one patch discussed earlier today. Feel free to
> > route that one via fixes branch of your tree.
> > 
> > In v3:
> > - collected tags (Marius)
> > - added note to the documentation about usage of new API (Jonathan)
> > - added a handful patches for kxcjk-1013 driver
> > 
> > In v2:
> > - collected tags (Hans, Jean-Baptiste)
> > - updated SoB chain in patch 4
> > 
> > Andy Shevchenko (24):
> >    iio: magnetometer: bmc150: Drop dead code from the driver
> >    iio: adc: pac1934: Replace strange way of checking type of enumeration
> >    iio: imu: inv_mpu6050: Replace strange way of checking type of
> >      enumeration
> >    iio: acpi: Improve iio_read_acpi_mount_matrix()
> >    iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
> >    iio: accel: kxcjk-1013: Remove redundant I²C ID
> >    iio: accel: kxcjk-1013: Revert "Add support for KX022-1020"
> >    iio: accel: kxcjk-1013: Switch from CONFIG_PM guards to pm_ptr() etc
> >    iio: accel: kxcjk-1013: Use local variable for regs
> >    iio: accel: kxcjk-1013: Rename kxcjk1013_info
> >    iio: accel: kxcjk-1013: Start using chip_info variables instead of
> >      enum
> >    iio: accel: kxcjk-1013: Move odr_start_up_times up in the code
> >    iio: accel: kxcjk-1013: Convert ODR times array to variable in
> >      chip_info
> >    iio: accel: kxcjk-1013: Get rid of enum kx_chipset
> >    iio: accel: kxcjk-1013: Replace a variant of
> >      iio_get_acpi_device_name_and_data()
> >    iio: accel: kxcjk-1013: drop ACPI_PTR() and move ID out of CONFIG_ACPI
> >      guards
> 
> I missed reviewing these kxcjk changes. Not sure I loved all of them

Patches are welcome! :-)

> but I must admit the resulting code is looks better in general.
> 
> Thanks for the clean-up Andy!

Thank you for looking at this!

-- 
With Best Regards,
Andy Shevchenko



