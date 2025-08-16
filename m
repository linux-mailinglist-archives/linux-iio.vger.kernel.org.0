Return-Path: <linux-iio+bounces-22782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3635B28C9F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A825E3C96
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C228A1F6;
	Sat, 16 Aug 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np5DpHm8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C710E3;
	Sat, 16 Aug 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338572; cv=none; b=MFwTknjpDxRye/xTMQY31zvt6UPYpezElTcJCkUpZt87oL6AT2AUdSshCpEHpvMMEjdt29koyf2mSB68pQeYpkd0GElm9hk7phoO4RwE6Ei/73s7QAAo0FYfgdYcbzHPI8xKeEkTkUqp2MEdG3FVHFm5Coz0qTVr/Wsi4zAv9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338572; c=relaxed/simple;
	bh=VuiPBXQ22lseM4os8mxj8uNO0UUQTf2gEqPele8VL5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLNrL5xAw2lkqr3DRRUIey5hlpVrf5j69cbKb8YE4sShbP85SfJK/a/OeV9tnsS4IcvI44/CqgQkvl86cSxJYk6GJH79OmAz2CyMG/rS/BVhP2qWAwrKnv36Sx+K663QCqsWhhNXTUYeNSc4hiCwiA4TWH6PbmxKgvHA6UsrCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np5DpHm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55344C4CEEF;
	Sat, 16 Aug 2025 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755338572;
	bh=VuiPBXQ22lseM4os8mxj8uNO0UUQTf2gEqPele8VL5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Np5DpHm8hu4QckqtMcPAXjceEmhgVPuTvHa4vT9m8oaaFq8DbLWhnYXvY6d8pb62g
	 Sh60kAnyj3m8WogjMkYDAa9dwyBOmgK6npZ+lqIRbOHjYdTQVJb+Zb7rEJjz0p95+T
	 3g9p2ldwUikZurxf1Fl54ZKe0V8uJ+PUdyBqFl9s18GFqFstPDcEezmwJXG96M6itl
	 gnpePXCHcaiZGNIcZyta+yNwla4EUel80Otc+AxL+cMQK+QKgbAx5OOg5wZXG0682j
	 Y1YLVQqpJDhiIMLYSiTGTaP6pSwoXj6MKbNMqWBrkGpDeDK1DYuX/j56r8URrB4sqh
	 DNeyRd9Pr4jqQ==
Date: Sat, 16 Aug 2025 11:02:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ben Collins <bcollins@watter.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <20250816110243.06fbf7fb@jic23-huawei>
In-Reply-To: <202508161646.PDl6V4EU-lkp@intel.com>
References: <20250815164627.22002-4-bcollins@watter.com>
	<202508161646.PDl6V4EU-lkp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 16:46:12 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ben,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v6.17-rc1 next-20250815]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Collins/dt-bindings-iio-mcp9600-Add-compatible-for-microchip-mcp9601/20250816-005705
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20250815164627.22002-4-bcollins%40watter.com
> patch subject: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
> config: riscv-randconfig-001-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508161646.PDl6V4EU-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:27:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:820:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      820 |         insl(addr, buffer, count);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
>      106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
>          |                                          ~~~~~~~~~~ ^
>    In file included from drivers/iio/temperature/mcp9600.c:13:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:27:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:829:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      829 |         outsb(addr, buffer, count);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
>      118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
>          |                                            ~~~~~~~~~~ ^
>    In file included from drivers/iio/temperature/mcp9600.c:13:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:27:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:838:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      838 |         outsw(addr, buffer, count);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
>      119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
>          |                                            ~~~~~~~~~~ ^
>    In file included from drivers/iio/temperature/mcp9600.c:13:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:27:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:847:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      847 |         outsl(addr, buffer, count);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
>      120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
>          |                                            ~~~~~~~~~~ ^
>    In file included from drivers/iio/temperature/mcp9600.c:13:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:27:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>     1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>          |                                                   ~~~~~~~~~~ ^
> >> drivers/iio/temperature/mcp9600.c:440:53: warning: invalid conversion specifier '\x0a' [-Wformat-invalid-specifier]  
>      440 |                                 "Expected id %02x, but device responded with %02\n",
>          |                                                                              ~~~^
>    include/linux/dev_printk.h:156:62: note: expanded from macro 'dev_warn'
>      156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |                                                                     ^~~
>    include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
>       19 | #define dev_fmt(fmt) fmt
>          |                      ^~~
>    include/linux/dev_printk.h:110:16: note: expanded from macro 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>          |                              ^~~
> >> drivers/iio/temperature/mcp9600.c:441:26: warning: data argument not used by format string [-Wformat-extra-args]  
>      440 |                                 "Expected id %02x, but device responded with %02\n",
>          |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      441 |                                  chip_info->chip_id, dev_id);
>          |                                                      ^
>    include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
>      156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |                                                                     ~~~     ^
>    include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>          |                              ~~~    ^
>    drivers/iio/temperature/mcp9600.c:428:22: warning: unused variable 'ret' [-Wunused-variable]
>      428 |         int ch_sel, dev_id, ret;
>          |                             ^~~
>    10 warnings generated.
> 
> 
> vim +/x0a +440 drivers/iio/temperature/mcp9600.c
> 
>    422	
>    423	static int mcp9600_probe(struct i2c_client *client)
>    424	{
>    425		const struct mcp_chip_info *chip_info = i2c_get_match_data(client);

Probably a false positive as I don't think we can probe without something matching and hence
that not being NULL but an error check on that match is still a nice to have and should
resolve this build warning.  Note there is very little chance a compiler could ever figure
out if this can be NULL or not so it's a reasonable warning!

Jonathan


>    426		struct iio_dev *indio_dev;
>    427		struct mcp9600_data *data;
>    428		int ch_sel, dev_id, ret;
>    429	
>    430		dev_id = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
>    431		if (dev_id < 0)
>    432			return dev_err_probe(&client->dev, dev_id,
>    433					     "Failed to read device ID\n");
>    434	
>    435		switch (dev_id) {
>    436		case MCP9600_DEVICE_ID_MCP9600:
>    437		case MCP9600_DEVICE_ID_MCP9601:
>    438			if (dev_id != chip_info->chip_id)
>    439				dev_warn(&client->dev,
>  > 440					"Expected id %02x, but device responded with %02\n",
>  > 441					 chip_info->chip_id, dev_id);  
>    442			break;
>    443	
>    444		default:
>    445			dev_warn(&client->dev, "Unknown id %x, using %x\n", dev_id,
>    446				 chip_info->chip_id);
>    447		}
>    448	
>    449		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>    450		if (!indio_dev)
>    451			return -ENOMEM;
>    452	
>    453		data = iio_priv(indio_dev);
>    454		data->client = client;
>    455	
>    456		ch_sel = mcp9600_probe_alerts(indio_dev);
>    457		if (ch_sel < 0)
>    458			return ch_sel;
>    459	
>    460		indio_dev->info = &mcp9600_info;
>    461		indio_dev->name = chip_info->chip_name;
>    462		indio_dev->modes = INDIO_DIRECT_MODE;
>    463		indio_dev->channels = mcp9600_channels[ch_sel];
>    464		indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels[ch_sel]);
>    465	
>    466		return devm_iio_device_register(&client->dev, indio_dev);
>    467	}
>    468	
> 


