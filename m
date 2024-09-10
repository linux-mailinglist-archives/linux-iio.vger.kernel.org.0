Return-Path: <linux-iio+bounces-9425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43201972A2B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 09:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54996283AFD
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 07:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653017BEA4;
	Tue, 10 Sep 2024 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJmhuppl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4717BB32;
	Tue, 10 Sep 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951959; cv=none; b=P+fE/NkyDyhUqyFMeZkBz3j5yVlkAOGQYoBi3mILblM2wFTuOcx6w64btv91KrkhTx1uNN09VcNQlditDN/IEqdsebtCjGRapDL7hR1vcCphUOTqJiBfhyfGg72kRCwKI+bocJT+yTiDBcDVTevxYJedCyu2MdhgrVMH/dK8oSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951959; c=relaxed/simple;
	bh=FRulgI0lmiE0mYaYBCABBxeBTTqRHcICmBnluUqRnrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwrf6FOQRb0CwREVzJTl2TFTZLSicjZccmxpkqFyGmtzszWTeEA9Xdokr7zoANYg9Od03wrqplo7MG2jNXRtdkjm66a5cC6Pbks6i1wuYf5nF7P2DcfoTjr7l3FSFY3HGzYFatXm8UnsfBDpN4Gb4l6NAhrDUvKD+Ap1BGq2Vlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJmhuppl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725951958; x=1757487958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRulgI0lmiE0mYaYBCABBxeBTTqRHcICmBnluUqRnrs=;
  b=YJmhuppl9xqYuFQ3Frvl9WQx/BaZzQXQc0RDR2iKCuoQqm3Gi3+Kt+yv
   mS77rY1QdbH+9NubpxZxWESzGOTLTlknhwwuNjsuAiIp9yTD1oNtIDhLI
   akpOOA7VN8/iaGsL1SbaX6TRQi6/aXCBB9Ho2vZhRM5sw2IS71lkCqh/a
   AoUSq2r3+sr2FZ8gUhTAsY3OCOUdi35MsN6s/twMaM1Ob8dF3ex8IhQkK
   0CH69kQdlH5rgs4WRlS1w+idGYbOanPtI+iaSJHEV4Clv3SbOooHhf3bw
   VA000/5ZNrKHxlOs5vxJ0FWXHKN91e2453Qimro57QNPVpU2dxi1iOrn+
   A==;
X-CSE-ConnectionGUID: sRnTC2FESYemJkAqMy9gpQ==
X-CSE-MsgGUID: x760udS0TVqx+U2cmCaObw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28571865"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="28571865"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:05:57 -0700
X-CSE-ConnectionGUID: I3VDDTDyTc+3JjSsWJWdhg==
X-CSE-MsgGUID: 6+k9GiLTQB2IH5OYdhI0kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="97638224"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Sep 2024 00:05:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snuwd-0000CI-1G;
	Tue, 10 Sep 2024 07:05:47 +0000
Date: Tue, 10 Sep 2024 15:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: Abhash Jha <abhashkumarjha123@gmail.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, anshulusr@gmail.com, jic23@kernel.org,
	lars@metafoo.de, linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: Re: [PATCH 3/4] iio: light: ltr390: Interrupts and threshold event
 support
Message-ID: <202409101339.74gDdc6n-lkp@intel.com>
References: <20240909103623.264113-4-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909103623.264113-4-abhashkumarjha123@gmail.com>

Hi Abhash,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on next-20240909]
[cannot apply to linus/master v6.11-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhash-Jha/iio-light-ltr390-Suspend-and-Resume-support/20240909-193623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240909103623.264113-4-abhashkumarjha123%40gmail.com
patch subject: [PATCH 3/4] iio: light: ltr390: Interrupts and threshold event support
config: i386-buildonly-randconfig-002-20240910 (https://download.01.org/0day-ci/archive/20240910/202409101339.74gDdc6n-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101339.74gDdc6n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101339.74gDdc6n-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/light/ltr390.c: In function 'ltr390_probe':
>> drivers/iio/light/ltr390.c:633:33: error: implicit declaration of function 'irq_get_trigger_type' [-Werror=implicit-function-declaration]
     633 |                 int irq_flags = irq_get_trigger_type(client->irq);
         |                                 ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/irq_get_trigger_type +633 drivers/iio/light/ltr390.c

   578	
   579	static int ltr390_probe(struct i2c_client *client)
   580	{
   581		struct ltr390_data *data;
   582		struct iio_dev *indio_dev;
   583		struct device *dev;
   584		int ret, part_number;
   585	
   586		dev = &client->dev;
   587		indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
   588		if (!indio_dev)
   589			return -ENOMEM;
   590	
   591		data = iio_priv(indio_dev);
   592	
   593		data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
   594		if (IS_ERR(data->regmap))
   595			return dev_err_probe(dev, PTR_ERR(data->regmap),
   596					     "regmap initialization failed\n");
   597	
   598		data->client = client;
   599		/* default value of integration time from pg: 15 of the datasheet */
   600		data->int_time_us = 100000;
   601		/* default value of gain from pg: 16 of the datasheet */
   602		data->gain = 3;
   603		/* default mode for ltr390 is ALS mode */
   604		data->mode = LTR390_SET_ALS_MODE;
   605	
   606		mutex_init(&data->lock);
   607	
   608		indio_dev->info = &ltr390_info;
   609		indio_dev->channels = ltr390_channels;
   610		indio_dev->num_channels = ARRAY_SIZE(ltr390_channels);
   611		indio_dev->name = "ltr390";
   612	
   613		ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
   614		if (ret)
   615			return dev_err_probe(dev, ret,
   616					     "failed to get sensor's part id\n");
   617		/* Lower 4 bits of `part_number` change with hardware revisions */
   618		if (part_number >> 4 != LTR390_PART_NUMBER_ID)
   619			dev_info(dev, "received invalid product id: 0x%x", part_number);
   620		dev_dbg(dev, "LTR390, product id: 0x%x\n", part_number);
   621	
   622		/* reset sensor, chip fails to respond to this, so ignore any errors */
   623		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SW_RESET);
   624	
   625		/* Wait for the registers to reset before proceeding */
   626		usleep_range(1000, 2000);
   627	
   628		ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
   629		if (ret)
   630			return dev_err_probe(dev, ret, "failed to enable the sensor\n");
   631	
   632		if (client->irq) {
 > 633			int irq_flags = irq_get_trigger_type(client->irq);
   634	
   635			if (!irq_flags)
   636				irq_flags = IRQF_TRIGGER_FALLING;
   637	
   638			ret = devm_request_threaded_irq(&client->dev, client->irq,
   639							NULL, ltr390_interrupt_handler,
   640							irq_flags | IRQF_ONESHOT,
   641							"ltr390_thresh_event", indio_dev);
   642			if (ret) {
   643				dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
   644				return ret;
   645			}
   646		}
   647	
   648		return devm_iio_device_register(dev, indio_dev);
   649	}
   650	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

