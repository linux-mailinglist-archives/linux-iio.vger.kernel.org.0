Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F5248DC5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHRSNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 14:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgHRSNX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2020 14:13:23 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DDBC061342
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 11:13:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f12so10849110ils.6
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9U/Sx2QERcOCVX35hWobFoJ/Y77xMuuF+XP4kC4IsP8=;
        b=HSfPAi5z56+1OQ56s/bVL/8m0nwvhOhVAl0upIKbSldrxDGbMzriinSM50HLJHfTQg
         EDXziX69Qyvg9n2sgYPg855R9fycdB6u2HUvmVi6qsd1bb+QjAAQjB6Mx/jqzRolYbE+
         bZ2cF53BTu9M6hyrrfIVZCFIjcSS9Fa+CGoDyVsSCJOljJOwpOih97f4LTuGLk3PNL0m
         EIgBQd0dBFkt1JMZEtMDHIbCoOU5HgBc0gZ9WHu7AyBpKJ4Zu8RrnpoFCAOs7UTD77gI
         pra1aG4x2NZfN2xAk23zrSVa0GzJ2PqqqZW+0zyP8TFrVV4oagPup6MLZdtXbUpf4dwL
         fn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9U/Sx2QERcOCVX35hWobFoJ/Y77xMuuF+XP4kC4IsP8=;
        b=KCNie6+1t3Y/ctHYU8rrzunI9HUVW0yVn2ZY3PSnR+V3/I531UudD0Sw9O6nPzmz6A
         UQ3LuckcEijCuuWjPe5pNos7o46Zm0L6BM1IjingX+4lHkIEgm40APPDK2CwyAhFGT0z
         g8VNI7b+yI6J9DXmDJG/uKgTu7kM9/GT7P6qS7SBegeLMMOIdS3SdybYbSB2mdnqjC/F
         gmBfb6B1Fze9pm6jm2HYy3d9/sN4P2VwzqvmJI4Xm0Q9XXG5y9qUQ+FbbTVeQ9WEa0tq
         vBYJxkxJ7DvM3qGH9neSkrR/Sm1ttR5lcWG5/ua4fMYujzpu/KuqA9XeStswaFABBetW
         gihQ==
X-Gm-Message-State: AOAM530Ueq57nWBnN15w0m4UAK0y332wYA0Bqf5akLf8hbj4qOYOTqtm
        O01Xqvn7Hq0ATNH1B1QbvMRq52o+uRS9ut9FZWtqpw==
X-Google-Smtp-Source: ABdhPJwU0zjhfSycWdHZuFdxhvZP3nNBrtpPBCHl2IpLXWUKYq+9nUKXoWE1Im4HPtI8g4UpL17/nP0HqX7WQma6iho=
X-Received: by 2002:a92:d30a:: with SMTP id x10mr18991938ila.287.1597774401599;
 Tue, 18 Aug 2020 11:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170535.17041-1-brgl@bgdev.pl> <20200817170535.17041-2-brgl@bgdev.pl>
 <20200817173908.GS1891694@smile.fi.intel.com> <CAMRc=MdaaWhV_ZKHgWy_Gxkp=jMuZcwqpoE8Ya_84n9ZT5O31A@mail.gmail.com>
 <20200818082500.GB1891694@smile.fi.intel.com> <CAMRc=Md5yrgxnPf=qwKYhwHACcq-XeKOKZ76OwYdMGO8SgYmzQ@mail.gmail.com>
 <20200818171046.GU1891694@smile.fi.intel.com>
In-Reply-To: <20200818171046.GU1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 18 Aug 2020 20:13:10 +0200
Message-ID: <CAMRc=MfmmRweZ_WBkqA_FHVoTZ5KxNwyFLjwpypG5c=K9ki8XA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 18, 2020 at 7:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 18, 2020 at 06:27:12PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Aug 18, 2020 at 10:40 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Aug 17, 2020 at 10:02:05PM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Aug 17, 2020 at 7:43 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Mon, Aug 17, 2020 at 07:05:33PM +0200, Bartosz Golaszewski wro=
te:
> > > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > ...
> > >
> > > > > > +static struct devres *to_devres(void *data)
> > > > > > +{
> > > > > > +     return (struct devres *)((u8 *)data - ALIGN(sizeof(struct=
 devres),
> > > > > > +                                                 ARCH_KMALLOC_=
MINALIGN));
> > > > >
> > > > > Do you really need both explicit castings?
> > > > >
> > > >
> > > > Yeah, we can probably drop the (struct devres *) here.
> > >
> > > void * -> u8 * here is also not needed, it is considered byte access =
IIRC.
> > >
> >
> > Actually it turns out that while we don't need the (void *) -> (u8 *)
> > casting, we must cast to (struct devres *) or the following error is
> > produced:
> >
> > drivers/base/devres.c: In function =E2=80=98to_devres=E2=80=99:
> > drivers/base/devres.c:41:21: error: returning =E2=80=98u8 *=E2=80=99 {a=
ka =E2=80=98unsigned
> > char *=E2=80=99} from a function with incompatible return type =E2=80=
=98struct devres
> > *=E2=80=99 [-Werror=3Dincompatible-pointer-types]
> >   return ((u8 *)data - ALIGN(sizeof(struct devres),
> >          ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         ARCH_KMALLOC_MINALIGN));
> >         ~~~~~~~~~~~~~~~~~~~~~~~
>
> Of course, you have to drop u8 * casting as well.
>

Yes, of course. Duh

Bart
