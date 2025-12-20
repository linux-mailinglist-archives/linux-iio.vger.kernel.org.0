Return-Path: <linux-iio+bounces-27245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B84ECD262E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B3C1301A1F4
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 03:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765992D3ECA;
	Sat, 20 Dec 2025 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTBWk1sL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E32BF3DF;
	Sat, 20 Dec 2025 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766201381; cv=none; b=ELq1tdxle1SO3sw6mpRh+gqUwv+uTRbHZETNkB5GO0JVHpMJlC6avuzu0GbJ25ZyaEGJHFLf3C+ApfrpxmpMFpBz6DEKHgmiDucPkGCG+EHXoABxGs9DDFfZDHL3vJDYHEs1RgCykA0xe0pzWLwOVJwtLX3+DnSc/Z0szXwtYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766201381; c=relaxed/simple;
	bh=dHJPsoiZM2Pt/LO2/t7tfW6iX8YWiA+lglnGn2p7WUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir3jHP19yv6aO5qQuvnwe9NwvPf++ccO9aNnQQ9QxdZJQStKRqBklrkhvSt5/je1Jq27jDUyOeLArvJbiCFNjoMNMsvR4fj26kcxPC77i4vXAi9WnrF59ARdLbsLc8zPDVDTGyG3OwmhYKPuxMGcJphW8SwhOA4rpXaTs16qqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTBWk1sL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766201380; x=1797737380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dHJPsoiZM2Pt/LO2/t7tfW6iX8YWiA+lglnGn2p7WUA=;
  b=bTBWk1sLPXacj++tlTS3VUJaFgz5uGl9jVzbtMcgMlXuyBXvOGa50M0f
   Diz+h75EhaihLEehSRUJqpxOkflZSIfMpCdHeEJFM31tg2NpFtYvtmB5g
   4pW6yK84duM7Oj65fUu9/aqkB9p0Rk5H01HI3TH3PXpT8nA4zfsYwFHkE
   19gVev5TXzZ01kSYLw11eXiE8HGEPWJ9IXc+iM+Y8+vEfIbpm5gDAOzJ8
   LXVvQ01Ex2wr4EcZIo+wTXxLnlG+cDClZA08JxEINB6PUxuXLE3vDdabq
   aiE8a9ZH2UqWg5XCOCD26q3SV1M8thERndV0Hz14TqHNc9i5ulofKHqfL
   w==;
X-CSE-ConnectionGUID: R+0KNXyjTm2JSlt3127rcQ==
X-CSE-MsgGUID: /J2jUiB2TGOitYj69rcqTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78876317"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="78876317"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 19:29:39 -0800
X-CSE-ConnectionGUID: us1GrXXXQlOBIDNvR1VgMQ==
X-CSE-MsgGUID: doZUs0N3T4aTJaxl17UW0Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Dec 2025 19:29:37 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWnew-000000004IX-2Tl8;
	Sat, 20 Dec 2025 03:29:34 +0000
Date: Sat, 20 Dec 2025 11:28:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH 1/2] iio: adc: ad9467: include two's complement in
 default mode
Message-ID: <202512201109.STBoyjad-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512201109.STBoyjad-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512201109.STBoyjad-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512201109.STBoyjad-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad9467.c: In function 'ad9647_calibrate_prepare':
>> drivers/iio/adc/ad9467.c:686:17: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     686 |                 FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
         |                 ^~~~~~~~~~


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

