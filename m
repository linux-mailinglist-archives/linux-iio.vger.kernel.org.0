Return-Path: <linux-iio+bounces-23132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9247BB30F9E
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 08:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46631787E1
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 06:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E382E5B12;
	Fri, 22 Aug 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJrfF+3Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1382E22AE;
	Fri, 22 Aug 2025 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845614; cv=none; b=bGCyjqEYnMBFyXHPUHN4MqE64LhcoVjO/+7DqbO2/afQWCjIPu2+tEdg42rwZZCRR0l7qKeiavDVgPW4ek79Fd6N6+oJkBseFIRSfauj1iEKog0JanjW1X/QCPXZhT4TNMNbb94RML+OrS6tDR5kPHXsi2oKB1DgKzjv6nm2RxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845614; c=relaxed/simple;
	bh=9wRvB665rcxu8fe1PXnuVkbMQ0wZR5mh+LTi0x0XhqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JikeXitFyAeBiGv79bng246zl2fPN9RRn//YlQyZONFRy83sqPRmxAhOvmMDQrbSnIFst+NK2AM+CQe2uCpiPsLuI8VWo26ZXmVM981KiMxXdlybW+MGNTf8CDa8hqr2lkypaMP7xm5H0Aq8nbPds+xsZE5o4/lvGzHYo/0RHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJrfF+3Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755845613; x=1787381613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9wRvB665rcxu8fe1PXnuVkbMQ0wZR5mh+LTi0x0XhqE=;
  b=PJrfF+3QstoDlAtbXlZJWNTKjqqbwHl8UnYyTw7dn/64uFZA3tlZlFa7
   kOqvmmjL7VrGa7nugOHZ0UPKXD0Pzt1MrAfhVehkTA5dR0iVf3Khl79yp
   hnUZ6OQ9E+/GOTfUu/JVkBlL9/z515Wov4CyzU3rsvq3gMiJYvsqTIj/C
   tHtbj8cybYhf59+alT0JAOXAK9B9zoqGrUgnrdj6TtJU6fYFhEsC7Ob8S
   tZ3SeJfUDsWtKS7g6Qnqg2vdHswtYl+iQ2EOJxevqW30730JR0gMZA4YU
   3ZmBpiwajQJikVWFdVb6wzYtlOdIrROwMwXqDyJI1mCHsDMLrQx5Lt5Al
   g==;
X-CSE-ConnectionGUID: 8h4QFdWqQ3OEHDaz8pFaZA==
X-CSE-MsgGUID: /5W3JcALQE+1b3P1vkNzaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60777425"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60777425"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:53:32 -0700
X-CSE-ConnectionGUID: G0lx52a5T56sJGD0DmjRDQ==
X-CSE-MsgGUID: q6bYU03qRYWZlhUkuK6F1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168246511"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 21 Aug 2025 23:53:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upLeP-000Kzf-0H;
	Fri, 22 Aug 2025 06:53:25 +0000
Date: Fri, 22 Aug 2025 14:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add basic support for MAX14001
Message-ID: <202508221427.TaHJJwvG-lkp@intel.com>
References: <2919a00f86c1188b83446853bcb9740138d70f44.1755778212.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2919a00f86c1188b83446853bcb9740138d70f44.1755778212.git.marilene.agarcia@gmail.com>

Hi Marilene,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7c680c4dbbb5365ad78ce661886ce1668ff40f9c]

url:    https://github.com/intel-lab-lkp/linux/commits/Marilene-Andrade-Garcia/dt-bindings-iio-adc-Add-MAX14001/20250821-225647
base:   7c680c4dbbb5365ad78ce661886ce1668ff40f9c
patch link:    https://lore.kernel.org/r/2919a00f86c1188b83446853bcb9740138d70f44.1755778212.git.marilene.agarcia%40gmail.com
patch subject: [PATCH v1 2/2] iio: adc: Add basic support for MAX14001
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250822/202508221427.TaHJJwvG-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221427.TaHJJwvG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221427.TaHJJwvG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/max14001.c:10:10: fatal error: 'asm/unaligned.h' file not found
      10 | #include <asm/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~
   1 error generated.


vim +10 drivers/iio/adc/max14001.c

  > 10	#include <asm/unaligned.h>
    11	#include <linux/bitfield.h>
    12	#include <linux/bitrev.h>
    13	#include <linux/module.h>
    14	#include <linux/spi/spi.h>
    15	#include <linux/iio/iio.h>
    16	#include <linux/regulator/consumer.h>
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

