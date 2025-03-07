Return-Path: <linux-iio+bounces-16526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BCA56A3C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A1189AEA9
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E921B9F1;
	Fri,  7 Mar 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aylFrI/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE021B9CE;
	Fri,  7 Mar 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357342; cv=none; b=FOdqOwUOk9Sv6uozHy/QNINQ6CQ4RVY/NbkJlgQbMpDenivBmCbXf/x4q3btNmkh9GJCjPos6fWzucGd6TM+rO31WWYpBX5wB778nuQlKSyXWo67ax9jbr9rISJud/JfqbK+AMQSA4FGxCv0bmcSt1tPQ9zBW/eMGGNnVZ2YkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357342; c=relaxed/simple;
	bh=Xq0iwcDh7S4jmFV/WUP4gOkUzHiVYQo8h95MoE9/hh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPvHRuW8aIaF+r/G69LhMQjMq1jKj22ehCqzfTDJ3ECjfi8wUxBy23BrIrbH87MxRLNhqrM+nYA63Ic9CWWMQ8j+0CjgykbRI4pVWYB/TSwV0S+B7+vTlKyaPeOMdXSh4Hnmr1LTcZYEVkWOUNqPmmQ4I5KVlW1B2OW1t62YPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aylFrI/M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741357340; x=1772893340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xq0iwcDh7S4jmFV/WUP4gOkUzHiVYQo8h95MoE9/hh0=;
  b=aylFrI/MiF/8bLt5ceuyurxWJDqHTU8pSZKi5Y33N7y0NWnC+sbeB70b
   zOs8b9sS5nGSeieMVrdr8O7lPH6VsOU9IxpkljhQP+S7T4YWf4ZW/oCqT
   SW5bDPxpMWdQmy0oJgzQG0xXyyArCTcmdcIoNh5E+pmCBvNWE05o7o+Fy
   kXoTkJpark5leyNUQJy3N44Ju8tUIDfeGLCpnztoXm+aCSxURD/7FYfJl
   L1Hpmiz1yTNkcpb8dvb56YkcEmtB6xSbyfQa/T4XEXNRw9XGcO6IvjgVd
   2tJ8Xz7dRlV+16WQ/HFmlC3EdjMUEKKVdCIf3JvtTUrVw2EQB0vft9pDJ
   g==;
X-CSE-ConnectionGUID: UZK/TksyQCi4r8lFQQzvHw==
X-CSE-MsgGUID: YIiyeMnVSROIjYRXWZ2/WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53042140"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53042140"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:22:19 -0800
X-CSE-ConnectionGUID: 5CF1E6FQR2CSWgcWhZHL5g==
X-CSE-MsgGUID: 1+VCvBl2Tx+8X9gueM0WGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150280816"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Mar 2025 06:22:16 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqYac-0000ZH-1A;
	Fri, 07 Mar 2025 14:22:14 +0000
Date: Fri, 7 Mar 2025 22:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: Jorge Marques <jorge.marques@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jorge Marques <jorge.marques@analog.com>
Subject: Re: [PATCH 4/4] iio: adc: add support for ad4052
Message-ID: <202503080031.APfLdyiz-lkp@intel.com>
References: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>

Hi Jorge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aac287ec80d71a7ab7e44c936a434625417c3e30]

url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Marques/iio-code-mark-iio_dev-as-const-in-iio_buffer_enabled/20250306-220719
base:   aac287ec80d71a7ab7e44c936a434625417c3e30
patch link:    https://lore.kernel.org/r/20250306-iio-driver-ad4052-v1-4-2badad30116c%40analog.com
patch subject: [PATCH 4/4] iio: adc: add support for ad4052
config: um-randconfig-r073-20250307 (https://download.01.org/0day-ci/archive/20250308/202503080031.APfLdyiz-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503080031.APfLdyiz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503080031.APfLdyiz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad4052.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/adc/ad4052.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/adc/ad4052.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/iio/adc/ad4052.c:201:41: warning: unused variable 'ad4052_regmap_rd_table' [-Wunused-const-variable]
     201 | static const struct regmap_access_table ad4052_regmap_rd_table = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ad4052.c:214:41: warning: unused variable 'ad4052_regmap_wr_table' [-Wunused-const-variable]
     214 | static const struct regmap_access_table ad4052_regmap_wr_table = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ad4052.c:239:18: warning: unused variable 'ad4052_sample_rate_avail' [-Wunused-const-variable]
     239 | static const int ad4052_sample_rate_avail[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   15 warnings generated.


vim +/ad4052_regmap_rd_table +201 drivers/iio/adc/ad4052.c

   200	
 > 201	static const struct regmap_access_table ad4052_regmap_rd_table = {
   202		.yes_ranges = ad4052_regmap_rd_ranges,
   203		.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_rd_ranges),
   204	};
   205	
   206	static const struct regmap_range ad4052_regmap_wr_ranges[] = {
   207		regmap_reg_range(AD4052_REG_INTERFACE_CONFIG_A, AD4052_REG_DEVICE_CONFIG),
   208		regmap_reg_range(AD4052_REG_SCRATCH_PAD, AD4052_REG_SCRATCH_PAD),
   209		regmap_reg_range(AD4052_REG_STREAM_MODE, AD4052_REG_INTERFACE_STATUS),
   210		regmap_reg_range(AD4052_REG_MODE_SET, AD4052_REG_MON_VAL),
   211		regmap_reg_range(AD4052_REG_FUSE_CRC, AD4052_REG_DEVICE_STATUS),
   212	};
   213	
 > 214	static const struct regmap_access_table ad4052_regmap_wr_table = {
   215		.yes_ranges = ad4052_regmap_wr_ranges,
   216		.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_wr_ranges),
   217	};
   218	
   219	static const struct iio_event_spec ad4052_events[] = {
   220		{
   221			.type = IIO_EV_TYPE_THRESH,
   222			.dir = IIO_EV_DIR_EITHER,
   223			.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE)
   224		},
   225		{
   226			.type = IIO_EV_TYPE_THRESH,
   227			.dir = IIO_EV_DIR_RISING,
   228			.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
   229					      BIT(IIO_EV_INFO_HYSTERESIS)
   230		},
   231		{
   232			.type = IIO_EV_TYPE_THRESH,
   233			.dir = IIO_EV_DIR_FALLING,
   234			.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
   235					      BIT(IIO_EV_INFO_HYSTERESIS)
   236		}
   237	};
   238	
 > 239	static const int ad4052_sample_rate_avail[] = {
   240		2000000, 1000000, 300000, 100000, 33300,
   241		10000, 3000, 500, 333, 250, 200,
   242		166, 140, 125, 111
   243	};
   244	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

