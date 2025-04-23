Return-Path: <linux-iio+bounces-18553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752FCA98010
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 09:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336993BF065
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F61C5490;
	Wed, 23 Apr 2025 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWj7Zxbn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4F1E1E1E;
	Wed, 23 Apr 2025 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392017; cv=none; b=B/V4WWWllgj9F3e7XCQ0of5JlHfFg6iFiajR/mM1r48lN5Xe4/Eh/PgeUp9ChXV1NTSwUBP7M4tFtCyv0DlypKAlYXOt0BZ0B7PLuyTUx+6nY7mBFOnrJrYUxDY1BhwkpsmIucy1xrRVkLplYWFwXi69xv1Bj1pELOR2F+OHoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392017; c=relaxed/simple;
	bh=xt0DA3GstpCfr74NeBEXDfg1bNB8goQaSwLushyxukA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEkDYxzYJZ+FiRqnSgxrWNt+DSEfOVwhRgKtGfgeCrlfdWrnRz3OOLemy7heTrX+VClUbSd3cAm9td+T3p4quNmmxQEQd1MGV20VBTEbU4pLOfNQHzyfhsJZ1K7TMR4Rg0AkxH4o98Gzu3oljYkya5K6BhtMpC0+z28TeRNqX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWj7Zxbn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745392016; x=1776928016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xt0DA3GstpCfr74NeBEXDfg1bNB8goQaSwLushyxukA=;
  b=FWj7Zxbn34McFLVwvs/C2+WOfgF2bdyal3RrNyUSoThyDGIP/nR4FQ7N
   3xEMfAk4V2knQ2o3WQ0E116g4MsBYnyEk++NMIEFj23EmNlpqFAOwyehV
   B34lMsr13xKFX6xmLc5KfAJIDCoh+5kYBpSJE1EFUAB6N6oqRTpUEv6No
   vKq8PTUI4evLQGhwJSHFMHmtjJ8yxoEIzbn3iwIAgsoyE3r+2gp2r4Jym
   tmaivebivLsZey+NCOWMdWsDJRcREtobvtUf3la2eGrkKtMqBaRSorqER
   hzVGhS06AbnBZHB1VfrEdvLEKpYbB+qwqv32VBEILJGCiLsQ3T2W/wt35
   Q==;
X-CSE-ConnectionGUID: TdtBT+YGRdiTatYayQu4bg==
X-CSE-MsgGUID: vPjP3mLRRFqIW7SO68L2UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49637709"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="49637709"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 00:06:55 -0700
X-CSE-ConnectionGUID: xmFabzE5SVaVHbyoVfBwbw==
X-CSE-MsgGUID: Qsq+L7PrTDui0jV3bz8b2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="136302582"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2025 00:06:53 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7UC3-0001fz-1G;
	Wed, 23 Apr 2025 07:06:51 +0000
Date: Wed, 23 Apr 2025 15:06:09 +0800
From: kernel test robot <lkp@intel.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jic23@kernel.org,
	robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format
 conversion.
Message-ID: <202504231421.JAMhWond-lkp@intel.com>
References: <20250423022956.31218-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423022956.31218-1-rodrigo.gobbi.7@gmail.com>

Hi Rodrigo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.15-rc3 next-20250422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rodrigo-Gobbi/dt-bindings-iio-adc-st-spear600-adc-txt-to-yaml-format-conversion/20250423-103135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250423022956.31218-1-rodrigo.gobbi.7%40gmail.com
patch subject: [PATCH] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format conversion.
reproduce: (https://download.01.org/0day-ci/archive/20250423/202504231421.JAMhWond-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504231421.JAMhWond-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/staging/iio/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 984.
   make[2]: *** [Documentation/Makefile:121: htmldocs] Error 255
   make[1]: *** [Makefile:1801: htmldocs] Error 2
   make: *** [Makefile:248: __sub-make] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

