Return-Path: <linux-iio+bounces-7955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44093DC91
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 02:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910521C23268
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBC610FA;
	Sat, 27 Jul 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQSAr33F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D4812;
	Sat, 27 Jul 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722040220; cv=none; b=fwZrDyQRsdUCaKsBrtoMNJVOi2xjCIs4iRPuSWKDTixKCKtms8sb0MXLNIHoe+Cm9cDwDBfXUc4eaCHYYezN0by0oH3j1NavPgzWpXGTYCmADripKKJJNcbJpoJS0xXdKbTyS3bke7fHWv6lyqtJW1FPF9PlPQOn/RXW4D6PjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722040220; c=relaxed/simple;
	bh=mCVSTRV3rhZ/5whvsTgdVrcA6k8L7Ed+HfUHhstdUuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdYYbOlfT6ft+/sLVgUAfaxbGGVFaOZf0pZQcyEVXH37O4S9NZEbIywcUj3CTbQ4zJWWk0o5qe8p+Y/1PtstqaR2smEQCdYjwHMhrSjztGYafm37xv1qmfr7x90ypnCezW11xapHqgg21PPXs3uaAqzVBq9psSQY+oLSsjqcOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQSAr33F; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722040216; x=1753576216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mCVSTRV3rhZ/5whvsTgdVrcA6k8L7Ed+HfUHhstdUuE=;
  b=jQSAr33FU0EoYTTx5Wz/+pZnkn2eD9bKA9X/okLNl7YSfoYUjCOCWl/+
   WBXdB3/gxPDs7RGNssvvxCB0sEU225rOrJAYZ8K0C8Slvr9k5sFCWkfxn
   JRzmWAlNA7y3AblLhcXl0+6BFR8haRp5LVk9YcRCVLMoXVMpAXQvvM04R
   9gE8yQij1pWiA2GL2PoLcX4cpXCqwHZNTDXKm4oShau3NYWIGwCtu9V4k
   WqFo2+4IdePxmIlOo7CVjNyO1RnO/jQoAHSfm9RRCaotFrJE0rbeymsAo
   QDqLvneW7OcIZWtD5QuSScwAzmHvPBm4mjx1ldURSiX+0KeRM6iXwGBWB
   Q==;
X-CSE-ConnectionGUID: UO++9VWZR8Kr5AZTqlqSow==
X-CSE-MsgGUID: 9FpVLjwwRRCs+/7Ev9zaWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="37321867"
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="37321867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 17:30:16 -0700
X-CSE-ConnectionGUID: rMIvXdeOS4+hpXO92LzViw==
X-CSE-MsgGUID: y/8zfYvSSsePWi2954/lOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="90875769"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Jul 2024 17:30:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXVK4-000pWi-39;
	Sat, 27 Jul 2024 00:30:08 +0000
Date: Sat, 27 Jul 2024 08:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	vassilisamir@gmail.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: pressure bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <202407270859.izJnB7MZ-lkp@intel.com>
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
config: s390-randconfig-002-20240726 (https://download.01.org/0day-ci/archive/20240727/202407270859.izJnB7MZ-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240727/202407270859.izJnB7MZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407270859.izJnB7MZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/pressure/bmp280-core.c:36:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/iio/pressure/bmp280-core.c:36:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/iio/pressure/bmp280-core.c:36:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/iio/pressure/bmp280-core.c:3146:29: error: initializer element is not a compile-time constant
           .id_reg = bmp180_chip_info.id_reg,
                     ~~~~~~~~~~~~~~~~~^~~~~~
   12 warnings and 1 error generated.


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

