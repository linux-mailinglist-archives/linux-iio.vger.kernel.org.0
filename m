Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6384270DDA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgISMRH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 08:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgISMRH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 08:17:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5CA20878;
        Sat, 19 Sep 2020 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600517826;
        bh=qQED3ZsvFj3ueUzjOOHhk72bFOy/HYXmOyirQHvq8Rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QiGqcKAV6fSc4QEF9VPHJD33c5Llbi8r78oHJwyCZcGSWCEAaly3fGr4zFUS1ChDM
         acwSKT2GD+sk/Kp7/X5/htLcPIW0UgR+6fDoQGpG8lNgwh/+S312YHw8b4COpLXK1a
         RBJ8lK6YnPvWNTz1OF+rnuiFsQ3WtOlV3RgQs8YM=
Date:   Sat, 19 Sep 2020 13:17:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH v5] iio: adc: ad7768-1: Add channel label example
Message-ID: <20200919131701.619bded2@archlinux>
In-Reply-To: <202009182056.LiUdHLln%lkp@intel.com>
References: <20200918093356.93670-1-cristian.pop@analog.com>
        <202009182056.LiUdHLln%lkp@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 20:55:10 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Cristian,
> 
> Thank you for the patch! Yet something to improve:
For anyone tracking this.  The error is down to Cristian working around
an email issue by sending the series as individual patches.
Not ideal and confuses autobuilding but something odd was going on
and this got it out.

Thanks,

Jonathan

> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on linux/master linus/master v5.9-rc5 next-20200918]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Cristian-Pop/iio-adc-ad7768-1-Add-channel-label-example/20200918-190340
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/adc/ad7768-1.c:432:3: error: 'const struct iio_info' has no member named 'read_label'; did you mean 'read_raw'?  
>      432 |  .read_label = ad7768_read_label,
>          |   ^~~~~~~~~~
>          |   read_raw
> >> drivers/iio/adc/ad7768-1.c:432:16: error: initialization of 'int (*)(struct iio_dev *, const struct iio_chan_spec *, long int)' from incompatible pointer type 'int (*)(struct iio_dev *, const struct iio_chan_spec *, char *)' [-Werror=incompatible-pointer-types]  
>      432 |  .read_label = ad7768_read_label,
>          |                ^~~~~~~~~~~~~~~~~
>    drivers/iio/adc/ad7768-1.c:432:16: note: (near initialization for 'ad7768_info.write_raw_get_fmt')
>    cc1: some warnings being treated as errors
> 
> # https://github.com/0day-ci/linux/commit/6144f5a8d7fa8961b6d39e36092c14301ad823c1
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review Cristian-Pop/iio-adc-ad7768-1-Add-channel-label-example/20200918-190340
> git checkout 6144f5a8d7fa8961b6d39e36092c14301ad823c1
> vim +432 drivers/iio/adc/ad7768-1.c
> 
>    427	
>    428	static const struct iio_info ad7768_info = {
>    429		.attrs = &ad7768_group,
>    430		.read_raw = &ad7768_read_raw,
>    431		.write_raw = &ad7768_write_raw,
>  > 432		.read_label = ad7768_read_label,  
>    433		.debugfs_reg_access = &ad7768_reg_access,
>    434	};
>    435	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

