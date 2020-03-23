Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71A518F1F5
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 10:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCWJkZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 05:40:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2583 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727695AbgCWJkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 05:40:24 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9488083465067C7A73B8;
        Mon, 23 Mar 2020 09:40:23 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Mar 2020 09:40:22 +0000
Received: from localhost (10.47.90.106) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 09:40:22 +0000
Date:   Mon, 23 Mar 2020 09:40:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/5] iio: pressure: bmp280: Tolerate IRQ before
 registering
Message-ID: <20200323094018.00002190@Huawei.com>
In-Reply-To: <CAHp75VcUPSmCnKFSm8y6Nq_qCcMHHihACC+49FyzrawAqMjQDA@mail.gmail.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
        <20200322171216.3260cd37@archlinux>
        <CAHp75VcUPSmCnKFSm8y6Nq_qCcMHHihACC+49FyzrawAqMjQDA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.106]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 23:15:13 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Mar 22, 2020 at 7:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 17 Mar 2020 12:18:09 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  
> > > With DEBUG_SHIRQ enabled we have a kernel crash
> > >
> > > [  116.482696] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > >
> > > ...
> > >
> > > [  116.606571] Call Trace:
> > > [  116.609023]  <IRQ>
> > > [  116.611047]  complete+0x34/0x50
> > > [  116.614206]  bmp085_eoc_irq+0x9/0x10 [bmp280]
> > >
> > > because DEBUG_SHIRQ mechanism fires an IRQ before registration and drivers
> > > ought to be able to handle an interrupt happening before request_irq() returns.
> > >
> > > Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> >
> > Hmm. Nasty corner case but fair enough to fix it up.
> > I guess we should audit other drivers for similar paths...  
> 
> One can easily test, no device even needed (however in this case I have one)
> 
> ...
> 
> > > -     if (data->use_eoc)
> > > -             init_completion(&data->done);
> > > +     reinit_completion(&data->done);  
> >
> > reinit on the completion when we don't even have an interrupt
> > (hence data->use_eoc == false) seems excessive.  Why did
> > you drop the conditional?  
> 
> It's harmless and gives less code I believe.
> But if you insist I can put it back.
> 

I agree it's harmless but breaks the logical flow by doing
something unnecessary so either we need a comment to say that
or easier option, just put the condition back in.

Jonathan


