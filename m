Return-Path: <linux-iio+bounces-23716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E934BB43DFE
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 16:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12B1161E41
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A223054C0;
	Thu,  4 Sep 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfJohFUH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3952D8771;
	Thu,  4 Sep 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994679; cv=none; b=dEzAtVj0GQJ9AX9aQt+97z+jLJirH3ZnHunQZYL95n/gJCx6XqepipXK4rbIVMiTn9FWG2vhaTC2tXox0SC8j1W45GcDyq6tCgdHo2GrxGpBwmcqoy+gcFLJym4+9R4pb8C6hBfB7DD5ukoqMbyq99JZF63+VvdwuGX0MqzqPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994679; c=relaxed/simple;
	bh=8D15COu2exGUd3E0Qy8knhTqB4T/stT3kGk+YvNt1Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtGJNnHqiAsLiPU25ARVPZjYgLNvKVd4UdnlFgS/1OMVsiss/8/lLDdB+NOB7m6XCEe8jNou9HJbFshHdqRu1qa5nACBSipqdYFWmIJRtcDk1Z0KWCf18f2+ZRSss1X9koT7pZqQ8DCJwerWs+VOBuCUQ7mZi9YC+oRrhAZKg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfJohFUH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756994678; x=1788530678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8D15COu2exGUd3E0Qy8knhTqB4T/stT3kGk+YvNt1Xc=;
  b=KfJohFUH7Hn1UeO43oPCiN3r+3F941+Cogr92jFKdEr40icswc/cO/Q1
   P4ZXVOEFo4TOHlPuR/3xJYWVJqbuoj3LLbSOOUmWEF59xJhZaQ3xqLwIV
   zZoIdG376fb/57Zl6nMqJdCHKUNd7dd0WnXBywvjPToeTaNJ72YD+D/tu
   CJfOt1RX9do3P6jR3r2MnvnazJ302KTRUQ6dbBbpXXiZG7BmOdpt89X5Q
   qjPZJ0WiQoBA4A6BVYaZ33ifaOVyiSKNgcjAHI3jgdLGIQKL/JIh53vMN
   iqYLxc84JY6RmGVe1btPRJFy225gJwcXpk0s3EbEe1d4kWXe+lIfJPH+z
   w==;
X-CSE-ConnectionGUID: dur8aXbyR4icYs9PvtclUw==
X-CSE-MsgGUID: 8XQCbnVKQZGLYFK/yZFDaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70431585"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70431585"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 07:04:37 -0700
X-CSE-ConnectionGUID: jk3xqa1ERUuvLneeMH0DuQ==
X-CSE-MsgGUID: ZlXGG7xRRzuIrTFtgMNG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202827580"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 04 Sep 2025 07:04:31 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuAYv-0005Mt-2U;
	Thu, 04 Sep 2025 14:03:53 +0000
Date: Thu, 4 Sep 2025 22:02:41 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <202509042119.GiwpuwCl-lkp@intel.com>
References: <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d1487b0b78720b86ec2a2ac7acc683ec90627e5b]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/dt-bindings-iio-adc-ROHM-BD79112-ADC-GPIO/20250902-203558
base:   d1487b0b78720b86ec2a2ac7acc683ec90627e5b
patch link:    https://lore.kernel.org/r/08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount%40gmail.com
patch subject: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
config: sparc-randconfig-r071-20250904 (https://download.01.org/0day-ci/archive/20250904/202509042119.GiwpuwCl-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509042119.GiwpuwCl-lkp@intel.com/

smatch warnings:
drivers/iio/adc/rohm-bd79112.c:212 bd79112_read_raw() warn: inconsistent indenting

vim +212 drivers/iio/adc/rohm-bd79112.c

   192	
   193	static int bd79112_read_raw(struct iio_dev *indio_dev,
   194				    struct iio_chan_spec const *chan, int *val,
   195				    int *val2, long m)
   196	{
   197		struct bd79112_data *data = iio_priv(indio_dev);
   198		int ret;
   199	
   200		switch (m) {
   201		case IIO_CHAN_INFO_RAW:
   202			ret = regmap_read(data->map, chan->channel, val);
   203			if (ret < 0)
   204				return ret;
   205	
   206			return IIO_VAL_INT;
   207	
   208		case IIO_CHAN_INFO_SCALE:
   209			 *val = data->vref_mv;
   210			 *val2 = 12;
   211	
 > 212			return IIO_VAL_FRACTIONAL_LOG2;
   213		}
   214	
   215		return -EINVAL;
   216	}
   217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

