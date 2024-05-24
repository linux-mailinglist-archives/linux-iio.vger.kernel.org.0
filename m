Return-Path: <linux-iio+bounces-5248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8998CE172
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08101C21052
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D80128396;
	Fri, 24 May 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZY7i0DJH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67138FA0;
	Fri, 24 May 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535128; cv=none; b=g8LoJhZxTEgHanMA9nX6xI0uOS7TZ1U/mdjVaYB2RfgzIfvWMh1et4QP1ABG6X2X4Fea420ONmG/n+ZBkYfOxYWjG5exl1cURtDefdKBL41xj8REF+ltlofTqHiXq8bQ1ChtU5rRRIypO5DEW2+Vp7ucAjHvPpJUdcDeQYqRMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535128; c=relaxed/simple;
	bh=gEpxqnhJewyVo17z9MQUXr2dRWmpPDHyYY8T/8oxJvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9SgBXBaQJ6OleEV8gv6jnCz1hx8fGDeVbs1BJPshLMF3fyIJhTJByfyncEEqlNNdHdZa6DHBPr6GfFeZKJFhvVsD1Q6RpOL1YPt0XsXKrSi1vCk+8ye7bCHzJc6fOfK1n09I/6XWL5XvT3mkAFuxPXoCByIZyGIdRN5mbZ6s1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZY7i0DJH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716535127; x=1748071127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEpxqnhJewyVo17z9MQUXr2dRWmpPDHyYY8T/8oxJvE=;
  b=ZY7i0DJHRXpnPOiBsXLReyVkSpkLh6+zeZAqqkEbXZCA7oLQkRDkukZz
   v7EhUmsTpg/K65PonVZXxz7sOSo4oYO+gBpCE8RrijWBzhIldUhcIUKUK
   mb9SsIEFlCpNlH4Ep6s5OM3HLBkSjDE1HGVe6PijHcqmM9llRfr8JA5sI
   LuqbdmuAeGPTQlGAYgXgDDfvFciDU7kP/mLZmbZP3v5WkjYIn/GRhxr2t
   aTzvKmLZTTHsgI2prIXpMG1nR4Y71pOuHcuARPaqjAJ5g9bXHI09mNEdE
   mecXXvVoNUg5xLNSDgaK86NeYKBZwGcw5tI835EX0IZyo1vDESNy/+g+F
   Q==;
X-CSE-ConnectionGUID: Hn1hm+1oTFq7GBmaTN9Rog==
X-CSE-MsgGUID: jUhQpeFsQLWA1Uezx8KdQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12684220"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12684220"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:18:46 -0700
X-CSE-ConnectionGUID: xT9SPV0wT/aZPvAk2lxcCQ==
X-CSE-MsgGUID: MZJgdZYrRsSd36J5AsCAkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="33946883"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 24 May 2024 00:18:42 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAPCJ-00045P-1H;
	Fri, 24 May 2024 07:18:39 +0000
Date: Fri, 24 May 2024 15:17:43 +0800
From: kernel test robot <lkp@intel.com>
To: ranechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ranechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: adc: add support for ad777x family
Message-ID: <202405241412.bLit8xvt-lkp@intel.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522120005.18197-1-ramona.nechita@analog.com>

Hi ranechita,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.9 next-20240523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ranechita/drivers-iio-adc-add-support-for-ad777x-family/20240522-203155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240522120005.18197-1-ramona.nechita%40analog.com
patch subject: [PATCH] drivers: iio: adc: add support for ad777x family
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240524/202405241412.bLit8xvt-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241412.bLit8xvt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241412.bLit8xvt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad7779.c:28:10: fatal error: 'cf_axi_adc.h' file not found
      28 | #include "cf_axi_adc.h"
         |          ^~~~~~~~~~~~~~
   1 error generated.


vim +28 drivers/iio/adc/ad7779.c

    27	
  > 28	#include "cf_axi_adc.h"
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

