Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAEE4600AB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 18:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhK0Ruw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 12:50:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40452 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbhK0Rsw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 12:48:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 462E460EFC;
        Sat, 27 Nov 2021 17:45:37 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A8EB0C53FAD;
        Sat, 27 Nov 2021 17:45:31 +0000 (UTC)
Date:   Sat, 27 Nov 2021 17:50:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        kbuild-all@lists.01.org
Subject: Re: [PATCH v11 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <20211127175031.6471b43b@jic23-huawei>
In-Reply-To: <202111271041.Cdu0In2E-lkp@intel.com>
References: <20211124225407.17793-4-anand.ashok.dumbre@xilinx.com>
        <202111271041.Cdu0In2E-lkp@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Nov 2021 10:43:11 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Anand,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linux/master linus/master v5.16-rc2 next-20211126]
> [cannot apply to xilinx-xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Anand-Ashok-Dumbre/Add-Xilinx-AMS-Driver/20211125-065614
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: powerpc64-randconfig-s032-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271041.Cdu0In2E-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/0day-ci/linux/commit/9b07fe52c07c2e9f6eccd2f2050f69558904ed64
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Anand-Ashok-Dumbre/Add-Xilinx-AMS-Driver/20211125-065614
>         git checkout 9b07fe52c07c2e9f6eccd2f2050f69558904ed64
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/clk/ drivers/iio/adc/ drivers/pci/controller/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iio/adc/xilinx-ams.c:1175:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *data @@  
>    drivers/iio/adc/xilinx-ams.c:1175:17: sparse:     expected void volatile [noderef] __iomem *addr
>    drivers/iio/adc/xilinx-ams.c:1175:17: sparse:     got void *data
> >> drivers/iio/adc/xilinx-ams.c:1192:69: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *ps_base @@  
>    drivers/iio/adc/xilinx-ams.c:1192:69: sparse:     expected void *data
>    drivers/iio/adc/xilinx-ams.c:1192:69: sparse:     got void [noderef] __iomem *ps_base
> >> drivers/iio/adc/xilinx-ams.c:1206:69: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *pl_base @@  
>    drivers/iio/adc/xilinx-ams.c:1206:69: sparse:     expected void *data
>    drivers/iio/adc/xilinx-ams.c:1206:69: sparse:     got void [noderef] __iomem *pl_base
> 
> vim +1175 drivers/iio/adc/xilinx-ams.c
> 
>   1172	
>   1173	static void ams_iounmap(void *data)
>   1174	{
> > 1175		iounmap(data);  
I guess you probably already fixed this, but I'd do it by passing the
containing structure in as the *data and then use
ams->pl_base to access it here.

It's a bit more code than we'd normally need but cleaner than force
changes to and from iomem via forcing the pointer conversions.

>   1176	}
>   1177	
>   1178	static int ams_init_module(struct iio_dev *indio_dev,
>   1179				   struct fwnode_handle *fwnode,
>   1180				   struct iio_chan_spec *channels)
>   1181	{
>   1182		struct device *dev = indio_dev->dev.parent;
>   1183		struct ams *ams = iio_priv(indio_dev);
>   1184		int num_channels = 0;
>   1185		int ret;
>   1186	
>   1187		if (fwnode_property_match_string(fwnode, "compatible",
>   1188						 "xlnx,zynqmp-ams-ps") == 0) {
>   1189			ams->ps_base = fwnode_iomap(fwnode, 0);
>   1190			if (!ams->ps_base)
>   1191				return -ENXIO;
> > 1192			ret = devm_add_action_or_reset(dev, ams_iounmap, ams->ps_base);  
>   1193			if (ret < 0)
>   1194				return ret;
>   1195	
>   1196			/* add PS channels to iio device channels */
>   1197			memcpy(channels, ams_ps_channels,
>   1198			       sizeof(ams_ps_channels));
>   1199			num_channels += ARRAY_SIZE(ams_ps_channels);
>   1200		} else if (fwnode_property_match_string(fwnode, "compatible",
>   1201							"xlnx,zynqmp-ams-pl") == 0) {
>   1202			ams->pl_base = fwnode_iomap(fwnode, 0);
>   1203			if (!ams->pl_base)
>   1204				return -ENXIO;
>   1205	
> > 1206			ret = devm_add_action_or_reset(dev, ams_iounmap, ams->pl_base);  
>   1207			if (ret < 0)
>   1208				return ret;
>   1209	
>   1210			/* Copy only first 10 fix channels */
>   1211			memcpy(channels, ams_pl_channels,
>   1212			       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
>   1213			num_channels += AMS_PL_MAX_FIXED_CHANNEL;
>   1214	
>   1215			num_channels = ams_get_ext_chan(fwnode, channels,
>   1216							num_channels);
>   1217		} else if (fwnode_property_match_string(fwnode, "compatible",
>   1218							"xlnx,zynqmp-ams") == 0) {
>   1219			/* add AMS channels to iio device channels */
>   1220			memcpy(channels, ams_ctrl_channels,
>   1221			       sizeof(ams_ctrl_channels));
>   1222			num_channels += ARRAY_SIZE(ams_ctrl_channels);
>   1223		} else {
>   1224			return -EINVAL;
>   1225		}
>   1226	
>   1227		return num_channels;
>   1228	}
>   1229	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

