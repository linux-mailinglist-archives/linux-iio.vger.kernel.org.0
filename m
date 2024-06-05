Return-Path: <linux-iio+bounces-5874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414CC8FD7CA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D367A1F21506
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EC15F304;
	Wed,  5 Jun 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox1skVRN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DF139D00;
	Wed,  5 Jun 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620674; cv=none; b=USZOqsh6iuNxptNPVxX/iFGKpI+oAa+uXT/x3l3C4qT4Anl4TqJAh+ntqNQ1sIND8cW0l9P4gmmZNN7UUh7FnMeiv7SCxr50PPbWeDD7Oc9cum4+JbGl27d8Fn0aNokL5BIsxBJSmlZYGx4v8CaFqJaZHE/4/uo1U+VXMSH0jtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620674; c=relaxed/simple;
	bh=YbTwfNApTMNIiy0vIhw2dAIKkM6NP0Ye8Tt8hdNNo4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYs/dpA51zf55uxC0N8xBLWR3/Vh7AJbqpS1nVfRLzpYi55WkYddcoOWb7IDsjnxTZoXinJfmtP5NowS8ugeuhW671SRKDAnD0J2/d7r7gv/cGZ0Znahv/qI++MVCXBaecTOPYU7O7YEto/N3rzEhL8Bx3jduOLnHURKgRErkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox1skVRN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717620671; x=1749156671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YbTwfNApTMNIiy0vIhw2dAIKkM6NP0Ye8Tt8hdNNo4E=;
  b=Ox1skVRNzVcebzlnMNwlxfYvYfUe2MgSbuz+Mt36u/ZWDEO52sLp4LJK
   QbTH8UpVslH2rmfhonvbFgF+vT2U+W0weAD5uJWLdLw3tknZ2x+bFOrYj
   BJOZi/t+e3wA1jl5c0BZ5p/wfKV/EHjvFmpEewVgX3TDGHCIH8QAmprJ1
   KB2ek7FFozU6hB0eOtXO0ovfmVEwuMTITcExGfmn5nIs/xrA7v0HZH5qp
   kaU807FFBznmnkPRUwwY9osuCbwK44eBDj8Ot6z3JD/pvdeE46DVavC+3
   kS2e/Tk18MyYeftuvC/WEZ5MYfP6IRGwxhfCJBCdshkvExLeeJZ9P9SBj
   Q==;
X-CSE-ConnectionGUID: wEgyKadyQ4aUD300HaI+0A==
X-CSE-MsgGUID: J7oaKjwJTxmFXQRHUzjmew==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14375217"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14375217"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:51:11 -0700
X-CSE-ConnectionGUID: MI/DZGIIRaicjauBgg11Uw==
X-CSE-MsgGUID: nj9FXtOaRcK1olqlQgeXFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="68543844"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Jun 2024 13:51:07 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sExb6-0002FM-1w;
	Wed, 05 Jun 2024 20:51:04 +0000
Date: Thu, 6 Jun 2024 04:50:23 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: adc: Add support for AD4000
Message-ID: <202406060440.I43MwC4B-lkp@intel.com>
References: <e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on jic23-iio/togreg linus/master v6.10-rc2 next-20240605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/spi-Add-SPI-mode-bit-for-MOSI-idle-state-configuration/20240605-231912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v3 6/6] iio: adc: Add support for AD4000
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240606/202406060440.I43MwC4B-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406060440.I43MwC4B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406060440.I43MwC4B-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad4000.c: In function 'ad4000_single_conversion':
>> drivers/iio/adc/ad4000.c:375:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     375 |         int ret;
         |             ^~~


vim +/ret +375 drivers/iio/adc/ad4000.c

   369	
   370	static int ad4000_single_conversion(struct iio_dev *indio_dev,
   371					    const struct iio_chan_spec *chan, int *val)
   372	{
   373		struct ad4000_state *st = iio_priv(indio_dev);
   374		u32 sample;
 > 375		int ret;
   376	
   377		ret = ad4000_convert_and_acquire(st);
   378	
   379		if (chan->scan_type.storagebits > 16)
   380			sample = be32_to_cpu(st->scan.data.sample_buf32);
   381		else
   382			sample = be16_to_cpu(st->scan.data.sample_buf16);
   383	
   384		switch (chan->scan_type.realbits) {
   385		case 16:
   386			break;
   387		case 18:
   388			sample = FIELD_GET(AD4000_18BIT_MSK, sample);
   389			break;
   390		case 20:
   391			sample = FIELD_GET(AD4000_20BIT_MSK, sample);
   392			break;
   393		default:
   394			return -EINVAL;
   395		}
   396	
   397		if (chan->scan_type.sign == 's')
   398			*val = sign_extend32(sample, chan->scan_type.realbits - 1);
   399	
   400		return IIO_VAL_INT;
   401	}
   402	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

