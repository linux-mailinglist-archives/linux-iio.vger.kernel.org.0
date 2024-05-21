Return-Path: <linux-iio+bounces-5155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9E8CAB76
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721E4282467
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635F06BB50;
	Tue, 21 May 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NO2Ffq6w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303154777;
	Tue, 21 May 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285978; cv=none; b=HI4f9hfEg5LQklbr4njw6eZn0c850/LSh1cT03vuv67hNbxRNISvd2fRdnUTEVUm91Tvvlwbu7S1xJiHs+x2v4zQZuKTm6UogKUQr44BQhx68PiEl0TuPvpHxYoXxyyQ4P/23IMq9JGmXl2R+1qYiSrvHt1CI/RogDP3+Cw9UgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285978; c=relaxed/simple;
	bh=ZIgwGNN0rag8Erxom7NQ1rwWDS/S6QnWCK9t2Ggg/rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItMWrati0s9jC1UZ3UIzLgwymhvFSKAR0izolldA4IE2IiC55VE9wwt8K51/+Nw1i2ouLTNzpT2XCGF5uIdNV1vdE5GR41yRxLOD7ichheZMaYYgiBCYNPqXFGot7NBlN0am1E+VXpzZf6V9QretKGjQ1m48AKMauNIddaC/yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NO2Ffq6w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716285977; x=1747821977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZIgwGNN0rag8Erxom7NQ1rwWDS/S6QnWCK9t2Ggg/rU=;
  b=NO2Ffq6wLwJZmbDwQ3ygWfZyQgj7qEQoAG/Vq6v4QDPcvSiXqoaI6zF+
   NC6p5alSMfsXurA83XLnG6QfV3Pj6/uJSWKH5kViewns3cqD2AXd63n6j
   AUxOs+Q5ps7NaccvxSXUFGLQMNSl/UWSXXuupidIzE/QEYGYSjfmYhMYN
   bOFxaOoTWvRKr5B0ZXjfBL+S7k53VlQcTYYal5+S3uyv/JP+uQkfvwgV1
   2W+ApNk26OFNlaCsipD15Dk0VOci+rhP1gPNhWwlmKYZnY/NNGgds5rXO
   d4xH+rBWbZly24a48AD8UILGQYvd1nAU22m29OGZtz+sFjaXT/567wy8+
   Q==;
X-CSE-ConnectionGUID: e/fVMlcnQh2ok9JsQ7R8Nw==
X-CSE-MsgGUID: xZrSexaLTZ+X/FoY6NF3Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29986467"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="29986467"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 03:06:16 -0700
X-CSE-ConnectionGUID: OwbFUO7GQEe57k3Fu7tVCg==
X-CSE-MsgGUID: 5Mf2tTLbRqy2h9Kf0tw2xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="37450356"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 21 May 2024 03:06:13 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9MNm-0006GO-2z;
	Tue, 21 May 2024 10:06:10 +0000
Date: Tue, 21 May 2024 18:05:29 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	swboyd@chromium.org, nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <202405211730.Ft1IxvLC-lkp@intel.com>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.9 next-20240521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240515-083021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: hexagon-randconfig-001-20240521 (https://download.01.org/0day-ci/archive/20240521/202405211730.Ft1IxvLC-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fa9b1be45088dce1e4b602d451f118128b94237b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240521/202405211730.Ft1IxvLC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405211730.Ft1IxvLC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __hexagon_udivdi3
   >>> referenced by hx9031as.c
   >>>               drivers/iio/proximity/hx9031as.o:(hx9031as_write_raw) in archive vmlinux.a
   >>> referenced by hx9031as.c
   >>>               drivers/iio/proximity/hx9031as.o:(hx9031as_write_raw) in archive vmlinux.a
   >>> did you mean: __hexagon_udivsi3
   >>> defined in: vmlinux.a(arch/hexagon/lib/udivsi3.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

