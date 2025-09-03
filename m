Return-Path: <linux-iio+bounces-23695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35862B42CC7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 00:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5521F1B274B5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA72EDD76;
	Wed,  3 Sep 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8MsM39I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1C2EDD64;
	Wed,  3 Sep 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938589; cv=none; b=XIdFcia1qK9LpNH7u7BJY1q57AjVifUcPVKPc6hxV+MW5EZ+m8yZKohbOHaRLAUqX1z6I9k77MKLRe7XSuK/wtIkehi2poozbQGbT7GBfmacFj8DqgV6siUuRLL39UaAhZOMYeRWz6QKcZZ7Q7f9PcSW01b2xgGgZUJO1ER9kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938589; c=relaxed/simple;
	bh=PSEVuZUNWlueqS+Ui8pc2fm3qOdMiz+R5imI8e5EXAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix1Vxbw5ALQbdayYfJ/RbM3iNaiuEAOsfRt+j7qKqjwEPKyeNYpNLM9b6SgtQe68v+3lTgmdvTJapaFCvViuDqoI22PouJxCwvQ6ZGoAjkdwiswtoRSR4FGiELGaq3ijFutcUAwa0otJQ6WJXu4gJ9xVRkdhjUftdhPfNtrRtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8MsM39I; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756938588; x=1788474588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PSEVuZUNWlueqS+Ui8pc2fm3qOdMiz+R5imI8e5EXAw=;
  b=e8MsM39ITKnyhH7t9WtSxSpg+qD7sH6h/RlV+cn406O8eHFBmqRbN/p/
   9AS7e7rriVKgifKOE0BdplgG7Xfo/DrkCwslTLjcvr8hrKIir32WLOL6J
   +oJuRlUcq8xKsISbcfc87SY2R5hZrbLl8hcVMqV26ZDlz059/sQWmucB7
   ghPnd2EMKIsk+PPhME2La3WWjxZ4+g9hZrdrSasHCzBAtFRMJE9p6tDtN
   apGxnzl8FTybkfYwMT8aEW0dRrV5de0fVJo9J9+MfRKx2YSMnv4AGXkbO
   gokN2UAEQ3Sj0x36DzhBXA6+AB+jftVTIvivfBxeGJzqg5tBBlB1HV+m0
   Q==;
X-CSE-ConnectionGUID: ugixRcPGQwehC63L/m7Dlw==
X-CSE-MsgGUID: WAlhLn7YRmaYYhqKSg/FeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59378141"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59378141"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:29:47 -0700
X-CSE-ConnectionGUID: 40QyShBNR7CMykOLW2VH5Q==
X-CSE-MsgGUID: mfOXVpV6SzGI80goFY9hpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="172161049"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Sep 2025 15:29:43 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utvyk-0004Tz-1o;
	Wed, 03 Sep 2025 22:29:33 +0000
Date: Thu, 4 Sep 2025 06:28:27 +0800
From: kernel test robot <lkp@intel.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v10 2/2] iio: adc: max14001: New driver
Message-ID: <202509040617.gcAKQNlG-lkp@intel.com>
References: <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>

Hi Marilene,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d1487b0b78720b86ec2a2ac7acc683ec90627e5b]

url:    https://github.com/intel-lab-lkp/linux/commits/Marilene-Andrade-Garcia/dt-bindings-iio-adc-add-max14001/20250902-212046
base:   d1487b0b78720b86ec2a2ac7acc683ec90627e5b
patch link:    https://lore.kernel.org/r/f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia%40gmail.com
patch subject: [PATCH v10 2/2] iio: adc: max14001: New driver
config: hexagon-randconfig-r113-20250904 (https://download.01.org/0day-ci/archive/20250904/202509040617.gcAKQNlG-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 2e122990391b2ba062e6308a12cfedf7206270ba)
reproduce: (https://download.01.org/0day-ci/archive/20250904/202509040617.gcAKQNlG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509040617.gcAKQNlG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/max14001.c:109:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] spi_tx_buffer @@     got unsigned long @@
   drivers/iio/adc/max14001.c:109:27: sparse:     expected restricted __be16 [usertype] spi_tx_buffer
   drivers/iio/adc/max14001.c:109:27: sparse:     got unsigned long
>> drivers/iio/adc/max14001.c:110:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __be16 [usertype] spi_tx_buffer @@
   drivers/iio/adc/max14001.c:110:29: sparse:     expected unsigned short [usertype] val
   drivers/iio/adc/max14001.c:110:29: sparse:     got restricted __be16 [usertype] spi_tx_buffer
>> drivers/iio/adc/max14001.c:110:29: sparse: sparse: cast from restricted __be16
>> drivers/iio/adc/max14001.c:110:29: sparse: sparse: cast from restricted __be16
>> drivers/iio/adc/max14001.c:110:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [usertype] __x @@     got restricted __be16 [usertype] @@
   drivers/iio/adc/max14001.c:110:29: sparse:     expected unsigned short [usertype] __x
   drivers/iio/adc/max14001.c:110:29: sparse:     got restricted __be16 [usertype]
>> drivers/iio/adc/max14001.c:110:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] spi_tx_buffer @@     got int @@
   drivers/iio/adc/max14001.c:110:27: sparse:     expected restricted __be16 [usertype] spi_tx_buffer
   drivers/iio/adc/max14001.c:110:27: sparse:     got int
>> drivers/iio/adc/max14001.c:120:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] spi_rx_buffer @@     got int @@
   drivers/iio/adc/max14001.c:120:27: sparse:     expected restricted __be16 [usertype] spi_rx_buffer
   drivers/iio/adc/max14001.c:120:27: sparse:     got int
>> drivers/iio/adc/max14001.c:121:21: sparse: sparse: cast to restricted __be16
>> drivers/iio/adc/max14001.c:121:21: sparse: sparse: restricted __be16 degrades to integer
>> drivers/iio/adc/max14001.c:121:21: sparse: sparse: restricted __be16 degrades to integer
   drivers/iio/adc/max14001.c:133:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] spi_tx_buffer @@     got unsigned long @@
   drivers/iio/adc/max14001.c:133:27: sparse:     expected restricted __be16 [usertype] spi_tx_buffer
   drivers/iio/adc/max14001.c:133:27: sparse:     got unsigned long
   drivers/iio/adc/max14001.c:136:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __be16 [usertype] spi_tx_buffer @@
   drivers/iio/adc/max14001.c:136:29: sparse:     expected unsigned short [usertype] val
   drivers/iio/adc/max14001.c:136:29: sparse:     got restricted __be16 [usertype] spi_tx_buffer
   drivers/iio/adc/max14001.c:136:29: sparse: sparse: cast from restricted __be16
   drivers/iio/adc/max14001.c:136:29: sparse: sparse: cast from restricted __be16
   drivers/iio/adc/max14001.c:136:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [usertype] __x @@     got restricted __be16 [usertype] @@
   drivers/iio/adc/max14001.c:136:29: sparse:     expected unsigned short [usertype] __x
   drivers/iio/adc/max14001.c:136:29: sparse:     got restricted __be16 [usertype]
   drivers/iio/adc/max14001.c:136:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] spi_tx_buffer @@     got int @@
   drivers/iio/adc/max14001.c:136:27: sparse:     expected restricted __be16 [usertype] spi_tx_buffer
   drivers/iio/adc/max14001.c:136:27: sparse:     got int

vim +109 drivers/iio/adc/max14001.c

    89	
    90	static int max14001_read(struct max14001_state *st, u16 reg_addr, u16 *reg_data)
    91	{
    92		struct spi_transfer xfers[] = {
    93			{
    94				.tx_buf = &st->spi_tx_buffer,
    95				.len = sizeof(st->spi_tx_buffer),
    96				.cs_change = 1,
    97			}, {
    98				.rx_buf = &st->spi_rx_buffer,
    99				.len = sizeof(st->spi_rx_buffer),
   100			},
   101		};
   102		int ret;
   103	
   104		/*
   105		 * Prepare SPI transmit buffer 16 bit-value big-endian format and
   106		 * reverses bit order to align with the LSB-first input on SDI port
   107		 * in order to meet the device communication requirements.
   108		 */
 > 109		st->spi_tx_buffer = FIELD_PREP(MAX14001_MASK_ADDR, reg_addr);
 > 110		st->spi_tx_buffer = bitrev16(cpu_to_be16(st->spi_tx_buffer));
   111	
   112		ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
   113		if (ret)
   114			return ret;
   115	
   116		/*
   117		 * Convert received 16-bit value from big-endian to cpu-endian format
   118		 * and reverses bit order.
   119		 */
 > 120		st->spi_rx_buffer = bitrev16(be16_to_cpu(st->spi_rx_buffer));
 > 121		*reg_data = FIELD_GET(MAX14001_MASK_DATA, st->spi_rx_buffer);
   122	
   123		return 0;
   124	}
   125	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

