Return-Path: <linux-iio+bounces-7717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC093802F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B18AB2111C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094829CFE;
	Sat, 20 Jul 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLxixCzt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C622F14;
	Sat, 20 Jul 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467210; cv=none; b=R/sFvk3whNxUe7/mKJBy9ot7KKhMNxny87lbKNVMXmVwgtdRqFOqTL4fn+E2LNFwpg4urO6VcSW/ISSah/LuZ7RW3/kpfCjWp+rdn/ejCOWhcsqNeDCwXRbkrRNSHXUXhTTll9ppeJPwhWWOCZ5GQtkJsdH9AzLvgjGpUKrV0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467210; c=relaxed/simple;
	bh=aXf0RhYpLwGl1ZpQsVRJ9rreF9cvCbgkrqqIYoZ7O5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmavjY0oNbkvdPjKGgIhF0Kjaj8hq0CyW4fSAc1DTqL541VMJuga/3L/676/huLszr2aEi7TbgG8W1GxyDrCM5PU6F5sG8J2p7h3lV6IRluDb3BwC+2kTFO+OtvI2mTVCSbdkufknr74YWcVOeHSxOAi0vgJeU5yC+NM2MT1RCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLxixCzt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721467209; x=1753003209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXf0RhYpLwGl1ZpQsVRJ9rreF9cvCbgkrqqIYoZ7O5Y=;
  b=fLxixCztyMD9w4BXcsHCVCkYAKQ33rBFWhLeRdnWobgdS9HO1Bv6i5ne
   re9XpiGdD8cmnusTyCgYGhFvOdNZHy86ad1/na7+zNVLNZfRTrl6Qgtzg
   m51Spqg8jlisAl3ymwlOfxD9RULMDn4l150lVpeWHFazPm6oKgSvFs0SL
   BSic6LMKweDIUUua0AELDEC/wOGS8sM358wTf8cEahm98h1TpAEqsAvUx
   GVO5zoZWQxRtsRGkuqKsGjrTEkPUSIucL+yyx0+j3sz+o885BtYr7qY9s
   rpctcB3EFbcYXTStEc0AxBv/5M/bDw0xmg7pruBSPBy4Y38jxspvklweb
   A==;
X-CSE-ConnectionGUID: QWF25M8ySMSmyvMVIYREaQ==
X-CSE-MsgGUID: 4/Fk0t5FQOSq+CHUBGjSzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="19222250"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="19222250"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 02:20:08 -0700
X-CSE-ConnectionGUID: yNJE7YUMRpCngUiVF5Hzxw==
X-CSE-MsgGUID: IQjQqnNGT4SONSZt/20sDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="74586696"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jul 2024 02:20:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sV6G3-000j3x-09;
	Sat, 20 Jul 2024 09:20:03 +0000
Date: Sat, 20 Jul 2024 17:19:42 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: humidity: Add support for ENS210
Message-ID: <202407201602.KrJ889wu-lkp@intel.com>
References: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>

Hi Joshua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1ebab783647a9e3bf357002d5c4ff060c8474a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Felmeden/dt-bindings-iio-humidity-add-ENS210-sensor-family/20240719-210648
base:   1ebab783647a9e3bf357002d5c4ff060c8474a0a
patch link:    https://lore.kernel.org/r/20240719-ens21x-v4-2-6044e48a376a%40thegoodpenguin.co.uk
patch subject: [PATCH v4 2/2] iio: humidity: Add support for ENS210
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240720/202407201602.KrJ889wu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407201602.KrJ889wu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407201602.KrJ889wu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/humidity/ens210.c:19:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/humidity/ens210.c:252:4: warning: format specifies type 'unsigned long' but the argument has underlying type 'unsigned int' [-Wformat]
     251 |                         "Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
         |                                                              ~~~~~
         |                                                              %04x
     252 |                         data->chip_info->part_id);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:160:67: note: expanded from macro 'dev_info'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/iio/humidity/ens210.c:200:30: warning: unused variable 'id' [-Wunused-variable]
     200 |         const struct i2c_device_id *id = i2c_client_get_device_id(client);
         |                                     ^~
   7 warnings generated.


vim +252 drivers/iio/humidity/ens210.c

   197	
   198	static int ens210_probe(struct i2c_client *client)
   199	{
   200		const struct i2c_device_id *id = i2c_client_get_device_id(client);
   201		struct ens210_data *data;
   202		struct iio_dev *indio_dev;
   203		uint16_t part_id;
   204		int ret;
   205	
   206		if (!i2c_check_functionality(client->adapter,
   207				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
   208				I2C_FUNC_SMBUS_WRITE_BYTE |
   209				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
   210			dev_err_probe(&client->dev, -EOPNOTSUPP,
   211				"adapter does not support some i2c transactions\n");
   212			return -EOPNOTSUPP;
   213		}
   214	
   215		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
   216		if (!indio_dev)
   217			return -ENOMEM;
   218	
   219		data = iio_priv(indio_dev);
   220		i2c_set_clientdata(client, indio_dev);
   221		data->client = client;
   222		mutex_init(&data->lock);
   223		data->chip_info = i2c_get_match_data(client);
   224	
   225		ret = devm_regulator_get_enable(&client->dev, "vdd");
   226		if (ret)
   227			return ret;
   228	
   229		/* reset device */
   230		ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
   231						ENS210_SYS_CTRL_SYS_RESET);
   232		if (ret)
   233			return ret;
   234	
   235		/* wait for device to become active */
   236		usleep_range(4000, 5000);
   237	
   238		/* disable low power mode */
   239		ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL, 0x00);
   240		if (ret)
   241			return ret;
   242	
   243		/* wait for device to finish */
   244		usleep_range(4000, 5000);
   245	
   246		/* get part_id */
   247		part_id = i2c_smbus_read_word_data(client, ENS210_REG_PART_ID);
   248	
   249		if (part_id != data->chip_info->part_id) {
   250			dev_info(&client->dev,
   251				"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
 > 252				data->chip_info->part_id);
   253		}
   254	
   255		/* reenable low power */
   256		ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
   257						ENS210_SYS_CTRL_LOW_POWER_ENABLE);
   258		if (ret)
   259			return ret;
   260	
   261		indio_dev->name = data->chip_info->name;
   262		indio_dev->modes = INDIO_DIRECT_MODE;
   263		indio_dev->channels = ens210_channels;
   264		indio_dev->num_channels = ARRAY_SIZE(ens210_channels);
   265		indio_dev->info = &ens210_info;
   266	
   267		return devm_iio_device_register(&client->dev, indio_dev);
   268	}
   269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

