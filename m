Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B38258ACC
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 10:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAIwU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 04:52:20 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbgIAIwT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 04:52:19 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9B8A6B5857652B869046;
        Tue,  1 Sep 2020 09:52:17 +0100 (IST)
Received: from localhost (10.52.122.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Sep 2020
 09:52:17 +0100
Date:   Tue, 1 Sep 2020 09:50:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
CC:     Julia Lawall <julia.lawall@inria.fr>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [iio:fixes-togreg 19/19] drivers/iio/adc/mcp3422.c:147:3-9:
 preceding lock on line 137 (fwd)
Message-ID: <20200901095041.0000279e@Huawei.com>
In-Reply-To: <CA+TH9VmQq3=Kf=f72CSn2ZziKP3YP6qjsXQL1nXzS-O8FscBWw@mail.gmail.com>
References: <alpine.DEB.2.22.394.2008292228320.3629@hadrien>
        <CA+TH9VkAo4CgCVDGvQumfePvNCg9ffwEHbqic7TsYJn4VZ3aTw@mail.gmail.com>
        <alpine.DEB.2.22.394.2008310947020.2533@hadrien>
        <CA+TH9VmQq3=Kf=f72CSn2ZziKP3YP6qjsXQL1nXzS-O8FscBWw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 11:09:53 +0200
Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:

> Il giorno lun 31 ago 2020 alle ore 09:48 Julia Lawall
> <julia.lawall@inria.fr> ha scritto:
> >
> >
> >
> > On Mon, 31 Aug 2020, Angelo Compagnucci wrote:
> >  
> > > Hi Julia,
> > >
> > > Il giorno sab 29 ago 2020 alle ore 22:29 Julia Lawall
> > > <julia.lawall@inria.fr> ha scritto:  
> > > >
> > > > Please check whether there should be a mutex_unlock before line 147.  
> > >
> > > Having  a mutex_unlock before line 147 is wrong here, cause the lock
> > > should be held for the entire reading operation. Adding an unlock
> > > before the lock means that a concurrent call can unlock the lock
> > > previously held by another call and the result ends up mixing the
> > > reading for the first call to the reading of the second call.  
> >
> > OK, I don't know the calling context.  But you have a function where the
> > lock is held on the failure path and is released on the success path,
> > which seems at least a little strange.  
> 
> I see.
> 
> I have to respin!
> 
> Thanks for your support!
Hi Julia, Angelo,

Please can we cc linux-iio@vger.kernel.org for such reports.
The fix has headed upstream. So we need to chase it with a fix asap.

Greg, would you prefer a following fix (please cc Greg directly) or
to revert the patch? 

3f1093d83d71 ("iio: adc: mcp3422: fix locking scope")

Sorry I missed this one. Was working on wrong computer to access
the account this went to.

Jonathan

> 
> >  But if the calling context deals
> > with that in a reasonable way, then ok.  Maybe a comment would be useful.
> >
> > julia
> >  
> > >
> > > Sincerely, Angelo
> > >  
> > > >
> > > > julia
> > > >
> > > >
> > > > ---------- Forwarded message ----------
> > > > Date: Sun, 30 Aug 2020 04:08:59 +0800
> > > > From: kernel test robot <lkp@intel.com>
> > > > To: kbuild@lists.01.org
> > > > Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
> > > > Subject: [iio:fixes-togreg 19/19] drivers/iio/adc/mcp3422.c:147:3-9: preceding
> > > >     lock on line 137
> > > >
> > > > CC: kbuild-all@lists.01.org
> > > > TO: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > > > CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg
> > > > head:   ba255800f7fbb8da411c92c33b25d52970558509
> > > > commit: ba255800f7fbb8da411c92c33b25d52970558509 [19/19] iio: adc: mcp3422: fix locking scope
> > > > :::::: branch date: 3 hours ago
> > > > :::::: commit date: 3 hours ago
> > > > config: i386-randconfig-c001-20200830 (attached as .config)
> > > > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > > >
> > > >
> > > > coccinelle warnings: (new ones prefixed by >>)
> > > >  
> > > > >> drivers/iio/adc/mcp3422.c:147:3-9: preceding lock on line 137  
> > > >
> > > > # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=ba255800f7fbb8da411c92c33b25d52970558509
> > > > git remote add iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> > > > git fetch --no-tags iio fixes-togreg
> > > > git checkout ba255800f7fbb8da411c92c33b25d52970558509
> > > > vim +147 drivers/iio/adc/mcp3422.c
> > > >
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  129
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  130  static int mcp3422_read_channel(struct mcp3422 *adc,
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  131                              struct iio_chan_spec const *channel, int *value)
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  132  {
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  133      int ret;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  134      u8 config;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  135      u8 req_channel = channel->channel;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  136
> > > > ba255800f7fbb8d Angelo Compagnucci 2020-08-19 @137      mutex_lock(&adc->lock);
> > > > ba255800f7fbb8d Angelo Compagnucci 2020-08-19  138
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  139      if (req_channel != MCP3422_CHANNEL(adc->config)) {
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  140              config = adc->config;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  141              config &= ~MCP3422_CHANNEL_MASK;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  142              config |= MCP3422_CHANNEL_VALUE(req_channel);
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  143              config &= ~MCP3422_PGA_MASK;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  144              config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  145              ret = mcp3422_update_config(adc, config);
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  146              if (ret < 0)
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02 @147                      return ret;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  148              msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  149      }
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  150
> > > > ba255800f7fbb8d Angelo Compagnucci 2020-08-19  151      ret = mcp3422_read(adc, value, &config);
> > > > ba255800f7fbb8d Angelo Compagnucci 2020-08-19  152
> > > > ba255800f7fbb8d Angelo Compagnucci 2020-08-19  153      mutex_unlock(&adc->lock);
> > > > ba255800f7fbb8d Angelo Compagnucci 2020-08-19  154
> > > > ba255800f7fbb8d Angelo Compagnucci 2020-08-19  155      return ret;
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  156  }
> > > > 07914c84ba30e31 Angelo Compagnucci 2013-09-02  157
> > > >
> > > > :::::: The code at line 147 was first introduced by commit
> > > > :::::: 07914c84ba30e311f6bfb65b811b33a1dc094311 iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC
> > > >
> > > > :::::: TO: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > > > :::::: CC: Jonathan Cameron <jic23@kernel.org>
> > > >
> > > > ---
> > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org  
> > >
> > >
> > >
> > > --
> > > Profile: http://it.linkedin.com/in/compagnucciangelo
> > >  
> 
> 
> 


