Return-Path: <linux-iio+bounces-27255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32CCD27BE
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 06:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF5B230115FE
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6E2BE03B;
	Sat, 20 Dec 2025 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBySW845"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C01B808;
	Sat, 20 Dec 2025 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766207627; cv=none; b=d8CacllknMqTTgaPRB4cbiZhrXLF1UOJbP8QIUwCmtRUtjCjMDVWpifH8MetAMKsz58AifD2Rd1++qVGoSRFKH/mVR+6oipH7ml5CZnJ+9zymH69qOX49uYl6/6NqlnYvBi1SmKAmtGUyy16IMAAH2ohUrDyVrRJYAl+gW0nP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766207627; c=relaxed/simple;
	bh=ZcLSKFFXyPlwDK310t9a5hYrDRgEz8LSQOm4CLfkE00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9dZlWr6eT7SOnZHGmdj/tRy2W7+U+/6LAgwYpxAo6dcBp3YNK1J78Im/cdGNuQLJb7setXjO4nLWBe24pTsgF5MVYzLcaxQnq7SdDEmuBs9Yk5/VXDXSQVX28M+L16p0ppZW12LjqG61EVjkkff20CiclzMwAtBfdN2R99/f0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBySW845; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766207625; x=1797743625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZcLSKFFXyPlwDK310t9a5hYrDRgEz8LSQOm4CLfkE00=;
  b=mBySW845x1WnDjWlncpNF7Ldi0wt/rmH3hq742TrXEt2pVHHkbdDM7mL
   58hs7Oad1BQoKlEZPF7sLlK2cLWBK0Y3Uq3DgAI6UO85LLJfGUtbPxuYe
   nAEZKxbKjX9mgd7LxFSBsj2MBl/2S+bOq9dci1AatQ9qdH4ARZm7ah7sK
   Km5y+J1DWbaHTrnSH3EGqiSKkfsjUia4Cq3k7dalHW7Gx4RD1IV/H6+yF
   EBT/ZuNr/jDkNnbZuadCIPqQQpRJ1SwigvfQbJQWuYtCALt8XGoumF5iH
   w9bP634kOjiwC57C7nF9EhmSbyvjAUhFjNiP2/Wb6aW6FhasKRMHL606C
   g==;
X-CSE-ConnectionGUID: nZ81PX3XQdOtUZsxQTXwbQ==
X-CSE-MsgGUID: zGGmwRWlQ/m38hb4J9DCMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78478932"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="78478932"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 21:13:45 -0800
X-CSE-ConnectionGUID: W9jqGzsISjqRa9i4XVC5zg==
X-CSE-MsgGUID: PnZH+RuoQzmb3XUMSfIIBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="222454505"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Dec 2025 21:13:42 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWpHf-000000004Lt-3QWK;
	Sat, 20 Dec 2025 05:13:39 +0000
Date: Sat, 20 Dec 2025 13:13:08 +0800
From: kernel test robot <lkp@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH 1/2] iio: adc: ad9467: include two's complement in
 default mode
Message-ID: <202512201254.2FFxkibV-lkp@intel.com>
References: <20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d@vaisala.com>

Hi Tomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on a7b10f0963c651a6406d958a5f64b9c5594f84da]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomas-Melin/iio-adc-ad9467-include-two-s-complement-in-default-mode/20251216-233841
base:   a7b10f0963c651a6406d958a5f64b9c5594f84da
patch link:    https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d%40vaisala.com
patch subject: [PATCH 1/2] iio: adc: ad9467: include two's complement in default mode
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512201254.2FFxkibV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512201254.2FFxkibV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512201254.2FFxkibV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad9467.c:686:3: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     686 |                 FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
         |                 ^
   drivers/iio/adc/ad9467.c:1197:4: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1197 |                         FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
         |                         ^
   2 errors generated.


vim +/FIELD_PREP +686 drivers/iio/adc/ad9467.c

   678	
   679	static int ad9647_calibrate_prepare(struct ad9467_state *st)
   680	{
   681		unsigned int cmode;
   682		unsigned int c;
   683		int ret;
   684	
   685		cmode = (st->info->default_output_mode & ~AN877_ADC_OUTPUT_MODE_MASK) |
 > 686			FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
   687				   AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
   688		ret = ad9467_outputmode_set(st, cmode);
   689		if (ret)
   690			return ret;
   691	
   692		for (c = 0; c < st->info->num_channels; c++) {
   693			ret = ad9467_testmode_set(st, c, AN877_ADC_TESTMODE_PN9_SEQ);
   694			if (ret)
   695				return ret;
   696	
   697			ret = ad9467_backend_testmode_on(st, c,
   698							 IIO_BACKEND_ADI_PRBS_9A);
   699			if (ret)
   700				return ret;
   701		}
   702	
   703		return 0;
   704	}
   705	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

