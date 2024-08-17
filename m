Return-Path: <linux-iio+bounces-8561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70EC9558D8
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0F41C20C8A
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0CF81751;
	Sat, 17 Aug 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rf9jTElJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D322770E;
	Sat, 17 Aug 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911291; cv=none; b=KBfygst3ZJSTWXEbBrb6kUQKRwsmKnF+qo3GfCTuv3BKWdsX28WzRNWoKvXgsdoF0GEzhlyf9ODKg+OPkfFv+Sm9gWKICAVWcbfgQhlUO+xU8odqZp4ZwyMlK3rK1mEhiwgBNIVFH4InXzu/gcveU7OO6oAOjNc4jp/xNM3P6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911291; c=relaxed/simple;
	bh=LZX1B+Io8BPETsAKw2XMgIdDqyatJYHuwjQzXELe6zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5zNsNPZCgofpJ4sk2O1g8mbXdTfL80BrEDvsHla6vD5g5ZeGbblKZ198sXj0IXiFboAjaobcUwJSaGYbR/apPkElltcIMKyxae6cJa7f51bAOmnnZ0crJHK7ixHtk3sDt5rEYBDdUgj54fDp0VMNUfoZt5lInSSnl9ZxM5NF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rf9jTElJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723911289; x=1755447289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LZX1B+Io8BPETsAKw2XMgIdDqyatJYHuwjQzXELe6zM=;
  b=Rf9jTElJBN/07YILmw/fIMnvFHP8yFH3xQg8ectb7mu39YPso+lAuP03
   FaYc5c7W4j+zbEr4CxhZnoT1nhtOVvgcnwZwRtDbRdjykB3nmA2O929wo
   aNe5HXrgc6qEPbsUyrTodxpQuVmobmYotZkN9/feLbS80si379RJlwWV2
   JvENtsoNnl+yF9NCSATD8Ys/77xIRxpm8vJpY6K7sGramvouK2toxAe/u
   JuiJ+w/rZbxhlvnI6QwoDPVRNJ+d0G1KfzsheWlkIG1AYfZsEA6gDrUCE
   usZXwR7vu4EXhx9GxKSR83EADFT/VQiN/yLOBLHwyvrnjIK3kckMUuAUo
   Q==;
X-CSE-ConnectionGUID: 4xAg0rY3S7+HPg+hfiSBaQ==
X-CSE-MsgGUID: V6tWL6UFTvqFbA9H9R14wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="22073150"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="22073150"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 09:14:48 -0700
X-CSE-ConnectionGUID: aRP8oc91Qg+Dd0a247pXqw==
X-CSE-MsgGUID: xGXM+jRMTMWMdg0hVwJrOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="59990838"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Aug 2024 09:14:45 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfM4g-0007dK-2v;
	Sat, 17 Aug 2024 16:14:42 +0000
Date: Sun, 18 Aug 2024 00:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
	Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iio: imu: smi240: imu driver
Message-ID: <202408172325.mMMFMiZJ-lkp@intel.com>
References: <20240815152545.7705-3-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815152545.7705-3-Jianping.Shen@de.bosch.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianping-Shen-de-bosch-com/dt-bindings-iio-imu-smi240-devicetree-binding/20240815-234739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240815152545.7705-3-Jianping.Shen%40de.bosch.com
patch subject: [PATCH v3 2/2] iio: imu: smi240: imu driver
config: microblaze-randconfig-r132-20240817 (https://download.01.org/0day-ci/archive/20240817/202408172325.mMMFMiZJ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240817/202408172325.mMMFMiZJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408172325.mMMFMiZJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/iio/imu/smi240/smi240_spi.c:69:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] request @@     got int @@
   drivers/iio/imu/smi240/smi240_spi.c:69:17: sparse:     expected restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:69:17: sparse:     got int
   drivers/iio/imu/smi240/smi240_spi.c:70:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:70:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:70:17: sparse:    right side has type int
   drivers/iio/imu/smi240/smi240_spi.c:71:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:71:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:71:17: sparse:    right side has type unsigned long
   drivers/iio/imu/smi240/smi240_spi.c:72:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] request @@
   drivers/iio/imu/smi240/smi240_spi.c:72:32: sparse:     expected unsigned int [usertype] data
   drivers/iio/imu/smi240/smi240_spi.c:72:32: sparse:     got restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:72:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:72:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:72:17: sparse:    right side has type unsigned char
>> drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] request @@
   drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse:     expected unsigned int [usertype] val
   drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse:     got restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse: sparse: cast from restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse: sparse: cast from restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse: sparse: cast from restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse: sparse: cast from restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:89:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] response @@     got unsigned int [usertype] @@
   drivers/iio/imu/smi240/smi240_spi.c:89:18: sparse:     expected restricted __be32 [addressable] [usertype] response
   drivers/iio/imu/smi240/smi240_spi.c:89:18: sparse:     got unsigned int [usertype]
   drivers/iio/imu/smi240/smi240_spi.c:91:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [addressable] [usertype] response @@
   drivers/iio/imu/smi240/smi240_spi.c:91:42: sparse:     expected unsigned int [usertype] data
   drivers/iio/imu/smi240/smi240_spi.c:91:42: sparse:     got restricted __be32 [addressable] [usertype] response
   drivers/iio/imu/smi240/smi240_spi.c:94:20: sparse: sparse: cast to restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:94:20: sparse: sparse: restricted __be32 degrades to integer
   drivers/iio/imu/smi240/smi240_spi.c:94:20: sparse: sparse: restricted __be32 degrades to integer
   drivers/iio/imu/smi240/smi240_spi.c:94:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] response @@     got unsigned long @@
   drivers/iio/imu/smi240/smi240_spi.c:94:18: sparse:     expected restricted __be32 [addressable] [usertype] response
   drivers/iio/imu/smi240/smi240_spi.c:94:18: sparse:     got unsigned long
   drivers/iio/imu/smi240/smi240_spi.c:108:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] request @@     got int @@
   drivers/iio/imu/smi240/smi240_spi.c:108:17: sparse:     expected restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:108:17: sparse:     got int
   drivers/iio/imu/smi240/smi240_spi.c:109:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:109:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:109:17: sparse:    right side has type int
   drivers/iio/imu/smi240/smi240_spi.c:110:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:110:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:110:17: sparse:    right side has type unsigned long
   drivers/iio/imu/smi240/smi240_spi.c:111:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:111:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:111:17: sparse:    right side has type unsigned long
   drivers/iio/imu/smi240/smi240_spi.c:112:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] request @@
   drivers/iio/imu/smi240/smi240_spi.c:112:32: sparse:     expected unsigned int [usertype] data
   drivers/iio/imu/smi240/smi240_spi.c:112:32: sparse:     got restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:112:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:112:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:112:17: sparse:    right side has type unsigned char
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] request @@
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse:     expected unsigned int [usertype] val
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse:     got restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse: sparse: cast from restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse: sparse: cast from restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse: sparse: cast from restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse: sparse: cast from restricted __be32

vim +73 drivers/iio/imu/smi240/smi240_spi.c

    58	
    59	static int smi240_regmap_spi_read(void *context, const void *reg_buf,
    60					  size_t reg_size, void *val_buf,
    61					  size_t val_size)
    62	{
    63		int ret;
    64		__be32 request, response;
    65		struct spi_device *spi = context;
    66		struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
    67		struct smi240_data *data = iio_priv(indio_dev);
    68	
    69		request = SMI240_BUS_ID << 30;
    70		request |= FIELD_PREP(SMI240_CAP_BIT_MASK, data->capture);
    71		request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
    72		request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
  > 73		request = cpu_to_be32(request);
    74	
    75		/*
    76		 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
    77		 * SPI protocol, where the slave interface responds to
    78		 * the Master request in the next frame.
    79		 * CS signal must toggle (> 700 ns) between the frames.
    80		 */
    81		ret = spi_write(spi, &request, sizeof(request));
    82		if (ret)
    83			return ret;
    84	
    85		ret = spi_read(spi, &response, sizeof(response));
    86		if (ret)
    87			return ret;
    88	
    89		response = be32_to_cpu(response);
    90	
    91		if (!smi240_sensor_data_is_valid(response))
    92			return -EIO;
    93	
    94		response = FIELD_GET(SMI240_READ_DATA_MASK, response);
    95		memcpy(val_buf, &response, val_size);
    96	
    97		return 0;
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

