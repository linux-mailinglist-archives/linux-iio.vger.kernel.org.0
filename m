Return-Path: <linux-iio+bounces-8137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77636945B5C
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 11:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB20C1F230A3
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851981DB43D;
	Fri,  2 Aug 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYwEMHx/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684D256D;
	Fri,  2 Aug 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592030; cv=none; b=CSzpwhmy79ZPilwAmTx647Fgkl1dShV3ht1bs7Cs3vx75uHZlR1S5e6EcmyHmNAXo1K7Z1p1QPP1IP7f5VpnF/vJwpazdkeQTDKTOy14/Hu2ak8YUGYNHOGtREPcgN0hqU+LSSZhaU7dqK4LrG3tjfXmVx4V/OmhXA5a01gO2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592030; c=relaxed/simple;
	bh=r18OwXbqxgO8PN4RtN+7uTpp0YGWxlu8gkQG/BbI96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5boNNnBS3gEfE/oOWovKwFBvJNfgWZ0vc+wEIsB9xFfISL7LMXMfFiSQO1kva6GWXRoduDjIshRaRJSZZaiOHwHUIPygCdCCKKNLDMsedo/dhgvZ8GtXcF7/MyhJao8y1aMWOTK0Kq/04owVRZEl+fBkr0+DQz7Phf1W8pstCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYwEMHx/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722592028; x=1754128028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r18OwXbqxgO8PN4RtN+7uTpp0YGWxlu8gkQG/BbI96Q=;
  b=aYwEMHx/2kAHmKYi1dbWWuZ8+v3DJSE2sdzXmqc18/jdcNstmWPAeoRd
   4VckDfHSGZNBztZySayaKX37I26I1DgM/I+uguL5PEr/czxiDFaVZF7ky
   eiuiZ5tLrTpVVWbIw+U6+MtatYnjbjhOQ8dpYzmEWtcU+VYw8crDcNIwB
   0sRi6NKhTF2OWu6t3aU1C9OAIxqsC5b9gARuyoyMHhJeEd/N+QPnVfZ5g
   5KSkGgMSAJdcWeIwfap97bJEIZ3pZ2flrseSN6sD2Ps9Vo+qqhn/VEF3d
   8irpnh0ta/MXyf1Z5/htTM4LE+eisyX9kUSYAAJqL4aXyNP66G5RxCa1y
   w==;
X-CSE-ConnectionGUID: uGzM5tWPS4y+8vJgwagAuw==
X-CSE-MsgGUID: AmvX893LSK+Q9F3vnpvIbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="38105895"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38105895"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 02:47:07 -0700
X-CSE-ConnectionGUID: IF1ytPHrTwmb8RH4zyqkgw==
X-CSE-MsgGUID: NBcpWt0zQE6JRjFW3zKjFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55583178"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Aug 2024 02:47:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZosH-000wba-1q;
	Fri, 02 Aug 2024 09:47:01 +0000
Date: Fri, 2 Aug 2024 17:46:49 +0800
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
Message-ID: <202408021737.KMIdEjmt-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 9900e7a54764998ba3a22f06ec629f7b5fe0b422]

url:    https://github.com/intel-lab-lkp/linux/commits/Mariel-Tinaco/dt-bindings-iio-dac-add-docs-for-ad8460/20240730-112724
base:   9900e7a54764998ba3a22f06ec629f7b5fe0b422
patch link:    https://lore.kernel.org/r/20240730030509.57834-3-Mariel.Tinaco%40analog.com
patch subject: [PATCH v2 2/2] iio: dac: support the ad8460 Waveform DAC
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240802/202408021737.KMIdEjmt-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240802/202408021737.KMIdEjmt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408021737.KMIdEjmt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/dac/ad8460.c: In function 'ad8460_dac_input_read':
>> drivers/iio/dac/ad8460.c:159:15: error: implicit declaration of function 'ad8460_get_hvdac_word' [-Werror=implicit-function-declaration]
     159 |         ret = ad8460_get_hvdac_word(state, private, &reg);
         |               ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:163:35: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'unsigned int' [-Wformat=]
     163 |         return sysfs_emit(buf, "%ld\n", reg);
         |                                 ~~^     ~~~
         |                                   |     |
         |                                   |     unsigned int
         |                                   long int
         |                                 %d
   drivers/iio/dac/ad8460.c: In function 'ad8460_dac_input_write':
   drivers/iio/dac/ad8460.c:176:30: warning: passing argument 2 of 'kstrtou32' makes integer from pointer without a cast [-Wint-conversion]
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
>> drivers/iio/dac/ad8460.c:176:15: error: too few arguments to function 'kstrtou32'
     176 |         ret = kstrtou32(buf, &reg);
         |               ^~~~~~~~~
   include/linux/kstrtox.h:84:32: note: declared here
      84 | static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
         |                                ^~~~~~~~~
>> drivers/iio/dac/ad8460.c:182:16: error: implicit declaration of function 'ad8460_set_hvdac_word' [-Werror=implicit-function-declaration]
     182 |         return ad8460_set_hvdac_word(state, private, reg);
         |                ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_write_symbol':
   drivers/iio/dac/ad8460.c:211:30: warning: passing argument 2 of 'kstrtou16' makes integer from pointer without a cast [-Wint-conversion]
     211 |         ret = kstrtou16(buf, &sym);
         |                              ^~~~
         |                              |
         |                              bool * {aka _Bool *}
   include/linux/kstrtox.h:94:56: note: expected 'unsigned int' but argument is of type 'bool *' {aka '_Bool *'}
      94 | int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
         |                                           ~~~~~~~~~~~~~^~~~
>> drivers/iio/dac/ad8460.c:211:15: error: too few arguments to function 'kstrtou16'
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
>> drivers/iio/dac/ad8460.c:335:12: error: static declaration of 'ad8460_get_hvdac_word' follows non-static declaration
     335 | static int ad8460_get_hvdac_word(struct ad8460_state *state,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:159:15: note: previous implicit declaration of 'ad8460_get_hvdac_word' with type 'int()'
     159 |         ret = ad8460_get_hvdac_word(state, private, &reg);
         |               ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_get_hvdac_word':
>> drivers/iio/dac/ad8460.c:346:16: error: implicit declaration of function 'get_unaligned_le16' [-Werror=implicit-function-declaration]
     346 |         *val = get_unaligned_le16(state->spi_tx_buf);
         |                ^~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: At top level:
>> drivers/iio/dac/ad8460.c:351:12: error: static declaration of 'ad8460_set_hvdac_word' follows non-static declaration
     351 | static int ad8460_set_hvdac_word(struct ad8460_state *state,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:182:16: note: previous implicit declaration of 'ad8460_set_hvdac_word' with type 'int()'
     182 |         return ad8460_set_hvdac_word(state, private, reg);
         |                ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_set_hvdac_word':
>> drivers/iio/dac/ad8460.c:355:9: error: implicit declaration of function 'put_unaligned_le16' [-Werror=implicit-function-declaration]
     355 |         put_unaligned_le16(val & 0x3FFF, &state->spi_tx_buf);
         |         ^~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c: In function 'ad8460_probe':
>> drivers/iio/dac/ad8460.c:855:15: error: implicit declaration of function 'devm_regulator_get_enable_read_voltage'; did you mean 'devm_regulator_get_enable_optional'? [-Werror=implicit-function-declaration]
     855 |         ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio_1p2v");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               devm_regulator_get_enable_optional
>> drivers/iio/dac/ad8460.c:859:57: error: 'vrefio' undeclared (first use in this function)
     859 |                 return dev_err_probe(&spi->dev, PTR_ERR(vrefio),
         |                                                         ^~~~~~
   drivers/iio/dac/ad8460.c:859:57: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iio/dac/ad8460.c:819:27: warning: unused variable 'refio_1p2v' [-Wunused-variable]
     819 |         struct regulator *refio_1p2v;
         |                           ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ad8460_get_hvdac_word +159 drivers/iio/dac/ad8460.c

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
 > 159		ret = ad8460_get_hvdac_word(state, private, &reg);
   160		if (ret)
   161			return ret;
   162	
   163		return sysfs_emit(buf, "%ld\n", reg);
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
 > 182		return ad8460_set_hvdac_word(state, private, reg);
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
   223	static ssize_t ad8460_read_toggle_en(struct iio_dev *indio_dev,
   224					     uintptr_t private,
   225					     const struct iio_chan_spec *chan,
   226					     char *buf)
   227	{
   228		struct ad8460_state *state = iio_priv(indio_dev);
   229		unsigned int reg;
   230		int ret;
   231	
   232		ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x02), &reg);
   233		if (ret)
   234			return ret;
   235	
   236		return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_APG_MODE_ENABLE_MSK, reg));
   237	}
   238	
   239	static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev,
   240					      uintptr_t private,
   241					      const struct iio_chan_spec *chan,
   242					      const char *buf,
   243					      size_t len)
   244	{
   245		struct ad8460_state *state = iio_priv(indio_dev);
   246		bool toggle_en;
   247		int ret;
   248	
   249		ret = kstrtou16(buf, &toggle_en);
   250		if (ret)
   251			return ret;
   252	
   253		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
   254			return ad8460_enable_apg_mode(state, toggle_en);
   255		unreachable();
   256	}
   257	
   258	static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev,
   259					     uintptr_t private,
   260					     const struct iio_chan_spec *chan,
   261					     char *buf)
   262	{
   263		struct ad8460_state *state = iio_priv(indio_dev);
   264		unsigned int reg;
   265		int ret;
   266	
   267		ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x01), &reg);
   268		if (ret)
   269			return ret;
   270	
   271		return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_HVDAC_SLEEP_MSK, reg));
   272	}
   273	
   274	static ssize_t ad8460_write_powerdown(struct iio_dev *indio_dev,
   275					      uintptr_t private,
   276					      const struct iio_chan_spec *chan,
   277					      const char *buf,
   278					      size_t len)
   279	{
   280		struct ad8460_state *state = iio_priv(indio_dev);
   281		bool pwr_down;
   282		u64 sdn_flag;
   283		int ret;
   284	
   285		ret = kstrtobool(buf, &pwr_down);
   286		if (ret)
   287			return ret;
   288	
   289		guard(mutex)(&state->lock);
   290	
   291		ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
   292					 AD8460_HVDAC_SLEEP_MSK,
   293					 FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, pwr_down));
   294		if (ret)
   295			return ret;
   296	
   297		if (!pwr_down) {
   298			ret = ad8460_read_shutdown_flag(state, &sdn_flag);
   299			if (ret)
   300				return ret;
   301	
   302			if (sdn_flag) {
   303				ret = ad8460_hv_reset(state);
   304				if (ret)
   305					return ret;
   306			}
   307		}
   308	
   309		ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x00),
   310					 AD8460_HV_SLEEP_MSK,
   311					 FIELD_PREP(AD8460_HV_SLEEP_MSK, !pwr_down));
   312		if (ret)
   313			return ret;
   314	
   315		return len;
   316	}
   317	
   318	static const char * const ad8460_powerdown_modes[] = {
   319		"three_state",
   320	};
   321	
   322	static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
   323					     const struct iio_chan_spec *chan)
   324	{
   325		return 0;
   326	}
   327	
   328	static int ad8460_set_powerdown_mode(struct iio_dev *indio_dev,
   329					     const struct iio_chan_spec *chan,
   330					     unsigned int type)
   331	{
   332		return 0;
   333	}
   334	
 > 335	static int ad8460_get_hvdac_word(struct ad8460_state *state,
   336					 int index,
   337					 int *val)
   338	{
   339		int ret;
   340	
   341		ret = regmap_bulk_read(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
   342				       &state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
   343		if (ret)
   344			return ret;
   345	
 > 346		*val = get_unaligned_le16(state->spi_tx_buf);
   347	
   348		return ret;
   349	}
   350	
 > 351	static int ad8460_set_hvdac_word(struct ad8460_state *state,
   352					 int index,
   353					 int val)
   354	{
 > 355		put_unaligned_le16(val & 0x3FFF, &state->spi_tx_buf);
   356	
   357		return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
   358					 state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
   359	}
   360	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

