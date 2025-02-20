Return-Path: <linux-iio+bounces-15876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51531A3E044
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6327A83B5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F195200132;
	Thu, 20 Feb 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9okpbtR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3E1FF1DF;
	Thu, 20 Feb 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067697; cv=none; b=FJXMU1vhVI8wxkZfX+G1L+aCTDfDeBFP75aX0+dRNMhowPu9lYVOCSrSKiZm9rauYNSme+B/Kz+LQbJ+lMRdyoDVFbiGalCbol5slUNAjqdhGm2vFP/hlZckq3jIkHRB8r/qoAW/MsHPOTSok8YiJNxfshd/knKcinIspxB2pSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067697; c=relaxed/simple;
	bh=5UKuSJfQdQ3wxkz3CXu365iXRHx0PfplKe3AL6w5Cms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKp9hEmACsNSTOqkorAo+Bjf2YVp6sOpcQabwo0+j7+SthQQ7gQRUnI3sVCG5cZZi4DUqUX3xbVKziu+bSdWIys885JvUCMwQCc6RUeAcNzMtH2AT1eh1EH2oxCse7j2NMvCYi3gqQUUt7jMhtDbg5h5YlvFsXLjxIOtvtMQrLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9okpbtR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740067696; x=1771603696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5UKuSJfQdQ3wxkz3CXu365iXRHx0PfplKe3AL6w5Cms=;
  b=J9okpbtRpXRYl+M69rE0zMxjVCOfdknLKdoqhqnfc5BRu3umjarlf74r
   Z50lobRptblpjuhqb67uCfOEXh9Nj4j5X8+Sa6kU0GNOvgyRw/0friaBH
   jRgR/UmWPelWGtSvqPSgDnYKVSyDw60fQ8kjZunh7kVsHUHi9zgRIxZPG
   yigr73se9pGu5lA4qG+prUL0bdBYeA33NlLBz94YChaKwRXmKb/tUKpYE
   RsXuTjasvlU0+ABZvQUEa/L0CS/MbayGUh3DmKy/Jz+ru2k1ALki/rV9n
   YdkfqGEf3DkHU9AnodBen2wnD1ouCOoLIKwdvS3wMIusZGcSOKpX+k5/i
   A==;
X-CSE-ConnectionGUID: 7iuCIUTiSNmeuEJSftQBpg==
X-CSE-MsgGUID: jyquree2Syqh6Eqhnhl3Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41111097"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="41111097"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:08:12 -0800
X-CSE-ConnectionGUID: XpRPYF38T1i0MknHmzmydw==
X-CSE-MsgGUID: nmfcKGLnQPKtGGWmAwquGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145937707"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2025 08:08:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl95l-0004Tv-20;
	Thu, 20 Feb 2025 16:08:01 +0000
Date: Fri, 21 Feb 2025 00:07:17 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 6/9] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <202502202332.jrEGhoBM-lkp@intel.com>
References: <25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5bc55a333a2f7316b58edc7573e8e893f7acb532]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/dt-bindings-ROHM-BD79124-ADC-GPO/20250219-203748
base:   5bc55a333a2f7316b58edc7573e8e893f7acb532
patch link:    https://lore.kernel.org/r/25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount%40gmail.com
patch subject: [PATCH v3 6/9] iio: adc: rzg2l_adc: Use adc-helpers
config: i386-buildonly-randconfig-005-20250220 (https://download.01.org/0day-ci/archive/20250220/202502202332.jrEGhoBM-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502202332.jrEGhoBM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502202332.jrEGhoBM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_iio_adc_device_alloc_chaninfo
   >>> referenced by rzg2l_adc.c:324 (drivers/iio/adc/rzg2l_adc.c:324)
   >>>               drivers/iio/adc/rzg2l_adc.o:(rzg2l_adc_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

