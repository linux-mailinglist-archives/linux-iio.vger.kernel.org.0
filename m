Return-Path: <linux-iio+bounces-27345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DDCDA8CC
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1915C30305D6
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880BC316189;
	Tue, 23 Dec 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKs9FKN5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53E31576D;
	Tue, 23 Dec 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522182; cv=none; b=L7GJzhWXwBfbXk6Rt2nns9ChpEharVZH0qIK6O8QZMIwBhfO/uARPl4U2tfNRAf+vHXCjbPTMVEGPwiPBa0to3zC6Um3khUSw1VDEmQX/UURZJvJtXXfOltKN9Thp2mcSa/yNHQ1FXg4ZsGHu8x1TxUzXvwr9a3BSJ+GqZN72Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522182; c=relaxed/simple;
	bh=WiaKcg6tqwr+deTq4kuVVXhsBv+dWmCSB3tiAiPsCn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkP0IzhXvn1fUUdAiLphzPK9FQumngv3pCwkDNNnt/0NO2K/ezHdX6ksBJK/pUChoL4dhit0efS9ZfXu6fgbfehh//CnRaxyjvPSMYxdRblCZnpI8kGjuurzAnkoTkYFSMzbktsjiy1mH9h9wzEMbclML46ret0ggkouaFs92Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKs9FKN5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766522181; x=1798058181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WiaKcg6tqwr+deTq4kuVVXhsBv+dWmCSB3tiAiPsCn0=;
  b=HKs9FKN5RG61i9FDGKrCpumLXMQX3rUeoGeilA14P6NbXkgM6Emz8Rsk
   IVlprorocaVwnJdTITJzyOy2DAIbmG+q2QgiGFL0YN3Xj2QDUXEemCXo3
   GV6BJCfQPCwD92AueNShZ42kkHGBzaktshQUqeckiQt5iY7pHYJwJIy5V
   yhltI69+wYA76+xVfUlF6GDS+0eUV4h/Fj0VY2gB2aJ/3TNT2dY/4JyJV
   4DSk1v+Q2V1W744BCZbgVr1i9Xpb4/2Dnibz8x1c8aaAirL9KgCxQdgtu
   yota3AO7ygpTKIRm4M4bM/QvTk0PVpsTqgkQLPmzttI/b9W6K/HqCSyQU
   w==;
X-CSE-ConnectionGUID: tXwCsw6PS4eIjzfOF6J2vQ==
X-CSE-MsgGUID: pMuRaMuNS1SDGE/GybzoCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="71999157"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="71999157"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 12:36:20 -0800
X-CSE-ConnectionGUID: M3uEnjh3SWGNRRVwUNZ+9A==
X-CSE-MsgGUID: OK99AN2yRaW09OhWVIaCrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="199520264"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Dec 2025 12:36:17 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY978-000000002Lv-2ZAk;
	Tue, 23 Dec 2025 20:36:14 +0000
Date: Wed, 24 Dec 2025 04:35:53 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ltc2309: add support for ltc2305
Message-ID: <202512240416.ckqhNpHO-lkp@intel.com>
References: <20251223-add_ltc2305_driver-v1-2-dfa0827fd620@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-add_ltc2305_driver-v1-2-dfa0827fd620@gmail.com>

Hi Kyle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9448598b22c50c8a5bb77a9103e2d49f134c9578]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Hsieh/dt-bindings-adc-ltc2497-add-support-for-ltc2305/20251223-171509
base:   9448598b22c50c8a5bb77a9103e2d49f134c9578
patch link:    https://lore.kernel.org/r/20251223-add_ltc2305_driver-v1-2-dfa0827fd620%40gmail.com
patch subject: [PATCH 2/2] iio: adc: ltc2309: add support for ltc2305
config: sparc64-randconfig-001-20251224 (https://download.01.org/0day-ci/archive/20251224/202512240416.ckqhNpHO-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240416.ckqhNpHO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240416.ckqhNpHO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ltc2309.c: In function 'ltc2309_probe':
>> drivers/iio/adc/ltc2309.c:195:29: warning: unused variable 'match' [-Wunused-variable]
     const struct of_device_id *match;
                                ^~~~~


vim +/match +195 drivers/iio/adc/ltc2309.c

   192	
   193	static int ltc2309_probe(struct i2c_client *client)
   194	{
 > 195		const struct of_device_id *match;
   196		const struct ltc230x_chip_info *chip_info;
   197		struct iio_dev *indio_dev;
   198		struct ltc2309 *ltc2309;
   199		int ret;
   200	
   201		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
   202		if (!indio_dev)
   203			return -ENOMEM;
   204	
   205		ltc2309 = iio_priv(indio_dev);
   206		chip_info = device_get_match_data(&client->dev);
   207		if (!chip_info)
   208			return -EINVAL;
   209	
   210		ltc2309->dev = &indio_dev->dev;
   211		ltc2309->client = client;
   212	
   213		indio_dev->name = chip_info->name;
   214		indio_dev->modes = INDIO_DIRECT_MODE;
   215		indio_dev->channels = chip_info->channels;
   216		indio_dev->num_channels = chip_info->num_channels;
   217		indio_dev->info = &ltc2309_info;
   218	
   219		ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
   220		if (ret < 0 && ret != -ENODEV)
   221			return dev_err_probe(ltc2309->dev, ret,
   222					     "failed to get vref voltage\n");
   223	
   224		ltc2309->vref_mv = ret == -ENODEV ? LTC2309_INTERNAL_REF_MV : ret / 1000;
   225	
   226		mutex_init(&ltc2309->lock);
   227	
   228		return devm_iio_device_register(&client->dev, indio_dev);
   229	}
   230	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

