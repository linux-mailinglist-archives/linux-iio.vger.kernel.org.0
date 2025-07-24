Return-Path: <linux-iio+bounces-22001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E84B1133B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 23:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682E016D4A6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54F623AB8D;
	Thu, 24 Jul 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfjQx0Pu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DD23958A;
	Thu, 24 Jul 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393218; cv=none; b=SPzIEectOTdva/YF5cntlzoIR8Q8wEiE/H12ZdHgVAqPX2vtZLQu6t5EGTpBKW/BuHD9U1MvGvI3NF/lG0hb0B6tbyumKBtPqkYZNsGcYVRw1vY8Sj3ngDzxU5+1Jb43Ity+IU6s8XvpAQ3EVm5P24Y49Gs5pZ804koLyw/XOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393218; c=relaxed/simple;
	bh=neZ4nhTci/OztAR0grO1PqnyUkXOKJlgcFsWnc1vRHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHJeaaQexX721vm6zikF0YBQ7lbIlTgbhKhbwK0slf50ZjrMumOEfmmhMuEBbvAm31oqPWDA5vOnpusMjdygrpZYAn2WzHrZdkTnH5/1kXN7CUzUHJrH1dTBbSf1Wvzs/QFr6KvIu4TfAvHJDGNVwFd4vOmFGsnY7uKUX1S93hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfjQx0Pu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753393217; x=1784929217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=neZ4nhTci/OztAR0grO1PqnyUkXOKJlgcFsWnc1vRHY=;
  b=cfjQx0Pup2NGYN0uH5Ca6kV2GvOyfBsO52XQILmQycnuZQS3AD7ooiMT
   x9+rCu0nYRsmb5i43etDVfo1/xdVykkgzIbcVaHr4FKmrEL6yiL/bPjpC
   dt3DkgaPl6Enw2YiPjyp9sliJ/GC7nipO3woSpXdqT+DX3PSusoi2lg0/
   zHgAksXrYG8Ekt3sQx7Mhitygr638cYAdAMdxL4yoQcpnEBNqYmDLsg1x
   IhF2cgnAcKv8D6bkj+tFmo47tNiPvoLTXBWJTBpA8ovOvGVrb0z1Sbsxg
   u72SM2a1DmLy4e2//MLzkDMc1ghuwFSJqqUy6AoSO2YYy9Nr3NeO08QaK
   g==;
X-CSE-ConnectionGUID: zgd6fwwLTJugowJDUswRFg==
X-CSE-MsgGUID: JLff8pQCSTWZMjax1wDXhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67078124"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="67078124"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 14:40:16 -0700
X-CSE-ConnectionGUID: am3gpL4CTQ+F++tC4OhfVw==
X-CSE-MsgGUID: GKXt7Mp8RxCertJvEzhVlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="164728880"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jul 2025 14:40:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uf3fd-000KqZ-15;
	Thu, 24 Jul 2025 21:40:09 +0000
Date: Fri, 25 Jul 2025 05:39:09 +0800
From: kernel test robot <lkp@intel.com>
To: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	peterz@infradead.org, jstephan@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com, carlos.song@nxp.com, xiaoning.wang@nxp.com,
	haibo.chen@nxp.com, Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support.
Message-ID: <202507250514.dtLcgKZ2-lkp@intel.com>
References: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724083951.2273717-1-lakshay.piplani@nxp.com>

Hi Lakshay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.16-rc7 next-20250724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lakshay-Piplani/iio-temperature-Add-driver-for-NXP-P3T175x-temperature-sensor/20250724-165936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250724083951.2273717-1-lakshay.piplani%40nxp.com
patch subject: [PATCH 1/2] dt-bindings: iio: temperature: Add NXP P3T175x support.
config: arc-randconfig-052-20250725 (https://download.01.org/0day-ci/archive/20250725/202507250514.dtLcgKZ2-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250725/202507250514.dtLcgKZ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507250514.dtLcgKZ2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Duplicate compatible "nxp,p3t1755" found in schemas matching "$id":
   	http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
   	http://devicetree.org/schemas/hwmon/lm75.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

