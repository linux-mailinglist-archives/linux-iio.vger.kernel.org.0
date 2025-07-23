Return-Path: <linux-iio+bounces-21894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE78B0ED68
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5336E3B7538
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99654280A56;
	Wed, 23 Jul 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiqrWl5G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B6279DB6;
	Wed, 23 Jul 2025 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259889; cv=none; b=dJ/XUR2EcBsohV9Ok0jTFn5j2gVfvIoBSbDo721vM4C6V1f2+JkdMgUsgGRekciYgHlY0tPPYm+WHZ0Mf05rVtqAeibLxhVRfNOw9zCWaRbpw+o3iYrUlKu1XQ0txhG66zu/PV5cE9D5L2A9PBkZH0YUZ/D+pt4JJi9SPLrCFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259889; c=relaxed/simple;
	bh=4qbZQMMBOmmLEL/u4/6u8vCeedLqEVOr855SNhW0HrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWgEHxN7hCn/ZSdan1l2l0XGSfC9Kmjzps4h6sUQPusCX7iXrceF5BBAAwy5wFBIsXb2ZcFxMxDsPLCyunCqCfVMo3oCJ9jzPgOUsoYVFgBQyn2nWiyzjxmqYFHHSRAklibPU98Akh49T116iGnRHDmRr1+G3tu8v1y/ei0TNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiqrWl5G; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753259888; x=1784795888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4qbZQMMBOmmLEL/u4/6u8vCeedLqEVOr855SNhW0HrM=;
  b=RiqrWl5GowWx3Srs9SRg7+hG0m3Ro3fTeyzxmo+483Mu0bdHamqiBtOy
   GJv+PMcwEZlkalAuElG6T7bVntGo4kGDVrVuFxLfiawzGm8rpTFMg/Trs
   nsWJEOo/oKozKAFB8AgUrB8fsDuLoLCoGUQVMrTxQ9h6LqcsEqObQG2zV
   wmGL8t9f2sgIkp2CxsS9hreY7Fe88Rt1OAHVY/qvVB4Q/LuIyImGfMHgB
   MHjTPeSJ/MIVx3hdRbmSswTVkQN3HEe4MrEZYE7BweQ1zFtR82UTOUpU9
   EaTdvgekkY3lfBngJIHzusG2nQDkkDEp2q3FzAKg+OpuAA1Q+zQ4qGI2X
   Q==;
X-CSE-ConnectionGUID: iNqMaG8TRvqB7/6uL7Wt5g==
X-CSE-MsgGUID: 0TtN8cwiQauhS0EMwAQleg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55382773"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55382773"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 01:38:07 -0700
X-CSE-ConnectionGUID: LQ9Qcj+iT52wKy4Bwqf+PQ==
X-CSE-MsgGUID: i1lLUci5QUGmNhtoGsrTIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190348638"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Jul 2025 01:38:01 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueUz9-000J8l-16;
	Wed, 23 Jul 2025 08:37:59 +0000
Date: Wed, 23 Jul 2025 16:37:30 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org
Subject: Re: [PATCH v2 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <202507231529.OH2sdMoF-lkp@intel.com>
References: <20250722101317.76729-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722101317.76729-2-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250722]
[also build test WARNING on v6.16-rc7]
[cannot apply to jic23-iio/togreg sre-power-supply/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/spmi-Implement-spmi_subdevice_alloc_and_add-and-devm-variant/20250722-181911
base:   next-20250722
patch link:    https://lore.kernel.org/r/20250722101317.76729-2-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 1/7] spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
config: sparc-randconfig-001-20250723 (https://download.01.org/0day-ci/archive/20250723/202507231529.OH2sdMoF-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507231529.OH2sdMoF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507231529.OH2sdMoF-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: module spmi-devres uses symbol spmi_subdevice_remove from namespace SPMI, but does not import it.
>> WARNING: modpost: module spmi-devres uses symbol spmi_subdevice_alloc_and_add from namespace SPMI, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

