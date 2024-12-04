Return-Path: <linux-iio+bounces-13084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89399E38DE
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 12:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C6A16619E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464C1B21BA;
	Wed,  4 Dec 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf6XkKmj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A91AC884;
	Wed,  4 Dec 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312032; cv=none; b=THqMcuV7Tz/SgpZStykgxBTgPaboKR7NKsyEgLQM7+vAvT/kBSZ6I0feQvp5K1w6EsiEWy1hUEfU1dagTmUEB3d003YIzgrtvS8ezlR7+HJd/B3aILJAitR+DOSrmAhBhBdUyHJe8x+smInOiCHc+GrQt6PvLsvLjofPGkS0Zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312032; c=relaxed/simple;
	bh=icNQ1hK/KEU+ydk3SKlmtjZgJ3jM4g14xAoPkqOL7KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4JdzWfy6Yci453d/QACMYbUn/dZM8qQGbMO38jTD88QfIBJDyrBU41AF6uTZNh3Q5/uzLTQVRNqNJ+e6kOfxzpKtwtwfqZ7dROeABb0EovxMF9UKfqJFhcnKdFtYVsF1rc1ec2DPGGZQvkj06vY3CijZu5qX+uE+l/1vPB0fNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf6XkKmj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733312030; x=1764848030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=icNQ1hK/KEU+ydk3SKlmtjZgJ3jM4g14xAoPkqOL7KQ=;
  b=Jf6XkKmjX+UtWZz64oqL9eQsq02ZVEgMztXCJKxtq/3SKiDKQdKFtA9t
   jNbiWl3KX0LP3RE4rChmZPeo+MFyy5ppfCYilh9nwmDj5PkJlWdFN+6Vj
   VGyAFIj9hwkebh2WA61aqjwbWhesXkuAbfXJ/z7UryRlCWgckU1FncEgk
   tux3kzFiOGCJT/+duMUt6YOauonUlI5MUcj6Sru6YE2Wu54d+K9myMu85
   TYR5Io26GSOwVE50Pvo69qA5i56vmbI2Pi/tDTteaBtsw3JGr2yL6B/xQ
   XwXDgyDxHxVtAVt7z/rn7Ks6+u0LjKjctcktjUKGj2Pwcm4T+3K4y0VXS
   Q==;
X-CSE-ConnectionGUID: /3x/V5POQKO59+qFpacYCA==
X-CSE-MsgGUID: K88dkSLESuKwlduDSpfkdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21155299"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="21155299"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:33:50 -0800
X-CSE-ConnectionGUID: q+vr65RRTaSzksH6y/BXFQ==
X-CSE-MsgGUID: TgHUJz4/SpCVjX0z0bEIKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98766291"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 04 Dec 2024 03:33:47 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIndZ-0002xZ-0a;
	Wed, 04 Dec 2024 11:33:45 +0000
Date: Wed, 4 Dec 2024 19:32:59 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/4] iio: afe: rescale: Re-use generic struct s32_fract
Message-ID: <202412041908.UaZf89I0-lkp@intel.com>
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
config: arm-randconfig-003 (https://download.01.org/0day-ci/archive/20241204/202412041908.UaZf89I0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041908.UaZf89I0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041908.UaZf89I0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/test/iio-test-rescale.c:655:10: error: no member named 'numerator' in 'struct rescale'
     655 |         rescale.numerator = t->numerator;
         |         ~~~~~~~ ^
>> drivers/iio/test/iio-test-rescale.c:656:10: error: no member named 'denominator' in 'struct rescale'
     656 |         rescale.denominator = t->denominator;
         |         ~~~~~~~ ^
   drivers/iio/test/iio-test-rescale.c:684:10: error: no member named 'numerator' in 'struct rescale'
     684 |         rescale.numerator = t->numerator;
         |         ~~~~~~~ ^
   drivers/iio/test/iio-test-rescale.c:685:10: error: no member named 'denominator' in 'struct rescale'
     685 |         rescale.denominator = t->denominator;
         |         ~~~~~~~ ^
   4 errors generated.


vim +655 drivers/iio/test/iio-test-rescale.c

8e74a48d17d509 Liam Beguin 2022-02-12  645  
8e74a48d17d509 Liam Beguin 2022-02-12  646  static void iio_rescale_test_scale(struct kunit *test)
8e74a48d17d509 Liam Beguin 2022-02-12  647  {
8e74a48d17d509 Liam Beguin 2022-02-12  648  	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
8e74a48d17d509 Liam Beguin 2022-02-12  649  	char *buff = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
8e74a48d17d509 Liam Beguin 2022-02-12  650  	struct rescale rescale;
8e74a48d17d509 Liam Beguin 2022-02-12  651  	int values[2];
8e74a48d17d509 Liam Beguin 2022-02-12  652  	int rel_ppm;
8e74a48d17d509 Liam Beguin 2022-02-12  653  	int ret;
8e74a48d17d509 Liam Beguin 2022-02-12  654  
8e74a48d17d509 Liam Beguin 2022-02-12 @655  	rescale.numerator = t->numerator;
8e74a48d17d509 Liam Beguin 2022-02-12 @656  	rescale.denominator = t->denominator;
8e74a48d17d509 Liam Beguin 2022-02-12  657  	rescale.offset = t->offset;
8e74a48d17d509 Liam Beguin 2022-02-12  658  	values[0] = t->schan_val;
8e74a48d17d509 Liam Beguin 2022-02-12  659  	values[1] = t->schan_val2;
8e74a48d17d509 Liam Beguin 2022-02-12  660  
8e74a48d17d509 Liam Beguin 2022-02-12  661  	ret = rescale_process_scale(&rescale, t->schan_scale_type,
8e74a48d17d509 Liam Beguin 2022-02-12  662  				    &values[0], &values[1]);
8e74a48d17d509 Liam Beguin 2022-02-12  663  
8e74a48d17d509 Liam Beguin 2022-02-12  664  	ret = iio_format_value(buff, ret, 2, values);
8e74a48d17d509 Liam Beguin 2022-02-12  665  	KUNIT_EXPECT_EQ(test, (int)strlen(buff), ret);
8e74a48d17d509 Liam Beguin 2022-02-12  666  
8e74a48d17d509 Liam Beguin 2022-02-12  667  	rel_ppm = iio_test_relative_error_ppm(buff, t->expected);
8e74a48d17d509 Liam Beguin 2022-02-12  668  	KUNIT_EXPECT_GE_MSG(test, rel_ppm, 0, "failed to compute ppm\n");
8e74a48d17d509 Liam Beguin 2022-02-12  669  
8e74a48d17d509 Liam Beguin 2022-02-12  670  	KUNIT_EXPECT_EQ_MSG(test, rel_ppm, 0,
8e74a48d17d509 Liam Beguin 2022-02-12  671  			    "\t    real=%s"
8e74a48d17d509 Liam Beguin 2022-02-12  672  			    "\texpected=%s\n",
8e74a48d17d509 Liam Beguin 2022-02-12  673  			    buff, t->expected);
8e74a48d17d509 Liam Beguin 2022-02-12  674  }
8e74a48d17d509 Liam Beguin 2022-02-12  675  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

