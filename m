Return-Path: <linux-iio+bounces-21560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09526B0126F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 06:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5360216EDBE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE91ADC7E;
	Fri, 11 Jul 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Np2zONjI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C373FFD;
	Fri, 11 Jul 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752209745; cv=none; b=ITFCKRGr7WXknDDE7J+No7mI7U64bExeShffoMRjgd/ORhfHFNMcHpwaMHc8BsE+zCFio6esxlDPv8wFoeuUmTBKfsrcVaNRLgCqZzFkEs9SOX1u2Oec0/GMG2T7woUOi6450Q0E/8rRTy9/Mm/K+TjVCvLVKz1+N2Ulz0e6ubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752209745; c=relaxed/simple;
	bh=nmDjlbCtjRN5C7WrKYk6tvhMqcBpnIIFxiZRtcoyhzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sedRUGVpBvV1mnpr1Q+YgrODlecPSJ40l8s5QO8wrmK4G2bpD1j9pK9EoQZ5rFYvNsznggYYVHKaGXaaZFsIU9Uj5vRAR4fvIxrwS5zDHyB4N1IOtsgwol80dE7QjShm8y+mvK9b0y/d2YnW2aMrfV5hjntlIhnDFZrKjod55YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Np2zONjI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752209744; x=1783745744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nmDjlbCtjRN5C7WrKYk6tvhMqcBpnIIFxiZRtcoyhzk=;
  b=Np2zONjI98TKH1WUXKh19WGaZYARULdvIFBAkg1nc6LiQC1VRYrY/AwW
   GVhp4C+6Ak47KNRZi1ESFiSlIT3k8yq5vO34om9mZzFDqOmnjLJjdsQTT
   R9EIOgQK19OgPP4uPl4T38+6Be9VwWu6Y3AmUa9zvRmDnYs8cWRjkBDjM
   vvWH4OeF7gRzmzKO5JdPu/6h0MPuTTl5MGD6vkPm/ceviSQeUTFzTUJpq
   +9Pj8cqn49De/CPOmRck6tn6CKTInvUzxetuA8jC1/MHTXDJOyEtgJNNb
   gZUAnWgIacMBYWcpOLVF6b5CsT2c/z1ReqllAITVSiJMkxeejOkP44SQH
   A==;
X-CSE-ConnectionGUID: tBmPvLC7Qe2//ecraSK1YA==
X-CSE-MsgGUID: eTuI7BQ2Q6OIzLEhEio1PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57116487"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="57116487"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:55:43 -0700
X-CSE-ConnectionGUID: YtYsmBWPREyJANI0l56+JQ==
X-CSE-MsgGUID: Bp8nS3xdSoi3h3zGapZN9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="187263438"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jul 2025 21:55:40 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua5nN-0005tD-2R;
	Fri, 11 Jul 2025 04:55:37 +0000
Date: Fri, 11 Jul 2025 12:55:25 +0800
From: kernel test robot <lkp@intel.com>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Remi Buisson <remi.buisson@tdk.com>
Subject: Re: [PATCH v2 6/8] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Message-ID: <202507111201.r62j5rb6-lkp@intel.com>
References: <20250710-add_newport_driver-v2-6-bf76d8142ef2@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-add_newport_driver-v2-6-bf76d8142ef2@tdk.com>

Hi Remi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f8f559752d573a051a984adda8d2d1464f92f954]

url:    https://github.com/intel-lab-lkp/linux/commits/Remi-Buisson-via-B4-Relay/dt-bindings-iio-imu-Add-inv_icm45600/20250710-170143
base:   f8f559752d573a051a984adda8d2d1464f92f954
patch link:    https://lore.kernel.org/r/20250710-add_newport_driver-v2-6-bf76d8142ef2%40tdk.com
patch subject: [PATCH v2 6/8] iio: imu: inv_icm45600: add SPI driver for inv_icm45600 driver
config: mips-randconfig-r072-20250711 (https://download.01.org/0day-ci/archive/20250711/202507111201.r62j5rb6-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507111201.r62j5rb6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507111201.r62j5rb6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c:107:7: warning: variable 'sleep' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     107 |                 if (*scan_mask & (BIT(INV_ICM45600_ACCEL_SCAN_X) |
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     108 |                                  BIT(INV_ICM45600_ACCEL_SCAN_Y) |
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     109 |                                  BIT(INV_ICM45600_ACCEL_SCAN_Z))) {
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c:123:6: note: uninitialized use occurs here
     123 |         if (sleep)
         |             ^~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c:107:3: note: remove the 'if' if its condition is always true
     107 |                 if (*scan_mask & (BIT(INV_ICM45600_ACCEL_SCAN_X) |
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     108 |                                  BIT(INV_ICM45600_ACCEL_SCAN_Y) |
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     109 |                                  BIT(INV_ICM45600_ACCEL_SCAN_Z))) {
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c:100:20: note: initialize the variable 'sleep' to silence this warning
     100 |         unsigned int sleep;
         |                           ^
         |                            = 0
   1 warning generated.
--
>> drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c:107:7: warning: variable 'sleep' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     107 |                 if (*scan_mask & (BIT(INV_ICM45600_GYRO_SCAN_X) |
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     108 |                                  BIT(INV_ICM45600_GYRO_SCAN_Y) |
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     109 |                                  BIT(INV_ICM45600_GYRO_SCAN_Z))) {
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c:121:6: note: uninitialized use occurs here
     121 |         if (sleep)
         |             ^~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c:107:3: note: remove the 'if' if its condition is always true
     107 |                 if (*scan_mask & (BIT(INV_ICM45600_GYRO_SCAN_X) |
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     108 |                                  BIT(INV_ICM45600_GYRO_SCAN_Y) |
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     109 |                                  BIT(INV_ICM45600_GYRO_SCAN_Z))) {
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c:100:20: note: initialize the variable 'sleep' to silence this warning
     100 |         unsigned int sleep;
         |                           ^
         |                            = 0
   1 warning generated.


vim +107 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c

1fb5c2bf7348d06 Remi Buisson 2025-07-10   91  
1fb5c2bf7348d06 Remi Buisson 2025-07-10   92  /* enable accelerometer sensor and FIFO write */
1fb5c2bf7348d06 Remi Buisson 2025-07-10   93  static int inv_icm45600_accel_update_scan_mode(struct iio_dev *indio_dev,
1fb5c2bf7348d06 Remi Buisson 2025-07-10   94  					       const unsigned long *scan_mask)
1fb5c2bf7348d06 Remi Buisson 2025-07-10   95  {
1fb5c2bf7348d06 Remi Buisson 2025-07-10   96  	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
1fb5c2bf7348d06 Remi Buisson 2025-07-10   97  	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
1fb5c2bf7348d06 Remi Buisson 2025-07-10   98  	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
1fb5c2bf7348d06 Remi Buisson 2025-07-10   99  	unsigned int fifo_en = 0;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  100  	unsigned int sleep;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  101  	int ret;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  102  
1fb5c2bf7348d06 Remi Buisson 2025-07-10  103  	scoped_guard(mutex, &st->lock) {
1fb5c2bf7348d06 Remi Buisson 2025-07-10  104  		if (*scan_mask & BIT(INV_ICM45600_ACCEL_SCAN_TEMP))
1fb5c2bf7348d06 Remi Buisson 2025-07-10  105  			fifo_en |= INV_ICM45600_SENSOR_TEMP;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  106  
1fb5c2bf7348d06 Remi Buisson 2025-07-10 @107  		if (*scan_mask & (BIT(INV_ICM45600_ACCEL_SCAN_X) |
1fb5c2bf7348d06 Remi Buisson 2025-07-10  108  				 BIT(INV_ICM45600_ACCEL_SCAN_Y) |
1fb5c2bf7348d06 Remi Buisson 2025-07-10  109  				 BIT(INV_ICM45600_ACCEL_SCAN_Z))) {
1fb5c2bf7348d06 Remi Buisson 2025-07-10  110  			/* enable accel sensor */
1fb5c2bf7348d06 Remi Buisson 2025-07-10  111  			conf.mode = accel_st->power_mode;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  112  			ret = inv_icm45600_set_accel_conf(st, &conf, &sleep);
1fb5c2bf7348d06 Remi Buisson 2025-07-10  113  			if (ret)
1fb5c2bf7348d06 Remi Buisson 2025-07-10  114  				return ret;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  115  			fifo_en |= INV_ICM45600_SENSOR_ACCEL;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  116  		}
1fb5c2bf7348d06 Remi Buisson 2025-07-10  117  
1fb5c2bf7348d06 Remi Buisson 2025-07-10  118  		/* Update data FIFO write. */
1fb5c2bf7348d06 Remi Buisson 2025-07-10  119  		ret = inv_icm45600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
1fb5c2bf7348d06 Remi Buisson 2025-07-10  120  	}
1fb5c2bf7348d06 Remi Buisson 2025-07-10  121  
1fb5c2bf7348d06 Remi Buisson 2025-07-10  122  	/* Sleep required time. */
1fb5c2bf7348d06 Remi Buisson 2025-07-10  123  	if (sleep)
1fb5c2bf7348d06 Remi Buisson 2025-07-10  124  		msleep(sleep);
1fb5c2bf7348d06 Remi Buisson 2025-07-10  125  
1fb5c2bf7348d06 Remi Buisson 2025-07-10  126  	return ret;
1fb5c2bf7348d06 Remi Buisson 2025-07-10  127  }
1fb5c2bf7348d06 Remi Buisson 2025-07-10  128  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

