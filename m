Return-Path: <linux-iio+bounces-20914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0601AE45EB
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7A73B670E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA525393C;
	Mon, 23 Jun 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XApXZgei"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D823E344;
	Mon, 23 Jun 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686991; cv=none; b=c5/E60ec8dBcn/f2LAw5ftRHuO9fylOAJRAOXYscOT3gn55PGDnVSfTq+haUuT2Al7C350TNtYiPNmZsspHeyMfH1UndBPSYpsmXrb900yr+065Bwu4NH52atzhMjvfPtM1JHIf8SpO2pZJS3adrWXr2iAZv9+2zXcK/FeI3Uco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686991; c=relaxed/simple;
	bh=BTYyyGYNVnjSCNBgeNkFIdfjEBcqf+09SP/3DndyJ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4fYeZ3ssL3QFuwTbI4bhxcaaNwkpwbUWM3FzhXjDxjsf7MCBV4d3+vt4OzJK04RZROiTj+d1DcxBKBA6nlm14uxO9Of0HVcD50j2juZIGIr02DubQMnfEOGdHtXAUJn2j5vt4T/SNFGR+NTihBUOAF7ArcuqZid5+QDbvxFmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XApXZgei; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750686989; x=1782222989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BTYyyGYNVnjSCNBgeNkFIdfjEBcqf+09SP/3DndyJ+8=;
  b=XApXZgeiVfowjuRzJTgoCfXdkVx8oramMgTANMGEPi/DXsFt1DNUVKuA
   X0Ed1MyNaB2XXUfaSPmbpa9XBtc69WDYfRvIeEUJcWpX9gbplVt540QdO
   4AuIFpbDBl3O+QqRo8q8Q7D1G8wnAFSQPCWb4Mq/Nc/Rt6sFPwZAS0SoB
   A8H5tQcqpn0cyo27zdNS4D6pMtV8kobRdB0tRrzy5LopbSEsbq8A+h8Xh
   rfhZdn0bKaewU/aRpj/h/f+p1surjiHcJsl+8nuvASWWpPOABT16Xz30t
   rCOCHs//tT5zpC/3vFSEXKv35Kt8nr9r3epzpsDbb8fOQGbMkyda+rPC1
   Q==;
X-CSE-ConnectionGUID: wFTS6WrYR1uftpdojCU5vg==
X-CSE-MsgGUID: PvmxDSX5TZ2R1aVbUCdeug==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="75428941"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="75428941"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 06:56:28 -0700
X-CSE-ConnectionGUID: vV3UJ73dRKevd5zXEFEfSA==
X-CSE-MsgGUID: +HErZaZ4Q0S7IuRdDW+3CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151901679"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Jun 2025 06:56:25 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uThep-000OyM-0V;
	Mon, 23 Jun 2025 13:56:23 +0000
Date: Mon, 23 Jun 2025 21:55:33 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
Message-ID: <202506232119.aLbzgQow-lkp@intel.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on d02f330b0c78bcf76643fbb7d3215a58b181f829]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad_sigma_delta-sort-includes/20250621-063127
base:   d02f330b0c78bcf76643fbb7d3215a58b181f829
patch link:    https://lore.kernel.org/r/20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430%40baylibre.com
patch subject: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
config: x86_64-buildonly-randconfig-001-20250621 (https://download.01.org/0day-ci/archive/20250623/202506232119.aLbzgQow-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250623/202506232119.aLbzgQow-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506232119.aLbzgQow-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module ad_sigma_delta uses symbol devm_iio_dmaengine_buffer_setup_with_handle from namespace IIO_DMAENGINE_BUFFER, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

