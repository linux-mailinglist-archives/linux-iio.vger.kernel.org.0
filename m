Return-Path: <linux-iio+bounces-8134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5F945804
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 08:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3D6286B58
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957038F9C;
	Fri,  2 Aug 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMdswKOp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011A282FA;
	Fri,  2 Aug 2024 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579790; cv=none; b=IrnvCSzwiUnK1+a9ZL0YqBRfz1GMfk8C4jMD5xuDFSNpcozh4UiaofTrva+c3fwn4+EHhvXwo1hChD1FSnj411QwGpD4vKSPfxSiF9MvdaBPEF3L9q2sTlu/CI0FDwSzp2c47o3i2B/OgJpNEoG6RRz1w6hKvvzsK6aQzj1gflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579790; c=relaxed/simple;
	bh=bBQMiYAvPVjgJtj/tiLbe4yspB/VxSsyiOeWhgvCC3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUTjGkOHiTiGVMPJkvYV/GUPpJS6ICbktBYfWpH0hZ3r0cpF48qc6+ad4mY+cy95M4C2vu8QBmBhRZz+apW13XRud+R52ZQwPBnFXliEdCh5nVTUs4fhykhZ0Sr58ASoXCJW+kJm6mNCwX47GMwkL7Z99VZv2djUVpCEi8uAb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMdswKOp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722579788; x=1754115788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bBQMiYAvPVjgJtj/tiLbe4yspB/VxSsyiOeWhgvCC3E=;
  b=TMdswKOpv1YvDY5PgBtqt4yKkxq9ccIqKzd1F00mNXb3lTs4CMNvdHBE
   gkOdkkWbnf2lW9/zvqAIVSyfwETAcSBVgU/JVjSJd/e39HXetwZ3Objid
   GAYqO/H0J/kNv2aIEK/WgqeVRJT5tSzlVI4oPykW8fJAHRS8jsX8txtbp
   EharGNHJGbSipgwxzeVwGO9IGZ/DW1guOf/0o9BT8yTPAwr6HGRYTenpo
   HH6SUR2jO9ni4wjMq3487qDdfrydot0tdQyei2QuyV6td0UVCCSPfrOmZ
   Yn3xfK8sr4ouQWg+v4wx0ucOPZgnc3FvqV2T9dZ5QfEnwFFvMgew0Oby+
   w==;
X-CSE-ConnectionGUID: 8mi1y+S9RrqbMmn8sZC+Fg==
X-CSE-MsgGUID: LCXwU8/rQfurNcbOPKaWHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20754285"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="20754285"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 23:23:07 -0700
X-CSE-ConnectionGUID: CjvPgjBGT+O+5uFG6qI1tA==
X-CSE-MsgGUID: w5/W+DBGSjC98Bd3Vdo0Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="60318224"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Aug 2024 23:23:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZlgq-000wVQ-1d;
	Fri, 02 Aug 2024 06:23:00 +0000
Date: Fri, 2 Aug 2024 14:21:50 +0800
From: kernel test robot <lkp@intel.com>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <202408021321.uic81edY-lkp@intel.com>
References: <20240730030509.57834-3-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730030509.57834-3-Mariel.Tinaco@analog.com>

Hi Mariel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9900e7a54764998ba3a22f06ec629f7b5fe0b422]

url:    https://github.com/intel-lab-lkp/linux/commits/Mariel-Tinaco/dt-bindings-iio-dac-add-docs-for-ad8460/20240730-112724
base:   9900e7a54764998ba3a22f06ec629f7b5fe0b422
patch link:    https://lore.kernel.org/r/20240730030509.57834-3-Mariel.Tinaco%40analog.com
patch subject: [PATCH v2 2/2] iio: dac: support the ad8460 Waveform DAC
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240802/202408021321.uic81edY-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240802/202408021321.uic81edY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408021321.uic81edY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/dac/ad8460.c: In function 'ad8460_dac_input_read':
   drivers/iio/dac/ad8460.c:159:15: error: implicit declaration of function 'ad8460_get_hvdac_word' [-Werror=implicit-function-declaration]
     159 |         ret = ad8460_get_hvdac_word(state, private, &reg);
         |               ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/dac/ad8460.c:163:35: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'unsigned int' [-Wformat=]
     163 |         return sysfs_emit(buf, "%ld\n", reg);
         |                                 ~~^     ~~~
         |                                   |     |
         |                                   |     unsigned int
         |                                   long int
         |                                 %d
   drivers/iio/dac/ad8460.c: In function 'ad8460_dac_input_write':
>> drivers/iio/dac/ad8460.c:176:30: warning: passing argument 2 of 'kstrtou32' makes integer from pointer without a cast [-Wint-conversion]
     176 |         ret = kstrtou32(buf, &reg);
         |                              ^~~~
         |                              |
         |                              unsigned int *
   In file included from include/linux/kernel.h:25,
                    from include/linux/clk.h:13,
                    from drivers/iio/dac/ad8460.c:10:
   include/linux/kstrtox.h:84:70: note: expected 'unsigned int' but argument is of type 'unsigned int *'
      84 | static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
         |                                                         ~~~~~~~~~~~~~^~~~
   drivers/iio/dac/ad8460.c:176:15: error: too few arguments to function 'kstrtou32'
     176 |         ret = kstrtou32(buf, &reg);
         |               ^~~~~~~~~
   include/linux/kstrtox.h:84:32: note: declared here
      84 | static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
         |                                ^~~~~~~~~
   drivers/iio/dac/ad8460.c:182:16: error: implicit declaration of function 'ad8460_set_hvdac_word' [-Werror=implicit-function-declaration]
     182 |         return ad8460_set_hvdac_word(state, private, reg);
         |                ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_write_symbol':
>> drivers/iio/dac/ad8460.c:211:30: warning: passing argument 2 of 'kstrtou16' makes integer from pointer without a cast [-Wint-conversion]
     211 |         ret = kstrtou16(buf, &sym);
         |                              ^~~~
         |                              |
         |                              bool * {aka _Bool *}
   include/linux/kstrtox.h:94:56: note: expected 'unsigned int' but argument is of type 'bool *' {aka '_Bool *'}
      94 | int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
         |                                           ~~~~~~~~~~~~~^~~~
   drivers/iio/dac/ad8460.c:211:15: error: too few arguments to function 'kstrtou16'
     211 |         ret = kstrtou16(buf, &sym);
         |               ^~~~~~~~~
   include/linux/kstrtox.h:94:18: note: declared here
      94 | int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
         |                  ^~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_write_toggle_en':
   drivers/iio/dac/ad8460.c:249:30: warning: passing argument 2 of 'kstrtou16' makes integer from pointer without a cast [-Wint-conversion]
     249 |         ret = kstrtou16(buf, &toggle_en);
         |                              ^~~~~~~~~~
         |                              |
         |                              bool * {aka _Bool *}
   include/linux/kstrtox.h:94:56: note: expected 'unsigned int' but argument is of type 'bool *' {aka '_Bool *'}
      94 | int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
         |                                           ~~~~~~~~~~~~~^~~~
   drivers/iio/dac/ad8460.c:249:15: error: too few arguments to function 'kstrtou16'
     249 |         ret = kstrtou16(buf, &toggle_en);
         |               ^~~~~~~~~
   include/linux/kstrtox.h:94:18: note: declared here
      94 | int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
         |                  ^~~~~~~~~
   drivers/iio/dac/ad8460.c: At top level:
   drivers/iio/dac/ad8460.c:335:12: error: static declaration of 'ad8460_get_hvdac_word' follows non-static declaration
     335 | static int ad8460_get_hvdac_word(struct ad8460_state *state,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:159:15: note: previous implicit declaration of 'ad8460_get_hvdac_word' with type 'int()'
     159 |         ret = ad8460_get_hvdac_word(state, private, &reg);
         |               ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_get_hvdac_word':
   drivers/iio/dac/ad8460.c:346:16: error: implicit declaration of function 'get_unaligned_le16' [-Werror=implicit-function-declaration]
     346 |         *val = get_unaligned_le16(state->spi_tx_buf);
         |                ^~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: At top level:
   drivers/iio/dac/ad8460.c:351:12: error: static declaration of 'ad8460_set_hvdac_word' follows non-static declaration
     351 | static int ad8460_set_hvdac_word(struct ad8460_state *state,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:182:16: note: previous implicit declaration of 'ad8460_set_hvdac_word' with type 'int()'
     182 |         return ad8460_set_hvdac_word(state, private, reg);
         |                ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_set_hvdac_word':
   drivers/iio/dac/ad8460.c:355:9: error: implicit declaration of function 'put_unaligned_le16' [-Werror=implicit-function-declaration]
     355 |         put_unaligned_le16(val & 0x3FFF, &state->spi_tx_buf);
         |         ^~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_probe':
   drivers/iio/dac/ad8460.c:855:15: error: implicit declaration of function 'devm_regulator_get_enable_read_voltage'; did you mean 'devm_regulator_get_enable_optional'? [-Werror=implicit-function-declaration]
     855 |         ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio_1p2v");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               devm_regulator_get_enable_optional
   drivers/iio/dac/ad8460.c:859:57: error: 'vrefio' undeclared (first use in this function)
     859 |                 return dev_err_probe(&spi->dev, PTR_ERR(vrefio),
         |                                                         ^~~~~~
   drivers/iio/dac/ad8460.c:859:57: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iio/dac/ad8460.c:819:27: warning: unused variable 'refio_1p2v' [-Wunused-variable]
     819 |         struct regulator *refio_1p2v;
         |                           ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +163 drivers/iio/dac/ad8460.c

   149	
   150	static ssize_t ad8460_dac_input_read(struct iio_dev *indio_dev,
   151					     uintptr_t private,
   152					     const struct iio_chan_spec *chan,
   153					     char *buf)
   154	{
   155		struct ad8460_state *state = iio_priv(indio_dev);
   156		unsigned int reg;
   157		int ret;
   158	
   159		ret = ad8460_get_hvdac_word(state, private, &reg);
   160		if (ret)
   161			return ret;
   162	
 > 163		return sysfs_emit(buf, "%ld\n", reg);
   164	}
   165	
   166	static ssize_t ad8460_dac_input_write(struct iio_dev *indio_dev,
   167					      uintptr_t private,
   168					      const struct iio_chan_spec *chan,
   169					      const char *buf,
   170					      size_t len)
   171	{
   172		struct ad8460_state *state = iio_priv(indio_dev);
   173		unsigned int reg;
   174		int ret;
   175	
 > 176		ret = kstrtou32(buf, &reg);
   177		if (ret)
   178			return ret;
   179	
   180		guard(mutex)(&state->lock);
   181	
   182		return ad8460_set_hvdac_word(state, private, reg);
   183	}
   184	
   185	static ssize_t ad8460_read_symbol(struct iio_dev *indio_dev,
   186					  uintptr_t private,
   187					  const struct iio_chan_spec *chan,
   188					  char *buf)
   189	{
   190		struct ad8460_state *state = iio_priv(indio_dev);
   191		unsigned int reg;
   192		int ret;
   193	
   194		ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x02), &reg);
   195		if (ret)
   196			return ret;
   197	
   198		return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_PATTERN_DEPTH_MSK, reg));
   199	}
   200	
   201	static ssize_t ad8460_write_symbol(struct iio_dev *indio_dev,
   202					   uintptr_t private,
   203					   const struct iio_chan_spec *chan,
   204					   const char *buf,
   205					   size_t len)
   206	{
   207		struct ad8460_state *state = iio_priv(indio_dev);
   208		bool sym;
   209		int ret;
   210	
 > 211		ret = kstrtou16(buf, &sym);
   212		if (ret)
   213			return ret;
   214	
   215		guard(mutex)(&state->lock);
   216	
   217		return regmap_update_bits(state->regmap,
   218					  AD8460_CTRL_REG(0x02),
   219					  AD8460_PATTERN_DEPTH_MSK,
   220					  FIELD_PREP(AD8460_PATTERN_DEPTH_MSK, sym));
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

