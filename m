Return-Path: <linux-iio+bounces-17163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBFA6B04D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 23:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A7189F41A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406452222A2;
	Thu, 20 Mar 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO8MxZ28"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EA1EB1AE;
	Thu, 20 Mar 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508510; cv=none; b=VeZD9AIFfReYsHFhv170rzsbnHeTWW4BBwmr9mx1JvdbDYMVa0h64EUk4KgtomySCFeKbQeBiJa3Tb76Ed2BhAf1sj74Cto89ULxGbeIKM9QxxgsxY7HERNBzzXQLTTaNmy64gcPe9jzyEUUg7nJRnrcpCSV6+UvfaglWVU78qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508510; c=relaxed/simple;
	bh=663gcOFwkwRPcgJfgUo1lbojiZAPOuhRheA1XInAKVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQAPtkGnQIN7sDvfV8+baBHb2bILAaL3Mfnzw29h8MTTgvcnlAMgUugkm5sQC9reDm5+Ry/yaeSv889q2YxAVeOU0P+Sluv/4qLHnxiXbt3noxl3Sie15slru6v5ywY3RI8cvhSqrB5nBdHjFDUr4HDXdeCMftMT8YHfp1yIMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO8MxZ28; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742508508; x=1774044508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=663gcOFwkwRPcgJfgUo1lbojiZAPOuhRheA1XInAKVk=;
  b=TO8MxZ28oNWG20H13a1ai03KnqZrYyhzIbWsjfupWob91AQiSGiRqIPG
   zdPDjmabhP5fWZiKf3385IunKzXY7cvnYg5EZSyOEtMoNVOfakWEV/5ZD
   HJQhmjkL3kf1SjNCZPr234zF+EYchzjbLquAyGOAlzXbfRlNz+mA74CX9
   B4+Fa8PMZx2BymvVERyi2RHB6btSdK8Im8uDjopt29CBWEbw2TFauF8Ah
   WsABvSBk05Kx4a+QG2NeEi5yZudiAto6Pz7thOaXC81DEQMhor/ftF2bT
   jqWFGWOGOt9foKDkYA+MVV4F6SM+kR7SlpNDr7/9HqJIIZojlbXOBvoK2
   Q==;
X-CSE-ConnectionGUID: zJ6wtIZLRTiIsMX8luAUKg==
X-CSE-MsgGUID: gTc/kVQvQXSTFY0hGhfbkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66229466"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66229466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:08:27 -0700
X-CSE-ConnectionGUID: z9/ir06NSD2C25UMgMpeqw==
X-CSE-MsgGUID: ItkH32rjT/GfYhazN4CjyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123674982"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 20 Mar 2025 15:08:25 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvO3q-0000oB-2e;
	Thu, 20 Mar 2025 22:08:22 +0000
Date: Fri, 21 Mar 2025 06:08:08 +0800
From: kernel test robot <lkp@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>
Subject: Re: [PATCH 4/4] iio: dac: ad3530r: Add driver for AD3530R and AD3531R
Message-ID: <202503210537.KxDNeihS-lkp@intel.com>
References: <20250319-togreg-v1-4-d8244a502f2c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-togreg-v1-4-d8244a502f2c@analog.com>

Hi Kim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8dbeb413806f9f810d97d25284f585b201aa3bdc]

url:    https://github.com/intel-lab-lkp/linux/commits/Kim-Seer-Paller/iio-ABI-add-new-DAC-powerdown-mode/20250319-115119
base:   8dbeb413806f9f810d97d25284f585b201aa3bdc
patch link:    https://lore.kernel.org/r/20250319-togreg-v1-4-d8244a502f2c%40analog.com
patch subject: [PATCH 4/4] iio: dac: ad3530r: Add driver for AD3530R and AD3531R
config: alpha-randconfig-r121-20250321 (https://download.01.org/0day-ci/archive/20250321/202503210537.KxDNeihS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250321/202503210537.KxDNeihS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503210537.KxDNeihS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/dac/ad3530r.c:286:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int reg_val @@     got restricted __be16 [usertype] @@
   drivers/iio/dac/ad3530r.c:286:17: sparse:     expected unsigned int reg_val
   drivers/iio/dac/ad3530r.c:286:17: sparse:     got restricted __be16 [usertype]
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16
>> drivers/iio/dac/ad3530r.c:316:24: sparse: sparse: cast to restricted __be16

vim +286 drivers/iio/dac/ad3530r.c

   278	
   279	static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
   280				     unsigned int val)
   281	{
   282		int ret;
   283		unsigned int reg_val;
   284	
   285		guard(mutex)(&st->lock);
 > 286		reg_val = cpu_to_be16(val);
   287	
   288		ret = regmap_bulk_write(st->regmap, st->chip_info->input_ch_reg(chan),
   289					&reg_val, 2);
   290		if (ret)
   291			return ret;
   292	
   293		if (st->ldac_gpio)
   294			return ad3530r_trigger_hw_ldac(st->ldac_gpio);
   295	
   296		return regmap_update_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
   297					  AD3530R_SW_LDAC_TRIG_MASK,
   298					  FIELD_PREP(AD3530R_SW_LDAC_TRIG_MASK, 1));
   299	}
   300	
   301	static int ad3530r_read_raw(struct iio_dev *indio_dev,
   302				    struct iio_chan_spec const *chan,
   303				    int *val, int *val2, long info)
   304	{
   305		struct ad3530r_state *st = iio_priv(indio_dev);
   306		int ret;
   307	
   308		switch (info) {
   309		case IIO_CHAN_INFO_RAW:
   310			ret = regmap_bulk_read(st->regmap,
   311					       st->chip_info->input_ch_reg(chan->channel),
   312					       val, 2);
   313			if (ret)
   314				return ret;
   315	
 > 316			*val = FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(*val));
   317	
   318			return IIO_VAL_INT;
   319		case IIO_CHAN_INFO_SCALE:
   320			*val = st->vref_mv;
   321			*val2 = 16;
   322	
   323			return IIO_VAL_FRACTIONAL_LOG2;
   324		case IIO_CHAN_INFO_OFFSET:
   325			*val = 0;
   326	
   327			return IIO_VAL_INT;
   328		default:
   329			return -EINVAL;
   330		}
   331	}
   332	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

