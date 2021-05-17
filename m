Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26630382572
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhEQHi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEQHi6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:38:58 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD14C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:37:42 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 66so2623999vsk.9
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sj5Np2+8inI665WoQ6AJL8HD1n2fstnINDnLTrN+dQ=;
        b=gMYgeO7Bq6xqaQWQ5A4niiSLQx9UpseKu5NevHyw4ay5/VfzPobI8j34xx2FTzgd7P
         jFfmQ0okm7rdyh1zeqrEPEP6A6wI7Al1MSpUB7X4itp1tT2QvKKpC2zLH/2bOR0W4QLE
         yleypbpfZKY+VZgRxpd5qycIkO+35t94DB5zA8Yg34I2luSa85fPqpxsvaBsW6sEch13
         GmxF5mjslCf/mJrsjlUktYNEx1Os5hxLO8P+2SPHudnpn0UyKveHA6T69x61IVczf1yw
         JGUuqMAR9aYjrnl05uXyWaJsCcNu2qzbMtKM10nmO9TWIptjdc5X2zpuUUVLYya/kD4Q
         w1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sj5Np2+8inI665WoQ6AJL8HD1n2fstnINDnLTrN+dQ=;
        b=lg6s0mCIrnQYzfU9flDMlrThDbRz3RZl7lyO5HFN6QxYC124O4tGKaZhtb5BIvRhSX
         1Gh1iL4nlpP3azMxxgcVDLSIEErdFAnHArViy3h5EDrHlUwJSYOlJw/Vk53MV3yr93z4
         cH1mdA9nnq8Ijm+TXSSdp4qUGNMTjMalfqRY3v3lv6sfSD966VxDz/bJOpen7eIq+sny
         GQbdAkNKtvGaNc1+eeG0BiukRNPSrwfAjWxDJg072bHYDtnuJC4SHwloCVjUYSeAy/Gh
         zylziY9bCTxP0SYTqn7LOcj6XCFiTfRJ+VDFdPU7Y08cV9Dv3n6WRbijNgexac22+Z38
         ZgfQ==
X-Gm-Message-State: AOAM533LTlMrc0BeajIk8BLFAdw2WfAoIdCfaCXPDrIWdRZ8T8zJT4XQ
        0cEoB/C4oIVUwXi3x34zH+peNZ7BYiCT12a2B40bNQ==
X-Google-Smtp-Source: ABdhPJz0SzkfkTr40mPF69qxxymd+LL7USqJwGop95CdeAPwUXnN0D/yYq8+mL0QJKiSM/DjCEBjgeVcP2+rZJiLvIE=
X-Received: by 2002:a67:db91:: with SMTP id f17mr50441769vsk.47.1621237062133;
 Mon, 17 May 2021 00:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-8-jic23@kernel.org>
 <CAASAkoYqGqwQcHZpSJHBZp+t_9bAZ04DSqAzM9=yHB4aaj_VWw@mail.gmail.com>
In-Reply-To: <CAASAkoYqGqwQcHZpSJHBZp+t_9bAZ04DSqAzM9=yHB4aaj_VWw@mail.gmail.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:37:31 +0300
Message-ID: <CAASAkoZxvz05Q3ep4uQH=Zh7xehZPPSRmC=y+xP18MAdsymjSw@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: adc: ti-adc108s102: Use devm managed functions
 for all of probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 May 2021 at 10:31, Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Simplifies error handling and lets us drop remove() entirely.
> >
>

// Removed Bogdan's email; it's not working;
Apologies to return on this.
This note can be disregarded, but this patch could do a direct return
for devm_iio_device_register().
It doesn't make much sense to print a failure there as that can be
also viewed via some broader kernel logging.
But it's also fine to leave it.

> Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
>
>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Bogdan Pricop <bogdan.pricop@emutex.com>
> > ---
> >  drivers/iio/adc/ti-adc108s102.c | 45 +++++++++++----------------------
> >  1 file changed, 15 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> > index 183b2245e89b..db902aef2abe 100644
> > --- a/drivers/iio/adc/ti-adc108s102.c
> > +++ b/drivers/iio/adc/ti-adc108s102.c
> > @@ -215,6 +215,11 @@ static const struct iio_info adc108s102_info = {
> >         .update_scan_mode       = &adc108s102_update_scan_mode,
> >  };
> >
> > +static void adc108s102_reg_disable(void *reg)
> > +{
> > +       regulator_disable(reg);
> > +}
> > +
> >  static int adc108s102_probe(struct spi_device *spi)
> >  {
> >         struct adc108s102_state *st;
> > @@ -239,6 +244,10 @@ static int adc108s102_probe(struct spi_device *spi)
> >                         dev_err(&spi->dev, "Cannot enable vref regulator\n");
> >                         return ret;
> >                 }
> > +               ret = devm_add_action_or_reset(&spi->dev, adc108s102_reg_disable,
> > +                                              st->reg);
> > +               if (ret)
> > +                       return ret;
> >
> >                 ret = regulator_get_voltage(st->reg);
> >                 if (ret < 0) {
> > @@ -249,7 +258,6 @@ static int adc108s102_probe(struct spi_device *spi)
> >                 st->va_millivolt = ret / 1000;
> >         }
> >
> > -       spi_set_drvdata(spi, indio_dev);
> >         st->spi = spi;
> >
> >         indio_dev->name = spi->modalias;
> > @@ -266,40 +274,18 @@ static int adc108s102_probe(struct spi_device *spi)
> >         spi_message_init_with_transfers(&st->scan_single_msg,
> >                                         &st->scan_single_xfer, 1);
> >
> > -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > -                                        &adc108s102_trigger_handler, NULL);
> > +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> > +                                             &adc108s102_trigger_handler,
> > +                                             NULL);
> >         if (ret)
> > -               goto error_disable_reg;
> > +               return ret;
> >
> > -       ret = iio_device_register(indio_dev);
> > -       if (ret) {
> > +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> > +       if (ret)
> >                 dev_err(&spi->dev, "Failed to register IIO device\n");
> > -               goto error_cleanup_triggered_buffer;
> > -       }
> > -       return 0;
> > -
> > -error_cleanup_triggered_buffer:
> > -       iio_triggered_buffer_cleanup(indio_dev);
> > -
> > -error_disable_reg:
> > -       regulator_disable(st->reg);
> > -
> >         return ret;
> >  }
> >
> > -static int adc108s102_remove(struct spi_device *spi)
> > -{
> > -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > -       struct adc108s102_state *st = iio_priv(indio_dev);
> > -
> > -       iio_device_unregister(indio_dev);
> > -       iio_triggered_buffer_cleanup(indio_dev);
> > -
> > -       regulator_disable(st->reg);
> > -
> > -       return 0;
> > -}
> > -
> >  static const struct of_device_id adc108s102_of_match[] = {
> >         { .compatible = "ti,adc108s102" },
> >         { }
> > @@ -327,7 +313,6 @@ static struct spi_driver adc108s102_driver = {
> >                 .acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
> >         },
> >         .probe          = adc108s102_probe,
> > -       .remove         = adc108s102_remove,
> >         .id_table       = adc108s102_id,
> >  };
> >  module_spi_driver(adc108s102_driver);
> > --
> > 2.31.1
> >
