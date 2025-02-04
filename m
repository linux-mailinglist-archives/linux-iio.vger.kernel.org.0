Return-Path: <linux-iio+bounces-14961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524DA26EE9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 10:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2CD3A7188
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAF2080DB;
	Tue,  4 Feb 2025 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCNYBax9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768F207A00;
	Tue,  4 Feb 2025 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663189; cv=none; b=U4twOU5ZRIBCRXzCs3LTyQzhLvNw/AfqiPV4D4JlgOrtnLeHCJ0iAZBRSDDNH/GrMObsAnxhikeKKla+moKKPgctA+BAzy6IatmrhfemtS0fBXC8DYk22/PlWAZMbIhUa4cQ5uFL6Mvyq255exVksz4yMl+u1UXaRTGWepPAJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663189; c=relaxed/simple;
	bh=6K3zRmiuCUh3vM/8mpSY0RRXd5t6WO6/geN74RWeLQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7ZGZXJOnBQB62B2RRuFwJqMRA/AFU1gnFe8wVqbfZOW8wwzuumQRVkYTM4G1/mwTK0vLpBsZL92OsruszLGfl4b3gnr0uOx1hBBb3Zr416b4z3iwsUf3SabIIlU074P9plh+JEAXsENCKmRxi26sWWtSe7v5wXXfvMN5pzJ9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCNYBax9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738663188; x=1770199188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6K3zRmiuCUh3vM/8mpSY0RRXd5t6WO6/geN74RWeLQA=;
  b=mCNYBax91cNvLBNdpjudZ0inVENpZelt/WRseCATByeo20car8qL7V5u
   7FbNYL1Nv1ZrJdSvlAcO7lD9nEeysg9MkrzNZ5iNQZWIvANJYg/ZJGxLI
   PPZtuekFYMt7v/0YmvIrHsFyg+4UuRadXoTML9RjCDsqY37CeaVCf0mKB
   EzPdz5T8GEJlIZf9/EAeDSEL8cl29iLcN4hoeyAkU234Olgc7dsiq8P4t
   t8hD0Sv+rFT3Hc0E7LkkXoh4jgcrsvEM6AsQ5oF10XuGbjExqVj1EHI9X
   xrOSydVGHQGMrkbJa0yNTueN3Csyn94Xb7S5TTpL6Zg+uYDZUvwno02NM
   Q==;
X-CSE-ConnectionGUID: LmcxpkMLQ1+eknLSQiGYQg==
X-CSE-MsgGUID: 9RCZiSqUSk6uwb4h2NNBZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50602876"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50602876"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 01:59:47 -0800
X-CSE-ConnectionGUID: gOFg8UrETV+H7y9KNKfCWg==
X-CSE-MsgGUID: U/q2CAQUS3KG26opVAsjHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147759115"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Feb 2025 01:59:44 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfFiX-000sJD-1f;
	Tue, 04 Feb 2025 09:59:41 +0000
Date: Tue, 4 Feb 2025 17:59:02 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Message-ID: <202502041729.kDDFNlnS-lkp@intel.com>
References: <20250203-adc_ml-v2-2-8a597660c395@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-adc_ml-v2-2-8a597660c395@softing.com>

Hi Tobias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5]

url:    https://github.com/intel-lab-lkp/linux/commits/Tobias-Sperling-via-B4-Relay/dt-bindings-iio-adc-Introduce-ADS7138/20250204-003030
base:   05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
patch link:    https://lore.kernel.org/r/20250203-adc_ml-v2-2-8a597660c395%40softing.com
patch subject: [PATCH v2 2/2] iio: adc: Add driver for ADS7128 / ADS7138
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250204/202502041729.kDDFNlnS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250204/202502041729.kDDFNlnS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502041729.kDDFNlnS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ti-ads7138.c:706:12: warning: 'ads71x8_runtime_resume' defined but not used [-Wunused-function]
     706 | static int ads71x8_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ti-ads7138.c:698:12: warning: 'ads71x8_runtime_suspend' defined but not used [-Wunused-function]
     698 | static int ads71x8_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +/ads71x8_runtime_resume +706 drivers/iio/adc/ti-ads7138.c

   697	
 > 698	static int ads71x8_runtime_suspend(struct device *dev)
   699	{
   700		struct iio_dev *indio_dev = dev_get_drvdata(dev);
   701		struct ads71x8_data *data = iio_priv(indio_dev);
   702	
   703		return ads71x8_set_conv_mode(data, ADS71x8_MODE_MANUAL);
   704	}
   705	
 > 706	static int ads71x8_runtime_resume(struct device *dev)
   707	{
   708		struct iio_dev *indio_dev = dev_get_drvdata(dev);
   709		struct ads71x8_data *data = iio_priv(indio_dev);
   710	
   711		return ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
   712	}
   713	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

