Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC49334680
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 19:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCJSTK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 13:19:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2682 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhCJSSr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 13:18:47 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DwgFn0Kppz67p8G;
        Thu, 11 Mar 2021 02:14:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 19:18:45 +0100
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 18:18:44 +0000
Date:   Wed, 10 Mar 2021 18:18:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <dragos.bogdan@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: Contribution to linux-iio for GSOC 2021
Message-ID: <20210310181843.00001b8f@huawei.com>
In-Reply-To: <20210310174535.00007ae2@Huawei.com>
References: <CANBZqrGur27Mn8upmfz216tz4ZsgZoVEJTjhgmhDbWT-5_kxZg@mail.gmail.com>
        <20210310174535.00007ae2@Huawei.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Mar 2021 17:45:35 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 10 Mar 2021 19:24:39 +0530
> Utkarsh Verma <utkarshverma294@gmail.com> wrote:
> 
> > Hello,
> > 
> > This is Utkarsh Verma. I am a 3rd year Bachelor of Technology
> > Undergrad in Electronics Engineering from HBTU, Kanpur, India.
> > 
> > I want to participate in GSOC this summer, by contributing to the IIO
> > subsystem. But more importantly, I want to be a part of this community
> > and get my hands dirty.
> > 
> > I have done the operating system course and know the very basics of
> > Linux Kernel. I have also read some chapters of the "Linux Device
> > Drivers" book. I am very new to the iio subsystem and I am still
> > reading the documentation and the conversation on the mailing list. So
> > if anyone can suggest some easy fixes/tasks for getting started would
> > really be appreciated.
> > 
> > I would be really happy to contribute.
> > 
> > Regards,
> > Utkarsh Verma  
> 
> Hi Utkarsh,
> 
> Welcome to IIO.
> 
> If you want a practical immediate task to make sure you have flow
> of submitting patches etc correct, one issue we've just started seeing
> is that when we do
> 
> make W=1
> 
> we get some misleading reports like:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > head:   4ef57c4862e38e6034978d8b247a511292d7055a
> > commit: 1cabd1c21b2a6c5b0dd3fdcffe0b24c1d0e4fc38 [72/74] iio: hrtimer: Allow sub Hz granularity
> > config: x86_64-randconfig-a011-20210308 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 3a11a41795bec548e91621caaa4cc00fc31b2212)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=1cabd1c21b2a6c5b0dd3fdcffe0b24c1d0e4fc38
> >         git remote add iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> >         git fetch --no-tags iio testing
> >         git checkout 1cabd1c21b2a6c5b0dd3fdcffe0b24c1d0e4fc38
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >    
> > >> drivers/iio/trigger/iio-trig-hrtimer.c:20: warning: expecting prototype for O periodic hrtimer trigger driver(). Prototype was for PSEC_PER_SEC() instead    
> >
> >
> > vim +20 drivers/iio/trigger/iio-trig-hrtimer.c
> >
> >     18
> >     19  /* Defined locally, not in time64.h yet. */    
> >   > 20  #define PSEC_PER_SEC   1000000000000LL    
> >     21
> >  
> 
> Gwendal figured out what was going on.  It's down to an incorrect marking of the
> initial comment block (where copyright notice etc is ) as kernel doc
> by prefixing it with /**
> 
> If you'd like to first fine one of those cases and send a patch fixing it that
> would be great.  Once we've sanity checked that first one for process issues etc
> you could then ensure there are no other instances in IIO.
> 
> No problem if not and you want something more substantial to start with.
> This is just something that hit my inbox today that I'd otherwise clean up,
> but seemed like a good task for anyone wanting to get started!

Actually scrap that idea.  Serves me right for not reading all my IIO related emails
but Gwendal already sent out a patch fixing them all.  Sorry!

Jonathan

> 
> Thanks,
> 
> Jonathan

