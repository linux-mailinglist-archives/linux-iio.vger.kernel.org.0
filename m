Return-Path: <linux-iio+bounces-4971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45A8C3333
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3374B20FE2
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7420CE57D;
	Sat, 11 May 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qp1uz5Tw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB228E8;
	Sat, 11 May 2024 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715452645; cv=none; b=QoqyIWvA3T569OARyllsZK7+rlvOa9L/YFUN9Q+tANN2GwVql9OkteAueZdTA+9sAqobFaxpcjyFtWN9ywv/eDUjkPJg3C8Wdn0RJRGKzHldvNVON3zoXQNuIdmxxS3xWEReLTnBy6hcrZjeOAaHzBK9cehCgexMSeA0ThIf5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715452645; c=relaxed/simple;
	bh=jz3xzOFL3a+eek1BV5fALhmy/iesismdICnAeMLying=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqwJe37//8rWRkj3ZZ15JBYS9XN3nQws2B7U/Qk9568dyJUPwA1L3fNnjqs25AuJmp2N2NwRGzgGJgZPmsaeYg9yJtvidfzqR3sD9ZQ/8EXX1C6komTQBS3L+RIad7Gn8DHHVHQv4GVsLibcS698KV+yXUfEWSRlhLHRYmQ79zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qp1uz5Tw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715452643; x=1746988643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jz3xzOFL3a+eek1BV5fALhmy/iesismdICnAeMLying=;
  b=Qp1uz5TwOrBYtRfSNNZtYrFZYnjdSWzfexCxCIETHMroA3JirQlVPoW/
   nqaG3+m33gpqO2Ab5afXO/XHIYhaoQQe54DCKQE4OgHOmAtJ+neEUSu/r
   sRzjrs6vNa9ekXCF2V94b0R+cqGXnQLvOgjdqrd8+GMviiQhVdoBD42lV
   3ea365G61NFRcwEosnOHeHKxnPzAf3HD4IoLIaaxTqc3q6cGbbIk+wmuP
   h/8zacOR87g5nvDiKNDhQDxVFfHBrOrgd8Ly7oCNxZJ/aAaBvBOMJqHgp
   hHpkezagvd4Wib9PVc6hVcpTwwDWWOS3Z6GItN2WDQRQge+0DM6W2J4+B
   A==;
X-CSE-ConnectionGUID: p+ltM+giTMiVvQIfsn2SRw==
X-CSE-MsgGUID: Gj7pG1u3RU6ssIpv0t2vSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11371023"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="11371023"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 11:37:23 -0700
X-CSE-ConnectionGUID: vChuxWkwQ/+JrbMH2n26EQ==
X-CSE-MsgGUID: eRAVvIylTG+F8NwOhvFnEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="34479141"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2024 11:37:20 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5rav-0007j9-1W;
	Sat, 11 May 2024 18:37:17 +0000
Date: Sun, 12 May 2024 02:36:30 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de, swboyd@chromium.org,
	nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <202405120249.yMpobA26-lkp@intel.com>
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
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20240512/202405120249.yMpobA26-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240512/202405120249.yMpobA26-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405120249.yMpobA26-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/proximity/hx9031as.c: In function 'hx9031as_dump_show':
>> drivers/iio/proximity/hx9031as.c:1497:1: warning: the frame size of 1044 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1497 | }
         | ^


vim +1497 drivers/iio/proximity/hx9031as.c

  1477	
  1478	static ssize_t hx9031as_dump_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
  1479	{
  1480		int ret = -1;
  1481		uint8_t rx_buf[1] = {0};
  1482		char buf[BUF_SIZE * 2] = {0};
  1483		char *p = buf;
  1484		int ii = 0;
  1485	
  1486		for (ii = 0; ii < ARRAY_SIZE(hx9031as_reg_init_list); ii++) {
  1487			ret = hx9031as_read(hx9031as_reg_init_list[ii].addr, rx_buf, 1);
  1488			if (ret != 0)
  1489				PRINT_ERR("hx9031as_read failed\n");
  1490			PRINT_INF("0x%02X=0x%02X\n", hx9031as_reg_init_list[ii].addr, rx_buf[0]);
  1491			p += snprintf(p, PAGE_SIZE, "0x%02X=0x%02X\n", hx9031as_reg_init_list[ii].addr, rx_buf[0]);
  1492		}
  1493	
  1494		p += snprintf(p, PAGE_SIZE, "driver version:%s\n", HX9031AS_DRIVER_VER);
  1495	
  1496		return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
> 1497	}
  1498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

