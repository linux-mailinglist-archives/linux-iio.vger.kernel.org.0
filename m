Return-Path: <linux-iio+bounces-7180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C214E9246BD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 19:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9832849AD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1421C0067;
	Tue,  2 Jul 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neuX7k4j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566301BE873;
	Tue,  2 Jul 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942990; cv=none; b=ikL3XVUDWoSjiA3X9u6bhBQcu99Iu+uRo1akjjEcfWQo6b3EtPxVvdo0j9Q9mwxIRTdqRkcbmwy0P0yu8vMbbEPvLf1Og4do+H/LXUtg+GHTE1u4U/nbaUV0O7MkTeEFq78K0AIhf10wjuejdZsutmvOz5GRoYXbf7MJqQTA02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942990; c=relaxed/simple;
	bh=Apev7mV1TmbmNliNcO9E2giuYRzMGlA8lEdXvzWk5K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr9mFwg0yiYisWI7rtJKkEsMVckDrZDxX36YPvqz3u+hjb44ayPIvwgM22AGZJTjXTgs5fbjNFP+/N0W3Y2DxH4amFNVnUFmDgyQBNcdiUv/NNr7J9YzPN7MuUOa5TJhXH75bKbpnxyaRYUKooy7A2ZLJsEhM8c7VleqGp73eNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neuX7k4j; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719942989; x=1751478989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Apev7mV1TmbmNliNcO9E2giuYRzMGlA8lEdXvzWk5K8=;
  b=neuX7k4jwwnJRenC9sc1wHBwyYOwfqdhO1HwLVGux5nQsSpgnH/DjYC7
   /yXtap0RVqI43zysyT7svqZej0Gwc3Z57TssF85d1hzTyMGtqonfCFpXF
   RZEe7Fzo8feFhZMkMaWer7gUlLi9pZs3KUhgw0emeGxGmSKjgDyCvMOnH
   bZaKShb9ZwtGlrpKxdn+Xnf2iFozowbHOlrihxnC8kxj9E+lrzfH1CWIJ
   X0S5wQVvnmrEWut4I93L5pM1gGegzhyrqOBzZoendyF4liHR7EYMdqRnn
   VxyUjRBoxQWX14yBB+UxPqadi+n03pstZ6/28lNF39R919/VjElHwqpKS
   Q==;
X-CSE-ConnectionGUID: tPjIfqw8Riig4GoSv+2nWA==
X-CSE-MsgGUID: RaZthrMPR8WQ8toWlulLvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16976994"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16976994"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:56:28 -0700
X-CSE-ConnectionGUID: 0w0GjoV9TYS9IszbimlegA==
X-CSE-MsgGUID: qJ2dLYKeReqovNOnMY+mjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="83533564"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2024 10:56:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOhjq-000OUS-1p;
	Tue, 02 Jul 2024 17:56:22 +0000
Date: Wed, 3 Jul 2024 01:55:10 +0800
From: kernel test robot <lkp@intel.com>
To: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Petar Stoykov <pd.pstoykov@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add Sensirion SDP500
Message-ID: <202407030117.3F6Sm9vA-lkp@intel.com>
References: <20240702-mainline_sdp500-v3-3-0902047b3eee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-mainline_sdp500-v3-3-0902047b3eee@gmail.com>

Hi Petar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ab27740f76654ed58dd32ac0ba0031c18a6dea3b]

url:    https://github.com/intel-lab-lkp/linux/commits/Petar-Stoykov-via-B4-Relay/dt-bindings-iio-pressure-Add-Sensirion-SDP500/20240702-235054
base:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
patch link:    https://lore.kernel.org/r/20240702-mainline_sdp500-v3-3-0902047b3eee%40gmail.com
patch subject: [PATCH v3 3/3] MAINTAINERS: Add Sensirion SDP500
reproduce: (https://download.01.org/0day-ci/archive/20240703/202407030117.3F6Sm9vA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407030117.3F6Sm9vA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
   Warning: file ./Documentation/ABI/testing/sysfs-platform-silicom#20:
   What '/sys/devices/platform/silicom-platform/power_cycle' doesn't have a description
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

