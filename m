Return-Path: <linux-iio+bounces-19360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D3AB1071
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9409A3BC0D3
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC43428EA4F;
	Fri,  9 May 2025 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFf/DZvi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696728D841;
	Fri,  9 May 2025 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786124; cv=none; b=UGmMLcaqgoYgIE0XdhYko55vr/+O5cAUm+LkB5qj0sJZ15Hh7/8/kCLPFqeuYey5oBQ0YdIz7/GDHzcgi7VAeDbA8Rlfb2ZVIYBT5jdSLVx5WdiC7qApTIdm43xWNkhMopNU2HjSdULcW3/RC4M7g7cSqJ8TryUDSHmX++/G1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786124; c=relaxed/simple;
	bh=u0FdmcLCzWAN0OgJO+9XszGN9E14Xi6UpgFN0H7wVRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poyepx22o2/8HG1pG5J8kB9WPSRUyVPV7hOwRsjEVFqSpvq4j2kmDMFHn5+rwr6hle8GBC/5CweRLcGjVXFUC+lWUjxgA7kLRbowFg+NmeY8+bXvF1yo5ce095Kkg8hpD3zSmZn0oxKlulHxV+wK78QU98/aL/jU1Y7xKjs4I7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFf/DZvi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746786123; x=1778322123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0FdmcLCzWAN0OgJO+9XszGN9E14Xi6UpgFN0H7wVRU=;
  b=OFf/DZviM+d9aQK3G0Nd7zSDVk3krGTOY0SfV3HPmdI9QTe/MBVafH37
   s+yg6wGmk+jlWcvVPj9oR144HMlQG0iEpRl5QvjpJGGwruT+hWEY6QmiP
   CvEZeOD8FcNQeyB7pysqclCZPqujubgvO4ZlUgtdaIibhFMrmvR6Fs+CY
   MP+RTz73uYFcjQKwHImbHs6mpECYM3zVI3fxPEbYgXCLYXO7y1CFL9PF4
   KI676URhIYyXfy46qHqdXpiWDtM+6nIdTsJ3//GsCIqVjsNMyjEsOGISA
   Ys1BHzWVilX2/5YOIYK+5rDCmTR5rIKsHS728j1QtJXWA7vj6x+UAoSiQ
   g==;
X-CSE-ConnectionGUID: Drz52SWMRsOOv3TPi/SEPA==
X-CSE-MsgGUID: 4GD/0geGQUWu+IToI6zYzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48725846"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48725846"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:22:02 -0700
X-CSE-ConnectionGUID: DwlI8GfKRSeoSrKIj+e3mw==
X-CSE-MsgGUID: LEpLa6rRSGu1qx1TTsl+hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="140631455"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2025 03:21:57 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDKra-000Bvn-2Y;
	Fri, 09 May 2025 10:21:54 +0000
Date: Fri, 9 May 2025 18:21:11 +0800
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
Message-ID: <202505091838.a9sKlbJN-lkp@intel.com>
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
[also build test WARNING on linus/master v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pop-Ioan-Daniel/iio-backend-update-iio_backend_oversampling_ratio_set/20250508-203339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250508123107.3797042-2-pop.ioan-daniel%40analog.com
patch subject: [PATCH v2 1/4] iio: backend: update iio_backend_oversampling_ratio_set
config: nios2-randconfig-001-20250509 (https://download.01.org/0day-ci/archive/20250509/202505091838.a9sKlbJN-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505091838.a9sKlbJN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091838.a9sKlbJN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad4851.c: In function 'ad4851_set_oversampling_ratio':
>> drivers/iio/adc/ad4851.c:324:60: warning: passing argument 2 of 'iio_backend_oversampling_ratio_set' makes integer from pointer without a cast [-Wint-conversion]
     324 |         ret = iio_backend_oversampling_ratio_set(st->back, chan, osr);
         |                                                            ^~~~
         |                                                            |
         |                                                            const struct iio_chan_spec *
   In file included from drivers/iio/adc/ad4851.c:26:
   include/linux/iio/backend.h:212:53: note: expected 'unsigned int' but argument is of type 'const struct iio_chan_spec *'
     212 |                                        unsigned int chan,
         |                                        ~~~~~~~~~~~~~^~~~


vim +/iio_backend_oversampling_ratio_set +324 drivers/iio/adc/ad4851.c

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

