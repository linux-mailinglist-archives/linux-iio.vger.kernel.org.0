Return-Path: <linux-iio+bounces-10824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FE9A55DA
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FB21C20DC1
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4746197A7C;
	Sun, 20 Oct 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgSyavW6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456B194AD6;
	Sun, 20 Oct 2024 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729449067; cv=none; b=N4NH49B7X34gsoCNMEJfAr87UvHZrB5TiD3mso2oDvZHQPtpYtwzsGXMUVOFFxtPsr31mSN+vTonjJ1wTnaVeouo4rSn2cMepuEDqGob1wl9Zi0vZ6hblQm6xz1r1XTDUyEbRHMZFnViaV3B/260bvD5+dlTY2fot4pX2/PZq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729449067; c=relaxed/simple;
	bh=v39Rr5eF3eWe0K5Su3ujXYO57zb/mrOvhsFkm+1e1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY+RCFK1KOcCRkcAdXdvybnNrfQyFLiPJXglGdMir/ZOGx3k/UCRiF92HToBkzmeP7ufrLKVNzocmXTuXoyTKZzRnShCnaYLyww9oLI9A1UZwSWHL6rD+vz28GNAmCfOf4JwvGwJwMzQeZbhM0YBPVD7LtDOPs6H3unltsRsbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgSyavW6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729449065; x=1760985065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v39Rr5eF3eWe0K5Su3ujXYO57zb/mrOvhsFkm+1e1nU=;
  b=OgSyavW6TdS2Hu03Fyl1SeYcvOCrEyXPdXqj8R7aYQCecRS0bx1bV8OO
   odvtZ77Pduno001HMZxnotJCPmzKs1k/LvjkwYBN6Siajhowmsil0Dtzo
   n3czd4hRjB6DIYzuBAxYQ+qEPufqcFbMyrLfNS0IbrTOVu2PJ1a9pY5i3
   g4laPKmknQ5YmZqd0wzVy4zwNRaxcG/bfvFomMlGQ+gzyvn2OFl8LK6ND
   o3HHzjg5M1rLGuC54fLO5w4GQM1CGyRuklZ6wYP64Os/kufTuej/JbeDw
   URlMLPX+/BxDwQTeyLDtlEQgn1kMW2Ev/oE958PqEbdzR7jTOf6ZZeCtG
   Q==;
X-CSE-ConnectionGUID: r0ndL4RfQl6axx+phGfxeQ==
X-CSE-MsgGUID: MqNBRm1nQ5ysCbfX3xeacA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32840925"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="32840925"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 11:31:05 -0700
X-CSE-ConnectionGUID: OzBYEk6pRU2avgDpHiDMBQ==
X-CSE-MsgGUID: G8xMv0IUThyf5uIazvRcLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="116786918"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Oct 2024 11:31:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2ahg-000Qgy-1Q;
	Sun, 20 Oct 2024 18:31:00 +0000
Date: Mon, 21 Oct 2024 02:30:28 +0800
From: kernel test robot <lkp@intel.com>
To: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: invensense: fix multiple odr switch when FIFO is off
Message-ID: <202410210200.tPt6CQU4-lkp@intel.com>
References: <20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-v1-1-1bcfa70a747b@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-v1-1-1bcfa70a747b@tdk.com>

Hi Jean-Baptiste,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c3e9df514041ec6c46be83801b1891392f4522f7]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Baptiste-Maneyrol-via-B4-Relay/iio-invensense-fix-multiple-odr-switch-when-FIFO-is-off/20241017-220821
base:   c3e9df514041ec6c46be83801b1891392f4522f7
patch link:    https://lore.kernel.org/r/20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-v1-1-1bcfa70a747b%40tdk.com
patch subject: [PATCH] iio: invensense: fix multiple odr switch when FIFO is off
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20241021/202410210200.tPt6CQU4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410210200.tPt6CQU4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410210200.tPt6CQU4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c: In function 'inv_icm42600_gyro_update_scan_mode':
>> drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c:103:39: warning: unused variable 'ts' [-Wunused-variable]
     103 |         struct inv_sensors_timestamp *ts = &gyro_st->ts;
         |                                       ^~
--
   drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c: In function 'inv_icm42600_accel_update_scan_mode':
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:203:39: warning: unused variable 'ts' [-Wunused-variable]
     203 |         struct inv_sensors_timestamp *ts = &accel_st->ts;
         |                                       ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/ts +103 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c

7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22   96  
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22   97  /* enable gyroscope sensor and FIFO write */
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22   98  static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22   99  					      const unsigned long *scan_mask)
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  100  {
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  101  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
a1432b5b4f4c44 Jean-Baptiste Maneyrol    2024-04-22  102  	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
a1432b5b4f4c44 Jean-Baptiste Maneyrol    2024-04-22 @103  	struct inv_sensors_timestamp *ts = &gyro_st->ts;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  104  	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  105  	unsigned int fifo_en = 0;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  106  	unsigned int sleep_gyro = 0;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  107  	unsigned int sleep_temp = 0;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  108  	unsigned int sleep;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  109  	int ret;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  110  
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  111  	mutex_lock(&st->lock);
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  112  
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  113  	if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP) {
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  114  		/* enable temp sensor */
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  115  		ret = inv_icm42600_set_temp_conf(st, true, &sleep_temp);
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  116  		if (ret)
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  117  			goto out_unlock;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  118  		fifo_en |= INV_ICM42600_SENSOR_TEMP;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  119  	}
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  120  
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  121  	if (*scan_mask & INV_ICM42600_SCAN_MASK_GYRO_3AXIS) {
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  122  		/* enable gyro sensor */
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  123  		conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  124  		ret = inv_icm42600_set_gyro_conf(st, &conf, &sleep_gyro);
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  125  		if (ret)
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  126  			goto out_unlock;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  127  		fifo_en |= INV_ICM42600_SENSOR_GYRO;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  128  	}
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  129  
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  130  	/* update data FIFO write */
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  131  	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  132  
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  133  out_unlock:
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  134  	mutex_unlock(&st->lock);
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  135  	/* sleep maximum required time */
c788b9e56acd46 Bragatheswaran Manickavel 2023-10-27  136  	sleep = max(sleep_gyro, sleep_temp);
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  137  	if (sleep)
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  138  		msleep(sleep);
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  139  	return ret;
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  140  }
7f85e42a6c54c0 Jean-Baptiste Maneyrol    2020-06-22  141  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

