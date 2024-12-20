Return-Path: <linux-iio+bounces-13723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9439F96BF
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 17:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB621887199
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D221A438;
	Fri, 20 Dec 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/deixQq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF2218EAC;
	Fri, 20 Dec 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712794; cv=none; b=o17Rovi0PsDiQ8xs775MY/62Ckcy6KBaOdq1PA1PZST+6OBM6ZzVqIMbGK4yYYjMxwk0tObWFrWOc9r2KdifvZETtV5mfxY81q9xlJ2KWY48FKZMOFu8Co2GG9TSoo7q7aXutsqdeCxxJPMOoQBjX9MltUSiy1O48LhkX15C7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712794; c=relaxed/simple;
	bh=U/1mKpQTpHvOqgUoNrg55elV0rI3c1VcRHbvyZXZdRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8fOU8N5ab/y+zwOgdHFWRvfTIP3iyTo6OvfWFdYiSNPbXlW7ZHGtjbCDomTTb88CIBV63EIQCbK7VSs2rIh8wd8KTaU78x+iw2y+fOiOw90FtcykBGA/nQMqgQ+pOm1TEDhNTQnIXBhHIpF2y5EiGXXxQRLob0BfoTbwxvGXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/deixQq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734712791; x=1766248791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U/1mKpQTpHvOqgUoNrg55elV0rI3c1VcRHbvyZXZdRw=;
  b=n/deixQqvxT6LtCi18xeZ8iy6jb74usJp8+Iyc+nwFSDUh/HEwWTqxUz
   DDK7mkvQF046gL1VO8KcbsY4IQJaXlawvKaJ5gmw+zlNGDXxpilpx35lu
   4rn5OXT2dHu9AevLlaoPDVj/DrkvvwD5BuZ0ew6PYQcwiq5PVmWhhJDXs
   KHJiFzePkYSRael9lz5tcFtq1LHDeNfSThMrdkzn7gC39equp9AlQtNFG
   vNTr9u9DESfpht1blAUx5eq/Ju87dArJv3v8KJpGFUGzwajrmjsmzERD4
   wE2frRtXeDihPSocwfZ/xFkNfpuch0nZmCzr/6jRcnXBVhgVASk1+pS92
   Q==;
X-CSE-ConnectionGUID: 6LnsNDcVTWu1ikqYtTw2wA==
X-CSE-MsgGUID: g1gOTqGbRhyhzCShQan8aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35295809"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35295809"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 08:39:50 -0800
X-CSE-ConnectionGUID: yC19I6f+QhC3XADwBab0PQ==
X-CSE-MsgGUID: /KVqTUQTRw2/FOTI+vtuvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98386685"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Dec 2024 08:39:48 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOg2T-0001QD-2x;
	Fri, 20 Dec 2024 16:39:45 +0000
Date: Sat, 21 Dec 2024 00:39:06 +0800
From: kernel test robot <lkp@intel.com>
To: Esteban Blanc <eblanc@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
Subject: Re: [PATCH v2 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <202412210010.ddQlStza-lkp@intel.com>
References: <20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5@baylibre.com>

Hi Esteban,

kernel test robot noticed the following build errors:

[auto build test ERROR on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/dt-bindings-iio-adc-add-ADI-ad4030-ad4630-and-ad4632/20241220-001408
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5%40baylibre.com
patch subject: [PATCH v2 2/6] iio: adc: ad4030: add driver for ad4030-24
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241221/202412210010.ddQlStza-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412210010.ddQlStza-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210010.ddQlStza-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad4030.c: In function 'ad4030_get_chan_calibscale':
>> drivers/iio/adc/ad4030.c:346:16: error: implicit declaration of function 'get_unaligned_be16' [-Wimplicit-function-declaration]
     346 |         gain = get_unaligned_be16(st->rx_data.raw);
         |                ^~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad4030.c: In function 'ad4030_get_chan_calibbias':
>> drivers/iio/adc/ad4030.c:375:38: error: implicit declaration of function 'get_unaligned_be24' [-Wimplicit-function-declaration]
     375 |                 *val = sign_extend32(get_unaligned_be24(st->rx_data.raw), 23);
         |                                      ^~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad4030.c: In function 'ad4030_set_chan_calibscale':
>> drivers/iio/adc/ad4030.c:399:9: error: implicit declaration of function 'put_unaligned_be16' [-Wimplicit-function-declaration]
     399 |         put_unaligned_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad4030.c: In function 'ad4030_set_chan_calibbias':
>> drivers/iio/adc/ad4030.c:424:17: error: implicit declaration of function 'put_unaligned_be24' [-Wimplicit-function-declaration]
     424 |                 put_unaligned_be24(offset, st->tx_data);
         |                 ^~~~~~~~~~~~~~~~~~


vim +/get_unaligned_be16 +346 drivers/iio/adc/ad4030.c

   331	
   332	static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
   333					      struct iio_chan_spec const *chan,
   334					      int *val,
   335					      int *val2)
   336	{
   337		struct ad4030_state *st = iio_priv(indio_dev);
   338		u16 gain;
   339		int ret;
   340	
   341		ret = regmap_bulk_read(st->regmap, AD4030_REG_GAIN_CHAN(chan->address),
   342				       st->rx_data.raw, AD4030_REG_GAIN_BYTES_NB);
   343		if (ret)
   344			return ret;
   345	
 > 346		gain = get_unaligned_be16(st->rx_data.raw);
   347	
   348		/* From datasheet: multiplied output = input × gain word/0x8000 */
   349		*val = gain / 0x8000;
   350		*val2 = mul_u64_u32_div(gain % 0x8000, NANO, 0x8000);
   351	
   352		return IIO_VAL_INT_PLUS_NANO;
   353	}
   354	
   355	/* Returns the offset where 1 LSB = (VREF/2^precision_bits - 1)/gain */
   356	static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
   357					     struct iio_chan_spec const *chan,
   358					     int *val)
   359	{
   360		struct ad4030_state *st = iio_priv(indio_dev);
   361		int ret;
   362	
   363		ret = regmap_bulk_read(st->regmap,
   364				       AD4030_REG_OFFSET_CHAN(chan->address),
   365				       st->rx_data.raw, AD4030_REG_OFFSET_BYTES_NB);
   366		if (ret)
   367			return ret;
   368	
   369		switch (st->chip->precision_bits) {
   370		case 16:
   371			*val = sign_extend32(get_unaligned_be16(st->rx_data.raw), 15);
   372			return IIO_VAL_INT;
   373	
   374		case 24:
 > 375			*val = sign_extend32(get_unaligned_be24(st->rx_data.raw), 23);
   376			return IIO_VAL_INT;
   377	
   378		default:
   379			return -EINVAL;
   380		}
   381	}
   382	
   383	static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
   384					      struct iio_chan_spec const *chan,
   385					      int gain_int,
   386					      int gain_frac)
   387	{
   388		struct ad4030_state *st = iio_priv(indio_dev);
   389		u64 gain;
   390	
   391		if (gain_int < 0 || gain_frac < 0)
   392			return -EINVAL;
   393	
   394		gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
   395	
   396		if (gain > AD4030_REG_GAIN_MAX_GAIN)
   397			return -EINVAL;
   398	
 > 399		put_unaligned_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO),
   400				   st->tx_data);
   401	
   402		return regmap_bulk_write(st->regmap,
   403					 AD4030_REG_GAIN_CHAN(chan->address),
   404					 st->tx_data, AD4030_REG_GAIN_BYTES_NB);
   405	}
   406	
   407	static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
   408					     struct iio_chan_spec const *chan,
   409					     int offset)
   410	{
   411		struct ad4030_state *st = iio_priv(indio_dev);
   412	
   413		if (offset < st->offset_avail[0] || offset > st->offset_avail[2])
   414			return -EINVAL;
   415	
   416		st->tx_data[2] = 0;
   417	
   418		switch (st->chip->precision_bits) {
   419		case 16:
   420			put_unaligned_be16(offset, st->tx_data);
   421			break;
   422	
   423		case 24:
 > 424			put_unaligned_be24(offset, st->tx_data);
   425			break;
   426	
   427		default:
   428			return -EINVAL;
   429		}
   430	
   431		return regmap_bulk_write(st->regmap,
   432					 AD4030_REG_OFFSET_CHAN(chan->address),
   433					 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
   434	}
   435	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

