Return-Path: <linux-iio+bounces-13270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09259E89EA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 04:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525D9281ABA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 03:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08445197A67;
	Mon,  9 Dec 2024 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcqkjtMy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DD19343B;
	Mon,  9 Dec 2024 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715670; cv=none; b=RRj/Sj1aAh7/X1uQckWQL7uNWzlvMlPQt/MmiT2IoTvTswOtM55krUFYTauQCiGBNzj4voh1bByDLakrVW0pXAEka+P25JKYnGjH/oNzR5LPg/DtDcNAxCS6stwf6YilJmQR7YBD+zgXJ9k3EzI2fshvLl9WNa51D6IAbPtDfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715670; c=relaxed/simple;
	bh=vjbIdbSim8iWqX+UbKf5ptJxs26aJd7ZE7FpjmOELSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLeQGja5wG5u/t+hedGCX4vOfPIX+5x+XOWbp5lbIC8VWjLRqp68ZhMv2wfB8ECXfBOnoov2A1cr12P8U2dbp4HZ+eEMapQ++XFgdyMRLSdlNauANN6uRPZvt3V/72cQXO+L4Et3ERPWMyZ7XMMmse07RmU/U40gNywYf/VZURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcqkjtMy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733715669; x=1765251669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vjbIdbSim8iWqX+UbKf5ptJxs26aJd7ZE7FpjmOELSc=;
  b=FcqkjtMyaLuCSE9E14XCXGpex8uQWGRXQlleU3O/FFhUsgOnoXirVkoD
   f4vdJ32d7QYl5N9vnX+6/htc27jFIGFCoKiIijjjH19f5znZSFB+AYc8Z
   /qX7gPvIZ0WCqvsgQCZmDbPI2JSbtaz5cXx1kLjLoo6EYvYwG9b2jTsgT
   p+OyGbitQ6/w8gGU35Ot2p6PQNadBySmNq0yNBG8EWb4JXNiigE24d8jw
   BWszaHlfz3fsmtfgwhrrh+KtU9Zkv5jv0vBWwgnb+GLkybNt7Xq7795jx
   U9ZLYzCt5ULwcIlGSuAiZYySeVpCxQMlHVTByUyUwC9fQiELj0izl28h7
   g==;
X-CSE-ConnectionGUID: WZviv3DrSICwGXLloEYYhA==
X-CSE-MsgGUID: sueqzu6CS7ibuQ5w66cnyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33889120"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33889120"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:41:06 -0800
X-CSE-ConnectionGUID: 13PYygnzQiKk9KjRXY1Pjw==
X-CSE-MsgGUID: G6xn3xyeQVKTr5GalSqDtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95295524"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Dec 2024 19:41:02 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKUdn-0003kD-0P;
	Mon, 09 Dec 2024 03:40:59 +0000
Date: Mon, 9 Dec 2024 11:40:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <202412070636.sTYakaSQ-lkp@intel.com>
References: <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>

Hi Mikael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5de07b8a24cf44cdb78adeab790704bf577c2c1d]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikael-Gonella-Bolduc-via-B4-Relay/dt-bindings-iio-light-Add-APDS9160-binding/20241207-001144
base:   5de07b8a24cf44cdb78adeab790704bf577c2c1d
patch link:    https://lore.kernel.org/r/20241206-apds9160-driver-v2-2-be2cb72ef8f4%40dimonoff.com
patch subject: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241207/202412070636.sTYakaSQ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070636.sTYakaSQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070636.sTYakaSQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/light/apds9160.c:12:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/light/apds9160.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/iio/light/apds9160.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/iio/light/apds9160.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/iio/light/apds9160.c:986:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     986 |                 default:
         |                 ^
   drivers/iio/light/apds9160.c:986:3: note: insert 'break;' to avoid fall-through
     986 |                 default:
         |                 ^
         |                 break; 
>> drivers/iio/light/apds9160.c:256:18: warning: unused variable 'apds9160_als_gain_avail' [-Wunused-const-variable]
     256 | static const int apds9160_als_gain_avail[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   18 warnings generated.


vim +986 drivers/iio/light/apds9160.c

   889	
   890	static int apds9160_read_raw(struct iio_dev *indio_dev,
   891				     struct iio_chan_spec const *chan, int *val,
   892				     int *val2, long mask)
   893	{
   894		struct apds9160_chip *data = iio_priv(indio_dev);
   895		int ret = -EINVAL;
   896	
   897		switch (mask) {
   898		case IIO_CHAN_INFO_RAW:
   899			switch (chan->type) {
   900			case IIO_PROXIMITY: {
   901				__le16 buf;
   902	
   903				ret = regmap_bulk_read(data->regmap, chan->address,
   904						       &buf, 2);
   905				if (ret)
   906					return ret;
   907	
   908				ret = IIO_VAL_INT;
   909				*val = le16_to_cpu(buf);
   910				/* Remove overflow bits from result */
   911				*val = FIELD_GET(APDS9160_PS_DATA_MASK, *val);
   912			} break;
   913			case IIO_LIGHT:
   914			case IIO_INTENSITY: {
   915				u8 buf[3];
   916	
   917				ret = regmap_bulk_read(data->regmap, chan->address,
   918						       &buf, 3);
   919				if (ret)
   920					return ret;
   921	
   922				ret = IIO_VAL_INT;
   923				*val = get_unaligned_le24(buf);
   924			} break;
   925			case IIO_CURRENT:
   926				ret = IIO_VAL_INT;
   927				*val = data->ps_current;
   928				break;
   929			default:
   930				break;
   931			}
   932			break;
   933		case IIO_CHAN_INFO_HARDWAREGAIN:
   934			switch (chan->type) {
   935			case IIO_LIGHT:
   936				ret = IIO_VAL_INT;
   937				*val = data->als_hwgain;
   938				break;
   939			case IIO_PROXIMITY:
   940				ret = IIO_VAL_INT;
   941				*val = data->ps_gain;
   942				break;
   943			default:
   944				break;
   945			}
   946			break;
   947		case IIO_CHAN_INFO_INT_TIME:
   948			switch (chan->type) {
   949			case IIO_LIGHT:
   950				ret = IIO_VAL_INT;
   951				*val = data->als_itime;
   952				break;
   953			default:
   954				break;
   955			}
   956			break;
   957		case IIO_CHAN_INFO_SAMP_FREQ:
   958			switch (chan->type) {
   959			case IIO_PROXIMITY:
   960				ret = IIO_VAL_INT;
   961				*val = data->ps_rate;
   962				break;
   963			default:
   964				break;
   965			}
   966			break;
   967		case IIO_CHAN_INFO_CALIBSCALE:
   968			switch (chan->type) {
   969			case IIO_PROXIMITY:
   970				ret = IIO_VAL_INT;
   971				*val = data->ps_cancellation_level;
   972				break;
   973			default:
   974				break;
   975			}
   976			break;
   977		case IIO_CHAN_INFO_CALIBBIAS:
   978			switch (chan->type) {
   979			case IIO_PROXIMITY:
   980				ret = IIO_VAL_INT;
   981				*val = data->ps_cancellation_analog;
   982				break;
   983			case IIO_CURRENT:
   984				ret = IIO_VAL_INT;
   985				*val = data->ps_cancellation_current;
 > 986			default:
   987				break;
   988			}
   989			break;
   990		case IIO_CHAN_INFO_SCALE:
   991			switch (chan->type) {
   992			case IIO_LIGHT:
   993				ret = IIO_VAL_INT_PLUS_MICRO;
   994				*val = data->als_scale1;
   995				*val2 = data->als_scale2;
   996				break;
   997			default:
   998				break;
   999			}
  1000			break;
  1001		default:
  1002			break;
  1003		}
  1004	
  1005		return ret;
  1006	};
  1007	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

