Return-Path: <linux-iio+bounces-24916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3ADBCDF43
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 18:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4FA19E063F
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908FB2FC012;
	Fri, 10 Oct 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgTzsYhK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EB2FBE08;
	Fri, 10 Oct 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113513; cv=none; b=tb4YfWZC0NDOgR3bQntBRzf+0XQ3zMVfBoA29s1vcSoxr4icP8C4kHmP8Iwioj+L0LSwdx17u2N+QJ3ZCW/ztWcLel52Tl9uv+osYXD9gj3yC+0pgPEN5Y1fsPJxlRji0Za1E6JCnAISzRZLwFQBien0ClyYorbsw7ZmOOb9Quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113513; c=relaxed/simple;
	bh=sU+6p0fES1lWLpxFt1ech3kFhO9HRwj64Qc8e+dCNyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c92y5fxZfySYcdozHLsulTAmhwwcBTY4A1TfHy73lduIfnVRXZuZAbTzqY+C6s5tqgKabAALsc1HaNhqcHxwRd3rIg2eovm3EdcNQqlG0lWIKBDHs7k5OhA8EKSnSHMrBtjs/rPMnk1vhiHog6/ChdV0w0Q9JtR/BlXldNVPLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgTzsYhK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760113512; x=1791649512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sU+6p0fES1lWLpxFt1ech3kFhO9HRwj64Qc8e+dCNyA=;
  b=lgTzsYhKmG81AGYKuam0rFbIDE5cWb/o1FuZ2y/vyJIDwJquPEAl7uav
   oc9nxrvwmUzoRYUXV6V3f5hTRY27fBydSwtpDBB9MLEuqj1JPS+GNHtUF
   FOHveYkbI+YtMLjE1JkIiHnK/7FDUrHCMN0tpRIwhOvVmW1i12olZDn6g
   Ez0PU75w2EvF/UwC8IrP1w5HTx1PcUBhF3IhYtCiZ40Q7p4jSpX6v69bZ
   Tdgxr3p6ALnIJwBS5OucH/COnu+B4rVJZRsIkCbUJ0QZjVoY3Aw5wXYaJ
   kI9Bcj4DNtamQeT+3zdsMG5iUzrQnK7lJWC9C3UPeT+Xxdm6y8AkBD3Pz
   w==;
X-CSE-ConnectionGUID: SqDwR6S6SBqWNt4eII6cAA==
X-CSE-MsgGUID: rEy9A7MKT7Ci9/dSeqe5nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62254120"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62254120"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 09:25:02 -0700
X-CSE-ConnectionGUID: gfr2n2wqTtSF9blMwY6URw==
X-CSE-MsgGUID: EBoKTs3FRYKkgFllL0MGiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180699022"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2025 09:24:59 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7FvM-0002xH-14;
	Fri, 10 Oct 2025 16:24:56 +0000
Date: Sat, 11 Oct 2025 00:24:06 +0800
From: kernel test robot <lkp@intel.com>
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: health: max30100: Add pulse-width
 configuration via DT
Message-ID: <202510110029.epOLovuF-lkp@intel.com>
References: <20251008031737.7321-3-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008031737.7321-3-raskar.shree97@gmail.com>

Hi Shrikant,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next v6.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shrikant-Raskar/dt-bindings-iio-max30100-Add-pulse-width-property/20251010-102537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251008031737.7321-3-raskar.shree97%40gmail.com
patch subject: [PATCH v2 2/2] iio: health: max30100: Add pulse-width configuration via DT
config: csky-randconfig-001-20251010 (https://download.01.org/0day-ci/archive/20251011/202510110029.epOLovuF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110029.epOLovuF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110029.epOLovuF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/health/max30100.c: In function 'max30100_chip_init':
>> drivers/iio/health/max30100.c:352:34: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     352 |                                  FIELD_PREP(MAX30100_REG_SPO2_CONFIG_PW_MASK, pulse_width));
         |                                  ^~~~~~~~~~


vim +/FIELD_PREP +352 drivers/iio/health/max30100.c

   327	
   328	static int max30100_chip_init(struct max30100_data *data)
   329	{
   330		int ret;
   331		int pulse_width;
   332		/* set default pulse-width-us to 1600us */
   333		unsigned int pulse_us = 1600;
   334		struct device *dev = &data->client->dev;
   335	
   336		/* setup LED current settings */
   337		ret = max30100_led_init(data);
   338		if (ret)
   339			return ret;
   340	
   341		/* Read pulse-width-us from DT */
   342		device_property_read_u32(dev, "maxim,pulse-width-us", &pulse_us);
   343	
   344		pulse_width = max30100_get_pulse_width(pulse_us);
   345		if (pulse_width < 0)
   346			return dev_err_probe(dev, pulse_width, "invalid pulse-width %uus\n", pulse_us);
   347	
   348		/* enable hi-res SPO2 readings at 100Hz */
   349		ret = regmap_write(data->regmap, MAX30100_REG_SPO2_CONFIG,
   350					 MAX30100_REG_SPO2_CONFIG_HI_RES_EN |
   351					 MAX30100_REG_SPO2_CONFIG_100HZ |
 > 352					 FIELD_PREP(MAX30100_REG_SPO2_CONFIG_PW_MASK, pulse_width));
   353		if (ret)
   354			return ret;
   355	
   356		/* enable SPO2 mode */
   357		ret = regmap_update_bits(data->regmap, MAX30100_REG_MODE_CONFIG,
   358					 MAX30100_REG_MODE_CONFIG_MODE_MASK,
   359					 MAX30100_REG_MODE_CONFIG_MODE_HR_EN |
   360					 MAX30100_REG_MODE_CONFIG_MODE_SPO2_EN);
   361		if (ret)
   362			return ret;
   363	
   364		/* enable FIFO interrupt */
   365		return regmap_update_bits(data->regmap, MAX30100_REG_INT_ENABLE,
   366					 MAX30100_REG_INT_ENABLE_MASK,
   367					 MAX30100_REG_INT_ENABLE_FIFO_EN
   368					 << MAX30100_REG_INT_ENABLE_MASK_SHIFT);
   369	}
   370	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

