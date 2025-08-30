Return-Path: <linux-iio+bounces-23436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18213B3C9F8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2955E42D0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A726D4D8;
	Sat, 30 Aug 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="henxafJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA572417C5;
	Sat, 30 Aug 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548831; cv=none; b=ZyXhucKm925WO+uGV40V1fjHnZtTTxcLsjMl4zEHCZ5Yzm+/buGfmQRFpOT/nP2gagVS6WVshkI91K35d+gKECqu0OEkoJpuxpHfGJkHgrbMiK3ioU7c+iDn9XIXkxAD8LHAUARLsxORTr2Cq4ZBHHT1cF9YFJhG/ZRr8SWl1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548831; c=relaxed/simple;
	bh=B1ZFXpO17HYnFuaf9SvN4OnRff+GK1Sv6tFs7KIG8bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQKxsoEoATT5jysZk6rNzDHkFnG/amW7TwL2wYjpUceMkAO4vDbFSQV8R4wRf/hDkR6p2n6BLgqbdn6DPK9+Z+x64SDF50GDxvgm3dw03UgPyDX2VRrmRpQniSoB5xoCD6EoBHC7H0BY9vjcySyGD4qMwYzmYuSxneVhJVtNST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=henxafJL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756548830; x=1788084830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1ZFXpO17HYnFuaf9SvN4OnRff+GK1Sv6tFs7KIG8bE=;
  b=henxafJLHC65wNRQqEOosp7osS0LpvvsVlh+LBt+XtBm6+CMmkNqnpu/
   lalSBUuDPy+AxCW9y+lxomlyqJwT8OHC7lzCbGHwLKP4k0rrxpTwcgnRV
   B1OMXroYRhWWD+lknMVC1i5pHfPkzEeO6sBFSWt1/j4kFxlhMvSGBc41t
   lHuA/DO/dVef/nCmc+roXOUz1G4DJImusLwxEjaeRT0EbRODUAirU2GNM
   QnTz+dXPtwLVvbE1ewepASWDNLpDIAuleKEWqScHLdVUIvi5Q0m91OQqh
   WJRwb5G/C0RpN2Zz9OTNJQ+wP/jcVNJkxY0so/5/+AUhp5mboElP0FUlj
   w==;
X-CSE-ConnectionGUID: 8mAApW1fQKagBC2+FtHTKg==
X-CSE-MsgGUID: iWS4NJSzSWSro6iG1HpPaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69923015"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69923015"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 03:13:50 -0700
X-CSE-ConnectionGUID: ggO2xV+VQqWUfbEiIMcc3w==
X-CSE-MsgGUID: +MLpiocSR7mpPdx1SzmCKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170961120"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2025 03:13:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usIaJ-000VIZ-2o;
	Sat, 30 Aug 2025 10:13:32 +0000
Date: Sat, 30 Aug 2025 18:13:08 +0800
From: kernel test robot <lkp@intel.com>
To: victor.duicu@microchip.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, marius.cristea@microchip.com,
	victor.duicu@microchip.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: temperature: add support for MCP998X
Message-ID: <202508301754.nIIdyNZ3-lkp@intel.com>
References: <20250829143447.18893-3-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829143447.18893-3-victor.duicu@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 788c57f4766bd5802af9918ea350053a91488c60]

url:    https://github.com/intel-lab-lkp/linux/commits/victor-duicu-microchip-com/dt-bindings-iio-temperature-add-support-for-MCP998X/20250829-223952
base:   788c57f4766bd5802af9918ea350053a91488c60
patch link:    https://lore.kernel.org/r/20250829143447.18893-3-victor.duicu%40microchip.com
patch subject: [PATCH v4 2/2] iio: temperature: add support for MCP998X
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250830/202508301754.nIIdyNZ3-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project ac23f7465eedd0dd565ffb201f573e7a69695fa3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508301754.nIIdyNZ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508301754.nIIdyNZ3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/iio/temperature/mcp9982.c:114 struct member 'allow_apdd' not described in 'mcp9982_features'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

