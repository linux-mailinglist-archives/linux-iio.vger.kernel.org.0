Return-Path: <linux-iio+bounces-4939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660718C2D94
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 01:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99BD1F21BA0
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCAB176FB3;
	Fri, 10 May 2024 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0L6mQVa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935C171E6A;
	Fri, 10 May 2024 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383482; cv=none; b=liBJ7Tgu57ZQ1fA2BLadA16JimReDXfrn6TJkfJfoI+F4uzqyOofJCXDIgB8heUfQAS0HCOjPiGwgqvB16fpgmbax0hDTt3XyGIOS+ur3zJysqHq0RA5HV6CPlMxMc3Emg4pybCTaUH+RDZjFmwByK0G1cnFf/WQevUBY5/io7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383482; c=relaxed/simple;
	bh=CFfTjMpZwa0nTJjNm3L4qTZeh/Pp/1mtOQRR2uaqwLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLGNPtw41gcHOh1O9i5PXGPULnVhLKgrzjlvMj6I3Ovx8WhpMH7pRBSVtumTHIo2VHJzflYCch0+ex8OLyvCSbjO5TsuHveZbKWxth6tnBVW0KjZj14FYAp0CYcF8QCpqY5BL30FSa0sd5sy6MHFUR15SDWo/L00IbKz2CmXHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0L6mQVa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715383480; x=1746919480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFfTjMpZwa0nTJjNm3L4qTZeh/Pp/1mtOQRR2uaqwLY=;
  b=U0L6mQVaCCOKzmQCMd8xVvGsZeuzUFmwWX7V40rK9FhwSq6UYnlHH4by
   Wumk08dJw1ToVFYNwk/mXxvdrWSn6njdddj2ykjN2IGz40+9LRN2aZr8Q
   CUW9/wb4LSUxqfB+lcPMl5xtCpkUzjrjoA4PhLwHnmF5pmr4at/TmNKOE
   gm32gusainoBE+mmSAB6RlssVnbTZ5GIksnyWU9TWOsvFojj9drVWkbch
   f2l7tnNKf0eGHkeKcbV6beAVc5J/1Y+POPpZGr+YluQgchxZJiDds1BqC
   m+p5s9Npm0Efa88wFFTtue1J2Vm5Sd0yY6jYx0qvXZ2Q2blsfMyDNkL/e
   A==;
X-CSE-ConnectionGUID: CFGsqlkyTNC3chxwB5iUsQ==
X-CSE-MsgGUID: rYAT6ljcRairXkd9ip7OQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="21989390"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="21989390"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 16:24:40 -0700
X-CSE-ConnectionGUID: L3apfB/vTXaRnwBwnTOBXQ==
X-CSE-MsgGUID: gakXD4PAS+a2Mv8trbS/MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="34633389"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 May 2024 16:24:37 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5ZbO-0006fr-0T;
	Fri, 10 May 2024 23:24:34 +0000
Date: Sat, 11 May 2024 07:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: Re: [PATCH v2 8/8] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <202405110735.khNaHnAJ-lkp@intel.com>
References: <20240508131310.880479-9-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508131310.880479-9-ramona.bolboaca13@gmail.com>

Hi Ramona,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[cannot apply to linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240508-211559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240508131310.880479-9-ramona.bolboaca13%40gmail.com
patch subject: [PATCH v2 8/8] drivers: iio: imu: Add support for adis1657x family
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240511/202405110735.khNaHnAJ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110735.khNaHnAJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405110735.khNaHnAJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/imu/adis16475.c:16:
   include/linux/iio/imu/adis.h:530:60: warning: 'struct iio_dev_attr' declared inside parameter list will not be visible outside of this definition or declaration
     530 |                                               const struct iio_dev_attr **buffer_attrs);
         |                                                            ^~~~~~~~~~~~
   drivers/iio/imu/adis16475.c: In function 'adis16475_probe':
>> drivers/iio/imu/adis16475.c:1959:69: error: passing argument 5 of 'devm_adis_setup_buffer_and_trigger_with_attrs' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1959 |                                                                     adis16475_fifo_attributes);
         |                                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                     |
         |                                                                     const struct attribute **
   include/linux/iio/imu/adis.h:530:75: note: expected 'const struct iio_dev_attr **' but argument is of type 'const struct attribute **'
     530 |                                               const struct iio_dev_attr **buffer_attrs);
         |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devm_adis_setup_buffer_and_trigger_with_attrs +1959 drivers/iio/imu/adis16475.c

  1912	
  1913	
  1914	static int adis16475_probe(struct spi_device *spi)
  1915	{
  1916		struct iio_dev *indio_dev;
  1917		struct adis16475 *st;
  1918		int ret;
  1919	
  1920		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
  1921		if (!indio_dev)
  1922			return -ENOMEM;
  1923	
  1924		st = iio_priv(indio_dev);
  1925	
  1926		st->info = spi_get_device_match_data(spi);
  1927		if (!st->info)
  1928			return -EINVAL;
  1929	
  1930		ret = adis_init(&st->adis, indio_dev, spi, &st->info->adis_data);
  1931		if (ret)
  1932			return ret;
  1933	
  1934		indio_dev->name = st->info->name;
  1935		indio_dev->channels = st->info->channels;
  1936		indio_dev->num_channels = st->info->num_channels;
  1937		if (st->info->flags & ADIS16475_HAS_FIFO)
  1938			indio_dev->info = &adis16575_info;
  1939		else
  1940			indio_dev->info = &adis16475_info;
  1941		indio_dev->modes = INDIO_DIRECT_MODE;
  1942	
  1943		ret = __adis_initial_startup(&st->adis);
  1944		if (ret)
  1945			return ret;
  1946	
  1947		ret = adis16475_config_irq_pin(st);
  1948		if (ret)
  1949			return ret;
  1950	
  1951		ret = adis16475_config_sync_mode(st);
  1952		if (ret)
  1953			return ret;
  1954	
  1955		if (st->info->flags & ADIS16475_HAS_FIFO) {
  1956			ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
  1957									    adis16475_trigger_handler_with_fifo,
  1958									    &adis16475_buffer_ops,
> 1959									    adis16475_fifo_attributes);
  1960			if (ret)
  1961				return ret;
  1962			/* Update overflow behavior to always overwrite the oldest sample. */
  1963			ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
  1964					       ADIS16575_OVERFLOW_MASK, (u16)ADIS16575_OVERWRITE_OLDEST);
  1965		} else {
  1966			ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
  1967								 adis16475_trigger_handler);
  1968		}
  1969		if (ret)
  1970			return ret;
  1971	
  1972		ret = devm_iio_device_register(&spi->dev, indio_dev);
  1973		if (ret)
  1974			return ret;
  1975	
  1976		adis16475_debugfs_init(indio_dev);
  1977	
  1978		return 0;
  1979	}
  1980	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

