Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B835133227D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCIKAu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 05:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCIKA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 05:00:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C04C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 02:00:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id i14so619225pjz.4
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNo2d4AFzTjubvXS7+flHoTfVVSZq52F4jlYUQr36ZA=;
        b=mU90JIEQVYXczrTdoaszHn8QclIeXTEKH16PiaSz6V39z7WdvTj/f9GE7ZIZA6MRIz
         Cyu1fxNytQBrOFZ3OXPD8suocUanUxJ5gg5fjzkufqIWA2qrcnrJZgxa/RNBAKyszuXg
         lwxv7is9vunwNZ9UsHknqA0Dxzbxp3rUfLg1nUWLjFZbXczY9IuhIN8BdkZDT6Clcvjr
         1AnYarb8Ow/5C74E5SwCDmNu8RDCICGVke8vVxZdIhhw7tJzxaZ3ZdpnKa82DkKbL1xD
         C4J3XaHoA/Tz9/oklD+dIYTJQhm18JyHiPMZ/ipZ9g4NtDhanW53PgfD2I9oyPvt+NMq
         8FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNo2d4AFzTjubvXS7+flHoTfVVSZq52F4jlYUQr36ZA=;
        b=ESMimk2a8qXMHexvM6wD4toUnySqohO610AIBzqlAcFmEdlGH5pRdP5fkD7BoGyAvS
         vtRYa/vr+7Fsx9kZmqifvCpeAI7gGHTPK6x5NMOZvPagLVg+MZrX3xTixwj25RDwwfBp
         anz92u5NptAskx6ttLFVuqdMKZv/xWeIKHaUCAVJ2aps1HNgWbAIlfCF8r4ENz6crcco
         iRJbuw5dt4TVETatnUDwAdRZ/4487Z0GD8zmjxiRHKryuy0N0gntD0DBcv3ZX5WHU8pY
         EV2Npm158gfb+ZJ2Zv2Xs6zbJ6JaRD/Iz1BPVTd6qrKUHmZ5M/x8FfJYV709CA8Z5TSl
         /WtQ==
X-Gm-Message-State: AOAM5334PAvqvn5V9FmmmAK+5J+Mjiytvl5ccPC7mOMsjKyeBKeaMba4
        rVTBHjxth2jjoHhwSBNMTP4+w79Ju8wyOu7BRu5GzqBzZG0FAw==
X-Google-Smtp-Source: ABdhPJxRW5Ls5wkeBjIVECOiFbg4wW3JQi6QTUP3PtL0yvkAw2rfbEj5trzKwsQnfl06OhLgDlWt6qsGWd+lIeoB9GY=
X-Received: by 2002:a17:902:70c7:b029:e3:71cf:33d2 with SMTP id
 l7-20020a17090270c7b02900e371cf33d2mr25177420plt.21.1615284027222; Tue, 09
 Mar 2021 02:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20210309011816.2024099-1-gwendal@chromium.org> <20210309011816.2024099-2-gwendal@chromium.org>
In-Reply-To: <20210309011816.2024099-2-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 12:00:11 +0200
Message-ID: <CAHp75VeH36QdbU=CQ6KXZK=AHbS5AzSfowAMOCMenO+e+U0zZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iio: set default trig->dev.parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 3:18 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> When allocated with [devm_]iio_trigger_alloc(), set trig device parent to
> the device the trigger is allocated for by default.
>
> It can always be reassigned in the probe routine.
>
> Change iio_trigger_alloc() API to add the device pointer to be coherent
> with devm_iio_trigger_alloc, using similar interface to
> iio_device_alloc().

Few nit-picks below.

...

> +static __printf(2, 0)
> +struct iio_trigger *viio_trigger_alloc(struct device *parent,

> +                                      const char *fmt,
> +                                      va_list vargs)

Can be one line.

...

> +/**
> + * iio_trigger_alloc - Allocate a trigger
> + * @parent:            Device to allocate iio_trigger for

> + * @fmt:               trigger name format. If it includes format
> + *                     specifiers, the additional arguments following
> + *                     format are formatted and inserted in the resulting
> + *                     string replacing their respective specifiers.

Strange indentation (Everything after the first period should go into
the main description section). Also inconsistency with capital letters
at the beginning of field description.
Yes I have noticed that it's in the original code, but we may do
better, don't we?

> + * RETURNS:
> + * Pointer to allocated iio_trigger on success, NULL on failure.
> + */

...

> +struct iio_trigger *iio_trigger_alloc(struct device *parent,
> +                                     const char *fmt, ...)

One line?

...

> +struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
>                                            const char *fmt, ...);

One line?

...

> +__printf(2, 3) struct iio_trigger *iio_trigger_alloc(struct device *parent,
> +                                                    const char *fmt, ...);

Perhaps leave __printf() on the first line and keep everything else on
the second one?

-- 
With Best Regards,
Andy Shevchenko
