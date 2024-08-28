Return-Path: <linux-iio+bounces-8835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3590961DC8
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 06:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50286B22151
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 04:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D61494AC;
	Wed, 28 Aug 2024 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbWDjIsx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE177117;
	Wed, 28 Aug 2024 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724820822; cv=none; b=ZApHVM5cgfbFggdmvq9/ebg17wafY96EuoSYqwHvAQhMZhTDGlp5Qt09qSHXKoGAlCcqoc2vYDHVlZIsTsHyDWbj3sL7vMFM8X7SZdHxq3/7OZfnPJvRo6yy7djAv9DE412J9XvJAEu5Rd4pJ6Z20580h3QPsjA8VeqYJcP1DVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724820822; c=relaxed/simple;
	bh=V1yZOu2GId5b6bnaYM6dmXuqDYTml9tYA+NecUp0Zag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmvBBy4nbthomxIxe3HcjMlNmUJky3EnE2JF/P0V5fXSX6jj2onppRkV6ZdZjxBIvZv0adi/D+fA85+Mcqr/pOLEp83vfldRkOqnTz8VOdHjQ5C8oNOrhUQm2EvbxRXmheJ8dRxa2Uq3lf203CvH/Up9UL6bAzydQ3o/TDZkPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbWDjIsx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724820821; x=1756356821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1yZOu2GId5b6bnaYM6dmXuqDYTml9tYA+NecUp0Zag=;
  b=IbWDjIsxUYeIr/954+4Wc2mDyamqyp/oNCyJhB/+4SIca7tXjCjZ3Las
   LAOUlnAWQglGZ4tBrGbl09M9clXZq8hq/YkGr475YdCay/TYX5bmoMyas
   RyIJJhlq6cHnvbyoi6EpS2ZChFba4NFwV0VFtQ0/DVc1oekwLB1+47Yi6
   BIrKaN0r9oYs2bXHodtfeAzOCxNIoQ1hzYr8IKHCfSvnVFfpISfDvJfFB
   vP9BWp432kEN/Swgu/IRvMDf9YUG/h6STn6fGBUPpIAjbxcJycPtd+QYP
   VS3MF3KO0VykkerGxzAZASl/mZsLvIRBS/7FtljX2DO8TGlfG2wer8FWL
   w==;
X-CSE-ConnectionGUID: iCSv7/nySzeRJx9p1DRflw==
X-CSE-MsgGUID: f02qN3y2Sl6vjjJPyVqqQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34737015"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34737015"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 21:53:40 -0700
X-CSE-ConnectionGUID: cQZeiJr2Qa2wN9m847ImQg==
X-CSE-MsgGUID: Dt1q/+H2RlG43n9QpIA1cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="93809470"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Aug 2024 21:53:38 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjAgZ-000KUq-3B;
	Wed, 28 Aug 2024 04:53:35 +0000
Date: Wed, 28 Aug 2024 12:52:45 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: imu: st_lsm6dsx: Remove useless dev_fwnode()
 calls
Message-ID: <202408281240.oT6C3uTj-lkp@intel.com>
References: <20240826212344.866928-3-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826212344.866928-3-andy.shevchenko@gmail.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.11-rc5 next-20240827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-imu-st_lsm6dsx-Use-iio_read_acpi_mount_matrix-helper/20240827-052617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240826212344.866928-3-andy.shevchenko%40gmail.com
patch subject: [PATCH v1 2/2] iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls
config: x86_64-randconfig-122-20240828 (https://download.01.org/0day-ci/archive/20240828/202408281240.oT6C3uTj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408281240.oT6C3uTj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408281240.oT6C3uTj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:62: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] *val @@     got int drdy_pin @@
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:62: sparse:     expected unsigned int [usertype] *val
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:62: sparse:     got int drdy_pin
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:62: sparse: sparse: non size-preserving integer to pointer cast

vim +2137 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c

  2129	
  2130	static int
  2131	st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
  2132				const struct st_lsm6dsx_reg **drdy_reg)
  2133	{
  2134		struct device *dev = hw->dev;
  2135		int err = 0, drdy_pin;
  2136	
> 2137		if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
  2138			struct st_sensors_platform_data *pdata;
  2139	
  2140			pdata = (struct st_sensors_platform_data *)dev->platform_data;
  2141			drdy_pin = pdata ? pdata->drdy_int_pin : 1;
  2142		}
  2143	
  2144		switch (drdy_pin) {
  2145		case 1:
  2146			hw->irq_routing = &hw->settings->irq_config.irq1_func;
  2147			*drdy_reg = &hw->settings->irq_config.irq1;
  2148			break;
  2149		case 2:
  2150			hw->irq_routing = &hw->settings->irq_config.irq2_func;
  2151			*drdy_reg = &hw->settings->irq_config.irq2;
  2152			break;
  2153		default:
  2154			dev_err(hw->dev, "unsupported data ready pin\n");
  2155			err = -EINVAL;
  2156			break;
  2157		}
  2158	
  2159		return err;
  2160	}
  2161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

