Return-Path: <linux-iio+bounces-13083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE199E389E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 12:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C707BB3CFEC
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40A1B6D0F;
	Wed,  4 Dec 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/j31cxC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F21B6D0C;
	Wed,  4 Dec 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310894; cv=none; b=Vw2uuMvlA5jlkZSTK4PP4B+Ie45ZDCIl3gb6p1AtYQ4lMHHqFR3Lu0l2AC9SswZpSpaupAICTa2iBN6LJ6CS9kcleovfEhsv796mue0yPlggP0SmilqwGUSTrMUUFGh/zEqxa8mznMOc7AWIWm0pQtp1vff39RkuRxZsnQRApj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310894; c=relaxed/simple;
	bh=TRrjlDtNrJaiiiHFC3eFwvdwTNvVe78pKIUN5/g/PgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkcRo4Bwg1MERAXe3NxqZiH+FMLkNlPlqvGsnx1A+2nyJr5aIWCeupSo/kcR86QbtTGLefI87or/zBvMRZNUnVpufsbQKrCnCRRBzLz/fF710mqIqKOknUQMs5c2uMvcIrJsIGwr682dMhqNJI2fc3HxxvmACbg829UAtfT7ICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/j31cxC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733310893; x=1764846893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TRrjlDtNrJaiiiHFC3eFwvdwTNvVe78pKIUN5/g/PgE=;
  b=N/j31cxCejX55CNqOyjsPktO2qcv83+MdNv2YZGF3d/GyNxbGmF7sfNU
   5zqp8UKoniojmowa68YnF4yLIh2jZbJzEph94QueMpQR5oP8/ICdV4g6G
   CvNYEO80SnYoxJyS0BfyeN+5ClTXXFxOThGY1xl7VxVr0fbxFNSGDSPb7
   LsEiTQlmTVFNNlIRXsIHDmVdIdxOhNfVC0N95cnXJf4fyWv4oMw7WvKYa
   Wb2zqGZDXgGTImU5C3Bne0s/sWam/cb7i787MRCCJzDk2Ta/LR+durFkW
   FIgTvl6uQX8v4eNQRstmgQX7gIkj8Qnkdkd1Qs+KG/kdAls8bEXKO5ZmX
   w==;
X-CSE-ConnectionGUID: VoQMtktvS0GSZqnAs2DeJA==
X-CSE-MsgGUID: fZAleUxHSbCYH/RDN3wGNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58976277"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="58976277"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:14:52 -0800
X-CSE-ConnectionGUID: EOVvGmCfSKeJ4jho8ubKpw==
X-CSE-MsgGUID: A3qZavwTTySTGjj3PJBb7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93626968"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Dec 2024 03:14:50 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInKi-0002vh-20;
	Wed, 04 Dec 2024 11:14:22 +0000
Date: Wed, 4 Dec 2024 19:11:20 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/4] iio: afe: rescale: Re-use generic struct s32_fract
Message-ID: <202412041825.tYQkmq7d-lkp@intel.com>
References: <20241204013620.862943-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204013620.862943-4-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.13-rc1 next-20241203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-afe-rescale-Don-t-use-for-booleans/20241204-124353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241204013620.862943-4-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 3/4] iio: afe: rescale: Re-use generic struct s32_fract
config: arm64-randconfig-001 (https://download.01.org/0day-ci/archive/20241204/202412041825.tYQkmq7d-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041825.tYQkmq7d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041825.tYQkmq7d-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/test/iio-test-rescale.c: In function 'iio_rescale_test_scale':
>> drivers/iio/test/iio-test-rescale.c:655:16: error: 'struct rescale' has no member named 'numerator'
     655 |         rescale.numerator = t->numerator;
         |                ^
>> drivers/iio/test/iio-test-rescale.c:656:16: error: 'struct rescale' has no member named 'denominator'
     656 |         rescale.denominator = t->denominator;
         |                ^
   drivers/iio/test/iio-test-rescale.c: In function 'iio_rescale_test_offset':
   drivers/iio/test/iio-test-rescale.c:684:16: error: 'struct rescale' has no member named 'numerator'
     684 |         rescale.numerator = t->numerator;
         |                ^
   drivers/iio/test/iio-test-rescale.c:685:16: error: 'struct rescale' has no member named 'denominator'
     685 |         rescale.denominator = t->denominator;
         |                ^


vim +655 drivers/iio/test/iio-test-rescale.c

8e74a48d17d509b Liam Beguin 2022-02-12  645  
8e74a48d17d509b Liam Beguin 2022-02-12  646  static void iio_rescale_test_scale(struct kunit *test)
8e74a48d17d509b Liam Beguin 2022-02-12  647  {
8e74a48d17d509b Liam Beguin 2022-02-12  648  	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
8e74a48d17d509b Liam Beguin 2022-02-12  649  	char *buff = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
8e74a48d17d509b Liam Beguin 2022-02-12  650  	struct rescale rescale;
8e74a48d17d509b Liam Beguin 2022-02-12  651  	int values[2];
8e74a48d17d509b Liam Beguin 2022-02-12  652  	int rel_ppm;
8e74a48d17d509b Liam Beguin 2022-02-12  653  	int ret;
8e74a48d17d509b Liam Beguin 2022-02-12  654  
8e74a48d17d509b Liam Beguin 2022-02-12 @655  	rescale.numerator = t->numerator;
8e74a48d17d509b Liam Beguin 2022-02-12 @656  	rescale.denominator = t->denominator;
8e74a48d17d509b Liam Beguin 2022-02-12  657  	rescale.offset = t->offset;
8e74a48d17d509b Liam Beguin 2022-02-12  658  	values[0] = t->schan_val;
8e74a48d17d509b Liam Beguin 2022-02-12  659  	values[1] = t->schan_val2;
8e74a48d17d509b Liam Beguin 2022-02-12  660  
8e74a48d17d509b Liam Beguin 2022-02-12  661  	ret = rescale_process_scale(&rescale, t->schan_scale_type,
8e74a48d17d509b Liam Beguin 2022-02-12  662  				    &values[0], &values[1]);
8e74a48d17d509b Liam Beguin 2022-02-12  663  
8e74a48d17d509b Liam Beguin 2022-02-12  664  	ret = iio_format_value(buff, ret, 2, values);
8e74a48d17d509b Liam Beguin 2022-02-12  665  	KUNIT_EXPECT_EQ(test, (int)strlen(buff), ret);
8e74a48d17d509b Liam Beguin 2022-02-12  666  
8e74a48d17d509b Liam Beguin 2022-02-12  667  	rel_ppm = iio_test_relative_error_ppm(buff, t->expected);
8e74a48d17d509b Liam Beguin 2022-02-12  668  	KUNIT_EXPECT_GE_MSG(test, rel_ppm, 0, "failed to compute ppm\n");
8e74a48d17d509b Liam Beguin 2022-02-12  669  
8e74a48d17d509b Liam Beguin 2022-02-12  670  	KUNIT_EXPECT_EQ_MSG(test, rel_ppm, 0,
8e74a48d17d509b Liam Beguin 2022-02-12  671  			    "\t    real=%s"
8e74a48d17d509b Liam Beguin 2022-02-12  672  			    "\texpected=%s\n",
8e74a48d17d509b Liam Beguin 2022-02-12  673  			    buff, t->expected);
8e74a48d17d509b Liam Beguin 2022-02-12  674  }
8e74a48d17d509b Liam Beguin 2022-02-12  675  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

