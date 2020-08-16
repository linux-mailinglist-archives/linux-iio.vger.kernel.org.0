Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73424566D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgHPHRp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgHPHRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 03:17:44 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70633C061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 00:17:44 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so14690623iob.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXYVoRV6/wwhwUrbNsrq/kQI+zWJF1Efm0rdp9INwX0=;
        b=ANvM6qBNto6adqqRcruQRrN4Y9ZGVMFhSEYa/VG34PREzj+MYLuzUehJajefAM/UPA
         xk+HrsfzsyuJ76v18CYMM8waiicFq1B0jOEtRovc6LSf9gIWYNLCQoW6a3PV1IxdqIty
         m6LwMDO2hfc6mOe+/wfFE7hvPo3bDYMM+2VAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXYVoRV6/wwhwUrbNsrq/kQI+zWJF1Efm0rdp9INwX0=;
        b=spI7jQfJCQbnjpl0ied9kOcA1japumzfyN2n7+gE9oQZkGNmuPqzl61LNBwZ0Q1uMe
         4QXyOO/S1Tt9Vo1i2sSOzHOTnD4jtfPHgNavNfLtCaHGSrRH6i0eZIt/RxlE8TGsyhiV
         8aoOjFG4S0i3117sKjTaCeM7PXyPT79NX6+5mCXjNFCAagd8uVJYkU8t4SmP42qjuhpr
         jQAEqL5GkfXVKMplG8ZsqEgu0//Id7+8MBUvxNaxq8c8oBNGdJtMj4OSsbPzkaLWbxJC
         f0+szQQQ9neOebjWNTzdgn/uiYKs0MxFujf5aHziOezrw7D/qr3A4xPT9F9cAuIgWQsa
         keGQ==
X-Gm-Message-State: AOAM531HFvjdwBXYyBprmZrDKZoSYqsOgUTh1Zbezje/fXV5m9ckfNiW
        HMyPHvKHIBxettjhZZLtfVn0mSUkqF3E+YJR7PfrrcGKq9upMw==
X-Google-Smtp-Source: ABdhPJzzG2jY/Ss20cxJR8s1lmMhnyErN876TVQijpXhzEZLkzCKqtJygvZEzAm8rYMz4LPOUyl+yODMtsGDcHScMto=
X-Received: by 2002:a05:6638:2595:: with SMTP id s21mr9437816jat.12.1597562263685;
 Sun, 16 Aug 2020 00:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200816071540.31897-1-matt.ranostay@konsulko.com> <20200816071540.31897-3-matt.ranostay@konsulko.com>
In-Reply-To: <20200816071540.31897-3-matt.ranostay@konsulko.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 16 Aug 2020 00:17:32 -0700
Message-ID: <CAJCx=g=dap0EuSpuop+V=SWrmyGvcn+SpTRH2pbxu166T6fXQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: chemical: atlas-ezo-sensor: add humidity sensor support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 16, 2020 at 12:15 AM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> Add support for atlas,hum-ezo / humidity sensor which with scaling
> provides respective data in millipercent
>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-ezo-sensor.c | 37 ++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index 60a0c752fbc5..bb9b36b12a86 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -17,10 +17,12 @@
>
>  #define ATLAS_EZO_DRV_NAME             "atlas-ezo-sensor"
>  #define ATLAS_INT_TIME_IN_MS           950
> +#define ATLAS_INT_HUM_TIME_IN_MS       350
>
>  enum {
>         ATLAS_CO2_EZO,
>         ATLAS_O2_EZO,
> +       ATLAS_HUM_EZO,
>  };
>
>  struct atlas_ezo_device {
> @@ -63,6 +65,21 @@ static const struct iio_chan_spec atlas_o2_ezo_channels[] = {
>         ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_O2),
>  };
>
> +static const struct iio_chan_spec atlas_hum_ezo_channels[] = {
> +       {
> +               .type = IIO_CONCENTRATION,\

*sigh* shouldn't submit these late at night. wrong type :/

Will fix in v2 tomorrow.

- Matt


> +               .info_mask_separate =
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .scan_index = 0,
> +               .scan_type =  {
> +                       .sign = 'u',
> +                       .realbits = 32,
> +                       .storagebits = 32,
> +                       .endianness = IIO_CPU,
> +               },
> +       },
> +};
> +
>  static struct atlas_ezo_device atlas_ezo_devices[] = {
>         [ATLAS_CO2_EZO] = {
>                 .channels = atlas_co2_ezo_channels,
> @@ -73,7 +90,12 @@ static struct atlas_ezo_device atlas_ezo_devices[] = {
>                 .channels = atlas_o2_ezo_channels,
>                 .num_channels = 1,
>                 .delay = ATLAS_INT_TIME_IN_MS,
> -       }
> +       },
> +       [ATLAS_HUM_EZO] = {
> +               .channels = atlas_hum_ezo_channels,
> +               .num_channels = 1,
> +               .delay = ATLAS_INT_HUM_TIME_IN_MS,
> +       },
>  };
>
>  static void atlas_ezo_sanitize(char *buf)
> @@ -131,6 +153,17 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>                 return ret ? ret : IIO_VAL_INT;
>         }
>         case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_HUMIDITYRELATIVE:
> +                       *val = 1000;
> +                       return IIO_VAL_INT;
> +               case IIO_CONCENTRATION:
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +
> +               /* IIO_CONCENTRATION modifiers */
>                 switch (chan->channel2) {
>                 case IIO_MOD_CO2:
>                         *val = 0;
> @@ -153,6 +186,7 @@ static const struct iio_info atlas_info = {
>  static const struct i2c_device_id atlas_ezo_id[] = {
>         { "atlas-co2-ezo", ATLAS_CO2_EZO },
>         { "atlas-o2-ezo", ATLAS_O2_EZO },
> +       { "atlas-hum-ezo", ATLAS_HUM_EZO },
>         {}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
> @@ -160,6 +194,7 @@ MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
>  static const struct of_device_id atlas_ezo_dt_ids[] = {
>         { .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
>         { .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
> +       { .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
> --
> 2.27.0
>
