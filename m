Return-Path: <linux-iio+bounces-25330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA09BF6634
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 175C8501AD2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB535504B;
	Tue, 21 Oct 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxrTZpeI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA335503E;
	Tue, 21 Oct 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048877; cv=none; b=Ooi4gsZygPeqXIAK3xEEOo8hN8UBkC2OGk+WlPulhZ5dMfD79+G7cI8YMTIUVHK9+/0aWqMipcZ7AwqTbU+cw7qhq4p3/Cry/Ek8f8wKG8yfef+GG1uoI3hOrrBXhIJOMKnTvfdUsPkO/kRIEEWfBTY77xcjSGw1FxBX9PuqIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048877; c=relaxed/simple;
	bh=ElSiGl51SENdQy+zgYpYwRZ/ED2yT+tL43Wf5Uo2oRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffkUlMd+UOd3cCW4yAfNfC6MBsmCXB/aO9iKrv6qhGc+XxOLrFecuPV2yQ4nrZLNCF+QIZNuKCYeNCdosQsHjcjRlSSsqhEcX3geEm0gTk9sl5f7aPlFMfDiamllN3wyQcaFm9eQCoiUrns4ogQ3cLtTflUVj7SliS5+bW/9tXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxrTZpeI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761048876; x=1792584876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ElSiGl51SENdQy+zgYpYwRZ/ED2yT+tL43Wf5Uo2oRo=;
  b=mxrTZpeIG0TipS+JUltNkZQ9839b6xS7l2ixzrHg9vZ5rZrPe34hBpWO
   y3dzR56Hqsiixu9WTqRMXaGHYHrSu3RDcM0uAE931p0QVfOUVyhbWMlss
   3yS13TGwiGkBPnWASW5Pg7N5SRlVGIfIpJic5SPhTOasF0IPsWTKZ5KGQ
   F0a5lCXJeR4HlORwlATD2LLzbI7hvK3JzSXS3fEiOyHcdhcRmBrXZnVsL
   Jx/ELusRbCyWmesVDVI2weJ8ia7N1iyB+sXZKg1Dj2nlBmMYOM5CwUoNv
   3qNo2EJ+RjJnCbU6ORjcr9mJh10uPFbuVev+ovBr89caD7+NSUa4nm9mp
   Q==;
X-CSE-ConnectionGUID: NcrZt546TyiBiGmzv3RB5A==
X-CSE-MsgGUID: tZvMHudGTBKjrL0XPtUj3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73843859"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="73843859"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:14:35 -0700
X-CSE-ConnectionGUID: mFYrMzXCR0aGuLvRqYMPBA==
X-CSE-MsgGUID: ucocjoz3QIGLiRJSkgBqFg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 21 Oct 2025 05:14:32 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBBG1-000AoJ-2c;
	Tue, 21 Oct 2025 12:14:29 +0000
Date: Tue, 21 Oct 2025 20:14:09 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Dutt <duttaditya18@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Frank Zago <frank@zago.net>
Cc: oe-kbuild-all@lists.linux.dev, Aditya Dutt <duttaditya18@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: position: Add support for ams AS5600 angle
 sensor
Message-ID: <202510211910.UK1wOVjv-lkp@intel.com>
References: <20251020201653.86181-3-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020201653.86181-3-duttaditya18@gmail.com>

Hi Aditya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Dutt/dt-bindings-iio-position-Add-ams-AS5600-Position-Sensor/20251021-042001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251020201653.86181-3-duttaditya18%40gmail.com
patch subject: [PATCH 2/2] iio: position: Add support for ams AS5600 angle sensor
config: powerpc-randconfig-r073-20251021 (https://download.01.org/0day-ci/archive/20251021/202510211910.UK1wOVjv-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251021/202510211910.UK1wOVjv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510211910.UK1wOVjv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/position/as5600.c:127:12: warning: implicit conversion from 'long long' to 'int' changes value from 4096000000 to -198967296 [-Wconstant-conversion]
                           *val2 = 4096000000;
                                 ~ ^~~~~~~~~~
   1 warning generated.


vim +127 drivers/iio/position/as5600.c

    93	
    94	static int as5600_read_raw(struct iio_dev *indio_dev,
    95				   struct iio_chan_spec const *chan,
    96				   int *val, int *val2, long mask)
    97	{
    98		struct as5600_priv *priv = iio_priv(indio_dev);
    99		u16 bitmask;
   100		s32 ret;
   101		u16 reg;
   102	
   103		switch (mask) {
   104		case IIO_CHAN_INFO_RAW:
   105			if (chan->channel == 0) {
   106				reg = AS5600_REG_RAW_ANGLE;
   107				bitmask = AS5600_FIELD_RAW_ANGLE;
   108			} else {
   109				reg = AS5600_REG_ANGLE;
   110				bitmask = AS5600_FIELD_ANGLE;
   111			}
   112			ret = i2c_smbus_read_word_swapped(priv->client, reg);
   113	
   114			if (ret < 0)
   115				return ret;
   116			*val = ret & bitmask;
   117	
   118			return IIO_VAL_INT;
   119	
   120		case IIO_CHAN_INFO_SCALE:
   121			/* Always 4096 steps, but angle range varies between
   122			 * 18 and 360 degrees.
   123			 */
   124			if (chan->channel == 0) {
   125				/* Whole angle range = 2*pi / 4096 */
   126				*val = 2 * 3141592;
 > 127				*val2 = 4096000000;
   128			} else {
   129				s32 range;
   130	
   131				/* MPOS - ZPOS defines the active angle selection */
   132				/* Partial angle = (range / 4096) * (2*pi / 4096) */
   133				mutex_lock(&priv->lock);
   134				range = priv->mpos - priv->zpos;
   135				mutex_unlock(&priv->lock);
   136				if (range <= 0)
   137					range += 4096;
   138	
   139				*val = range * 2 * 314159;
   140				*val /= 4096;
   141				*val2 = 409600000;
   142			}
   143	
   144			return IIO_VAL_FRACTIONAL;
   145	
   146		default:
   147			return -EINVAL;
   148		}
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

