Return-Path: <linux-iio+bounces-12623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C099D8339
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D6B161CD2
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB21922E1;
	Mon, 25 Nov 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu6+kOlL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5318755C;
	Mon, 25 Nov 2024 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529743; cv=none; b=gvacUmHXVBFrUFf8+i9rZRS0bUszUUkRjbY/a5Q+bXltE4ItgkbBLYiZSaaXo3rEhm+J2JFluWrsLl+9mxDJ9ALn+L2f4QD6yUtlqDogOjDagfV5iU72r6hq3v8GgE+w+q+u53uMZNniQ3iogu1zEdmsxLMqPUs71mXf2gX118A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529743; c=relaxed/simple;
	bh=GiIac8RYgpyiBtV5sX1sMUgkSXZVze0gtDqZg8DIDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk9kgs8tiUCpR4TuhkhH81QYc0f1Snk5sN1V7A96H8NnMa+d3/XrY83nH1wu27R6tXscT+1g1G1FmR2LcJMtYQFXzVeWkf47SS60Z60zXHwdOou6DHHiE1FISBDZvcDWT5CKwwnmomk0EaKbjMtlui4/2DX7NRLmqYxEmx/my48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu6+kOlL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732529741; x=1764065741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GiIac8RYgpyiBtV5sX1sMUgkSXZVze0gtDqZg8DIDXo=;
  b=Yu6+kOlLN8Ril0d5waDtiR9nXOyMImS4PfVU5ELLGOBuv3Vz3MFP2b76
   pYApLNnzqDs4ZpnPBmJMkmcq/SqKvNPxJ3Y1xXQT1VNbbh8V20rpA7S62
   yE3AyFsAp5ej09+so1w3GSuD1tgcliBmZ3XequIS1zs4QkTBB99aKLVQc
   oRo/9gMyIPJd90E0WYnX1q3P3kigyTgnagx4UxHE7hO+YVEF+ANkRR5op
   x92twRjD+khAGE6Sre6zBjNbSFFBgFbmDXK2Iw2ncCpCVE1KZwo1zNu90
   Ew5Wo6jF3GvTIhzxNglTQJ0f+O4tK5129Wh3HVJnzqZ6LtGOLKKUrHSV1
   w==;
X-CSE-ConnectionGUID: 9e8wPKAmTs2592bGYMcYug==
X-CSE-MsgGUID: FvcvyRYeTteN6WeDnN/Paw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32775361"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32775361"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:15:41 -0800
X-CSE-ConnectionGUID: CXoMBjGrSLi4vnp/rs/TZg==
X-CSE-MsgGUID: PstgRX2IRbmlkbtaqb3uRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91636260"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2024 02:15:37 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFW7y-00068s-2H;
	Mon, 25 Nov 2024 10:15:34 +0000
Date: Mon, 25 Nov 2024 18:14:58 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?unknown-8bit?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 07/10] iio: adc: ad_sigma_delta: Store information
 about reset sequence length
Message-ID: <202411251711.ZE0hl0cg-lkp@intel.com>
References: <20241122113322.242875-19-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122113322.242875-19-u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on adc218676eef25575469234709c2d87185ca223a]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/iio-adc-ad7124-Don-t-create-more-channels-than-the-driver-can-handle/20241125-104725
base:   adc218676eef25575469234709c2d87185ca223a
patch link:    https://lore.kernel.org/r/20241122113322.242875-19-u.kleine-koenig%40baylibre.com
patch subject: [PATCH v3 07/10] iio: adc: ad_sigma_delta: Store information about reset sequence length
config: i386-buildonly-randconfig-003-20241125 (https://download.01.org/0day-ci/archive/20241125/202411251711.ZE0hl0cg-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251711.ZE0hl0cg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251711.ZE0hl0cg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad_sigma_delta.c:186: warning: Excess function parameter 'reset_length' description in 'ad_sd_reset'


vim +186 drivers/iio/adc/ad_sigma_delta.c

af3008485ea037 Lars-Peter Clausen 2012-08-10  176  
7fc10de8d49a74 Dragos Bogdan      2017-09-05  177  /**
7fc10de8d49a74 Dragos Bogdan      2017-09-05  178   * ad_sd_reset() - Reset the serial interface
7fc10de8d49a74 Dragos Bogdan      2017-09-05  179   *
7fc10de8d49a74 Dragos Bogdan      2017-09-05  180   * @sigma_delta: The sigma delta device
7fc10de8d49a74 Dragos Bogdan      2017-09-05  181   * @reset_length: Number of SCLKs with DIN = 1
7fc10de8d49a74 Dragos Bogdan      2017-09-05  182   *
7fc10de8d49a74 Dragos Bogdan      2017-09-05  183   * Returns 0 on success, an error code otherwise.
7fc10de8d49a74 Dragos Bogdan      2017-09-05  184   **/
066265377484bc Uwe Kleine-König   2024-11-22  185  int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
7fc10de8d49a74 Dragos Bogdan      2017-09-05 @186  {
066265377484bc Uwe Kleine-König   2024-11-22  187  	unsigned int reset_length = sigma_delta->info->num_resetclks;
066265377484bc Uwe Kleine-König   2024-11-22  188  	unsigned int size = DIV_ROUND_UP(reset_length, 8);
7fc10de8d49a74 Dragos Bogdan      2017-09-05  189  	uint8_t *buf;
7fc10de8d49a74 Dragos Bogdan      2017-09-05  190  	int ret;
7fc10de8d49a74 Dragos Bogdan      2017-09-05  191  
7fc10de8d49a74 Dragos Bogdan      2017-09-05  192  	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
7fc10de8d49a74 Dragos Bogdan      2017-09-05  193  	if (!buf)
7fc10de8d49a74 Dragos Bogdan      2017-09-05  194  		return -ENOMEM;
7fc10de8d49a74 Dragos Bogdan      2017-09-05  195  
7fc10de8d49a74 Dragos Bogdan      2017-09-05  196  	memset(buf, 0xff, size);
7fc10de8d49a74 Dragos Bogdan      2017-09-05  197  	ret = spi_write(sigma_delta->spi, buf, size);
7fc10de8d49a74 Dragos Bogdan      2017-09-05  198  	kfree(buf);
7fc10de8d49a74 Dragos Bogdan      2017-09-05  199  
7fc10de8d49a74 Dragos Bogdan      2017-09-05  200  	return ret;
7fc10de8d49a74 Dragos Bogdan      2017-09-05  201  }
ef807729767fb7 Jonathan Cameron   2022-01-30  202  EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
7fc10de8d49a74 Dragos Bogdan      2017-09-05  203  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

