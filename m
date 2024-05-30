Return-Path: <linux-iio+bounces-5475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05938D42AE
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 03:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37A21C214C4
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 01:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBAEE56C;
	Thu, 30 May 2024 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSVYgwBJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80748F4E2;
	Thu, 30 May 2024 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031266; cv=none; b=u/yPymtufU7qjx7GAvh1dOuvFtVLzByfCR4JbxvootHhl/tCdODL/Jqo9L+qrhJYK492qX64UGxLJk1uNknXFjTuTNTThIi6kv7NEOZF/p7pFKeAoyh8ls6I42+rJZvCehbR6mOt+2rDfF10vYsmrXYlI0sTVmfDF/rS0c87vUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031266; c=relaxed/simple;
	bh=DJmoYBOGcoVNLMBEvrCcota/ugc5wL4TTlwryI1YZpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWSsgpM99Cx4z6VAbv/0F9YEy++RWe6waFN9IXKbGCk+4lpAnPsaDRSbLWIyRNX86NUrTJpWEPBHYCHxVQ1VSYC+nzGAhd+YQP+ONPA1/fdryZvC1rAzS+NcpO9PyMqJ7PHgInUq19AMGzLdf6fR6Y3lEkjNv+d0irUExx13QU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSVYgwBJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717031265; x=1748567265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DJmoYBOGcoVNLMBEvrCcota/ugc5wL4TTlwryI1YZpw=;
  b=TSVYgwBJfeyV2mVxCQUv1TRizFDQ6s2ZR2GyIWW0nfMy8EmkEoTatF4o
   rqYu4GEY9yHq6oNfOcLNZ8ikfME9BUc76IHEn7WIVaoJtRAVWja/kyC6r
   5Wd3LFG2g9yxWCSVNBKYhXJsGVo5rDDm09KgqftOboK3MA+DqJK7fyTG5
   Oz94Y1353L5sMA0iiHF4cywZ2+k85BnESki9+mUkORTeU+TOiK2Q6U7Xi
   3pd8ST7VGcOU1QgzKri/x2Jg5emngTsfxKrzjMXGcvbLJ94OxccBMWFZV
   3dcIb3ho85vyUp4uY/jPq7eQP8GF2bwQA+ugurBgli3apGSNgxJY2yS3b
   g==;
X-CSE-ConnectionGUID: KSHZLvxrSoue6FU+CIxsjA==
X-CSE-MsgGUID: 5gnSS4LaTEeVnARUqXbd7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24894762"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24894762"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:07:41 -0700
X-CSE-ConnectionGUID: cvEuSgAhSLKkjZZE3aipcw==
X-CSE-MsgGUID: vg6zkNkiQB+cW9xJ4m4Yyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="73089446"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 May 2024 18:07:39 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCUGV-000EOl-34;
	Thu, 30 May 2024 01:07:35 +0000
Date: Thu, 30 May 2024 09:06:52 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy.shevchenko@gmail.com,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.a@analog.com,
	swboyd@chromium.org, u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com, yasin.lee.x@outlook.com
Subject: Re: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <202405300812.jv99FywV-lkp@intel.com>
References: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9023s-Add-TYHX-HX9023S-sensor-driver/20240529-170307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB81019AB7F38806097F2C8A34A4F22%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
config: x86_64-randconfig-r113-20240530 (https://download.01.org/0day-ci/archive/20240530/202405300812.jv99FywV-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405300812.jv99FywV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405300812.jv99FywV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/proximity/hx9023s.c:1242:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 @@     got int @@
   drivers/iio/proximity/hx9023s.c:1242:44: sparse:     expected restricted __be16
   drivers/iio/proximity/hx9023s.c:1242:44: sparse:     got int

vim +1242 drivers/iio/proximity/hx9023s.c

  1228	
  1229	static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
  1230	{
  1231		struct iio_poll_func *pf = private;
  1232		struct iio_dev *indio_dev = pf->indio_dev;
  1233		struct hx9023s_data *data = iio_priv(indio_dev);
  1234		int bit;
  1235		int i = 0;
  1236	
  1237		guard(mutex)(&data->mutex);
  1238		hx9023s_sample(data);
  1239		hx9023s_get_prox_state(data);
  1240	
  1241		for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
> 1242			data->buffer.channels[i++] = data->diff[indio_dev->channels[bit].channel];
  1243	
  1244		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
  1245	
  1246		iio_trigger_notify_done(indio_dev->trig);
  1247		return IRQ_HANDLED;
  1248	}
  1249	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

