Return-Path: <linux-iio+bounces-18572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04931A9968E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 19:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F367AD5D6
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C228C5D0;
	Wed, 23 Apr 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBzOXkiD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38892280CDC;
	Wed, 23 Apr 2025 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429135; cv=none; b=Bo+09pFjfe1ns7GUUxJZMjs7BUKDwM+FedDVzPbG0kXAzu67OD/Auk06B3WEJ7+j0hfnXX0CWzdJIw7HuvlBrmvG9RqxPEZY4B/DmzPx3x8n6qaSmbia8lHXL7CaqYD1RUVG0wZ+uoBlm5a5dKTzijQAM3tEVLdeXrBb/rFhzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429135; c=relaxed/simple;
	bh=VPDAEHukUbI+oi/4og11d+8ZLIVqGYmsWG4hYtjyuhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+ML2B4m27A9BM4M+dhdNYS1tMFtBJUeRAyTPDctYYtXwm1wpywD0cgJtf1fahibE0jqT43YKXch8QKW9cTfvO1dtzLFLBdG+tpWb3p9uqLnWmWbirf0f8XV4bntscj0/OPPU2fvSooUHtjYXF3+VBD9phkB+b2yTVkMSjTrcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBzOXkiD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745429134; x=1776965134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPDAEHukUbI+oi/4og11d+8ZLIVqGYmsWG4hYtjyuhI=;
  b=BBzOXkiDinigD5GjV7pxJfAJTUlocbUPiZZMLBEwrkbCt/18ntnyySCs
   EhsVfiSk+vNx9XmRnt8Fzak1v8m7dJcsLN+1LWuK6MqAHo6G0uceYo9xO
   V6fQtZG83C9IoqRdoC7BeDx5eLAKf2yBb+NfIBZvaw5aglH2ZiILiXpE2
   nvqZ2xS1s1jGzNOlvpSKP/AY+4W0apFqp2eHQnZF0TrWt0pAgZkQyZ48T
   1sVteVKWI5JPdVJ7xNMakg2ki/HxxZI/MWjHBpgcqOAL0Y+Aitbp9HXyX
   5QRToy2zSL8rUDEwvufXrbEyRvUZy6apXP9zz/tVV5zWK0t8SG2yFqEBX
   g==;
X-CSE-ConnectionGUID: VBzGLQAETDS/Q9+HlvFXEQ==
X-CSE-MsgGUID: +oSlkJEgQx29DHQi/wyMSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50863731"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50863731"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:25:33 -0700
X-CSE-ConnectionGUID: bMooqzDqQdeZnoEE66eaag==
X-CSE-MsgGUID: CoVTSh/MTHqyaZCTwy5v8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132908758"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Apr 2025 10:25:30 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7dqh-0003Up-2m;
	Wed, 23 Apr 2025 17:25:27 +0000
Date: Thu, 24 Apr 2025 01:25:08 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Message-ID: <202504240112.hZy9LpvD-lkp@intel.com>
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on aff301f37e220970c2f301b5c65a8bfedf52058e]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-introduce-IIO_DECLARE_BUFFER_WITH_TS-macros/20250423-061049
base:   aff301f37e220970c2f301b5c65a8bfedf52058e
patch link:    https://lore.kernel.org/r/20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706%40baylibre.com
patch subject: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
config: sh-randconfig-001-20250424 (https://download.01.org/0day-ci/archive/20250424/202504240112.hZy9LpvD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250424/202504240112.hZy9LpvD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504240112.hZy9LpvD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/industrialio-buffer.c:29:
>> include/linux/iio/iio.h:813:1: error: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
     813 | _Static_assert(sizeof(IIO_DMA_MINALIGN) % sizeof(s64) == 0,
         | ^~~~~~~~~~~~~~


vim +813 include/linux/iio/iio.h

   781	
   782	#define _IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
   783		type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64) / sizeof(type)]
   784	
   785	/**
   786	 * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
   787	 * @type: element type of the buffer
   788	 * @name: identifier name of the buffer
   789	 * @count: number of elements in the buffer
   790	 *
   791	 * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
   792	 * addition to allocating enough space for @count elements of @type, it also
   793	 * allocates space for a s64 timestamp at the end of the buffer and ensures
   794	 * proper alignment of the timestamp.
   795	 */
   796	#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
   797		_IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
   798	
   799	/**
   800	 * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
   801	 * @type: element type of the buffer
   802	 * @name: identifier name of the buffer
   803	 * @count: number of elements in the buffer
   804	 *
   805	 * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
   806	 * to ensure that the buffer doesn't share cachelines with anything that comes
   807	 * before it in a struct. This should not be used for stack-allocated buffers
   808	 * as stack memory cannot generally be used for DMA.
   809	 */
   810	#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
   811		_IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
   812	
 > 813	_Static_assert(sizeof(IIO_DMA_MINALIGN) % sizeof(s64) == 0,
   814		"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
   815	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

