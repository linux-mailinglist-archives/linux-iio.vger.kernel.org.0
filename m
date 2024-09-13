Return-Path: <linux-iio+bounces-9479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEED9777D1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 06:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF0DB218FA
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 04:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010861D47D6;
	Fri, 13 Sep 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNH6pXjx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FC1D3180;
	Fri, 13 Sep 2024 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201060; cv=none; b=BvI5DSm66OkYMa46pRxXvFLRhUcGfte/uGqku+2fEw5Tuv1vtEciyv8CISJzDq6efpiHgghjLbzYQAqgtCFI+8T5SIVvbDuQJARnsr2oZR69LFE1GAT7DO/BIyT7PdCge0gb/yAsVMp5okX7+t2IySBSBN4RUiIRym9yslZhdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201060; c=relaxed/simple;
	bh=S6IS0/dc6jPqT0X5YnU7M+Sh2Oaf4b+CDbvVMXZru6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi46wO6eFfIhSePvD4Rp1UxSl64qpjeBc/zG2plZhQAYK0lzMN4LpJ0IS5VxOujPprtQ8ldsKtDBKt++GF0mo0oOcDsErpoOEhWO5xYpn9dWX4T9nOmikGX0EMLMJWHc/RbtqN9PRS8BiPpMbghL6S7D6IDiWF1hag1KCi3ChGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNH6pXjx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726201059; x=1757737059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6IS0/dc6jPqT0X5YnU7M+Sh2Oaf4b+CDbvVMXZru6A=;
  b=cNH6pXjxOeUSm/aJ9bwzs8bpkVr7Ea5VQ0zXXila9pWqNBTv08GEampR
   7fPJm/ypq4wJOew6Fum9fUQZ3I87UgTAndB3AbHySSyzSRBtVsqS2wXpN
   FvBCGZ49MrezrHA3W0fXTnrv4F5xv8T7mM7T6xO6gRwBEi1pSSj7apsla
   2AwkUclPH+MOcGEjTCfbO07hU7TzhOT6wRGaKowtklBiuqgYFCR9srhtH
   7Z5lKL+aPxRo6jVBG7OzMnxfvTkdc3k0/Tko7fPxn3xzgUTkpSXdk5sSK
   WT06JVdH+ojlFXnjSs2LnB2bMD3h3TjlwTrQRm9nKjlnkDkVnoom+cOxQ
   g==;
X-CSE-ConnectionGUID: Q+Nq14MFSo24YpydrBV9VA==
X-CSE-MsgGUID: dlEK2mZ1RaGkUYh9YRAk1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="42564412"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="42564412"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:17:38 -0700
X-CSE-ConnectionGUID: jxIOVqy1Tom4J+bpPhXlWw==
X-CSE-MsgGUID: w9GyVT6yRV+ITkp8Wm6aRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="67766196"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Sep 2024 21:17:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soxkR-0005zz-0g;
	Fri, 13 Sep 2024 04:17:31 +0000
Date: Fri, 13 Sep 2024 12:16:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <202409131243.olYA3Qdt-lkp@intel.com>
References: <20240912121609.13438-3-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912121609.13438-3-ramona.nechita@analog.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.11-rc7 next-20240912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Alexandra-Nechita/dt-bindings-iio-adc-add-a7779-doc/20240912-201936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240912121609.13438-3-ramona.nechita%40analog.com
patch subject: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in sysfs-bus-iio
reproduce: (https://download.01.org/0day-ci/archive/20240913/202409131243.olYA3Qdt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131243.olYA3Qdt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

