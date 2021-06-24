Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32D3B2C94
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 12:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhFXKmT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXKmT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 06:42:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DEC061574;
        Thu, 24 Jun 2021 03:40:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c5so4792726pfv.8;
        Thu, 24 Jun 2021 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2nueDFN3sIUezwAZTq4ZWYAx08fjXKv4iNtaPXarDA=;
        b=mhmJm3rC5l98CLp97BJhCX6M5px6gRr0k5qBRMbEmQMmZs//HLTPQ1IAHBYs8TlzWC
         XDgyddHepQofYbWc/+LAEXMIihPPX8XQ0uoC54Kqfbg/S1thl+NkJpK1nJ3jXZSdP67D
         QXoxcD+Rc8A1izn5yZrr00MK9OASLRpLickqFT5tXH10RGq1lTYxHketHxBnH5/lTGmf
         V3bmxsmwzWZImT8+Dr2NPBKxOdP6zVQC/TYW0URB+aN93d4DplGReIVJ/3Y16PcK/izY
         yO6P8lDtmc7QCWp4Fp6RAe2dbzpeDcCs0kFLpagRSsDVZa4wgOybzyiO1qj3EZZ3P8TX
         md2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2nueDFN3sIUezwAZTq4ZWYAx08fjXKv4iNtaPXarDA=;
        b=kNg3IQxVglrbOkrXKpe530plUo7SO/8kZFinjOW5B9b3yghWTas1dN5+QS6IAjpN5Z
         BCE8Bu8j7KVErjmEPIpzpoqANH02TsWW+D7M6ywhoIqRmSTyWLPYBdQfXDSfVetLLltF
         ImYCJ6D7KbhF6Yj0d/mf9DSr84vYMGEtIImW6kC5702aucZQ8PhIx+GP2uvxLoqA6UPJ
         QuXBel3guvvjYTioMjjxlePFxEYJI7WQx95w/Wx6dYbMYVLWHFJLj4AfnBQyAo7kdNUb
         BsTfK4bk3GjM7+TaiKY9oyfyNDEguucKB67pxeofl0peKkFZZ+qWejGXSSmMmwcwZ9At
         XIFA==
X-Gm-Message-State: AOAM532Fu2NdT6g1wMNsR8X9KN3eOpsq2d9oFzcKrIVpKFHHlaXx4Glc
        I7VI/qflb+V0706rI/JBTsdDEgkfHBKQbz4gQOg=
X-Google-Smtp-Source: ABdhPJwPOnctZ3dJHDJ4KduItbbDZUCLsUq5ipRDaV8PWp32E7mzKYiwf16T6sdcPH7NzadTMdXGGcOPkeb0JF99vK8=
X-Received: by 2002:a63:fd16:: with SMTP id d22mr4168264pgh.203.1624531200201;
 Thu, 24 Jun 2021 03:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210624100046.1037159-1-nsaenzju@redhat.com>
In-Reply-To: <20210624100046.1037159-1-nsaenzju@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jun 2021 13:39:23 +0300
Message-ID: <CAHp75VcG-0L+qG5JirWH21bnpVwRv_wfjM6Sfd2pJrq4-OqJ0Q@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: Avoid using irq_work
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 24, 2021 at 1:01 PM Nicolas Saenz Julienne
<nsaenzju@redhat.com> wrote:
>
> The atlas sensor driver currently registers a threaded IRQ handler whose
> sole responsibility is to trigger an irq_work which will in turn run
> iio_trigger_poll() in IRQ context.
>
> This seems overkill given the fact that there already was a opportunity

an opportunity

> to run iio_trigger_poll() in IRQ context in the top half of the IRQ
> handler. So make use of it, ultimately avoiding a context switch, an
> IPI, and reducing latency.

...

> @@ -474,7 +465,7 @@ static irqreturn_t atlas_interrupt_handler(int irq, void *private)
>         struct iio_dev *indio_dev = private;
>         struct atlas_data *data = iio_priv(indio_dev);
>
> -       irq_work_queue(&data->work);
> +       iio_trigger_poll(data->trig);

Have you considered dropping atlas_interrupt_trigger_ops() altogether?

>         return IRQ_HANDLED;

...

>         if (client->irq > 0) {
>                 /* interrupt pin toggles on new conversion */
>                 ret = devm_request_threaded_irq(&client->dev, client->irq,

> -                               NULL, atlas_interrupt_handler,
> +                               atlas_interrupt_handler, NULL,

So, you move it from threaded IRQ to be a hard IRQ handler (we have a
separate call for this).
Can you guarantee that handling of those events will be fast enough?

>                                 IRQF_TRIGGER_RISING |
>                                 IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>                                 "atlas_irq",


-- 
With Best Regards,
Andy Shevchenko
