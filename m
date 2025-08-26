Return-Path: <linux-iio+bounces-23300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F5B3624A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371F61BC0165
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A833EB1D;
	Tue, 26 Aug 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nT4E0zj2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3529338F51;
	Tue, 26 Aug 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213972; cv=none; b=OgR+xsHru5fVriViZWhFvtiM8ahfJ4h+mJmuNUd8yuO8AiuyQpduCa9fhoaDdw4++CPDizlXK8CyKOBkW1agMuBa1owlkR7zZKZT/rOrqPF7ko0QYBu1sJxuIx792iIYuJw4VT6G1S9jeat3rYDMOzHTkip7LffP1xdz+ye5PCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213972; c=relaxed/simple;
	bh=N5Lv6gxPb1gIs50nNVHbShegReo0NnYRAemVW9LBZAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8urdBM4XMUxDJq/Ck9I2YFwHCPsCp0Au8M1pkkHn8p/UM7qu908YF+2DU5JwhBm0Z7aVr9owilb3GHax11HwMl1dNfiEvTI1a2hLBH9PJSzuQMnCYueV8ekB9G14ZrRjVpDXTyGZU9/LDPs9o17Mtp81f/qxk3o8ehqrxUTCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nT4E0zj2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756213971; x=1787749971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5Lv6gxPb1gIs50nNVHbShegReo0NnYRAemVW9LBZAk=;
  b=nT4E0zj254y6b0FrPRmH9icuewWIwJ8C8XRICpVjXv62IYGpXErB/6l0
   2YdLkqKl5Tmdb2w8pgzr3Ti9ulz/QyA4M02gN5FotjVEhTnX7Wk4q5XIM
   +bf67szt8nofGhXNYr+EOJtcU7RbyY+V0b5OfhMa0ooNrcfjWT7B35Ag5
   AYE3MPxNiVkskNL7VQp/eHPuoaqMSjXHuwYSHouK9YuiryTpScgKQb6ZF
   1ftPIhcGO5DSF8z5uyhQWi/Pc2kc0hZEUu2EadtJsJ5sYS2AHNkXDgkWI
   EYdPClUCBl6Bo137kceZX/04Yn2ahRHCvttl2GstZBAGgGYByrp4XrM5F
   Q==;
X-CSE-ConnectionGUID: OuvhAvHnS26XyeGMMZ4BZA==
X-CSE-MsgGUID: doBxyOBxSvi/mWDRVzgGDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58592565"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58592565"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 06:12:50 -0700
X-CSE-ConnectionGUID: PC0eTIDzTAunXwSIbEKgdA==
X-CSE-MsgGUID: yLW5rj20Q9+thwdV2DfLOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200519421"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 06:12:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqtTf-000PgZ-2o;
	Tue, 26 Aug 2025 13:12:43 +0000
Date: Tue, 26 Aug 2025 21:10:41 +0800
From: kernel test robot <lkp@intel.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
	jlc23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	Marcelo.Schmitt@analog.com, dumitru.ceclan@analog.com,
	Jonathan.Santos@analog.com, dragos.bogdan@analog.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add initial support for MAX22531 ADC
Message-ID: <202508262023.u2lGZ2mB-lkp@intel.com>
References: <edc52c93e0d4e08619ba8a98674aeb7d49e6dd1b.1756115378.git.jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc52c93e0d4e08619ba8a98674aeb7d49e6dd1b.1756115378.git.jain.abhinav177@gmail.com>

Hi Abhinav,

kernel test robot noticed the following build errors:

[auto build test ERROR on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhinav-Jain/dt-bindings-iio-adc-Add-device-tree-binding-for-MAX22531-ADC/20250826-052702
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/edc52c93e0d4e08619ba8a98674aeb7d49e6dd1b.1756115378.git.jain.abhinav177%40gmail.com
patch subject: [PATCH v1 2/2] iio: adc: Add initial support for MAX22531 ADC
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250826/202508262023.u2lGZ2mB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508262023.u2lGZ2mB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508262023.u2lGZ2mB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/max22531.c: In function 'max22531_reg_read':
>> drivers/iio/adc/max22531.c:76:15: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      76 |         cmd = FIELD_PREP(MAX22531_REG_ADDR_MASK, reg);
         |               ^~~~~~~~~~
   drivers/iio/adc/max22531.c: In function 'max22531_probe':
>> drivers/iio/adc/max22531.c:154:13: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     154 |             FIELD_GET(MAX22531_DEVICE_REV_MSK, prod_id) != MAX22531_DEVICE_REV)
         |             ^~~~~~~~~


vim +/FIELD_PREP +76 drivers/iio/adc/max22531.c

    70	
    71	static int max22531_reg_read(struct max22531 *adc, unsigned int reg,
    72				     unsigned int *readval)
    73	{
    74		u8 cmd;
    75	
  > 76		cmd = FIELD_PREP(MAX22531_REG_ADDR_MASK, reg);
    77		*readval = spi_w8r16be(adc->spi_dev, cmd);
    78		if (*readval < 0)
    79			return *readval;
    80	
    81		return 0;
    82	}
    83	
    84	static int max22531_read_raw(struct iio_dev *indio_dev,
    85				     struct iio_chan_spec const *chan,
    86				     int *val, int *val2, long mask)
    87	{
    88		struct max22531 *adc = iio_priv(indio_dev);
    89		int ret;
    90	
    91		switch (mask) {
    92		case IIO_CHAN_INFO_RAW:
    93			ret = max22531_reg_read(adc, MAX22531_REG_ADC_CHAN(chan->channel), val);
    94			if (ret)
    95				return ret;
    96		return IIO_VAL_INT;
    97	
    98		case IIO_CHAN_INFO_AVERAGE_RAW:
    99			ret = max22531_reg_read(adc, MAX22531_REG_FADC_CHAN(chan->channel), val);
   100			if (ret)
   101				return ret;
   102			return IIO_VAL_INT;
   103	
   104		case IIO_CHAN_INFO_SCALE:
   105			*val = MAX22531_VREF_MV;
   106			*val2 = 12;
   107	
   108			return IIO_VAL_FRACTIONAL_LOG2;
   109	
   110		default:
   111			return -EINVAL;
   112		}
   113	}
   114	
   115	static const struct iio_info max22531_info = {
   116		.read_raw = max22531_read_raw,
   117	};
   118	
   119	static int max22531_probe(struct spi_device *spi)
   120	{
   121		struct iio_dev *indio_dev;
   122		struct max22531 *adc;
   123		unsigned int prod_id;
   124		int ret;
   125	
   126		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
   127		if (!indio_dev)
   128			return -ENOMEM;
   129	
   130		adc = iio_priv(indio_dev);
   131		adc->spi_dev = spi;
   132		adc->chip_info = spi_get_device_match_data(spi);
   133		if (!adc->chip_info)
   134			return dev_err_probe(&spi->dev, -EINVAL,
   135					"no chip info\n");
   136	
   137		indio_dev->name = adc->chip_info->name;
   138		indio_dev->info = &max22531_info;
   139		indio_dev->channels = max22531_channels;
   140		indio_dev->num_channels = ARRAY_SIZE(max22531_channels);
   141	
   142		ret = devm_regulator_get_enable(&spi->dev, "vddl");
   143		if (ret)
   144			return dev_err_probe(&spi->dev, ret,
   145			       "Failed to retrieve power logic supply.\n");
   146	
   147		ret = devm_regulator_get_enable(&spi->dev, "vddpl");
   148		if (ret)
   149			return dev_err_probe(&spi->dev, ret,
   150			       "Failed to retrieve isolated DC-DC supply.\n");
   151	
   152		ret = max22531_reg_read(adc, MAX22531_REG_PROD_ID, &prod_id);
   153		if (ret ||
 > 154		    FIELD_GET(MAX22531_DEVICE_REV_MSK, prod_id) != MAX22531_DEVICE_REV)
   155			dev_warn(&spi->dev, "PROD_ID verification failed\n");
   156	
   157		return devm_iio_device_register(&spi->dev, indio_dev);
   158	}
   159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

