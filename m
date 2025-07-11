Return-Path: <linux-iio+bounces-21559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BAB01169
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 04:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C691C2801E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F591194C86;
	Fri, 11 Jul 2025 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vcdc0DDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A43D299;
	Fri, 11 Jul 2025 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202775; cv=none; b=IwNrnS3Co8sZe8a1nOSRbRX7y8FzMx6H6HqgbSt25xc2Uom6rIVegEHniyNapvPjNooo5L+wjJaHhDOb1ZjgxPwucs70Gi0QDK2kSANOa39dMF/ky+T+j/H7Jcz6piwvGl7GZ/NcGJJTpAUBTO6299kKfed2WkuJIRWvPyDjHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202775; c=relaxed/simple;
	bh=uYi6b4lxY7joRSjwFWGu5UViREJAVzxZg9lIqCDsTQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1d3bqsKh1JmesKYUf9dcc8jGKzps6GW1xSprODSnzBYxns/RFSIaCrGcSon/EI2J9b1T6C7Lo5Kxr/Fqisv9gXGXxkL/4oMvTFxK/EKEGKEYkxzHCKt3FyOzufdwbb2PgaqpYQer6Xv+rBLOnORzZpoNRy2uxKzWiaj5+Qfk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vcdc0DDP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752202773; x=1783738773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYi6b4lxY7joRSjwFWGu5UViREJAVzxZg9lIqCDsTQc=;
  b=Vcdc0DDP/Tj9EQjUjRfZYBO5hMXHqepyhZCbOYZ2iyHc+HvJGq4twnHP
   /HXKR3AlM6QBPp40E+pGKyGCa/zrzsVfQpSeeN2JRGooGGvb2Db2l6fHr
   BmrxORvC38C5DQhln+whltQBi24xDQgx+78lry7t1hjXX34hCpmT1DaNP
   Kj6ThdU2K3LPc5acYcuroekMXpfR2QE2/Eyx4dkNmcI2CuGarHhHkEunC
   +ALhn39PoZD77cF6XyPkDqYeRAyuhbeYuEAj4KfTjmwPmCqf3eobohqLJ
   1XQsAnu1n9EODWwTPrjkAMUk6dGvv521iDhh+ICt8WbFw4hkd7qdgTbMF
   g==;
X-CSE-ConnectionGUID: S0gpyRSmSO2dVyeprtu0zg==
X-CSE-MsgGUID: dnY58yDgRuSbJOWBlQpKUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54586648"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54586648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:59:32 -0700
X-CSE-ConnectionGUID: nwfQO6SDQMiX24cSffMjhQ==
X-CSE-MsgGUID: +lNfvEFYSzOi/U+16I4Y4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="187247826"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jul 2025 19:59:29 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua3yx-0005mh-0i;
	Fri, 11 Jul 2025 02:59:27 +0000
Date: Fri, 11 Jul 2025 10:58:58 +0800
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
Subject: Re: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <202507111042.NdeRL3wM-lkp@intel.com>
References: <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>

Hi Remi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f8f559752d573a051a984adda8d2d1464f92f954]

url:    https://github.com/intel-lab-lkp/linux/commits/Remi-Buisson-via-B4-Relay/dt-bindings-iio-imu-Add-inv_icm45600/20250710-170143
base:   f8f559752d573a051a984adda8d2d1464f92f954
patch link:    https://lore.kernel.org/r/20250710-add_newport_driver-v2-2-bf76d8142ef2%40tdk.com
patch subject: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600 driver
config: i386-buildonly-randconfig-001-20250711 (https://download.01.org/0day-ci/archive/20250711/202507111042.NdeRL3wM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507111042.NdeRL3wM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507111042.NdeRL3wM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hsi/hsi_boardinfo.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hsi/hsi_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hte/hte.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/channel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/channel_mgmt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/hv_proc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/mshv_common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/mshv_root_hv_call.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/ring_buffer.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/vmbus_drv.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/adt7x10.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/hwmon-vid.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/hwmon.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/ltc2947-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/max1111.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/nct6775-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/pmbus/pmbus_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/sch56xx-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwspinlock/hwspinlock_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-etm-perf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-platform.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-syscfg.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-sysfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-tmc-etr.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-trace-id.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/intel_th/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/intel_th/msu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/stm/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/stm/policy.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/algos/i2c-algo-bit.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/algos/i2c-algo-pca.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/algos/i2c-algo-pcf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-amd-mp2-pci.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-designware-slave.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-pasemi-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-piix4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-viai2c-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-atr.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-acpi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-of-prober.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-of.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-slave.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-smbus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-mux.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-smbus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i3c/device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i3c/master/dw-i3c-master.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl313_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl345_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl355_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl367.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl372.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl380.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/bma400_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/bmc150-accel-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/bmi088-accel-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/fxls8962af-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/kxsd9.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/mma7455_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/mma9551_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/st_accel_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/ad7091r-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/ad7606.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/ltc2497-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/qcom-vadc-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/afe/iio-rescale.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/buffer/industrialio-buffer-dma.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/buffer/kfifo_buf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/chemical/bme680_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/chemical/ens160_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/chemical/sps30.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/hid-sensors/hid-sensor-attributes.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/hid-sensors/hid-sensor-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/inv_sensors/inv_sensors_timestamp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/ms_sensors/ms_sensors_i2c.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/ssp_sensors/ssp_dev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/ssp_sensors/ssp_iio.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_buffer.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_i2c.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_spi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dac/ad3552r-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dac/ad5592r-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dac/ad5686.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dummy/iio_dummy_evgen.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/gyro/bmg160_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/gyro/fxas21002c_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/gyro/st_gyro_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/humidity/hts221_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/adis.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bmi160/bmi160_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bmi270/bmi270_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bmi323/bmi323_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bno055/bno055.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/fxos8700_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
>> drivers/iio/imu/inv_icm45600/inv_icm45600_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/industrialio-backend.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/industrialio-configfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/industrialio-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/industrialio-event.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/industrialio-sw-device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/industrialio-sw-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/industrialio-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/light/st_uvis25_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/magnetometer/bmc150_magn.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/magnetometer/hmc5843_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/magnetometer/rm3100-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/magnetometer/st_magn_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/bmp280-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/bmp280-regmap.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/hsc030pa.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/mpl115.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/mprls0025pa.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/ms5611_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/st_pressure_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/pressure/zpa2326.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/addr.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/cache.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/cgroup.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/cm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/cma.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/cq.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/ib_core_uverbs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/iwcm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/mad.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/mr_pool.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/nldev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/rdma_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/restrack.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/roce_gid_mgmt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/rw.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/sa_query.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/security.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/sysfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/ucaps.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/umem_dmabuf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/uverbs_cmd.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/uverbs_ioctl.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/uverbs_main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/core/uverbs_std_types.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/sw/rdmavt/ah.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/sw/rdmavt/cq.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/sw/rdmavt/mcast.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/sw/rdmavt/mr.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/sw/rdmavt/qp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/sw/rdmavt/rc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/sw/rdmavt/vt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/ulp/rtrs/rtrs-clt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/ulp/rtrs/rtrs-srv.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/infiniband/ulp/rtrs/rtrs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/ff-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/ff-memless.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/gameport/gameport.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/input-poller.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/input.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/joystick/iforce/iforce-main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/joystick/iforce/iforce-packets.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/misc/ad714x.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/misc/adxl34x.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/misc/cma3000_d0x.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/rmi4/rmi_2d_sensor.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/rmi4/rmi_bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/rmi4/rmi_driver.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/serio/hil_mlc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/serio/hp_sdc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/serio/i8042.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/serio/libps2.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/serio/serio.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/sparse-keymap.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/ad7879.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/cyttsp_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/goodix_berlin_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/tsc200x-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/wm9705.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/wm9712.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/wm9713.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/input/touchscreen/wm97xx-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/icc-clk.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/imx/imx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/mediatek/icc-emi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/qcom/bcm-voter.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/qcom/icc-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/qcom/icc-rpm-clocks.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/qcom/icc-rpm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/qcom/icc-rpmh.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/interconnect/qcom/smd-rpm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iommu/dma-iommu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iommu/intel/dmar.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iommu/intel/iommu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iommu/io-pgfault.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

