Return-Path: <linux-iio+bounces-26210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D676C5C493
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 10:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A467D42211E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D0306B31;
	Fri, 14 Nov 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzuQ0lR3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849028727C;
	Fri, 14 Nov 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112441; cv=none; b=r392oKcMOyqBA3ayn7sIrRVziWpfGGNl32CQeD5frNl9HI/v2HbqV/EEK7Q6o8VQnTeGZBXto80Of30hJBTi5EBxF+krQnSXyLVnYycpYK7PxhWV1kTDrCeDspBJREcuRup7gNYWWYHDp5oEmOFDPAK7NEgYlseBCq5nudiOFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112441; c=relaxed/simple;
	bh=JEFXzboCDJt0JmXtr+UN4FXJ3ZEMeYNhJunbMmjv/q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS0BuGKpA3yqEP0Afv4KM73LMPP7TLOdNZNMZuZ1kip4j9/Y9uLnSw9lh4nltMiZpwCrjH36hJ69KvMlUf2cjoLWS3ojNBx5X+oCgMOP9/Fl/k2EfSCXsTdCQQxdontQvplHyJavcHlrcoa5O8mivD640O7U6crEThQ9WqzcR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzuQ0lR3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763112440; x=1794648440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JEFXzboCDJt0JmXtr+UN4FXJ3ZEMeYNhJunbMmjv/q4=;
  b=NzuQ0lR3TlX5mCm2XFeIoBLd6j3+nTwWhPMSIeC7ZWXdL4NEffVY063m
   ihgaCm9e3Jn0p4Tlp0O+ip5C/VfRDML+2E/qanGMliON1jXgtmDHWbfFK
   OfXMU9TzSDn6PTEQCDO8eUT3Crt8O95ZbEk9bZ/Rni3tz2BEHl1Ndf45w
   6Pat/L81aR9wR7FYlafyRFGIegI0avb2f1xUzbhHDZQw6sTHKE715Oolm
   U9c4Wq/vj8stCK/9Gv8AJQ4QZDz4Okvk45jEKo43gUZgQgLAXrZSTBbvx
   SrIyUlozZGot3yb4gfHbOK8zABKgvwUBXz5B6Zu20XhZqkjzrfU2V4IK7
   w==;
X-CSE-ConnectionGUID: EMY+raUMS3G/4oF4P3BBRA==
X-CSE-MsgGUID: splbwSesRFuG7hpnOES09g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76306657"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="76306657"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 01:27:20 -0800
X-CSE-ConnectionGUID: 4AjhgMubSHes0WVu/Jx9Pg==
X-CSE-MsgGUID: rr1ahpIVT1iWUmr5/Xq9uA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Nov 2025 01:27:15 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJq5J-0006P9-0Q;
	Fri, 14 Nov 2025 09:27:13 +0000
Date: Fri, 14 Nov 2025 17:26:25 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, cosmin.tanislav@analog.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 2/3] iio: adc: Initial support for AD4134
Message-ID: <202511141657.LqnXWUQm-lkp@intel.com>
References: <86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build errors:

[auto build test ERROR on c5411c8b9ed1caf53604bb1a5be3f487988efc98]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-Add-AD4134/20251110-204756
base:   c5411c8b9ed1caf53604bb1a5be3f487988efc98
patch link:    https://lore.kernel.org/r/86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v1 2/3] iio: adc: Initial support for AD4134
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20251114/202511141657.LqnXWUQm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251114/202511141657.LqnXWUQm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511141657.LqnXWUQm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad4134-common.c: In function 'ad4134_probe':
>> drivers/iio/adc/ad4134-common.c:178:34: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     178 |                                  FIELD_PREP(AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
         |                                  ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +178 drivers/iio/adc/ad4134-common.c

    87	
    88	int ad4134_probe(struct device *dev, const struct ad4134_bus_info *bus_info)
    89	{
    90		bool use_internal_ldo_retulator;
    91		struct gpio_desc *reset_gpio;
    92		struct iio_dev *indio_dev;
    93		struct ad4134_state *st;
    94		int ret;
    95	
    96		indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
    97		if (!indio_dev)
    98			return -ENOMEM;
    99	
   100		st = iio_priv(indio_dev);
   101		st->dev = dev;
   102	
   103		indio_dev->name = bus_info->chip_info->name;
   104	
   105		/* Required regulators */
   106		ret = devm_regulator_bulk_get_enable(dev, 3, ad4143_regulator_names);
   107		if (ret)
   108			return dev_err_probe(dev, ret, "failed to enable power supplies\n");
   109	
   110		/* Required regulator that we need to read the voltage */
   111		ret = devm_regulator_get_enable_read_voltage(dev, "refin");
   112		if (ret < 0)
   113			return dev_err_probe(dev, ret, "failed to get REFIN voltage.\n");
   114	
   115		st->refin_mv = ret / MILLI;
   116	
   117		/*
   118		 * If ldoin is not provided, then avdd1v8, dvdd1v8, and clkvdd are
   119		 * required.
   120		 */
   121		ret = devm_regulator_get_enable_optional(dev, "ldoin");
   122		if (ret < 0 && ret != -ENODEV)
   123			return dev_err_probe(dev, ret, "failed to enable ldoin supply\n");
   124	
   125		use_internal_ldo_retulator = ret == 0;
   126	
   127		if (!use_internal_ldo_retulator) {
   128			ret = devm_regulator_get_enable(dev, "avdd1v8");
   129			if (ret < 0)
   130				return dev_err_probe(dev, ret,
   131						     "failed to enable avdd1v8 supply\n");
   132	
   133			ret = devm_regulator_get_enable(dev, "dvdd1v8");
   134			if (ret < 0)
   135				return dev_err_probe(dev, ret,
   136						     "failed to enable dvdd1v8 supply\n");
   137	
   138			ret = devm_regulator_get_enable(dev, "clkvdd");
   139			if (ret < 0)
   140				return dev_err_probe(dev, ret,
   141						     "failed to enable clkvdd supply\n");
   142		}
   143	
   144		ret = ad4134_clock_select(st);
   145		if (ret)
   146			return ret;
   147	
   148		crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
   149	
   150		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
   151		if (IS_ERR(reset_gpio))
   152			return dev_err_probe(dev, PTR_ERR(reset_gpio),
   153					     "failed to find reset GPIO\n");
   154	
   155		if (reset_gpio) {
   156			fsleep(AD4134_RESET_TIME_US);
   157			gpiod_set_value_cansleep(reset_gpio, 0);
   158		}
   159	
   160		ret = bus_info->bops->config_iio_dev(indio_dev);
   161		if (ret)
   162			return dev_err_probe(dev, ret, "failed to config IIO device\n");
   163	
   164		st->regmap = bus_info->bops->init_regmap(st);
   165		if (IS_ERR(st->regmap))
   166			return dev_err_probe(st->dev, PTR_ERR(st->regmap),
   167					     "failed to initialize regmap");
   168	
   169		/* wiring/configuration specific setup */
   170		ret = bus_info->bops->setup(st);
   171		if (ret)
   172			return dev_err_probe(dev, ret, "failed to setup bus\n");
   173	
   174		/* Bump precision to 24-bit */
   175		st->current_scan_type = AD4134_DATA_PACKET_24BIT_FRAME;
   176		ret = regmap_update_bits(st->regmap, AD4134_DATA_PACKET_CONFIG_REG,
   177					 AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
 > 178					 FIELD_PREP(AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
   179						    st->current_scan_type));
   180		if (ret)
   181			return ret;
   182	
   183		/* Set high performance power mode */
   184		ret = regmap_update_bits(st->regmap, AD4134_DEVICE_CONFIG_REG,
   185					 AD4134_DEVICE_CONFIG_POWER_MODE_MASK,
   186					 FIELD_PREP(AD4134_DEVICE_CONFIG_POWER_MODE_MASK,
   187						    AD4134_POWER_MODE_HIGH_PERF));
   188		if (ret)
   189			return ret;
   190	
   191		return devm_iio_device_register(dev, indio_dev);
   192	}
   193	EXPORT_SYMBOL_NS_GPL(ad4134_probe, "IIO_AD4134");
   194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

