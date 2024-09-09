Return-Path: <linux-iio+bounces-9415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4416A9725FC
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 01:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C7A2844CA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF018E76E;
	Mon,  9 Sep 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzvVq2/3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141E18DF8F;
	Mon,  9 Sep 2024 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926294; cv=none; b=TM1dTZr+gtnti482VH7Mabln1V+Tz/hU/xqmy3/zF455Csuqet/wZawSa61nhXirHqhTyK5k1Z9jlqm5wlgvMP+lLg6ORsG0NWj82I/GzZND8TN1bq4vbe3OG1iTJgn1zWl2NVC0qj/FEp5ULeVsPieFgUQMay/6ultaCzdO/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926294; c=relaxed/simple;
	bh=5epVVkn2PLxPjF6sN9j3lSNsxBTpsJNigNUbCBDzaGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N71paFNLozJWLcor8nOc2AfZrMtaHk5iDYzgMKyItqJcjmz0J7B9QC/aqHyXaeaQ1UmzL830omgJAN5d0FP4NR084JokMzHshPzsiWjxpYMFBwf+JulDLACUCBA1BkRpwsrG3WFOp8TY2OtRo3OsA6UblVQyq5Kcwcs7gxMShlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzvVq2/3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725926293; x=1757462293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5epVVkn2PLxPjF6sN9j3lSNsxBTpsJNigNUbCBDzaGE=;
  b=ZzvVq2/3ZKibj0kwlM/QN9L5rPgN2e8GsdjfPw8fey9mal9x8cVqt0q7
   qEa+A5fyTvvIEBJbkeuWmTvnwfneiz3Q3ygucVfNJJ38M9ER6OEDtpS17
   ddyHmc1zx2w9lONpbZKHwPRPWZBbY31twXjsLiBlCuN0DI7stopK9Rt/F
   f7OEPggx4sHesgEsjgMd3/XeMUWayxB+Kyq6RlNW236hpBCX5+xf3/VPI
   1OWZcZzGFr1ypHVbh6leMrkWYX0o8oELinYRTWScaKB7WVJoZAEOrxTL3
   t8+2FYSUO44xHJCcK0JSqCWJiYo3xIW5r8AM2mLwqxwqC2bwBAEPXlYiF
   A==;
X-CSE-ConnectionGUID: 4cOoffcTQX++S18AYmbrdw==
X-CSE-MsgGUID: dD+HPtcHQ4WCtDe/bahyiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28430948"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="28430948"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 16:58:12 -0700
X-CSE-ConnectionGUID: 1WbSL/OlSTSao5p/1SU7lQ==
X-CSE-MsgGUID: XkS4mGqfTAamzR8ZFWoXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="90123048"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Sep 2024 16:58:09 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snoGl-000FMe-12;
	Mon, 09 Sep 2024 23:58:07 +0000
Date: Tue, 10 Sep 2024 07:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Abhash Jha <abhashkumarjha123@gmail.com>, linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anshulusr@gmail.com, jic23@kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: Re: [PATCH 3/4] iio: light: ltr390: Interrupts and threshold event
 support
Message-ID: <202409100717.2rKMS0oi-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-003-20240910 (https://download.01.org/0day-ci/archive/20240910/202409100717.2rKMS0oi-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100717.2rKMS0oi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409100717.2rKMS0oi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/light/ltr390.c:633:19: error: call to undeclared function 'irq_get_trigger_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     633 |                 int irq_flags = irq_get_trigger_type(client->irq);
         |                                 ^
   1 error generated.


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

