Return-Path: <linux-iio+bounces-11944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6079BE953
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 13:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7312852E8
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CC1DFD89;
	Wed,  6 Nov 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7ksSaeb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C237DA7F;
	Wed,  6 Nov 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896378; cv=none; b=GO50F8QGUuunLXmjSnlfMrsA64t/pPXVuGk7+VYH4TtehIarlui37N1H575LXWre214cC6KMedoxHCnQjVgc1zd0imKQrT9+kCweBqKDTXIBwKQcarVDQW0vcP+/ICRBkN21pV7PJK9/ZTXgksT3ax/k3C6pWMr+wy6qmgdiCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896378; c=relaxed/simple;
	bh=pAaxQ9Gjz6nuJzTKxrooqmYKq2ChzragGuK0hhgnAHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBrGFTCBAIcNRA9Kt214w9qH7jFbUd3MN3sKf1EwozeRGgcu93rAywo1ErmY+qgAz0KHOzFRqEmFUWWYb+nPc58qYj6/itLvOQwUBakhos+YAl96dNgwM06x5Zj+3DToDgMofeUMnQScICKG6Po7loDGVKUoumZ+qCsFl5h7uB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7ksSaeb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730896375; x=1762432375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pAaxQ9Gjz6nuJzTKxrooqmYKq2ChzragGuK0hhgnAHs=;
  b=j7ksSaebWgX3MiCldODAM+8bM9EMsCy3R3XWhZqQspIL4TApE45d48TD
   WUcnIx9NXIBWZOKMJo4THl9Y8kzdI4VT+pMW/pn9pEK2eOOxOi9ScjY7z
   dA2QuZhcjR9MP9fPZ0RP/9sbqB5vjojmIi7AQZ9U/WUllswh8Twt/CqIV
   faPbY0ds1sD2L9n+a5TuOjxwZXt4/m5y25zs6vaEF/AHjNw1IvpEv2idm
   2gTXoAObQaM0lxrJ5UUVoL8LlTgrdUyE+CeKimH0gftxogeylKFaS1vQa
   3tAObnG/yloKR/IHTzAchmwC8a9bzHVLY279w1Eh6OmQmO721qerM6i6N
   w==;
X-CSE-ConnectionGUID: E/kJA+E4Ql2XiRTyHXkW2A==
X-CSE-MsgGUID: VRRCFjjLRC+jKeJjFxTz5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30796860"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="30796860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 04:32:54 -0800
X-CSE-ConnectionGUID: K2WuBYXxT2Oz0PvRjM0onQ==
X-CSE-MsgGUID: OehlV23PTxyEfmktAHBvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="122042036"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2024 04:31:34 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8fC7-000neY-2J;
	Wed, 06 Nov 2024 12:31:31 +0000
Date: Wed, 6 Nov 2024 20:30:54 +0800
From: kernel test robot <lkp@intel.com>
To: Eason Yang <j2anfernee@gmail.com>, avifishman70@gmail.com,
	tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
	yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com, andy@kernel.org,
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com,
	alisadariana@gmail.com, joao.goncalves@toradex.com,
	marius.cristea@microchip.com, mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <202411062051.TLRkJSSL-lkp@intel.com>
References: <20241106023916.440767-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106023916.440767-3-j2anfernee@gmail.com>

Hi Eason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc6 next-20241106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eason-Yang/dt-bindings-iio-adc-Add-binding-for-Nuvoton-NCT720x-ADCs/20241106-104046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241106023916.440767-3-j2anfernee%40gmail.com
patch subject: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241106/202411062051.TLRkJSSL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411062051.TLRkJSSL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411062051.TLRkJSSL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/nct720x.c:9:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/nct720x.c:526:16: warning: cast to smaller integer type 'enum nct720x_chips' from 'const void *' [-Wvoid-pointer-to-enum-cast]
     526 |                 chip->type = (enum nct720x_chips)device_get_match_data(&client->dev);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   5 warnings generated.


vim +526 drivers/iio/adc/nct720x.c

   511	
   512	static int nct720x_probe(struct i2c_client *client)
   513	{
   514		const struct i2c_device_id *id = i2c_client_get_device_id(client);
   515		struct nct720x_chip_info *chip;
   516		struct iio_dev *indio_dev;
   517		int ret;
   518		u32 tmp;
   519	
   520		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
   521		if (!indio_dev)
   522			return -ENOMEM;
   523		chip = iio_priv(indio_dev);
   524	
   525		if (client->dev.of_node)
 > 526			chip->type = (enum nct720x_chips)device_get_match_data(&client->dev);
   527		else
   528			chip->type = i2c_match_id(nct720x_id, client)->driver_data;
   529	
   530		chip->vin_max = (chip->type == nct7201) ? NCT7201_VIN_MAX : NCT7202_VIN_MAX;
   531	
   532		ret = of_property_read_u32(client->dev.of_node, "read-vin-data-size", &tmp);
   533		if (ret < 0) {
   534			pr_err("read-vin-data-size property not found\n");
   535			return ret;
   536		}
   537	
   538		if (tmp == 8) {
   539			chip->use_read_byte_vin = true;
   540		} else if (tmp == 16) {
   541			chip->use_read_byte_vin = false;
   542		} else {
   543			pr_err("invalid read-vin-data-size (%d)\n", tmp);
   544			return -EINVAL;
   545		}
   546	
   547		mutex_init(&chip->access_lock);
   548	
   549		/* this is only used for device removal purposes */
   550		i2c_set_clientdata(client, indio_dev);
   551	
   552		chip->client = client;
   553	
   554		ret = nct720x_init_chip(chip);
   555		if (ret < 0)
   556			return ret;
   557	
   558		indio_dev->name = id->name;
   559		indio_dev->channels = nct720x_channels;
   560		indio_dev->num_channels = ARRAY_SIZE(nct720x_channels);
   561		indio_dev->info = &nct720x_info;
   562		indio_dev->modes = INDIO_DIRECT_MODE;
   563	
   564		iio_device_register(indio_dev);
   565	
   566		return 0;
   567	}
   568	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

