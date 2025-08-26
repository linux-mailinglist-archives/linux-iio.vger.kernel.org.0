Return-Path: <linux-iio+bounces-23296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE4B358BA
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 11:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4CA3BC6F7
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454BC30748C;
	Tue, 26 Aug 2025 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/VN1Oj+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5BE306D48;
	Tue, 26 Aug 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200169; cv=none; b=PeQx5v57W3IRNrp6MWCjUWBzyGrr1n127WVM/JDoL7p+vDJT2YsoNMpzcGr0XU/jFX06/hRRocELR/hlT49O7UPXvSO605eaKFoVXXwH1eaQ6GF1m2VFPvH9rAjId0P6KnycKVmlqfBiqKy1JLQwrlio3uC467M5js2M2X7y84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200169; c=relaxed/simple;
	bh=cF/+t7YqCrNDg50jpNmnlCcL8GC0O3MrdFh1V8+gYws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxTcXAZ0kVjjlVIzKGCwJ0dqxSFkGPwGZSHHfCzyWk4c58lHNt/BiK6/GXcONQsKrJ0nFERIV+Y5SiNBoJ3EvlQpc7VxSTrwYmhsvGKah455REUOkxVcu9iYOUkr55BXWdhTlp+5KjY2FvUTlmYcDWuuV8wJsZNzHVd77kCezLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/VN1Oj+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756200167; x=1787736167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cF/+t7YqCrNDg50jpNmnlCcL8GC0O3MrdFh1V8+gYws=;
  b=Y/VN1Oj+EfUq3C0VMsVVJ1bV2nXbQTo71mebmu5Ox7v7RYcyi/8JCuXZ
   sqAZeYK2HQZEVIaiXQNxmt/3V3ZggwnGt5yjMKD41V2keCeBsh+b/r732
   T810TqV2zE3onbpAcwoeXR4avgzjGbGEZkuxEATrEUO9J6Iedm0ncnJEN
   dc4XSAN8G9hHKK9BFtB1x8xQ3UhMrxvSuJeqKwuDACy0N38YvE5ygc+RV
   QHIhITub/e6sfKrt/JwDGdVKDdv9ACFAyL1gWLMM56RDYhHF1O46BmxEd
   /cz7KxVSmYAMIiGmYNYvYPbsFYwPwo+40A4gPy9zbjimREIPDcJlxuDKA
   A==;
X-CSE-ConnectionGUID: I9h+OnZgRWWYP7yhLDfZBQ==
X-CSE-MsgGUID: 1A4S0oG5TxG52+8sO4CAcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="76028112"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="76028112"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 02:22:46 -0700
X-CSE-ConnectionGUID: t+UCmRX3T7SPuBu8l9kCaA==
X-CSE-MsgGUID: x21R8PKZSbaO0g5oh9U2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174830972"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 26 Aug 2025 02:22:43 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqpt0-000OMr-05;
	Tue, 26 Aug 2025 09:22:41 +0000
Date: Tue, 26 Aug 2025 17:21:00 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7124: add clock output support
Message-ID: <202508261731.33GQLUPx-lkp@intel.com>
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on 91812d3843409c235f336f32f1c37ddc790f1e03]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/dt-bindings-iio-adc-adi-ad7124-fix-clocks-properties/20250826-065924
base:   91812d3843409c235f336f32f1c37ddc790f1e03
patch link:    https://lore.kernel.org/r/20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35%40baylibre.com
patch subject: [PATCH v2 4/4] iio: adc: ad7124: add clock output support
config: sparc-randconfig-002-20250826 (https://download.01.org/0day-ci/archive/20250826/202508261731.33GQLUPx-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508261731.33GQLUPx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508261731.33GQLUPx-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__clk_hw_register_fixed_rate" [drivers/iio/adc/ad7124.ko] undefined!
>> ERROR: modpost: "of_clk_hw_simple_get" [drivers/iio/adc/ad7124.ko] undefined!
>> ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/iio/adc/ad7124.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

