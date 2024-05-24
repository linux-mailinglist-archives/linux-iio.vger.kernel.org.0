Return-Path: <linux-iio+bounces-5245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2770E8CDFC3
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 05:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9324B1F21D81
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDA374E9;
	Fri, 24 May 2024 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyrW24+b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196D722616;
	Fri, 24 May 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521322; cv=none; b=oGoVBzDFYYC4tG1UB4esHNRpsMpPj6+umeDe4nzTQeRUez4Q7TfSKF5cufdZVWFpcppn1JwQxPfRe8Se7O46MHKa0DQhnJAf4oQk+XnhZxvby/5YKIDCrMCXsaBujqxBf8eyXF1CYZnibS8HG/eY3OyptKX6EIOXT72uyVuwH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521322; c=relaxed/simple;
	bh=BmHxPvxy7A16jb2AYJ8QAISuGgdPP6gUOqwmVG0jhKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpkwZXyXk+qLj/zjGUQJEV66cbJj7Xap6jVT3H73tDrBOWD0jL3cT8ur+4s+Z1cAjyrSWkkjHqNzkdNte8TP/qlNblYR0QMFLOai+ROyJBppcQNsLtsci/Z/PfKpYxsLxvwMp4YD8CEBfKSmM+8+9VWNKhWvTHERLqlizTQfLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyrW24+b; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716521321; x=1748057321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BmHxPvxy7A16jb2AYJ8QAISuGgdPP6gUOqwmVG0jhKQ=;
  b=IyrW24+bBOi0DgUQCVPonuGSCA80PxeuT/nJ8IJYgyE1lTKcX/EKQYUA
   M50IC22lbb1v31wzGg5SPuXfgWux9jqfYqzmAT0buEZXehm+j1HgQxQ98
   G72yrrYvJw6nGF7cx+GoC46ky7IosLb6w7EwLP3pfphpGSTsHllUtrIvQ
   RmLh43YKTNHaR+AfzK3CeamDY8M4VRG5iQeCY+0UVbgG9wVemIPR0JHMU
   4RvZFNHIhimRSwA2wFfwiPn9DqVUb4UrgsIGi8dLe81bd+sMBwEvWyBC2
   IZhH6HqDdHFMTVpLSuZnD+QqVf9pvWXzB1Kt1mcwmsNonFuvjtELQKPOD
   A==;
X-CSE-ConnectionGUID: 0iDmhUuPS6e9rGYhZ57ExQ==
X-CSE-MsgGUID: JWwO0x6FR7qIPBjEP+hS1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35398333"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="35398333"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 20:28:40 -0700
X-CSE-ConnectionGUID: gY/CM6FATPai6/GBbCwYiw==
X-CSE-MsgGUID: vmi/9T6/RKm+fon72EZqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="65093228"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 23 May 2024 20:28:35 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sALbb-0003n3-2n;
	Fri, 24 May 2024 03:28:32 +0000
Date: Fri, 24 May 2024 11:28:10 +0800
From: kernel test robot <lkp@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Message-ID: <202405241141.kYcxrSem-lkp@intel.com>
References: <20240523031909.19427-6-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523031909.19427-6-kimseer.paller@analog.com>

Hi Kim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 827dca3129708a8465bde90c86c2e3c38e62dd4f]

url:    https://github.com/intel-lab-lkp/linux/commits/Kim-Seer-Paller/iio-ABI-Generalize-ABI-documentation-for-DAC/20240523-112246
base:   827dca3129708a8465bde90c86c2e3c38e62dd4f
patch link:    https://lore.kernel.org/r/20240523031909.19427-6-kimseer.paller%40analog.com
patch subject: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 and LTC2672
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240524/202405241141.kYcxrSem-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241141.kYcxrSem-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241141.kYcxrSem-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/dac/ltc2664.c:20:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/dac/ltc2664.c:627:8: warning: variable 'span' is uninitialized when used here [-Wuninitialized]
     627 |                         if (span < 0)
         |                             ^~~~
   drivers/iio/dac/ltc2664.c:563:15: note: initialize the variable 'span' to silence this warning
     563 |         int ret, span;
         |                      ^
         |                       = 0
   6 warnings generated.


vim +/span +627 drivers/iio/dac/ltc2664.c

   557	
   558	static int ltc2664_channel_config(struct ltc2664_state *st)
   559	{
   560		const struct ltc2664_chip_info *chip_info = st->chip_info;
   561		struct device *dev = &st->spi->dev;
   562		u32 reg, tmp[2], mspan;
   563		int ret, span;
   564	
   565		mspan = LTC2664_MSPAN_SOFTSPAN;
   566		ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
   567					       &mspan);
   568		if (!ret) {
   569			if (!chip_info->manual_span_support)
   570				return dev_err_probe(dev, -EINVAL,
   571				       "adi,manual-span-operation-config not supported\n");
   572	
   573			if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
   574				return dev_err_probe(dev, -EINVAL,
   575				       "adi,manual-span-operation-config not in range\n");
   576		}
   577	
   578		st->rfsadj = 20000;
   579		ret = device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsadj);
   580		if (!ret) {
   581			if (!chip_info->rfsadj_support)
   582				return dev_err_probe(dev, -EINVAL,
   583						     "adi,rfsadj-ohms not supported\n");
   584	
   585			if (st->rfsadj < 19000 || st->rfsadj > 41000)
   586				return dev_err_probe(dev, -EINVAL,
   587						     "adi,rfsadj-ohms not in range\n");
   588		}
   589	
   590		device_for_each_child_node_scoped(dev, child) {
   591			struct ltc2664_chan *chan;
   592	
   593			ret = fwnode_property_read_u32(child, "reg", &reg);
   594			if (ret)
   595				return dev_err_probe(dev, ret,
   596						     "Failed to get reg property\n");
   597	
   598			if (reg >= chip_info->num_channels)
   599				return dev_err_probe(dev, -EINVAL,
   600						     "reg bigger than: %d\n",
   601						     chip_info->num_channels);
   602	
   603			chan = &st->channels[reg];
   604	
   605			if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
   606				chan->toggle_chan = true;
   607				/* assume sw toggle ABI */
   608				st->iio_channels[reg].ext_info = ltc2664_toggle_sym_ext_info;
   609				/*
   610				 * Clear IIO_CHAN_INFO_RAW bit as toggle channels expose
   611				 * out_voltage/current_raw{0|1} files.
   612				 */
   613				__clear_bit(IIO_CHAN_INFO_RAW,
   614					    &st->iio_channels[reg].info_mask_separate);
   615			}
   616	
   617			chan->raw[0] = ltc2664_mspan_lut[mspan][1];
   618			chan->raw[1] = ltc2664_mspan_lut[mspan][1];
   619	
   620			chan->span = ltc2664_mspan_lut[mspan][0];
   621	
   622			ret = fwnode_property_read_u32_array(child, "adi,output-range-microvolt",
   623							     tmp, ARRAY_SIZE(tmp));
   624			if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
   625				chan->span = ltc2664_set_span(st, tmp[0] / 1000,
   626							      tmp[1] / 1000, reg);
 > 627				if (span < 0)
   628					return dev_err_probe(dev, span,
   629							     "Failed to set span\n");
   630	
   631			}
   632	
   633			ret = fwnode_property_read_u32(child,
   634						       "adi,output-range-microamp",
   635						       &tmp[0]);
   636			if (!ret) {
   637				chan->span = ltc2664_set_span(st, 0, tmp[0] / 1000, reg);
   638				if (span < 0)
   639					return dev_err_probe(dev, span,
   640							     "Failed to set span\n");
   641			}
   642		}
   643	
   644		return 0;
   645	}
   646	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

