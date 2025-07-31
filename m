Return-Path: <linux-iio+bounces-22160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BDB16B04
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 06:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDFB18C4F1F
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8A23F40E;
	Thu, 31 Jul 2025 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLmGBqgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6622F770;
	Thu, 31 Jul 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753934401; cv=none; b=iWgoUEh2MSP+w/E1IZL/sSkbPmSxqIsEvpzAnzw5fNT1UzdZMyzRw4ok7KbIizk8Lsx4jaCHE8qxNPSFgDJjBXtBa6OXY2ttNxp/yWkf2Fo11CiGkxBmtbnMAIUg5n8enaj9K4RrC4HskWDFsN4XugfU/2JqSq6Ugwn6oh5Hn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753934401; c=relaxed/simple;
	bh=OcrZsUyHq3wWNpX5cgXufQ+ZLvYsQ6Y63zo9gqCOHL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq0Fb5D++Y7J04aqj+BSW4izzJo3NaQfMex6w6Dc+N2LA2TMapIvWF/MERvWCIbH4BR9NLJb6iuYGP943Rrnp+k2LWI0qL6LVJS5YCuTrLbcKOra7ah2pILiB8gz9bqGN/XFEAEI0QDLK9xCjwgVS5Qm/X81hC1ukpRsaw4/B30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLmGBqgu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753934399; x=1785470399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OcrZsUyHq3wWNpX5cgXufQ+ZLvYsQ6Y63zo9gqCOHL4=;
  b=aLmGBqguwPgC+ZAPOuB3E0kxCLB0MKUofJJQZksjB+ZtDzGGyfKcDtI/
   Jk9MeFdP94zXwaEvD7rcW52cbW0HNU5oSmzO7zfRwpoJYrQmjHDx6W2He
   5wlF/2fYecrqSEvI3T3RfbCY7Fmvomc9M7yseE+YbThJtlUhdN5gOkcni
   hm4QzSxFIbLAy+yspVqRDoaevy/zjnIsvgIVkNH34OiS8sN26VmZeu3eq
   Sk8Jw9iOoxdTpjKG/mc8rfjAm+gbOVH6KlBwihq+n5rkqELWqLos/ljUI
   ygzcGWR0b5y9T9PDLUfI1dpgkWDyb3hQg67no/2XMkYgQ4M5obAi37up+
   w==;
X-CSE-ConnectionGUID: QP8b36mARpO8c+l4cfmB3A==
X-CSE-MsgGUID: +9Fq4xwLTuycK4sPldo3yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56336418"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56336418"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 20:59:59 -0700
X-CSE-ConnectionGUID: gYjm9tjYSkK3pLYlL9EdZg==
X-CSE-MsgGUID: p6F5ISCGQ2S6IQroCGXimQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="194138761"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2025 20:59:54 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhKSN-0003Oi-0h;
	Thu, 31 Jul 2025 03:59:51 +0000
Date: Thu, 31 Jul 2025 11:59:47 +0800
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
Subject: Re: [PATCH v3 4/7] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <202507311150.5ofvQlKl-lkp@intel.com>
References: <20250730112645.542179-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730112645.542179-5-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250730]
[cannot apply to jic23-iio/togreg sre-power-supply/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.16 v6.16-rc7 v6.16-rc6 v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/spmi-Implement-spmi_subdevice_alloc_and_add-and-devm-variant/20250730-193217
base:   next-20250730
patch link:    https://lore.kernel.org/r/20250730112645.542179-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v3 4/7] phy: qualcomm: eusb2-repeater: Migrate to devm_spmi_subdevice_alloc_and_add()
config: arm64-randconfig-002-20250731 (https://download.01.org/0day-ci/archive/20250731/202507311150.5ofvQlKl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311150.5ofvQlKl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311150.5ofvQlKl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>> aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/phy/qualcomm/phy-qcom-eusb2-repeater.o: in function `eusb2_repeater_probe':
   drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c:228:(.text+0x5a8): undefined reference to `devm_spmi_subdevice_alloc_and_add'
>> aarch64-linux-ld: drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c:236:(.text+0x61c): undefined reference to `__devm_regmap_init_spmi_ext'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

