Return-Path: <linux-iio+bounces-21563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39AB01491
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443AD1894AFC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07DE1EC018;
	Fri, 11 Jul 2025 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+AA/LtX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED111EA7CE;
	Fri, 11 Jul 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218763; cv=none; b=HrdA74bpAZL/tahaQb+vGGcuXApp9UonxkeXWV6teA3cocUasd1m7w5RmSqVp9u2A4MpfF6GqvKJ5dru6J1QXwBvbyTrEzD24jBC/GZ2/1FCD+DBqN+f+Zy5htAW2ceMntajSX6jTkCf6OHyk66WygcE3M1AKwd+ZH193m28IxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218763; c=relaxed/simple;
	bh=bZBbzK4EC0AKwX2333BO4L7MfNA6I++mgmTp3LjgmsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwYNHyHR3P3d314reEOn8knw9vWh0eEqEDBUoXwK9TVPfh4BKHTyo3lu9hsyxRHBAsxuC/8zsT/aJsJO6ZXlB3QrvAcAZtD9PljrA67FyUrajdftySrcx4cVlW7rxAMivjyOdy6ARHIbD6EWcPZJvfoB2UqGUmc7lX1nBoMs+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+AA/LtX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752218762; x=1783754762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZBbzK4EC0AKwX2333BO4L7MfNA6I++mgmTp3LjgmsU=;
  b=U+AA/LtXGx2ZBEnBEwz4USCfJI2b9qdhhW73+bukBTLgyGw9eFjboHqA
   F6b9vOd82+Z337qLw7ToPt8UcHZyffjGzoz4HTkQ7VAZEWert686GrVTc
   Eqghn7DFLgmQVqz91W8068UugFK7MIetaEQA9ZsEGaxLz/L7sLO9vmxh7
   WDc/qDpsRZScw1trWdKoOgHGfzi+inkJDyTceD8FnIAXDlaQx9tOPoxYy
   LYFYDV+TSQbOjsB9Gel5QpsGUaH3Sak+cjm4IRFfDqCYJixw77Zb0ZJSJ
   hv4cJgR+IL7/Zy6CW2DVYO7lo4C2VVCxxm8FFYCKZCEREYsFK3LvV39iT
   Q==;
X-CSE-ConnectionGUID: P2YddlDtQ96Y6omk804sSA==
X-CSE-MsgGUID: rORc59eMT1+QdvRQWaa6mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="79945850"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="79945850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 00:25:59 -0700
X-CSE-ConnectionGUID: ClaLrc71Qjes2Ijq0Ul68g==
X-CSE-MsgGUID: 0lSQ76dZSQG1lHnuqfqcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="160599199"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jul 2025 00:25:56 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua88o-00065P-0a;
	Fri, 11 Jul 2025 07:25:54 +0000
Date: Fri, 11 Jul 2025 15:24:59 +0800
From: kernel test robot <lkp@intel.com>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Remi Buisson <remi.buisson@tdk.com>
Subject: Re: [PATCH v2 5/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Message-ID: <202507111539.F4FrQltx-lkp@intel.com>
References: <20250710-add_newport_driver-v2-5-bf76d8142ef2@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-add_newport_driver-v2-5-bf76d8142ef2@tdk.com>

Hi Remi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f8f559752d573a051a984adda8d2d1464f92f954]

url:    https://github.com/intel-lab-lkp/linux/commits/Remi-Buisson-via-B4-Relay/dt-bindings-iio-imu-Add-inv_icm45600/20250710-170143
base:   f8f559752d573a051a984adda8d2d1464f92f954
patch link:    https://lore.kernel.org/r/20250710-add_newport_driver-v2-5-bf76d8142ef2%40tdk.com
patch subject: [PATCH v2 5/8] iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250711/202507111539.F4FrQltx-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507111539.F4FrQltx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507111539.F4FrQltx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:894:12: warning: 'inv_icm45600_runtime_resume' defined but not used [-Wunused-function]
     894 | static int inv_icm45600_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:875:12: warning: 'inv_icm45600_runtime_suspend' defined but not used [-Wunused-function]
     875 | static int inv_icm45600_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:832:12: warning: 'inv_icm45600_resume' defined but not used [-Wunused-function]
     832 | static int inv_icm45600_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:790:12: warning: 'inv_icm45600_suspend' defined but not used [-Wunused-function]
     790 | static int inv_icm45600_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~


vim +/inv_icm45600_runtime_resume +894 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c

01fd98fed267cd Remi Buisson 2025-07-10  785  
01fd98fed267cd Remi Buisson 2025-07-10  786  /*
01fd98fed267cd Remi Buisson 2025-07-10  787   * Suspend saves sensors state and turns everything off.
01fd98fed267cd Remi Buisson 2025-07-10  788   * Check first if runtime suspend has not already done the job.
01fd98fed267cd Remi Buisson 2025-07-10  789   */
01fd98fed267cd Remi Buisson 2025-07-10 @790  static int inv_icm45600_suspend(struct device *dev)
01fd98fed267cd Remi Buisson 2025-07-10  791  {
01fd98fed267cd Remi Buisson 2025-07-10  792  	struct inv_icm45600_state *st = dev_get_drvdata(dev);
01fd98fed267cd Remi Buisson 2025-07-10  793  	int ret;
01fd98fed267cd Remi Buisson 2025-07-10  794  
01fd98fed267cd Remi Buisson 2025-07-10  795  	guard(mutex)(&st->lock);
01fd98fed267cd Remi Buisson 2025-07-10  796  
01fd98fed267cd Remi Buisson 2025-07-10  797  	st->suspended.gyro = st->conf.gyro.mode;
01fd98fed267cd Remi Buisson 2025-07-10  798  	st->suspended.accel = st->conf.accel.mode;
01fd98fed267cd Remi Buisson 2025-07-10  799  	if (pm_runtime_suspended(dev))
01fd98fed267cd Remi Buisson 2025-07-10  800  		return 0;
01fd98fed267cd Remi Buisson 2025-07-10  801  
eaedaea6990c59 Remi Buisson 2025-07-10  802  	/* Disable FIFO data streaming. */
eaedaea6990c59 Remi Buisson 2025-07-10  803  	if (st->fifo.on) {
eaedaea6990c59 Remi Buisson 2025-07-10  804  		unsigned int val;
eaedaea6990c59 Remi Buisson 2025-07-10  805  
eaedaea6990c59 Remi Buisson 2025-07-10  806  		ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
eaedaea6990c59 Remi Buisson 2025-07-10  807  					INV_ICM45600_FIFO_CONFIG3_IF_EN);
eaedaea6990c59 Remi Buisson 2025-07-10  808  		if (ret)
eaedaea6990c59 Remi Buisson 2025-07-10  809  			return ret;
eaedaea6990c59 Remi Buisson 2025-07-10  810  		val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
eaedaea6990c59 Remi Buisson 2025-07-10  811  			INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
eaedaea6990c59 Remi Buisson 2025-07-10  812  		ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
eaedaea6990c59 Remi Buisson 2025-07-10  813  					 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
eaedaea6990c59 Remi Buisson 2025-07-10  814  		if (ret)
eaedaea6990c59 Remi Buisson 2025-07-10  815  			return ret;
eaedaea6990c59 Remi Buisson 2025-07-10  816  	}
eaedaea6990c59 Remi Buisson 2025-07-10  817  
01fd98fed267cd Remi Buisson 2025-07-10  818  	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
01fd98fed267cd Remi Buisson 2025-07-10  819  					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
01fd98fed267cd Remi Buisson 2025-07-10  820  	if (ret)
01fd98fed267cd Remi Buisson 2025-07-10  821  		return ret;
01fd98fed267cd Remi Buisson 2025-07-10  822  
01fd98fed267cd Remi Buisson 2025-07-10  823  	regulator_disable(st->vddio_supply);
01fd98fed267cd Remi Buisson 2025-07-10  824  
01fd98fed267cd Remi Buisson 2025-07-10  825  	return 0;
01fd98fed267cd Remi Buisson 2025-07-10  826  }
01fd98fed267cd Remi Buisson 2025-07-10  827  
01fd98fed267cd Remi Buisson 2025-07-10  828  /*
01fd98fed267cd Remi Buisson 2025-07-10  829   * System resume gets the system back on and restores the sensors state.
01fd98fed267cd Remi Buisson 2025-07-10  830   * Manually put runtime power management in system active state.
01fd98fed267cd Remi Buisson 2025-07-10  831   */
01fd98fed267cd Remi Buisson 2025-07-10 @832  static int inv_icm45600_resume(struct device *dev)
01fd98fed267cd Remi Buisson 2025-07-10  833  {
01fd98fed267cd Remi Buisson 2025-07-10  834  	struct inv_icm45600_state *st = dev_get_drvdata(dev);
eaedaea6990c59 Remi Buisson 2025-07-10  835  	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
eaedaea6990c59 Remi Buisson 2025-07-10  836  	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
01fd98fed267cd Remi Buisson 2025-07-10  837  	int ret;
01fd98fed267cd Remi Buisson 2025-07-10  838  
01fd98fed267cd Remi Buisson 2025-07-10  839  	guard(mutex)(&st->lock);
01fd98fed267cd Remi Buisson 2025-07-10  840  
01fd98fed267cd Remi Buisson 2025-07-10  841  	ret = inv_icm45600_enable_regulator_vddio(st);
01fd98fed267cd Remi Buisson 2025-07-10  842  	if (ret)
01fd98fed267cd Remi Buisson 2025-07-10  843  		return ret;
01fd98fed267cd Remi Buisson 2025-07-10  844  
01fd98fed267cd Remi Buisson 2025-07-10  845  	pm_runtime_disable(dev);
01fd98fed267cd Remi Buisson 2025-07-10  846  	pm_runtime_set_active(dev);
01fd98fed267cd Remi Buisson 2025-07-10  847  	pm_runtime_enable(dev);
01fd98fed267cd Remi Buisson 2025-07-10  848  
01fd98fed267cd Remi Buisson 2025-07-10  849  	/* Restore sensors state. */
eaedaea6990c59 Remi Buisson 2025-07-10  850  	ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
01fd98fed267cd Remi Buisson 2025-07-10  851  					 st->suspended.accel, NULL);
eaedaea6990c59 Remi Buisson 2025-07-10  852  	if (ret)
eaedaea6990c59 Remi Buisson 2025-07-10  853  		return ret;
01fd98fed267cd Remi Buisson 2025-07-10  854  
eaedaea6990c59 Remi Buisson 2025-07-10  855  	/* Restore FIFO data streaming. */
eaedaea6990c59 Remi Buisson 2025-07-10  856  	if (st->fifo.on) {
eaedaea6990c59 Remi Buisson 2025-07-10  857  		unsigned int val;
eaedaea6990c59 Remi Buisson 2025-07-10  858  
eaedaea6990c59 Remi Buisson 2025-07-10  859  		inv_sensors_timestamp_reset(&gyro_st->ts);
eaedaea6990c59 Remi Buisson 2025-07-10  860  		inv_sensors_timestamp_reset(&accel_st->ts);
eaedaea6990c59 Remi Buisson 2025-07-10  861  		val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
eaedaea6990c59 Remi Buisson 2025-07-10  862  			INV_ICM45600_FIFO_CONFIG0_MODE_STREAM);
eaedaea6990c59 Remi Buisson 2025-07-10  863  		ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
eaedaea6990c59 Remi Buisson 2025-07-10  864  					 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
eaedaea6990c59 Remi Buisson 2025-07-10  865  		if (ret)
eaedaea6990c59 Remi Buisson 2025-07-10  866  			return ret;
eaedaea6990c59 Remi Buisson 2025-07-10  867  		ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
eaedaea6990c59 Remi Buisson 2025-07-10  868  				      INV_ICM45600_FIFO_CONFIG3_IF_EN);
eaedaea6990c59 Remi Buisson 2025-07-10  869  	}
eaedaea6990c59 Remi Buisson 2025-07-10  870  
eaedaea6990c59 Remi Buisson 2025-07-10  871  	return ret;
01fd98fed267cd Remi Buisson 2025-07-10  872  }
01fd98fed267cd Remi Buisson 2025-07-10  873  
01fd98fed267cd Remi Buisson 2025-07-10  874  /* Runtime suspend will turn off sensors that are enabled by iio devices. */
01fd98fed267cd Remi Buisson 2025-07-10 @875  static int inv_icm45600_runtime_suspend(struct device *dev)
01fd98fed267cd Remi Buisson 2025-07-10  876  {
01fd98fed267cd Remi Buisson 2025-07-10  877  	struct inv_icm45600_state *st = dev_get_drvdata(dev);
01fd98fed267cd Remi Buisson 2025-07-10  878  	int ret;
01fd98fed267cd Remi Buisson 2025-07-10  879  
01fd98fed267cd Remi Buisson 2025-07-10  880  	guard(mutex)(&st->lock);
01fd98fed267cd Remi Buisson 2025-07-10  881  
01fd98fed267cd Remi Buisson 2025-07-10  882  	/* disable all sensors */
01fd98fed267cd Remi Buisson 2025-07-10  883  	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
01fd98fed267cd Remi Buisson 2025-07-10  884  					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
01fd98fed267cd Remi Buisson 2025-07-10  885  	if (ret)
01fd98fed267cd Remi Buisson 2025-07-10  886  		return ret;
01fd98fed267cd Remi Buisson 2025-07-10  887  
01fd98fed267cd Remi Buisson 2025-07-10  888  	regulator_disable(st->vddio_supply);
01fd98fed267cd Remi Buisson 2025-07-10  889  
01fd98fed267cd Remi Buisson 2025-07-10  890  	return 0;
01fd98fed267cd Remi Buisson 2025-07-10  891  }
01fd98fed267cd Remi Buisson 2025-07-10  892  
01fd98fed267cd Remi Buisson 2025-07-10  893  /* Sensors are enabled by iio devices, no need to turn them back on here. */
01fd98fed267cd Remi Buisson 2025-07-10 @894  static int inv_icm45600_runtime_resume(struct device *dev)
01fd98fed267cd Remi Buisson 2025-07-10  895  {
01fd98fed267cd Remi Buisson 2025-07-10  896  	struct inv_icm45600_state *st = dev_get_drvdata(dev);
01fd98fed267cd Remi Buisson 2025-07-10  897  
01fd98fed267cd Remi Buisson 2025-07-10  898  	guard(mutex)(&st->lock);
01fd98fed267cd Remi Buisson 2025-07-10  899  
01fd98fed267cd Remi Buisson 2025-07-10  900  	return inv_icm45600_enable_regulator_vddio(st);
01fd98fed267cd Remi Buisson 2025-07-10  901  }
01fd98fed267cd Remi Buisson 2025-07-10  902  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

