Return-Path: <linux-iio+bounces-8483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F264B95290E
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BB61F2342C
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C8176AB7;
	Thu, 15 Aug 2024 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+W9R8F9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0814373B;
	Thu, 15 Aug 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701125; cv=none; b=MPMEJOSasge3sXZtUSlRJFTJqfYDoe44xSLH5qZC9ix0OyHOEq18gKPjU8OLOkLFLQSWLGJS4L7X0bga9kH/4xb0FRNIwQqMv9uj1ZX7VPIPcywnbn2tO8M4evljvAaBbnp4fJXytzcPSluyZXhSjvYAy0TRmu7+k3SYmG1WUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701125; c=relaxed/simple;
	bh=MQR+GReeIVWHV3GGNyHTT7zvvVhdqZnBBoe0MuH7tOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXgmPWCtwf5RYUk11zZkPqHaKybkv/E9yoZeq8ytl2T/AY705qQ6i0xfVrlPGnTlT4Vo+5lb9zN3oWxXQyd9IveBpBdeW+BZViykZ0AvKE1I9ZzUtZ8EDHXgp49LHlTAWGPjF14/QXmDmeikECD/5dbo265uNUmYHUkhP4kfLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+W9R8F9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723701123; x=1755237123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQR+GReeIVWHV3GGNyHTT7zvvVhdqZnBBoe0MuH7tOc=;
  b=l+W9R8F9vvhIZM+J9S2swREXG8vW/OouICswbpme8TSER28SlMXdMbX5
   WShJwaPlo4FN9NbC0i9ZuZCjVlG2aukecXpCySAv4/QsnDnTJCmeQKlY+
   d41iEGnSFBXGnRfI+dW5Dife5rMXJoklMRKRtjWN+dVW+H9a5yTMhG2gC
   eM9W/LY59nRZkmCV3U7Ca2u5JKDwP0PB97c4m5a7j/CXj6NsMREowinuw
   Ip7McylqVu3idlrP3KrkLNjvWVJ3YAaL7pi6D/9TltBHggmCg4zw82nIi
   M2aO/gsT8dT33VqVNRRXuVT503QnLPjU2k6akf+8ygs8iYGpgd07i2Oin
   g==;
X-CSE-ConnectionGUID: qYqix1WGTHSX0arcX1/wVw==
X-CSE-MsgGUID: osgOJq5TQiWPNXl3ijgqIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="47349330"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="47349330"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 22:52:02 -0700
X-CSE-ConnectionGUID: W0sE2WX4S1mmpY6va6H1lw==
X-CSE-MsgGUID: n9Xn6A/pTHqs5l++08/Xyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="96773518"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Aug 2024 22:51:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seTOt-0003Ez-2r;
	Thu, 15 Aug 2024 05:51:55 +0000
Date: Thu, 15 Aug 2024 13:51:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: proximity: Add support for everlight pmd16d17
 sensor
Message-ID: <202408151352.u8v6HOIQ-lkp@intel.com>
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
[also build test WARNING on robh/for-next linus/master v6.11-rc3 next-20240814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kiszka/dt-bindings-vendor-prefixes-Add-EVERLIGHT/20240814-234801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/abb0c1c0724be733138276f638e43e98784bd191.1723527641.git.jan.kiszka%40siemens.com
patch subject: [PATCH 3/3] iio: proximity: Add support for everlight pmd16d17 sensor
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240815/202408151352.u8v6HOIQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151352.u8v6HOIQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151352.u8v6HOIQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/proximity/pm16d17.c:142:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     142 |         default:
         |         ^
   drivers/iio/proximity/pm16d17.c:142:2: note: insert 'break;' to avoid fall-through
     142 |         default:
         |         ^
         |         break; 
>> drivers/iio/proximity/pm16d17.c:187:3: warning: variable 'op_mode_setting_val' is uninitialized when used here [-Wuninitialized]
     187 |                 op_mode_setting_val |= (ilog2(pgain) << 6) & PS_GAIN_MASK;
         |                 ^~~~~~~~~~~~~~~~~~~
   drivers/iio/proximity/pm16d17.c:159:29: note: initialize the variable 'op_mode_setting_val' to silence this warning
     159 |         uint8_t op_mode_setting_val;
         |                                    ^
         |                                     = '\0'
   2 warnings generated.


vim +142 drivers/iio/proximity/pm16d17.c

   109	
   110	static int pm16d17_read_raw(struct iio_dev *indio_dev,
   111				    struct iio_chan_spec const *chan,
   112				    int *val, int *val2, long mask)
   113	{
   114		struct pm16d17_data *data = iio_priv(indio_dev);
   115		unsigned int ps_data_l;
   116		unsigned int ps_data_h;
   117		uint16_t ps_data;
   118		int ret = -EINVAL;
   119	
   120		switch (mask) {
   121		case IIO_CHAN_INFO_RAW:
   122			switch (chan->type) {
   123			case IIO_PROXIMITY:
   124				ret = pm16d17_read_reg(data, PM16D17_PS_DATA_L, &ps_data_l);
   125				if (ret < 0)
   126					return ret;
   127	
   128				ret = pm16d17_read_reg(data, PM16D17_PS_DATA_H, &ps_data_h);
   129				if (ret < 0)
   130					return ret;
   131	
   132				ps_data = (ps_data_h << 8) | ps_data_l;
   133	
   134				dev_dbg(&data->client->dev, "PS data: %x\n", ps_data);
   135	
   136				*val = ps_data;
   137				ret = IIO_VAL_INT;
   138				break;
   139			default:
   140				break;
   141			}
 > 142		default:
   143			break;
   144		}
   145	
   146		return ret;
   147	}
   148	
   149	static const struct iio_info pm16d17_info = {
   150		.read_raw = pm16d17_read_raw,
   151	};
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
 > 187			op_mode_setting_val |= (ilog2(pgain) << 6) & PS_GAIN_MASK;
   188			break;
   189		default:
   190			break;
   191		}
   192	
   193		of_property_read_string(np, "ps-itime", &conv_time);
   194		if (strcmp(conv_time, "0.4") == 0)
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

