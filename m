Return-Path: <linux-iio+bounces-11827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DB9B9F0D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 11:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9F11C215CD
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3361714D9;
	Sat,  2 Nov 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hfmsa6p8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50D17085C;
	Sat,  2 Nov 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730544461; cv=none; b=ib9Ibb+HwaTpSQsDfmrvbQbFBWWBg2wUtCSSp/gN4fvLPB4F6qG5YIX9AuyS7xV/H1V+x2WZP35IgNoe9TRcIj1Y9zPMY8IwsFktJJfSP+FPYsZNZc8tvwqBlFbjoaZopNoLiy5vdBtXGQvKY05EBby/wpOWlVU7v07O6Ij8SDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730544461; c=relaxed/simple;
	bh=zybFxd/JEqTLlTVQcJAakhPKB9jHi5x6yGUbpN3RLkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdMC5xPGX1tTNpHAA2sEBaox+NGAEV+UucC0AIOcG3MLjNfnZQhAhYO6KGwUnybyQ2xRU0JKRralT5rkutLJ+3MB15kWl0o39Rm2VJ1Q55KZIlTEGe2XRAEsRzEQlTAvg3YHDfsKw9B9c1ajG30DpvrBC8KgeWHB4KkuK6oP48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hfmsa6p8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730544459; x=1762080459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zybFxd/JEqTLlTVQcJAakhPKB9jHi5x6yGUbpN3RLkQ=;
  b=Hfmsa6p8WAIo5Ql42LN8E4rqZoCP36SKdUjzedRAh0CfwpYF50gXMdat
   +mwD5vUhGbmG2h2lE4T2efJsqgxcQmwARODj+oXq94F7e1oXPOYT1yKSO
   oaR+EL9YQL1fDp0AQd5sOLz0TMY3Te0SBN7EerFI7FaJRI27i6ZhmkJ7X
   0YCmUNKiKXZLRfuiSiVdBl6sx1h+e3zrj4v9nCz/JAWSUM5LCiPLGDGAI
   AhSmkL4SnGF5g72FmVhG2yBxXAtqQrBMomuLiVVVFOrjweWIOwqX7/Uj1
   gxyIRsIJjFGwCjznpvaZ3uv+cMeXOc31LxmQJSD9DWPDYnUTXqfvJVBVs
   w==;
X-CSE-ConnectionGUID: uIoyf/SYSBmO7OJeBt4oZA==
X-CSE-MsgGUID: JckAahPFS/aIccDj13yQ6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52865922"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52865922"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 03:47:38 -0700
X-CSE-ConnectionGUID: fdgXRwBHRWaknwcAKmGDkA==
X-CSE-MsgGUID: 33/uCdm4SVmTE6cRcbybZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="113978725"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Nov 2024 03:47:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7BfF-000inD-0a;
	Sat, 02 Nov 2024 10:47:29 +0000
Date: Sat, 2 Nov 2024 18:46:53 +0800
From: kernel test robot <lkp@intel.com>
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
	daniel.lezcano@linaro.org, sboyd@kernel.org,
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
	quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
	amitk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lee@kernel.org, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de,
	quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
	Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH V4 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <202411021830.6iNtNN1E-lkp@intel.com>
References: <20241030185854.4015348-4-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030185854.4015348-4-quic_jprakash@quicinc.com>

Hi Jishnu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6fb2fa9805c501d9ade047fc511961f3273cdcb5]

url:    https://github.com/intel-lab-lkp/linux/commits/Jishnu-Prakash/dt-bindings-iio-adc-Move-QCOM-ADC-bindings-to-iio-adc-folder/20241031-030237
base:   6fb2fa9805c501d9ade047fc511961f3273cdcb5
patch link:    https://lore.kernel.org/r/20241030185854.4015348-4-quic_jprakash%40quicinc.com
patch subject: [PATCH V4 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20241102/202411021830.6iNtNN1E-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021830.6iNtNN1E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021830.6iNtNN1E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/qcom-spmi-adc5-gen3.c:31: warning: Cannot understand  * @adc_tm: indicates TM type if the channel is used for TM measurements.
    on line 31 - I thought it was a doc line
>> drivers/iio/adc/qcom-spmi-adc5-gen3.c:70: warning: Function parameter or struct member 'dev_data' not described in 'adc5_chip'
>> drivers/iio/adc/qcom-spmi-adc5-gen3.c:70: warning: Function parameter or struct member 'tm_aux' not described in 'adc5_chip'


vim +31 drivers/iio/adc/qcom-spmi-adc5-gen3.c

    29	
    30	/**
  > 31	 * @adc_tm: indicates TM type if the channel is used for TM measurements.
    32	 * @chip: pointer to top-level ADC device structure.
    33	 */
    34	
    35	struct adc5_channel_prop {
    36		struct adc5_channel_common_prop common_props;
    37		int				adc_tm;
    38		struct adc5_chip		*chip;
    39	};
    40	
    41	/**
    42	 * struct adc5_chip - ADC private structure.
    43	 * @dev: SPMI ADC5 Gen3 device.
    44	 * @num_sdams: number of SDAMs (Shared Direct Access Memory Module) being used.
    45	 * @nchannels: number of ADC channels.
    46	 * @chan_props: array of ADC channel properties.
    47	 * @iio_chans: array of IIO channels specification.
    48	 * @complete: ADC result notification after interrupt is received.
    49	 * @lock: ADC lock for access to the peripheral, to prevent concurrent
    50	 * requests from multiple clients.
    51	 * @n_tm_channels: number of ADC channels used for TM measurements.
    52	 * @data: software configuration data.
    53	 */
    54	struct adc5_chip {
    55		struct device			*dev;
    56		struct adc5_device_data	dev_data;
    57		unsigned int			num_sdams;
    58		unsigned int			nchannels;
    59		struct adc5_channel_prop	*chan_props;
    60		struct iio_chan_spec		*iio_chans;
    61		struct completion		complete;
    62		/*
    63		 * lock for access to the peripheral, to prevent concurrent
    64		 * requests from multiple clients.
    65		 */
    66		struct mutex			lock;
    67		const struct adc5_data		*data;
    68		unsigned int			n_tm_channels;
    69		struct auxiliary_device		*tm_aux;
  > 70	};
    71	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

