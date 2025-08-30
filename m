Return-Path: <linux-iio+bounces-23447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC6B3CAB7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DC87AA94E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80C279DA3;
	Sat, 30 Aug 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpQZjXeM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79326461F;
	Sat, 30 Aug 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756555762; cv=none; b=hQbu0/QadR8u7Yw0w0eOSH/eYD7LuhjeaVHIacg037xa/fE8yNZVT3afVLzEj+SkhTP2preL/3XVeF8eEjx8DxgxPTl8HpYvCwdlu1nC781Jtm629YyHajmbbXRhRobO8yg0kb0QbYSpBhLkxU7WCmqNJ7pq5ifPk4AFQGxavds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756555762; c=relaxed/simple;
	bh=1+xq6OH5070SzEoSMljxDD2Dtf3DYllZFYJcUxswmQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM6+skPsRf0+P7N3r+lPYB8SV/rwDUH3PJ20BjUlvHP9FoRUcun2koN2mSuPR8C7nVstCyf8rUiexroCrD8cMjUGeZRPjeIdsIDEU+xbaqgie43MImBZ/rAk5cYnijMk/sRvQxQAsirwhXoWy0Y+6XnVQkoGTFwgR2QsPM3vgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpQZjXeM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756555759; x=1788091759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+xq6OH5070SzEoSMljxDD2Dtf3DYllZFYJcUxswmQo=;
  b=XpQZjXeMlGd/eRixVem5MjRl1MwW1mArgTCc9LxvcWrfEDtIpfT5Fe88
   ySgHHYEA/Kwi/FSEcRuh3fXeVfD8FVgLA5pa1aMNV3YA5TTg9Fk4V9zcx
   4h0jTeqIpiHGFn9lcyULMMAcLSjCj/adXvEYMjHiRk7SRkQ++3GEBnFHQ
   cugRKpN78rmEEeyMluJnnbWrZbwlkNfLL3nl5vy+gvfVs/ipFbGge5AVk
   U7Inwe94l2+fu+siC623WUkSMrev8jbftbnm0f+fbFPm/C9Fi+s38KcEi
   pTh0bAFVRHAGgz1YHx2EKj+PGZBLWXc0DzWK39gQijdCz5Ma9knNfoOM1
   A==;
X-CSE-ConnectionGUID: neV2N1BhTA+5fB6fZ7/XGg==
X-CSE-MsgGUID: GAipdPOhShyqFHdFMfxKfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81415163"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81415163"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 05:09:19 -0700
X-CSE-ConnectionGUID: CDsjC0QASdmYqG2IE1GfVA==
X-CSE-MsgGUID: 0TCqgrzkQ76l4KQQn0hFRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="174931769"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2025 05:09:14 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usKOB-000VLL-1G;
	Sat, 30 Aug 2025 12:09:04 +0000
Date: Sat, 30 Aug 2025 20:08:07 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org,
	Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
	ahaslam@baylibre.com, sergiu.cuciurean@analog.com,
	tgamblin@baylibre.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH 07/15] iio: adc: ad4030: Add SPI offload support
Message-ID: <202508301919.3TZbcu20-lkp@intel.com>
References: <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 91812d3843409c235f336f32f1c37ddc790f1e03]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/iio-adc-ad4030-Fix-_scale-for-when-oversampling-is-enabled/20250830-084901
base:   91812d3843409c235f336f32f1c37ddc790f1e03
patch link:    https://lore.kernel.org/r/0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt%40analog.com
patch subject: [PATCH 07/15] iio: adc: ad4030: Add SPI offload support
config: x86_64-buildonly-randconfig-005-20250830 (https://download.01.org/0day-ci/archive/20250830/202508301919.3TZbcu20-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508301919.3TZbcu20-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508301919.3TZbcu20-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad4030.c: In function '__ad4030_set_sampling_freq':
>> drivers/iio/adc/ad4030.c:518:23: error: implicit declaration of function 'pwm_round_waveform_might_sleep' [-Werror=implicit-function-declaration]
     518 |                 ret = pwm_round_waveform_might_sleep(st->conv_trigger, &conv_wf);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad4030.c: In function 'ad4030_offload_buffer_postenable':
>> drivers/iio/adc/ad4030.c:1055:15: error: implicit declaration of function 'pwm_set_waveform_might_sleep' [-Werror=implicit-function-declaration]
    1055 |         ret = pwm_set_waveform_might_sleep(st->conv_trigger, &st->conv_wf, false);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pwm_round_waveform_might_sleep +518 drivers/iio/adc/ad4030.c

   496	
   497	static int __ad4030_set_sampling_freq(struct ad4030_state *st, unsigned int freq)
   498	{
   499		struct spi_offload_trigger_config *config = &st->offload_trigger_config;
   500		struct pwm_waveform conv_wf = { };
   501		u64 offload_period_ns;
   502		u64 offload_offset_ns;
   503		u32 mode;
   504		int ret;
   505		u64 target = AD4030_TCNVH_NS;
   506	
   507		conv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
   508		/*
   509		 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
   510		 * rounded PWM's value is less than 10, increase the target value by 10
   511		 * and attempt to round the waveform again, until the value is at least
   512		 * 10 ns. Use a separate variable to represent the target in case the
   513		 * rounding is severe enough to keep putting the first few results under
   514		 * the minimum 10ns condition checked by the while loop.
   515		 */
   516		do {
   517			conv_wf.duty_length_ns = target;
 > 518			ret = pwm_round_waveform_might_sleep(st->conv_trigger, &conv_wf);
   519			if (ret)
   520				return ret;
   521			target += 10;
   522		} while (conv_wf.duty_length_ns < 10);
   523	
   524		offload_period_ns = conv_wf.period_length_ns;
   525	
   526		ret = regmap_read(st->regmap, AD4030_REG_MODES, &mode);
   527		if (ret)
   528			return ret;
   529		if (FIELD_GET(AD4030_REG_MODES_MASK_OUT_DATA_MODE, mode) == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {
   530			u32 avg;
   531	
   532			ret = regmap_read(st->regmap, AD4030_REG_AVG, &avg);
   533			if (ret)
   534				return ret;
   535	
   536			offload_period_ns <<= FIELD_GET(AD4030_REG_AVG_MASK_AVG_VAL, avg);
   537		}
   538	
   539		config->periodic.frequency_hz =  DIV_ROUND_UP_ULL(NSEC_PER_SEC,
   540								  offload_period_ns);
   541	
   542		/*
   543		 * The hardware does the capture on zone 2 (when spi trigger PWM
   544		 * is used). This means that the spi trigger signal should happen at
   545		 * tsync + tquiet_con_delay being tsync the conversion signal period
   546		 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
   547		 *
   548		 * The PWM waveform API only supports nanosecond resolution right now,
   549		 * so round this setting to the closest available value.
   550		 */
   551		offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
   552		do {
   553			config->periodic.offset_ns = offload_offset_ns;
   554			ret = spi_offload_trigger_validate(st->offload_trigger, config);
   555			if (ret)
   556				return ret;
   557			offload_offset_ns += 10;
   558	
   559		} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
   560	
   561		st->conv_wf = conv_wf;
   562	
   563		return 0;
   564	}
   565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

