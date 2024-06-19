Return-Path: <linux-iio+bounces-6543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F3590E1E6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 05:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5098282F62
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 03:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF955885;
	Wed, 19 Jun 2024 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzJBSkQs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85B1DFCB;
	Wed, 19 Jun 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718767004; cv=none; b=FPcmmEhK6m+e1tGMEk/lix6u1IUCsSM9tP8d/8+6l15drpx+ZjKio0CT/JaiHVqHDCqRqoFa13UXc0HtNFx99y8SWUr/HxT1odfLj5y0iBNVzG2Oy6xgbE7ybdstz14AQmHuM2gxNwK5cq1Z5lU/t7sRftHdjyRRwQ7PKSG53YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718767004; c=relaxed/simple;
	bh=7tNztevkaavreFJV4rcNE+ypDdZDtO+Kfjq+mux+/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/C+ZCz24pgNuD477MAF7n5DuXF73V4tcggflEi5NThofKPBKp4e/bW6XLwlDEmQRLls4WQea7O/UAin9QkxrLe67rz7BlnwbW1g/MTYCRvv74/xwZX9nIv0P1whg2Ovk6E2s7dgtgKe3j/0QEodAVmQ6R7d1l0a9Iow4Su8d+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzJBSkQs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718767003; x=1750303003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7tNztevkaavreFJV4rcNE+ypDdZDtO+Kfjq+mux+/GI=;
  b=dzJBSkQsVOiMXFP4MAeL84xMiQWCKbjGeTjYaF6U7aqWX5muNV878vIg
   F6A0FPC3Wwg4gGyp8jqGhiqFkDhvR6F347DHs3+yW21ImwufEWIvexfa/
   v+LIjlzxpCPBn2SXGt6gdHrvLlW1qEJjXbVgcarstaArMc2RK+FoZAV6v
   mitNLcye1Mib2cHqCP13Xmmo7EG1zpHb7IGX3wPM0qmPM+H7uDJ5KPqYx
   1zYZEDducn6p6L3NTUYXWkhkSTFO0gcen6k9IQNNHbhGrWGcfp9TApJhm
   IC0Gwhy+pfWGkhpWFxEOiXpAKJap8QYwmXKTv6RYpbn6phZGyB7uPU+8+
   A==;
X-CSE-ConnectionGUID: nVR4zDwHTaiRlkdCLCWQfg==
X-CSE-MsgGUID: geD0UplfTiSQKeGVzrJv2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26363845"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="26363845"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 20:16:42 -0700
X-CSE-ConnectionGUID: VNwv6KUmRV291ct3PKIUNA==
X-CSE-MsgGUID: pjj5/MnPTyikLcMM9WZraQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="46893908"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2024 20:16:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJloK-0006Da-1B;
	Wed, 19 Jun 2024 03:16:36 +0000
Date: Wed, 19 Jun 2024 11:15:55 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume Stols <gstols@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org, Guillaume Stols <gstols@baylibre.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 7/9] iio: adc: ad7606: switch mutexes to scoped_guard
Message-ID: <202406191142.rs8moLqC-lkp@intel.com>
References: <20240618-cleanup-ad7606-v1-7-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-cleanup-ad7606-v1-7-f1854d5c779d@baylibre.com>

Hi Guillaume,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 07d4d0bb4a8ddcc463ed599b22f510d5926c2495]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-Stols/dt-bindings-iio-adc-adi-ad7606-add-missing-datasheet-link/20240618-223010
base:   07d4d0bb4a8ddcc463ed599b22f510d5926c2495
patch link:    https://lore.kernel.org/r/20240618-cleanup-ad7606-v1-7-f1854d5c779d%40baylibre.com
patch subject: [PATCH 7/9] iio: adc: ad7606: switch mutexes to scoped_guard
config: x86_64-randconfig-101-20240619 (https://download.01.org/0day-ci/archive/20240619/202406191142.rs8moLqC-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191142.rs8moLqC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191142.rs8moLqC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7606.o: warning: objtool: ad7606_reg_access+0x5a: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

