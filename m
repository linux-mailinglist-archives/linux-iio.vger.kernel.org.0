Return-Path: <linux-iio+bounces-15554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11BFA3706F
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE03516DADC
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB57E1FCCE1;
	Sat, 15 Feb 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbASNQqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7281F890D;
	Sat, 15 Feb 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739648128; cv=none; b=Tb7vS04yLoHk6jAQ3JGstEPe5I/NEipnWWhhEp7tfZBNPGfkXYCDz0G3NI5yXZJ3OhfA/PxHBmtwmq4yvuEELYcbOh7ytUy8lPCaONEedSoEJowKBfqyzdsam/Vk5eicClJ43MBQFjfoGZSb14QhjN64W94Nu7FjTMO5IZs3f/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739648128; c=relaxed/simple;
	bh=ikWYkDoin1yaKx3qdc9Z08RFLs1B9XJN0ceL+3+hyX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQqivpsEmtsal/01jOHIZ2g1kyH2RFafNn6swoPE6qNjWxy2k/tQwhJ9EmQ9wY2/cZcVhS2MLb9aLRAEhYBm0pCNE3TNFlWWcw+3mItFD6nU2ax/H7yDJP/p5tArMd520fiIryLLz4nuF9+9mGnpu4RZ1zVvpYhBX7npFcxjyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbASNQqr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739648127; x=1771184127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikWYkDoin1yaKx3qdc9Z08RFLs1B9XJN0ceL+3+hyX4=;
  b=kbASNQqrApk23tCrQpQsEiaCglf9Gs2r66qZq4IoFFSzBCRDsRueTOYW
   GQace4MEY+cYK9ZCiJ1+hMdzzXtsDJe5h4uzaxQWZ4aP5AZZ2bvXdeWPw
   P/PZrfzVwKsv5214x7H1+QBhO1G2ujoy0q/93wxYxE+p/fZdDLLgicTlD
   o8XsDd6EbfwU5hIRQnApa8o89H+wcn0rjvJ9FpdYkbLS/CygGKYJe+96Z
   RX2edhRdqqo+GeaWGT997Tl0PbfFokkVupgf4LxjHxY+d1awQekHdwHW4
   62wZMCYuXon8VLqlDdzop7N2G3zbuvYvqWLOq7HAejygRwMnwgmbV3TOD
   Q==;
X-CSE-ConnectionGUID: OzLBNtRoSLiUxEyDZTx/aQ==
X-CSE-MsgGUID: 4vWYEFD2QI6sGivwMEJQDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="51356940"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="51356940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 11:35:27 -0800
X-CSE-ConnectionGUID: ykA1mrAHR3eNTeriF7hLMA==
X-CSE-MsgGUID: p5CXGFyMQL+UMtGLPwtkFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136972271"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Feb 2025 11:35:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjNwe-001B7N-2f;
	Sat, 15 Feb 2025 19:35:20 +0000
Date: Sun, 16 Feb 2025 03:34:51 +0800
From: kernel test robot <lkp@intel.com>
To: Esteban Blanc <eblanc@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Esteban Blanc <eblanc@baylibre.com>
Subject: Re: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
Message-ID: <202502160351.NQfCUpV9-lkp@intel.com>
References: <20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a@baylibre.com>

Hi Esteban,

kernel test robot noticed the following build errors:

[auto build test ERROR on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/dt-bindings-iio-adc-add-ADI-ad4030-ad4630-and-ad4632/20250214-202727
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a%40baylibre.com
patch subject: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250216/202502160351.NQfCUpV9-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160351.NQfCUpV9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160351.NQfCUpV9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad4030.c:375:13: error: assigning to 'struct iio_scan_type *' from 'const struct iio_scan_type *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     375 |                 scan_type = iio_get_current_scan_type(indio_dev,
         |                           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     376 |                                                       st->chip->channels);
         |                                                       ~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +375 drivers/iio/adc/ad4030.c

   365	
   366	static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
   367					 struct iio_chan_spec const *chan,
   368					 int *val,
   369					 int *val2)
   370	{
   371		struct ad4030_state *st = iio_priv(indio_dev);
   372		struct iio_scan_type *scan_type;
   373	
   374		if (chan->differential) {
 > 375			scan_type = iio_get_current_scan_type(indio_dev,
   376							      st->chip->channels);
   377			*val = (st->vref_uv * 2) / MILLI;
   378			*val2 = scan_type->realbits;
   379			return IIO_VAL_FRACTIONAL_LOG2;
   380		}
   381	
   382		*val = st->vref_uv / MILLI;
   383		*val2 = chan->scan_type.realbits;
   384		return IIO_VAL_FRACTIONAL_LOG2;
   385	}
   386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

