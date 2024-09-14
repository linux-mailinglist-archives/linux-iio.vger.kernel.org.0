Return-Path: <linux-iio+bounces-9534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2738978C74
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 03:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21041C25356
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF148BE8;
	Sat, 14 Sep 2024 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGpB6VHd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A025748D;
	Sat, 14 Sep 2024 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726278283; cv=none; b=QlVgeThqpa7tNkO8mq13drjMcaQ3f0GJMXmUaN2xLDGTbbSS9JhItvGP366Hc4vZfLrMbOFUjkEFkv6OHK4cP3RDPm264iDEPSe4uT+Ts2+PmAxJfxKnMfgAt7diIe0Ug8OEjXR5VXkfiLk3aWHZATjs6MmlrN+iBammDT3kPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726278283; c=relaxed/simple;
	bh=iLGIsaLTMLN5+yfFHCAWEL882yp38PL3qxmT0t2FzKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKTdGxVfJvGN9d1M16tDzkqBpjGTPxAYp9OJ3yw+uyt8Mow0XipU+CMtoukKI5M5MEXIwhnXCils7+9W7HUFx/dvrpxwKJd5G9Lz+p4OBPwsaV9VObReE9ClA/SglPdC90LlhimIlbB9SU00c9d7m/8erQIsk0fneiMUucA5IgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGpB6VHd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726278282; x=1757814282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iLGIsaLTMLN5+yfFHCAWEL882yp38PL3qxmT0t2FzKQ=;
  b=gGpB6VHdUo41TbB11g6/yGmVNj+GtDCZE/mFl1hON9FMkM+i1PdEwqUH
   x9qyScoqpMcN5G/RbMOD9p2lj9Ux/W1/u24oxw+Kz9wI8kTq9EwUJqVSi
   xg4+yEoThvNhPLojeijPATljIog54nHgOJOrZiwRj9LDVw+buYuSZDpSO
   U3PUl9YITeyEI2/6aNRHIAQbHl2lo3IMORs3aAVLUBO2n2mh7ME9WUQNd
   GBJD09wa/xUKSdjqsQ8kO1su7OTbcRIbswUnJpwwj4pOHiSYwp9Q7z8dx
   Uyu2cKzj6/FpLimJs8QmPPIoz6IGNJAT52/euqganp2QUocMWQ1KUSh9k
   Q==;
X-CSE-ConnectionGUID: kTPH5JJoQ466ZNaV3+9LPg==
X-CSE-MsgGUID: N59k2577QNGJ7iZ7SPuTjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28978689"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28978689"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 18:44:41 -0700
X-CSE-ConnectionGUID: bADnWdd0R3a9MFHG4j/syg==
X-CSE-MsgGUID: qISTvLKgSNW4o6+EzSGfCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="67887817"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Sep 2024 18:44:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spHpw-0007Ei-1s;
	Sat, 14 Sep 2024 01:44:32 +0000
Date: Sat, 14 Sep 2024 09:44:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <202409140955.bz1rH7Q6-lkp@intel.com>
References: <20240912121609.13438-4-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912121609.13438-4-ramona.nechita@analog.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Alexandra-Nechita/dt-bindings-iio-adc-add-a7779-doc/20240912-201936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240912121609.13438-4-ramona.nechita%40analog.com
patch subject: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240914/202409140955.bz1rH7Q6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140955.bz1rH7Q6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140955.bz1rH7Q6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad7779.c:15:
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
   In file included from drivers/iio/adc/ad7779.c:15:
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
   In file included from drivers/iio/adc/ad7779.c:15:
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
   In file included from drivers/iio/adc/ad7779.c:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/adc/ad7779.c:748:35: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     748 |                 return dev_err_probe(&spi->dev, ret,
         |                                                 ^~~
   drivers/iio/adc/ad7779.c:735:9: note: initialize the variable 'ret' to silence this warning
     735 |         int ret;
         |                ^
         |                 = 0
   8 warnings generated.


vim +/ret +748 drivers/iio/adc/ad7779.c

   729	
   730	static int ad7779_probe(struct spi_device *spi)
   731	{
   732		struct iio_dev *indio_dev;
   733		struct ad7779_state *st;
   734		struct gpio_desc *reset_gpio, *start_gpio;
   735		int ret;
   736	
   737		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
   738		if (!indio_dev)
   739			return -ENOMEM;
   740	
   741		st = iio_priv(indio_dev);
   742	
   743		st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
   744		if (IS_ERR(st->mclk))
   745			return PTR_ERR(st->mclk);
   746	
   747		if (!spi->irq)
 > 748			return dev_err_probe(&spi->dev, ret,
   749					     "DRDY irq not present\n");
   750	
   751		reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
   752		if (IS_ERR(reset_gpio))
   753			return PTR_ERR(reset_gpio);
   754	
   755		start_gpio = devm_gpiod_get(&spi->dev, "start", GPIOD_OUT_HIGH);
   756		if (IS_ERR(start_gpio))
   757			return PTR_ERR(start_gpio);
   758	
   759		crc8_populate_msb(ad7779_crc8_table, AD7779_CRC8_POLY);
   760		st->spi = spi;
   761	
   762		st->chip_info = spi_get_device_match_data(spi);
   763		if (!st->chip_info)
   764			return -ENODEV;
   765	
   766		ret = ad7779_reset(indio_dev, reset_gpio);
   767		if (ret)
   768			return ret;
   769	
   770		ad7779_powerup(st, start_gpio);
   771		if (ret)
   772			return ret;
   773	
   774		indio_dev->name = st->chip_info->name;
   775		indio_dev->info = &ad7779_info;
   776		indio_dev->modes = INDIO_DIRECT_MODE;
   777		indio_dev->channels = st->chip_info->channels;
   778		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
   779	
   780		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
   781						  indio_dev->name, iio_device_id(indio_dev));
   782		if (!st->trig)
   783			return -ENOMEM;
   784	
   785		st->trig->ops = &ad7779_trigger_ops;
   786	
   787		iio_trigger_set_drvdata(st->trig, st);
   788	
   789		ret = devm_request_irq(&spi->dev, spi->irq,
   790				      iio_trigger_generic_data_rdy_poll,
   791				      IRQF_ONESHOT | IRQF_NO_AUTOEN,
   792				      indio_dev->name, st->trig);
   793		if (ret)
   794			return dev_err_probe(&spi->dev, ret, "request irq %d failed\n",
   795					     st->spi->irq);
   796	
   797		ret = devm_iio_trigger_register(&spi->dev, st->trig);
   798		if (ret)
   799			return ret;
   800	
   801		indio_dev->trig = iio_trigger_get(st->trig);
   802	
   803		init_completion(&st->completion);
   804	
   805		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
   806						      &iio_pollfunc_store_time,
   807						      &ad7779_trigger_handler,
   808						      &ad7779_buffer_setup_ops);
   809		if (ret)
   810			return ret;
   811	
   812		ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
   813					    AD7779_DCLK_CLK_DIV_MSK,
   814					    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
   815		if (ret)
   816			return ret;
   817	
   818		return devm_iio_device_register(&spi->dev, indio_dev);
   819	}
   820	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

