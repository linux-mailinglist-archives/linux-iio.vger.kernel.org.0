Return-Path: <linux-iio+bounces-5512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D7F8D5069
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 19:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE231F2465F
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894833D57A;
	Thu, 30 May 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XizQfk3r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7F4596F;
	Thu, 30 May 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088580; cv=none; b=hMbw6N8gvZluZn/9Ck9te1Va9xJ7Xq7JuQIiHyzpMYXdqblo3hmM0O7DVM1/St0lkSXEQVDPeIT+/ASVTBtYjv3B+XZmPOC0jhGDDMwHTP5cPXTDznUbOk85tvCaZcexacp70ZrFkDs7zqcbapLP9q4nryyZFnULn4i0jSH5yno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088580; c=relaxed/simple;
	bh=GzKBrhX5Mrx9Fgc9D6BndebC2wOUB3k5OXpy4LjwLAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ16UypkJZAFviK+YMFV2atez0DKt0H9DrRCcsXXzXDVWX97J7NHhI8UOUr+p2hYhbTiawV2r+Z3yvEnnyBgsg5IU4dZDqPNi+tGEC3dLy4zybxcFql01TLO7QIA1hT8SXOOtH+/3EumDaqLDD2F4gLnv5KKU571sYuyt8i7pUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XizQfk3r; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717088579; x=1748624579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GzKBrhX5Mrx9Fgc9D6BndebC2wOUB3k5OXpy4LjwLAI=;
  b=XizQfk3rwPdG7H1XhHzikjCqPO/SKI2xi5oIRL95CuOA7Gl11VEQpYnZ
   dUkYhwY6ZXRzidEdL6BjwUR/qBXl7gMauULPxyiVAXjl359gKvggTQLGv
   bd9LXXkeNR9RTGFZXPFHxPUMFcvzKJXIVOAqEwSWh4IRMVQezYDhsG3T2
   N3+s1/j5fQSuL4Weg0xez5SQ7oZehA0DscG0bKD0+9LglS8UYFJ4d+I1A
   2MEKi6S9D4KKuQ9EqcJstHH9s1Oha/e/vd27MVPGUBN5VxA0qikxvBE/Z
   Xd56sDP/FnijvDqvjSOCLajt5fUB9CKSu7JrC/ALZdxEqR66cKQaTSpX1
   g==;
X-CSE-ConnectionGUID: y06dZQmlRXKFIjdIZaD2IQ==
X-CSE-MsgGUID: 2UAwSuzGSPCfDJcabOji4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13427037"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13427037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:02:58 -0700
X-CSE-ConnectionGUID: uT4hl57ESmGK08yFumAB6w==
X-CSE-MsgGUID: kWjRMTdeSHSE/jmK1rO54Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66746145"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 30 May 2024 10:02:55 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCjAn-000Fl7-1F;
	Thu, 30 May 2024 17:02:51 +0000
Date: Fri, 31 May 2024 00:59:19 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy.shevchenko@gmail.com,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.a@analog.com,
	swboyd@chromium.org, u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com, yasin.lee.x@outlook.com
Subject: Re: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <202405310010.dSPEpCuu-lkp@intel.com>
References: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9023s-Add-TYHX-HX9023S-sensor-driver/20240529-170307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB81019AB7F38806097F2C8A34A4F22%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
config: hexagon-randconfig-r062-20240530 (https://download.01.org/0day-ci/archive/20240531/202405310010.dSPEpCuu-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310010.dSPEpCuu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310010.dSPEpCuu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/proximity/hx9023s.c:10:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/iio/proximity/hx9023s.c:10:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/iio/proximity/hx9023s.c:10:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/iio/proximity/hx9023s.c:556:9: error: implicit declaration of function 'FIELD_GET' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           *val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
                  ^
   drivers/iio/proximity/hx9023s.c:570:9: error: implicit declaration of function 'FIELD_GET' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           *val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
                  ^
   6 warnings and 2 errors generated.


vim +/FIELD_GET +556 drivers/iio/proximity/hx9023s.c

   545	
   546	static int hx9023s_read_far_debounce(struct hx9023s_data *data, int *val)
   547	{
   548		int ret;
   549	
   550		ret = regmap_read(data->regmap, HX9023S_PROX_INT_LOW_CFG, val);
   551		if (ret < 0) {
   552			dev_err(&data->client->dev, "i2c read failed\n");
   553			return ret;
   554		}
   555	
 > 556		*val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
   557		return IIO_VAL_INT;
   558	}
   559	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

