Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E55A37B613
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhELGaC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 02:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhELGaC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 02:30:02 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BECC06174A
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 23:28:53 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x188so5862398vsx.12
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 23:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UwPaiMvT71jZjZxQi+bCQNJCogOTLRNHtxmsH4BW50=;
        b=d7RU5qCrJDkEmIQMPHye1G5TVdNusfGm+NTUX5fTO4/eJOtrKm4FvEy+/5f94acZyl
         IuIdA/BinCUwI0yZUpfGK1vzwW1P7K4I4xMVqdf6iHuh97Jgn/mQ/TKVDZ3OBeyAJ32f
         g/rhQijVOHTYqFy2et4D1inpQO/415khcRiAWo+pxnUG3wtEMi3vmD2Fiwx7Ip77IHOn
         /X2K3X4ouu+cV27gxCg1ySUFMxsVTiuDZ0tO1T7oj5Onl7fVpoKCsVuzAkYn/tF/S3ii
         DQDYTv/kJGNpHFZNWAfctmz80ByQgXxzAjUAfQG5y+KMsGroeFkY4/T8H4JDFp0hg1Ga
         2H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UwPaiMvT71jZjZxQi+bCQNJCogOTLRNHtxmsH4BW50=;
        b=XhcM2Eunz0YZYqYvajH6ff46GX+7NJvlH0/DFc0e3qsQE0yr/2fcvyahGAnC/xjr6Y
         8muj14MH5bd7rbWp16GLy+oG1MDMAM3wlDA9aVoqpL4Sd03E4mIoEHvIYR9GXHA73FLu
         8G1JiX6Qvleaf8pvPW2ru40/oWa/89jQ4T2h0Y6IYzCU5o3h9fs1CNtRsYKlyvrvvSVZ
         lAOMeCJcmGf3NBBANLrVPDtV0nEAB8pevfojtQ9eXER0qb477BPVYrfGQ0lKHgIUjNEB
         7MxYM+llwoIsxkTKml9A0jpM8044R4XE/3kbmYFkdaEvq1JrKPQEo+Z5jmIFSCpWg7Fa
         mZLQ==
X-Gm-Message-State: AOAM530EhA1oosi/+LMcM1/z6eHda+gnqp0o2C1v2C1ixMLHIgsApWfS
        OW7Becywoal6NBjH4m4uZvEQ/USikrwfDQLZ9Ay+jw==
X-Google-Smtp-Source: ABdhPJxETzUBunSy7yLPByflWEIZ1igjsdrbkBYLFIdko5atRxzG9ECM7P7kgvmTAvzYG75JZq6WnS4SM0uOEIUWB6Y=
X-Received: by 2002:a67:db91:: with SMTP id f17mr30048675vsk.47.1620800932800;
 Tue, 11 May 2021 23:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210511071831.576145-1-aardelean@deviqon.com>
 <20210511071831.576145-5-aardelean@deviqon.com> <20210511151323.30832207@jic23-huawei>
In-Reply-To: <20210511151323.30832207@jic23-huawei>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Wed, 12 May 2021 09:28:41 +0300
Message-ID: <CAASAkobRBr9i+Jz3d7AMk9SDyHP-nOn413-ZjBX3nmQ5jSZQ-A@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] iio: adc: ad7192: handle zero Avdd regulator
 value as error
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        alexandru.tachici@analog.com, linux@deviqon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 at 17:12, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 11 May 2021 10:18:23 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> > This change fixes a corner-case, where the returned voltage is actually
> > zero. This is also what patch ab0afa65bbc7 ("staging: iio: adc: ad7192:
> > fail probe on get_voltage") was trying to do.
> >
> > But as Jonathan pointed out, a zero-value would signal that the probe has
> > succeeded, putting the driver is a semi-initialized state.
> >
> > Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
> > Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
>
> Given that voltage_uv == 1 would result in a situation no worse than
> for voltage_uv == 0 perhaps we should just change the following condition to
>
> if (voltage_uv >= 0)  ?

hmmm, you're right;
i think had some narrow vision about this;

will send a v3

>
> Jonathan
>
> > ---
> >  drivers/iio/adc/ad7192.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index d3be67aa0522..79df54e0dc96 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -950,6 +950,11 @@ static int ad7192_probe(struct spi_device *spi)
> >       }
> >
> >       voltage_uv = regulator_get_voltage(st->avdd);
> > +     if (voltage_uv == 0) {
> > +             ret = -EINVAL;
> > +             dev_err(&spi->dev, "Zero value provided for AVdd supply\n");
> > +             goto error_disable_avdd;
> > +     }
> >
> >       if (voltage_uv > 0) {
> >               st->int_vref_mv = voltage_uv / 1000;
>
