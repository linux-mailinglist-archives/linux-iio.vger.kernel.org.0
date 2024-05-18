Return-Path: <linux-iio+bounces-5094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09948C907A
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2024 13:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6265F1F21B92
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2024 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1BD266AB;
	Sat, 18 May 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igg2Ld53"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289251BC59;
	Sat, 18 May 2024 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716030063; cv=none; b=BhUcEcOC0U3PqwZpnNOql1k27fpvmqL8kUyAWzgbsPqbp6YTih/o2weg1BxojxHm5cBF4C7GNHDjXYZCQ8gi98uka55UaFY57MSLZAKHKLUUHAKwuskQcntGI9TVlMz0QMO7DnW5h3it2C63Gjyxwt1WlmmHAynfm7bp5m8LSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716030063; c=relaxed/simple;
	bh=IYkSHNbOk5pFgx8fb3hLqTIA1sWMOKEj2tGHHJKWubI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJy2vWKxqoYEyJ4PnRjxhGy9LeFdgBFp5I06927Pp1QFbOa6CF+d+LNVVtdhXZBvjBdU+FtaiHXiNpdCOFa5EHEa60oJUuca3ZYv5YnOJrvkPTmHLKmJPB4o01w7FNm+uF5SRTsZU+FI0Qazue9LQ/CUNr47xs9q95LilKLn/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igg2Ld53; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716030062; x=1747566062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYkSHNbOk5pFgx8fb3hLqTIA1sWMOKEj2tGHHJKWubI=;
  b=igg2Ld53b+lFvReFbUQwiiDQlu6mG7X/ogX68Ny0a7KoeYGlcnXynzAX
   /+m813uNyl7+co+Vy4w0MlJL/JQDX8BbM41mohKnvgMgTdVh2IwHp5QW1
   HvT/ND7PTj5FX5MJtASHIKRpOma2LJoCYg+r1LKLXNhYeppcOYcB1JPZV
   CDj7d8jCajxssw2vuNS1PkGbVhmRrfBDSdUrnURcdwT0+xcErexA6r2Do
   +9dFfLYABd0cK6r14quALAh5sepckveYchYlKe3MEKscaxUd4V9vdgEM9
   7IyFebeDHFJm6dmoGfVYdnpPEK6foY4bo7McCSdNRBkbIan9512W34tAP
   g==;
X-CSE-ConnectionGUID: R/lz5lvmQoCklWpWq33tdg==
X-CSE-MsgGUID: uk/dSYFFRw+eyUJUw3at/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="34725133"
X-IronPort-AV: E=Sophos;i="6.08,170,1712646000"; 
   d="scan'208";a="34725133"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 04:01:02 -0700
X-CSE-ConnectionGUID: +Jm/iyHFS6e00adlVPVeHA==
X-CSE-MsgGUID: VFtEGmy5TrKGn9EMpzA2WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,170,1712646000"; 
   d="scan'208";a="32468882"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 18 May 2024 04:00:58 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8Ho8-00027H-1t;
	Sat, 18 May 2024 11:00:56 +0000
Date: Sat, 18 May 2024 19:00:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: Re: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <202405181841.ESCYTmmL-lkp@intel.com>
References: <20240517074750.87376-10-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517074750.87376-10-ramona.bolboaca13@gmail.com>

Hi Ramona,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[cannot apply to linus/master v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240517-155051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240517074750.87376-10-ramona.bolboaca13%40gmail.com
patch subject: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x family
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240518/202405181841.ESCYTmmL-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405181841.ESCYTmmL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405181841.ESCYTmmL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/adis16475.c:523:2: error: incompatible pointer types initializing 'const struct iio_dev_attr *' with an expression of type 'struct attribute *' [-Werror,-Wincompatible-pointer-types]
     523 |         &iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/adis16475.c:524:2: error: incompatible pointer types initializing 'const struct iio_dev_attr *' with an expression of type 'struct attribute *' [-Werror,-Wincompatible-pointer-types]
     524 |         &iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/adis16475.c:525:2: error: incompatible pointer types initializing 'const struct iio_dev_attr *' with an expression of type 'struct attribute *' [-Werror,-Wincompatible-pointer-types]
     525 |         &iio_dev_attr_hwfifo_watermark.dev_attr.attr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/adis16475.c:526:2: error: incompatible pointer types initializing 'const struct iio_dev_attr *' with an expression of type 'struct attribute *' [-Werror,-Wincompatible-pointer-types]
     526 |         &iio_dev_attr_hwfifo_enabled.dev_attr.attr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +523 drivers/iio/imu/adis16475.c

   514	
   515	static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
   516	static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
   517	static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
   518			       adis16475_get_fifo_watermark, NULL, 0);
   519	static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
   520			       adis16475_get_fifo_enabled, NULL, 0);
   521	
   522	static const struct iio_dev_attr *adis16475_fifo_attributes[] = {
 > 523		&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
   524		&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
   525		&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
   526		&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
   527		NULL
   528	};
   529	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

