Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62A38253E
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhEQHYE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhEQHYE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:24:04 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2AC061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:22:45 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a12so1796955uak.6
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9ZK/1wCBWnKyzlF7S3efpJYdiabsjD9dAFNKHjyiBk=;
        b=q1g0lKkhbGg6rQbot+npZknubZulGSjEAcBbEvmYVVPaTnriBv2JRunifK3loFuUrR
         spMT8pXvS4862ELczF2hskBBCeTg6ICeiNK0EnjnJDRWJiJh0i2up56QNLMEEKJjHU01
         RlQdpNq3qhdZT58HwaIWNwIA+0cmmZGKZjcze1rqPPo/us77oBDIHcO/jjM/GZli/TPa
         +qYXB1GEnleeSF0X5G9SG7BUIWvfzgmZgdbbcLJ8fVMRDOyn22oYgPG02fj8LnEu0xzG
         a9pFY4HNSURG2WshggyM/grNRxvjpIBb6VF8m5onkmL5DspjzLLYiPSK0JLxjzr4YpIo
         iabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9ZK/1wCBWnKyzlF7S3efpJYdiabsjD9dAFNKHjyiBk=;
        b=Xgvjfie0qQIN68eDQirVFsVW6BqHKag+0odRTDCjqf6PvRCuSZ78ql+bzGuJ95EwrY
         R8AjWjgZCxksC3hbJhrFee1iY639y2pmnmXTGMJNu0de3HzYjrL/koxwyjXmr5MjbDYI
         r+fn+wPZt30s+R13zwrXp/eqha6GR/3jgqzDGNUydQZRXlyPP2a1URc6ZUIM6Y4agTyx
         RqzVGHgTFCcIM6ctjZH4juHywQWkj4oWgi6fJcq1mwKuEs5lUWAtPNmrGSqCCMP5Wa4x
         NOgW9LadE/2+4hOdkwd1f0hQDhnDuVdF/q/lCXkDqWS/QXoS5KUfo009FRAXYQ8TKnwv
         ay0w==
X-Gm-Message-State: AOAM5327mkFop/nVN4rrOwQY2vVS9YaPrPqrpA5txjemMDSjUlO3yyEU
        JWOuPe+lKjUUFcA5X21m2Q3NVxsV25xa/MmwSDyOkccoP7YqqB94BC4=
X-Google-Smtp-Source: ABdhPJwYm84Mm0tJaWF7VOP83acIayxWp4CjfGBPiUCgJjTvwL6yA0cVBEw+tamYwbW6WzgoeLH6MPlOy+QLyLesPg8=
X-Received: by 2002:ab0:36b4:: with SMTP id v20mr5423983uat.67.1621236164994;
 Mon, 17 May 2021 00:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-3-jic23@kernel.org>
 <CAASAkoaYcAG8-s5kfd68Hi2m7+JCWhh0gd5yrMN0vO1cESy+uA@mail.gmail.com>
In-Reply-To: <CAASAkoaYcAG8-s5kfd68Hi2m7+JCWhh0gd5yrMN0vO1cESy+uA@mail.gmail.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:22:34 +0300
Message-ID: <CAASAkob-bmVxREd+5QrOJ+My36AcxDscxu_39kS7OqJy9FhoZQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: adc: max11100: Use devm_ functions for rest of probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 May 2021 at 10:08, Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > By using devm_add_action_or_reset() to manage the regulator disable,
> > it becomes simple to use managed functions for all of remove.
> > This simplifies error handling and allows us to drop the remove()
> > function entirely.
> >
>

Apologies to come back on this.
But "spi_set_drvdata(spi, indio_dev);"  can be removed in this patch.
And while at it, the "state->vref_reg" parameter can be indented a bit.

> Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jacopo Mondi <jacopo@jmondi.org>
> > ---
> >  drivers/iio/adc/max11100.c | 29 +++++++++--------------------
> >  1 file changed, 9 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> > index 69d607fa17aa..9951f6a6a4b9 100644
> > --- a/drivers/iio/adc/max11100.c
> > +++ b/drivers/iio/adc/max11100.c
> > @@ -102,6 +102,11 @@ static const struct iio_info max11100_info = {
> >         .read_raw = max11100_read_raw,
> >  };
> >
> > +static void max11100_regulator_disable(void *reg)
> > +{
> > +       regulator_disable(reg);
> > +}
> > +
> >  static int max11100_probe(struct spi_device *spi)
> >  {
> >         int ret;
> > @@ -131,27 +136,12 @@ static int max11100_probe(struct spi_device *spi)
> >         if (ret)
> >                 return ret;
> >
> > -       ret = iio_device_register(indio_dev);
> > +       ret = devm_add_action_or_reset(&spi->dev, max11100_regulator_disable,
> > +                               state->vref_reg);
> >         if (ret)
> > -               goto disable_regulator;
> > -
> > -       return 0;
> > -
> > -disable_regulator:
> > -       regulator_disable(state->vref_reg);
> > -
> > -       return ret;
> > -}
> > -
> > -static int max11100_remove(struct spi_device *spi)
> > -{
> > -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > -       struct max11100_state *state = iio_priv(indio_dev);
> > -
> > -       iio_device_unregister(indio_dev);
> > -       regulator_disable(state->vref_reg);
> > +               return ret;
> >
> > -       return 0;
> > +       return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> >
> >  static const struct of_device_id max11100_ids[] = {
> > @@ -166,7 +156,6 @@ static struct spi_driver max11100_driver = {
> >                 .of_match_table = max11100_ids,
> >         },
> >         .probe          = max11100_probe,
> > -       .remove         = max11100_remove,
> >  };
> >
> >  module_spi_driver(max11100_driver);
> > --
> > 2.31.1
> >
