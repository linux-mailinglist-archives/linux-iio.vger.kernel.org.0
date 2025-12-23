Return-Path: <linux-iio+bounces-27331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B6CD896B
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 10:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2D6D3017397
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B243283C9E;
	Tue, 23 Dec 2025 09:31:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D61DF261
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482309; cv=none; b=F5Jjcb7cIjrUIchHLT/mqhfolP+UHm9ex05i86Q95xFgLRYPwQr/kaPdsTUKgG0bui6yA5fNNBa+DYQhmypoY3dwyhfU1bpwlaDNqS4piUnRhG+hjvcF5JYZHzSdAvyBhEK6JTjt4ZevS5w2fB9/OHLWERxQIxkqiSWdE+xw28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482309; c=relaxed/simple;
	bh=/IL1Bx+B+6xzXrEGlyDvla+vW6SiSqe4XfcB68GOcno=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyR6geuUZX0tqb4PirMDAms+bZepl/E0raXvR5B0+O6H5Tjs4scIvELBp3dSlfljtGuZ/9ja3/kdihL4EFu3bOatklqNvt9rw1o/jNxKNbFvVTML6jnbJH/WV6bLVFYqLq0m67Fei+6iKiQqEimnhwzKNGFINoTF4x7G1SGzWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4db8rp02dpzJ46bZ;
	Tue, 23 Dec 2025 17:31:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E2FC64056E;
	Tue, 23 Dec 2025 17:31:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 09:31:44 +0000
Date: Tue, 23 Dec 2025 09:31:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: kernel test robot <lkp@intel.com>
CC: Frank Li <Frank.Li@nxp.com>, <oe-kbuild-all@lists.linux.dev>, "Carlos
 Song" <carlos.song@nxp.com>, Adrian Fluturel <fluturel.adrian@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [jic23-iio:testing 47/49] drivers/base/regmap/regmap-i3c.c:41:
 undefined reference to `i3c_device_do_xfers'
Message-ID: <20251223093142.00007880@huawei.com>
In-Reply-To: <20251223093037.00003f7a@huawei.com>
References: <202512230418.nu3V6Yua-lkp@intel.com>
	<20251223093037.00003f7a@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 23 Dec 2025 09:30:37 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Tue, 23 Dec 2025 04:17:12 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > head:   4e44c635ba8c281f74001d47e20bbcb7f516530c
> > commit: 6e5f6bf2e3f036e6d7466d2a3322445729ea3356 [47/49] iio: magnetometer: Add mmc5633 sensor
> > config: sparc64-randconfig-001-20251223 (https://download.01.org/0day-ci/archive/20251223/202512230418.nu3V6Yua-lkp@intel.com/config)
> > compiler: sparc64-linux-gcc (GCC) 8.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230418.nu3V6Yua-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202512230418.nu3V6Yua-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    sparc64-linux-ld: drivers/base/regmap/regmap-i3c.o: in function `regmap_i3c_read':  
> > >> drivers/base/regmap/regmap-i3c.c:41: undefined reference to `i3c_device_do_xfers'    
> >    sparc64-linux-ld: drivers/base/regmap/regmap-i3c.o: in function `regmap_i3c_write':
> >    drivers/base/regmap/regmap-i3c.c:22: undefined reference to `i3c_device_do_xfers'
> >    sparc64-linux-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_is_support_hdr':  
> > >> drivers/iio/magnetometer/mmc5633.c:193: undefined reference to `i3c_device_get_supported_xfer_mode'    
> >    sparc64-linux-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_read_measurement':  
> > >> drivers/iio/magnetometer/mmc5633.c:230: undefined reference to `i3c_device_do_xfers'
> > >> sparc64-linux-ld: drivers/iio/magnetometer/mmc5633.c:237: undefined reference to `i3c_device_do_xfers'    
> >    sparc64-linux-ld: drivers/iio/magnetometer/mmc5633.c:251: undefined reference to `i3c_device_do_xfers'  
> > >> sparc64-linux-ld: drivers/iio/magnetometer/mmc5633.c:230: undefined reference to `i3c_device_do_xfers'    
> 
> Seems like we need a stub.

+CC the lists to broaden awareness.

> 
> Jonathan
> 
> 
> > 
> > Kconfig warnings: (for reference only)
> >    WARNING: unmet direct dependencies detected for CAN_DEV
> >    Depends on [n]: NETDEVICES [=n] && CAN [=y]
> >    Selected by [y]:
> >    - CAN [=y] && NET [=y]
> >    WARNING: unmet direct dependencies detected for REGMAP_I3C
> >    Depends on [n]: I3C [=n]
> >    Selected by [y]:
> >    - MMC5633 [=y] && IIO [=y] && (I2C [=y] || I3C [=n])
> > 
> > 
> > vim +41 drivers/base/regmap/regmap-i3c.c
> > 
> > 6445500b43129b Vitor Soares   2019-06-06  24  
> > 6445500b43129b Vitor Soares   2019-06-06  25  static int regmap_i3c_read(void *context,
> > 6445500b43129b Vitor Soares   2019-06-06  26  			   const void *reg, size_t reg_size,
> > 6445500b43129b Vitor Soares   2019-06-06  27  			   void *val, size_t val_size)
> > 6445500b43129b Vitor Soares   2019-06-06  28  {
> > 6445500b43129b Vitor Soares   2019-06-06  29  	struct device *dev = context;
> > 6445500b43129b Vitor Soares   2019-06-06  30  	struct i3c_device *i3c = dev_to_i3cdev(dev);
> > 79c3ae7ada0548 Frank Li       2025-10-28  31  	struct i3c_xfer xfers[2];
> > 6445500b43129b Vitor Soares   2019-06-06  32  
> > 6445500b43129b Vitor Soares   2019-06-06  33  	xfers[0].rnw = false;
> > 6445500b43129b Vitor Soares   2019-06-06  34  	xfers[0].len = reg_size;
> > 6445500b43129b Vitor Soares   2019-06-06  35  	xfers[0].data.out = reg;
> > 6445500b43129b Vitor Soares   2019-06-06  36  
> > 6445500b43129b Vitor Soares   2019-06-06  37  	xfers[1].rnw = true;
> > 6445500b43129b Vitor Soares   2019-06-06  38  	xfers[1].len = val_size;
> > 6445500b43129b Vitor Soares   2019-06-06  39  	xfers[1].data.in = val;
> > 6445500b43129b Vitor Soares   2019-06-06  40  
> > c2f2b01b74be8b Linus Torvalds 2025-12-08 @41  	return i3c_device_do_xfers(i3c, xfers, ARRAY_SIZE(xfers), I3C_SDR);
> > 6445500b43129b Vitor Soares   2019-06-06  42  }
> > 6445500b43129b Vitor Soares   2019-06-06  43  
> > 
> > :::::: The code at line 41 was first introduced by commit
> > :::::: c2f2b01b74be8b40a2173372bcd770723f87e7b2 Merge tag 'i3c/for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
> > 
> > :::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
> > :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> >   
> 


