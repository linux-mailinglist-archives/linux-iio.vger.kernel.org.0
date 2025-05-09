Return-Path: <linux-iio+bounces-19358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F638AB1001
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762AF1C251C1
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B94F28E619;
	Fri,  9 May 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaImMMFg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67C28E5E3;
	Fri,  9 May 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785464; cv=none; b=gxw+gx6iytuHPPlstgTaVYl4m75/Gb7bnzQRQmYUKqKhzbjzCPTL42R1477fhV1pysnXRqNIGpNNNaQrsJAnBG0RsiwVJGrXWJ4toS2gwwb9WDwrHBj0JyNDD74NVyJLXIJryGQe9GUxpToUTaV+V1kp4mReEEBLYWyhepIyLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785464; c=relaxed/simple;
	bh=Qaky7RedrcOMmPqHtyjf5ffJQToE+TYbiEAJfJ73Rmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2tYdTvFE5U+rx4wpK9pMolRMwc4FPUkzTEpkAopo7liQRaABiYA/4iB/OQVpr4wAnGqIlBtLGWXk/E1/DqwvmeL3chTbTNntgxJKpmYUVFWsGUA8nAy0F/g5JhA/ztKhGBQYp+EfjcHUu7xvGnujIqb5nUHm/LACk0ac7Fw4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaImMMFg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746785462; x=1778321462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qaky7RedrcOMmPqHtyjf5ffJQToE+TYbiEAJfJ73Rmg=;
  b=EaImMMFgvSfOMqlvlYBxigR49Ccboc2nMtoPtqEEiw/7mq+qWYlw/QZQ
   NIdnJQ4IF+4Y8az5XJ7tIBOa7S+a5V+KS6xYNId0B14nJRRfkd45IgT7b
   YAbtmIfS2vJ+5ydyV92OhzJPvpRgXRJ7WtXfGulT+urOX3cwSthHoEefZ
   /QJ4eb3E6bD48hGpwEgJc9uYsT5Cy7Limn7f80arbMgEDtGnMV0c69UAx
   I1ih8s+vGEg0UgI+Ac1sjC6Zt5YxONl4F1JiR1LpDxZJvsglOih2pNQhx
   iwS6sGwbCk6ZOPZ1KF+VgDV1UM1xyHXlv5xNo30MfL5kwSC7kXUDIhmDT
   Q==;
X-CSE-ConnectionGUID: Zztr1gcYT+2dalzw9qRtmw==
X-CSE-MsgGUID: ZWWeUG+oQxSnWtaTGIznNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48724843"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48724843"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:11:02 -0700
X-CSE-ConnectionGUID: HqY9jbtzSteBKacvM4ethg==
X-CSE-MsgGUID: kPZ4jp7LTgSjyqipK5/yuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="137075540"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 May 2025 03:10:56 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDKgv-000Bv5-32;
	Fri, 09 May 2025 10:10:53 +0000
Date: Fri, 9 May 2025 18:10:43 +0800
From: kernel test robot <lkp@intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/4] iio: backend: update
 iio_backend_oversampling_ratio_set
Message-ID: <202505091706.owR2rZED-lkp@intel.com>
References: <20250508123107.3797042-2-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508123107.3797042-2-pop.ioan-daniel@analog.com>

Hi Pop,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pop-Ioan-Daniel/iio-backend-update-iio_backend_oversampling_ratio_set/20250508-203339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250508123107.3797042-2-pop.ioan-daniel%40analog.com
patch subject: [PATCH v2 1/4] iio: backend: update iio_backend_oversampling_ratio_set
config: arm-randconfig-004-20250509 (https://download.01.org/0day-ci/archive/20250509/202505091706.owR2rZED-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505091706.owR2rZED-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091706.owR2rZED-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad4851.c:324:53: error: incompatible pointer to integer conversion passing 'const struct iio_chan_spec *' to parameter of type 'unsigned int' [-Wint-conversion]
     324 |         ret = iio_backend_oversampling_ratio_set(st->back, chan, osr);
         |                                                            ^~~~
   include/linux/iio/backend.h:212:25: note: passing argument to parameter 'chan' here
     212 |                                        unsigned int chan,
         |                                                     ^
   1 error generated.


vim +324 drivers/iio/adc/ad4851.c

   295	
   296	static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
   297						 const struct iio_chan_spec *chan,
   298						 unsigned int osr)
   299	{
   300		struct ad4851_state *st = iio_priv(indio_dev);
   301		int val, ret;
   302	
   303		guard(mutex)(&st->lock);
   304	
   305		if (osr == 1) {
   306			ret = regmap_clear_bits(st->regmap, AD4851_REG_OVERSAMPLE,
   307						AD4851_OS_EN_MSK);
   308			if (ret)
   309				return ret;
   310		} else {
   311			val = ad4851_osr_to_regval(osr);
   312			if (val < 0)
   313				return -EINVAL;
   314	
   315			ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
   316						 AD4851_OS_EN_MSK |
   317						 AD4851_OS_RATIO_MSK,
   318						 FIELD_PREP(AD4851_OS_EN_MSK, 1) |
   319						 FIELD_PREP(AD4851_OS_RATIO_MSK, val));
   320			if (ret)
   321				return ret;
   322		}
   323	
 > 324		ret = iio_backend_oversampling_ratio_set(st->back, chan, osr);
   325		if (ret)
   326			return ret;
   327	
   328		switch (st->info->resolution) {
   329		case 20:
   330			switch (osr) {
   331			case 0:
   332				return -EINVAL;
   333			case 1:
   334				val = 20;
   335				break;
   336			default:
   337				val = 24;
   338				break;
   339			}
   340			break;
   341		case 16:
   342			val = 16;
   343			break;
   344		default:
   345			return -EINVAL;
   346		}
   347	
   348		ret = iio_backend_data_size_set(st->back, val);
   349		if (ret)
   350			return ret;
   351	
   352		if (osr == 1 || st->info->resolution == 16) {
   353			ret = regmap_clear_bits(st->regmap, AD4851_REG_PACKET,
   354						AD4851_PACKET_FORMAT_MASK);
   355			if (ret)
   356				return ret;
   357	
   358			st->resolution_boost_enabled = false;
   359		} else {
   360			ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,
   361						 AD4851_PACKET_FORMAT_MASK,
   362						 FIELD_PREP(AD4851_PACKET_FORMAT_MASK, 1));
   363			if (ret)
   364				return ret;
   365	
   366			st->resolution_boost_enabled = true;
   367		}
   368	
   369		if (st->osr != osr) {
   370			ret = ad4851_scale_fill(indio_dev);
   371			if (ret)
   372				return ret;
   373	
   374			st->osr = osr;
   375		}
   376	
   377		return 0;
   378	}
   379	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

