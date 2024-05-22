Return-Path: <linux-iio+bounces-5190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD578CC924
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 00:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E771C210EC
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBC1494A1;
	Wed, 22 May 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdDI8Zin"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2695148848;
	Wed, 22 May 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716417689; cv=none; b=QBYQZeYPc2mDT+KvQGXhmpyns1d1JvDVE9S1v3nsYd/7dshqtk7627eHbjU4e/q8BHUYVOBxWWmIYFl9zvRl/2Pxff27DNY1KoKDnUqKf1Nl0eODHr2ggbt9dLRqKCPLQ2J7nwtOjWvFiwP/awoer4WXiOD1N6tZwpoTf4g64oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716417689; c=relaxed/simple;
	bh=iuj6Q7bXd0nsxTrkcDOpqVGIlXug7kdeJu0pY6RhbNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB0E0Le1M8IDzPtRePd+d4F50mSgq3af6GTlJ89vB2vvL9q0y4mc4elqNlRyIgZdYgHdrS6CCxx59OJC7p6OdB2qAaEbcB8ry69jN/8i+wi3eQA1+kKxaV+toBVWr6dWqV/UpQUEnQGJEwtjBzjOkTVTXb1vDu4Vb4DxsRXInh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdDI8Zin; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716417688; x=1747953688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iuj6Q7bXd0nsxTrkcDOpqVGIlXug7kdeJu0pY6RhbNk=;
  b=SdDI8ZinZ3ht3i1lg13RgA+ploGJACQpfhVcN9r8NQzKoWHWBhif7iiq
   /x+pwAuBdjVdqHow+UwvY4N3Tv+8gaoXDjn2Hzth3XC/sGmZ+CEKjZPdj
   DuuZYkGZDW2+p0um4d2DFnr6vuLsragRIMsO9nwARy/KBrbsvTFo2N7HX
   Rh9H2ByUoYu3h92cOj5fnbhUDmjkLUT741RH9JWRNJH7ZM7iT7e8yFwGf
   QAX1yi/tpfDDNRFQks0gQXin9ap9QjepB/RJwY8XMrjNdYNyZpf6zDhhk
   055hfTWb6BbSsBr12QyJAk2u530D4vPS6JmXdFgUL02ZxBty4AuR5AcNT
   Q==;
X-CSE-ConnectionGUID: 8gpRSQtLTPm0r5cjx7XAeg==
X-CSE-MsgGUID: g4LoL1ARRf+F6Sal9eqqBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12933619"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12933619"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:41:27 -0700
X-CSE-ConnectionGUID: m3vrOt1PTpG4zp3FdFmcjA==
X-CSE-MsgGUID: bPKkFEi2QqSqVJ78P0JLGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33344409"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 May 2024 15:41:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9ue9-0002Bv-0a;
	Wed, 22 May 2024 22:41:21 +0000
Date: Thu, 23 May 2024 06:40:47 +0800
From: kernel test robot <lkp@intel.com>
To: ranechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ranechita <ramona.nechita@analog.com>,
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
Message-ID: <202405230610.tR3hCo2B-lkp@intel.com>
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
[also build test ERROR on linus/master v6.9 next-20240522]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ranechita/drivers-iio-adc-add-support-for-ad777x-family/20240522-203155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240522120005.18197-1-ramona.nechita%40analog.com
patch subject: [PATCH] drivers: iio: adc: add support for ad777x family
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240523/202405230610.tR3hCo2B-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405230610.tR3hCo2B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405230610.tR3hCo2B-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad7779.c:28:10: fatal error: cf_axi_adc.h: No such file or directory
      28 | #include "cf_axi_adc.h"
         |          ^~~~~~~~~~~~~~
   compilation terminated.


vim +28 drivers/iio/adc/ad7779.c

    27	
  > 28	#include "cf_axi_adc.h"
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

