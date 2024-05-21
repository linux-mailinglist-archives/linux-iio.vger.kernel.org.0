Return-Path: <linux-iio+bounces-5157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68718CADA5
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F79281C63
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74F757EF;
	Tue, 21 May 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DViXGBwT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C66EB6E;
	Tue, 21 May 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292264; cv=none; b=A/oQl/sqHv4JkZ3NQHANjJ3VLDeHucUAHJoL784hI40v7Xy/2VTFFe418wIqQTuAuDM2lk3PB9zaQdut/gxxB5DK83tF7Ft/egEpIZ2BdwpY+pw5qv7vdEdcGnXd0bDraM228dZ9nqoER+fwEAd/jJsQAi+5EE6zyzVuASgscnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292264; c=relaxed/simple;
	bh=LW2SW54CS7kiFzJ+0X6xF+D2LW3LQDKnImBKOygd46E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZviy8LzWUYjUvKNWEnjy0uUHZh2cHMnoalO/RyiGMkIt0CAf7LZB45z5/2+JYlV5bQ16XGCBBMITf4fhOM0r0MnGaEf1sVE7X9g9GsZ+hzrHRQ7htKAHuW8ZTBlaeH5sAbvUZwCePJAdfK3O8PngHG//RfbF0UXv4cFUlH0vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DViXGBwT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716292262; x=1747828262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LW2SW54CS7kiFzJ+0X6xF+D2LW3LQDKnImBKOygd46E=;
  b=DViXGBwT9bwQ00LBzcz/lG23a7ILjpce/CGFqppRJ1GL/Jqz1oZlaoO7
   PyQTyTQEnUKVh/mBsBAi+O29qLbaE9QowiZQCqAYaREdLmj9000vH/nzv
   nSkQ5J1b40HVQZiOezut6wdvB166EX6ImymPpgpwzyBCKM19uA72egQMn
   X8+pbGuKis1hd5DKZvw7pbA9RzlSbp20+N1D24n5OJSz6Atqq9DG+1kio
   hI8//q/OpzcfYU+7fTJuCrwQhSqoXSUzRVAtxqck/PjIIfG8xGjAlY+ML
   r5v7DH/qvjRo9ljXE4wT9WtDJ1OzGhJrqZ7QL/VFDYUM4/pmg+xxFBCXy
   w==;
X-CSE-ConnectionGUID: wxDvXtzhTNCV6eeQlSQyiA==
X-CSE-MsgGUID: dIceliU+TJe66YidjMH20w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="15425136"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="15425136"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 04:51:01 -0700
X-CSE-ConnectionGUID: wiMzQji1Rc+4RukGpTyyzA==
X-CSE-MsgGUID: aJzOEdKUQN2RouCil4rAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="33489098"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 May 2024 04:50:59 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9O1A-0006K0-0X;
	Tue, 21 May 2024 11:50:56 +0000
Date: Tue, 21 May 2024 19:50:22 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de, swboyd@chromium.org,
	nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <202405211949.0oxrugaN-lkp@intel.com>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.9 next-20240521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240515-083021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: xtensa-randconfig-001-20240521 (https://download.01.org/0day-ci/archive/20240521/202405211949.0oxrugaN-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240521/202405211949.0oxrugaN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405211949.0oxrugaN-lkp@intel.com/

All errors (new ones prefixed by >>):

   `.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o: defined in discarded section `.exit.text' of fs/fuse/inode.o
   `.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o: defined in discarded section `.exit.text' of fs/fuse/inode.o
   xtensa-linux-ld: drivers/base/regmap/regmap-spi.o: in function `__regmap_init_spi':
   regmap-spi.c:(.text+0x17c): undefined reference to `spi_write_then_read'
   xtensa-linux-ld: regmap-spi.c:(.text+0x1a2): undefined reference to `spi_write_then_read'
   xtensa-linux-ld: drivers/base/regmap/regmap-spi.o: in function `__devm_regmap_init_spi':
   regmap-spi.c:(.text+0x2a0): undefined reference to `spi_sync'
   xtensa-linux-ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_async_alloc':
   regmap-spi.c:(.text+0x372): undefined reference to `spi_sync'
   xtensa-linux-ld: drivers/base/regmap/regmap-spi.o: in function `spi_sync_transfer.constprop.0':
   regmap-spi.c:(.text+0x3f4): undefined reference to `spi_async'
   xtensa-linux-ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_write':
   regmap-spi.c:(.text+0x53e): undefined reference to `spi_async'
   xtensa-linux-ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_async_write':
   regmap-spi.c:(.text+0x6eb): undefined reference to `spi_sync'
   xtensa-linux-ld: drivers/iio/dac/ad9739a.o:(.init.literal+0x8): undefined reference to `__spi_register_driver'
   xtensa-linux-ld: drivers/iio/dac/ad9739a.o: in function `ad9739a_driver_init':
   ad9739a.c:(.init.text+0x1e): undefined reference to `__spi_register_driver'
   xtensa-linux-ld: drivers/iio/proximity/hx9031as.o: in function `hx9031as_manual_offset_calibration_store':
   hx9031as.c:(.text.unlikely+0x15e8): undefined reference to `__udivdi3'
>> xtensa-linux-ld: hx9031as.c:(.text.unlikely+0x167f): undefined reference to `__udivdi3'
   xtensa-linux-ld: drivers/iio/proximity/hx9031as.o: in function `schedule_delayed_work.constprop.0.isra.0':
   hx9031as.c:(.text.unlikely+0x18ca): undefined reference to `__udivdi3'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [y]:
   - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

