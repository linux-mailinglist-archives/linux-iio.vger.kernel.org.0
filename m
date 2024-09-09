Return-Path: <linux-iio+bounces-9403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED4971FD8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BFB226A1
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 17:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BA16EBEC;
	Mon,  9 Sep 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdjcOUBh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F8116DED5;
	Mon,  9 Sep 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901422; cv=none; b=BN6ZnKo00uRIUil0gH9F2mrK053rsGQD+ogkesURQlt+IxeNNIXglNygrEbzmpFWJgE4p+AHfB3qwA9nMo0DM8PbtCPPIu64MJQsLDmduAu+4Aebl9KRB73ku8AffJXl95PnP1NLDpsenlRj9hNctQ92n0zYrvEGOeSlnrASLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901422; c=relaxed/simple;
	bh=z2f2zMXr032Lrm+l7qqrSHc0CLC2s9dIbQt/a78PVfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/85VksMEm+JXK92o004NHS3/vCnrKoHBUdc2y09IHrPBsVAmqyMtl62EkhdiPqlRaWaNLJAhPMzQh2eR6eNbriICqju4Ll2jR+7+34OkAKD0PEkPx2UmYhAB84cC4a8Kz7jm3lMtwhLUupLZTPyzY0pIrNxGngjK/npD9YzrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdjcOUBh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725901421; x=1757437421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2f2zMXr032Lrm+l7qqrSHc0CLC2s9dIbQt/a78PVfI=;
  b=TdjcOUBhb9TDJ3nAsDKwYUw0rwxvw/3+z3JyrFhGUlomBF0J54u4MXFp
   F2sBiR0x1TX/QY7hY4RzhxI87JNHH8lQ/msMmq5L5XFJLeJ/2GeAkSe/5
   ZxcwvQeRWC5YGqdpIx8f7eINZzImxELtxUgM8rew/PKqk6bdl194LWRwL
   d5Hux7NenSTBe3nK1SAgVzeSnBa3V7f6EjUvZnV8PUrYhipItqoY/dAmf
   ECUnGouCuu2eE7Eab2XlNQX9TyhqqHynlesqZf4U/nRFkXomlU1G6eXoj
   SuZ4Qh5xCOa0B7iy9QBPtKcUflGFFcwk9z4wUtbMqtKmaND4mefwjx3ZF
   w==;
X-CSE-ConnectionGUID: y76JqmwATBWw2biECmZ24A==
X-CSE-MsgGUID: s5YhtjDdRU2Y/M6QeyjiOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24722634"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24722634"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 10:03:40 -0700
X-CSE-ConnectionGUID: Grq5JGftRl2YhAd2ZBNVBQ==
X-CSE-MsgGUID: EbBA92hXS/mAaNEtpWDONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66790757"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Sep 2024 10:03:36 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snhnZ-000F0S-2f;
	Mon, 09 Sep 2024 17:03:33 +0000
Date: Tue, 10 Sep 2024 01:03:04 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>
Cc: oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <202409100026.17N3K11W-lkp@intel.com>
References: <20240909043254.611589-3-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909043254.611589-3-lanzano.alex@gmail.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.11-rc7 next-20240909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Lanzano/dt-bindings-iio-imu-add-bmi270-bindings/20240909-123509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240909043254.611589-3-lanzano.alex%40gmail.com
patch subject: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240910/202409100026.17N3K11W-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100026.17N3K11W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409100026.17N3K11W-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/imu/bmi270/bmi270_core.c: In function 'bmi270_configure_imu':
>> drivers/iio/imu/bmi270/bmi270_core.c:180:31: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     180 |                               FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
         |                               ^~~~~~~~~~


vim +/FIELD_PREP +180 drivers/iio/imu/bmi270/bmi270_core.c

   165	
   166	static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
   167	{
   168		int ret;
   169		struct device *dev = bmi270_device->dev;
   170		struct regmap *regmap = bmi270_device->regmap;
   171	
   172		ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
   173				      BMI270_PWR_CTRL_AUX_EN_MSK |
   174				      BMI270_PWR_CTRL_GYR_EN_MSK |
   175				      BMI270_PWR_CTRL_ACCEL_EN_MSK);
   176		if (ret)
   177			return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
   178	
   179		ret = regmap_set_bits(regmap, BMI270_ACC_CONF_REG,
 > 180				      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
   181						 BMI270_ACC_CONF_ODR_100HZ) |
   182				      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
   183						 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
   184				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
   185		if (ret)
   186			return dev_err_probe(dev, ret, "Failed to configure accelerometer");
   187	
   188		ret = regmap_set_bits(regmap, BMI270_GYR_CONF_REG,
   189				      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
   190						 BMI270_GYR_CONF_ODR_200HZ) |
   191				      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
   192						 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
   193				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
   194		if (ret)
   195			return dev_err_probe(dev, ret, "Failed to configure gyroscope");
   196	
   197		/* Enable FIFO_WKUP, Disable ADV_PWR_SAVE and FUP_EN */
   198		ret = regmap_write(regmap, BMI270_PWR_CONF_REG,
   199				   BMI270_PWR_CONF_FIFO_WKUP_MSK);
   200		if (ret)
   201			return dev_err_probe(dev, ret, "Failed to set power configuration");
   202	
   203		return 0;
   204	}
   205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

