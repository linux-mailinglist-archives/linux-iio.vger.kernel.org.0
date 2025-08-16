Return-Path: <linux-iio+bounces-22778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16054B28C03
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0C83ADFE8
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE52156237;
	Sat, 16 Aug 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTrhJzbD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769A13AD26;
	Sat, 16 Aug 2025 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334033; cv=none; b=cIIil1UQfg/3OnuDPWRyo9K1xmSFyyCXzvnoR8RCeGJcSLFivVgENEqkMkVCIxLJ2PAbHmMf1pH2pZJMjxzxzWvAcj/19kNi876aBKfjobhhkOFseLZf3K1CoISHkOPuH5WTjIgQAGrmiM77+BbZOqjCkvcNFoVDOB4f0A33IIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334033; c=relaxed/simple;
	bh=X/tWkuenMGUH8KB0IxKz5clw88ySLexKQReiGWiI9HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ+mdXz8Ru+dFBnLtdiTrG+LDJ5KKuAFYKQy/j/NqFjpw6XIzqo4a6fxkMQv080/wSCx/uUYGWDLqcIvjajaWnguagmtt2eTrzbcaesGwmKSRwejUwFkPrqHmCXGX8rk49SpkCyu2KRkJDm3zyk40REm+JKS4qKSRGwGYpK3z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTrhJzbD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755334031; x=1786870031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X/tWkuenMGUH8KB0IxKz5clw88ySLexKQReiGWiI9HI=;
  b=CTrhJzbDQL2EF/7FDWRT6ixGCjlINfWlTMbet0wrQkZZMA2P+5rJ/3tx
   8ij24+ay00Vn/ZbR7X0EX9x4D5krj9O13a+Ly2j1n2lWp+coOUav2eJJ3
   CqGUKCSjzhK8nDVO03r9N4zN/4OtWLEux/y9OtF216+KDgah+4emKzm/x
   q7MCi25K0L7QuYnlBCU51cSaLd6pxqdaNb2LZavZxMY56LGiEjqK63MV9
   vqC3Eg/gReGpMEDiJSvNRn6m2sgej1Z2iT9Ax+AOeh9a5mtUV4Wl/wtV7
   nTnbzBQk9L/zl832rPpZWEaU45VoGrtUA9ngNonBFDOOkwCoafp7fdsUE
   Q==;
X-CSE-ConnectionGUID: e4gnpK6sSjSIsr14N3rM3Q==
X-CSE-MsgGUID: rnP4qIhtRKWkgKGPeDqLPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57743936"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57743936"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 01:47:11 -0700
X-CSE-ConnectionGUID: 907qySqDRHCENg03g4Lvow==
X-CSE-MsgGUID: GxsIphT9QiKsF29TgU7HQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167565368"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 16 Aug 2025 01:47:08 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unCZ8-000Cku-1j;
	Sat, 16 Aug 2025 08:47:06 +0000
Date: Sat, 16 Aug 2025 16:46:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <202508161646.PDl6V4EU-lkp@intel.com>
References: <20250815164627.22002-4-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815164627.22002-4-bcollins@watter.com>

Hi Ben,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Collins/dt-bindings-iio-mcp9600-Add-compatible-for-microchip-mcp9601/20250816-005705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250815164627.22002-4-bcollins%40watter.com
patch subject: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
config: riscv-randconfig-001-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161646.PDl6V4EU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:820:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     820 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/iio/temperature/mcp9600.c:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:829:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     829 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/iio/temperature/mcp9600.c:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:838:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     838 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/iio/temperature/mcp9600.c:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:847:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     847 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/iio/temperature/mcp9600.c:13:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/iio/temperature/mcp9600.c:440:53: warning: invalid conversion specifier '\x0a' [-Wformat-invalid-specifier]
     440 |                                 "Expected id %02x, but device responded with %02\n",
         |                                                                              ~~~^
   include/linux/dev_printk.h:156:62: note: expanded from macro 'dev_warn'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ^~~
   include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   include/linux/dev_printk.h:110:16: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
>> drivers/iio/temperature/mcp9600.c:441:26: warning: data argument not used by format string [-Wformat-extra-args]
     440 |                                 "Expected id %02x, but device responded with %02\n",
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     441 |                                  chip_info->chip_id, dev_id);
         |                                                      ^
   include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ~~~     ^
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^
   drivers/iio/temperature/mcp9600.c:428:22: warning: unused variable 'ret' [-Wunused-variable]
     428 |         int ch_sel, dev_id, ret;
         |                             ^~~
   10 warnings generated.


vim +/x0a +440 drivers/iio/temperature/mcp9600.c

   422	
   423	static int mcp9600_probe(struct i2c_client *client)
   424	{
   425		const struct mcp_chip_info *chip_info = i2c_get_match_data(client);
   426		struct iio_dev *indio_dev;
   427		struct mcp9600_data *data;
   428		int ch_sel, dev_id, ret;
   429	
   430		dev_id = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
   431		if (dev_id < 0)
   432			return dev_err_probe(&client->dev, dev_id,
   433					     "Failed to read device ID\n");
   434	
   435		switch (dev_id) {
   436		case MCP9600_DEVICE_ID_MCP9600:
   437		case MCP9600_DEVICE_ID_MCP9601:
   438			if (dev_id != chip_info->chip_id)
   439				dev_warn(&client->dev,
 > 440					"Expected id %02x, but device responded with %02\n",
 > 441					 chip_info->chip_id, dev_id);
   442			break;
   443	
   444		default:
   445			dev_warn(&client->dev, "Unknown id %x, using %x\n", dev_id,
   446				 chip_info->chip_id);
   447		}
   448	
   449		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
   450		if (!indio_dev)
   451			return -ENOMEM;
   452	
   453		data = iio_priv(indio_dev);
   454		data->client = client;
   455	
   456		ch_sel = mcp9600_probe_alerts(indio_dev);
   457		if (ch_sel < 0)
   458			return ch_sel;
   459	
   460		indio_dev->info = &mcp9600_info;
   461		indio_dev->name = chip_info->chip_name;
   462		indio_dev->modes = INDIO_DIRECT_MODE;
   463		indio_dev->channels = mcp9600_channels[ch_sel];
   464		indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels[ch_sel]);
   465	
   466		return devm_iio_device_register(&client->dev, indio_dev);
   467	}
   468	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

