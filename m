Return-Path: <linux-iio+bounces-19402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B6AB1BE6
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2567B21FF
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 18:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5023BD0E;
	Fri,  9 May 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRwRilSD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DC23A994;
	Fri,  9 May 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813831; cv=none; b=HThs9BeVNRxafeAUXomGCTFU4CD7XROVXp+6nUaKsunApBpT0h22hJN1zxsv8/+il+7CAFVD/lULRsjx4ij+IKp2rNjda+QIUWju4s28EPy7lL6v0JMKs+iZ9U0LFGJ1S2T9PJeX57m0hWap0Pkn9g7WgMXBK3DhSnUIVw2CWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813831; c=relaxed/simple;
	bh=TMIiQS5YfSgbaasKX3QzBCK1/RYA4e4rftcFiPeXxS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffT8uoRMZgUaG4W0KB43saNiVnIaydhysrH5EWbBrb9XIQhj5bj53iyXaVcf6RbDPvyqPx+i1synpd2Uksnxs/g08Cu4MRChvlFiuw/8kx/4Gk8f9DR4WxkTrtG/7SOqPTtbKMWLo3lQeaNOk3NkkzQhaRt206KNypKmMyVXdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRwRilSD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746813830; x=1778349830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMIiQS5YfSgbaasKX3QzBCK1/RYA4e4rftcFiPeXxS8=;
  b=CRwRilSDwM6EvLv3d66YeXGcQaJbsuD4dGaLDYwkPDIKE22pPqA+SVGF
   mIdhEMc6DINlZABECe4tD8jamLlc8S2RfdOJ4YRioduIXqW918LSCbUZX
   /wchVlxjKNA/yOdxWN3ooSV6tOpSmHdOlWDQXXPuRYaQG3NVyseKuA9NC
   dFx6wEi0PKqcz16t5nULoMSYF7FVNNaAkIkCnkKdfRiO71EaHvFsaGOUq
   sRCGEnaxTX5LIJzgFK8B7r7RecVkVS9ZHrLQLsFmRyGbusQ3XTOx9MIo3
   IHLNGGZRCHKvtU0L5TOoIXmp7DwkKxBvwz1Jlhyr1NpReSlTVxze0n9cS
   g==;
X-CSE-ConnectionGUID: uieYRu5RTXS8vnXEqeTe/Q==
X-CSE-MsgGUID: Qwn9x3ZXRp+LXtjjSuSGpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48349969"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48349969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 11:03:49 -0700
X-CSE-ConnectionGUID: Wdk17spXQvK54qmPmDD3Cw==
X-CSE-MsgGUID: 97+KdvmWSkqS2ddY1D4QhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141802458"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 May 2025 11:03:40 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDS4Q-000CL5-0U;
	Fri, 09 May 2025 18:03:38 +0000
Date: Sat, 10 May 2025 02:03:05 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/4] iio: backend: update
 iio_backend_oversampling_ratio_set
Message-ID: <202505100131.FZe7C8ot-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.15-rc5 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pop-Ioan-Daniel/iio-backend-update-iio_backend_oversampling_ratio_set/20250508-203339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250508123107.3797042-2-pop.ioan-daniel%40analog.com
patch subject: [PATCH v2 1/4] iio: backend: update iio_backend_oversampling_ratio_set
config: i386-randconfig-061-20250509 (https://download.01.org/0day-ci/archive/20250510/202505100131.FZe7C8ot-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250510/202505100131.FZe7C8ot-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505100131.FZe7C8ot-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad4851.c:324:60: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int chan @@     got struct iio_chan_spec const *chan @@
   drivers/iio/adc/ad4851.c:324:60: sparse:     expected unsigned int chan
   drivers/iio/adc/ad4851.c:324:60: sparse:     got struct iio_chan_spec const *chan

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

