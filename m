Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B6312B69
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBHIC7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 03:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhBHICo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 03:02:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A372C06174A
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 00:02:04 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p15so11907671ilq.8
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 00:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fgd0XnI7LURRTD2FiiPPVwOhPkM3tqnC+Cx+EyvnUxY=;
        b=Isoz0AQdgPHu7Fm7gKrBILRLCrLU7X7wFYAl7jt1UKf6UJUhDsr1J2AEbeTa8bDfrh
         nF2xoD1qT+7iKYzHkKKrI+HPfNYYkyvbBwDPa6gqfgqj65vs2ij/uIQpHJaWPx4xve5l
         Ip+ECWWkxpVwVXZRD2rYrZnx7sr//+NMGCT5fGjDDJov1WbqQPart9k0/Qo7ZJyqTJGB
         i7M0xCfWjPGBgIUL/+ZuTgkkgesxvQ5HWmVBCYwn1unEol285k2c4HE57W0qDTlINPYG
         mYZQATDUnwvoZFi/lgI3jtFkzvQNmR33RMzybyLB2Kt8vYvW3kM5n0uEI5YhHWrzdBf6
         Y5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fgd0XnI7LURRTD2FiiPPVwOhPkM3tqnC+Cx+EyvnUxY=;
        b=KD6TGdWifi6fxNxS2w0SGjZDTPWEaEYdccfCHweFPW5N8gpeFGDxvm4QmYrTtqOJn8
         0QM74OMH+sdBlElQNu+cj29ZLaQI5LHsbWhnvpSqFfzQ58+8v3ZJYoOJkR5ilvIyFtlb
         Kc4kF/wlW+mrVO2DqxrhWJe6RdMgDou9lgZG9aoowUSGahTFWDSx+qr2ZXHXbx6ntC2D
         3ygTmRTsrDhDmTb7KejQgi0TnYHng5HCpe3hrn8pIQtNiiZ2REJ69hpEegazkaS0YXbD
         Ip1BMG4uAfX74xI2yTullyi6dVoK2asBFwGxRcuOUi1euJx/c2/0JAaeB6p4yEges/zp
         lOIw==
X-Gm-Message-State: AOAM532b5NR7joxQGkwu3hmbZArqLjNdR3zylVZH0Ho31QHy20F4yymG
        1qTCX7GYtW4VTN61Rnth+U4lrGtbXaM914IXCJg=
X-Google-Smtp-Source: ABdhPJzxNJCuLWQvmMzvvPlvbRpQLzT2LcBEsq1BG6Rx9FUsHM5c69utimxpT2bZnboKjzC3OZw+GhP1/ol8M/vA1ik=
X-Received: by 2002:a92:ab10:: with SMTP id v16mr15233517ilh.100.1612771323582;
 Mon, 08 Feb 2021 00:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20210207154623.433442-1-jic23@kernel.org> <20210207154623.433442-21-jic23@kernel.org>
 <ad342dd10155419097b852761aa21038@hisilicon.com>
In-Reply-To: <ad342dd10155419097b852761aa21038@hisilicon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 8 Feb 2021 10:01:52 +0200
Message-ID: <CA+U=DsoRRQZ2fbywQHjiC6Qzu1tNHq3aQjy4-=0rNgS2zwRWwQ@mail.gmail.com>
Subject: Re: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 8, 2021 at 9:52 AM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Monday, February 8, 2021 4:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> > <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> > <jonathan.cameron@huawei.com>
> > Subject: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Rather than using the fallback path in the i2c subsystem and hoping
> > for no clashes across vendors, lets put in an explicit table for
> > matching.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/staging/iio/cdc/ad7150.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7150.c
> > b/drivers/staging/iio/cdc/ad7150.c
> > index 0bc8c7a99883..33c8a78c076f 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >
> > @@ -655,9 +656,16 @@ static const struct i2c_device_id ad7150_id[] = {
> >
> >  MODULE_DEVICE_TABLE(i2c, ad7150_id);
> >
> > +static const struct of_device_id ad7150_of_match[] = {
> > +     { "adi,ad7150" },
> > +     { "adi,ad7151" },
> > +     { "adi,ad7156" },
> > +     {}
> > +};
>
> Does it compile if CONFIG_OF is not enabled?
>
> >  static struct i2c_driver ad7150_driver = {
> >       .driver = {
> >               .name = "ad7150",
> > +             .of_match_table = ad7150_of_match,
>
> of_match_ptr(ad7150_of_match)?

of_match_ptr() is not recommended anymore because of the ACPI PRP0001
thing/compat with OF;

>
> Do we need dt-binding doc?

Should be here:
https://lore.kernel.org/linux-iio/20210207161820.28abeb33@archlinux/T/#u

>
>
> >       },
> >       .probe = ad7150_probe,
> >       .id_table = ad7150_id,
> > --
> > 2.30.0
>
> Thanks
> Barry
>
