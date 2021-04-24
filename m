Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C379E36A184
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbhDXOHD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 10:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237911AbhDXOEH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 10:04:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC166147F;
        Sat, 24 Apr 2021 14:03:26 +0000 (UTC)
Date:   Sat, 24 Apr 2021 15:04:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH 5/7] iio: core: simplify some devm functions
Message-ID: <20210424150406.04178e7d@jic23-huawei>
In-Reply-To: <59831f7e-106b-013b-818d-8411777eed85@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
        <CA+U=DspZCGVjFxB0YH7OAPBKhFAKz=a9Q=O7xW-Xu4BPZKC=pA@mail.gmail.com>
        <9f1257a2-a69e-acbc-8c0a-2d2157274225@hisilicon.com>
        <CAHp75Ve_JwGeruZeZnVk3pXXmETVERQTdR2+MSPX=Y75+nQLcw@mail.gmail.com>
        <94bbe851-1f09-7099-38ac-2b6fcb056349@hisilicon.com>
        <CAHp75Ve7+-_=nsUjn5e3tR-37Fg622_PSPyR5CrgUWGxk6zPKA@mail.gmail.com>
        <59831f7e-106b-013b-818d-8411777eed85@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Apr 2021 21:05:49 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> On 2021/4/9 17:55, Andy Shevchenko wrote:
> > On Fri, Apr 9, 2021 at 12:42 PM Yicong Yang <yangyicong@hisilicon.com> wrote:  
> >> On 2021/4/9 17:19, Andy Shevchenko wrote:  
> >>> On Fri, Apr 9, 2021 at 10:22 AM Yicong Yang <yangyicong@hisilicon.com> wrote:  
> >>>> On 2021/4/8 21:09, Alexandru Ardelean wrote:  
> >>>>> On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:  
> > 
> > ...
> >   
> >>> Actually Alexandru has a good point. Compare the pieces I left above.
> >>>  
> >>
> >> a little different from my perspective when I did this.
> >>
> >> previously:
> >>
> >> -       ptr = devres_alloc(devm_iio_device_release, sizeof(*ptr),
> >> -                          GFP_KERNEL);
> >> -       if (!ptr)
> >> -               return NULL;
> >>
> >> if devres_alloc() failure we return NULL.
> >>
> >>
> >>         iio_dev = iio_device_alloc(parent, sizeof_priv);
> >> -       if (iio_dev) {
> >> -               *ptr = iio_dev;
> >> -               devres_add(parent, ptr);
> >> -       } else {
> >> -               devres_free(ptr);
> >> -       }
> >>
> >>         return iio_dev;
> >>
> >> if iio_device_alloc() failed, we return what it returns.
> >>
> >> now we remove devres_alloc() and stay iio_device_alloc(), so I just
> >> keep to return iio_dev.
> >>
> >> but actually iio_device_alloc() will return NULL at failure. :)
> >> so return NULL here is definitely correct. i'll change to that if
> >> it's recommended.  
> > 
> > Confusing here (in your case) is that:
> > 
> > if (!FOO)
> >  return BAR;
> > 
> > ...
> > 
> > return BAR;
> > 
> > I.e. twice returning BAR for different occasions. This makes
> > additional cognitive work and decrease readability / maintainability
> > of the code.
> > 
> > I.o.w., yes, it's preferred.
> >   
> 
> got it. will return NULL and will check if other patches in this series
> met the same condition.
> 
> thanks.
> 
Rather than go around a gain, I fixed this up as discussed above and applied
to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan


