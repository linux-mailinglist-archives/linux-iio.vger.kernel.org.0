Return-Path: <linux-iio+bounces-24240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3193B82B52
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 05:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C9C7B8E78
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5C2248B0;
	Thu, 18 Sep 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrlcIVRP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D32253F2;
	Thu, 18 Sep 2025 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164878; cv=none; b=eh2A1CSkc3ekJ3HYF4JKM6KP/drrEKSbiYhMD+++2kcPPDlfPIVRslp+VTQfLG0kK8amaKQ14Fz6YuYhQSL0i7qwwax/xgEtdVAxBS/8SmI4qPrwMtWbpZQN8PdUtLEmzM4tsl8izf4603UiBD9vJ9cWOLuiPIgp3vs+u7fkgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164878; c=relaxed/simple;
	bh=vxmzojAbDASA52i3gEMLP/8kjtkaX8qnfVm04vkuXBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/3ktJ2mghsmjU39NLTyNW/uc1jqpecsMszWs21IxvoeZOyuqMMfsJbJzFMU3TV+L5xEWEOxO/EP56N1pK6vPo3v2GhUJ8qPbuHySP11lyHry4k37G1cbAmKW/e0dLcedHTZxyVPzOiygdo0T0aHV8rTGigoO9q7cVlkEQ31Fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrlcIVRP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758164876; x=1789700876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vxmzojAbDASA52i3gEMLP/8kjtkaX8qnfVm04vkuXBQ=;
  b=jrlcIVRPsOvUJQnLWfX/xJKr7UY3wbL7FcjJbE0zSTLXxBAtQJot0u5D
   HyD7ePXPg4/zvgJP2XEzClcdnwTKczDO9uJy+Q4/zfscItoemgf98Dnmp
   vXz/0sWoGWZojbipNHpPmGxlYtlmgJR0hpohQjerFhp4a+jCRpNb/uqcu
   m6oNLePshJuvwrvP/Z1pq0YfFLRnPS06NF8MHy5rIaGpZA5hkuNcNB6Ge
   qIFFpc/aM1mXn+qz3Yty2Q/QWzV5WxEAqvZ8R5h2wor5VIg//sYjdbIAq
   erlTo8qzLRb7jsgjEqUkkAL59Fzv+AygSfRxhKns0JO/KbZWXP3X7/xkX
   g==;
X-CSE-ConnectionGUID: 1oDRMn3kTjG3oFsZWpPhuw==
X-CSE-MsgGUID: On2Ad8UMTka7VrDcqinpFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60372005"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="60372005"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 20:07:56 -0700
X-CSE-ConnectionGUID: o+VnVdjrRbOrf5S9IyL/6Q==
X-CSE-MsgGUID: mv2o59GIT6OgGr8WTEhazA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="212567329"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Sep 2025 20:07:53 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uz4zu-0002gR-36;
	Thu, 18 Sep 2025 03:07:50 +0000
Date: Thu, 18 Sep 2025 11:07:15 +0800
From: kernel test robot <lkp@intel.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>
Subject: Re: [PATCH 2/2] iio: temperature: add support for EMC1812
Message-ID: <202509181058.dx3hT9N3-lkp@intel.com>
References: <20250917-iio-emc1812-v1-2-0b1f74cea7ab@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-iio-emc1812-v1-2-0b1f74cea7ab@microchip.com>

Hi Marius,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Marius-Cristea/dt-bindings-iio-temperature-add-support-for-EMC1812/20250917-202833
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20250917-iio-emc1812-v1-2-0b1f74cea7ab%40microchip.com
patch subject: [PATCH 2/2] iio: temperature: add support for EMC1812
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250918/202509181058.dx3hT9N3-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250918/202509181058.dx3hT9N3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509181058.dx3hT9N3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:28:9: warning: '__SANITIZE_ADDRESS__' macro redefined [-Wmacro-redefined]
      28 | #define __SANITIZE_ADDRESS__
         |         ^
   <built-in>:371:9: note: previous definition is here
     371 | #define __SANITIZE_ADDRESS__ 1
         |         ^
>> drivers/iio/temperature/emc1812.c:259:27: warning: unused variable 'emc1812_window_size' [-Wunused-const-variable]
     259 | static const unsigned int emc1812_window_size[3] = { 1, 4, 8 };
         |                           ^~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/emc1812_window_size +259 drivers/iio/temperature/emc1812.c

   258	
 > 259	static const unsigned int emc1812_window_size[3] = { 1, 4, 8 };
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

