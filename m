Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7EC481992
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 06:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhL3FPc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 00:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhL3FPb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 00:15:31 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C39C06173E
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:31 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x6so28197214iol.13
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxGE0+rjWPjDYY2GkTmBJ28xwLSzN3QC/S2I0pikjnw=;
        b=KGXrrchcqSZzKbrql1zzJa10QeGbK4BYWs6kiUQSzs4jXvx+DgQQorCwrshKlk/9wp
         reTwDgainibD2qkXC6fhWGXmOVK2j8rlTKpPWETxA5gOkntojjBaxkiw5Hz49cCv9AEC
         2PwxaRS2ZBTINO7+MVrPMRBlvUAmkg2OxgFkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxGE0+rjWPjDYY2GkTmBJ28xwLSzN3QC/S2I0pikjnw=;
        b=LKd4jwTEzC5w5f6d5mSmL8mO1ro52TQ8rne/0fR9vzpYFZRF04O0vpKkI87l+j4Xar
         MkCwjZvVr3FPpssVtLK/tecH/jCxmZiSAVla5XTruduRAnWy0NrH5QLQ89kxEJ1rzhUK
         kiAMGrOuuo3G9TDiFdvzUp9T6Ue4r3WQJGb6Lq+kCX6QMKdpMP1B6ZF3XjRmpMSqiPcp
         JnOk/GcEckJnsqq1tHpjbhB6tl0j5Ud367IS2shTJndjuI2bT9AfyK7X2kTU47iyULxF
         ie/3GTRYSztcyUCBGrpxvHZcc1If2tAMLlX/pCl2YOHKfmSxC8awCLgKl5XIh8rbRh0s
         XgQQ==
X-Gm-Message-State: AOAM531mrYECLzxb2ikBuuLw6kNFRNCCQAnuFUGUFR3+MEE7VSf8p8rD
        ahlZ5VVOF/KZFwEPUkmfOCZFdX5S9RFZl8qQOfmbOO3vMKQ=
X-Google-Smtp-Source: ABdhPJzKVKzpsHiEmUY8cW4kURWwcpzUUDm1ytTFXI9lXD4E/iijmJwBCLDkJorIjXIkOz5pp2r5uBb5PNE6NUX5QBA=
X-Received: by 2002:a05:6638:23a:: with SMTP id f26mr13421651jaq.222.1640841330579;
 Wed, 29 Dec 2021 21:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20211218002705.3099096-1-gwendal@chromium.org>
 <20211218002705.3099096-2-gwendal@chromium.org> <20211221130019.36b12ac2@jic23-huawei>
In-Reply-To: <20211221130019.36b12ac2@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 29 Dec 2021 21:15:18 -0800
Message-ID: <CAPUE2uvKyP9FUDEYGOg8gu1b08x2h2ZQAgOXFDX2QRRjne3M-Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: proximity: Add sx9360 support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 21, 2021 at 4:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 17 Dec 2021 16:27:03 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > A simplified version of SX9324, it only have one pin and
> > 2 phases (aka channels).
> > Only one event is presented.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> > Changes since v3:
> > - Remove "reference" as a new modifier: it is not needed, indexed
> >   channels and labels are used instead.
> > - Use dev_get_drvdata to access iio device structure.
> > - Use already calculated local variable
> > - Use default: clause to return when possible.
> >
> > Changes since v2:
> > - Fix issues reported during sx9324 driver review:
> >   - fix include with iwyu
> >   - Remove call to ACPI_PTR to prevent unused variable warning.
> > - Fix panic when setting frequency to 0.
> > - Add offset to decipher interrupt register
> > - Fix default register value.
> >
> > Changes since v1:
> > - Remove SX9360_DRIVER_NAME
> > - Simplify whoami function
> > - Define WHOAMI register value internally.
> > - Handle negative values when setting sysfs parameters.
> >
> >  drivers/iio/proximity/Kconfig  |  14 +
> >  drivers/iio/proximity/Makefile |   1 +
> >  drivers/iio/proximity/sx9360.c | 816 +++++++++++++++++++++++++++++++++
> >  3 files changed, 831 insertions(+)
> >  create mode 100644 drivers/iio/proximity/sx9360.c
> >
> Hi Gwendal,
>
> A few trivial things that I'd just have tidied up whilst applying except
> that this is dependent on the earlier series anyway so I can't apply yet.
>
> > +
> > +/*
> > + * Each entry contains the integer part (val) and the fractional part, in micro
> > + * seconds. It conforms to the IIO output IIO_VAL_INT_PLUS_MICRO.
> > + *
> > + * The frequency control register holds the period, with a ~2ms increment.
> > + * Therefore the smallest frequency is 4MHz / (2047 * 8192),
> > + * The fastest is 4MHz / 8192.
> > + * The interval is not linear, but given there is 2047 possible value,
> > + * Returns the fake increment of (Max-Min)/2047
> > + *
>
> Trivial, but this blank line doesn't add anything so please remove.
Remove some in sx_common.h as well.
>
> > + */
> > +static const struct {
> > +     int val;
> > +     int val2;
> > +} sx9360_samp_freq_interval[] = {
> > +     {0, 281250},  /* 4MHz / (8192 * 2047) */
> > +     {0, 281250},
> > +     {448, 281250},  /* 4MHz / 8192 */
> > +};
> > +
> ...
>
>
> > +static int sx9360_read_label(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
> > +                          char *label)
> > +{
> > +     return snprintf(label, PAGE_SIZE, "%s\n", sx9360_channel_labels[chan->channel]);
>
> Trivial but preference for sysfs_emit()
> (Andy noted this for the other driver in a more complex case so I did a quick
> search for repeats)
Fixed in other patches as well.
>
> > +}
> > +
>
>
> ...
>
> > +
> > +static const struct dev_pm_ops sx9360_pm_ops = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(sx9360_suspend, sx9360_resume)
> > +};
>
> static SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
Fix in sx9310/24 and 60 driver as well.
>
>
