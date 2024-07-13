Return-Path: <linux-iio+bounces-7586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7BF930529
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D24E1C21154
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD661FC7;
	Sat, 13 Jul 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npxuPVds"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6E45008;
	Sat, 13 Jul 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866861; cv=none; b=WCaVltj9/dbZkwidQrJgt7d8TmjSK7gqtIaN4ysfrHtOJXIY5l3R2UYOE0nbIE/f6vBTQ9VIkGJgzH27CsLyRy7gkaKw8t0TAwiLppq3wNR0MPfoImWql5MdFCYK1u5TarP9Me5S4zqxwKLo/YckJTmUKAuqwQ2wDbxcLyMzEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866861; c=relaxed/simple;
	bh=wHL89j46c+8SyZizzkw+zjxBFQ6oTMVQToilyEIMIAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhtEg3sL2uNEiF9t9Lu51NIu7rhGdBKrRFZQYBpmE3hcZ5lFv3tnUdbSibkjrbf/riCVSmDJCnlw82W5xnbyaujcot3nM4SvrgymcbR/ZcNGGJwJ7b1VVCbD7hqPTxQF8prcXinKnOnulYDadzSIRMSwXh0ze+LuTd9WScDsS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npxuPVds; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720866859; x=1752402859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHL89j46c+8SyZizzkw+zjxBFQ6oTMVQToilyEIMIAc=;
  b=npxuPVdsEr32eKSRHggkvHvKum/wnOpvIIfX1q5GwFOYmtrvmBftzO1o
   lgyQLeSJu8ddmW0tDgKbfxRBAiqTuPvAKqDr+6+BGVBkuxtvKme56SL8Q
   vLynCR5AEEDX+xo/GGeV1juYF4shBDg53+AGUqyipTCxadD8cX34BVa6N
   0xbm1emKNFNkpCcO3d8tyO6u5MnJlol48pYBiv2ssQl+4sk6jou7y8WN4
   CvPUqSV05ZdS0m09FKQ8PDeeOQMQxkT9IKggKNeTjmzxXx/c3SYrCCKn+
   TFkrDWFur/FOLm0gAhbai/uMb5zvyHm5cc+gbssxYkavn+4dpNs9Yjz0P
   g==;
X-CSE-ConnectionGUID: VLqKP7QdTdyIDffQZJwsLw==
X-CSE-MsgGUID: DPef+2gwS8KAOmnlCkEPXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18178397"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="18178397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 03:34:18 -0700
X-CSE-ConnectionGUID: GuJfLMxMTkmRcZ2zqyZASg==
X-CSE-MsgGUID: AEDThg0lQCm69IC7O2a+LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="49231775"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Jul 2024 03:34:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSa4z-000byf-1V;
	Sat, 13 Jul 2024 10:34:13 +0000
Date: Sat, 13 Jul 2024 18:33:22 +0800
From: kernel test robot <lkp@intel.com>
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	waqar.hameed@axis.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, wangshuaijie@awinic.com,
	liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Message-ID: <202407131813.fFyF06Pu-lkp@intel.com>
References: <20240712113200.2468249-3-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712113200.2468249-3-wangshuaijie@awinic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 43db1e03c086ed20cc75808d3f45e780ec4ca26e]

url:    https://github.com/intel-lab-lkp/linux/commits/wangshuaijie-awinic-com/dt-bindings-iio-Add-YAML-to-Awinic-proximity-sensor/20240712-194024
base:   43db1e03c086ed20cc75808d3f45e780ec4ca26e
patch link:    https://lore.kernel.org/r/20240712113200.2468249-3-wangshuaijie%40awinic.com
patch subject: [PATCH V3 2/2] Add support for Awinic proximity sensor
config: powerpc-randconfig-r132-20240713 (https://download.01.org/0day-ci/archive/20240713/202407131813.fFyF06Pu-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20240713/202407131813.fFyF06Pu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131813.fFyF06Pu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/proximity/aw9610x.c:1056:22: sparse: sparse: symbol 'g_aw9610x_awrw' was not declared. Should it be static?

vim +/g_aw9610x_awrw +1056 drivers/iio/proximity/aw9610x.c

  1055	
> 1056	struct aw_sar_awrw_t g_aw9610x_awrw = {
  1057		.p_set_awrw_node_fn = aw9610x_awrw_set,
  1058		.p_get_awrw_node_fn = aw9610x_awrw_get,
  1059	};
  1060	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

