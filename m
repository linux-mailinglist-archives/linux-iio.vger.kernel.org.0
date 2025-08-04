Return-Path: <linux-iio+bounces-22293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF193B1A8BF
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B965318A2F8A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D67226177;
	Mon,  4 Aug 2025 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CssflQVc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B061165F13;
	Mon,  4 Aug 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754329784; cv=none; b=nKX6+cdEs97e0VLG5lyjImBx/EbPtz87yKIDUkAmovIBRnx9QjUNkfIfI8CN8yi0eoQ0ldCTXxbxD8ME2M2crUSZDUUG1oICTFGskQ994W8hlyR8vfEQjbswUZnUItpGAp8alu9Yao8WMt3YZLtgEU4eS509vPD75w/nw3Xik8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754329784; c=relaxed/simple;
	bh=q6heWKyDFbjItz7wuCWRrYQJUr7D5cG41YJHZWVIU6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwkU2zn672YnuZFpRhOFwvpijUVNFFQd+44UsJML2+06TdModwHTjW4d7j2f7Y8/swIZsers1cd5MRJBi15cNFNweoviT3PxeBfK2jql9O0B/2wHmbk08CddBdL43nv/n5VxaqdSLqaxlNuTDOk6PIziQYNm/1f9jRkXtTMN50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CssflQVc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754329783; x=1785865783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6heWKyDFbjItz7wuCWRrYQJUr7D5cG41YJHZWVIU6g=;
  b=CssflQVcXPUQfuFdUTUjNFl0hpLSC+6bHfy0ZdmiMUsW5ZQtNkiqgBeb
   MrsDH3V666Bzq6E/MSmvC56XoWhisenEyaghFAHrhIraP3YdjHgmMXlHI
   M4kRTath1iYFL2t6Pf9G5sOkNM4BALckt4BhmqWGRoEUVQCEEXeQr1yJO
   W1vwYIktgMJAy5NXNU6eEsGKj+1P5sVsytMLfqxHU3R0qSoxotN7DCzeK
   rYZTy0yj8fOw7j0Xca3sZGgjsCW6t3Ebl5cilCF6t51/euABWq0o282uV
   u43XZLVLYDEddrMR1VQ3WgtIb6WXq3Zu1BaMY2MEO0k1QM/OtuMJT2Cse
   w==;
X-CSE-ConnectionGUID: hisk8w+TSxq61eVMpqU+Sw==
X-CSE-MsgGUID: 2UIoeoXXQWOa1Tbp9vUA0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="67304834"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67304834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 10:49:42 -0700
X-CSE-ConnectionGUID: olE6/67RQQOuZ+UKVgVyYA==
X-CSE-MsgGUID: 3xthNx7uR+eN5fI4n0anQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163905010"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Aug 2025 10:49:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uizJX-0000At-0a;
	Mon, 04 Aug 2025 17:49:35 +0000
Date: Tue, 5 Aug 2025 01:49:07 +0800
From: kernel test robot <lkp@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
	eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, varshini.rajendran@microchip.com
Subject: Re: [PATCH 02/15] nvmem: microchip-otpc: rework to access packets
 based on tag
Message-ID: <202508050141.HKFcYdLy-lkp@intel.com>
References: <20250804100219.63325-3-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804100219.63325-3-varshini.rajendran@microchip.com>

Hi Varshini,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on jic23-iio/togreg v6.16]
[cannot apply to linus/master next-20250804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Varshini-Rajendran/ARM-dts-microchip-sama7d65-add-cpu-opps/20250804-180839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250804100219.63325-3-varshini.rajendran%40microchip.com
patch subject: [PATCH 02/15] nvmem: microchip-otpc: rework to access packets based on tag
config: arc-randconfig-002-20250804 (https://download.01.org/0day-ci/archive/20250805/202508050141.HKFcYdLy-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250805/202508050141.HKFcYdLy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508050141.HKFcYdLy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/nvmem/microchip-otpc.c:83 struct member 'payload_info' not described in 'mchp_otpc_packet'
>> Warning: drivers/nvmem/microchip-otpc.c:83 Excess struct member 'id' description in 'mchp_otpc_packet'
>> Warning: drivers/nvmem/microchip-otpc.c:83 Excess struct member 'offset' description in 'mchp_otpc_packet'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

