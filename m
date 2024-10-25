Return-Path: <linux-iio+bounces-11257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 041FC9AFD7B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76EF4B22CA5
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0471D4356;
	Fri, 25 Oct 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhTLQZQ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C551D4325;
	Fri, 25 Oct 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846917; cv=none; b=Gz+9N5de7QdR1Bw1YHiDjZNvpOyCdks4VsNdk0JSG0P6aWS294k3enawozl01TE2B1FsAzsKngNpwoJOoBAL6FgOEq+86/wQ/75SyaP3R6Y0/STmjo1CjGGA8kLlfDxHVJMWrWMQFvtGTbxC+5BiFHswtATwr0s0yHvPO2WkREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846917; c=relaxed/simple;
	bh=htC/6QMDF8HVGn5CRNi07vqi5NpRMzbknlYRKztT9jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKT2w6i5txAfRnJFELcQdRlgL1AXcCpoLM8fgqeLfjyNDRUGpFkYVbMDIC1jRX9GJiQxLQCfRxUY5BMk5WpZOQiFVZN2Srx72DAhru0UARyoZrYq75lLjD0N9bS+6Y3Vx2w2O9b29ZIXEOowswIn4uQ83RDZNr1wmr2imnx1Qv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhTLQZQ6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729846916; x=1761382916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=htC/6QMDF8HVGn5CRNi07vqi5NpRMzbknlYRKztT9jk=;
  b=hhTLQZQ6yr9GVJeXoPK8AjnTKrneaWjS9yR4LB4u1JSfal7eSLwWhn4B
   RwRzKKT+ieGHbeR/BfaiHZmm4Qpe/YKPCQJckeX7MLHgQHskKW8ltUvP6
   Ylmt62uXx9UjGxERANiMrVfGlBEnt2LCdewF/Ivy1s+X9e7BDfrRx8Qky
   sb45ROQRa61oQZCC4hMNbTpNmyn2JsNtPs6Ac30esJF2gZvOoWp/txz3Q
   9asMcucPq1D9fDR+fMpo1x1ad3EpSGOtRPBZmzJYCTmy5IvNVo8veNMuq
   eVh/iMemV/r+50h94FVJKwKjhcm4C+FhmJdiFhv/IRQYSpKOJ6Zga/mgC
   A==;
X-CSE-ConnectionGUID: DGKbz6hVTjSL3lrEAPsgNg==
X-CSE-MsgGUID: E7I9ATUyTKatCMAmiM3Thw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52064597"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52064597"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:01:55 -0700
X-CSE-ConnectionGUID: aomwVR+sSpSr6jfrzBx1Aw==
X-CSE-MsgGUID: QKJd9hcgRwaUxHbYSG+U3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85620158"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Oct 2024 02:01:52 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4GCb-000Xuo-2n;
	Fri, 25 Oct 2024 09:01:49 +0000
Date: Fri, 25 Oct 2024 17:01:18 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: add support for veml3235
Message-ID: <202410251610.kB7u6xMJ-lkp@intel.com>
References: <20241023-veml3235-v3-2-8490f2622f9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-veml3235-v3-2-8490f2622f9a@gmail.com>

Hi Javier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ceab669fdf7b7510b4e4997b33d6f66e433a96db]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/dt-bindings-iio-light-veml6030-add-veml3235/20241024-030144
base:   ceab669fdf7b7510b4e4997b33d6f66e433a96db
patch link:    https://lore.kernel.org/r/20241023-veml3235-v3-2-8490f2622f9a%40gmail.com
patch subject: [PATCH v3 2/2] iio: light: add support for veml3235
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410251610.kB7u6xMJ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251610.kB7u6xMJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251610.kB7u6xMJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/light/veml3235.c: In function 'veml3235_set_it':
>> drivers/iio/light/veml3235.c:148:26: warning: variable 'it_idx' set but not used [-Wunused-but-set-variable]
     148 |         int ret, new_it, it_idx;
         |                          ^~~~~~
   drivers/iio/light/veml3235.c: In function 'veml3235_set_gain':
>> drivers/iio/light/veml3235.c:191:28: warning: variable 'gain_idx' set but not used [-Wunused-but-set-variable]
     191 |         int ret, new_gain, gain_idx;
         |                            ^~~~~~~~


vim +/it_idx +148 drivers/iio/light/veml3235.c

   144	
   145	static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
   146	{
   147		struct veml3235_data *data = iio_priv(indio_dev);
 > 148		int ret, new_it, it_idx;
   149	
   150		if (val)
   151			return -EINVAL;
   152	
   153		switch (val2) {
   154		case 50000:
   155			new_it = 0x00;
   156			it_idx = 4;
   157			break;
   158		case 100000:
   159			new_it = 0x01;
   160			it_idx = 3;
   161			break;
   162		case 200000:
   163			new_it = 0x02;
   164			it_idx = 2;
   165			break;
   166		case 400000:
   167			new_it = 0x03;
   168			it_idx = 1;
   169			break;
   170		case 800000:
   171			new_it = 0x04;
   172			it_idx = 0;
   173			break;
   174		default:
   175			return -EINVAL;
   176		}
   177	
   178		ret = regmap_field_write(data->rf.it, new_it);
   179		if (ret) {
   180			dev_err(data->dev,
   181				"failed to update integration time: %d\n", ret);
   182			return ret;
   183		}
   184	
   185		return 0;
   186	}
   187	
   188	static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
   189	{
   190		struct veml3235_data *data = iio_priv(indio_dev);
 > 191		int ret, new_gain, gain_idx;
   192	
   193		if (val2 != 0)
   194			return -EINVAL;
   195	
   196		switch (val) {
   197		case 1:
   198			new_gain = 0x00;
   199			gain_idx = 3;
   200			break;
   201		case 2:
   202			new_gain = 0x01;
   203			gain_idx = 2;
   204			break;
   205		case 4:
   206			new_gain = 0x03;
   207			gain_idx = 1;
   208			break;
   209		case 8:
   210			new_gain = 0x07;
   211			gain_idx = 0;
   212			break;
   213		default:
   214			return -EINVAL;
   215		}
   216	
   217		ret = regmap_field_write(data->rf.gain, new_gain);
   218		if (ret) {
   219			dev_err(data->dev, "failed to set gain: %d\n", ret);
   220			return ret;
   221		}
   222	
   223		return 0;
   224	}
   225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

