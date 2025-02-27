Return-Path: <linux-iio+bounces-16161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C233A48CD9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 00:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2599C188C338
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9644B276D3D;
	Thu, 27 Feb 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVxnFCrQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F2276D23;
	Thu, 27 Feb 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699306; cv=none; b=B4OGldiRbSGunqNCYI5DezEiffPPDOj0kuu6aAPnjENBWazc+nfzcKrRHjVSffL1mNsyRqLf4mG8mPV9PzR7igixb3qKhBm16pSEMXUpxfJo5+f53kFRtrw8sVOrVQ7+szZfi5aMkQ+mFE0p7oRKHbO8NQDqjRxetULhKzOs+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699306; c=relaxed/simple;
	bh=bkqOxOWQQQCLGRepn5os0rxwFT8Ja2Tsk0+nPgxMF3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MasEG80N0P8W1UGez0uTclmyq7LL0eeVp/iMbOnOPAJh3YaZDUFLkIt61w7H51ULfwFsYdAQCEh92lVP9gzBzTwwmMShumaatpMN/e3YGWQAgHGUF0z7efGdcRe6ISaTQUrBh5hegrlwG4rs5EmVuT+KwuF5soBXqa6Q6+giyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVxnFCrQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740699303; x=1772235303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bkqOxOWQQQCLGRepn5os0rxwFT8Ja2Tsk0+nPgxMF3k=;
  b=OVxnFCrQi5VuGZdkGCfVWiXvhNtab/f9aoizkV3migDpg+6W80C9cFEv
   lIfmPizXCSxhfRlxZrvX84Xv2pOTipP3jA1wulhrNeKnqVtfMslQW3ipN
   bgTXnDNljGwv37G8vp+WrsZmePuE43jor5cgnQZmchmmZGFvxluf5v+5C
   RZTB+5IkQsGa+LHsJNeXIaMTHjdd7W6HMJildbJJTYxP9X6HmubTe4vps
   PuyN+FsT7d6pKibyaHwfRsryl3C9Jq+wQ/Udfeog3H0KSUL2rHaeW4Qq/
   8GssrL8dYb/CFdhXHSuH6/cWuKZT/C4CZosJta4ULDVaayNzjM/asXZe0
   w==;
X-CSE-ConnectionGUID: tTGGOBKcRpKm59+wFWRXTA==
X-CSE-MsgGUID: /VBeWWvOQRGxbl0+8YKmew==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41317907"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41317907"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:35:02 -0800
X-CSE-ConnectionGUID: LZ4CqSA+TDGa2Oiwl5QCwQ==
X-CSE-MsgGUID: 2bABavt/QpyPKQ46ixT8Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117356118"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Feb 2025 15:34:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnnP6-000EB8-1f;
	Thu, 27 Feb 2025 23:34:56 +0000
Date: Fri, 28 Feb 2025 07:34:14 +0800
From: kernel test robot <lkp@intel.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/3] iio: adc: ad7191: add AD7191
Message-ID: <202502280702.31rbuGw8-lkp@intel.com>
References: <20250226115451.249361-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226115451.249361-3-alisa.roman@analog.com>

Hi Alisa-Dariana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alisa-Dariana-Roman/dt-bindings-iio-adc-add-AD7191/20250226-195853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250226115451.249361-3-alisa.roman%40analog.com
patch subject: [PATCH v5 2/3] iio: adc: ad7191: add AD7191
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502280702.31rbuGw8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280702.31rbuGw8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280702.31rbuGw8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7191.c:217:15: warning: variable 'pga_index' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
     217 |                 for (i = 0; i < ARRAY_SIZE(gain); i++) {
         |                             ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7191.c:224:35: note: uninitialized use occurs here
     224 |                 st->scale_avail = &scale_buffer[pga_index];
         |                                                 ^~~~~~~~~
   drivers/iio/adc/ad7191.c:217:15: note: remove the condition if it is always true
     217 |                 for (i = 0; i < ARRAY_SIZE(gain); i++) {
         |                             ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7191.c:160:48: note: initialize the variable 'pga_index' to silence this warning
     160 |         int odr_value, odr_index, pga_value, pga_index, i, ret;
         |                                                       ^
         |                                                        = 0
>> drivers/iio/adc/ad7191.c:179:15: warning: variable 'odr_index' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
     179 |                 for (i = 0; i < ARRAY_SIZE(samp_freq); i++) {
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7191.c:186:36: note: uninitialized use occurs here
     186 |                 st->samp_freq_avail = &samp_freq[odr_index];
         |                                                  ^~~~~~~~~
   drivers/iio/adc/ad7191.c:179:15: note: remove the condition if it is always true
     179 |                 for (i = 0; i < ARRAY_SIZE(samp_freq); i++) {
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7191.c:160:26: note: initialize the variable 'odr_index' to silence this warning
     160 |         int odr_value, odr_index, pga_value, pga_index, i, ret;
         |                                 ^
         |                                  = 0
   drivers/iio/adc/ad7191.c:553:18: error: expected ';' after top level declarator
     553 | MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
         |                  ^
   2 warnings and 1 error generated.


vim +217 drivers/iio/adc/ad7191.c

   150	
   151	static int ad7191_config_setup(struct iio_dev *indio_dev)
   152	{
   153		struct ad7191_state *st = iio_priv(indio_dev);
   154		struct device *dev = &st->sd.spi->dev;
   155		/* Sampling frequencies in Hz, see Table 5 */
   156		static const u32 samp_freq[4] = { 120, 60, 50, 10 };
   157		/* Gain options, see Table 7 */
   158		const u32 gain[4] = { 1, 8, 64, 128 };
   159		static u32 scale_buffer[4][2];
   160		int odr_value, odr_index, pga_value, pga_index, i, ret;
   161		u64 scale_uv;
   162	
   163		st->samp_freq_index = 0;
   164		st->scale_index = 0;
   165	
   166		ret = device_property_read_u32(dev, "adi,odr-value", &odr_value);
   167		if (ret && ret != -EINVAL)
   168			return dev_err_probe(dev, ret, "Failed to get odr value.\n");
   169	
   170		if (ret == -EINVAL) {
   171			st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
   172			if (IS_ERR(st->odr_gpios))
   173				return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
   174						     "Failed to get odr gpios.\n");
   175	
   176			st->samp_freq_avail = samp_freq;
   177			st->samp_freq_avail_size = ARRAY_SIZE(samp_freq);
   178		} else {
 > 179			for (i = 0; i < ARRAY_SIZE(samp_freq); i++) {
   180				if (odr_value != samp_freq[i])
   181					continue;
   182				odr_index = i;
   183				break;
   184			}
   185	
   186			st->samp_freq_avail = &samp_freq[odr_index];
   187			st->samp_freq_avail_size = 1;
   188	
   189			st->odr_gpios = NULL;
   190		}
   191	
   192		mutex_lock(&st->lock);
   193	
   194		for (i = 0; i < ARRAY_SIZE(scale_buffer); i++) {
   195			scale_uv = ((u64)st->int_vref_mv * NANO) >>
   196				(indio_dev->channels[0].scan_type.realbits - 1);
   197			do_div(scale_uv, gain[i]);
   198			scale_buffer[i][1] = do_div(scale_uv, NANO);
   199			scale_buffer[i][0] = scale_uv;
   200		}
   201	
   202		mutex_unlock(&st->lock);
   203	
   204		ret = device_property_read_u32(dev, "adi,pga-value", &pga_value);
   205		if (ret && ret != -EINVAL)
   206			return dev_err_probe(dev, ret, "Failed to get pga value.\n");
   207	
   208		if (ret == -EINVAL) {
   209			st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
   210			if (IS_ERR(st->pga_gpios))
   211				return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
   212						     "Failed to get pga gpios.\n");
   213	
   214			st->scale_avail = scale_buffer;
   215			st->scale_avail_size = ARRAY_SIZE(scale_buffer);
   216		} else {
 > 217			for (i = 0; i < ARRAY_SIZE(gain); i++) {
   218				if (pga_value != gain[i])
   219					continue;
   220				pga_index = i;
   221				break;
   222			}
   223	
   224			st->scale_avail = &scale_buffer[pga_index];
   225			st->scale_avail_size = 1;
   226	
   227			st->pga_gpios = NULL;
   228		}
   229	
   230		st->temp_gpio = devm_gpiod_get(dev, "temp", GPIOD_OUT_LOW);
   231		if (IS_ERR(st->temp_gpio))
   232			return dev_err_probe(dev, PTR_ERR(st->temp_gpio),
   233					     "Failed to get temp gpio.\n");
   234	
   235		st->chan_gpio = devm_gpiod_get(dev, "chan", GPIOD_OUT_LOW);
   236		if (IS_ERR(st->chan_gpio))
   237			return dev_err_probe(dev, PTR_ERR(st->chan_gpio),
   238					     "Failed to get chan gpio.\n");
   239	
   240		return 0;
   241	}
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

