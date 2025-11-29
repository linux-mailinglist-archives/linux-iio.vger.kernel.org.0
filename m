Return-Path: <linux-iio+bounces-26563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C74C94582
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 18:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 496AC4E211F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277A2773FE;
	Sat, 29 Nov 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jej8diPT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500823E325;
	Sat, 29 Nov 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436107; cv=none; b=LW8He29gENUbYEV3sL8zdUaGDco5zmVKKjOHlX9zkJ4B9btSo74FVMEM6aRqfPPt5JouP/P9TibfDXOcTQBtpCj6cvrudoc533J3JdcLS1BZ0dEGO2HlHRBZFiselipgI1idliaR25LsyUmIDL34OuViW3XOHLVwxMgKfDKMmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436107; c=relaxed/simple;
	bh=+bevP/0R/VoXIhpIIKnzgq5Z8RfHu4MVErQ3XrbNF3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs/0msTzouIP9I7nZM3nYvZf4BsIeYGK4yE5+SxuqKYZH2JmVCgb95to/olAWbmdnHQPXJRtFcXJX+9ePwVYmLTjdPoEqjva1aQvJbZXL+och0X6QHNnfQI3Rd0dXvOKAilNrq4LxQpaxTEAjYkyjnkXeGDYnrGMFFgk2ibJKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jej8diPT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764436105; x=1795972105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bevP/0R/VoXIhpIIKnzgq5Z8RfHu4MVErQ3XrbNF3E=;
  b=jej8diPTsA8IUFRe4EoeJaFh6IHAJ7w4MP5cX18xf33Zgn9uNeJZEC2V
   cwPfp47oy/Q1tPHfLT2LcaTpGJzEvkSmf5Y2qYy/YQUB/U8xFFOkmk6x/
   5yns75l7ZA0OQbDrFjSObQz0DUiCIJKKSK5JHE7v2/TCfsAOtnYjJvbnJ
   pwpsUBABVlBGStrlLfzZH0ZSrnw6KMdKxhy92ChHvHHfIy+yIOTOCgnk1
   oY8KPKvGhCutKchSGm7DNRl3v0fv+X4VyRk73CeeyYpp+iU4x3gxaClJ3
   /Yfiv2CaltEEWrZhbsEXlcKw/Ps4UUYqHqOfHnRz0vGASrSvW+l7NpSMm
   Q==;
X-CSE-ConnectionGUID: URbHHc9ZR/eogLZ4PURrpw==
X-CSE-MsgGUID: I+fJuZY5RtSe3assQOhGFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="76749359"
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="76749359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 09:08:24 -0800
X-CSE-ConnectionGUID: EziT+gQLTu2QFv3RtSKfyg==
X-CSE-MsgGUID: HPx5jHnCTAmAzzOq8iOJSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="197886281"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Nov 2025 09:08:21 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vPOQk-000000007PR-2yvB;
	Sat, 29 Nov 2025 17:08:18 +0000
Date: Sun, 30 Nov 2025 01:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <202511300040.bsFH07WD-lkp@intel.com>
References: <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>

Hi Kurt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f9e05791642810a0cf6237d39fafd6fec5e0b4bb]

url:    https://github.com/intel-lab-lkp/linux/commits/Kurt-Borja/dt-bindings-iio-adc-Add-TI-ADS1018-ADS1118/20251129-120153
base:   f9e05791642810a0cf6237d39fafd6fec5e0b4bb
patch link:    https://lore.kernel.org/r/20251128-ads1x18-v3-2-a6ebab815b2d%40gmail.com
patch subject: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251130/202511300040.bsFH07WD-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251130/202511300040.bsFH07WD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511300040.bsFH07WD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/iio/adc/ti-ads1018.c:183 function parameter 'ads1018' not described in 'ads1018_get_data_rate_mode'
>> Warning: drivers/iio/adc/ti-ads1018.c:197 function parameter 'ads1018' not described in 'ads1018_get_pga_mode'
>> Warning: drivers/iio/adc/ti-ads1018.c:213 function parameter 'ads1018' not described in 'ads1018_set_data_rate_mode'
>> Warning: drivers/iio/adc/ti-ads1018.c:229 function parameter 'ads1018' not described in 'ads1018_set_pga_mode'
>> Warning: drivers/iio/adc/ti-ads1018.c:246 function parameter 'ads1018' not described in 'ads1018_calc_delay'
>> Warning: drivers/iio/adc/ti-ads1018.c:272 function parameter 'ads1018' not described in 'ads1018_read_unlocked'
>> Warning: drivers/iio/adc/ti-ads1018.c:302 function parameter 'ads1018' not described in 'ads1018_oneshot'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

