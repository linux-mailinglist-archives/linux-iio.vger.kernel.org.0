Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E427007E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgIRPFJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 11:05:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2893 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbgIRPFI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Sep 2020 11:05:08 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4C4C61F1FBE76D027E8C;
        Fri, 18 Sep 2020 16:05:07 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 16:05:07 +0100
Date:   Fri, 18 Sep 2020 16:05:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: IIO: Review request.
Message-ID: <20200918160506.00001e9d@huawei.com>
In-Reply-To: <CAHp75VfEAA7QeFz1uEVoX6fsuO9kGEmLTCZkHaCk8_rOWigtbQ@mail.gmail.com>
References: <20200918133357.0ed56512@archlinux>
        <CAHp75VfEAA7QeFz1uEVoX6fsuO9kGEmLTCZkHaCk8_rOWigtbQ@mail.gmail.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 17:05:29 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 18, 2020 at 3:34 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > Hi All,
> >
> > Classic being the maintainer problem, is that there is no one specific to pester
> > when you can't get reviews on your own patches.  Hence if anyone has some
> > time I'd appreciate sanity checks on:
> >
> > [PATCH 2/3] iio: Add __printf() attributes to various allocation functions
> > https://lore.kernel.org/linux-iio/20200913132115.800131-3-jic23@kernel.org/
> >  
> 
> Examples show that rather
> static __printf() for the first occurrence. Otherwise the entire list
> of these patches LGTM. You may put my Rb tag.

Thanks to everyone who jumped on these.

I'll fix up that and pick them up shortly.

Jonathan

> 
> > [PATCH 3/3] iio:core: Tidy up kernel-doc.
> > https://lore.kernel.org/linux-iio/20200913132115.800131-4-jic23@kernel.org/
> >
> > [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by enum required.
> > https://lore.kernel.org/linux-iio/20200913112546.715624-1-jic23@kernel.org/
> >
> > [PATCH] iio:accel:bma180: Fix use of true when should be iio_shared_by enum
> > https://lore.kernel.org/linux-iio/20200913121227.764626-1-jic23@kernel.org/
> >
> > For those last 2 I forgot I'd previously sent effectively the same fixes out
> > earlier in the year but didn't get any reviews then either :(
> >
> > Note I've randomly picked a few people who have done reviews or posted a lot
> > of patches recently for the cc list.  I'm more than happy if anyone else
> > wants to join in with the fun :)  Reviews are always appreciated for any
> > code submitted to IIO from anyone.  If you are unsure about something in
> > a review, it is fine to say so.  Hence even relatively new people can
> > offer great value.  We all started somewhere!
> >
> > Thanks,
> >
> > Jonathan  
> 
> 
> 

