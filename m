Return-Path: <linux-iio+bounces-10325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771FA99433A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4242EB2B672
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E21E0E10;
	Tue,  8 Oct 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcU1VuCk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC71E0E08;
	Tue,  8 Oct 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376310; cv=none; b=LNpaS8/QVJYGL/EO7JtRwcwFwW3c/Z1jaoM192If986OTJ0Xhxsp7bUjGe7pxET3jfESIlbS0hKbNWROxVxUzrP1/lnNCoZNBXuJ2dtCNKU659H9rCKygZ5DPmPasf/xhIy9io0qQe4okvxPHt1n+q+cfygEdU1Zs6iOfmhRnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376310; c=relaxed/simple;
	bh=+f/xsEFjXW1Goapy9ip1TIgiTvi7UsrdNU7dVcyqE/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnbVkEJw5k9KQ6f7iyVErleDHCPI+MUwelOpb2RsV5PSjrqjehUudpXRyycnN1ybWwEDWHk1oE+T6a43lQD0Erh1Qw4hJvOqATDCwC678SxE/xykom/Yoe5cOJwoJQunmoDI1ieZwlqdqq1aLB4lFil1cristjpIkCPdF0eIkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcU1VuCk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728376308; x=1759912308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+f/xsEFjXW1Goapy9ip1TIgiTvi7UsrdNU7dVcyqE/s=;
  b=AcU1VuCkOjGJ593j3e5tHyJcthIObdMFvhX25KjEEs6V3dGx+L38oAkN
   T+rJ+JRpeVim3fJtYqjrDwZlIE3INpXsosUW6t8jTqaqZ7LVE/TODD3R7
   5heHH06dxxqB4yEHDIJdZ6wACCj5HAIlW5f2FuX7G5OZ17x1r5WZjqvN9
   nCTd4T1N77LejXngMKvMWz5xcAZuAW9kCEiFaLOyNGpDS84+VnC6gmNx5
   SRBuTT0PkMUQ7qGTgNp57uNoc6ElZU8CQ+kekL/IAjcunKj0Uu02s+kHi
   JmuCyNxyRGcWNKXTskpDHon2Y7qFacJdVLMGIp//+D3Jz9ACL7ZomUa7V
   A==;
X-CSE-ConnectionGUID: qBWl5wA1RY+8Jnh6Ab/JrQ==
X-CSE-MsgGUID: HWVOuUFAQPChoyD/5z5Fmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27645402"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="27645402"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 01:31:48 -0700
X-CSE-ConnectionGUID: +0vLyqs4S82TUFQ7q02+jw==
X-CSE-MsgGUID: Kjx0nVjOSZu6aCM3KBP8RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="79752089"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Oct 2024 01:31:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy5d7-00066w-0N;
	Tue, 08 Oct 2024 08:31:41 +0000
Date: Tue, 8 Oct 2024 16:31:40 +0800
From: kernel test robot <lkp@intel.com>
To: Julien Stephan <jstephan@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 4/6] iio: adc: ad7380: add missing supplies
Message-ID: <202410081608.ZxEPPZ0u-lkp@intel.com>
References: <20241007-ad7380-fix-supplies-v1-4-badcf813c9b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-ad7380-fix-supplies-v1-4-badcf813c9b9@baylibre.com>

Hi Julien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d]

url:    https://github.com/intel-lab-lkp/linux/commits/Julien-Stephan/dt-bindings-iio-adc-ad7380-remove-voltage-reference-for-supplies/20241007-234838
base:   8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
patch link:    https://lore.kernel.org/r/20241007-ad7380-fix-supplies-v1-4-badcf813c9b9%40baylibre.com
patch subject: [PATCH 4/6] iio: adc: ad7380: add missing supplies
config: x86_64-buildonly-randconfig-003-20241008 (https://download.01.org/0day-ci/archive/20241008/202410081608.ZxEPPZ0u-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081608.ZxEPPZ0u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081608.ZxEPPZ0u-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7380.c:1045:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
    1045 |         if (ret)
         |             ^~~
   drivers/iio/adc/ad7380.c:1030:9: note: initialize the variable 'ret' to silence this warning
    1030 |         int ret, i;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +1045 drivers/iio/adc/ad7380.c

  1024	
  1025	static int ad7380_probe(struct spi_device *spi)
  1026	{
  1027		struct iio_dev *indio_dev;
  1028		struct ad7380_state *st;
  1029		bool external_ref_en;
  1030		int ret, i;
  1031	
  1032		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
  1033		if (!indio_dev)
  1034			return -ENOMEM;
  1035	
  1036		st = iio_priv(indio_dev);
  1037		st->spi = spi;
  1038		st->chip_info = spi_get_device_match_data(spi);
  1039		if (!st->chip_info)
  1040			return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
  1041	
  1042		devm_regulator_bulk_get_enable(&spi->dev, st->chip_info->num_supplies,
  1043					       st->chip_info->supplies);
  1044	
> 1045		if (ret)
  1046			return dev_err_probe(&spi->dev, ret,
  1047					     "Failed to enable power supplies\n");
  1048		msleep(T_POWERUP_MS);
  1049	
  1050		/*
  1051		 * If there is no REFIO supply, then it means that we are using
  1052		 * the internal 2.5V reference, otherwise REFIO is reference voltage.
  1053		 */
  1054		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
  1055		if (ret < 0 && ret != -ENODEV)
  1056			return dev_err_probe(&spi->dev, ret,
  1057					     "Failed to get refio regulator\n");
  1058	
  1059		external_ref_en = ret != -ENODEV;
  1060		st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
  1061	
  1062		if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
  1063			return dev_err_probe(&spi->dev, -EINVAL,
  1064					     "invalid number of VCM supplies\n");
  1065	
  1066		/*
  1067		 * pseudo-differential chips have common mode supplies for the negative
  1068		 * input pin.
  1069		 */
  1070		for (i = 0; i < st->chip_info->num_vcm_supplies; i++) {
  1071			const char *vcm = st->chip_info->vcm_supplies[i];
  1072	
  1073			ret = devm_regulator_get_enable_read_voltage(&spi->dev, vcm);
  1074			if (ret < 0)
  1075				return dev_err_probe(&spi->dev, ret,
  1076						     "Failed to get %s regulator\n",
  1077						     vcm);
  1078	
  1079			st->vcm_mv[i] = ret / 1000;
  1080		}
  1081	
  1082		st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ad7380_regmap_config);
  1083		if (IS_ERR(st->regmap))
  1084			return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
  1085					     "failed to allocate register map\n");
  1086	
  1087		/*
  1088		 * Setting up xfer structures for both normal and sequence mode. These
  1089		 * struct are used for both direct read and triggered buffer. Additional
  1090		 * fields will be set up in ad7380_update_xfers() based on the current
  1091		 * state of the driver at the time of the read.
  1092		 */
  1093	
  1094		/*
  1095		 * In normal mode a read is composed of two steps:
  1096		 *   - first, toggle CS (no data xfer) to trigger a conversion
  1097		 *   - then, read data
  1098		 */
  1099		st->normal_xfer[0].cs_change = 1;
  1100		st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
  1101		st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
  1102		st->normal_xfer[1].rx_buf = st->scan_data;
  1103	
  1104		spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
  1105						ARRAY_SIZE(st->normal_xfer));
  1106		/*
  1107		 * In sequencer mode a read is composed of four steps:
  1108		 *   - CS toggle (no data xfer) to get the right point in the sequence
  1109		 *   - CS toggle (no data xfer) to trigger a conversion of AinX0 and
  1110		 *   acquisition of AinX1
  1111		 *   - 2 data reads, to read AinX0 and AinX1
  1112		 */
  1113		st->seq_xfer[0].cs_change = 1;
  1114		st->seq_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
  1115		st->seq_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
  1116		st->seq_xfer[1].cs_change = 1;
  1117		st->seq_xfer[1].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
  1118		st->seq_xfer[1].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
  1119	
  1120		st->seq_xfer[2].rx_buf = st->scan_data;
  1121		st->seq_xfer[2].cs_change = 1;
  1122		st->seq_xfer[2].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
  1123		st->seq_xfer[2].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
  1124	
  1125		spi_message_init_with_transfers(&st->seq_msg, st->seq_xfer,
  1126						ARRAY_SIZE(st->seq_xfer));
  1127	
  1128		indio_dev->channels = st->chip_info->channels;
  1129		indio_dev->num_channels = st->chip_info->num_channels;
  1130		indio_dev->name = st->chip_info->name;
  1131		indio_dev->info = &ad7380_info;
  1132		indio_dev->modes = INDIO_DIRECT_MODE;
  1133		indio_dev->available_scan_masks = st->chip_info->available_scan_masks;
  1134	
  1135		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
  1136						      iio_pollfunc_store_time,
  1137						      ad7380_trigger_handler,
  1138						      &ad7380_buffer_setup_ops);
  1139		if (ret)
  1140			return ret;
  1141	
  1142		ret = ad7380_init(st, external_ref_en);
  1143		if (ret)
  1144			return ret;
  1145	
  1146		return devm_iio_device_register(&spi->dev, indio_dev);
  1147	}
  1148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

