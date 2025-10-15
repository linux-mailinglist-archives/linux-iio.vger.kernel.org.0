Return-Path: <linux-iio+bounces-25082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0BEBDCA34
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 07:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB973E6B2A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 05:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE43002C8;
	Wed, 15 Oct 2025 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bovpp8nU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E5145B3F;
	Wed, 15 Oct 2025 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507227; cv=none; b=hGSbtKuzhCKdwmsUPBLhnT15DAM/PPxUwDRcQ2/GGP1+x2grkxoxowxhk0PStrFgVgMAOA3jEd32zmRJqKvhBwSH94xG1UcLgvPmkhMPGnr2xpU8q+PP+N6pDhW+2xgO0/XV0BqSGYqS1mtD+Ia3mbFH3IMJ0NRClALGvH1RzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507227; c=relaxed/simple;
	bh=xbXk+okfI7R80kMOmsrYfUSCZu5KU1YThXHCJwmOhKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZl0HPbE9jvDqiKttmc2fcGa1KLOcCju81oHg2pqsgcdgQL2q4KxEbMUHw5DXgM5UluxygQgocKLfDlLBCh2Y+Qf9HO7fF73Wtezo+aFa3fTvMMEzVDiN+bZCIKwKZElYX6tUpx+Xy2+NuoLlkYTa1okqh2FPiIqMhgJgxMMtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bovpp8nU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760507226; x=1792043226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xbXk+okfI7R80kMOmsrYfUSCZu5KU1YThXHCJwmOhKI=;
  b=bovpp8nUjd81RxCrh4kSZObNu0eivNOk4rrC/buqBPlXP8U+VWdHbYsj
   kVCtRsKoJyWuGERRuIKe6OeMlGIjVKlXhMFltT4EV36lYUFRNFD3yj5KW
   GEIR3nZGJxWIxqI1VXXvdFvyZTa4G46rfB1DiVMrdVlFpDL+lbWbkEFPC
   sdcDz06zuJrH2Fxeuqoimw8wKEKyaMg9VsTm1h9hOxeboDORjBnnxt1sn
   WIg/Y9Az/sTvmhZuEW8cF+gbpsJaQnOw+p4Pl7UhMEVAHyYxG1GvM8rQG
   iJvN5AZoDgoBADpAySn6XN95jQM+xI7SlJJ9rLttfKPceNri230kumR36
   w==;
X-CSE-ConnectionGUID: NZWQwXu8Tfe540ozZ+9qmQ==
X-CSE-MsgGUID: funl+HhIQmCaMpkVJegd3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50238367"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50238367"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:47:05 -0700
X-CSE-ConnectionGUID: 7UmYTXd9SPScFqSXOmbvJA==
X-CSE-MsgGUID: /nb92FxfRuWjTD0h7VAqhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="187166284"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 14 Oct 2025 22:47:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8uLg-0003Ux-01;
	Wed, 15 Oct 2025 05:46:57 +0000
Date: Wed, 15 Oct 2025 13:46:34 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: test: fixed-point: new kunit test
Message-ID: <202510151318.gmNqcrgt-lkp@intel.com>
References: <20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on a9682f53c2d1678b93a123cdaa260e955430bc5c]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-test-fixed-point-new-kunit-test/20251014-053648
base:   a9682f53c2d1678b93a123cdaa260e955430bc5c
patch link:    https://lore.kernel.org/r/20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6%40baylibre.com
patch subject: [PATCH] iio: test: fixed-point: new kunit test
config: i386-buildonly-randconfig-004-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151318.gmNqcrgt-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151318.gmNqcrgt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151318.gmNqcrgt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/test/iio-test-fixed-point.c:52:16: error: initializing 'struct kunit_case *' with an expression of type 'const struct kunit_case[2]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
      52 |         .test_cases = iio_fixed_point_test_cases,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +52 drivers/iio/test/iio-test-fixed-point.c

    49	
    50	static struct kunit_suite iio_fixed_point_test_suite = {
    51		.name = "iio-fixed-point",
  > 52		.test_cases = iio_fixed_point_test_cases,
    53	};
    54	kunit_test_suite(iio_fixed_point_test_suite);
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

