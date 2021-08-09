Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339C73E4287
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhHIJWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 05:22:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3605 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhHIJWX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 05:22:23 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GjrDt6yWfz6D9D7;
        Mon,  9 Aug 2021 17:21:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 9 Aug 2021 11:22:01 +0200
Received: from localhost (10.52.123.61) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Mon, 9 Aug 2021
 10:22:00 +0100
Date:   Mon, 9 Aug 2021 10:21:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, Len Baker <len.baker@gmx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        <linux-hardening@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210809102131.000021eb@Huawei.com>
In-Reply-To: <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
References: <20210807152225.9403-1-len.baker@gmx.com>
        <20210808172503.5187cd24@jic23-huawei>
        <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.61]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Aug 2021 22:00:34 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 8, 2021 at 7:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat,  7 Aug 2021 17:22:25 +0200
> > Len Baker <len.baker@gmx.com> wrote:
> >  
> > > strcpy() performs no bounds checking on the destination buffer. This
> > > could result in linear overflows beyond the end of the buffer, leading
> > > to all kinds of misbehaviors. The safe replacement is strscpy().
> > >
> > > This patch is an effort to clean up the proliferation of str*()
> > > functions in the kernel and a previous step in the path to remove
> > > the strcpy function from the kernel entirely [1].
> > >
> > > [1] https://github.com/KSPP/linux/issues/88
> > >
> > > Signed-off-by: Len Baker <len.baker@gmx.com>  
> > Applied to the togreg branch of iio.git and pushed out as testing
> > so 0-day can poke at it and see if we missed anything.  
> 
> Isn't it too early? Or am I missing something (see below)?
> 
> ...
> 
> > >                       /* use length + 2 for adding minus sign if needed */
> > > -                     str = devm_kzalloc(regmap_get_device(st->map),
> > > -                                        strlen(orient) + 2, GFP_KERNEL);
> > > +                     n = strlen(orient) + 2;
> > > +                     str = devm_kzalloc(regmap_get_device(st->map), n,
> > > +                                        GFP_KERNEL);
> > >                       if (str == NULL)
> > >                               return -ENOMEM;
> > >                       if (strcmp(orient, "0") == 0) {
> > > -                             strcpy(str, orient);
> > > +                             strscpy(str, orient, n);
> > >                       } else if (orient[0] == '-') {
> > > -                             strcpy(str, &orient[1]);
> > > +                             strscpy(str, &orient[1], n);
> > >                       } else {
> > >                               str[0] = '-';
> > > -                             strcpy(&str[1], orient);
> > > +                             strscpy(&str[1], orient, n - 1);  
> 
> Why n-1?

n is the total length and this is printing from [1], so n - 1 is remaining
space.

> 
> > >                       }  
> 
> As far as I understood the logic, it  inverts the sign except the case
> when it equals 0.
> 
> I have a question here, why can't we always use +/-?
> Why can't 0 be prefixed with a sign?

Technically a userspace ABI change, but I agree it should be fairly
harmless unless someone is rolling their own string handling routines.

> 
> If the above can be used, we may simplify this code.
> 
> Len, I think this task may be considered simple, but I recommend
> thinking about each case and finding a way to simplify it more.
> 

It could be a little simpler doing this, so 'maybe' worth doing.

Jonathan
