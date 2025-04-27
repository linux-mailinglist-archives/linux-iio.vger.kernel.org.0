Return-Path: <linux-iio+bounces-18722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E34A9DE86
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 03:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161611A82C6D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85E1FDA8C;
	Sun, 27 Apr 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNpwHDBQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE61ACEDF;
	Sun, 27 Apr 2025 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745718964; cv=none; b=BaYsBZHG33yeZD6vAr7HVebgruo4b7e9Gxh8MdLusF+t42pcI/SB8z32L3CNYyQNNJwTG/sA5azVF0MKuVnTOi4cxHfdVgWrmmPygcq+FdAFW0IDTdT+RRXU001H/c/EezAknZoAo+xEPFNv0gcI6c1idBVM/efD0RCyNYNIH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745718964; c=relaxed/simple;
	bh=m6wMOhB/QmSA6Bw/+B6zy/hHoBsN2Sv1XTfyaFFtEfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpF4Xp7ikYqhfbCztM8VAv/7H42lwiUHESmpR3zMJxUq0DzfkZuaGATVJf8y37ZzfNLrFqKqaGrnIjl3qQzrCnyhkFEnIatQOISVhyzBziDheoe7OmJpsgbZ64KromRLsFsjRiIsMuEkQ9a4kVBRwnLA5EDKdJk8ICoDWhYThfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNpwHDBQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745718962; x=1777254962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m6wMOhB/QmSA6Bw/+B6zy/hHoBsN2Sv1XTfyaFFtEfA=;
  b=mNpwHDBQDbpktmdVbzYf0/kjzVu3k2bexD5qmRM5MBOuYhV0x27SeqNZ
   8Q8kZpShFInhYlHKqHAlUGL+lO9ylYVZmJBRY0fjWgvyJf2r/zVSy8dZ3
   SPz6nlGYYIKb7pm/BW65TGuyQQb8xsIfXE9v/XoXc73CZ5aydi7oRAtbI
   jcBZjS9TE8/HjC2/FKpnpvWKI41fC3qqRKe1kXFT5F/6T/B4nc0a2cUVU
   4zy/iqrF4VAkLlT7E2EL/yn6T1rRwsCRWdUL7TzQTubwAE75rpUdgXcxs
   2ucLL+54UoLMC+XaO0B6BwQQc1qgzhPMt6FAo9v1kVpWn3GMngSPkK1cG
   A==;
X-CSE-ConnectionGUID: EpEM4FpkTtempfJqFOTRaw==
X-CSE-MsgGUID: NE+NA20yT/2ctqkWOSV5FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="58704533"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="58704533"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 18:56:01 -0700
X-CSE-ConnectionGUID: vvRSLw4UQXqozfsE2gGZvQ==
X-CSE-MsgGUID: IqCyKMdLRpqRQLXF41FxXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="133736627"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Apr 2025 18:55:57 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8rFK-00063Z-2U;
	Sun, 27 Apr 2025 01:55:54 +0000
Date: Sun, 27 Apr 2025 09:54:58 +0800
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
Subject: Re: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Message-ID: <202504270919.3FGvikEj-lkp@intel.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aff301f37e220970c2f301b5c65a8bfedf52058e]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-introduce-IIO_DECLARE_BUFFER_WITH_TS-macros/20250426-051240
base:   aff301f37e220970c2f301b5c65a8bfedf52058e
patch link:    https://lore.kernel.org/r/20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248%40baylibre.com
patch subject: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
config: i386-randconfig-r133-20250427 (https://download.01.org/0day-ci/archive/20250427/202504270919.3FGvikEj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250427/202504270919.3FGvikEj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504270919.3FGvikEj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/iio/accel/adxl313_core.c: note: in included file (through drivers/iio/accel/adxl313.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl345_core.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl355_core.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl313_spi.c: note: in included file (through drivers/iio/accel/adxl313.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adis16201.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adis16209.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/dmard09.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/da311.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl313_i2c.c: note: in included file (through drivers/iio/accel/adxl313.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl367_spi.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/da280.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/kxsd9.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/bma220_spi.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/kionix-kx022a.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl372.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/kxcjk-1013.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/fxls8962af-core.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl380.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/adxl367.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/mma7455_core.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/mc3230.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/ssp_accel_sensor.c: note: in included file (through include/linux/iio/common/ssp_sensors.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/mma7660.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/sca3300.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/mma9551.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/mma9551_core.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/mxc4005.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/stk8312.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/stk8ba50.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/sca3000.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/msa311.c: note: in included file (through include/linux/iio/buffer.h):
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
--
   drivers/iio/accel/mma9553.c: note: in included file:
>> include/linux/iio/iio.h:815:1: sparse: sparse: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"

vim +815 include/linux/iio/iio.h

   782	
   783	#define __IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
   784		static_assert(count); \
   785		type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64) / sizeof(type)]
   786	
   787	/**
   788	 * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
   789	 * @type: element type of the buffer
   790	 * @name: identifier name of the buffer
   791	 * @count: number of elements in the buffer
   792	 *
   793	 * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
   794	 * addition to allocating enough space for @count elements of @type, it also
   795	 * allocates space for a s64 timestamp at the end of the buffer and ensures
   796	 * proper alignment of the timestamp.
   797	 */
   798	#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
   799		__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
   800	
   801	/**
   802	 * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
   803	 * @type: element type of the buffer
   804	 * @name: identifier name of the buffer
   805	 * @count: number of elements in the buffer
   806	 *
   807	 * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
   808	 * to ensure that the buffer doesn't share cachelines with anything that comes
   809	 * before it in a struct. This should not be used for stack-allocated buffers
   810	 * as stack memory cannot generally be used for DMA.
   811	 */
   812	#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
   813		__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
   814	
 > 815	static_assert(IIO_DMA_MINALIGN % sizeof(s64) == 0,
   816		"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
   817	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

