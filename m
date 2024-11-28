Return-Path: <linux-iio+bounces-12787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5829DBBC0
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FDCB20485
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C871C07EE;
	Thu, 28 Nov 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BC7rmni5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112081BD9FF;
	Thu, 28 Nov 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814494; cv=none; b=rSeMa7qiRGXXMZdKTt1VIEGFcjdhKOiEjBT9LlJlK6FcYHCo+tDv3EtTN1+2aebt8RRcX60k8KOJqS5esBWni+J5RX8+NWPnUMC+aU9Ym5svvmvwCNgB7eQ0Oj5BcDa8aOVILzBkCcxywQhNNc0zCsjTDctdCeRW4T1TvgEbArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814494; c=relaxed/simple;
	bh=1ZD2besWwUxZjER27WGcmeYP9lCfnVzAZX9t8iALQ7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IomRmowd6UHVM23DVDzsqq76wJ1RgVm+l6t87DORGR+h7/aq7OSOQb2FtRAUzPhYFE81KS1pkJmWv0NFYYBeUkXvsHLzGbAp3RYQXK18cXD4bCJyFIt0bXWa6E8fWdVDa4ft9ZBplRgo+EPZMMwmJGSyuBbF01eeEb+nMY6TcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BC7rmni5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732814493; x=1764350493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ZD2besWwUxZjER27WGcmeYP9lCfnVzAZX9t8iALQ7c=;
  b=BC7rmni5a6GOq1N6iFGxfdXHBppcgqzp25NgJnY3M5heghIevALcL7Dd
   gwnypbsCC2wuvZAllFPxISKA5ivMQ0Qd0m/XgegwgnRb9Wrobf7ygFLB6
   8OK3tZH/4MtDwxZNoGU4AxDvPc0IJuP7twQaVAFk6Wi5CZ4OTkxXb31oM
   Vk+48oR+KaZZ470zMdxqqAx3cFU+A2XrOEFjDRPfK4GQ2BgFP4asyHqG6
   RuuYaz0e6c41tzxSZZ1YSHB9CpxG9MRBhlptkgwT87KzeFMhdXRdeTvt0
   NEQofUY+E/4rmloaTne+KN2CL5Qp3py7spq89v37oZ1EFKn9ZfDy8Gz02
   A==;
X-CSE-ConnectionGUID: VCRaLZlmSwWdbMlelMFMdg==
X-CSE-MsgGUID: VHbpu96wQwmA0wxqoQ5hbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="58462468"
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="58462468"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 09:21:33 -0800
X-CSE-ConnectionGUID: W0vd1o6lQneZpQxYbQgZmw==
X-CSE-MsgGUID: UC0+7HevSHyI5HYansTOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="96717194"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Nov 2024 09:21:30 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGiCl-0009rL-1K;
	Thu, 28 Nov 2024 17:21:27 +0000
Date: Fri, 29 Nov 2024 01:20:41 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
Message-ID: <202411290107.KXHPQXRf-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on a61ff7eac77e86de828fe28c4e42b8ae9ec2b195]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/iio-accel-kx022a-Use-cleanup-h-helpers/20241128-170626
base:   a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
patch link:    https://lore.kernel.org/r/9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount%40gmail.com
patch subject: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241129/202411290107.KXHPQXRf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411290107.KXHPQXRf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411290107.KXHPQXRf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/accel/kionix-kx022a.c: In function 'kx022a_write_raw':
   drivers/iio/accel/kionix-kx022a.c:507:9: error: implicit declaration of function 'if_not_cond_guard' [-Wimplicit-function-declaration]
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |         ^~~~~~~~~~~~~~~~~
   drivers/iio/accel/kionix-kx022a.c:507:27: error: 'iio_claim_direct_try' undeclared (first use in this function); did you mean 'class_iio_claim_direct_try_t'?
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |                           ^~~~~~~~~~~~~~~~~~~~
         |                           class_iio_claim_direct_try_t
   drivers/iio/accel/kionix-kx022a.c:507:27: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iio/accel/kionix-kx022a.c:507:54: error: expected ';' before 'return'
     507 |         if_not_cond_guard(iio_claim_direct_try, idev)
         |                                                      ^
         |                                                      ;
     508 |                 return -EBUSY;
         |                 ~~~~~~                                
   In file included from drivers/iio/accel/kionix-kx022a.c:8:
>> include/linux/cleanup.h:308:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
     308 |         for (CLASS(_name, scope)(args),                                 \
         |         ^~~
   drivers/iio/accel/kionix-kx022a.c:521:17: note: in expansion of macro 'scoped_guard'
     521 |                 scoped_guard(mutex, &data->mutex) {
         |                 ^~~~~~~~~~~~
   drivers/iio/accel/kionix-kx022a.c:532:9: note: here
     532 |         case IIO_CHAN_INFO_SCALE:
         |         ^~~~


vim +308 include/linux/cleanup.h

e4ab322fbaaaf8 Peter Zijlstra 2023-09-17  306  
54da6a0924311c Peter Zijlstra 2023-05-26  307  #define scoped_guard(_name, args...)					\
54da6a0924311c Peter Zijlstra 2023-05-26 @308  	for (CLASS(_name, scope)(args),					\
e4ab322fbaaaf8 Peter Zijlstra 2023-09-17  309  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
e4ab322fbaaaf8 Peter Zijlstra 2023-09-17  310  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

