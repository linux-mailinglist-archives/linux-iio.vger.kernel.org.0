Return-Path: <linux-iio+bounces-25143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605ABE3A0E
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB441A63F68
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617603376BD;
	Thu, 16 Oct 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WlRlFvw9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86A338F5F;
	Thu, 16 Oct 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620444; cv=none; b=fSKYf5qsQMRUwVk9h11wNKgKasAg080JtVzg9I7l75sEZ0anJsxaseLD8Hj5SZlHloSa5Ilq7gtgUaMjh7JfR/bAhiUbn1MfaW3rfPmkDJWCDtTXJDnSipTzLHWpJHd3ZRLG4YpqRMF0/UHLTMqqVyM+2RhbSvFU4S3gaV0FghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620444; c=relaxed/simple;
	bh=f1jSt7aAO6g1KOQbj+5i+zz2EOi4pLeJVv7XCY2lQYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn7tVv9EZ/tleWiaLyt2982ixsHL28165P8v26t/w0Ot6/wJ3w32evpKehsYA4ES/qaz+n4jTUY+35QhRJJL5tXienDmuD+SzGfkob4y5xpIwE+RogsSzNgPtpbd4dBnH4Ml5M3XeRMPMYjKRha72Jkp4otEyQ3nd85A211JOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WlRlFvw9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760620443; x=1792156443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f1jSt7aAO6g1KOQbj+5i+zz2EOi4pLeJVv7XCY2lQYo=;
  b=WlRlFvw9pvxMnnh7MyR4Y3lJ36+5aFqLUoc+FlFL1YAE4ZHsps51aHQ4
   VraRvSp6RRU5F2+doZRxNY6Ndl+WcHZ8YNP07Apc51P0ToEuVd/w9RBqd
   ccEbyRK93jnc1HC31DlxWZ+zjPzE04FPOJTYPkuxGaDh9/+H/hM63C7T2
   yuSTmFNvelveaCa7XxrhdV0tPqO4t8HYw6G+PZN5HQ7r+hUaaY1/k870h
   outWt7a2+FSxCJC9Gi1jK/F5L3Wqg3697R1BthmtlxOwgJv+mMCCAttaA
   KzllvlOsDFyELdJ6jLhBpyqH+K7tiU/BsSZmUHigCQ7p8WkeJamOw3jto
   Q==;
X-CSE-ConnectionGUID: KqadeojlSWO2qW4TmVqR5g==
X-CSE-MsgGUID: Stc3Oa1+RXabCGxHPlr+jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62710896"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62710896"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 06:14:02 -0700
X-CSE-ConnectionGUID: L7Wy79iRQ22E6MwZ53EzBw==
X-CSE-MsgGUID: B4saKIrCTcq1Lu/FOO4KgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182431750"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 16 Oct 2025 06:13:57 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Nnm-0004q3-1L;
	Thu, 16 Oct 2025 13:13:54 +0000
Date: Thu, 16 Oct 2025 21:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <202510162035.gngVSgxu-lkp@intel.com>
References: <20251015142816.1274605-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015142816.1274605-3-herve.codina@bootlin.com>

Hi Herve,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on geert-renesas-devel/next linus/master v6.18-rc1 next-20251015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina-Schneider-Electric/dt-bindings-iio-adc-Add-the-Renesas-RZ-N1-ADC/20251015-223254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251015142816.1274605-3-herve.codina%40bootlin.com
patch subject: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251016/202510162035.gngVSgxu-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510162035.gngVSgxu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510162035.gngVSgxu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/rzn1-adc.c: In function 'rzn1_adc_vc_setup_conversion':
   drivers/iio/adc/rzn1-adc.c:53:49: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      53 | #define RZN1_ADC_VC_ADC1_CHANNEL_SEL(_c)        FIELD_PREP(RZN1_ADC_VC_ADC1_CHANNEL_SEL_MASK, _c)
         |                                                 ^~~~~~~~~~
   drivers/iio/adc/rzn1-adc.c:243:49: note: in expansion of macro 'RZN1_ADC_VC_ADC1_CHANNEL_SEL'
     243 |                 vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(adc1_ch);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/rzn1-adc.c: In function 'rzn1_adc_vc_wait_conversion':
   drivers/iio/adc/rzn1-adc.c:58:41: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
      58 | #define RZN1_ADC_ADCX_GET_DATA(_reg)    FIELD_GET(RZN1_ADC_ADCX_DATA_DATA_MASK, _reg)
         |                                         ^~~~~~~~~
   drivers/iio/adc/rzn1-adc.c:304:30: note: in expansion of macro 'RZN1_ADC_ADCX_GET_DATA'
     304 |                 *adc1_data = RZN1_ADC_ADCX_GET_DATA(data_reg);
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/rzn1-adc.c: At top level:
>> drivers/iio/adc/rzn1-adc.c:592:12: warning: 'rzn1_adc_pm_runtime_resume' defined but not used [-Wunused-function]
     592 | static int rzn1_adc_pm_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/rzn1-adc.c:582:12: warning: 'rzn1_adc_pm_runtime_suspend' defined but not used [-Wunused-function]
     582 | static int rzn1_adc_pm_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/rzn1_adc_pm_runtime_resume +592 drivers/iio/adc/rzn1-adc.c

   581	
 > 582	static int rzn1_adc_pm_runtime_suspend(struct device *dev)
   583	{
   584		struct iio_dev *indio_dev = dev_get_drvdata(dev);
   585		struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
   586	
   587		rzn1_adc_disable(rzn1_adc);
   588	
   589		return 0;
   590	}
   591	
 > 592	static int rzn1_adc_pm_runtime_resume(struct device *dev)
   593	{
   594		struct iio_dev *indio_dev = dev_get_drvdata(dev);
   595		struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
   596	
   597		return rzn1_adc_enable(rzn1_adc);
   598	}
   599	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

