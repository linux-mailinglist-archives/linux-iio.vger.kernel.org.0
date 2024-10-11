Return-Path: <linux-iio+bounces-10431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E6999BAE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 06:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FA51C2329F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34821F9409;
	Fri, 11 Oct 2024 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgZM9LAD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5471F4FAF;
	Fri, 11 Oct 2024 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621181; cv=none; b=AXBuWh1YFw2AXXHKo2cnmibjnhpQS1azhfxyXgbIUy67fXCNnPRg27s2sz0/AR7Gs+fPFS7fvOiecc45A3Aixnjj33y08P0yubIhzqgNn2/qC6NQe1Q1xSu3rguHhWaVRGVOpMBoudBPNdv5DP2zWY5HJER82fKtbgG8wFO0MZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621181; c=relaxed/simple;
	bh=WPsimNbw3/FLAWkS8kcN9an0/txl+7xFw5VfWVObtaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuTh2r0Ut0TI3BH3St6WQCwu96qa6ED/U2+OCcLIfyh+NrGd1Zq8kD37Ety5Fvk0cYshwYEER0hUeKlaMqTixrYm7D2xWDtm+88GaNG4qss0CCF43a0psgF58pYOUJxUip6ltMbU03KBcLiQ4B5r3kbmmj60Tu2t5hJp1XlivDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgZM9LAD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621180; x=1760157180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WPsimNbw3/FLAWkS8kcN9an0/txl+7xFw5VfWVObtaw=;
  b=fgZM9LADAOHfwsDpJBDggIFo+9aVmyAhkz+TbN1sk65676YnSeV5FGRc
   QMaC7g61ktoX6MqYcGV5LsW5wrhV5KS9rMONmEP5+dvIlk5YoyTU1j27H
   VZTFODxZX5GQXTH+w6mi8JZLpFi5tm49GAYTib2eeSqjEN6W162HZfXIY
   fPQVCInPG1m3bWqLQSmByYyDey5glwVa2yMS0TklwIaYjLbFZIR6ub34y
   a/U4XqpavEe8xvJPX77qAWvKlTvyr+TYRxDCEmL1krQXWhuJ7R8yURZ3h
   FeGKeUnUXoxRZU/SsAoNlmSiTdRPfURw2UeXleYqp1FqmDQ+yuBpuSRIU
   g==;
X-CSE-ConnectionGUID: ZcRx5KkcTK24dv0DUsmbZg==
X-CSE-MsgGUID: 4IVC8LveTOK6K5TNByvxOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101891"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101891"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:59 -0700
X-CSE-ConnectionGUID: xlrxdYeoRVCGPpSXEZMSUQ==
X-CSE-MsgGUID: 18hiwM1BSyycpyc4jLTsYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412364"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sz7Ke-000BnT-1j;
	Fri, 11 Oct 2024 04:32:52 +0000
Date: Fri, 11 Oct 2024 12:32:12 +0800
From: kernel test robot <lkp@intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	vassilisamir@gmail.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <202410111221.YIeXHxOv-lkp@intel.com>
References: <20241007194945.66192-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007194945.66192-2-vassilisamir@gmail.com>

Hi Vasileios,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 96be67caa0f0420d4128cb67f07bbd7a6f49e03a]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasileios-Amoiridis/iio-pressure-bmp280-Use-sleep-and-forced-mode-for-oneshot-captures/20241008-035238
base:   96be67caa0f0420d4128cb67f07bbd7a6f49e03a
patch link:    https://lore.kernel.org/r/20241007194945.66192-2-vassilisamir%40gmail.com
patch subject: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
config: i386-randconfig-006-20241011 (https://download.01.org/0day-ci/archive/20241011/202410111221.YIeXHxOv-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410111221.YIeXHxOv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410111221.YIeXHxOv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/pressure/bmp280-core.c:1051:3: warning: variable 'meas_time_us' is uninitialized when used here [-Wuninitialized]
    1051 |                 meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
         |                 ^~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:1046:32: note: initialize the variable 'meas_time_us' to silence this warning
    1046 |         unsigned int reg, meas_time_us;
         |                                       ^
         |                                        = 0
   drivers/iio/pressure/bmp280-core.c:2452:2: warning: variable 'offset' is uninitialized when used here [-Wuninitialized]
    2452 |         offset += sizeof(s32);
         |         ^~~~~~
   drivers/iio/pressure/bmp280-core.c:2437:17: note: initialize the variable 'offset' to silence this warning
    2437 |         int ret, offset;
         |                        ^
         |                         = 0
   2 warnings generated.


vim +/meas_time_us +1051 drivers/iio/pressure/bmp280-core.c

  1043	
  1044	static int bmp280_wait_conv(struct bmp280_data *data)
  1045	{
  1046		unsigned int reg, meas_time_us;
  1047		int ret;
  1048	
  1049		/* Check if we are using a BME280 device */
  1050		if (data->oversampling_humid)
> 1051			meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
  1052					BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
  1053	
  1054		/* Pressure measurement time */
  1055		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
  1056				BIT(data->oversampling_press) * BMP280_MEAS_DUR;
  1057	
  1058		/* Temperature measurement time */
  1059		meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
  1060	
  1061		/* Waiting time according to the BM(P/E)2 Sensor API */
  1062		fsleep(meas_time_us);
  1063	
  1064		ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
  1065		if (ret) {
  1066			dev_err(data->dev, "failed to read status register.\n");
  1067			return ret;
  1068		}
  1069	
  1070		if (reg & BMP280_REG_STATUS_MEAS_BIT) {
  1071			dev_err(data->dev, "Measurement cycle didn't complete.\n");
  1072			return -EBUSY;
  1073		}
  1074	
  1075		return 0;
  1076	}
  1077	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

