Return-Path: <linux-iio+bounces-6345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321990AD0D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DD1C22326
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39077194AD4;
	Mon, 17 Jun 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bELuhYh7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186C9191461;
	Mon, 17 Jun 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624090; cv=none; b=VIUxJ54R9CntAMouKc+I+MEumJJq0t5CKmsWglIG/AVAaQyVGGsZFvnaS5Gz6yF8I2wn/Dk4U8D0ImSLYnbHZtYdq8mt5C8GCvhnAPYnj5DkBZ78eeyGgJFeefBo7C1t6GYu2hf5mwrYNEwjl2cynjlkUQ4DlZekDrPLhHYjFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624090; c=relaxed/simple;
	bh=0jId0a55uaWiJleIvuFAp7uQffIjPdI/Ww2Wmybckx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL9tPIfe7GuLK0ebsQCprg3PcTF9GlKcKONjkwmt62OkE5ocFRUY0MDgCPr0/3lGoF9vS4rmFw8h/oRw7dCWcvyEY14E8rRWdK9zGz4Ba24mBDktV2IStlabbUCZ1s7HiWlTVDsra6F1zaoypbGTif5hw5477xcoHtJZ1x0LG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bELuhYh7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718624088; x=1750160088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jId0a55uaWiJleIvuFAp7uQffIjPdI/Ww2Wmybckx8=;
  b=bELuhYh7XykUM0BiQF9UDGrfnbCZ6Lzs559ctU42KfI1u1R/k9ktGImi
   E5Z8hmXyUMiIrtEOtbl75VROgOoKnPH+ihhyHtYy3b2W8WDLhnk3xx1UZ
   ZvZJW7NaB0ushr6ilq7fESgacTX+YyRqtAw/9sV0rm4fyagsoLxFYMcqA
   iZzcjj93kJxXc4kWhNLMBfBklcfQWA7F18ILb3Em+hQ/Nmb3HhP8WtoNa
   645KHz1N6HF5UmO1sUl65XoeDFvJkKBfqxoGFaf7ugbRGgSuA5rYgSuRn
   h7FisD4Jpb8fY7rVm6QkPekFeUFMxklF3JQC5qO93bBIF0TkVwdoZ/mpJ
   A==;
X-CSE-ConnectionGUID: AHV2rNPcQaixJuof2THFqg==
X-CSE-MsgGUID: Jif929qLSimskTX1+cSEmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15411182"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15411182"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 04:34:47 -0700
X-CSE-ConnectionGUID: E2+bi//pTLy/iZHHsXQ5NA==
X-CSE-MsgGUID: 5FEHokIsRdCLQF89Jyr7oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45698928"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jun 2024 04:34:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJAdG-0004ET-29;
	Mon, 17 Jun 2024 11:34:42 +0000
Date: Mon, 17 Jun 2024 19:34:30 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Yasin Lee <yasin.lee.x@gmail.com>
Subject: Re: [PATCH v5 3/3] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <202406171946.qe83Tde0-lkp@intel.com>
References: <SN7PR12MB8101D4BC788B5954608D677DA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101D4BC788B5954608D677DA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.10-rc4 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/dt-bindings-iio-proximity-Add-hx9023s-binding/20240616-154122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101D4BC788B5954608D677DA4CC2%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH v5 3/3] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
config: arm64-randconfig-r132-20240617 (https://download.01.org/0day-ci/archive/20240617/202406171946.qe83Tde0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240617/202406171946.qe83Tde0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406171946.qe83Tde0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/proximity/hx9023s.c:955:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 @@     got int diff @@
   drivers/iio/proximity/hx9023s.c:955:44: sparse:     expected restricted __be16
   drivers/iio/proximity/hx9023s.c:955:44: sparse:     got int diff

vim +955 drivers/iio/proximity/hx9023s.c

   931	
   932	static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
   933	{
   934		struct iio_poll_func *pf = private;
   935		struct iio_dev *indio_dev = pf->indio_dev;
   936		struct hx9023s_data *data = iio_priv(indio_dev);
   937		struct device *dev = regmap_get_device(data->regmap);
   938		int ret;
   939		unsigned int bit, i = 0;
   940	
   941		guard(mutex)(&data->mutex);
   942		ret = hx9023s_sample(data);
   943		if (ret) {
   944			dev_warn(dev, "sampling failed\n");
   945			goto out;
   946		}
   947	
   948		ret = hx9023s_get_prox_state(data);
   949		if (ret) {
   950			dev_warn(dev, "get prox failed\n");
   951			goto out;
   952		}
   953	
   954		for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
 > 955			data->buffer.channels[i++] = data->ch_data[indio_dev->channels[bit].channel].diff;
   956	
   957		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
   958	
   959	out:
   960		iio_trigger_notify_done(indio_dev->trig);
   961	
   962		return IRQ_HANDLED;
   963	}
   964	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

