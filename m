Return-Path: <linux-iio+bounces-8803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCA95F125
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0651C21AFB
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34598165F0E;
	Mon, 26 Aug 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cj74y9VQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348C140369;
	Mon, 26 Aug 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674687; cv=none; b=T8LS2PC0LLUmZ36wMCw4sBTCGIOyPZ8JaRRNJpiIDmZTROVKax3POVvmCNi4akW4DgcHNmmPb3Zg1pfwJ3FdnpUU5tkOojHBYKSX9AWFyDWilq6x5EpHDpWKrDCi4/gMlG6XofPdjyjkSSBUz7FT9+M764t1nwJ7HRPmTEHDOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674687; c=relaxed/simple;
	bh=0gKOTDN02xP/TYDq8rdQ5A2bRV/fvYT6EBL3PpPfiug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQbcqm7K/wQH6hS0fBAppw51NX1w6aDc2nFDHWxCoowkGEvJqYShkxzW2Ftsl4qAPmeD9abIinq3fnV0mVsuRrfqMgF2D53zNvbruL6zWxOPG9Ts+N81wMBHRIypY2raUa0NefUB/uM3ZvJtGUrM9yDZ/n76R8UGT0ffaUmKu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cj74y9VQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724674686; x=1756210686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0gKOTDN02xP/TYDq8rdQ5A2bRV/fvYT6EBL3PpPfiug=;
  b=Cj74y9VQIkQxKUK6A55dqMWxPK9a/R24s4L7na/bPKvgeBsXfcBtHyPr
   avNpEvfYA3jJNlW66gW1sHkJZ2gXDjMeMCDKqDBUT7+o5nFMyaOcbRWbN
   uf8ct2CEdPso1+pC4dzPD9g5i4VAxxxqlKw2Yo+K1gUaKW9uyREwgGpF/
   JEaEnUqmRi1/PgH/hsz8P/0/n+GUi+bEFGmdwWO5dy1rhFquWFKs1swkY
   Lebao9qv7pvxP6qXjhxnq4ptY+C3EH6Nvj9KxwNtePOao46O2MZYfxeLm
   dPt8ANLHSsMgZNo1Obtb+sz4TLGfcsm0dM468yaLNETxl6416YtHnpoZ6
   g==;
X-CSE-ConnectionGUID: 8ws6Dv86R2Kaxjp9H6JrUA==
X-CSE-MsgGUID: iGOhVdkjQPuzh26JrLx+kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33713998"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33713998"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 05:18:05 -0700
X-CSE-ConnectionGUID: Hz7RjpVWSgqIJQDveQnlsA==
X-CSE-MsgGUID: cg4jXx3WTuu5PLOYt6zTag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="85675660"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Aug 2024 05:18:02 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siYfW-000H1d-1v;
	Mon, 26 Aug 2024 12:17:58 +0000
Date: Mon, 26 Aug 2024 20:17:17 +0800
From: kernel test robot <lkp@intel.com>
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	kees@kernel.org, gustavoars@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, wangshuaijie@awinic.com,
	liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V8 2/2] iio: proximity: aw96103: Add support for
 aw96103/aw96105 proximity sensor
Message-ID: <202408262027.ynenF6mX-lkp@intel.com>
References: <20240823094947.3511730-3-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823094947.3511730-3-wangshuaijie@awinic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b78b25f69a1dfa79798f684ad34707b1da10a48f]

url:    https://github.com/intel-lab-lkp/linux/commits/wangshuaijie-awinic-com/dt-bindings-iio-aw96103-Add-bindings-for-aw96103-aw96105-sensor/20240826-130421
base:   b78b25f69a1dfa79798f684ad34707b1da10a48f
patch link:    https://lore.kernel.org/r/20240823094947.3511730-3-wangshuaijie%40awinic.com
patch subject: [PATCH V8 2/2] iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240826/202408262027.ynenF6mX-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408262027.ynenF6mX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408262027.ynenF6mX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/proximity/aw96103.c: In function 'aw96103_i2c_probe':
>> drivers/iio/proximity/aw96103.c:806:28: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     806 |         aw96103->chip_info = i2c_get_match_data(i2c);
         |                            ^


vim +/const +806 drivers/iio/proximity/aw96103.c

   793	
   794	static int aw96103_i2c_probe(struct i2c_client *i2c)
   795	{
   796		struct iio_dev *aw_iio_dev;
   797		struct aw96103 *aw96103;
   798		int ret;
   799	
   800		aw_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*aw96103));
   801		if (!aw_iio_dev)
   802			return -ENOMEM;
   803	
   804		aw96103 = iio_priv(aw_iio_dev);
   805		aw96103->dev = &i2c->dev;
 > 806		aw96103->chip_info = i2c_get_match_data(i2c);
   807		aw96103->max_channels = aw96103->chip_info->num_channels;
   808	
   809		aw96103->regmap = devm_regmap_init_i2c(i2c, &aw96103_regmap_confg);
   810		if (IS_ERR(aw96103->regmap))
   811			return PTR_ERR(aw96103->regmap);
   812	
   813		ret = devm_regulator_get_enable(aw96103->dev, "vcc");
   814		if (ret < 0)
   815			return ret;
   816	
   817		ret = aw96103_read_chipid(aw96103);
   818		if (ret)
   819			return ret;
   820	
   821		ret = aw96103_sw_reset(aw96103);
   822		if (ret)
   823			return ret;
   824	
   825		ret = aw96103_wait_chip_init(aw96103);
   826		if (ret)
   827			return ret;
   828	
   829		ret = request_firmware_nowait(THIS_MODULE, true, "aw96103_0.bin",
   830					      aw96103->dev, GFP_KERNEL, aw96103,
   831					      aw96103_cfg_update);
   832		if (ret)
   833			return ret;
   834	
   835		ret = aw96103_interrupt_init(aw_iio_dev, i2c);
   836		if (ret)
   837			return ret;
   838		aw_iio_dev->modes = INDIO_DIRECT_MODE;
   839		aw_iio_dev->num_channels = aw96103->chip_info->num_channels;
   840		aw_iio_dev->channels = aw96103->chip_info->channels;
   841		aw_iio_dev->info = &iio_info;
   842		aw_iio_dev->name = aw96103->chip_info->name;
   843		aw_iio_dev->dev.parent = aw96103->dev;
   844	
   845		return devm_iio_device_register(aw96103->dev, aw_iio_dev);
   846	}
   847	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

