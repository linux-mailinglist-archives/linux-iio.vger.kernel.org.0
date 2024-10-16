Return-Path: <linux-iio+bounces-10671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920099A15AB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 00:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5784728153C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E81D364B;
	Wed, 16 Oct 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih7yTjLz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764314EC47;
	Wed, 16 Oct 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116651; cv=none; b=Qz+LX2kuMZuU+H8MwxGiv6oXppHtca+kkFauyecrx5pE7y5Xs4ezXlo614KHNzzm3BoES6diwfZizf+YEpl8vPyAH4CxI/6D2f2rQ9JYxL1PNaSokpO7ONCktiI2m7ua+OG/4BbLSLI41A30YlP8PuXhSH5xiLPykyHY+wF9f58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116651; c=relaxed/simple;
	bh=2BgZtfKZf2x+57QEEEVp0Z+iLVJA2GU8FZXnbuwkYz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu0+fnjEZETR7EuGcTPicz7m0mlgWcIfFqZ+6A0Tzur7LmuD5rEPpKt9ofLVSvPQnCu/KXgo9T1DFTok8QaqDjulla+xuiBD1lzrhbIOjUdt01CVhQjLqBPzK28C8QDXjYU1E5GjvYyu67ukESMAV2Vei2l57rsKb3wGpJ+QVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih7yTjLz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729116650; x=1760652650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BgZtfKZf2x+57QEEEVp0Z+iLVJA2GU8FZXnbuwkYz0=;
  b=Ih7yTjLzPNFVZvadL3PJbGRaHjC5/kTsXjEGoKfrJid0QePlF4yOdM5/
   SZ3aFdy7olYVhLc2WH2WGxrf6eeaHMVH4UqdVRmbJmtQyzCzemOxzm0jz
   mO8XcKJkBXLYSazQ4f35t82kCKEhOu5PnZOWbY+Bxjlj+km3SiR2F1BQN
   kUFI5Nu9cCztS5kO7NGagYg48NdUrkmEA2ogLKukohzY+tvGp2+HJnxkZ
   QDj1pJxCofNZcRfQ+G1xmWMPHc3UrshEJxsW1/jsLsGXckFkbpTHQzvq5
   8p/jCA7CLGcTNBrZnfwM91wKO6nh95RI2HrvUVNpzAxfLU8yOfYVBa/Ln
   Q==;
X-CSE-ConnectionGUID: WaJuhtw7QeiGeWlb+CCh2A==
X-CSE-MsgGUID: fmu/lbpQQ4OAzOuZPOZjwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="32514392"
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="32514392"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 15:10:49 -0700
X-CSE-ConnectionGUID: josMHNayRhqqGc/fpFMzrA==
X-CSE-MsgGUID: /dxwmPuXTEiivmwyqEsFMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="83423127"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2024 15:10:46 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1CE7-000LTJ-17;
	Wed, 16 Oct 2024 22:10:43 +0000
Date: Thu, 17 Oct 2024 06:10:03 +0800
From: kernel test robot <lkp@intel.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	rickard.andersson@axis.com, kernel@axis.com,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202410170546.5rfqxnWM-lkp@intel.com>
References: <20241015143713.2017626-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015143713.2017626-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on eca631b8fe808748d7585059c4307005ca5c5820]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241015-224128
base:   eca631b8fe808748d7585059c4307005ca5c5820
patch link:    https://lore.kernel.org/r/20241015143713.2017626-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color sensor
config: x86_64-randconfig-161-20241017 (https://download.01.org/0day-ci/archive/20241017/202410170546.5rfqxnWM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410170546.5rfqxnWM-lkp@intel.com/

smatch warnings:
drivers/iio/light/opt4060.c:932 opt4060_volatile_reg() warn: always true condition '(reg >= 0) => (0-u32max >= 0)'

vim +932 drivers/iio/light/opt4060.c

   929	
   930	static bool opt4060_volatile_reg(struct device *dev, unsigned int reg)
   931	{
 > 932		return (reg >= OPT4060_RED_MSB && reg <= OPT4060_CLEAR_LSB) ||
   933		       (reg == OPT4060_RES_CTRL);
   934	}
   935	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

