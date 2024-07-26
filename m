Return-Path: <linux-iio+bounces-7932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E993D145
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B401F217B7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56770178CDE;
	Fri, 26 Jul 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCt27bn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1C178372;
	Fri, 26 Jul 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990514; cv=none; b=m+mE5wvzI++go5sKKE2zxw7nQ67gaVl9EWKKPHxs6PjSKbZsWY+6YP0ns6pSoe9nd3N0DvsfeOwRV90XDvmkv/uE3brSCcoYdmMTUTMgjloO5ONuGlPYzfMmxrZXVgv5UOYgQUnj411VBEH5S/qBcnxKxfin1EFEzaiS6IUdUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990514; c=relaxed/simple;
	bh=A6AZIIZg8RUq7EFqa50vxGkOTJ+a1AC/uuxwAeOc2Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4pcfNBnMGBIc1Z3/8OPqrV73+/7418OCBAzw5tF3A1oxhINwFPQasH19FGaKJPfupRraJp6AV+88O4cUn8huoeBQJNzTlApU/Tp81LUuxgUiOY1Lz6DxeaDIB/lpGRiomq5yeFU18CrJMBzd1qB+cHgl9htUxJY5uHmcXMIKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCt27bn+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721990512; x=1753526512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6AZIIZg8RUq7EFqa50vxGkOTJ+a1AC/uuxwAeOc2Wc=;
  b=nCt27bn+axmQGg0PMjM7CRTB+/ejJev9Mw2JFdQSOR/B8TS71VJ66lTx
   2LEdmKet8fCnY9+u2OjBUvB7NizMxuyQNMwgP2w1nevsyfYzbD8IfUAZh
   lqbV0xbSZDd495Q5gpBZ7vNXgSc/Kw10Ber3sZTihg/bzayIvPZ8U2C4p
   YIN1nT2AKd7jfUYlcpq2DmBk/mUvLDAX8Op1omuG83m0UWh3oyXAZu2pz
   5XYGaHNyJ5ecsBI9CC9e1AAXIfTWMxhxpmI82u6tN2o60gwaJh/OjZH6n
   m0r8JRkcW4oSxhCcBB/WAOJY8xUVWWYyPgYxNf7oPUtCA9AjoGWI7z+v0
   g==;
X-CSE-ConnectionGUID: ZFr7obQfSdmDCySv5W9vAw==
X-CSE-MsgGUID: /NXq4GxfTky93CqoiA1JdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="30375127"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="30375127"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 03:41:51 -0700
X-CSE-ConnectionGUID: AVtxKsHaT62o79HbIPIrrg==
X-CSE-MsgGUID: 3UNh5Qs2Q1aTTnj2OTuafA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53315847"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jul 2024 03:41:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXIOO-000ozw-38;
	Fri, 26 Jul 2024 10:41:44 +0000
Date: Fri, 26 Jul 2024 18:41:38 +0800
From: kernel test robot <lkp@intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: pressure bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <202407261832.zSKjAoTj-lkp@intel.com>
References: <20240725231039.614536-8-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725231039.614536-8-vassilisamir@gmail.com>

Hi Vasileios,

kernel test robot noticed the following build errors:

[auto build test ERROR on 47ee461357f9da5a35d5f43527b7804a6a5744cb]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasileios-Amoiridis/iio-pressure-bmp280-Use-bulk-read-for-humidity-calibration-data/20240726-071712
base:   47ee461357f9da5a35d5f43527b7804a6a5744cb
patch link:    https://lore.kernel.org/r/20240725231039.614536-8-vassilisamir%40gmail.com
patch subject: [PATCH v2 7/7] iio: pressure bmp280: Move bmp085 interrupt to new configuration
config: i386-buildonly-randconfig-005-20240726 (https://download.01.org/0day-ci/archive/20240726/202407261832.zSKjAoTj-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240726/202407261832.zSKjAoTj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407261832.zSKjAoTj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/pressure/bmp280-core.c:3146:12: error: initializer element is not constant
     .id_reg = bmp180_chip_info.id_reg,
               ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3146:12: note: (near initialization for 'bmp085_chip_info.id_reg')
   drivers/iio/pressure/bmp280-core.c:3147:13: error: initializer element is not constant
     .chip_id = bmp180_chip_info.chip_id,
                ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3147:13: note: (near initialization for 'bmp085_chip_info.chip_id')
   drivers/iio/pressure/bmp280-core.c:3148:17: error: initializer element is not constant
     .num_chip_id = bmp180_chip_info.num_chip_id,
                    ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3148:17: note: (near initialization for 'bmp085_chip_info.num_chip_id')
   drivers/iio/pressure/bmp280-core.c:3149:19: error: initializer element is not constant
     .regmap_config = bmp180_chip_info.regmap_config,
                      ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3149:19: note: (near initialization for 'bmp085_chip_info.regmap_config')
   drivers/iio/pressure/bmp280-core.c:3150:19: error: initializer element is not constant
     .start_up_time = bmp180_chip_info.start_up_time,
                      ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3150:19: note: (near initialization for 'bmp085_chip_info.start_up_time')
   drivers/iio/pressure/bmp280-core.c:3151:14: error: initializer element is not constant
     .channels = bmp180_chip_info.channels,
                 ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3151:14: note: (near initialization for 'bmp085_chip_info.channels')
   drivers/iio/pressure/bmp280-core.c:3152:18: error: initializer element is not constant
     .num_channels = bmp180_chip_info.num_channels,
                     ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3152:18: note: (near initialization for 'bmp085_chip_info.num_channels')
   drivers/iio/pressure/bmp280-core.c:3153:22: error: initializer element is not constant
     .avail_scan_masks = bmp180_chip_info.avail_scan_masks,
                         ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3153:22: note: (near initialization for 'bmp085_chip_info.avail_scan_masks')
   drivers/iio/pressure/bmp280-core.c:3155:29: error: initializer element is not constant
     .oversampling_temp_avail = bmp180_chip_info.oversampling_temp_avail,
                                ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3155:29: note: (near initialization for 'bmp085_chip_info.oversampling_temp_avail')
   drivers/iio/pressure/bmp280-core.c:3157:3: error: initializer element is not constant
      bmp180_chip_info.num_oversampling_temp_avail,
      ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3157:3: note: (near initialization for 'bmp085_chip_info.num_oversampling_temp_avail')
   drivers/iio/pressure/bmp280-core.c:3158:31: error: initializer element is not constant
     .oversampling_temp_default = bmp180_chip_info.oversampling_temp_default,
                                  ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3158:31: note: (near initialization for 'bmp085_chip_info.oversampling_temp_default')
   drivers/iio/pressure/bmp280-core.c:3160:30: error: initializer element is not constant
     .oversampling_press_avail = bmp180_chip_info.oversampling_press_avail,
                                 ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3160:30: note: (near initialization for 'bmp085_chip_info.oversampling_press_avail')
   drivers/iio/pressure/bmp280-core.c:3162:3: error: initializer element is not constant
      bmp180_chip_info.num_oversampling_press_avail,
      ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3162:3: note: (near initialization for 'bmp085_chip_info.num_oversampling_press_avail')
   drivers/iio/pressure/bmp280-core.c:3164:3: error: initializer element is not constant
      bmp180_chip_info.oversampling_press_default,
      ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3164:3: note: (near initialization for 'bmp085_chip_info.oversampling_press_default')
   drivers/iio/pressure/bmp280-core.c:3166:17: error: initializer element is not constant
     .temp_coeffs = bmp180_chip_info.temp_coeffs,
                    ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3166:17: note: (near initialization for 'bmp085_chip_info.temp_coeffs')
   drivers/iio/pressure/bmp280-core.c:3167:22: error: initializer element is not constant
     .temp_coeffs_type = bmp180_chip_info.temp_coeffs_type,
                         ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3167:22: note: (near initialization for 'bmp085_chip_info.temp_coeffs_type')
   drivers/iio/pressure/bmp280-core.c:3168:18: error: initializer element is not constant
     .press_coeffs = bmp180_chip_info.press_coeffs,
                     ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3168:18: note: (near initialization for 'bmp085_chip_info.press_coeffs')
   drivers/iio/pressure/bmp280-core.c:3169:23: error: initializer element is not constant
     .press_coeffs_type = bmp180_chip_info.press_coeffs_type,
                          ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3169:23: note: (near initialization for 'bmp085_chip_info.press_coeffs_type')
   drivers/iio/pressure/bmp280-core.c:3171:17: error: initializer element is not constant
     .chip_config = bmp180_chip_info.chip_config,
                    ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3171:17: note: (near initialization for 'bmp085_chip_info.chip_config')
   drivers/iio/pressure/bmp280-core.c:3172:15: error: initializer element is not constant
     .read_temp = bmp180_chip_info.read_temp,
                  ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3172:15: note: (near initialization for 'bmp085_chip_info.read_temp')
   drivers/iio/pressure/bmp280-core.c:3173:16: error: initializer element is not constant
     .read_press = bmp180_chip_info.read_press,
                   ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3173:16: note: (near initialization for 'bmp085_chip_info.read_press')
   drivers/iio/pressure/bmp280-core.c:3174:16: error: initializer element is not constant
     .read_calib = bmp180_chip_info.read_calib,
                   ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3174:16: note: (near initialization for 'bmp085_chip_info.read_calib')
   drivers/iio/pressure/bmp280-core.c:3175:14: error: initializer element is not constant
     .set_mode = bmp180_chip_info.set_mode,
                 ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3175:14: note: (near initialization for 'bmp085_chip_info.set_mode')
   drivers/iio/pressure/bmp280-core.c:3176:15: error: initializer element is not constant
     .wait_conv = bmp180_chip_info.wait_conv,
                  ^~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:3176:15: note: (near initialization for 'bmp085_chip_info.wait_conv')


vim +3146 drivers/iio/pressure/bmp280-core.c

  3144	
  3145	const struct bmp280_chip_info bmp085_chip_info = {
> 3146		.id_reg = bmp180_chip_info.id_reg,
  3147		.chip_id = bmp180_chip_info.chip_id,
  3148		.num_chip_id = bmp180_chip_info.num_chip_id,
  3149		.regmap_config = bmp180_chip_info.regmap_config,
  3150		.start_up_time = bmp180_chip_info.start_up_time,
  3151		.channels = bmp180_chip_info.channels,
  3152		.num_channels = bmp180_chip_info.num_channels,
  3153		.avail_scan_masks = bmp180_chip_info.avail_scan_masks,
  3154	
  3155		.oversampling_temp_avail = bmp180_chip_info.oversampling_temp_avail,
  3156		.num_oversampling_temp_avail =
  3157			bmp180_chip_info.num_oversampling_temp_avail,
  3158		.oversampling_temp_default = bmp180_chip_info.oversampling_temp_default,
  3159	
  3160		.oversampling_press_avail = bmp180_chip_info.oversampling_press_avail,
  3161		.num_oversampling_press_avail =
  3162			bmp180_chip_info.num_oversampling_press_avail,
  3163		.oversampling_press_default =
  3164			bmp180_chip_info.oversampling_press_default,
  3165	
  3166		.temp_coeffs = bmp180_chip_info.temp_coeffs,
  3167		.temp_coeffs_type = bmp180_chip_info.temp_coeffs_type,
  3168		.press_coeffs = bmp180_chip_info.press_coeffs,
  3169		.press_coeffs_type = bmp180_chip_info.press_coeffs_type,
  3170	
  3171		.chip_config = bmp180_chip_info.chip_config,
  3172		.read_temp = bmp180_chip_info.read_temp,
  3173		.read_press = bmp180_chip_info.read_press,
  3174		.read_calib = bmp180_chip_info.read_calib,
  3175		.set_mode = bmp180_chip_info.set_mode,
  3176		.wait_conv = bmp180_chip_info.wait_conv,
  3177	
  3178		.trigger_probe = bmp085_trigger_probe,
  3179		.trigger_handler = bmp180_trigger_handler,
  3180	};
  3181	EXPORT_SYMBOL_NS(bmp085_chip_info, IIO_BMP280);
  3182	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

