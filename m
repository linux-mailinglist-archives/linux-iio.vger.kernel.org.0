Return-Path: <linux-iio+bounces-23184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4CB3337A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 03:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869243B9362
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0461F4174;
	Mon, 25 Aug 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBSloFax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC1194C75;
	Mon, 25 Aug 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756084816; cv=none; b=CdLcnl0uNkEZHa35BT2pxWE3NyATVkKYHzKjDhzq4lFtWCOR08O+Lu1H9cd5fkemGc3a3ufGpSNK9l9MVQP+WgzPd/TVlV599+BxLbnYW87vsK1HZW888kbh5XaDii3rDsgrQdwoVdCLIx5lnpewKYGZU1CnQltK9z706QgGwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756084816; c=relaxed/simple;
	bh=i0RXekYR/78nngGBKq7LfKNLYqV8jqmvi+5G0IVH1+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO24+cXrFM9VKcNakyUTteJBkP7tVwAxg/Jc0D92Dh+i2tFXRccyk9TvxHLYTCniNYa4lt2YoUxWONZI/cAYget6LBh+5TheqWka1dVrdCnAinR2mNzbINsyjMc1D13Hsf4qO1fNJ4sXRfTA3wwLkDRmE80gnZd0wEWUQjGjzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBSloFax; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756084815; x=1787620815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i0RXekYR/78nngGBKq7LfKNLYqV8jqmvi+5G0IVH1+g=;
  b=KBSloFax/rObWuRFFUeziOlfg4OaonkgK7BZ1jZCtkXtMlI/Ci4aaCAR
   5bM14AoNVWSaaPh4L4V95rqHlcJj4/IINL23bRyv15i22VM3FMIMYQFud
   dxoi0mFkFLGpwf15LBSN55zjRlQz/r5gJuJeHtaLCoXbOhJl/7LkoDyCE
   oisLMoSm/2Ngh3Eibi0wJzYFXVuVgGbfctzTDqzb5QEpPtp0NP0nG2waN
   aNnxQ/rrt1YxnX9TGDszuxD/M45Ruq2zjfjE7KU2dAyWte+XqqOa6Zb6P
   auV38oqDZ1jaNOHeogkst5hSQdQhDdVMq1KEWqIUYVhD47p7EF4/N3H5/
   Q==;
X-CSE-ConnectionGUID: +1keEsYERWaCBAvbkO7k5Q==
X-CSE-MsgGUID: LGN4GjswRrysDwNqyIPlAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69395213"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69395213"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 18:20:14 -0700
X-CSE-ConnectionGUID: c631AIrjRRKQ4uvTXEIvbg==
X-CSE-MsgGUID: kSUpzhevSlqVTHXoTMLhbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="174444050"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 24 Aug 2025 18:20:12 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqLsP-000NIV-1s;
	Mon, 25 Aug 2025 01:20:07 +0000
Date: Mon, 25 Aug 2025 09:19:05 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH v5 4/6] iio: adc: add ade9000 support
Message-ID: <202508250933.cmESvJJG-lkp@intel.com>
References: <20250822160157.5092-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822160157.5092-5-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.17-rc3 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-add-IIO_ALTCURRENT-channel-type/20250823-001017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250822160157.5092-5-antoniu.miclaus%40analog.com
patch subject: [PATCH v5 4/6] iio: adc: add ade9000 support
config: i386-randconfig-r123-20250824 (https://download.01.org/0day-ci/archive/20250825/202508250933.cmESvJJG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250825/202508250933.cmESvJJG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508250933.cmESvJJG-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_clk_register" [drivers/iio/adc/ade9000.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

