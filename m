Return-Path: <linux-iio+bounces-22703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0FB2576C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 01:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8705D7AC029
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D3F2FC87A;
	Wed, 13 Aug 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmVQa/9K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0611366;
	Wed, 13 Aug 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127303; cv=none; b=ii8iIBdHBI+QpqI//rAavsNPWFp/enlYWShOG1OdbzLgwTF1xAl+mvBMKoo8p6JXsAaUmcw+DwuJyAfrKyJWN7D3X5mdcbdksQLtsbM9z+zGdbW1cbQNzOTp1KUOVxXLVj0oH/YdUmLVKe2/taY6mqwQxRe3u7mlTJs+HFerkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127303; c=relaxed/simple;
	bh=3FUHzB5zFPjRpIGR9t/HnNbe+pc72m44Y8u/Tn0719M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVhHYiBFMxgUT6GRWGuHnfBrVl7LYGspGNrShza6RmKAUQGVlHR3eIqlFSIhofy+iKLK7nK/9eiyLbCbdw6nD8w9vNklsDiqi5Bi4sv3G2nds//FiKZ3QtewY+mrY/V2ADi5ncCXn32LlhtdljSWW6KdKrSRMge1IkhjcXbNQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmVQa/9K; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755127302; x=1786663302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3FUHzB5zFPjRpIGR9t/HnNbe+pc72m44Y8u/Tn0719M=;
  b=ZmVQa/9K1M/9szvnBXqvVWDL+Rnut3IRbxsbqkiNw9pw61islh4JCPXb
   7sEOoSpb4P8RGJeBULpBPaUwFH6SNq3NnJVdoy5dL/+BqUKrCzoJ+V+a/
   FNfP2KGMub9wFzlCO5xOoD5obvorW+vPowrejZAo5WagL4tHtQP6rbjIF
   9pZz2ZSp5qXWBV26hcArfjpg+a+toVZrUd/OH+RfA8/h/MCDSWSL3z268
   FYNUPagtyockwiHiwVOhENL82PQ9we6m+S3huxuxPnkbeY/BuhujPgFju
   /fCfJfG1cOQsMFd8KnmRrnh8JbIMSV4ipQEneEbCt9Ibgvmw2wKhExxSY
   g==;
X-CSE-ConnectionGUID: vK982s33RPiaJrImb2z4Fw==
X-CSE-MsgGUID: 1w4mavA3QXOe2zFfji+qzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57154934"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57154934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 16:21:41 -0700
X-CSE-ConnectionGUID: zqWI8wdARxiqbK0emdenWw==
X-CSE-MsgGUID: GmLq9DUqTWWYubE5nQx4Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166096675"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 13 Aug 2025 16:21:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umKml-000AOi-0m;
	Wed, 13 Aug 2025 23:21:35 +0000
Date: Thu, 14 Aug 2025 07:21:18 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jonath4nns@gmail.com
Subject: Re: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC
 Family
Message-ID: <202508140742.AhFMglnF-lkp@intel.com>
References: <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>

Hi Jonathan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0a686b9c4f847dc21346df8e56d5b119918fefef]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Santos/dt-bindings-iio-adc-ad7768-1-add-new-supported-parts/20250813-145315
base:   0a686b9c4f847dc21346df8e56d5b119918fefef
patch link:    https://lore.kernel.org/r/f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos%40analog.com
patch subject: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
config: hexagon-randconfig-002-20250814 (https://download.01.org/0day-ci/archive/20250814/202508140742.AhFMglnF-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140742.AhFMglnF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140742.AhFMglnF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: rational_best_approximation
   >>> referenced by ad7768-1.c:554 (drivers/iio/adc/ad7768-1.c:554)
   >>>               drivers/iio/adc/ad7768-1.o:(ad7768_configure_dig_fil) in archive vmlinux.a
   >>> referenced by ad7768-1.c:554 (drivers/iio/adc/ad7768-1.c:554)
   >>>               drivers/iio/adc/ad7768-1.o:(ad7768_configure_dig_fil) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

