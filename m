Return-Path: <linux-iio+bounces-5519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D28D56BD
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 02:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EADB2312B
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C97FF;
	Fri, 31 May 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr0S5O+J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D815B3;
	Fri, 31 May 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114240; cv=none; b=DPyNnvtKoxSRAdceIN1bGupvQwvliR6FEFqwsT77o2YdgHBiK6CNCiPMgxpbXIy8asy7JE9UdhVJn0Q8BiC2LE+2e985UMJatL/9mtYgMZ7LI+WNBpBhTiu7tF5sW9Alz193HcmlYHR/pwEoHYSNqARKOjAb/0uONwaQTrxzc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114240; c=relaxed/simple;
	bh=kbuE3YYNvHZZpdFzMlUIb5zBZJCuGRjp82a+xXwXIow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBh1fqg4pkOrl5x+tNZ1nccU+hKsCZzs6W2sDswMJ+mTnlpLEIleyqJHpBspgiFWvUxl9QQ8tU09Ms8t+2Y9PIwHiAWxpaVwd9MbAD6/kHOA/7h3Q/Zl+OLF1mMQOoCbQqDZF+3uyM+18DbhM/MbigR16O9f5QpyxdEed8Msv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr0S5O+J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717114238; x=1748650238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kbuE3YYNvHZZpdFzMlUIb5zBZJCuGRjp82a+xXwXIow=;
  b=Jr0S5O+JTI/bYyk2opPL8AuIXRfFOuW/jsryVGg8g+TrwJ1L1kDVAq/U
   Rg1pPRupt9DT82AdvYwTF1glLMxeufCzJA5kvTn74VwTtHaHeJK3LB9rp
   7pqyJOt1qKxR/fc0JoUTljNkOY4vA0hIYMN2tBKD/aKKCdUNUPSHmkZBw
   jVq9eOwXfoXRuXPX1+JAxczYhWuBNZiVFHJC/XRkEjGsv5XMiinrGCHZ8
   DAQzJw0a1ttDKX9gCgZ/Nk4WoxXp43px7xtBX2nRojYWG0+5wm8njpDcQ
   qFGJN+i85XjyLUgwPJqoFAlyqkYB3UQRUNW+hELNzerjxxETzFPg+AyZC
   w==;
X-CSE-ConnectionGUID: +aySiVUXRKWhyNCvvKAHWA==
X-CSE-MsgGUID: 84xX1E9DT9K1PNZ4+hSCKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13481066"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13481066"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 17:10:37 -0700
X-CSE-ConnectionGUID: 2usrzk6OQhS9flupch8FOw==
X-CSE-MsgGUID: m/2Q4ip9TzeEilm/NbGggQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36028466"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 May 2024 17:07:22 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCpnj-000GEf-1o;
	Fri, 31 May 2024 00:07:19 +0000
Date: Fri, 31 May 2024 08:07:14 +0800
From: kernel test robot <lkp@intel.com>
To: ranechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ranechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Okan Sahin <okan.sahin@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: iio: adc: add support for ad777x family
Message-ID: <202405310747.6KO7w1V1-lkp@intel.com>
References: <20240529150322.28018-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529150322.28018-1-ramona.nechita@analog.com>

Hi ranechita,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ranechita/drivers-iio-adc-add-support-for-ad777x-family/20240529-230814
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240529150322.28018-1-ramona.nechita%40analog.com
patch subject: [PATCH v2] drivers: iio: adc: add support for ad777x family
config: microblaze-randconfig-r113-20240531 (https://download.01.org/0day-ci/archive/20240531/202405310747.6KO7w1V1-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240531/202405310747.6KO7w1V1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310747.6KO7w1V1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad7779.c:571:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 @@     got unsigned long @@
   drivers/iio/adc/ad7779.c:571:35: sparse:     expected restricted __be32
   drivers/iio/adc/ad7779.c:571:35: sparse:     got unsigned long
>> drivers/iio/adc/ad7779.c:581:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 @@     got unsigned int [usertype] @@
   drivers/iio/adc/ad7779.c:581:42: sparse:     expected restricted __be32
   drivers/iio/adc/ad7779.c:581:42: sparse:     got unsigned int [usertype]
>> drivers/iio/adc/ad7779.c:685:35: sparse: sparse: symbol 'ad777x_buffer_setup_ops' was not declared. Should it be static?
   drivers/iio/adc/ad7779.c: note: in included file (through include/linux/mutex.h, include/linux/notifier.h, include/linux/clk.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +571 drivers/iio/adc/ad7779.c

   552	
   553	static irqreturn_t ad777x_irq_handler(int irq, void *data)
   554	{
   555		struct iio_dev *indio_dev = data;
   556		struct ad777x_state *st = iio_priv(indio_dev);
   557		int ret;
   558		__be32 tmp[8];
   559		int i;
   560		int k = 0;
   561	
   562		struct spi_transfer sd_readback_tr[] = {
   563			{
   564				.rx_buf = st->spidata_rx,
   565				.tx_buf = st->spidata_tx,
   566				.len = 32,
   567			}
   568		};
   569	
   570		if (iio_buffer_enabled(indio_dev)) {
 > 571			st->spidata_tx[0] = AD777X_SPI_READ_CMD;
   572			ret = spi_sync_transfer(st->spi, sd_readback_tr,
   573						ARRAY_SIZE(sd_readback_tr));
   574			if (ret) {
   575				dev_err(&st->spi->dev,
   576					"spi transfer error in irq handler");
   577				return IRQ_HANDLED;
   578			}
   579			for (i = 0; i < AD777X_NUM_CHANNELS; i++) {
   580				if (st->active_ch & BIT(i))
 > 581					tmp[k++] = __be32_to_cpu(st->spidata_rx[i]);
   582			}
   583			iio_push_to_buffers(indio_dev, &tmp[0]);
   584		}
   585	
   586		return IRQ_HANDLED;
   587	}
   588	
   589	static int ad777x_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
   590	{
   591		struct ad777x_state *st = iio_priv(indio_dev);
   592		int ret;
   593		struct spi_transfer reg_read_tr[] = {
   594			{
   595				.tx_buf = st->reset_buf,
   596				.len = 8,
   597			},
   598		};
   599	
   600		memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
   601	
   602		if (reset_gpio) {
   603			gpiod_set_value(reset_gpio, 1);
   604			fsleep(230);
   605			return 0;
   606		}
   607	
   608		ret = spi_sync_transfer(st->spi, reg_read_tr,
   609					ARRAY_SIZE(reg_read_tr));
   610		if (ret)
   611			return ret;
   612	
   613		fsleep(230);
   614	
   615		return 0;
   616	}
   617	
   618	static const struct iio_info ad777x_info = {
   619		.read_raw = ad777x_read_raw,
   620		.write_raw = ad777x_write_raw,
   621		.debugfs_reg_access = &ad777x_reg_access,
   622		.update_scan_mode = &ad777x_update_scan_mode,
   623	};
   624	
   625	static const struct iio_enum ad777x_filter_enum = {
   626		.items = ad777x_filter_type,
   627		.num_items = ARRAY_SIZE(ad777x_filter_type),
   628		.get = ad777x_get_filter,
   629		.set = ad777x_set_filter,
   630	};
   631	
   632	static const struct iio_chan_spec_ext_info ad777x_ext_filter[] = {
   633		IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad777x_filter_enum),
   634		IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
   635					  &ad777x_filter_enum),
   636		{ }
   637	};
   638	
   639	#define AD777x_CHAN_S(index, _ext_info)					       \
   640		{								       \
   641			.type = IIO_VOLTAGE,					       \
   642			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE)  |	       \
   643					      BIT(IIO_CHAN_INFO_CALIBBIAS),	       \
   644			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
   645			.address = (index),					       \
   646			.indexed = 1,						       \
   647			.channel = (index),					       \
   648			.scan_index = (index),					       \
   649			.ext_info = (_ext_info),				       \
   650			.scan_type = {						       \
   651				.sign = 's',					       \
   652				.realbits = 24,					       \
   653				.storagebits = 32,				       \
   654			},							       \
   655		}
   656	
   657	#define AD777x_CHAN_NO_FILTER_S(index)					       \
   658		AD777x_CHAN_S(index, NULL)
   659	
   660	#define AD777x_CHAN_FILTER_S(index)					       \
   661		AD777x_CHAN_S(index, ad777x_ext_filter)
   662	
   663	static const struct iio_chan_spec ad777x_channels[] = {
   664		AD777x_CHAN_NO_FILTER_S(0),
   665		AD777x_CHAN_NO_FILTER_S(1),
   666		AD777x_CHAN_NO_FILTER_S(2),
   667		AD777x_CHAN_NO_FILTER_S(3),
   668		AD777x_CHAN_NO_FILTER_S(4),
   669		AD777x_CHAN_NO_FILTER_S(5),
   670		AD777x_CHAN_NO_FILTER_S(6),
   671		AD777x_CHAN_NO_FILTER_S(7),
   672	};
   673	
   674	static const struct iio_chan_spec ad777x_channels_filter[] = {
   675		AD777x_CHAN_FILTER_S(0),
   676		AD777x_CHAN_FILTER_S(1),
   677		AD777x_CHAN_FILTER_S(2),
   678		AD777x_CHAN_FILTER_S(3),
   679		AD777x_CHAN_FILTER_S(4),
   680		AD777x_CHAN_FILTER_S(5),
   681		AD777x_CHAN_FILTER_S(6),
   682		AD777x_CHAN_FILTER_S(7),
   683	};
   684	
 > 685	const struct iio_buffer_setup_ops ad777x_buffer_setup_ops = {
   686		.postenable = ad777x_buffer_postenable,
   687		.predisable = ad777x_buffer_predisable,
   688	};
   689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

