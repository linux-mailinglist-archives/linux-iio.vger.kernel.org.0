Return-Path: <linux-iio+bounces-12789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D229DBBFC
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 18:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098D1B212C9
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F41BE238;
	Thu, 28 Nov 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIYDLruT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58351BD9D3;
	Thu, 28 Nov 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732816387; cv=none; b=q5SHKLv00tF6xMEW6zT2M7O3h/mdbz8M5gL0HcMBcICXU//hZ3J3OE6gn/gm+xRUD0j+5hnHThvyKvmIaEv3BAC4ofFkldrdRKhrspUzUtnb5xLh8niPHzcVewfzlqNE8gDYSRRqiIgpC+zh9R9Odc7cB7ZXCpmjOzIVvhMdzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732816387; c=relaxed/simple;
	bh=vxW7Z5afkbZb5LSyPQi39qpihdzP1HhdzvIhYuY98eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0MPZrXtSIuL8npUHrxh4lRaX3Oi2UUewbeCVTQp1DtfAlahPiqifBUH6Fc/v/FMsTKzQvkmwAWo15J3QflS7a3s69uHnrtboBg7DJ4967ZPRBRdokaDuQzjeD9l1e9ZxD9Rk0KYAM8uu5UZw6Dn0N+7xugPripaXiSAtVYvQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIYDLruT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732816385; x=1764352385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vxW7Z5afkbZb5LSyPQi39qpihdzP1HhdzvIhYuY98eQ=;
  b=FIYDLruT76QSCNt8C3+1vRcUJQMxbyQepjP9+7r0Z3Hxhjq35vBealeG
   TIlL9aEY3BZeRdctVsk/OFkGIABPf+XZd0TBjgo/R802VIjujcjZjVTB1
   9Uv09Mk8+lzDffXMMTWb8kcJXQ74UiztOqN0IdHik/fcY0XMSlByZ46JX
   JA2tkw+lIUov4AkPj6yU7VjAwjmRXp+a14SNj9iFv9jMHbYKyFYBKQWnd
   esTujoqaaPK4rLiNqEfm1bwPUckbQgVswQ+cZVO57ki6SkQU+4u+iN1NV
   rGcziGegqwbDRIwJoPsQbXLGo8g/7FvrnaBmN9NXl6NTJL2zu0pAhAYr9
   A==;
X-CSE-ConnectionGUID: Sa/ksreVRi+zna0ce852kw==
X-CSE-MsgGUID: darzEyw8T3e9A8myh/gLSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33000481"
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="33000481"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 09:53:04 -0800
X-CSE-ConnectionGUID: nySdZo6WRg6VTu+9N5FJFg==
X-CSE-MsgGUID: I4NFisygTFa8SyiNpH1d0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="92474790"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Nov 2024 09:53:02 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGihH-0009t5-1H;
	Thu, 28 Nov 2024 17:52:59 +0000
Date: Fri, 29 Nov 2024 01:52:02 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
Message-ID: <202411290148.Jdoj8IqZ-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-004-20241128 (https://download.01.org/0day-ci/archive/20241129/202411290148.Jdoj8IqZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411290148.Jdoj8IqZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411290148.Jdoj8IqZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/accel/kionix-kx022a.c: In function 'kx022a_write_raw':
>> drivers/iio/accel/kionix-kx022a.c:507:9: error: implicit declaration of function 'if_not_cond_guard' [-Werror=implicit-function-declaration]
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |         ^~~~~~~~~~~~~~~~~
>> drivers/iio/accel/kionix-kx022a.c:507:27: error: 'iio_claim_direct_try' undeclared (first use in this function); did you mean 'class_iio_claim_direct_try_t'?
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |                           ^~~~~~~~~~~~~~~~~~~~
         |                           class_iio_claim_direct_try_t
   drivers/iio/accel/kionix-kx022a.c:507:27: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iio/accel/kionix-kx022a.c:507:54: error: expected ';' before 'return'
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |                                                      ^
         |                                                      ;
     508 |                 return -EBUSY;
         |                 ~~~~~~                                
   In file included from drivers/iio/accel/kionix-kx022a.c:8:
   include/linux/cleanup.h:308:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
     308 |         for (CLASS(_name, scope)(args),                                 \
         |         ^~~
   drivers/iio/accel/kionix-kx022a.c:521:17: note: in expansion of macro 'scoped_guard'
     521 |                 scoped_guard(mutex, &data->mutex) {
         |                 ^~~~~~~~~~~~
   drivers/iio/accel/kionix-kx022a.c:532:9: note: here
     532 |         case IIO_CHAN_INFO_SCALE:
         |         ^~~~
   cc1: some warnings being treated as errors


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

