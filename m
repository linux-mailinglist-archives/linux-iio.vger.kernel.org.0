Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3A2C04B9
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 12:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgKWLij (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 06:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgKWLii (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 06:38:38 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20EC0613CF
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2020 03:38:38 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id o8so9316031ioh.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2020 03:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GscDJuhiDYI0PonAMJ4n7EEJ+sUn5W7V85jdZ6urdyk=;
        b=1dh8p7k1lp5Ds+jtM8I2xKmjzfCV2nUm9U7Q2iHBD+hmnc9+Pfeh8G1ZLeiWBfLH9n
         LeuZkM63PluEhWUJndYfAhGLehyiMD3N5N9t8dQfPa/AcRgZLxte0xKKQJk1fUaDJcsU
         9XJLiPbEJPLg2JAQs1Y5ORIBzBYNBC6L6uBgIk6FhEFNEs0y6HM6ezYGBQyjktXPSHfP
         OvBql+tOL4ZaY6Q/HvbXw8jPZlBlUlSw/LJl27oe13JpZqPvbUcMOt9MEAeikEz/ZqRJ
         XaaBLISvJ6oOAPHdv/0mZWZyKP5EM3iTI4FQY9yLTeYxJ7mZwoxEWu6jUHYjffvMdjKG
         pjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GscDJuhiDYI0PonAMJ4n7EEJ+sUn5W7V85jdZ6urdyk=;
        b=Wuzj1IR0Ay+uO0hi+JY1O+5WT6E5qLqlYYZh52bVx/xA9e7X21jYGxyrF4XNODIsN3
         zCZM6YzCceNG3jr685Cfv2IWygUJLWNQBuGPhyRjiVKvjBSpI8b6Hb1XezRa2kfYPnGw
         UjdTUd2J0ggcoi4Bt4in44Qveecr4BJmrukYmGmQpQrwgIANAYsjXv1DAJjw6k5UIqMk
         rhKldT5mydKY2osP0QM0P8TIToXE7LxZJp3BzEKRywA6YUzb8iB3iyzIxdXvIj0W2xFt
         eKaxzASd8T/yWjmsN/6SJOKW/2Mavw5H9XhYLuOdSpFBbtJFl64HBPvq6EAvD0bjgINl
         X9LA==
X-Gm-Message-State: AOAM532Tkq03/BjfMC1lvJYDvz8j5XWEE2NsNGgELjoXGGqKzugYLKJ2
        aGi6hyeYyWEUGA/VvRV5MLckkOFUgGHFeTnzz24Egw==
X-Google-Smtp-Source: ABdhPJxYKrJ4ncImo3X/nb2XBn1D0r+PZcMWSmOulu8MZ7PU7Ly4pPaaJJMb86y4tbDTR9F/OzpLPXTCvE369c77RHc=
X-Received: by 2002:a05:6638:ca2:: with SMTP id x2mr5490033jad.136.1606131517077;
 Mon, 23 Nov 2020 03:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20201102142228.14949-1-brgl@bgdev.pl> <20201102142228.14949-2-brgl@bgdev.pl>
 <20201114154641.0258f4ee@archlinux> <X7ADFLwEpUHkTiT+@kroah.com> <CAMpxmJUHiNqKNVDxaWLeDja6huR78u1Hp7JHF_aP5L_UgjYzbg@mail.gmail.com>
In-Reply-To: <CAMpxmJUHiNqKNVDxaWLeDja6huR78u1Hp7JHF_aP5L_UgjYzbg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Nov 2020 12:38:26 +0100
Message-ID: <CAMRc=Mfa2Y65CW8YO_poRgrN9aPjLz=MXYrn7OPUEfwB3mnZvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] device: provide devm_krealloc_array()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 16, 2020 at 11:18 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Sat, Nov 14, 2020 at 5:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Nov 14, 2020 at 03:46:41PM +0000, Jonathan Cameron wrote:
> > > On Mon,  2 Nov 2020 15:22:25 +0100
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > When allocating an array of elements, users should check for
> > > > multiplication overflow or preferably use one of the provided helpers
> > > > like: devm_kmalloc_array().
> > > >
> > > > This provides devm_krealloc_array() for users who want to reallocate
> > > > managed arrays.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > +CC Greg KH.
> > >
> > > As this is going into a very generic place I'd like a relevant ack.
> > > That file is a bit of a wild west for acks, but Greg seems most
> > > appropriate person.
> > >
> > > So Greg, any comments on this one?
> >
> > As there is only 1 user of this function in the patch series, you don't
> > save any extra code space here, I don't think this is worth it.
> >
>
> It's worth it in that the overflow check before allocation doesn't
> seem to belong in a driver IMO but is a general check that should live
> in common code.
>
> > We are seeing less and less gains from these new devm_* additions, and
> > only more confusion and problems with them.  So perhaps don't add this?
> > I don't think it is needed.
> >
>
> I think you're referring to the discussion on
> devm_platform_ioremap_resource()? I would argue that consolidation of
> common operations in helpers is rarely a bad thing but it's a
> discussion for another thread.
>
> I'm not too attached to this patch - if you think this should be
> dropped then fine, but I don't see how the name devm_krealloc_array()
> can confuse anyone.
>

Greg: what's the final call on this?

Bartosz
