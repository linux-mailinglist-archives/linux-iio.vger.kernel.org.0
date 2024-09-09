Return-Path: <linux-iio+bounces-9414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7297251D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 00:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F0D28589E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 22:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8918CBF2;
	Mon,  9 Sep 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cx8Wt3aq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012417C9F8;
	Mon,  9 Sep 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920051; cv=none; b=Cc+UIw/+NRHeAQ/npRk4welzoUU6GCMcqY2cR/npXRn2vOx07qmGioNPDrIREBDNIVu12RkDTvg5XdFygcDIsSyy2ddzd88BIQKKw1WVkp0FnAEBCSorP5YomL4bubZ/puOYS6zUYcDgMdRLM2+XbccctaBwLlKorvOvEMUK5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920051; c=relaxed/simple;
	bh=jvN8sC2/dr+G1inFZ8r97yDKB0LTL5Q7/RvJPmJJyxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvPm+Mivz6495Vb9PyIfkRGvss+H07vFM/iszCGKuAUltP69pi5XL4053s5K48Y+/51fkQZq5GnXZCQhLr7YVcUir7QM0fQwz993QurTBz+dnPy3RFVDuyXyB3Adbisz+aPNjnajGbfVzZelabrXKK9HamhTXqvK3Bt9eBw68gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cx8Wt3aq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725920049; x=1757456049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jvN8sC2/dr+G1inFZ8r97yDKB0LTL5Q7/RvJPmJJyxE=;
  b=Cx8Wt3aqVMfzAJRQkFs2RLNG4LCn5E0AUaNdUSLMhtE7zZxWzqwHYZCb
   rrNwrRsA3scLrCM8IIdcvXS+7NMgCSNUvH2rly0pKjY5BufZYk5xF3y4B
   ejBhVrw2VUl8bhsQrA439e7ZGnH4IoJmbH/7+5hajULp2VHHBR4Uh19Sy
   hZkAR47ZXUh1ShAS1EZu4SLV0Xc9NXyLMizGGUmJjRSpsAXCmuuhdj4Bo
   UyxgaKUViiXSiL9L+RKHk7PRwg85/IPer7rVTQ2MLevjxBwJhNjWn3ruX
   hswSO7l3DSd6VkPqknQgKHIrPUFqe8udU7gP6cMHj3E9EYSyYFhLoFJuj
   A==;
X-CSE-ConnectionGUID: vDAi8aPdTCW8FdovEKs+fQ==
X-CSE-MsgGUID: iPoV8M9WTn2mdzKr9I5ArA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28421579"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="28421579"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 15:14:08 -0700
X-CSE-ConnectionGUID: HyRBTsnUQw+T+ZqgWwV4Og==
X-CSE-MsgGUID: YGJ/y2TbSFCKuH5/h5eGkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="66857798"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Sep 2024 15:14:05 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snme2-000FH6-21;
	Mon, 09 Sep 2024 22:14:02 +0000
Date: Tue, 10 Sep 2024 06:13:04 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <202409100526.LydCADNj-lkp@intel.com>
References: <20240909043254.611589-3-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909043254.611589-3-lanzano.alex@gmail.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.11-rc7 next-20240909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Lanzano/dt-bindings-iio-imu-add-bmi270-bindings/20240909-123509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240909043254.611589-3-lanzano.alex%40gmail.com
patch subject: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240910/202409100526.LydCADNj-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100526.LydCADNj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409100526.LydCADNj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/imu/bmi270/bmi270_core.c:180:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     180 |                               FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
         |                               ^
   7 warnings and 1 error generated.


vim +/FIELD_PREP +180 drivers/iio/imu/bmi270/bmi270_core.c

   165	
   166	static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
   167	{
   168		int ret;
   169		struct device *dev = bmi270_device->dev;
   170		struct regmap *regmap = bmi270_device->regmap;
   171	
   172		ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
   173				      BMI270_PWR_CTRL_AUX_EN_MSK |
   174				      BMI270_PWR_CTRL_GYR_EN_MSK |
   175				      BMI270_PWR_CTRL_ACCEL_EN_MSK);
   176		if (ret)
   177			return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
   178	
   179		ret = regmap_set_bits(regmap, BMI270_ACC_CONF_REG,
 > 180				      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
   181						 BMI270_ACC_CONF_ODR_100HZ) |
   182				      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
   183						 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
   184				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
   185		if (ret)
   186			return dev_err_probe(dev, ret, "Failed to configure accelerometer");
   187	
   188		ret = regmap_set_bits(regmap, BMI270_GYR_CONF_REG,
   189				      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
   190						 BMI270_GYR_CONF_ODR_200HZ) |
   191				      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
   192						 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
   193				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
   194		if (ret)
   195			return dev_err_probe(dev, ret, "Failed to configure gyroscope");
   196	
   197		/* Enable FIFO_WKUP, Disable ADV_PWR_SAVE and FUP_EN */
   198		ret = regmap_write(regmap, BMI270_PWR_CONF_REG,
   199				   BMI270_PWR_CONF_FIFO_WKUP_MSK);
   200		if (ret)
   201			return dev_err_probe(dev, ret, "Failed to set power configuration");
   202	
   203		return 0;
   204	}
   205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

