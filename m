Return-Path: <linux-iio+bounces-21595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46068B02C49
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6EB1C234B4
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DADF28A72F;
	Sat, 12 Jul 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHcMpoUX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51882236FB;
	Sat, 12 Jul 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752343031; cv=none; b=DOFJTGSlya4sBmqvZv8oD6hpjWXhx/Evh1Y4vBiSWyi27ph6Kp/FGxzh8fBqLzORIaofh2OaK7Zf/66YT3kwTcm91pLK/Ttrc35SBd803aTfyLcLh+zZaGXdCyFCZ+w4kWoRMd3FpWWG6HU0S24ztAsVzBCvhvx3tnIBfgot0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752343031; c=relaxed/simple;
	bh=H/rypz2Qr+SfNGH2PuCCBQtkvX2TjfFGf7Dh9YJ871w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2ef2QfBJy1QKTl7tyvPEiJcF7u8buw9xSp/CW8VT3lO1ikw17aIRkwD4ZzeiRknK5c10u57JK30wg2aY7RU3UKRQLuAaxVt6KPbNDEjt+WYxz4p88PPqbFMTkVg+Oq8kaQMuP1/IQ5ldDuMdz1ItVknaHa3nlPbvwnOUyodLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHcMpoUX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752343030; x=1783879030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H/rypz2Qr+SfNGH2PuCCBQtkvX2TjfFGf7Dh9YJ871w=;
  b=iHcMpoUXXu+DlefYuzSb5xvyRI7yknaDVHcVlalKrWX011qMDz+FXuTm
   fqdcoHSZAte0spZYxNpMuED3Xy/fM7EPoW6hINeXtqTTNW1OLNYiLQeJT
   P+PB0RuND1qFj62gh1Rm7sf44oeyZaDBMV8qO48NFQRAYsMppZVsMrIU6
   YHVcWQuvTFoA/UclrdGRSi7NPzmCyIQc+0SDDILszN+Jx0SvNtWC6U5we
   A2an874qBa0cJ1CV5GCIOyEIsv/Vh6iQI3aue3cpkK+wH8Vd85T0y7apn
   0587CHAw6f8lndYb7CreC2Bc4+rMWkWPosEmyYaCdTgcCI6SIh08+q9vl
   Q==;
X-CSE-ConnectionGUID: e7rMig1jRYaJ3MSDYn/o5g==
X-CSE-MsgGUID: 60elRmavSl6FXNc29Fn3KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="80041346"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="80041346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 10:57:09 -0700
X-CSE-ConnectionGUID: oi8yhvzwTVqN/u+no0FtcA==
X-CSE-MsgGUID: wYSE6Lg7QC24EtHbyLqjcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="162177159"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Jul 2025 10:57:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaeTB-0007ZP-0d;
	Sat, 12 Jul 2025 17:57:05 +0000
Date: Sun, 13 Jul 2025 01:56:20 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH 3/3] iio: adc: add ade9000 support
Message-ID: <202507130110.J1mOxDr1-lkp@intel.com>
References: <20250711130241.159143-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711130241.159143-4-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.16-rc5 next-20250711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-add-power-and-energy-measurement-modifiers/20250712-022300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250711130241.159143-4-antoniu.miclaus%40analog.com
patch subject: [PATCH 3/3] iio: adc: add ade9000 support
config: nios2-randconfig-002-20250713 (https://download.01.org/0day-ci/archive/20250713/202507130110.J1mOxDr1-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507130110.J1mOxDr1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130110.J1mOxDr1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ade9000.c:2170:34: warning: 'ade9000_of_match' defined but not used [-Wunused-const-variable=]
    2170 | static const struct of_device_id ade9000_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/ade9000_of_match +2170 drivers/iio/adc/ade9000.c

  2169	
> 2170	static const struct of_device_id ade9000_of_match[] = {
  2171		{ .compatible = "adi,ade9000" },
  2172		{}
  2173	};
  2174	MODULE_DEVICE_TABLE(of, ade9000_of_match);
  2175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

