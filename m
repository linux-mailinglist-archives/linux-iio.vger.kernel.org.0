Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D21AF64D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 04:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSCty (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 22:49:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:20201 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDSCty (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 22:49:54 -0400
IronPort-SDR: VZ6O97qvhYJOkULNrzhL/dIfDOdkmOmaBRFld1WbDH29GJyc6o7ljyyJ1DwF+kdRKcPTJZW8Kf
 GhQAc2l/9Fbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2020 19:49:53 -0700
IronPort-SDR: ieWttVn/aTgl915MUJ3l1Ij0cePAR7msaTQU2DnDG7LXv7fV9bQr7cGjCCLJIRqtvSC4J55nt4
 FbCwxRkCi+JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,401,1580803200"; 
   d="scan'208";a="455140969"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 18 Apr 2020 19:49:50 -0700
Date:   Sun, 19 Apr 2020 10:49:48 +0800
From:   Philip Li <philip.li@intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Jonathan Cameron <jic23@kernel.org>, kbuild-all@lists.01.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ti-ads8344: properly byte swap value
Message-ID: <20200419024948.GK21730@intel.com>
References: <20200415212257.161238-2-alexandre.belloni@bootlin.com>
 <202004161449.NY5hL54S%lkp@intel.com>
 <20200416205023.GA437042@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416205023.GA437042@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 16, 2020 at 10:50:23PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 16/04/2020 14:22:03+0800, kbuild test robot wrote:
> > Hi Alexandre,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on iio/togreg]
> > [also build test ERROR on v5.7-rc1 next-20200415]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/iio-adc-ti-ads8344-improve-the-driver/20200416-073357
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > config: c6x-allyesconfig (attached as .config)
> > compiler: c6x-elf-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=c6x 
> > 
> 
> I spent some time to reproduce and this is actually not that trivial
> because your toolchains are linked with libisl22 and most distributions
> still ship an older version. Maybe you can do something about that?
Thanks for the feedback, we will resolve this to use old version in
earliest time.

> 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > 
> > vim +/302 +96 drivers/iio/adc/ti-ads8344.c
> > 
> >     72	
> >     73	static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
> >     74					  bool differential)
> >     75	{
> >     76		struct spi_device *spi = adc->spi;
> >     77		int ret;
> >     78		u8 buf[3];
> >     79	
> >     80		adc->tx_buf = ADS8344_START;
> >     81		if (!differential)
> >     82			adc->tx_buf |= ADS8344_SINGLE_END;
> >     83		adc->tx_buf |= ADS8344_CHANNEL(channel);
> >     84		adc->tx_buf |= ADS8344_CLOCK_INTERNAL;
> >     85	
> >     86		ret = spi_write(spi, &adc->tx_buf, 1);
> >     87		if (ret)
> >     88			return ret;
> >     89	
> >     90		udelay(9);
> >     91	
> >     92		ret = spi_read(spi, buf, sizeof(buf));
> >     93		if (ret)
> >     94			return ret;
> >     95	
> >   > 96		return buf[0] << 9 | buf[1] << 1 | buf[2] >> 7;
> >     97	}
> >     98	
> > 
> 
> I take it this is a false positive as I don't get any errors when
> building this driver with the provided toolchain. However, I see a few
> "internal compiler error: in priority, at haifa-sched.c:1599"
> 
> -- 
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
