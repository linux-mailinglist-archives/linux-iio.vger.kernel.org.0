Return-Path: <linux-iio+bounces-9147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793EE96C2F5
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFFC9B24356
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934341E00A9;
	Wed,  4 Sep 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SH3uwh+O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098E1DFE35;
	Wed,  4 Sep 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465031; cv=none; b=K6+RD/1zbuWKB/0NGWIjUUftQK2ptFUdc4SVBywoIgKNGqVW780Kpec3NPX7pLBE0h39fMHjDdirKRcPKIDAzDj80qkHjQjKp83YLgVdW/xwvgWqCWDkHcaj+qfMsrscyXNdmN4fHqgR//s2IQeFIs1h29ArN+ymMdBK3r4/hGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465031; c=relaxed/simple;
	bh=qwDHvWtGidi6YhwcnUq01LvlP4dVDYDAJ3vzEEDQ/qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW3JhXMAqakPGpVY/gKd7a1i5pMIrAOCdKM5pVDZoPMdLqkd3ZgIME7HdlsKjh638hpKLdJH4Oy2bkW2TicvVMKipHs6wajBR9gCs43bPJDlZ3faF5xrJs5LmKZDPPUlKUIa/7QSz0XMppXiDuMbzxXIoPs1YHF4IfavHGHje7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SH3uwh+O; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725465029; x=1757001029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qwDHvWtGidi6YhwcnUq01LvlP4dVDYDAJ3vzEEDQ/qc=;
  b=SH3uwh+O+wWaFS+/JTw1EzNDBOgwUxFRs/f2SDXb48skGpG7QjMfzHyy
   MWNRMGG/15f1AxWj6ud2ge4pUM9TGGvsDovg44VNvcHhgD4g3y5yO/iHz
   n9VRpl0Jv4MQebs8xv5GXThhxHN1tFQsJjeFwFJJM4lCp/ICosct2YeYn
   M/zvE0mW4atdeujeRbrzbKQdbyOMcxAp952RDiZ1hLRxUhcJ+mdXgw8Sw
   40/AZRoKZK9dJU6uOnMdd8I3D/uBQrMOpTzdZxmbKWyy0kHcMaVX01Byl
   X035tWw0bJ6ZVzQlvEKEMtPskUyLTdZrvVTMpK3kL0epFYmlb1jtw+z0M
   Q==;
X-CSE-ConnectionGUID: NueMBSjCQmGrn7o3N0Q2RQ==
X-CSE-MsgGUID: ajvxk2i7SOqT/93SSaMiCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="41610189"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="41610189"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:50:29 -0700
X-CSE-ConnectionGUID: XtYPKgLFTxaZ66jBnCFSLg==
X-CSE-MsgGUID: Bbz/TEkNRPidB7QjsTXrVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="69475698"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Sep 2024 08:50:25 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slsH1-0008HL-0j;
	Wed, 04 Sep 2024 15:50:23 +0000
Date: Wed, 4 Sep 2024 23:50:21 +0800
From: kernel test robot <lkp@intel.com>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <202409042318.7nwvZc3c-lkp@intel.com>
References: <20240904023040.23352-3-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904023040.23352-3-Mariel.Tinaco@analog.com>

Hi Mariel,

kernel test robot noticed the following build errors:

[auto build test ERROR on c4b43d8336e52dce6d124e428aa3b71703e62647]

url:    https://github.com/intel-lab-lkp/linux/commits/Mariel-Tinaco/dt-bindings-iio-dac-add-docs-for-ad8460/20240904-103413
base:   c4b43d8336e52dce6d124e428aa3b71703e62647
patch link:    https://lore.kernel.org/r/20240904023040.23352-3-Mariel.Tinaco%40analog.com
patch subject: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240904/202409042318.7nwvZc3c-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409042318.7nwvZc3c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409042318.7nwvZc3c-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/dac/ad8460.c: In function 'ad8460_get_hvdac_word':
>> drivers/iio/dac/ad8460.c:165:16: error: implicit declaration of function 'get_unaligned_le16' [-Wimplicit-function-declaration]
     165 |         *val = get_unaligned_le16(state->spi_tx_buf);
         |                ^~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_set_hvdac_word':
>> drivers/iio/dac/ad8460.c:172:9: error: implicit declaration of function 'put_unaligned_le16' [-Wimplicit-function-declaration]
     172 |         put_unaligned_le16(FIELD_PREP(AD8460_DATA_BYTE_FULL_MSK, val),
         |         ^~~~~~~~~~~~~~~~~~


vim +/get_unaligned_le16 +165 drivers/iio/dac/ad8460.c

   155	
   156	static int ad8460_get_hvdac_word(struct ad8460_state *state, int index, int *val)
   157	{
   158		int ret;
   159	
   160		ret = regmap_bulk_read(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
   161				       &state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
   162		if (ret)
   163			return ret;
   164	
 > 165		*val = get_unaligned_le16(state->spi_tx_buf);
   166	
   167		return ret;
   168	}
   169	
   170	static int ad8460_set_hvdac_word(struct ad8460_state *state, int index, int val)
   171	{
 > 172		put_unaligned_le16(FIELD_PREP(AD8460_DATA_BYTE_FULL_MSK, val),
   173					     &state->spi_tx_buf);
   174	
   175		return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
   176					 state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

