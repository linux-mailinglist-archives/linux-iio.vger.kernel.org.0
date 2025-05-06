Return-Path: <linux-iio+bounces-19184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26FAABCF8
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 10:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C17B5038C6
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910EF21ADAE;
	Tue,  6 May 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0enN5CT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7714A639;
	Tue,  6 May 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519723; cv=none; b=CJQUahHR/vBWgLuk6j8DCUKv60VPazngaJF1C8xnPUVQUrZ68LVLug3aoqWgE+z33N7qeE3ZMaw20XcpeDQH0OXPGJS0J1qoZVafxxY/tGa424yNLDBdG3w4GGS7OhA8yHcNKd0DBxqFWM0X1dR3Xp1x/9Ljld/vYEQmD4G0j0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519723; c=relaxed/simple;
	bh=j/1IV7tCIQmBeZPRH9vvJKUGS/RAT+fb8WT9/9p4OUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfj0cnjsGYh22zMhOIyxUASfDKNmMrJnIJGwNEdOEEJKKTqtSyVQxkbKarGKfJfIhnj9CA06wzJq4UMAhina4fflCZalU2N9kUt9k0rkWgBamKylKbaOa2s3bX3fcPPb848DXGhFi/LDOR+9zqcIBtJIAVT+cX139q9yAr3dtmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0enN5CT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746519722; x=1778055722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/1IV7tCIQmBeZPRH9vvJKUGS/RAT+fb8WT9/9p4OUw=;
  b=d0enN5CT5eMjsXaDr5PnDk3rD8kB4qgL47cEcCi3oQqqWs7B7IpmGYmQ
   X9I6K/gMYb9PXDzt1CyGSS3wrb2R3UHeHvTkyJbprVn3/5sUdN5BzwzrI
   8U+QKRM7LM72HNzJ0UERq+q7hSfbtTz8NEqRu2POTkHjBxyQyLvJRbzxX
   po9qXdjlYcJyrbuABtF7/PCbqXxkASX9AExtrkgDlncHcol3gKJShXtVQ
   EUEwgo+PrEqqzSwziF3Jl9tL1RLOMIdKE5c+G8uDkyyKkn1dOqLPSL5rH
   kd/+alwrZkqDgorpoj/euuia168ytVW8Fsf7sQVswAyATREYf9FOp3pF2
   A==;
X-CSE-ConnectionGUID: bfpxp5elScuwSBnS+AHxMQ==
X-CSE-MsgGUID: J+cxqZUgSbyKcM1WpPsseA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58801461"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="58801461"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 01:22:01 -0700
X-CSE-ConnectionGUID: P94EiA+ET1e9JqFtksDmlQ==
X-CSE-MsgGUID: VI67xs1PQqqGJbunBsfhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="140665739"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 May 2025 01:21:57 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCDYo-0006Oh-0O;
	Tue, 06 May 2025 08:21:54 +0000
Date: Tue, 6 May 2025 16:21:29 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 4/7] iio: adc: ad4170: Add clock provider support
Message-ID: <202505061552.mYM50gr5-lkp@intel.com>
References: <bede8227189637568f9425cd6848e21be33c2fd2.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bede8227189637568f9425cd6848e21be33c2fd2.1745841276.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1c2409fe38d5c19015d69851d15ba543d1911932]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-Add-AD4170/20250428-222010
base:   1c2409fe38d5c19015d69851d15ba543d1911932
patch link:    https://lore.kernel.org/r/bede8227189637568f9425cd6848e21be33c2fd2.1745841276.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v2 4/7] iio: adc: ad4170: Add clock provider support
config: sh-kismet-CONFIG_COMMON_CLK-CONFIG_AD4170-0-0 (https://download.01.org/0day-ci/archive/20250506/202505061552.mYM50gr5-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250506/202505061552.mYM50gr5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505061552.mYM50gr5-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for COMMON_CLK when selected by AD4170
   WARNING: unmet direct dependencies detected for COMMON_CLK
     Depends on [n]: !HAVE_LEGACY_CLK [=y]
     Selected by [y]:
     - AD4170 [=y] && IIO [=y] && SPI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

