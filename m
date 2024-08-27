Return-Path: <linux-iio+bounces-8828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB769611C1
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6351F23E0F
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3F1C6F55;
	Tue, 27 Aug 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNkwqFLd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7001C68BD;
	Tue, 27 Aug 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772173; cv=none; b=p8kQ7BLoEmnWH0+usWxMM/NWFxvUYXXSfxKLVQXQjkl/NHBwo4maX8Fg6z5KhiarK5MC8eTMF488WvFaYYmF04bupa799HKEN3nFE9G6uqtQssydK5wsub4hgIpaEnlR1pQEXKg6uxgLZ8nGjKNqMnTrzXVuzZecrWiXoJghIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772173; c=relaxed/simple;
	bh=7qXMJi9JOU9nntdkpteu2ojSeQ24TNEcx8FDTGb2clM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q31PVCrbTPVHwEJhwSqFO4Z1oY1y9yjiQ4AuKTYf975mP6UyYqz8ave6J0NK0yENTlIder1DahKTutX2CqIURop8rSsoHYqfQ3DjYL/4ADsidYSOeK78K/51zQhuJXz/2agQpqAmSAOjgNzC98tt61E39QTCq+Pu6h9aQk3UG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNkwqFLd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724772171; x=1756308171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7qXMJi9JOU9nntdkpteu2ojSeQ24TNEcx8FDTGb2clM=;
  b=XNkwqFLduAYU/Z3IoTplUWjq5iFd0HAogQVgObew4vqWfpCA1qRViMj+
   /RfOvThbUjdjNwK3DMfAmFf0wxhGneznxtO4fBQPRqf0lUCL+KvGFLVFl
   hyrhyNIsTslV8HUPlxw7RXqxO5lTaajPAKIcmUCCb2HGH9Bkd67BgVv+S
   BESUCbnikJzXdAT/Yt0WUYxG74gXsYozdwgYnwbycPXPQSNO2hxhOA+Tl
   3lDl8oErfzaLEs3BIqk56ySJpj2+tJsFfY66kzczpfBdOT8G4Y58MALcD
   HJYfvjgkxRZIM4CfdIxLjlZipym8zul/NYGOwac+3RmgThElonG93yaW9
   Q==;
X-CSE-ConnectionGUID: O89DUGkkQtKq03sd/78e8w==
X-CSE-MsgGUID: wTum0RY+QUCYqwCHSwBMcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23059181"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23059181"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 08:22:50 -0700
X-CSE-ConnectionGUID: Lyq+Vl9JTW2Od2mvhlmZRA==
X-CSE-MsgGUID: 6sopaUusQ42/+CHkftjt9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62561480"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 27 Aug 2024 08:22:48 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siy1u-000JVh-0G;
	Tue, 27 Aug 2024 15:22:46 +0000
Date: Tue, 27 Aug 2024 23:22:21 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: imu: st_lsm6dsx: Remove useless dev_fwnode()
 calls
Message-ID: <202408272315.6tUsOdsF-lkp@intel.com>
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
config: arm64-randconfig-002-20240827 (https://download.01.org/0day-ci/archive/20240827/202408272315.6tUsOdsF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408272315.6tUsOdsF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408272315.6tUsOdsF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:55: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'u32 *' (aka 'unsigned int *') [-Wint-conversion]
           if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
                                                                ^~~~~~~~
   include/linux/property.h:229:36: note: passing argument to parameter 'val' here
                                              const char *propname, u32 *val)
                                                                         ^
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:55: warning: variable 'drdy_pin' is uninitialized when used here [-Wuninitialized]
           if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
                                                                ^~~~~~~~
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2135:23: note: initialize the variable 'drdy_pin' to silence this warning
           int err = 0, drdy_pin;
                                ^
                                 = 0
   2 warnings generated.


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

