Return-Path: <linux-iio+bounces-12788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54429DBBCB
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37664160486
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B851C0DCB;
	Thu, 28 Nov 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZzYK1Kr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E51C07EA;
	Thu, 28 Nov 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815103; cv=none; b=YmNQys2Kkkb5u8XqYWoeOIRMMsgsspZYneNafoAIJyQK1htlHGfnnQecTVm6cCgZRQMDCyArgq7lyfstFhflt28kvxqIogyqp3IGDFRKm+o2t1YJrZ5Kg3IAXftLcm5bp2uvcrYkgDUfqI6eTxGncRAfsx++syT9H9MjN0M7/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815103; c=relaxed/simple;
	bh=3AKUuiObs+e1uBCz93ES4BASLwZLDVbY+1tiCBDiXY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coCiqUP180+WGRSQEn+aKZXU9mVhJkh0LcYeh6VJsKaH/WmZlrcq1BbV4bqpE7l98gaGlZa16NG/squOgDZw2GgdvF9EiJS+MT+CmRPlakITuX5S7IqxGszL9st04XYYQjp9sYskAtTycrTExscuGe0VJD7amzczvzMp6EeuJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZzYK1Kr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732815102; x=1764351102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3AKUuiObs+e1uBCz93ES4BASLwZLDVbY+1tiCBDiXY4=;
  b=TZzYK1KrNsJjJxEEz+eP1dz+FA3g24whzRPTMB1RmYK8xSQzIi9O4Ivh
   a/yuCHMMDSNXeKBITJu2GxYYTmNO8oaufS68m5ZHrBBbyniRZ7KblbgvX
   8Wx2xWBfNfKZFGuONSpNjNXGP9UA1Q7HT6NgaRn5bMBeZEwMLrlgNBOBM
   aAXEmSZwZPXEFVWJ6+3lqHNF9ChtRQeUYXUeRMo9Dz4moQ28TVrF1M5vW
   g0xrFVzwPPT7PtfEj79xge4OUg6x70aDJppYe65WH3gAMoXRcHGyoLwom
   aNAAFzMg/Rly3CnVqeUOs/cHYRputSlOoEl0AQCjK2LFE0tuaoJXGiWYE
   w==;
X-CSE-ConnectionGUID: zioJRSkBQPiE2Ob9StZnPQ==
X-CSE-MsgGUID: ek9Jk+ptQKCLqmqGz3vBOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33199592"
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="33199592"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 09:31:41 -0800
X-CSE-ConnectionGUID: DI1xBrGCRJ+g+YmFKEnJ/A==
X-CSE-MsgGUID: bPriJ3uZTti7iZm1sdUaHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="92387059"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Nov 2024 09:31:37 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGiMZ-0009rn-1r;
	Thu, 28 Nov 2024 17:31:35 +0000
Date: Fri, 29 Nov 2024 01:31:15 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
Message-ID: <202411290140.7k2Z9JSi-lkp@intel.com>
References: <9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build errors:

[auto build test ERROR on a61ff7eac77e86de828fe28c4e42b8ae9ec2b195]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/iio-accel-kx022a-Use-cleanup-h-helpers/20241128-170626
base:   a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
patch link:    https://lore.kernel.org/r/9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount%40gmail.com
patch subject: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
config: i386-buildonly-randconfig-003-20241128 (https://download.01.org/0day-ci/archive/20241129/202411290140.7k2Z9JSi-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411290140.7k2Z9JSi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411290140.7k2Z9JSi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/accel/kionix-kx022a.c:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/accel/kionix-kx022a.c:507:2: error: call to undeclared function 'if_not_cond_guard'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |         ^
>> drivers/iio/accel/kionix-kx022a.c:507:47: error: expected ';' after expression
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |                                                      ^
         |                                                      ;
>> drivers/iio/accel/kionix-kx022a.c:507:20: error: use of undeclared identifier 'iio_claim_direct_try'
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |                           ^
   1 warning and 3 errors generated.


vim +/if_not_cond_guard +507 drivers/iio/accel/kionix-kx022a.c

   490	
   491	static int kx022a_write_raw(struct iio_dev *idev,
   492				    struct iio_chan_spec const *chan,
   493				    int val, int val2, long mask)
   494	{
   495		struct kx022a_data *data = iio_priv(idev);
   496		int ret, n;
   497	
   498		/*
   499		 * We should not allow changing scale or frequency when FIFO is running
   500		 * as it will mess the timestamp/scale for samples existing in the
   501		 * buffer. If this turns out to be an issue we can later change logic
   502		 * to internally flush the fifo before reconfiguring so the samples in
   503		 * fifo keep matching the freq/scale settings. (Such setup could cause
   504		 * issues if users trust the watermark to be reached within known
   505		 * time-limit).
   506		 */
 > 507		if_not_cond_guard(iio_claim_direct_try, idev)
   508			return -EBUSY;
   509	
   510		switch (mask) {
   511		case IIO_CHAN_INFO_SAMP_FREQ:
   512			n = ARRAY_SIZE(kx022a_accel_samp_freq_table);
   513	
   514			while (n--)
   515				if (val == kx022a_accel_samp_freq_table[n][0] &&
   516				    val2 == kx022a_accel_samp_freq_table[n][1])
   517					break;
   518			if (n < 0)
   519				return -EINVAL;
   520	
   521			scoped_guard(mutex, &data->mutex) {
   522				ret = kx022a_turn_on_off(data, false);
   523				if (ret)
   524					return ret;
   525	
   526				ret = regmap_update_bits(data->regmap,
   527							 data->chip_info->odcntl,
   528							 KX022A_MASK_ODR, n);
   529				data->odr_ns = kx022a_odrs[n];
   530				return kx022a_turn_on_off(data, true);
   531			}
   532		case IIO_CHAN_INFO_SCALE:
   533			n = data->chip_info->scale_table_size / 2;
   534	
   535			while (n-- > 0)
   536				if (val == data->chip_info->scale_table[n][0] &&
   537				    val2 == data->chip_info->scale_table[n][1])
   538					break;
   539			if (n < 0)
   540				return -EINVAL;
   541	
   542			scoped_guard(mutex, &data->mutex) {
   543				ret = kx022a_turn_on_off(data, false);
   544				if (ret)
   545					return ret;
   546	
   547				ret = regmap_update_bits(data->regmap,
   548							 data->chip_info->cntl,
   549							 KX022A_MASK_GSEL,
   550							 n << KX022A_GSEL_SHIFT);
   551				kx022a_turn_on_off(data, true);
   552	
   553				return ret;
   554			}
   555		default:
   556			break;
   557		}
   558	
   559		return -EINVAL;
   560	}
   561	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

