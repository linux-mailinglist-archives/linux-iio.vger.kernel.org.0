Return-Path: <linux-iio+bounces-26112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (unknown [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759BCC4463B
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43959188B9B5
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A620F2248B9;
	Sun,  9 Nov 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYQt3NZ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54DDF59;
	Sun,  9 Nov 2025 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716840; cv=none; b=RVd1A1ZNPyMa0vjRJQGiSXO8ROg4YYKf+CsBcdB1jHEtL2zvR826CPdXCZqibaGSBZfqBFg7AH4/iFQdUzNe1aMvcA5JhWtF98NnRNgFKPnDvPAvqaadn+HWVWBkJ3F0A8Gh7qSh3evds2LbcQaZBasBuhSOJoH3+1hu7QY9Tns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716840; c=relaxed/simple;
	bh=FQsLJNFelMULhIUY3Xjilt0nK9RrOxDUHqcd0BV4DH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTIQ0nK/mQLGWIArdxKwY1P9CB3GZ9JjMYDMVVHdV15R5cUaSsrkb3BQjQCfWGuGC6j8Vf9Rp64RoXaHsn9M3L2ABJXsFRufag3J8soQfgwg9yvb/T2sFlua0ojMLMZjhcff8xk9lEikF8cngwdpm6nvG/ZkOj6XEl0bwmBqnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYQt3NZ3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762716839; x=1794252839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FQsLJNFelMULhIUY3Xjilt0nK9RrOxDUHqcd0BV4DH0=;
  b=ZYQt3NZ3dnvPdrGs6jlAdukSY8CqhA0MZgW6DdGxtyXN+fu+N27Q5erf
   qgjVpsedAdRuEEhmMZtSeWseJ5cenyOub6vjnxx+ClL+9sIZlglAxK0Vm
   tHnKIFiax2wmR6x9XvbirCzCYhgjbiEpuf8syiPl8F6j5BUfXfXDeY3SZ
   9554iZ42O7oxUNZfIZwIzNm81rR7V60pUpIYxJNtwJFMPncpceeN4UPv0
   qWbOmppMPz9U9p1sfRiewVeND4IfzsOZrmtzPKQwQvGQWEFWQBTC3z1+g
   Q8RSgR82o9MHGwj1XvrbxZRBCcE+Y19y/PSSJ+npMq7ivPOpng+MCTUE9
   g==;
X-CSE-ConnectionGUID: s0Ee9tAQS+WMBysxSQsjOQ==
X-CSE-MsgGUID: 3zH+MjH8T2eBSf6DqAxlNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64820800"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="64820800"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 11:33:59 -0800
X-CSE-ConnectionGUID: Cd/nBDkSQJaF2Y0Q0UCABA==
X-CSE-MsgGUID: 7OHsT636SmGA8i/smPX+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="192892603"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 11:33:56 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vIBAf-000000076eT-3BuD;
	Sun, 09 Nov 2025 21:33:53 +0200
Date: Sun, 9 Nov 2025 21:33:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Message-ID: <aRDsoY7Ac4i0eGTF@smile.fi.intel.com>
References: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 09, 2025 at 08:24:36PM +0100, Andy Shevchenko wrote:
> The driver code is full of intXX_t and uintXX_t types which is
> not the pattern we use in the IIO subsystem. Switch the driver
> to use kernel internal types for that. No functional changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Jonathan, what is the status of fixing the type for
> iio_push_to_buffers_with_timestamp()? This patch doesn't do that
> as I see no API has been fixed (and it seems the only one that uses
> the *intXX_t parameter).
> 
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FWIW,

$ git grep -l 'u\?int[0-9][0-9]\?_t' -- drivers/iio/
drivers/iio/accel/bmc150-accel-core.c
drivers/iio/accel/bmc150-accel.h
drivers/iio/accel/fxls8962af-core.c
drivers/iio/accel/hid-sensor-accel-3d.c
drivers/iio/accel/kionix-kx022a.c
drivers/iio/accel/kxcjk-1013.c
drivers/iio/accel/sca3000.c
drivers/iio/accel/sca3300.c
drivers/iio/accel/ssp_accel_sensor.c
drivers/iio/adc/ad4000.c
drivers/iio/adc/ad7791.c
drivers/iio/adc/ad7887.c
drivers/iio/adc/at91_adc.c
drivers/iio/adc/ingenic-adc.c
drivers/iio/adc/max1363.c
drivers/iio/adc/qcom-spmi-rradc.c
drivers/iio/adc/qcom-vadc-common.c
drivers/iio/adc/ti-ads7950.c
drivers/iio/adc/ti-tlc4541.c
drivers/iio/adc/xilinx-xadc-core.c
drivers/iio/adc/xilinx-xadc-events.c
drivers/iio/adc/xilinx-xadc.h
drivers/iio/chemical/scd4x.c
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h
drivers/iio/common/hid-sensors/hid-sensor-attributes.c
drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
drivers/iio/common/ssp_sensors/ssp.h
drivers/iio/common/ssp_sensors/ssp_iio.c
drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
drivers/iio/dac/ad3552r.c
drivers/iio/dac/ad5446.c
drivers/iio/dac/ad5449.c
drivers/iio/dac/ad5766.c
drivers/iio/dac/ad7303.c
drivers/iio/dac/ad8460.c
drivers/iio/dac/ds4424.c
drivers/iio/dac/ti-dac7612.c
drivers/iio/frequency/admv4420.c
drivers/iio/gyro/adis16136.c
drivers/iio/gyro/ssp_gyro_sensor.c
drivers/iio/humidity/ens210.c
drivers/iio/imu/adis16400.c
drivers/iio/imu/adis16460.c
drivers/iio/imu/adis16480.c
drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
drivers/iio/industrialio-buffer.c
drivers/iio/light/ltr501.c
drivers/iio/light/rohm-bu27034.c
drivers/iio/light/si1133.c
drivers/iio/light/stk3310.c
drivers/iio/light/vcnl4000.c
drivers/iio/position/hid-sensor-custom-intel-hinge.c
drivers/iio/pressure/icp10100.c
drivers/iio/pressure/ms5611_core.c
drivers/iio/temperature/mlx90632.c

-- 
With Best Regards,
Andy Shevchenko



