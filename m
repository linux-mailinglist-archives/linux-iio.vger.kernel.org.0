Return-Path: <linux-iio+bounces-8901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F800966E48
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 02:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9584289FE5
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D8339A1;
	Sat, 31 Aug 2024 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWTSE9Br"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8B1C6B5;
	Sat, 31 Aug 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065149; cv=none; b=SX3TArwHzrCJGDuGUNvMWlAoVlvTSMVNrGSTJ7vG6ed8xbQbuh1zD1JszZpqRELrhubVXdTET9UDFN2Bc8oIscv31uKXlR4mQY7WVw/NIccFRYECeBLviHPKM58JBvCOSn+UP1Q/2m3kHN3h/L1zwF22D+nBFpUo6/eeeIzgwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065149; c=relaxed/simple;
	bh=m2q0EIE3WOnElSaZtNtUDPmT9aG++HAOSqsq5F8ycZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/qH6Q98w7AIxEhX9KT1B+/LYnYpNRjuIrmMmSIbhaEn1UkLZQLduP2iXE9yryA4z7f8Y8aXzqcvK8OD3GhEAnpwhdvM7P6DlEkAM6h7WZ2gHfgV/HtGgpkKLoNtBfGhWR6l7OvoumPzTtvlcFSPcD6KG6W5NVIpJ506wi1+hM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWTSE9Br; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725065148; x=1756601148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m2q0EIE3WOnElSaZtNtUDPmT9aG++HAOSqsq5F8ycZo=;
  b=MWTSE9BrC/5wP9addTlwbMw1dEATUI7rCIfIYUbugJkwl1SJt4kS6XAt
   kKaHQO9aF4jNREzLw1nG6+D1xWn5Nr3YhPmZ/LwcWMwovgRImF3eWuUZE
   A8o5JEK36S42uFjj3xZ7uyA0foB08EZR/YfH3e7Pt1h6WhGfbx3q1GroC
   1ZD6L+e6BP/XlMdLChPE8m2351zVwUz5GCqUFkrW5AI/dWtpllpV15Lei
   2xpIKWyfiofZGied+59zT1hGcBohExjkl1HchBOXEIUoRWV7uqYtFzssz
   89SgVcJKeWb1ci9U7Pp0IqTIkafNUrWFR+WRh0/Lf9k4dFIgz8jFQyiqp
   A==;
X-CSE-ConnectionGUID: /F8T9exoRvyR/XD7KIZIOw==
X-CSE-MsgGUID: lOJJfuMDSjWrvDP13Vkx3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23892878"
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="23892878"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 17:45:47 -0700
X-CSE-ConnectionGUID: u/GJuGqQQlK5hrQMr3hglw==
X-CSE-MsgGUID: k697wz3HTuSYiLlEI6//FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="68458817"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2024 17:45:43 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skCFJ-0002Fc-06;
	Sat, 31 Aug 2024 00:45:41 +0000
Date: Sat, 31 Aug 2024 08:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH v5 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV1800B SARADC
Message-ID: <202408310817.GT3TMpnv-lkp@intel.com>
References: <20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5be63fc19fcaa4c236b307420483578a56986a37]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Bonnefille/dt-bindings-iio-adc-sophgo-cv1800b-saradc-Add-Sophgo-CV1800B-SARADC/20240829-203431
base:   5be63fc19fcaa4c236b307420483578a56986a37
patch link:    https://lore.kernel.org/r/20240829-sg2002-adc-v5-2-aacb381e869b%40bootlin.com
patch subject: [PATCH v5 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo CV1800B SARADC
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240831/202408310817.GT3TMpnv-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310817.GT3TMpnv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310817.GT3TMpnv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/sophgo-cv1800b-adc.c:120:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     120 |                 u32 status_reg = readl(saradc->regs + CV1800B_ADC_CYC_SET_REG);
         |                 ^
   1 warning generated.


vim +120 drivers/iio/adc/sophgo-cv1800b-adc.c

    88	
    89	static int cv1800b_adc_read_raw(struct iio_dev *indio_dev,
    90					struct iio_chan_spec const *chan,
    91					int *val, int *val2, long mask)
    92	{
    93		struct cv1800b_adc *saradc = iio_priv(indio_dev);
    94	
    95		switch (mask) {
    96		case IIO_CHAN_INFO_RAW:{
    97			u32 sample;
    98	
    99			scoped_guard(mutex, &saradc->lock) {
   100				int ret;
   101	
   102				cv1800b_adc_start_measurement(saradc, chan->scan_index);
   103				ret = cv1800b_adc_wait(saradc);
   104				if (ret < 0)
   105					return ret;
   106	
   107				sample = readl(saradc->regs + CV1800B_ADC_CH_RESULT_REG(chan->scan_index));
   108			}
   109			if (!(sample & CV1800B_ADC_CH_VALID))
   110				return -ENODATA;
   111	
   112			*val = sample & CV1800B_ADC_CH_RESULT;
   113			return IIO_VAL_INT;
   114			}
   115		case IIO_CHAN_INFO_SCALE:
   116			*val = 3300;
   117			*val2 = 12;
   118			return IIO_VAL_FRACTIONAL_LOG2;
   119		case IIO_CHAN_INFO_SAMP_FREQ:
 > 120			u32 status_reg = readl(saradc->regs + CV1800B_ADC_CYC_SET_REG);
   121			int clk_div = (1 + FIELD_GET(CV1800B_MASK_CLKDIV, status_reg));
   122			int freq = clk_get_rate(saradc->clk) / clk_div;
   123			int nb_startup_cycle = 1 + FIELD_GET(CV1800B_MASK_STARTUP_CYCLE, status_reg);
   124			int nb_sample_cycle = 1 + FIELD_GET(CV1800B_MASK_SAMPLE_WINDOW, status_reg);
   125			int nb_compare_cycle = 1 + FIELD_GET(CV1800B_MASK_COMPARE_CYCLE, status_reg);
   126	
   127			*val = freq / (nb_startup_cycle + nb_sample_cycle + nb_compare_cycle);
   128			return IIO_VAL_INT;
   129		default:
   130			return -EINVAL;
   131		}
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

