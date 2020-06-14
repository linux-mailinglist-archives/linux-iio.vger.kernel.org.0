Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF81F8911
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgFNNwv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgFNNwu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:52:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45442206D7;
        Sun, 14 Jun 2020 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592142770;
        bh=ehbTMf8/rK3611e+NpluRQm97ZZRIaDtMlf8Jadcz6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xPM/0R14PI7rdAA6awWuCpEgJQ4w/EF28RhcC4yAFvNE1+1Vmy/pQIuAo+jaaNOIx
         j24uNPNXNTed4sq7Sifc8gxc37U7J52F1o3WhChjTxEca9fzcATXYDesa0sKRgyiXh
         w7NwZ0ial1mJF0SHJvRY0bIT2vxltkNOCRmQGIXg=
Date:   Sun, 14 Jun 2020 14:52:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        robh+dt@kernel.org, robh@kernel.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] iio: imu: add Kconfig and Makefile for
 inv_icm42600 driver
Message-ID: <20200614145245.3f459a72@archlinux>
In-Reply-To: <202006090630.5zuVlCdS%lkp@intel.com>
References: <20200608204250.3291-8-jmaneyrol@invensense.com>
        <202006090630.5zuVlCdS%lkp@intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


For anyone curious, this is an artefact of me failing to push the iio tree
out last weekend which included a patch to make iio_device_get_drvdata
take a const.

Sorry for the noise

Jonathan

On Tue, 9 Jun 2020 07:03:53 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Jean-Baptiste,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on iio/togreg]
> [also build test WARNING on robh/for-next linus/master v5.7 next-20200608]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Jean-Baptiste-Maneyrol/iio-imu-new-inv_icm42600-driver/20200609-044917
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: In function 'inv_icm42600_get_mount_matrix':
> >> drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:91:63: warning: passing argument 1 of 'iio_device_get_drvdata' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]  
> 91 |  const struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> |                                                               ^~~~~~~~~
> In file included from drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:15:
> include/linux/iio/iio.h:672:60: note: expected 'struct iio_dev *' but argument is of type 'const struct iio_dev *'
> 672 | static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
> |                                            ~~~~~~~~~~~~~~~~^~~~~~~~~
> 
> vim +91 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> 
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  86  
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  87  const struct iio_mount_matrix *
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  88  inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  89  			      const struct iio_chan_spec *chan)
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  90  {
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08 @91  	const struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  92  
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  93  	return &st->orientation;
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  94  }
> 632e967c33fb32 Jean-Baptiste Maneyrol 2020-06-08  95  
> 
> :::::: The code at line 91 was first introduced by commit
> :::::: 632e967c33fb32bb0a2a2f85a2a8d2e6d2b125f3 iio: imu: inv_icm42600: add core of new inv_icm42600 driver
> 
> :::::: TO: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> :::::: CC: 0day robot <lkp@intel.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

