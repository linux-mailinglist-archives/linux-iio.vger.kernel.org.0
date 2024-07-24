Return-Path: <linux-iio+bounces-7866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1E393B685
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 20:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950BA1C239F8
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4316A37C;
	Wed, 24 Jul 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCilKNMD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D215884B;
	Wed, 24 Jul 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845181; cv=none; b=KrkrSrkeQ0cCjHMFTuN7dMr1ccIE2+86pEpQ8WwuprKJObfhsXDDTL6i05F/K9M9OSt14icCf8jBG6mhrYWvTbXQb6xLJvBl1xkgOCuNX89Apj30N3qchc6rrlG4DChRDlNQmCYyAmqnnroWetQl8yak125d2FFn1NFC/CDv6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845181; c=relaxed/simple;
	bh=ytcR7tLLQZec/5rdvB6ZEixtX07E8uE1rniUQEzCK0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugOKrv+FhWiJ7DSP6y1Zs0cBi+3WKasled6/TzzBZ0yIy2gw9yNHiq+i6nj4MUiJTSXw1KpYDusM+alg7s05hHOxGyk0PKe/qfssHWNsXq7u+27SPhrKWBvHycA7sYrs8g5zOi+ythQYcKBRkck6QP1oxePp3D2pE5R5SsSG6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCilKNMD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721845178; x=1753381178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ytcR7tLLQZec/5rdvB6ZEixtX07E8uE1rniUQEzCK0o=;
  b=jCilKNMDIRTjNygEyEcazgdzvDJ0bDmRQUjtK5pJstZNq/NII6ssyu6Q
   QtT7/5wyRjYRHMwDT63wJmRDtPi5RorfzPpLNM/W5/ljlpw+1LtsI35b6
   jM+it62jsOuPoqUUmzaEuJ8HgBisyjc467F2tKojAzPk3AKPtUigAPTHT
   HX4whTHdt0aU/Fl6UJAjLsDgS3NbLY5DhFTxS36lB4531+Yrt6Fsl9JVx
   xX1ptBTV/IYNzAj2NthDzTz6U+iSvTvn9iZuYUEQ2LLC9N+fX6ox6sOd4
   e6r3ELP5CjS4Fx95Bc0HIkrc5OUjyK4F08a7gdhbejWs5jqfeeL4Y39ML
   A==;
X-CSE-ConnectionGUID: 2ZG0XGRkSnGQrijG16771A==
X-CSE-MsgGUID: ly0d137RSOKkoyBd8+JXWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="36999997"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="36999997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 11:19:37 -0700
X-CSE-ConnectionGUID: PJPz2ywtQfyvD3oTNPaMGA==
X-CSE-MsgGUID: M1zZTB4TSmqCaS//vATGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="90126197"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Jul 2024 11:19:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWgaI-000nJ6-0t;
	Wed, 24 Jul 2024 18:19:30 +0000
Date: Thu, 25 Jul 2024 02:19:11 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <202407250236.nzmLshy5-lkp@intel.com>
References: <20240724155517.12470-4-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724155517.12470-4-ramona.nechita@analog.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Alexandra-Nechita/dt-bindings-iio-adc-add-a7779-doc/20240725-000001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240724155517.12470-4-ramona.nechita%40analog.com
patch subject: [PATCH v4 2/3] Documentation: ABI: added filter mode doc in sysfs-bus-iio
reproduce: (https://download.01.org/0day-ci/archive/20240725/202407250236.nzmLshy5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407250236.nzmLshy5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

