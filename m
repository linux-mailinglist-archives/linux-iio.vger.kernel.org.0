Return-Path: <linux-iio+bounces-25079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8296BDC541
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 05:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5A824ED18D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 03:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614CC28850C;
	Wed, 15 Oct 2025 03:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJs4SNlu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDA2882CF;
	Wed, 15 Oct 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498538; cv=none; b=WhD7D1eOYSAYh7gjZEJ/5fAn9nQo7WJdlldD4FRorXfOMREDlap0jJ7NMYO8VxrmbQ4EXTBm/UPfYLp9VxCBZ+BkE3aukgyU+UKsP1DIrS040X3Q2OnFrbtYZeBJwZEYv2HlvW8EimKNdULI+rfv+LCUf5ruF4pgg2rdRHFCo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498538; c=relaxed/simple;
	bh=CyerrAKbJbPcJwqNpPFbrCr4No6M3gsoVL1gByZEjAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQD0oWftqIUwaoazx83dniwONVRCODK301y//PggRTqJVfEyhQfS37Mf5M7BYsWw4GdMG0kLKXS+09PPl86+6u8s1DvTYVYnC9LTapd/PwetXDPHmy5JHl9a0nLRFgB2BfGJ6odSKzB3N8TghqT1cJ+4HaBL4GCzAOB3avMA7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJs4SNlu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760498536; x=1792034536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CyerrAKbJbPcJwqNpPFbrCr4No6M3gsoVL1gByZEjAw=;
  b=QJs4SNluhPFIYvbxk22buPkjOX1mxnmoAmCsIIcSKdgaWUsRutUIwXz4
   bUK8nkWXToVQv41Z1i4/EDVLd/BO8LxBTJcZiRsZJFQaqcIy0tTprNra6
   uxEXRg313XfH0oEO3+bAmKKSW1w9yFY/Xt1rErYKIZEs1TMrD5CLB2UQp
   chCe4KnslcDerIDll3OTP2zXhT0wASDcwxSw5BPHuxmGY4yDING5Dq7Yh
   +pE07E334wOT6iaKLuLJFCGlp2tkN68Gyqc5wD1WG88Q/UXGeIBwV1XTR
   9zQDmLEOo7M0mMmSf0Fyk1VUMCtHxbuVJiGcPVPgdYQQa+aET26GkpM8O
   A==;
X-CSE-ConnectionGUID: l2e4zlzyRHq2aRVSRvNr0g==
X-CSE-MsgGUID: 3p4btwsETHK8U204z7z9yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62702946"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62702946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 20:22:15 -0700
X-CSE-ConnectionGUID: RTaeHBOmQlK9Ezi5OxtFIg==
X-CSE-MsgGUID: fzvbkfvhSom+Iht11GYi8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181267516"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 14 Oct 2025 20:22:11 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8s5B-0003P9-0T;
	Wed, 15 Oct 2025 03:21:51 +0000
Date: Wed, 15 Oct 2025 11:21:26 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: test: fixed-point: new kunit test
Message-ID: <202510151125.QEa3kUJR-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on a9682f53c2d1678b93a123cdaa260e955430bc5c]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-test-fixed-point-new-kunit-test/20251014-053648
base:   a9682f53c2d1678b93a123cdaa260e955430bc5c
patch link:    https://lore.kernel.org/r/20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6%40baylibre.com
patch subject: [PATCH] iio: test: fixed-point: new kunit test
config: i386-buildonly-randconfig-001-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151125.QEa3kUJR-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151125.QEa3kUJR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151125.QEa3kUJR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/test/iio-test-fixed-point.c:52:23: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      52 |         .test_cases = iio_fixed_point_test_cases,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/const +52 drivers/iio/test/iio-test-fixed-point.c

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

