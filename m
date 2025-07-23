Return-Path: <linux-iio+bounces-21897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054BB0EECA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 11:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B646958306D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 09:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0B9289817;
	Wed, 23 Jul 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG7X9Vye"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D362283141;
	Wed, 23 Jul 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264337; cv=none; b=J4J5rJIPJNnwiR+6JmzZmGQzBqXMVacRxAkwQxmW6w4lXQl6iJlWS4xkE5h6dwjNvoPzhuGy8OqaFtc+GmgnRA+c2Y5D93+3DlMynnQFI7zZ3Zcv5U130lV4f3MDzoWxEz0N66sydhABnnirNyfaYMbP/I6CWJziV7wXTxs87hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264337; c=relaxed/simple;
	bh=S7rUueZYDWfi2XdfEF4FIRPsKPUm1VdHKBUcSJ4JCHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPw4Fnfy23Mb1EUXXEcL3hMMFVDw2DKSwXbN8i/fxzTCddUU44TwaJkfC63HCqSG2L0GaOeZTe+ruGUvnoKFRBcbOiK8ZG1wVPrLOcsjY3cTj6ojEb5sWSISA19vGeBH+BvpJHdiH2AZgdy+jDQYWANRN7Rfw7Y18oAMTDlJRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG7X9Vye; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753264337; x=1784800337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7rUueZYDWfi2XdfEF4FIRPsKPUm1VdHKBUcSJ4JCHc=;
  b=PG7X9VyeLqAk8q4hPPh2CC8a+k0nIfD92OqF9ww2rajHERYL6viNWj+5
   k3udZw8c+mUFZfxaB0t07vdBQttpEqo93bkU+UtJS4WHAyImItJFsnjSL
   dGb2rG+Nl5A6wq1psyh3YIN4pCnhKDbBjwrlUBBDXJYC8dNobpT8MDnRC
   4wBl0qHKGV7XrvP0bdHWa0WkjYbNjc3aKUCu7IDYb9sXG1H5wYz+6a5LQ
   9Pal1UpELl+uOZQ03OAvLzMtRfSUbRl+eOUc4b5zzoCU91d4ZyKx6hI/a
   ORzbLE1AYeYqxl3E8RatqyRd/vC0eiH7h/fZzSYdgMMoTDXhnwLCYuQYu
   A==;
X-CSE-ConnectionGUID: Hqb5SprdSVe+5CpItuRGGQ==
X-CSE-MsgGUID: fURT+LlLTY2vPf07kvNkZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="72997160"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="72997160"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 02:52:16 -0700
X-CSE-ConnectionGUID: 6/y5p3vKShivz3vJh21Bow==
X-CSE-MsgGUID: xj2c8mPEQvC8svMxzk3i0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164843926"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jul 2025 02:52:10 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueW8u-000JCZ-0M;
	Wed, 23 Jul 2025 09:52:08 +0000
Date: Wed, 23 Jul 2025 17:52:03 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
	krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org
Subject: Re: [PATCH v2 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <202507231731.VakdiYEM-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250722]
[also build test ERROR on v6.16-rc7]
[cannot apply to jic23-iio/togreg sre-power-supply/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/spmi-Implement-spmi_subdevice_alloc_and_add-and-devm-variant/20250722-181911
base:   next-20250722
patch link:    https://lore.kernel.org/r/20250722101317.76729-2-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 1/7] spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
config: riscv-randconfig-002-20250723 (https://download.01.org/0day-ci/archive/20250723/202507231731.VakdiYEM-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507231731.VakdiYEM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507231731.VakdiYEM-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module spmi-devres uses symbol spmi_subdevice_alloc_and_add from namespace SPMI, but does not import it.
>> ERROR: modpost: module spmi-devres uses symbol spmi_subdevice_remove from namespace SPMI, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

