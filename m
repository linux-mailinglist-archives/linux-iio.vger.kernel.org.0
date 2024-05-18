Return-Path: <linux-iio+bounces-5093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B273B8C8FD7
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2024 08:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51501C2115F
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2024 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654EC152;
	Sat, 18 May 2024 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYW0iaNw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33ABE68;
	Sat, 18 May 2024 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716014886; cv=none; b=nh9mNdSbOjv5XTsR95Uzs8fdeMH41g0iUysuMz6zm2TJItfegPDGjfdBk9Ce1QiPh9NMAG3ow8NBDQUDUpWfxMltmJM9NWHi9BzhCeKlddLg3/kxLzpy9HgMHJg5asNBx5BIT6XHY8VhQcTJ88lyuw1wmTRTA8TR/7tqgZpxZ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716014886; c=relaxed/simple;
	bh=FqnqE+UrA/fKF5auAZ7YdoJp5gk2IOZmUMnphQzmxF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNyYHVmY5Q2v/h99ff1bwwe6jCYO1kVcf4KTRdfakh0V1/6oSQ3uNHl356Tf4pdKkbE20RrVJtE7OJJSdni43r/GnQhpNOy1w1x5St0vfnvh0eVWhy26P6BSY/tklg2C7Xhe+LinfB4z8rA5c6nPuJkY7QxVPM7E+24yPlhYD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYW0iaNw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716014884; x=1747550884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FqnqE+UrA/fKF5auAZ7YdoJp5gk2IOZmUMnphQzmxF8=;
  b=PYW0iaNwQztAkd3gw2pXHFxAw3cEewTMc0e5H0NE4m5AFqD0DCP19Ezb
   3vhpVSCFbFThoFXOi3+bMgmIARgBC5JL78a5mhMhPWyRvZKS/jZildCrr
   4KZl12vCtLR29iSfjHim3ioYH2MmOFbsnmJnuwuO3L4LlFgD+RrhSPatB
   M4WNZ/h/l59CCNwqaipnYyga87GYHUSZ0SwTr0orXuUDUC+wKuuTD3EQM
   QqzON8WNY3WiW4Y6rQRIS2Gqmuf8/cp6I4+Gb9TjQCMmucn0NkPL9XzUx
   a1yvmkm3nGXdij/K6ND3fKaAuztsNNPKLasnBuuJ0NTIzae2M8YeXp4Un
   Q==;
X-CSE-ConnectionGUID: 7wnIvbooS8y8Y7phEgAxaA==
X-CSE-MsgGUID: 6suTzOH2Qwq1wFj30dbc3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="29717423"
X-IronPort-AV: E=Sophos;i="6.08,170,1712646000"; 
   d="scan'208";a="29717423"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 23:48:04 -0700
X-CSE-ConnectionGUID: Cf6NzLpSRaC16HiIPZ+7IQ==
X-CSE-MsgGUID: GZ4fJXaAQTSnnddtE/LBFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,170,1712646000"; 
   d="scan'208";a="32037538"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 23:48:00 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8DrK-0001hk-1r;
	Sat, 18 May 2024 06:47:58 +0000
Date: Sat, 18 May 2024 14:47:01 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: Re: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <202405181400.174vWAhr-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240518/202405181400.174vWAhr-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405181400.174vWAhr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405181400.174vWAhr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/adis16475.c:523:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]
     523 |         &iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
         |         ^
   drivers/iio/imu/adis16475.c:523:9: note: (near initialization for 'adis16475_fifo_attributes[0]')
   drivers/iio/imu/adis16475.c:524:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]
     524 |         &iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
         |         ^
   drivers/iio/imu/adis16475.c:524:9: note: (near initialization for 'adis16475_fifo_attributes[1]')
   drivers/iio/imu/adis16475.c:525:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]
     525 |         &iio_dev_attr_hwfifo_watermark.dev_attr.attr,
         |         ^
   drivers/iio/imu/adis16475.c:525:9: note: (near initialization for 'adis16475_fifo_attributes[2]')
   drivers/iio/imu/adis16475.c:526:9: error: initialization of 'const struct iio_dev_attr *' from incompatible pointer type 'struct attribute *' [-Werror=incompatible-pointer-types]
     526 |         &iio_dev_attr_hwfifo_enabled.dev_attr.attr,
         |         ^
   drivers/iio/imu/adis16475.c:526:9: note: (near initialization for 'adis16475_fifo_attributes[3]')
   cc1: some warnings being treated as errors


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

