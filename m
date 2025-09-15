Return-Path: <linux-iio+bounces-24118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 656E9B58561
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 21:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9326C7AECD0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBBF280335;
	Mon, 15 Sep 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq5XpbLa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE7320F;
	Mon, 15 Sep 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964981; cv=none; b=TBoJDWqlR7A9p7nDdZtmfuigksJpoyThGK4gADYYGtt9p+JNgHhy86LVJLvw0UJSMbsXqylJVQ60+gRT3cuGykec/RV650WZE8Wq4P0r8B+6nX9gTOX/NvdGDEI3NNlqqsvd07NIjXRdMGlzrRKArZrloOch7TwfLhPUnITF/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964981; c=relaxed/simple;
	bh=xIiCA6XEsrWkWIw6mHGpGZiKaHps/gNNAYLbHZYqqj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8Pt4ZhNw/J0KFO5I+xQjMbYTEMLWcCSCMCyUIn2m6aUTBBV7PiX0p1XHksoR661L7isg+KaH/9/3gXF6Ije7CGkSmxqlSGpHPDu4PYXT9I92Cyo6lht4CRob7PnXFcQPr8oy6noowrsoDiiwar4nJuDKRcmISpskWmxVpIEVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq5XpbLa; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757964979; x=1789500979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xIiCA6XEsrWkWIw6mHGpGZiKaHps/gNNAYLbHZYqqj8=;
  b=Tq5XpbLaNHBbKlScR4AuNz3HZvfHWQfNBqmF1fXKkaWy5cI1Xk06QK9j
   BxoDNx6upziijcNr/AZ6skLcDml0tqsOxrogBM8K3K2vFqxx2+TMG/lR0
   +ZMdCF+TCXFVyGzesPIyaWW5tRa+gs5Rfa2TOetqEKeT1GFkiciY6Xqfm
   DqnZZHq6RYX640wB6ats7begSTBnf/1KIqXrR1AXrf9CUT9UXBrJTQ8wr
   5P6J+E2czrl3JgcRZl3k60viVn07kHnhe/QPvR8dhKah4QO9MYcD40m8v
   bbjlK71sbxSN5jK+L3ChWSZ9rS5oHYIsuQmTfvrcB7uyLPpos8gFYSCgD
   Q==;
X-CSE-ConnectionGUID: UxHDi4ccQQSeKZ1QAlywpw==
X-CSE-MsgGUID: E86gYZ0ARMe8EWkEq2/b6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="82827217"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="82827217"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 12:36:18 -0700
X-CSE-ConnectionGUID: Y8hQESkPS4qErw9rZtB5/g==
X-CSE-MsgGUID: ite+/TU1Qyacu+j/+yt5kA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2025 12:36:15 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyEzl-0000cl-0J;
	Mon, 15 Sep 2025 19:36:13 +0000
Date: Tue, 16 Sep 2025 03:36:02 +0800
From: kernel test robot <lkp@intel.com>
To: Lakshay Piplani <lakshay.piplani@nxp.com>, wbg@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: Re: [PATCH 2/2] counter: nxp-pcf85363-stopwatch: Add driver for NXP
 PCF85263/PCF85363 stopwatch
Message-ID: <202509160317.ig0aBXeu-lkp@intel.com>
References: <20250915071415.1956219-2-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071415.1956219-2-lakshay.piplani@nxp.com>

Hi Lakshay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.17-rc6 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lakshay-Piplani/counter-nxp-pcf85363-stopwatch-Add-driver-for-NXP-PCF85263-PCF85363-stopwatch/20250915-152227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250915071415.1956219-2-lakshay.piplani%40nxp.com
patch subject: [PATCH 2/2] counter: nxp-pcf85363-stopwatch: Add driver for NXP PCF85263/PCF85363 stopwatch
config: i386-randconfig-141-20250916 (https://download.01.org/0day-ci/archive/20250916/202509160317.ig0aBXeu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509160317.ig0aBXeu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509160317.ig0aBXeu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/counter/nxp-pcf85363-stopwatch.c:375:34: warning: unused variable 'dev_ids' [-Wunused-const-variable]
     375 | static const struct of_device_id dev_ids[] = {
         |                                  ^~~~~~~
   1 warning generated.


vim +/dev_ids +375 drivers/counter/nxp-pcf85363-stopwatch.c

   374	
 > 375	static const struct of_device_id dev_ids[] = {
   376		{ .compatible = "nxp,pcf85263atl", .data = &pcf_85263_config },
   377		{ .compatible = "nxp,pcf85363atl", .data = &pcf_85363_config },
   378		{ }
   379	};
   380	MODULE_DEVICE_TABLE(of, dev_ids);
   381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

