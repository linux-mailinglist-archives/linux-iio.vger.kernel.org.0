Return-Path: <linux-iio+bounces-10693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957C59A2FDC
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC91EB24F6A
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03A1D6191;
	Thu, 17 Oct 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W12ayIYR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7A1D5CE7;
	Thu, 17 Oct 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200898; cv=none; b=phUuZ5ucMlE7Pxmvv4fMbNouTdByLD01mgmWGN6v0EfGnfyEdHT5GtPWOgb8tAoKRs6ifAk9eUHo0Rb2yUHTO4R2+k29EOu3X0jAv8sbV1wrHw96iKU23xeDHFhcjoijuXAfwuhDRDKAviFjPukoHU4gctyTuNnMHqQ3J8pHw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200898; c=relaxed/simple;
	bh=xGsL5XIxEekvC5G0mKLGSSS+iQcB9KWvXvXMx2Sz9vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdZ/zgHE3kPAGEIr4cmhUHYL3XrUGmRx6HYgZXGk9BHfQXBnOslI8komqzbwOwBofOCHZMo3euMv5zNsSUep+64boCaXFQK0+djdwDOBKo35zTXvFir9/aUIKZ49BXZ4w54FEQBXH2d/UtcbXmDnb583/zNZkZpqP5JIW317Qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W12ayIYR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729200895; x=1760736895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xGsL5XIxEekvC5G0mKLGSSS+iQcB9KWvXvXMx2Sz9vc=;
  b=W12ayIYR4OCcgcU0PzfpdMABSBNXh5vHKesq75g+2GiyxqN2jHHIN5ZR
   OterShU/HyAdJs4HD/kQzfx1N+uS7EKy/GkJSqVVKgj4uX0os9k6WGxZI
   IVP+c/NOcqCaXIJD7kIxi/pVLXc9bdTABkvqj9uoEJQbKH3JHpZm4jOls
   whEs6aod+3INKIUdCd3/XzGpn/rSJzyrRQa2KmiACql2D6F5RFL9yYteP
   Rr4WcUG/H6sObFv0muoo2CTSvSVJAcDOU7OenAf9XtRV5Wy5Us7e8Rr3k
   HWFcCFUJkWmcWt9HVUewKwEfRIfTCHodE4lAvSCuPjy0suX90udhn84r4
   g==;
X-CSE-ConnectionGUID: D2QGCCs4Tb+W0x8feUlPuA==
X-CSE-MsgGUID: Xi0UVl5GShyEnJxzeU/yag==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28153947"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="28153947"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:34:55 -0700
X-CSE-ConnectionGUID: gTSFiqAUSEG5Z/jbnNq7FQ==
X-CSE-MsgGUID: VDgd6iYYQaKGQ00RkGM8Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83313101"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2024 14:34:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Y8u-000MyB-2w;
	Thu, 17 Oct 2024 21:34:48 +0000
Date: Fri, 18 Oct 2024 05:34:35 +0800
From: kernel test robot <lkp@intel.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	rickard.andersson@axis.com, kernel@axis.com,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202410180508.XPNXNSLX-lkp@intel.com>
References: <20241015143713.2017626-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015143713.2017626-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on eca631b8fe808748d7585059c4307005ca5c5820]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241015-224128
base:   eca631b8fe808748d7585059c4307005ca5c5820
patch link:    https://lore.kernel.org/r/20241015143713.2017626-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color sensor
config: um-randconfig-r113-20241017 (https://download.01.org/0day-ci/archive/20241018/202410180508.XPNXNSLX-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410180508.XPNXNSLX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410180508.XPNXNSLX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/light/opt4060.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/iio/light/opt4060.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/iio/light/opt4060.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/iio/light/opt4060.c:835:10: error: label at end of compound statement: expected statement
           default:
                   ^
                    ;
   12 warnings and 1 error generated.


vim +835 drivers/iio/light/opt4060.c

   807	
   808	static int opt4060_write_event(struct iio_dev *indio_dev,
   809				       const struct iio_chan_spec *chan,
   810				       enum iio_event_type type,
   811				       enum iio_event_direction dir,
   812				       enum iio_event_info info,
   813				       int val, int val2)
   814	{
   815		struct opt4060_chip *chip = iio_priv(indio_dev);
   816	
   817		switch (info) {
   818		case IIO_EV_INFO_VALUE:
   819			if (chan->type == IIO_INTENSITY && type == IIO_EV_TYPE_THRESH) {
   820				u32 th_lo, th_hi;
   821	
   822				if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
   823					return -EFAULT;
   824				if (dir == IIO_EV_DIR_FALLING)
   825					th_lo = val;
   826				else if (dir == IIO_EV_DIR_RISING)
   827					th_hi = val;
   828				if (opt4060_set_thresholds(chip, th_lo, th_hi))
   829					return -EFAULT;
   830				return 0;
   831			}
   832			break;
   833		case IIO_EV_INFO_PERIOD:
   834			return opt4060_write_ev_period(chip, val, val2);
 > 835		default:
   836		}
   837		return -EINVAL;
   838	}
   839	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

