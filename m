Return-Path: <linux-iio+bounces-8510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157B953CF4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 23:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951B41F210B2
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEE15443F;
	Thu, 15 Aug 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mek/yeXC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1E1514C8;
	Thu, 15 Aug 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758872; cv=none; b=nX8jIrtwg7VHqrm9sQlhDf+Bqmup16zWOcNmjVTNBeBcnc8TVCZs1NpwF5LWqx721Dc7gyyOVX9l9mpnXs09zDXedKyJMAnkdY1vpMbKuitvTQBUwxwZuH/9XvjeF0Eum0TkwjVixWsCv6YDs8NKpVqG9vJoLGmqZH31t6Y8pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758872; c=relaxed/simple;
	bh=xlNK/PzNDYdGBjudfy2KDxXzSE1WFPFrx9O2eJpr+Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwVI/oqxQSFuqX3c12OjMxSwU3oho4pE/b4GbGW57yzsIACaHtlkbXUjcnO1CY7Bpq+2/kf9YyBW+IAwEBCq+5rD64mjqGRHLzPiCArvLDJFNh3141U63ro6VvQe+tMnpYGNCfAJ88y+Ey9biGpXlefDXjZ3wqwc8GkLSbs1YtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mek/yeXC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723758871; x=1755294871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xlNK/PzNDYdGBjudfy2KDxXzSE1WFPFrx9O2eJpr+Wk=;
  b=mek/yeXCliJ3/kn2IRRzamfaE8K+GZPWBxqrxhT0879BIN3wlxt0wSlb
   nf6Vz+Z/7pwruL0hgtAGDdex5Pk1bzZrc1qNqvOsgtoXSMmMdqINz9Yc2
   fPayo1Ka97amHL8LTYAOFJGSBtgYMtsAok76fj1Pjm8+40ZWk6VCMEzb+
   CTaXY0KO7VEY2CFTAQhxGqHaDOgLeK+24RCRSim7A3cJPtVp0Z0TUje1h
   5PWhSXLgGzjCpcbyMndmoP65c0g5n/U0luGZ5eIpxJOAmavM/bHb+90v+
   Xclrd1AqSJAT3rszZIHQJarISUBoFwF36UUrhm1nkZrxNvzDT+GoY+7ET
   w==;
X-CSE-ConnectionGUID: 139P8nRcTGqqR80Q22QVkg==
X-CSE-MsgGUID: yNK++Z92Qv+xl4lVbXR1cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="25842284"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="25842284"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 14:54:30 -0700
X-CSE-ConnectionGUID: t4E3BAXKQnKmvd6oZFAg7Q==
X-CSE-MsgGUID: eQTgYPX7S/qSFpIa20AkCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="97002030"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Aug 2024 14:54:27 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seiQK-0005fO-2L;
	Thu, 15 Aug 2024 21:54:24 +0000
Date: Fri, 16 Aug 2024 05:54:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: proximity: Add support for everlight pmd16d17
 sensor
Message-ID: <202408160542.UEjIkjkC-lkp@intel.com>
References: <abb0c1c0724be733138276f638e43e98784bd191.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb0c1c0724be733138276f638e43e98784bd191.1723527641.git.jan.kiszka@siemens.com>

Hi Jan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kiszka/dt-bindings-vendor-prefixes-Add-EVERLIGHT/20240814-234801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/abb0c1c0724be733138276f638e43e98784bd191.1723527641.git.jan.kiszka%40siemens.com
patch subject: [PATCH 3/3] iio: proximity: Add support for everlight pmd16d17 sensor
config: x86_64-randconfig-101-20240816 (https://download.01.org/0day-ci/archive/20240816/202408160542.UEjIkjkC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160542.UEjIkjkC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160542.UEjIkjkC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/proximity/pm16d17.c: In function 'pm16d17_chip_init':
>> drivers/iio/proximity/pm16d17.c:194:13: warning: argument 1 null where non-null expected [-Wnonnull]
     194 |         if (strcmp(conv_time, "0.4") == 0)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/tlbbatch.h:5,
                    from include/linux/mm_types_task.h:16,
                    from include/linux/sched.h:38,
                    from include/linux/delay.h:23,
                    from drivers/iio/proximity/pm16d17.c:11:
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:196:18: warning: argument 1 null where non-null expected [-Wnonnull]
     196 |         else if (strcmp(conv_time, "0.8") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:198:18: warning: argument 1 null where non-null expected [-Wnonnull]
     198 |         else if (strcmp(conv_time, "1.6") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:200:18: warning: argument 1 null where non-null expected [-Wnonnull]
     200 |         else if (strcmp(conv_time, "3.2") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:202:18: warning: argument 1 null where non-null expected [-Wnonnull]
     202 |         else if (strcmp(conv_time, "6.3") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:204:18: warning: argument 1 null where non-null expected [-Wnonnull]
     204 |         else if (strcmp(conv_time, "12.6") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:206:18: warning: argument 1 null where non-null expected [-Wnonnull]
     206 |         else if (strcmp(conv_time, "25.2") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:214:13: warning: argument 1 null where non-null expected [-Wnonnull]
     214 |         if (strcmp(wait_time, "12.5") == 0)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:216:18: warning: argument 1 null where non-null expected [-Wnonnull]
     216 |         else if (strcmp(wait_time, "25") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:218:18: warning: argument 1 null where non-null expected [-Wnonnull]
     218 |         else if (strcmp(wait_time, "50") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:220:18: warning: argument 1 null where non-null expected [-Wnonnull]
     220 |         else if (strcmp(wait_time, "100") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:222:18: warning: argument 1 null where non-null expected [-Wnonnull]
     222 |         else if (strcmp(wait_time, "200") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:224:18: warning: argument 1 null where non-null expected [-Wnonnull]
     224 |         else if (strcmp(wait_time, "400") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:226:18: warning: argument 1 null where non-null expected [-Wnonnull]
     226 |         else if (strcmp(wait_time, "800") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
   drivers/iio/proximity/pm16d17.c:228:18: warning: argument 1 null where non-null expected [-Wnonnull]
     228 |         else if (strcmp(wait_time, "1600") == 0)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:156:12: note: in a call to function 'strcmp' declared 'nonnull'
     156 | extern int strcmp(const char *,const char *);
         |            ^~~~~~


vim +194 drivers/iio/proximity/pm16d17.c

   152	
   153	static int pm16d17_chip_init(struct pm16d17_data *data)
   154	{
   155		struct i2c_client *client = data->client;
   156		struct device_node *np = client->dev.of_node;
   157		const char *conv_time = NULL;
   158		const char *wait_time = NULL;
   159		uint8_t op_mode_setting_val;
   160		uint32_t ps_offset_cancel;
   161		uint8_t offset_lsb;
   162		uint8_t offset_msb;
   163		uint32_t pulse_count;
   164		uint32_t pgain;
   165		unsigned int val;
   166		int ret;
   167	
   168		ret = pm16d17_read_reg(data, PM16D17_DEV_ID, &val);
   169	
   170		if (ret < 0 || (val != DEVICE_ID)) {
   171			dev_err(&client->dev, "Invalid chip id 0x%04x\n", val);
   172			return -ENODEV;
   173		}
   174	
   175		dev_dbg(&client->dev, "Detected PM16D17 with chip id: 0x%04x\n", val);
   176	
   177		ret = pm16d17_write_reg(data, PM16D17_OP_MODE, ENABLE_PS_FUNCTION);
   178		if (ret < 0)
   179			return ret;
   180	
   181		of_property_read_u32(np, "ps-gain", &pgain);
   182		switch (pgain) {
   183		case 1:
   184		case 2:
   185		case 4:
   186		case 8:
   187			op_mode_setting_val |= (ilog2(pgain) << 6) & PS_GAIN_MASK;
   188			break;
   189		default:
   190			break;
   191		}
   192	
   193		of_property_read_string(np, "ps-itime", &conv_time);
 > 194		if (strcmp(conv_time, "0.4") == 0)
   195			op_mode_setting_val |= PITIME_0_POINT_4_MS & PS_ITIME_MASK;
   196		else if (strcmp(conv_time, "0.8") == 0)
   197			op_mode_setting_val |= PITIME_0_POINT_8_MS & PS_ITIME_MASK;
   198		else if (strcmp(conv_time, "1.6") == 0)
   199			op_mode_setting_val |= PITIME_1_POINT_6_MS & PS_ITIME_MASK;
   200		else if (strcmp(conv_time, "3.2") == 0)
   201			op_mode_setting_val |= PITIME_3_POINT_2_MS & PS_ITIME_MASK;
   202		else if (strcmp(conv_time, "6.3") == 0)
   203			op_mode_setting_val |= PITIME_6_POINT_3_MS & PS_ITIME_MASK;
   204		else if (strcmp(conv_time, "12.6") == 0)
   205			op_mode_setting_val |= PITIME_12_POINT_6_MS & PS_ITIME_MASK;
   206		else if (strcmp(conv_time, "25.2") == 0)
   207			op_mode_setting_val |= PITIME_25_POINT_2_MS & PS_ITIME_MASK;
   208		else {
   209			dev_info(&client->dev, "Using default ps itime value\n");
   210			op_mode_setting_val |= PITIME_0_POINT_4_MS & PS_ITIME_MASK;
   211		}
   212	
   213		of_property_read_string(np, "ps-wtime", &wait_time);
   214		if (strcmp(wait_time, "12.5") == 0)
   215			op_mode_setting_val |= PWTIME_12_POINT_5_MS & PS_WTIME_MASK;
   216		else if (strcmp(wait_time, "25") == 0)
   217			op_mode_setting_val |= PWTIME_25_MS & PS_WTIME_MASK;
   218		else if (strcmp(wait_time, "50") == 0)
   219			op_mode_setting_val |= PWTIME_50_MS & PS_WTIME_MASK;
   220		else if (strcmp(wait_time, "100") == 0)
   221			op_mode_setting_val |= PWTIME_100_MS & PS_WTIME_MASK;
   222		else if (strcmp(wait_time, "200") == 0)
   223			op_mode_setting_val |= PWTIME_200_MS & PS_WTIME_MASK;
   224		else if (strcmp(wait_time, "400") == 0)
   225			op_mode_setting_val |= PWTIME_400_MS & PS_WTIME_MASK;
   226		else if (strcmp(wait_time, "800") == 0)
   227			op_mode_setting_val |= PWTIME_800_MS & PS_WTIME_MASK;
   228		else if (strcmp(wait_time, "1600") == 0)
   229			op_mode_setting_val |= PWTIME_1600_MS & PS_WTIME_MASK;
   230		else {
   231			dev_info(&client->dev, "Using default ps wtime value\n");
   232			op_mode_setting_val |= PWTIME_12_POINT_5_MS & PS_WTIME_MASK;
   233		}
   234	
   235		ret = pm16d17_write_reg(data, PM16D17_PS_SETTING, op_mode_setting_val);
   236		if (ret < 0)
   237			return ret;
   238	
   239		of_property_read_u32(np, "ps-ir-led-pulse-count", &pulse_count);
   240		if (pulse_count > 256)
   241			pulse_count = 256;
   242		ret = pm16d17_write_reg(data, PM16D17_VCSEL_DRIVE_PULSE, pulse_count - 1);
   243		if (ret < 0)
   244			return ret;
   245	
   246		of_property_read_u32(np, "ps-offset-cancel", &ps_offset_cancel);
   247		if (ps_offset_cancel != 0) {
   248			ret = pm16d17_write_reg(data, PM16D17_PS_SETTING2, OFFSET_CANCEL_ENABLE);
   249			if (ret < 0)
   250				return ret;
   251	
   252			offset_lsb = ps_offset_cancel & PS_OFFSET_CANCEL_LSB_MASK;
   253			offset_msb = (ps_offset_cancel & PS_OFFSET_CANCEL_MSB_MASK) >> 8;
   254	
   255			ret = pm16d17_write_reg(data, PM16D17_PS_OFFSET_CANCEL_L, offset_lsb);
   256			if (ret < 0)
   257				return ret;
   258	
   259			ret = pm16d17_write_reg(data, PM16D17_PS_OFFSET_CANCEL_H, offset_msb);
   260			if (ret < 0)
   261				return ret;
   262		}
   263	
   264		return 0;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

