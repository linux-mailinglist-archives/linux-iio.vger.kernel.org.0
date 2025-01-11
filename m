Return-Path: <linux-iio+bounces-14125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3771A0A379
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA807A4442
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785A193094;
	Sat, 11 Jan 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtj24Grs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E413192B60;
	Sat, 11 Jan 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736597033; cv=none; b=rLn7Rf8ECq8aOdcQbT5lQJNylWhk5dFuCjdAsbJVY43oN6Zh+fJV+wVZBQTSh53XRnqEY8vl/V4fIEavSGg10e6QErMv2OnYNCwkYhK2b6ED4xatFPBiySquRtDQfgxGRrdGNIvKwjoBp9RGkFnYxYOGaKrXWP/ZD2NkmS3+Hts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736597033; c=relaxed/simple;
	bh=9lwsD16mqpsxnr7Lg7DWtNqFWv+blTvHMR+Mp08IuZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1kSA/MXFe4mgbhKCsg9titPSvMUWHUVFoCwepiB/tce+Y3FQ6LFzg1cXbKJqvKUmXiug0WLcrZcNQ2PHi7dNlbnAxcuJGI29g4eYZ5yoKKw50yuRLuoh/AilY6WHgdH7GG5NyCKRiQH/fvJYgXeJiGTzK/iMVnaB5Gf+Yox8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtj24Grs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736597031; x=1768133031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lwsD16mqpsxnr7Lg7DWtNqFWv+blTvHMR+Mp08IuZE=;
  b=jtj24GrsJy7+5bkj0lzB3T7SMR2TDtOeRRbxP8unuN+7CC1QQwv8739I
   ncV3GuxKWRcNiSP6irvZR9F+hk1vzaC/gC/dOJYNF1aeObze+PYVyw1zT
   AtqBZrANKtUAx3XlBf2a4plBtHBOab3u0N/lOy2Ie7L+LonfBIOTQsXNe
   g2cDtlZW2OwRjzIrOqUbmCe/IRP2EZqGoNtJxVDUEgN1Xx/m4w4SK/7aA
   DyLdMmIWN0X0BQHsr0JjO3YbQgPU+fPGSfIDZJ5LJFaraeH/vBxhh/ioX
   fMZkiDE6qN2AqD8jN07pWWzjXgnktzYUv2vT4I1nas6VE+5HavzHCDOpz
   Q==;
X-CSE-ConnectionGUID: X2gIRxrhS0y5OcDAWow4dg==
X-CSE-MsgGUID: 4omRTZgyTz6qITmhcu4FCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="40565034"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="40565034"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 04:03:51 -0800
X-CSE-ConnectionGUID: lavWYR7CQUyr8plOHXlQ4Q==
X-CSE-MsgGUID: jiv1JclGTi2UazKOfNLNjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="103781731"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jan 2025 04:03:47 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWaDQ-000Kbj-2y;
	Sat, 11 Jan 2025 12:03:44 +0000
Date: Sat, 11 Jan 2025 20:03:22 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Budai <robert.budai@analog.com>, Nuno Sa <nuno.sa@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Lanzano <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
Message-ID: <202501111951.NHXp98OK-lkp@intel.com>
References: <20250110074254.38966-6-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110074254.38966-6-robert.budai@analog.com>

Hi Robert,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Budai/iio-imu-adis-Add-custom-ops-struct/20250110-154645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250110074254.38966-6-robert.budai%40analog.com
patch subject: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250111/202501111951.NHXp98OK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501111951.NHXp98OK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501111951.NHXp98OK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/module.h:22,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/iio/iio.h:10,
                    from include/linux/iio/buffer.h:10,
                    from drivers/iio/imu/adis16550.c:12:
>> drivers/iio/imu/adis16550.c:1202:18: error: expected ',' or ';' before 'IIO_ADISLIB'
    1202 | MODULE_IMPORT_NS(IIO_ADISLIB);
         |                  ^~~~~~~~~~~
   include/linux/moduleparam.h:26:61: note: in definition of macro '__MODULE_INFO'
      26 |                 = __MODULE_INFO_PREFIX __stringify(tag) "=" info
         |                                                             ^~~~
   include/linux/module.h:299:33: note: in expansion of macro 'MODULE_INFO'
     299 | #define MODULE_IMPORT_NS(ns)    MODULE_INFO(import_ns, ns)
         |                                 ^~~~~~~~~~~
   drivers/iio/imu/adis16550.c:1202:1: note: in expansion of macro 'MODULE_IMPORT_NS'
    1202 | MODULE_IMPORT_NS(IIO_ADISLIB);
         | ^~~~~~~~~~~~~~~~


vim +1202 drivers/iio/imu/adis16550.c

  1196	
  1197	MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
  1198	MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
  1199	MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
  1200	MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
  1201	MODULE_LICENSE("GPL");
> 1202	MODULE_IMPORT_NS(IIO_ADISLIB);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

