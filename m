Return-Path: <linux-iio+bounces-8628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD5957F3F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 09:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC341C23D6A
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0116D33D;
	Tue, 20 Aug 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co/4brcW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739B16B391;
	Tue, 20 Aug 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138427; cv=none; b=JPULxgGtiPxCkxoSRg66v7BvhkJVrH1ia+vZe60R+ZbuH9rtZoqQctlDCsSFdyb0dmIls9HUxhFjc6kPH9n1npKG8YiGhMGAm5DMgLbv5+MYPXK+AT7TNgU5L/jq7kqGco/wFD8DEnkknSeNQjaJ4lN9nOgfd5Kl5gPPTVumPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138427; c=relaxed/simple;
	bh=glSoSr9Tbk75LSg/tAu/FUEqzBhmne/ozkkwbAinyf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYFar4XM1hp0KY/lKzluwUG7We/rDkEi3d3JBvrxPEX6O8MsCG9L0GfWESxdXGlkrbXxESNbcuYmdaRMcKFqJVy9uZkplNbxuHU2+6nugQ1/ZOhn9yVJ35qrfMVlWpiLNNPindp6XwD0zn+aKIwS28RURBc3+VnjBlXpY2XYWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co/4brcW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724138426; x=1755674426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=glSoSr9Tbk75LSg/tAu/FUEqzBhmne/ozkkwbAinyf8=;
  b=co/4brcWXYsggOAu0GvotVTt/ldKgv2yZPb24y95oYTngrYanezawbJ4
   i2SEOP2bE1EgbMUagp75u2WqNoitzmGhKzAeWX5UijxcJ/Ncgyh/CUE5m
   t2MPWQ7gh8zws8zY3GkZgI2fHs7UVKMJmCDTJYdIKJoogl6g4UgL+GzSR
   /ScKiR5Ovp3tPc5mKjOW8w5CIMGlyR0wamlXI76oCxd4S07TuAHfT28VM
   LS4nD/LORRyXV1Oh4SdwYSuKCjimjQ6L7+g2RVsInZLfy4KWnlRiYQD+8
   uiwRcykKwXjhFWjr+xF9+m8gge6Ah8A9iBpoCfIPap9Cj8E4JKDX/g3aF
   Q==;
X-CSE-ConnectionGUID: LS0/4hiGQpqKsY/l8U9EQA==
X-CSE-MsgGUID: uM8dzDQcRQ+wRioEhuJ8xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="21959435"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="21959435"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:20:25 -0700
X-CSE-ConnectionGUID: G3BqePshRN6O0pokLE5trg==
X-CSE-MsgGUID: 4xIVrBGcRKGl8FyWoZMX6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="61400408"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Aug 2024 00:20:20 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgJAA-0009q6-1M;
	Tue, 20 Aug 2024 07:20:18 +0000
Date: Tue, 20 Aug 2024 15:19:38 +0800
From: kernel test robot <lkp@intel.com>
To: Trevor Gamblin <tgamblin@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>,
	Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 2/3] iio: adc: ad7625: add driver
Message-ID: <202408201520.lFtco3eF-lkp@intel.com>
References: <20240819-ad7625_r1-v3-2-75d5217c76b5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-ad7625_r1-v3-2-75d5217c76b5@baylibre.com>

Hi Trevor,

kernel test robot noticed the following build errors:

[auto build test ERROR on ac6a258892793f0a255fe7084ec2b612131c67fc]

url:    https://github.com/intel-lab-lkp/linux/commits/Trevor-Gamblin/dt-bindings-iio-adc-add-AD762x-AD796x-ADCs/20240819-221425
base:   ac6a258892793f0a255fe7084ec2b612131c67fc
patch link:    https://lore.kernel.org/r/20240819-ad7625_r1-v3-2-75d5217c76b5%40baylibre.com
patch subject: [PATCH v3 2/3] iio: adc: ad7625: add driver
config: alpha-randconfig-r132-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201520.lFtco3eF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240820/202408201520.lFtco3eF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201520.lFtco3eF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad7625.c: In function 'ad7625_set_sampling_freq':
>> drivers/iio/adc/ad7625.c:191:15: error: implicit declaration of function 'pwm_round_waveform_might_sleep' [-Werror=implicit-function-declaration]
     191 |         ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7625.c: In function 'ad7625_buffer_preenable':
>> drivers/iio/adc/ad7625.c:420:15: error: implicit declaration of function 'pwm_set_waveform_might_sleep' [-Werror=implicit-function-declaration]
     420 |         ret = pwm_set_waveform_might_sleep(st->cnv_pwm, &st->cnv_wf, false);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pwm_round_waveform_might_sleep +191 drivers/iio/adc/ad7625.c

   175	
   176	static int ad7625_set_sampling_freq(struct ad7625_state *st, int freq)
   177	{
   178		u64 target;
   179		struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
   180		int ret;
   181	
   182		target = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
   183		cnv_wf.period_length_ns = clamp(target, 100, 10 * KILO);
   184	
   185		/*
   186		 * Use the maximum conversion time t_CNVH from the datasheet as
   187		 * the duty_cycle for ref_clk, cnv, and clk_gate
   188		 */
   189		cnv_wf.duty_length_ns = st->info->timing_spec->conv_high_ns;
   190	
 > 191		ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
   192		if (ret)
   193			return ret;
   194	
   195		/*
   196		 * Set up the burst signal for transferring data. period and
   197		 * offset should mirror the CNV signal
   198		 */
   199		clk_gate_wf.period_length_ns = cnv_wf.period_length_ns;
   200	
   201		clk_gate_wf.duty_length_ns = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC *
   202			st->info->chan_spec.scan_type.realbits,
   203			st->ref_clk_rate_hz);
   204	
   205		/* max t_MSB from datasheet */
   206		clk_gate_wf.duty_offset_ns = st->info->timing_spec->conv_msb_ns;
   207	
   208		ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
   209		if (ret)
   210			return ret;
   211	
   212		st->cnv_wf = cnv_wf;
   213		st->clk_gate_wf = clk_gate_wf;
   214	
   215		/* TODO: Add a rounding API for PWMs that can simplify this */
   216		target = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz, freq);
   217		st->sampling_freq_hz = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz,
   218							     target);
   219	
   220		return 0;
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

