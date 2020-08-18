Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF01248B9C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgHRQ27 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgHRQ1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2020 12:27:25 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A00AC061342
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 09:27:24 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q14so14693437ilm.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oryb9Gw/XAffWSWQvfMiaYrjBvPkCAMTzbIDIXNJbnI=;
        b=lbSYVl4iccAlsHjqO4TXn8l7W42NVRbWABhoe/TSlReejliAxJF6mSRBLxDZNPJNZh
         VId4k9ffeWPZhk7cbu1TO7cS/PNEVLwghIPT6w6bL9qC/JdbsNwj29BHb6Di8pjDYd6t
         Mb2Tj5uHQalzN89CEw8MTgpDGxSlc9Qr6rOFCyrfhM2cJuE07faFRcVHPHcuNjNsYD8h
         gn37CS6aTkVi9vjW3F+tGK72J0Xcltvu5GUZOJml8o8u07l9AaJo4Zwu5kdMWo9WTeex
         bxkuSzPNLlN7W1jffzHdrMP5MTNsNLgCT2Qq6iS6IKQpIJZweyCvjyX90YIefZjzDyp2
         IE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oryb9Gw/XAffWSWQvfMiaYrjBvPkCAMTzbIDIXNJbnI=;
        b=hkvGq9sxNCxqxGMQhe9J/BY48RCNV5TDVZjnYGkN6o+EUxYiVPQWIS0YpvLVp+RwzI
         zcmxsBeHGLiNk9UWY5CO1utYj1LJ1A+U6ww3U0xc8jzNkSFgrRq6UkioHWbl1D6/jPuZ
         Af+Uqv8xuegW3o0fmx596eHvk+uOFoHalV32C0yrOs2WVYSRiX10OlqtvEdC8qtOCrjz
         tXt241yROIjZLARz+leQ72bE02XQYakhBoxDjD5Cvuvi6cctdy5LVcUD2qw4K+W50mfx
         DQuUsxxFj/ePODwFdrk8F0NjsfS6HssMptDDLClCaxxvRqbfeFGCvLVFg/QWKcQj3f5d
         IFkA==
X-Gm-Message-State: AOAM5303gsjiQQKDTny3zVMLZFVx/Veyjdg7c+Eu3a5P8FB4DtBrxPF/
        Bhh/1XASl+Tnl0Mf4GOfViFWBpvtAmK1TzYB1hAUuQ==
X-Google-Smtp-Source: ABdhPJzG6Vqg4L5Wbx1ozdnU3GZmWNDJJUJs9j/zG7IUQgWN6QYwYtaA8cti9q2O+EPbmg1Ym7IzGb6KgGhztaQ6jQY=
X-Received: by 2002:a92:d30a:: with SMTP id x10mr18640134ila.287.1597768043689;
 Tue, 18 Aug 2020 09:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170535.17041-1-brgl@bgdev.pl> <20200817170535.17041-2-brgl@bgdev.pl>
 <20200817173908.GS1891694@smile.fi.intel.com> <CAMRc=MdaaWhV_ZKHgWy_Gxkp=jMuZcwqpoE8Ya_84n9ZT5O31A@mail.gmail.com>
 <20200818082500.GB1891694@smile.fi.intel.com>
In-Reply-To: <20200818082500.GB1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 18 Aug 2020 18:27:12 +0200
Message-ID: <CAMRc=Md5yrgxnPf=qwKYhwHACcq-XeKOKZ76OwYdMGO8SgYmzQ@mail.gmail.com>
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

On Tue, Aug 18, 2020 at 10:40 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 17, 2020 at 10:02:05PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Aug 17, 2020 at 7:43 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Aug 17, 2020 at 07:05:33PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> ...
>
> > > > +static struct devres *to_devres(void *data)
> > > > +{
> > > > +     return (struct devres *)((u8 *)data - ALIGN(sizeof(struct dev=
res),
> > > > +                                                 ARCH_KMALLOC_MINA=
LIGN));
> > >
> > > Do you really need both explicit castings?
> > >
> >
> > Yeah, we can probably drop the (struct devres *) here.
>
> void * -> u8 * here is also not needed, it is considered byte access IIRC=
.
>

Actually it turns out that while we don't need the (void *) -> (u8 *)
casting, we must cast to (struct devres *) or the following error is
produced:

drivers/base/devres.c: In function =E2=80=98to_devres=E2=80=99:
drivers/base/devres.c:41:21: error: returning =E2=80=98u8 *=E2=80=99 {aka =
=E2=80=98unsigned
char *=E2=80=99} from a function with incompatible return type =E2=80=98str=
uct devres
*=E2=80=99 [-Werror=3Dincompatible-pointer-types]
  return ((u8 *)data - ALIGN(sizeof(struct devres),
         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ARCH_KMALLOC_MINALIGN));
        ~~~~~~~~~~~~~~~~~~~~~~~

Bart
