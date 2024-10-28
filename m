Return-Path: <linux-iio+bounces-11508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A179B3936
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 19:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A487B21048
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E92175D25;
	Mon, 28 Oct 2024 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeFodYZk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAD1DF26E;
	Mon, 28 Oct 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140403; cv=none; b=VtT49yd2GDfQ0aGPwLqClq8+iWYtXvWZ5qGCrJUXRH0DV3Pl/HxtaKvWw6z60jIrf62+JAq5Hfsy6zIvwrNwfonUALwp+u+UmEcE0En6Bo9LXs7tgIw1ZFLg9a7HGSV6iDCw50VDJhqxyLcYMZUbLVVuOF3rK+9aXqqpjZewN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140403; c=relaxed/simple;
	bh=RtUxlckr7u4gCJmgfzIvJNSXpB/tzLCL+dbysnbd5fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixSYaemU+Oi+ERXl9+iACdEDBJ/W0QISuKQ2hwDzp8tXEYt1x60XNdxon7jolSD/O6/lQkLxwPQ1LVZCgcxC2O24+ZqQDTYquBhPDdFjqgvjbvZbgWChKhWj8kwV9gRviMOmLyyIgSvzkuazUgB+XlFkyHokzVb6XgX5wBJ1W4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeFodYZk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730140401; x=1761676401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RtUxlckr7u4gCJmgfzIvJNSXpB/tzLCL+dbysnbd5fQ=;
  b=BeFodYZkfAxrNKuR4aC/u1GQuucEsQqdtzV5zvH/mAHyE9JPcuDypVP6
   D8HsyLyqi/He3Dmm2OzUozq18NmRaRdtCtrXY+6O/0tvPz3JXIdNFuawo
   Z4pqRbhGVBf5BDyAExZFqZK36HYEiqaviLq7OSd9mU7fylLznilJ6UwVO
   QZuegigzfnwc82MSWmqsdHS40UZKl/aTENltPXAoHrBLDwtEpZ624Lyh2
   1AuZvewa1hCdbTLBtyN4IQe4qsRvO9f9F4jthsp1JDM0jm9s/fTjSIbjG
   aXf/olUqtMKYrY/o/60nebnE/dGp9TM0LW8wUo5rmZ98PFsXBZuWjfiEE
   A==;
X-CSE-ConnectionGUID: 9B5WwuwkQjmGHNsrjaoehw==
X-CSE-MsgGUID: QPr6b7hnT02BBQcAHAzh5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29961072"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29961072"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:33:20 -0700
X-CSE-ConnectionGUID: lDCXmLHRQu2g+UIZpN/LIQ==
X-CSE-MsgGUID: P8gHA8XbQiOZM5tj8p3DUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81269452"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Oct 2024 11:33:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5UYF-000ckW-0F;
	Mon, 28 Oct 2024 18:33:15 +0000
Date: Tue, 29 Oct 2024 02:32:42 +0800
From: kernel test robot <lkp@intel.com>
To: ahaslam@baylibre.com, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH 5/6] iio: dac: ad5791: Use
 devm_regulator_get_enable_read_voltage
Message-ID: <202410290245.0RC0cDV4-lkp@intel.com>
References: <20241028071118.699951-6-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028071118.699951-6-ahaslam@baylibre.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc5 next-20241028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ahaslam-baylibre-com/dt-bindings-iio-dac-ad5791-Add-optional-reset-clr-and-ldac-gpios/20241028-151319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241028071118.699951-6-ahaslam%40baylibre.com
patch subject: [PATCH 5/6] iio: dac: ad5791: Use devm_regulator_get_enable_read_voltage
config: x86_64-buildonly-randconfig-004-20241028 (https://download.01.org/0day-ci/archive/20241029/202410290245.0RC0cDV4-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290245.0RC0cDV4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290245.0RC0cDV4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/dac/ad5791.c:14:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/dac/ad5791.c:370:35: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     370 |                 return dev_err_probe(&spi->dev, ret, "failed to get vdd voltage\n");
         |                                                 ^~~
   drivers/iio/dac/ad5791.c:336:9: note: initialize the variable 'ret' to silence this warning
     336 |         int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
         |                ^
         |                 = 0
   2 warnings generated.


vim +/ret +370 drivers/iio/dac/ad5791.c

   330	
   331	static int ad5791_probe(struct spi_device *spi)
   332	{
   333		const struct ad5791_platform_data *pdata = dev_get_platdata(&spi->dev);
   334		struct iio_dev *indio_dev;
   335		struct ad5791_state *st;
   336		int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
   337		bool use_rbuf_gain2;
   338	
   339		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
   340		if (!indio_dev)
   341			return -ENOMEM;
   342		st = iio_priv(indio_dev);
   343	
   344		st->gpio_reset = devm_gpiod_get_optional(&spi->dev, "reset",
   345							 GPIOD_OUT_HIGH);
   346		if (IS_ERR(st->gpio_reset))
   347			return PTR_ERR(st->gpio_reset);
   348	
   349		st->gpio_clear = devm_gpiod_get_optional(&spi->dev, "clear",
   350							 GPIOD_OUT_LOW);
   351		if (IS_ERR(st->gpio_clear))
   352			return PTR_ERR(st->gpio_clear);
   353	
   354		st->gpio_ldac = devm_gpiod_get_optional(&spi->dev, "ldac",
   355							GPIOD_OUT_HIGH);
   356		if (IS_ERR(st->gpio_ldac))
   357			return PTR_ERR(st->gpio_ldac);
   358	
   359		st->pwr_down = true;
   360		st->spi = spi;
   361	
   362		if (pdata)
   363			use_rbuf_gain2 = pdata->use_rbuf_gain2;
   364		else
   365			use_rbuf_gain2 = device_property_read_bool(&spi->dev,
   366								   "adi,rbuf-gain2-en");
   367	
   368		pos_voltage_uv = devm_regulator_get_enable_read_voltage(&spi->dev, "vdd");
   369		if (pos_voltage_uv < 0 && pos_voltage_uv != -ENODEV)
 > 370			return dev_err_probe(&spi->dev, ret, "failed to get vdd voltage\n");
   371	
   372		neg_voltage_uv = devm_regulator_get_enable_read_voltage(&spi->dev, "vss");
   373		if (neg_voltage_uv < 0 && neg_voltage_uv != -ENODEV)
   374			return dev_err_probe(&spi->dev, ret, "failed to get vss voltage\n");
   375	
   376		if (neg_voltage_uv >= 0 && pos_voltage_uv >= 0) {
   377			st->vref_mv = (pos_voltage_uv + neg_voltage_uv) / 1000;
   378			st->vref_neg_mv = neg_voltage_uv / 1000;
   379		} else if (pdata) {
   380			st->vref_mv = pdata->vref_pos_mv + pdata->vref_neg_mv;
   381			st->vref_neg_mv = pdata->vref_neg_mv;
   382		} else {
   383			dev_warn(&spi->dev, "reference voltage unspecified\n");
   384		}
   385	
   386		if (st->gpio_reset) {
   387			fsleep(20);
   388			gpiod_set_value_cansleep(st->gpio_reset, 0);
   389		} else {
   390			ret = ad5791_spi_write(st, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
   391			if (ret)
   392				return dev_err_probe(&spi->dev, ret, "fail to reset\n");
   393		}
   394	
   395		st->chip_info = spi_get_device_match_data(spi);
   396		if (!st->chip_info)
   397			return dev_err_probe(&spi->dev, -EINVAL, "no chip info\n");
   398	
   399		st->ctrl = AD5761_CTRL_LINCOMP(st->chip_info->get_lin_comp(st->vref_mv))
   400			  | (use_rbuf_gain2 ? 0 : AD5791_CTRL_RBUF) |
   401			  AD5791_CTRL_BIN2SC;
   402	
   403		ret = ad5791_spi_write(st, AD5791_ADDR_CTRL, st->ctrl |
   404			AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
   405		if (ret)
   406			return dev_err_probe(&spi->dev, ret, "fail to write ctrl register\n");
   407	
   408		spi_set_drvdata(spi, indio_dev);
   409		indio_dev->info = &ad5791_info;
   410		indio_dev->modes = INDIO_DIRECT_MODE;
   411		indio_dev->channels = &st->chip_info->channel;
   412		indio_dev->num_channels = 1;
   413		indio_dev->name = st->chip_info->name;
   414		ret = iio_device_register(indio_dev);
   415		if (ret)
   416			return dev_err_probe(&spi->dev, ret, "unable to register iio device\n");
   417	
   418		return 0;
   419	}
   420	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

