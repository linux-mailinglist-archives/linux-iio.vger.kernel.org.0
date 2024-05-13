Return-Path: <linux-iio+bounces-5024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841EB8C4A3A
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 01:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DD71F24B1F
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 23:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC5126F02;
	Mon, 13 May 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjkzpoSI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27995129E7E;
	Mon, 13 May 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644266; cv=none; b=E7dmGgIz7VyOovE8TIMSTQQgSIC3wFmjMSqvj5uFCU/ZMz9p7a5MxgooBNvI5mZB2Pnh7IAPSRb9ICXutqqbtNcUet410DBiTtQG8WQe8ALzdOW4NLq0pDcYAHqjvfNaDKQgCs5BV7s2IY82OiSTW6XKaM/b9/FDnSK9t/K4Q+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644266; c=relaxed/simple;
	bh=8k7wY0dIyy5/im7vf9wz7CejUYZadSeVLOyq35oenu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFIWXUEHqR89Vue/bOz2pFp+/Dw2mmLhd6g8EtC4gxpi827Bnzb2nomh5ql6yJrJBMAN2a6/No54fM4o88HuO/E2F6upAkQTWOHGooN4cDhQVOdNhvK8kro9quhBiRlX8iheo3viDEUc6ko9ymVAQcik/7iUeRBZR83FRCaIdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjkzpoSI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715644264; x=1747180264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8k7wY0dIyy5/im7vf9wz7CejUYZadSeVLOyq35oenu0=;
  b=LjkzpoSIFECDZ4ftKkZZVDFLiDUjLUQNTQP0IaMgAc1O8aI+QDCoQc0K
   GMAE6QblmYZyQLEeLJth3FxP1Jgxw71Olr+nlAVYoXj6gHOHpz47Cuuh3
   Qu6RO4Ki+aZRUQu9dlvXSBIQEKLxIo5TX+AZeAiTIBu1GRZh7+Dd3p7ZY
   UIzpEi0qKxKnhKxrfENlnXa9F/n0KG2VyWdSzOArzhH/r4VtOk4U0976f
   V9TOe1pzXCX46+yhMgWuN5nm/d6h+kiuTb6jcQfGQK8utZDX3h6jVc+3x
   l5pqgZUAdqPP5IRX87/tZuI8ukvI66yrwkWAaLXaAQwzlq70f8hbT+KHl
   Q==;
X-CSE-ConnectionGUID: kHOrN815Qf2MB1x4mxI9oQ==
X-CSE-MsgGUID: Ge/Bl8W9RhmQyzesPfyAwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="29093954"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29093954"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 16:51:03 -0700
X-CSE-ConnectionGUID: SX6aCGhPTHuCKaVvAbrmLA==
X-CSE-MsgGUID: N0lPQVPlSMeeWOzne2Q0Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30497746"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 May 2024 16:51:01 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6fRa-000Ao7-1C;
	Mon, 13 May 2024 23:50:58 +0000
Date: Tue, 14 May 2024 07:50:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de, christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: chemical: ens160: add triggered buffer support
Message-ID: <202405140721.LuiSHRvx-lkp@intel.com>
References: <20240512210444.30824-5-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512210444.30824-5-gustavograzs@gmail.com>

Hi Gustavo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 084eeee1d8da6b4712719264b01cb27b41307f54]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-Silva/dt-bindings-vendor-prefixes-add-ScioSense/20240513-050745
base:   084eeee1d8da6b4712719264b01cb27b41307f54
patch link:    https://lore.kernel.org/r/20240512210444.30824-5-gustavograzs%40gmail.com
patch subject: [PATCH 4/6] iio: chemical: ens160: add triggered buffer support
config: arc-randconfig-r123-20240514 (https://download.01.org/0day-ci/archive/20240514/202405140721.LuiSHRvx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240514/202405140721.LuiSHRvx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405140721.LuiSHRvx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/chemical/ens160_core.c:250:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __le16 [addressable] [usertype] val @@
   drivers/iio/chemical/ens160_core.c:250:39: sparse:     expected unsigned short
   drivers/iio/chemical/ens160_core.c:250:39: sparse:     got restricted __le16 [addressable] [usertype] val
   drivers/iio/chemical/ens160_core.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +250 drivers/iio/chemical/ens160_core.c

   232	
   233	static irqreturn_t ens160_trigger_handler(int irq, void *p)
   234	{
   235		struct iio_poll_func *pf = p;
   236		struct iio_dev *indio_dev = pf->indio_dev;
   237		struct ens160_data *data = iio_priv(indio_dev);
   238		__le16 val;
   239		int ret, i, j = 0;
   240	
   241		mutex_lock(&data->mutex);
   242	
   243		for_each_set_bit(i, indio_dev->active_scan_mask,
   244				 indio_dev->masklength) {
   245			ret = regmap_bulk_read(data->regmap,
   246					       ENS160_REG_DATA_TVOC + 2 * i, &val, 2U);
   247			if (ret)
   248				goto err;
   249	
 > 250			data->scan.chans[j++] = val;
   251		}
   252	
   253		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
   254						   pf->timestamp);
   255	err:
   256		mutex_unlock(&data->mutex);
   257		iio_trigger_notify_done(indio_dev->trig);
   258	
   259		return IRQ_HANDLED;
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

