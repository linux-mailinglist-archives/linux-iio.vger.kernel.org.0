Return-Path: <linux-iio+bounces-8136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FA6945983
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 10:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9285EB228EA
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0E1C2310;
	Fri,  2 Aug 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqCM53CA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B744C3D0;
	Fri,  2 Aug 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585916; cv=none; b=REjS7yFZHEQ+mXgoIpI+n5Yf7bYUK8AHOc+uErfyrgiqyhV1oBZv/YcT9BHLYoiWc8jeWsfMiHrW0olaFpWYYdOHyKHD2PzqzkdKx04Mlb2M7/ayjKxRtum13xDtn+hjSZCI7iX7CRbY8Nrnv+mbgHYYdWSyICa6UjorKBRhJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585916; c=relaxed/simple;
	bh=2EcGfDArf+MGK7/GjIOlC6bogSo7gt7YM540zICjH5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isPqllwQC6UB2fZzPrglsC3Ux2mjgFh9IQej6NHTDn9/JRNHdvqNyHIfHumdnaJsrfXmFzMQ1Ev6JlzJRt7uxhP8XxNR1SnotXk1wx2MeN8ekjDKyUFG5ffkbqWFVAznRZprawxMxqa1JlcEzuH8/Pa2EcyaLDZoVE6An91Eonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqCM53CA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722585915; x=1754121915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2EcGfDArf+MGK7/GjIOlC6bogSo7gt7YM540zICjH5g=;
  b=JqCM53CAkagEKjM9qFPbUyvy6D2AhebzLsILOvTWYSGofNnpxrmVK33p
   m9/NvEpM0tfGDaKkzuBhlCu2E5lubsQSO2xnHMLxiK0zR4+i8Yxl3Qnhh
   4dTfCgRCAV1RSo5T3QCh7pxrOcxjR1xOxSTzJ5MTwbAOX+L9MukpwAFdD
   np9pqvWYuLR8+IASpse4hEA9ELaqlkO7yCo7MdHUEw905XDV4LfpO/dWq
   OcFvGTDC6HACQRXu9I252Q4X/AbKii5PoN3nn2/vvEgkRdfeQUQ0I/7l5
   qCgk71qWsyeoJd2GJvA1ZJzey+dRZsm5ObEJCj81VHb+uBEGqJNreo/xK
   g==;
X-CSE-ConnectionGUID: R4R2zqcuTW6GJpxVs4nXZw==
X-CSE-MsgGUID: vQQZO98cT7mZ80J8+feUaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20429987"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="20429987"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 01:05:14 -0700
X-CSE-ConnectionGUID: KTOEGHfcSVCCsCfHzck+rQ==
X-CSE-MsgGUID: S/dNMuleT3aCQ537zgFuWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55922863"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Aug 2024 01:05:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZnHf-000wYW-2W;
	Fri, 02 Aug 2024 08:05:07 +0000
Date: Fri, 2 Aug 2024 16:04:40 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <202408021509.ug75TMoS-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240802/202408021509.ug75TMoS-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240802/202408021509.ug75TMoS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408021509.ug75TMoS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/dac/ad8460.c:159:8: error: call to undeclared function 'ad8460_get_hvdac_word'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     159 |         ret = ad8460_get_hvdac_word(state, private, &reg);
         |               ^
>> drivers/iio/dac/ad8460.c:163:34: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
     163 |         return sysfs_emit(buf, "%ld\n", reg);
         |                                 ~~~     ^~~
         |                                 %u
   drivers/iio/dac/ad8460.c:176:27: error: too few arguments to function call, expected 3, have 2
     176 |         ret = kstrtou32(buf, &reg);
         |               ~~~~~~~~~          ^
   include/linux/kstrtox.h:84:32: note: 'kstrtou32' declared here
      84 | static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
         |                                ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:182:9: error: call to undeclared function 'ad8460_set_hvdac_word'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     182 |         return ad8460_set_hvdac_word(state, private, reg);
         |                ^
   drivers/iio/dac/ad8460.c:211:27: error: too few arguments to function call, expected 3, have 2
     211 |         ret = kstrtou16(buf, &sym);
         |               ~~~~~~~~~          ^
   include/linux/kstrtox.h:94:18: note: 'kstrtou16' declared here
      94 | int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
         |                  ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:249:33: error: too few arguments to function call, expected 3, have 2
     249 |         ret = kstrtou16(buf, &toggle_en);
         |               ~~~~~~~~~                ^
   include/linux/kstrtox.h:94:18: note: 'kstrtou16' declared here
      94 | int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
         |                  ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad8460.c:335:12: error: static declaration of 'ad8460_get_hvdac_word' follows non-static declaration
     335 | static int ad8460_get_hvdac_word(struct ad8460_state *state,
         |            ^
   drivers/iio/dac/ad8460.c:159:8: note: previous implicit declaration is here
     159 |         ret = ad8460_get_hvdac_word(state, private, &reg);
         |               ^
   drivers/iio/dac/ad8460.c:346:9: error: call to undeclared function 'get_unaligned_le16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     346 |         *val = get_unaligned_le16(state->spi_tx_buf);
         |                ^
   drivers/iio/dac/ad8460.c:351:12: error: static declaration of 'ad8460_set_hvdac_word' follows non-static declaration
     351 | static int ad8460_set_hvdac_word(struct ad8460_state *state,
         |            ^
   drivers/iio/dac/ad8460.c:182:9: note: previous implicit declaration is here
     182 |         return ad8460_set_hvdac_word(state, private, reg);
         |                ^
   drivers/iio/dac/ad8460.c:355:2: error: call to undeclared function 'put_unaligned_le16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     355 |         put_unaligned_le16(val & 0x3FFF, &state->spi_tx_buf);
         |         ^
   drivers/iio/dac/ad8460.c:855:8: error: call to undeclared function 'devm_regulator_get_enable_read_voltage'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     855 |         ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio_1p2v");
         |               ^
   drivers/iio/dac/ad8460.c:855:8: note: did you mean 'devm_regulator_get_enable_optional'?
   include/linux/regulator/consumer.h:166:5: note: 'devm_regulator_get_enable_optional' declared here
     166 | int devm_regulator_get_enable_optional(struct device *dev, const char *id);
         |     ^
   drivers/iio/dac/ad8460.c:859:43: error: use of undeclared identifier 'vrefio'
     859 |                 return dev_err_probe(&spi->dev, PTR_ERR(vrefio),
         |                                                         ^
   1 warning and 11 errors generated.


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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

