Return-Path: <linux-iio+bounces-6040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E479900F4F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 05:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7377B2378B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 03:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B784FD51D;
	Sat,  8 Jun 2024 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1qFFM8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D8BE58;
	Sat,  8 Jun 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717816808; cv=none; b=Cd4rt30nIJNjbVWPs2sbKPROw7+kVyt+ZNFp1QlrYHzbLUv0wflMtbjmc01swki1ku0uCUcR5tOi/c7aZ+Nnq4LU1P4vZcwXbqjdT4MIr5p9k87kKPGtQtRC2nDK68QNesA3oUpXliXARWrk6dMJihfRgrS9fcZP2W2GPdLV7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717816808; c=relaxed/simple;
	bh=N/QluFsTPdH4ayiBRNRvi3l+pA83DLYnSdfF/2R5R6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZX8d9X7gAcH49dHzRyi4rk0YxzvOaN9JBtgE12OOfXzS1D+vBeS5tg+rYjGKRbEgY3YH1JfDcD7c0NUsl1M6BzEb7tq0eD/P3BtM+diWv2z5slyfnOeJhDtYvM2XnqvRzHwBivE0WGc8GIQ1nOxyN6EUWeuGs7TwuWKaRdaUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1qFFM8B; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717816807; x=1749352807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/QluFsTPdH4ayiBRNRvi3l+pA83DLYnSdfF/2R5R6o=;
  b=C1qFFM8BYpUEkBtPeZJpDVrwxawCoLUQwbkQhl1n4vfl9JhSr/gOzW9f
   AgdymqRlaAfdjNZgU2zQfwTruJjhLqWw7WwwrcwREWML89hws/MsLTNj5
   xZJBFJ6u+561svetTcyn3woFvYW7brTxVPDW6CfZCbPnO6zXniorWFx45
   YyjS0TWqWUqMbUlY8zy6QxVTAb7wZvdS9/YJtQa0125L9dfMWZQmP2/wg
   gTcZKzPdxJ3MNRWaGF18pG7et4qFt1HLDCJ8RhmP7q4/Fy5x25CZW4esw
   I/vTM+TsNfyxeYn6sDtvC9Ee+V6G+nmqlMnbvx6OqtPY3dMUB2eixNpMV
   A==;
X-CSE-ConnectionGUID: JNDtfm+jRo2WW27boKXK7Q==
X-CSE-MsgGUID: LrZJ6gM7TRqwWAZGtJLtcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25958582"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="25958582"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:20:06 -0700
X-CSE-ConnectionGUID: 6bfyl3EAQpKRc9QPgfPO4A==
X-CSE-MsgGUID: hte8po7PTFa71It/m8pO9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="38597428"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Jun 2024 20:20:02 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFmcZ-0000uA-2K;
	Sat, 08 Jun 2024 03:19:59 +0000
Date: Sat, 8 Jun 2024 11:19:10 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andy.shevchenko@gmail.com, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.a@analog.com, swboyd@chromium.org,
	u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <202406081148.j9y5W5Ru-lkp@intel.com>
References: <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9023s-Add-TYHX-HX9023S-sensor-driver/20240607-194446
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240608/202406081148.j9y5W5Ru-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081148.j9y5W5Ru-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081148.j9y5W5Ru-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/proximity/hx9023s.c:666:58: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
     666 |                                         "Failed to read channel-positive for channel %d\n", i);
         |                                                                                             ^
   drivers/iio/proximity/hx9023s.c:652:12: note: initialize the variable 'i' to silence this warning
     652 |         int ret, i;
         |                   ^
         |                    = 0
   drivers/iio/proximity/hx9023s.c:976:25: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
     976 |                 data->buffer.channels[i++] =
         |                                       ^
   drivers/iio/proximity/hx9023s.c:969:7: note: initialize the variable 'i' to silence this warning
     969 |         int i;
         |              ^
         |               = 0
   2 warnings generated.


vim +/i +666 drivers/iio/proximity/hx9023s.c

   649	
   650	static int hx9023s_property_get(struct hx9023s_data *data)
   651	{
   652		int ret, i;
   653		u32 temp;
   654		struct fwnode_handle *child;
   655		struct device *dev = regmap_get_device(data->regmap);
   656	
   657		ret = device_property_read_u32(dev, "channel-in-use", &temp);
   658		if (ret)
   659			return dev_err_probe(dev, ret, "Failed to read channel-in-use property\n");
   660		data->chan_in_use = temp;
   661	
   662		device_for_each_child_node(dev, child) {
   663			ret = fwnode_property_read_u32(child, "channel-positive", &temp);
   664			if (ret)
   665				return dev_err_probe(dev, ret,
 > 666						"Failed to read channel-positive for channel %d\n", i);
   667			data->ch_data[i].channel_positive = temp;
   668	
   669			ret = fwnode_property_read_u32(child, "channel-negative", &temp);
   670			if (ret)
   671				return dev_err_probe(dev, ret,
   672						"Failed to read channel-negative for channel %d\n", i);
   673			data->ch_data[i].channel_negative = temp;
   674	
   675			i++;
   676		}
   677	
   678		return 0;
   679	}
   680	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

