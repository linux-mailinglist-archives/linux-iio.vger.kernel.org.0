Return-Path: <linux-iio+bounces-5739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917E8FAEA6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F731C20C1C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED705143888;
	Tue,  4 Jun 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7U7PNS4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BB14375F;
	Tue,  4 Jun 2024 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493027; cv=none; b=JzvAf794aak0X+O6S/XHvBX37gK00LJFrCk99CPbqSiX54mW2RoCAJ7VJnFyhaGNlQnhvKzemJ06HzWGldXkWviYMJl0/B56YyDP8mFq0+g7duXbCrNt20pqQdNeKX/ZwF2dEhlG6GGCti11IMyHKXTEb7d2E678SyEb7gvg76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493027; c=relaxed/simple;
	bh=0IbfNLKc2fhB1rZQPt8kaw8xS3yUglfykrxml/F/h1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe5C0xrrFHnb6MZ4brj3jDtzwB1azG170SNCCgLdSE0zLHqMyYQirar0lzWyuiiaoswmTJgsNr6lJpIyl1Vy/wqNI8cuYzj/XqSkxz0+Pgx7alef2owcNRC2PNaVMZQmiZ+Ik1IYLMFcDOsMm8p8j2ssUXkKttD33aL5d3QW4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7U7PNS4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717493025; x=1749029025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0IbfNLKc2fhB1rZQPt8kaw8xS3yUglfykrxml/F/h1Y=;
  b=a7U7PNS4fo2Q8ReSiiRVj43P4KBw5x0gQNOLG85t7Zg+YD4i2AaBCx3f
   GZOr731zmUltqROgM8Vzq9X4ear0eXF53OX1V433pqbwWBzMa05NvIFz8
   nUcUVZtTUbrpGfplvmX3KQFvsw8qzKqlGIAW4Stkp8tUfwb60FJ1GgR12
   BiabM/4ukW49wVBbvabDDyn3nui+FJyVQhxmuZU3/JO3bgrgu/fXnLMI2
   HptAmIsGb40fs3FFQtug9Yd7kd++bqJH9swZ2L3yD2wXyzTrABgI0bR8y
   2LlwV3iX38Ai1Vr5tb+b81hFB3sAsIdP9imYRu7ibHNpu+9gd6RWXCaiS
   g==;
X-CSE-ConnectionGUID: oSqAupphQPO0eIY+lfCVjQ==
X-CSE-MsgGUID: 90OAzwsYRcaVAPZR+Up0cA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14218171"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14218171"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:23:44 -0700
X-CSE-ConnectionGUID: VVvUL15DRC+K7N8LVcOeJw==
X-CSE-MsgGUID: aPqZVL8ETXKSpnpl7alWbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37262347"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2024 02:23:40 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEQOI-000Mzn-2L;
	Tue, 04 Jun 2024 09:23:38 +0000
Date: Tue, 4 Jun 2024 17:23:14 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hewitt <christianshewitt@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] iio: adc: meson: add support for the GXLX SoC
Message-ID: <202406041738.6Dy1cRih-lkp@intel.com>
References: <20240604055431.3313961-2-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604055431.3313961-2-christianshewitt@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/iio-adc-meson-add-support-for-the-GXLX-SoC/20240604-135606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240604055431.3313961-2-christianshewitt%40gmail.com
patch subject: [PATCH 2/2] iio: adc: meson: add support for the GXLX SoC
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240604/202406041738.6Dy1cRih-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041738.6Dy1cRih-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406041738.6Dy1cRih-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/meson_saradc.c:1262:10: error: 'const struct meson_sar_adc_param' has no member named 'vref_voltage'; did you mean 'vref_volatge'?
    1262 |         .vref_voltage = VREF_VOLTAGE_1V8,
         |          ^~~~~~~~~~~~
         |          vref_volatge
>> drivers/iio/adc/meson_saradc.c:1262:25: error: 'VREF_VOLTAGE_1V8' undeclared here (not in a function)
    1262 |         .vref_voltage = VREF_VOLTAGE_1V8,
         |                         ^~~~~~~~~~~~~~~~


vim +1262 drivers/iio/adc/meson_saradc.c

  1255	
  1256	static const struct meson_sar_adc_param meson_sar_adc_gxlx_param = {
  1257		.has_bl30_integration = true,
  1258		.clock_rate = 1200000,
  1259		.regmap_config = &meson_sar_adc_regmap_config_gxbb,
  1260		.resolution = 12,
  1261		.disable_ring_counter = 1,
> 1262		.vref_voltage = VREF_VOLTAGE_1V8,
  1263		.cmv_select = true,
  1264		.mpll_clock_bits = true,
  1265	};
  1266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

