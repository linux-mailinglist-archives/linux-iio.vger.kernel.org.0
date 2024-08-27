Return-Path: <linux-iio+bounces-8827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF26960FC7
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9526284B4B
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC712B93;
	Tue, 27 Aug 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KX9H5cus"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5F1C6890;
	Tue, 27 Aug 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770908; cv=none; b=uf38dW9/y5Ib5D9rArEpWRLuZVbSftrtq49xHwlPbHDjTDvILU7YxmI9WGcUhrI1nKlIFZKVOh93LXIFHrQdRZsbeTjWTLAdlovR8ojcpMeaxPrxd8G+H/TkM2YYVd2WE4bhWiTdrtLYbQfIXU4fsRD8g4ZTyFavqRJKDOKsVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770908; c=relaxed/simple;
	bh=04kzWfhg4OiC07BgSws7MX2zfVTZd9v2ch1ZbqtW5ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSFfXoHhPX99kq5Ahn8hh8MK0iooyR4Es4XXYfZLOl7c9RecOljI38MD4fTTzN/Opcs5ekNZ+P2j469k6RtML9rSqB+liBpuoPCDV7YuCcK0xxXOyT5vPeXcrzeTUJxRJ0X9J+8WQN0EkI64bYk39+N6kkwXAlPtJDF/+geDTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KX9H5cus; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724770906; x=1756306906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=04kzWfhg4OiC07BgSws7MX2zfVTZd9v2ch1ZbqtW5ps=;
  b=KX9H5cusryTRHwSHUaC8KS2Zm+6gJT97XM6Kv10F4UCiHiUUFd0Vvy6/
   RLoIWb7Loq540CCKRqffLg//0zgNT6hls4Trkfu+ctOtQiQ3RFLv6tdXu
   qin4YKZfeNeBLjJsq0aRLwnU7A8C/oMbH7ruVVOJCaoAo3hD+AhgSbK9W
   LCPSe/hfm+tj63vLvRfrBFqOZn0xZG0PRrxUL+Edwfb1bokfDqiIWCv8/
   v+HlZZK+D96BuneR2Gj0WbeYOe0gg/a5jkexPhh2T4WpdIqsAHakPp3D4
   OsXpKOdHvadxZFZeseLPtMb4MeHZe+3d+PCmERXlcTYZEdWEL86TBGTRy
   w==;
X-CSE-ConnectionGUID: 9EWADjsJQfmYKoq8js5mjA==
X-CSE-MsgGUID: dlbllQ1eT6ymxz4VBA34eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23429064"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23429064"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 08:01:36 -0700
X-CSE-ConnectionGUID: k6CJQLvEQUqqBOszqa8vMw==
X-CSE-MsgGUID: Vgoj9oVMSDqI06rGum72KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="86087616"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Aug 2024 08:01:34 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sixhL-000J6S-2L;
	Tue, 27 Aug 2024 15:01:31 +0000
Date: Tue, 27 Aug 2024 23:01:25 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: imu: st_lsm6dsx: Remove useless dev_fwnode()
 calls
Message-ID: <202408272259.MsdckhWn-lkp@intel.com>
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
config: arc-randconfig-001-20240827 (https://download.01.org/0day-ci/archive/20240827/202408272259.MsdckhWn-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408272259.MsdckhWn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408272259.MsdckhWn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c: In function 'st_lsm6dsx_get_drdy_reg':
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:62: warning: passing argument 3 of 'device_property_read_u32' makes pointer from integer without a cast [-Wint-conversion]
    2137 |         if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
         |                                                              ^~~~~~~~
         |                                                              |
         |                                                              int
   In file included from include/linux/acpi.h:16,
                    from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:76:
   include/linux/property.h:229:71: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'int'
     229 |                                            const char *propname, u32 *val)
         |                                                                  ~~~~~^~~
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:13: warning: 'drdy_pin' is used uninitialized [-Wuninitialized]
    2137 |         if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2135:22: note: 'drdy_pin' was declared here
    2135 |         int err = 0, drdy_pin;
         |                      ^~~~~~~~


vim +/device_property_read_u32 +2137 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c

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

