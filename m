Return-Path: <linux-iio+bounces-4974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E248C3363
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5650D1F21639
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 19:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7092F1CD0C;
	Sat, 11 May 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLOe74gS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806631CABF;
	Sat, 11 May 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455166; cv=none; b=sBnpzmDErtgtkO5cJhqqb1G/OTu140N+1TtVl56w4LzXRkgqR21C/kdgOBWWWxTH0jMYbbUNL1ktv8eGL98Xd+K2Y+/R+Cd/+0gfgC/EYkBDOqr4WZZZKqQPK2I1/A87pKPKIlpllY64beFVGCABfgXMV9e8iiS9UI4+PPrB5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455166; c=relaxed/simple;
	bh=10Sr8/r4vsQLBHs2eT8Nl5dyWcbWgKeqIXysLkPRiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDnNXww4Bc5FE2ohUEw10BBX7E0SDiPwRO0+6Y6kBasAfSZ17OxDlfZMi6iL7vCmFXx0i+5IrXHP6ayrYIMVtcuSLyNvkm+/rOKwlLsdXC81LTLKJLJjGXV5rwIgvs9Tc64Ylr1tQWtYd3CjpAIKH9bkeCoNwzJc7Qhx5IPFp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLOe74gS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715455165; x=1746991165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=10Sr8/r4vsQLBHs2eT8Nl5dyWcbWgKeqIXysLkPRiIA=;
  b=eLOe74gSCWnS3UmxJ3mMlYMWvP9YnlpS8l6jAVgMTnfZYK02sJTHut7W
   JSkQpevetCkEjRqi1qfBJERXJp+bfcjxpoYFsr21OKj5B0PsCu/KBXYYQ
   2JCkLu2WEzltHRv2zdt6vnPCzilofT8WJoCyVMR7ic95PUrAPs+t7MMzl
   Fbzzoy14ZEw8jAQcm0Xv18HLVgWdI8RlC1bc7oIYHMrp9fQ+AbQtghRk5
   wGekVDQiUXGYO3VtVNfc+f/vfYLY2aBaSHtnfASAYPwENUWbmyXlTytOd
   ezst0TAZmjuqRO+zv8eVIUrxVIkIqWxqFf6vdQNqUd2ExpS0q43ONvwTX
   Q==;
X-CSE-ConnectionGUID: p876ahm+TFi8HQlWLvCIaA==
X-CSE-MsgGUID: 85e6NXFKS7e/3IQiUmgjnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11285586"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="11285586"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 12:19:24 -0700
X-CSE-ConnectionGUID: nJLrBFAPTESYQUS/7keCKg==
X-CSE-MsgGUID: scCr+n+1QH+j+OT+k7ebsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="30342419"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 May 2024 12:19:22 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5sFa-0007l3-1N;
	Sat, 11 May 2024 19:19:18 +0000
Date: Sun, 12 May 2024 03:18:40 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de, swboyd@chromium.org,
	nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <202405120334.eHnXGJwn-lkp@intel.com>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240510-173839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: arc-randconfig-r133-20240512 (https://download.01.org/0day-ci/archive/20240512/202405120334.eHnXGJwn-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240512/202405120334.eHnXGJwn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405120334.eHnXGJwn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/proximity/hx9031as.c:1919:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] val @@     got signed int @@
   drivers/iio/proximity/hx9031as.c:1919:21: sparse:     expected restricted __be16 [usertype] val
   drivers/iio/proximity/hx9031as.c:1919:21: sparse:     got signed int
   drivers/iio/proximity/hx9031as.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +1919 drivers/iio/proximity/hx9031as.c

  1902	
  1903	static irqreturn_t hx9031as_trigger_handler(int irq, void *private)
  1904	{
  1905		struct iio_poll_func *pf = private;
  1906		struct iio_dev *indio_dev = pf->indio_dev;
  1907		struct hx9031as_data *data = iio_priv(indio_dev);
  1908		__be16 val;
  1909		int bit = 0;
  1910		int ii = 0;
  1911	
  1912		ENTER;
  1913		mutex_lock(&data->mutex);
  1914	
  1915		hx9031as_sample();
  1916		hx9031as_get_prox_state();
  1917	
  1918		for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
> 1919			val = hx9031as_pdata.diff[indio_dev->channels[bit].channel];
  1920			data->buffer.channels[ii++] = val;
  1921			PRINT_INF("bit=%d, ii=%d, val=%d\n", bit, ii - 1, val);
  1922		}
  1923	
  1924		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
  1925		mutex_unlock(&data->mutex);
  1926	
  1927		iio_trigger_notify_done(indio_dev->trig);
  1928		return IRQ_HANDLED;
  1929	}
  1930	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

