Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19144231155
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbgG1SKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgG1SKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:10:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E29C061794;
        Tue, 28 Jul 2020 11:10:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so12409643pgk.4;
        Tue, 28 Jul 2020 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS7ZbHNshUjvgFM/SjL19KD5bg30KRk+6drMh/R8Qvc=;
        b=Nj5nGKliBkt2r5LxIDuZhQ3VSk1ull6u3yjoCPlQgS7MHu42EU8DXAm8mcyjdNFEeq
         FNCCFwcs7byBLvpB4bGclG67ZB27/TKrlOazVZNaN8HhU1vB/VVAfuyHoig4HA0ISb76
         QmHf33mEDBbuQt9N0mbZ6EK7+A1WKPLo4/wMyHoobE679tSQATykWX3cgVSkbcby8ydq
         SZoeGbkNe7IfVVE8BnD6UvvGEUpi1/fNJPUdA8snL78rcSArwoBHtdtzdwdzAhttw1Wq
         lSncskQhCY9eb7UnEfm79lnjEncHNM+3+J+77qfQhXgfE7/gbhVpeL3VApcTBflabg6H
         svVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS7ZbHNshUjvgFM/SjL19KD5bg30KRk+6drMh/R8Qvc=;
        b=TTvjMgGwvqEhds7QpeICwV48uFtdJ60S52KDl80hIFej2dfcsLsWsbpbJETgkc6yFD
         cHEBWLCr5Lh0Tpm0foMoDCquvFRBfkYxbAB3UlM/1CYYmaPtEFRqLsSiPv+ydCOdaJUu
         7maOcNVIsI0Xnr8wwp3bI8o7JuM+HYhqF9ZxhXnHhhRgWHQfz/6KJyfj9l64iLpPlbwl
         NSyGd/dTpb7PRAKNBAfR5LmO6TmfciqtIBWeUK8AzpWMJMB51kE094xFXk3CJ0lcdift
         MnfmtMGTo1ARN9o6FHs53HOQl0LXs7gEbrj9xPWF6CWD5l78X1Cu5UowlgtqkSY98ZLm
         wA/w==
X-Gm-Message-State: AOAM530v/4TV7xFE1/d8Q2nmxf6u2l2dDOHac61x/hC+2kN1+eeBuKva
        ds+4o2PfJyXFTONXHYbVSgGTSUnwB14ik1S6rrE=
X-Google-Smtp-Source: ABdhPJwobv21t9hAadKQdwFWF7tOno4lqInStFN/DGlkxSkMkl+nKlookv7UkfbF50XGFcQ3srK73HIQW/Lu5PZC1Y0=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr12350334pfc.130.1595959835199;
 Tue, 28 Jul 2020 11:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.5.I0ea31fe183b99838b28213df05b0e7912db3ba29@changeid>
In-Reply-To: <20200728091057.5.I0ea31fe183b99838b28213df05b0e7912db3ba29@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:10:18 +0300
Message-ID: <CAHp75VfYuXzUipa9+NPgWNeP5MCYq7OdNQKQvPcnrKw+V7+Ekw@mail.gmail.com>
Subject: Re: [PATCH 05/15] iio: sx9310: Change from .probe to .probe_new
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:15 PM Daniel Campello <campello@chromium.org> wrote:
>
> Uses .probe_new in place of .probe. Also uses device_get_match_data()
> for whoami matching.

Good one!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/iio/proximity/sx9310.c | 37 ++++++++++++----------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 0fb88ad66f7342..de52afd7c13333 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -138,7 +138,7 @@ struct sx9310_data {
>         struct completion completion;
>         unsigned int chan_read, chan_event;
>         int channel_users[SX9310_NUM_CHANNELS];
> -       int whoami;
> +       unsigned int whoami;
>  };
>
>  static const struct iio_event_spec sx9310_events[] = {
> @@ -859,24 +859,15 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>
>  static int sx9310_set_indio_dev_name(struct device *dev,
>                                      struct iio_dev *indio_dev,
> -                                    const struct i2c_device_id *id, int whoami)
> +                                    unsigned int whoami)
>  {
> -       const struct acpi_device_id *acpi_id;
> -
> -       /* id will be NULL when enumerated via ACPI */
> -       if (id) {
> -               if (id->driver_data != whoami)
> -                       dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
> -                               id->name);
> -       } else if (ACPI_HANDLE(dev)) {
> -               acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -               if (!acpi_id)
> -                       return -ENODEV;
> -               if (acpi_id->driver_data != whoami)
> -                       dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
> -                               acpi_id->id);
> -       } else
> +       unsigned int long ddata;
> +
> +       ddata = (uintptr_t)device_get_match_data(dev);
> +       if (ddata != whoami) {
> +               dev_err(dev, "WHOAMI does not match device data: %u", whoami);
>                 return -ENODEV;
> +       }
>
>         switch (whoami) {
>         case SX9310_WHOAMI_VALUE:
> @@ -893,8 +884,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>         return 0;
>  }
>
> -static int sx9310_probe(struct i2c_client *client,
> -                       const struct i2c_device_id *id)
> +static int sx9310_probe(struct i2c_client *client)
>  {
>         int ret;
>         struct iio_dev *indio_dev;
> @@ -920,8 +910,7 @@ static int sx9310_probe(struct i2c_client *client,
>                 return ret;
>         }
>
> -       ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
> -                                       data->whoami);
> +       ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
>         if (ret < 0)
>                 return ret;
>
> @@ -1034,8 +1023,8 @@ static const struct acpi_device_id sx9310_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
>
>  static const struct of_device_id sx9310_of_match[] = {
> -       { .compatible = "semtech,sx9310" },
> -       { .compatible = "semtech,sx9311" },
> +       { .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
> +       { .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, sx9310_of_match);
> @@ -1054,7 +1043,7 @@ static struct i2c_driver sx9310_driver = {
>                 .of_match_table = sx9310_of_match,
>                 .pm = &sx9310_pm_ops,
>         },
> -       .probe          = sx9310_probe,
> +       .probe_new      = sx9310_probe,
>         .id_table       = sx9310_id,
>  };
>  module_i2c_driver(sx9310_driver);
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
