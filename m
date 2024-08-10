Return-Path: <linux-iio+bounces-8390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B794DBED
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C963EB21CD7
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4D14F124;
	Sat, 10 Aug 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0T+oCSU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4B4436E;
	Sat, 10 Aug 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281630; cv=none; b=jS5D3IIodsKJI0QVyswd78WPmYCSzyZIdabQfaeOfekcZKaV43zD1pAkrcINt0cB6x7bwDgURuBhjvNOJXn8OFqrkXNOmjRmkxnDJ96C6Eq2Z3ozngUOTN9NNtiDBFwyRxQvBaH+5JSYixls1K6RfQ0mC1dnA7rdT8N+TxEbbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281630; c=relaxed/simple;
	bh=hqbfNiQf/FaCYgIkBoBfBp6pDygQSbNfVoLQ+CBarrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7KPOyGdeDb5wSSDY6nQye2R7DeIshxl0vAHcbuj+QvVi8xVQUZUpRpGpQpsUPQolH0MhAbQqDakPvAdlYx6eUg+8d35xRiRBF64xGMGsaGm/Tq38yynDkzhSilLxmBS8bEzG0v3Nnpw9Iz4f9wzeTpEqtU60hwc67KCKU+eN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0T+oCSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62501C32781;
	Sat, 10 Aug 2024 09:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281630;
	bh=hqbfNiQf/FaCYgIkBoBfBp6pDygQSbNfVoLQ+CBarrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0T+oCSUmgLxjYAk3/y0g6IEqzTkRedT2bEHQyizq/Simd52NlpYl/B+64q+ZI1/4
	 nKDIz4A8tEm7B6o+wuOmI5opqXU8bCONHxN8kEDcgOz08Jn2OgkN1iIXubAqJMmtul
	 loV3sUKqKOp7UwEHGV98OvdxZDMrsrFbmodXmZ0ZjVJ8ta1SEw7mSgf4jax2lCiPQG
	 YpUioXbPH/icGEhYaIbD+z0WrJU2S4HTCmGN1s6DyCfRq2pzzn8ENQ882iid6FG2SF
	 IQ2lhXm0t0ymc6QRLIWfI2liOnyUcxU5s2vTewojys0+/5xF3KTTPfiXNiNjF/CGZG
	 FAaqdHCl58DJw==
Date: Sat, 10 Aug 2024 10:20:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
Message-ID: <20240810102021.45b35e59@jic23-huawei>
In-Reply-To: <202408081623.ua9EBfoZ-lkp@intel.com>
References: <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
	<202408081623.ua9EBfoZ-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 16:52:09 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi David,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 7cad163c39cb642ed587d3eeb37a5637ee02740f]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad4695-implement-triggered-buffer/20240808-063333
> base:   7cad163c39cb642ed587d3eeb37a5637ee02740f
> patch link:    https://lore.kernel.org/r/20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283%40baylibre.com
> patch subject: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240808/202408081623.ua9EBfoZ-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 408d82d352eb98e2d0a804c66d359cd7a49228fe)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408081623.ua9EBfoZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408081623.ua9EBfoZ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/iio/adc/ad4695.c:24:
>    In file included from include/linux/iio/triggered_buffer.h:6:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      548 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>          |                                                   ^
>    In file included from drivers/iio/adc/ad4695.c:24:
>    In file included from include/linux/iio/triggered_buffer.h:6:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>          |                                                   ^
>    In file included from drivers/iio/adc/ad4695.c:24:
>    In file included from include/linux/iio/triggered_buffer.h:6:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      585 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    In file included from drivers/iio/adc/ad4695.c:28:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:21:
>    In file included from include/linux/mm.h:2228:
>    include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
> >> drivers/iio/adc/ad4695.c:454:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]  
>      454 |         val = FIELD_PREP(mask, temp_chan_en ? 1 : 0);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
>      115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
>       72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>       73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
>          |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       74 |                                  _pfx "type of reg too small for mask"); \
>          |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
>    include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
>      510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
>      498 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
>      490 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    8 warnings generated.
> 
> 
> vim +454 drivers/iio/adc/ad4695.c
> 
>    373	
>    374	static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
>    375	{
>    376		struct ad4695_state *st = iio_priv(indio_dev);
>    377		struct spi_transfer *xfer;
>    378		u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
>    379		bool temp_chan_en = false;
>    380		u32 reg, mask, val, bit, num_xfer, num_slots;
>    381		int ret;
>    382	
>    383		/*
>    384		 * We are using the advanced sequencer since it is the only way to read
>    385		 * multiple channels that allows individual configuration of each
>    386		 * voltage input channel. Slot 0 in the advanced sequencer is used to
>    387		 * account for the gap between trigger polls - we don't read data from
>    388		 * this slot. Each enabled voltage channel is assigned a slot starting
>    389		 * with slot 1.
>    390		 */
>    391		num_slots = 1;
>    392	
>    393		memset(st->buf_read_xfer, 0, sizeof(st->buf_read_xfer));
>    394	
>    395		/* First xfer is only to trigger conversion of slot 1, so no rx. */
>    396		xfer = &st->buf_read_xfer[0];
>    397		xfer->cs_change = 1;
>    398		xfer->delay.value = AD4695_T_CNVL_NS;
>    399		xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
>    400		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
>    401		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
>    402		num_xfer = 1;
>    403	
>    404		iio_for_each_active_channel(indio_dev, bit) {
>    405			xfer = &st->buf_read_xfer[num_xfer];
>    406			xfer->bits_per_word = 16;
>    407			xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
>    408			xfer->len = 2;
>    409			xfer->cs_change = 1;
>    410			xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
>    411			xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
>    412	
>    413			if (bit == temp_chan_bit) {
>    414				temp_chan_en = true;
>    415			} else {
>    416				reg = AD4695_REG_AS_SLOT(num_slots);
>    417				val = FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit);
>    418	
>    419				ret = regmap_write(st->regmap, reg, val);
>    420				if (ret)
>    421					return ret;
>    422	
>    423				num_slots++;
>    424			}
>    425	
>    426			num_xfer++;
>    427		}
>    428	
>    429		/*
>    430		 * Don't keep CS asserted after last xfer. Also triggers conversion of
>    431		 * slot 0.
>    432		 */
>    433		xfer->cs_change = 0;
>    434	
>    435		/**
>    436		 * The advanced sequencer requires that at least 2 slots are enabled.
>    437		 * Since slot 0 is always used for other purposes, we need only 1
>    438		 * enabled voltage channel to meet this requirement. This error will
>    439		 * only happen if only the temperature channel is enabled.
>    440		 */
>    441		if (num_slots < 2) {
>    442			dev_err_ratelimited(&indio_dev->dev,
>    443				"Buffered read requires at least 1 voltage channel enabled\n");
>    444			return -EINVAL;
>    445		}
>    446	
>    447		/*
>    448		 * Temperature channel isn't included in the sequence, but rather
>    449		 * controlled by setting a bit in the TEMP_CTRL register.
>    450		 */
>    451	
>    452		reg = AD4695_REG_TEMP_CTRL;
>    453		mask = AD4695_REG_TEMP_CTRL_TEMP_EN;
>  > 454		val = FIELD_PREP(mask, temp_chan_en ? 1 : 0);
  
Probably a case of the compiler somehow failing to squash the local variable.
I'd just go with
			val = FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN,
					 temp_chan_en ? 1 : 0);
>    455	
>    456		ret = regmap_update_bits(st->regmap, reg, mask, val);
>    457		if (ret)
>    458			return ret;
>    459	
>    460		spi_message_init_with_transfers(&st->buf_read_msg, st->buf_read_xfer,
>    461						num_xfer);
>    462	
>    463		ret = spi_optimize_message(st->spi, &st->buf_read_msg);
>    464		if (ret)
>    465			return ret;
>    466	
>    467		/* This triggers conversion of slot 0. */
>    468		ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
>    469		if (ret) {
>    470			spi_unoptimize_message(&st->buf_read_msg);
>    471			return ret;
>    472		}
>    473	
>    474		return 0;
>    475	}
>    476	
> 


