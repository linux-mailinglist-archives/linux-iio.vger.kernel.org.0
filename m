Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F083CCE4A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhGSHQI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 03:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhGSHQH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 03:16:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42737C061767;
        Mon, 19 Jul 2021 00:13:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y4so15617356pfi.9;
        Mon, 19 Jul 2021 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YmX2Oxtcqjs3EK/fW8wr2ysw0zb7csbmsP0g4gVF/8U=;
        b=qStvLfplae7S9qGcKJli3+3Fn78sFjqhvBMEd4pIZ4MVWSb7Ue7jISU3EzdhHrIHOZ
         lym4TFCGfSqBXpxplm/SRpPpD9ShHwtIV2zdjIxqRD8fhcUrei/3kImfFgPSx1+L34q8
         WMMhWzTaXHFlzgyPoo4p1O0Ozsd2y7WnAG/Iq8AH4IOJg1k9PjJS8BubR05DBbD4M12F
         xWAqzDgV9LImSJC4FUQmq3IakF/oHqlkGsDtw28FQZaBUnrSRw/Do/9qRcJii2HGLqi/
         riFvr0LJTUO0U0QeGBhTYbKu/LLvUbBezWXgHYAZAxfr7gctBMU/IsmLox3yJwlDTSHS
         XpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YmX2Oxtcqjs3EK/fW8wr2ysw0zb7csbmsP0g4gVF/8U=;
        b=SzlchttP3c7q3hi9mx6lznkkSQGz22tvu8aQoygAey4dBL1e9JzNOw/Od92B5EEORo
         xkWfa28TqMA63AByCtidF5rPlTyOkQhS4eRhdDAHSM4uskUqLG2fELXZHAXhjJWgTGZm
         Mg6O/q8o62QGUgoWmNVMhmK4Wg/g6uoh7cIW7A3GD87Xc68mzFeaeCGf8iDOgXc5U09Z
         kUSNPSMP8nrxEe3QNBZRDBdcLr0JHwsTYoRWdKZr9W028h2tF9YY3/c0Fw8FUMZPOhbY
         oOlLNdJUeq04M5+g4hbirgjcsKYGV3U3O9aUDHVo7+ndcuA39cGn7ZkJ76teKpKocTl5
         33BA==
X-Gm-Message-State: AOAM5311MY8pIzYpZWzALUWAg2o9cin6u4l2ZWseoy+ZCQelS4S7J8zT
        5SXPA5DYD41jPOSrFHLjwYEqGbv4lvNtGMN6VynLvy4vBW8340S3
X-Google-Smtp-Source: ABdhPJyghy5zzTp6QtQ92u0cdy9MGro4uAThQk75ovvLwo8qxXR0f3065s6UyG7/QVM+7NzX3GXvoPwV21ipE7vewB0=
X-Received: by 2002:a63:67c5:: with SMTP id b188mr24111982pgc.333.1626678787737;
 Mon, 19 Jul 2021 00:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
 <CAN8YU5NKGLO6a4wqaW07NAU-OdsdBohoXzMCBcskaFsCRtrGhw@mail.gmail.com> <YPF97IvnlUDtIHar@smile.fi.intel.com>
In-Reply-To: <YPF97IvnlUDtIHar@smile.fi.intel.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 09:12:56 +0200
Message-ID: <CAN8YU5M6S11Bbe3LW74RCD3zqL6xQ+ZF5JtzMKSMMn7pxLL27g@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just few inline comments; implicitly OK for others.

Il giorno ven 16 lug 2021 alle ore 14:39 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
>
> > > Useless parentheses. If the LEN is a plain number, use decimal, if
> > > it's limited by register width, use the form of (BIT(x) - 1). In such
> > > a case it's easy to see how many bits are used for it.
> >
> > It's byte number, defined by how many 8-bits registers make up the
> > UID. I'll go for a decimal and I'll drop the parentheses.
>
> 15 seems the right one then?

Isn't it 16? From my understanding of the datasheet registers involved
are from 0x50 to 0x5F.

>
> > > > +       if (res && res != -ERESTARTSYS) {
> > >
> > > Shouldn't RESTARTSYS be handled on a regmap level?
> >
> > Can you please elaborate on this?
>
> I meant if you need to take care about this it seems to me that it has to be
> thought of on regmap level. I.o.w. what is the rationale behind this additional
> check?

The regmap_bus write() and read() implementations wait for an
interruptible completion, which is completed when a response from the
IMU is received. In practice by hitting Ctrl-C at the "right" moment I
got my kernel log polluted with dev_err() telling me the regmap
operation failed, but in this specific case there was nothing wrong:
it's just being aborted. Still, in all other error case I would like
to know. This is the rationale behind this check. The ERESTARTSYS
error have anyway to actually propagate in order to notify the caller
that the read/write just didn't complete.

If you mean move the check+dev_err() in bno055_sl.c regmap_bus read()
and write() ops, that is fine; my original point for putting it where
it is now, was because I was wondering whether this has to be common
to the (not yet here) I2C support code.

> ...
>
> > > Sounds like NIH hex2bin().
> >
> > Indeed.. I've failed to find out this helper. Looking at the code it
> > seems it wouldn't work as drop-in replacement here, because of spaces
> > in the HEX string. But I might just decide to format the HEX string
> > without spaces in order to being able to use hex2bin().
>
> I'm not even sure why it's in ASCII instead being directly binary file.

That was almost a coin-flip for me. Just, being a few bytes, I decided
to make them printable: If I load this driver for the 1st time, and
start poking around in it's sysfs, cat-ting random stuff to give a
look, I would just find a HEX line more friendly that a binary chunk
on my console.

.. But If you think it's better, I'll go for binary without any hesitation..

>
> > > IIO core should do this, besides the fact that it must use sysfs_emit().
> > > Ditto for the similar.
> >
> > Ok for sysfs_emit(), thanks. But what do you mean with "IIO core
> > should do this"? Can you please elaborate?
>
> I believe that IIO has a generic method to print tables via sysfs. AFAIR it is
> done via "_avail".

Ah, do you refer to the read_avail() operation in iio_info?
I'll try to go with it; I wasn't aware of that, thank you.
