Return-Path: <linux-iio+bounces-22338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE6B1C89B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F2718C370B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A034288CB3;
	Wed,  6 Aug 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hc36Hzxq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D128C2B9;
	Wed,  6 Aug 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493803; cv=none; b=esmlb8oyjjaiWfZ5T4YkHf4VtfxWo6dJgPvM846vh6reg2KOEnoAz4H6oGf59h0jVYgzJWIzUwRhVdVu5LQ4tHp6FxXGYm4HrGraveBa16EAe/PnO1gCQLGVupJbtXzujqWwCjFuUzbPFLzSJpHs4qZxSPuTk+spIhYNdwk2i+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493803; c=relaxed/simple;
	bh=AkGEAlIH3C0KUKVdvEoZWqHlxEIlk+uNMPjIK23FfD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa5woTuY17vI0jiJsAn1P4soRGetSPrID6DcjC6+bsagpN1BfhbKnBKThoip9Zq55VGFGOJZIQCT6qZpncjfm+SKt2gdSt7pe1e2CzfxDAezx4LFu/VgNkO9mOwg07eXEo9fO2MQdhb+SuqibUBsEQ2zFht4YgsADexZ86KNE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hc36Hzxq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754493802; x=1786029802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AkGEAlIH3C0KUKVdvEoZWqHlxEIlk+uNMPjIK23FfD4=;
  b=hc36HzxqDS0LEZLKQUkRFO1b6Jl+p17ikmQGMCTHCDYXy/6xdX58kFQu
   DPabW4Z/uj2EHUFVjktAc1A78dK9uw819MpZr7HzvLAGlygBYhhwMbvEt
   sLUlQfO+q3H6MC7Va5HbHV1lsAHnFtJdOCe06rylhiTDUD6364yE3LqBJ
   gLll86BmdvWxSTeZDTlotywW03nKqpvXcXK8GrXJ+mHsOvWHAUo8H365E
   y/JdjcU000AI4VkyvzycqxE7nEAnC9uTT3vFzgU4d5FflxaPW7+DfbrE0
   /+WfCuonz4n4lvJfyLDVIr4tjlHs6qZrhMnRw5Uur43apvrZDhOa7DC1v
   A==;
X-CSE-ConnectionGUID: xQ09okmwQY+kmZthepdHVg==
X-CSE-MsgGUID: CPRBTDi+TaenAQU+E5ABuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74395757"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74395757"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:23:21 -0700
X-CSE-ConnectionGUID: PGRGgmDGRLyq4aozpxbSNw==
X-CSE-MsgGUID: pO0qc8FiTq2lQarZ37YpLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164819014"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Aug 2025 08:23:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujfz2-0001oo-0l;
	Wed, 06 Aug 2025 15:23:16 +0000
Date: Wed, 6 Aug 2025 23:22:16 +0800
From: kernel test robot <lkp@intel.com>
To: Stefano Manni <stefano.manni@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: Re: [PATCH] iio: adc: ad799x: add reference supply for ad7994
Message-ID: <202508062313.Up1PAzZN-lkp@intel.com>
References: <20250805142423.17710-1-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805142423.17710-1-stefano.manni@gmail.com>

Hi Stefano,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefano-Manni/iio-adc-ad799x-add-reference-supply-for-ad7994/20250806-125049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250805142423.17710-1-stefano.manni%40gmail.com
patch subject: [PATCH] iio: adc: ad799x: add reference supply for ad7994
config: arc-randconfig-002-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062313.Up1PAzZN-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508062313.Up1PAzZN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062313.Up1PAzZN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad799x.c: In function 'ad799x_probe':
>> drivers/iio/adc/ad799x.c:829:73: error: called object is not a function or function pointer
     829 |                 if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)
         |                                                                 ~~~~~~~~^~~~~~~~~~


vim +829 drivers/iio/adc/ad799x.c

   777	
   778	static int ad799x_probe(struct i2c_client *client)
   779	{
   780		const struct i2c_device_id *id = i2c_client_get_device_id(client);
   781		int ret;
   782		int extra_config = 0;
   783		struct ad799x_state *st;
   784		struct iio_dev *indio_dev;
   785		const struct ad799x_chip_info *chip_info =
   786			&ad799x_chip_info_tbl[id->driver_data];
   787	
   788		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
   789		if (indio_dev == NULL)
   790			return -ENOMEM;
   791	
   792		st = iio_priv(indio_dev);
   793		/* this is only used for device removal purposes */
   794		i2c_set_clientdata(client, indio_dev);
   795	
   796		st->id = id->driver_data;
   797		if (client->irq > 0 && chip_info->irq_config.info)
   798			st->chip_config = &chip_info->irq_config;
   799		else
   800			st->chip_config = &chip_info->noirq_config;
   801	
   802		/* TODO: Add pdata options for filtering and bit delay */
   803	
   804		st->reg = devm_regulator_get(&client->dev, "vcc");
   805		if (IS_ERR(st->reg))
   806			return PTR_ERR(st->reg);
   807		ret = regulator_enable(st->reg);
   808		if (ret)
   809			return ret;
   810	
   811		/* check if an external reference is supplied */
   812		st->vref = devm_regulator_get_optional(&client->dev, "vref");
   813	
   814		if (IS_ERR(st->vref)) {
   815			if (PTR_ERR(st->vref) == -ENODEV) {
   816				st->vref = NULL;
   817				dev_info(&client->dev, "Using VCC reference voltage\n");
   818			} else {
   819				ret = PTR_ERR(st->vref);
   820				goto error_disable_reg;
   821			}
   822		}
   823	
   824		if (st->vref) {
   825			/*
   826			 * Use external reference voltage if supported by hardware.
   827			 * This is optional if voltage / regulator present, use VCC otherwise.
   828			 */
 > 829			if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)
   830				(st->id == ad7994)) {
   831				dev_info(&client->dev, "Using external reference voltage\n");
   832				extra_config |= AD7991_REF_SEL;
   833				ret = regulator_enable(st->vref);
   834				if (ret)
   835					goto error_disable_reg;
   836			} else {
   837				st->vref = NULL;
   838				dev_warn(&client->dev, "Supplied reference not supported\n");
   839			}
   840		}
   841	
   842		st->client = client;
   843	
   844		indio_dev->name = id->name;
   845		indio_dev->info = st->chip_config->info;
   846	
   847		indio_dev->modes = INDIO_DIRECT_MODE;
   848		indio_dev->channels = st->chip_config->channel;
   849		indio_dev->num_channels = chip_info->num_channels;
   850	
   851		ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
   852		if (ret)
   853			goto error_disable_vref;
   854	
   855		ret = iio_triggered_buffer_setup(indio_dev, NULL,
   856			&ad799x_trigger_handler, NULL);
   857		if (ret)
   858			goto error_disable_vref;
   859	
   860		if (client->irq > 0) {
   861			ret = devm_request_threaded_irq(&client->dev,
   862							client->irq,
   863							NULL,
   864							ad799x_event_handler,
   865							IRQF_TRIGGER_FALLING |
   866							IRQF_ONESHOT,
   867							client->name,
   868							indio_dev);
   869			if (ret)
   870				goto error_cleanup_ring;
   871		}
   872	
   873		mutex_init(&st->lock);
   874	
   875		ret = iio_device_register(indio_dev);
   876		if (ret)
   877			goto error_cleanup_ring;
   878	
   879		return 0;
   880	
   881	error_cleanup_ring:
   882		iio_triggered_buffer_cleanup(indio_dev);
   883	error_disable_vref:
   884		if (st->vref)
   885			regulator_disable(st->vref);
   886	error_disable_reg:
   887		regulator_disable(st->reg);
   888	
   889		return ret;
   890	}
   891	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

