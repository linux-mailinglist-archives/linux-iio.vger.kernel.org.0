Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9478332F22
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCIThn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhCIThi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:37:38 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E2CC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:37:38 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id a7so15190363iok.12
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRR7CvmF+/vXr5N7Hmmcgo1glaUM3nFjvNyqVKp/Hfk=;
        b=EPzSOn94u7NRT1/xFFyKIBquT4MMfgab8BwQ965Ywt8MriDc8hLL4+ndzqn0hg6zsU
         e+ROE2GkSLvuMbN9kbaVc38xOd1crocGZr5PatmMLDW11hq5sJxxky1+0jmqjDWNOVDL
         n0zoAyTFJBBHTuwLQWRzQ50+Ws8yARDnSCu0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRR7CvmF+/vXr5N7Hmmcgo1glaUM3nFjvNyqVKp/Hfk=;
        b=d7k7ojMmxg7kHLkRFTcuz3bUc1WvNmD40e10RlymbcbfRb2JmwJkxO6B8ZHhWN0A2m
         7fUACgtu2InPhK20zFgLjuaL3OUmhhgZ4tsywp3RNzwfUoJawMiLDpDHIZnTub0t7RC0
         wQtoii5+qruaN8eIOyjphlR1XOKcKFSwrlKOdvcSksOm8L3L2jcSx3c0Mo5OdTabZmHI
         ugNuh5f4sKfV/EqGBedj6VaSMZytsPrOKp4Ufk2oYHgWYR7NIcYERIoh9jF1kYKJUH+m
         DIJECf0d2okb9qzCVhujCf5ndej6zsxQ7XsOmKc4hY336gy9WGCUpcxUujFxRC0vbMaN
         2Waw==
X-Gm-Message-State: AOAM532VttenshOITAPQArFP9sK4Kxh5JOvE+F5wjAfKbpWjkeCMIa8U
        7t8BfL54ZitotF8BynVR9zU6PXvG+SI+SUDVHH8GqgN+XTI=
X-Google-Smtp-Source: ABdhPJwUIMINP2rX/M6lazJcTDErHLjP9ZbanOtLx9stl4AFmj7WJydxXeTJFZ4Xm3zylsB2hzcEPhCtbRlWzkXIwWY=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr23597092ioh.92.1615318657896;
 Tue, 09 Mar 2021 11:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20210309011816.2024099-1-gwendal@chromium.org>
 <20210309011816.2024099-2-gwendal@chromium.org> <CAHp75VeH36QdbU=CQ6KXZK=AHbS5AzSfowAMOCMenO+e+U0zZg@mail.gmail.com>
In-Reply-To: <CAHp75VeH36QdbU=CQ6KXZK=AHbS5AzSfowAMOCMenO+e+U0zZg@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 9 Mar 2021 11:37:27 -0800
Message-ID: <CAPUE2usUJ2vteXUTXKB0TUgiTeEmfGXxYusQP71UsyrbpybMww@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iio: set default trig->dev.parent
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 2:00 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Mar 9, 2021 at 3:18 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > When allocated with [devm_]iio_trigger_alloc(), set trig device parent to
> > the device the trigger is allocated for by default.
> >
> > It can always be reassigned in the probe routine.
> >
> > Change iio_trigger_alloc() API to add the device pointer to be coherent
> > with devm_iio_trigger_alloc, using similar interface to
> > iio_device_alloc().
>
> Few nit-picks below.
>
> ...
>
> > +static __printf(2, 0)
> > +struct iio_trigger *viio_trigger_alloc(struct device *parent,
>
> > +                                      const char *fmt,
> > +                                      va_list vargs)
>
> Can be one line.
Looking at the rest of the file, when arguments span on multiple
lines, there is only one argument per line: see iio_trigger_read_name
or iio_alloc_pollfunc.
>
> ...
>
> > +/**
> > + * iio_trigger_alloc - Allocate a trigger
> > + * @parent:            Device to allocate iio_trigger for
>
> > + * @fmt:               trigger name format. If it includes format
> > + *                     specifiers, the additional arguments following
> > + *                     format are formatted and inserted in the resulting
> > + *                     string replacing their respective specifiers.
>
> Strange indentation (Everything after the first period should go into
> the main description section). Also inconsistency with capital letters
> at the beginning of field description.
> Yes I have noticed that it's in the original code, but we may do
> better, don't we?
>
> > + * RETURNS:
> > + * Pointer to allocated iio_trigger on success, NULL on failure.
> > + */
>
> ...
>
> > +struct iio_trigger *iio_trigger_alloc(struct device *parent,
> > +                                     const char *fmt, ...)
>
> One line?
Done. Line is over 80 characters, but up to 100 character is now
allowed by checkpatch.pl.
>
> ...
>
> > +struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
> >                                            const char *fmt, ...);
>
> One line?
Done
>
> ...
>
> > +__printf(2, 3) struct iio_trigger *iio_trigger_alloc(struct device *parent,
> > +                                                    const char *fmt, ...);
>
> Perhaps leave __printf() on the first line and keep everything else on
> the second one?
Done, use the same format as devm_iio_trigger_alloc.

>
> --
> With Best Regards,
> Andy Shevchenko
