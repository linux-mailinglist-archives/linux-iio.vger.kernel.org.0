Return-Path: <linux-iio+bounces-7871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3693B9F6
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 02:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4149A1C2188C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 00:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1B23CB;
	Thu, 25 Jul 2024 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZectMUm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9884690;
	Thu, 25 Jul 2024 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721868770; cv=none; b=WktIGNLJmOw7I9kBwNAsBSGIU+4kvf9yRlNiCzG0Ugbs+NhYW8NkCQWZoR2ioXmjTUtu5JAD/1JFfmQ2nqHiLvD6F3vapVzsmlPfN4TzvzURl6TWH11JTDHwcKueYBP3kjsfc863fworkuYl8xCihz+QyaiHBQYdJH6UCQdTwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721868770; c=relaxed/simple;
	bh=nN9l10S1PLpLe84PRmRYkGz0bC2R/lDEAnp4HMrQVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVg17+ZOfosrKnWivsu1cXERQaMDs7rTnB9QkPzJRNUlzUZlH04Ob/kSHnDD1DP5DTYICRrfDll59qYUvFvKoxyR/IrJ6uqh7RwPnNSifiGYR6ZT1Xhnui1XTfa4FHJMz1rYEWOB0rN96TIhpAnyIVhssvDjuYIex9CvJPp5vZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZectMUm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721868768; x=1753404768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nN9l10S1PLpLe84PRmRYkGz0bC2R/lDEAnp4HMrQVP4=;
  b=EZectMUmHi1u1WXYZVmQVaNaGrZyMT3LAbge68tbtNoIZS4HoDBWgfgt
   VAH6flceplP19eMUECfSNIrVSpuq/78v/FCd3HOLplCxmweRKhEHcxKd0
   sM5YlqP5FEK/IIw9aq4TkXHWSpoTlvaZk5FaC8qGJEMbxqlwd3P7jw4Tu
   kYdmLhSnwmuPp2grCRSguY8ne8n/fNmvngbU3GrGhTF9pD+Dx3lzrRB7M
   RbHEZqmhui4ilbpwX83Njj16rQrfx+HsMEeU9ARBEPDcGFQcEuN7T47AQ
   g+AMjxHfKMOEXEZfX34HESrkD6DztWr+nChUZyae04nq8hPRGa+Ct0tNc
   Q==;
X-CSE-ConnectionGUID: ZCvdstPPSdaOrL/z/UiqiA==
X-CSE-MsgGUID: trWDR8XqTQehpy/SpX35Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="22490602"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="22490602"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 17:52:48 -0700
X-CSE-ConnectionGUID: TxDt6hEcT0idrsKdH+w6Yg==
X-CSE-MsgGUID: Y/48FsoSSlOf12oKqrGo3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52631100"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jul 2024 17:52:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWmin-000nbk-0u;
	Thu, 25 Jul 2024 00:52:41 +0000
Date: Thu, 25 Jul 2024 08:52:08 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <202407250808.qn23hGFg-lkp@intel.com>
References: <20240724155517.12470-5-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724155517.12470-5-ramona.nechita@analog.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Alexandra-Nechita/dt-bindings-iio-adc-add-a7779-doc/20240725-000001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240724155517.12470-5-ramona.nechita%40analog.com
patch subject: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240725/202407250808.qn23hGFg-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407250808.qn23hGFg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407250808.qn23hGFg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad7779.c: In function 'ad7779_get_calibbias':
>> drivers/iio/adc/ad7779.c:420:22: warning: unused variable 'high' [-Wunused-variable]
     420 |         u8 low, mid, high;
         |                      ^~~~
>> drivers/iio/adc/ad7779.c:420:17: warning: unused variable 'mid' [-Wunused-variable]
     420 |         u8 low, mid, high;
         |                 ^~~
>> drivers/iio/adc/ad7779.c:420:12: warning: unused variable 'low' [-Wunused-variable]
     420 |         u8 low, mid, high;
         |            ^~~
   drivers/iio/adc/ad7779.c: In function 'ad7779_set_calibbias':
>> drivers/iio/adc/ad7779.c:445:22: warning: variable 'lsb' set but not used [-Wunused-but-set-variable]
     445 |         u8 msb, mid, lsb;
         |                      ^~~
>> drivers/iio/adc/ad7779.c:445:17: warning: variable 'mid' set but not used [-Wunused-but-set-variable]
     445 |         u8 msb, mid, lsb;
         |                 ^~~
>> drivers/iio/adc/ad7779.c:445:12: warning: variable 'msb' set but not used [-Wunused-but-set-variable]
     445 |         u8 msb, mid, lsb;
         |            ^~~
   drivers/iio/adc/ad7779.c: In function 'ad7779_read_raw':
>> drivers/iio/adc/ad7779.c:475:13: warning: unused variable 'ret' [-Wunused-variable]
     475 |         int ret;
         |             ^~~


vim +/high +420 drivers/iio/adc/ad7779.c

   415	
   416	static int ad7779_get_calibbias(struct ad7779_state *st, int channel)
   417	{
   418		int ret;
   419		u8 calibbias[3];
 > 420		u8 low, mid, high;
   421	
   422		ret = ad7779_spi_read(st, AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
   423				      &calibbias[0]);
   424		if (ret)
   425			return ret;
   426	
   427		ret = ad7779_spi_read(st, AD7779_REG_CH_OFFSET_MID_BYTE(channel),
   428					  &calibbias[1]);
   429		if (ret)
   430			return ret;
   431	
   432		ret = ad7779_spi_read(st,
   433				      AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
   434				      &calibbias[2]);
   435		if (ret)
   436			return ret;
   437	
   438		return get_unaligned_be24(calibbias);
   439	}
   440	
   441	static int ad7779_set_calibbias(struct ad7779_state *st, int channel, int val)
   442	{
   443		int ret;
   444		u8 calibbias[3];
 > 445		u8 msb, mid, lsb;
   446	
   447		msb = FIELD_GET(AD7779_UPPER, val);
   448		mid = FIELD_GET(AD7779_MID, val);
   449		lsb = FIELD_GET(AD7779_LOWER, val);
   450		put_unaligned_be24(val, calibbias);
   451		ret = ad7779_spi_write(st,
   452				       AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
   453				       calibbias[0]);
   454		if (ret)
   455			return ret;
   456	
   457		ret = ad7779_spi_write(st,
   458				       AD7779_REG_CH_OFFSET_MID_BYTE(channel),
   459				       calibbias[1]);
   460		if (ret)
   461			return ret;
   462	
   463		return ad7779_spi_write(st,
   464					AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
   465					calibbias[2]);
   466	}
   467	
   468	static int ad7779_read_raw(struct iio_dev *indio_dev,
   469				   struct iio_chan_spec const *chan,
   470				   int *val,
   471				   int *val2,
   472				   long mask)
   473	{
   474		struct ad7779_state *st = iio_priv(indio_dev);
 > 475		int ret;
   476	
   477		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
   478			switch (mask) {
   479			case IIO_CHAN_INFO_CALIBSCALE:
   480				*val = ad7779_get_calibscale(st, chan->channel);
   481				iio_device_release_direct_mode(indio_dev);
   482				if (*val < 0)
   483					return -EINVAL;
   484				*val2 = GAIN_REL;
   485				return IIO_VAL_FRACTIONAL;
   486			case IIO_CHAN_INFO_CALIBBIAS:
   487				*val = ad7779_get_calibbias(st, chan->channel);
   488				iio_device_release_direct_mode(indio_dev);
   489				if (*val < 0)
   490					return -EINVAL;
   491				return IIO_VAL_INT;
   492			case IIO_CHAN_INFO_SAMP_FREQ:
   493				*val = st->sampling_freq;
   494				iio_device_release_direct_mode(indio_dev);
   495				if (*val < 0)
   496					return -EINVAL;
   497				return IIO_VAL_INT;
   498			}
   499			return -EINVAL;
   500		}
   501		unreachable();
   502	}
   503	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

