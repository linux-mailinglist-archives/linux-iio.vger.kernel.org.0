Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD821B25E2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgDUMY3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 21 Apr 2020 08:24:29 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34915 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgDUMY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 08:24:27 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EFAE120000A;
        Tue, 21 Apr 2020 12:24:24 +0000 (UTC)
Date:   Tue, 21 Apr 2020 14:24:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Xia, Hui" <hui.xia@intel.com>
Cc:     "Li, Philip" <philip.li@intel.com>, lkp <lkp@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ti-ads8344: properly byte swap value
Message-ID: <20200421122424.GK7326@piout.net>
References: <20200415212257.161238-2-alexandre.belloni@bootlin.com>
 <202004161449.NY5hL54S%lkp@intel.com>
 <20200416205023.GA437042@piout.net>
 <20200419024948.GK21730@intel.com>
 <2A5F4C9150EECB4DAA6291810D6D61B9745DE89F@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2A5F4C9150EECB4DAA6291810D6D61B9745DE89F@shsmsx102.ccr.corp.intel.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 21/04/2020 07:25:01+0000, Xia, Hui wrote:
> >-----Original Message-----
> >From: Li, Philip <philip.li@intel.com>
> >Sent: 2020年4月19日 10:50
> >To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >Cc: lkp <lkp@intel.com>; Jonathan Cameron <jic23@kernel.org>; kbuild-
> >all@lists.01.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen
> ><lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Gregory
> >CLEMENT <gregory.clement@bootlin.com>; linux-iio@vger.kernel.org; linux-
> >kernel@vger.kernel.org
> >Subject: Re: [PATCH 1/3] iio: adc: ti-ads8344: properly byte swap value
> >
> >On Thu, Apr 16, 2020 at 10:50:23PM +0200, Alexandre Belloni wrote:
> >> Hi,
> >>
> >> On 16/04/2020 14:22:03+0800, kbuild test robot wrote:
> >> > Hi Alexandre,
> >> >
> >> > I love your patch! Yet something to improve:
> >> >
> >> > [auto build test ERROR on iio/togreg] [also build test ERROR on
> >> > v5.7-rc1 next-20200415] [if your patch is applied to the wrong git
> >> > tree, please drop us a note to help improve the system. BTW, we also
> >> > suggest to use '--base' option to specify the base tree in git
> >> > format-patch, please see https://stackoverflow.com/a/37406982]
> >> >
> >> > url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/iio-adc-ti-
> >ads8344-improve-the-driver/20200416-073357
> >> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> >> > config: c6x-allyesconfig (attached as .config)
> >> > compiler: c6x-elf-gcc (GCC) 9.3.0
> >> > reproduce:
> >> >         wget https://raw.githubusercontent.com/intel/lkp-
> >tests/master/sbin/make.cross -O ~/bin/make.cross
> >> >         chmod +x ~/bin/make.cross
> >> >         # save the attached .config to linux build tree
> >> >         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0
> >> > make.cross ARCH=c6x
> >> >
> >>
> >> I spent some time to reproduce and this is actually not that trivial
> >> because your toolchains are linked with libisl22 and most
> >> distributions still ship an older version. Maybe you can do something about that?
> >Thanks for the feedback, we will resolve this to use old version in earliest time.
> The cross toolchains has been updated to link with libisl19 the stable version. Please remove the old toolchain and make.cross again.
> Feel free to let us know if still have problem. Thanks.
> 

Thank you, this works properly on more machines now.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
