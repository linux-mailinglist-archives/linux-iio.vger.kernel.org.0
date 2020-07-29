Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1923170A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 03:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgG2BDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 21:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgG2BDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 21:03:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F12C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 18:03:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so13321858pgv.9
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 18:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=bWQ5cNwAp1U8fuRjdwC2moXHDAbmr4xMaXTHz6nTZ1A=;
        b=BY7xswnqLwkaPjFKiGdpVGKtY1qOlCnsnq+JyFAikf6g9r4CYQNY2tSvWu8W7CyWsH
         kw19tbZkT4y/kCuXJjHoXsLYemXyrxN2dwkSegMb+9erv4b7KUivTEm1rtPQ3GF3jV3w
         vbekATMTMm4g2wXVfhwizPGnWy7LHo+XeFzRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=bWQ5cNwAp1U8fuRjdwC2moXHDAbmr4xMaXTHz6nTZ1A=;
        b=rfCmPl5LnlCXz3eHH770cAwxb50aDQhySDU5YRW03hA+rA/tny8fFz7FMwcOGt6Xtr
         kInXwZZbFXGKHFOdzVq9+AosvQ8aeJ5gb1ddN/oO3/VXCs+CPDB6pFARmozPCHs19AIV
         ohSKVZ1MpiQ8AhKEaKYSDUaN9Mi0sRIwECjN+kHnB1N7craI/vGnrPLxRzo2MP3q0yCf
         wh6dlIedGA8MvEPfFs992LCIC2k/MacKUQuZV/2NXklgT5MW+eXPgLIM/B/3XMYGAAw4
         A2x9NwXmTYIjsq6JFjvYrvsulFD9tafK6W1DouHyFfic6dkB1dQSjn/nXTs+qSRY3N8T
         tf1Q==
X-Gm-Message-State: AOAM53249BBgFn1Uz6OHO/vpO/lEiZ9CCJDTbDobEE3jwBweSxZ6kiNA
        /o69cgDCfnoxdjThyN9xVOCi/Q==
X-Google-Smtp-Source: ABdhPJxjz4++FkngpE03Ru2RmLgubdO6Te1eOvdKzggkzhIW+sZIXZmxlO3XsxCvB3jU2MjoxnrkAw==
X-Received: by 2002:a65:4b85:: with SMTP id t5mr26492451pgq.36.1595984614727;
        Tue, 28 Jul 2020 18:03:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k2sm251817pgm.11.2020.07.28.18.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:03:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728170317.v2.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
Subject: Re: [PATCH v2 07/14] iio: sx9310: Use long instead of int for channel bitmaps
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 18:03:32 -0700
Message-ID: <159598461271.1360974.15436404116157938506@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:13)
> Uses for_each_set_bit() macro to loop over channel bitmaps.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>=20
> Changes in v2:
>  - Changed prox_stat to chan_prox_stat bitmap.
>=20
>  drivers/iio/proximity/sx9310.c | 38 ++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 75e85dcd6b3572..1f04ab8507ec62 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -130,14 +130,15 @@ struct sx9310_data {
>          * Last reading of the proximity status for each channel.
>          * We only send an event to user space when this changes.
>          */
> -       bool prox_stat[SX9310_NUM_CHANNELS];
> +       unsigned long chan_prox_stat;

This can be DECLARE_BITMAP(chan_prox_stat, SX9310_NUM_CHANNELS)

>         bool trigger_enabled;
>         /* 64-bit data + 64-bit timestamp buffer */
>         __be16 buffer[SX9310_NUM_CHANNELS + 4] __aligned(8);
>         /* Remember enabled channels and sample rate during suspend. */
>         unsigned int suspend_ctrl0;
>         struct completion completion;
> -       unsigned int chan_read, chan_event;
> +       unsigned long chan_read;
> +       unsigned long chan_event;

Same for these?

>         int channel_users[SX9310_NUM_CHANNELS];
>         unsigned int whoami;
>  };
> @@ -280,15 +281,16 @@ static const struct regmap_config sx9310_regmap_con=
fig =3D {
>  };
> =20
>  static int sx9310_update_chan_en(struct sx9310_data *data,
> -                                unsigned int chan_read,
> -                                unsigned int chan_event)
> +                                unsigned long chan_read,
> +                                unsigned long chan_event)
>  {
>         int ret;
> +       unsigned long channels =3D chan_read | chan_event;
> =20
> -       if ((data->chan_read | data->chan_event) !=3D (chan_read | chan_e=
vent)) {
> +       if ((data->chan_read | data->chan_event) !=3D channels) {
>                 ret =3D regmap_update_bits(data->regmap, SX9310_REG_PROX_=
CTRL0,
>                                          SX9310_REG_PROX_CTRL0_SENSOREN_M=
ASK,
> -                                        chan_read | chan_event);
> +                                        channels);
>                 if (ret)
>                         return ret;
>         }
> @@ -531,6 +533,7 @@ static void sx9310_push_events(struct iio_dev *indio_=
dev)
>         unsigned int val, chan;
>         struct sx9310_data *data =3D iio_priv(indio_dev);
>         s64 timestamp =3D iio_get_time_ns(indio_dev);
> +       unsigned long prox_changed;
> =20
>         /* Read proximity state on all channels */
>         ret =3D regmap_read(data->regmap, SX9310_REG_STAT0, &val);
> @@ -539,24 +542,23 @@ static void sx9310_push_events(struct iio_dev *indi=
o_dev)
>                 return;
>         }
> =20
> -       for (chan =3D 0; chan < SX9310_NUM_CHANNELS; chan++) {
> +       /*
> +        * Only iterate over channels with changes on proximity status th=
at have
> +        * events enabled.
> +        */
> +       prox_changed =3D (data->chan_prox_stat ^ val) & data->chan_event;

I was expecting:


	bitmap_xor(&prox_changed, &data->chan_prox_stat, &val, SX9310_NUM_CHANNELS=
);
	bitmap_and(&prox_changed, &data->chan_event, SX9310_NUM_CHANNELS);
=09
> +
> +       for_each_set_bit(chan, &prox_changed, SX9310_NUM_CHANNELS) {
>                 int dir;
>                 u64 ev;
> -               bool new_prox =3D val & BIT(chan);
> -
> -               if (!(data->chan_event & BIT(chan)))
> -                       continue;
> -               if (new_prox =3D=3D data->prox_stat[chan])
> -                       /* No change on this channel. */
> -                       continue;
> =20
> -               dir =3D new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +               dir =3D val & BIT(chan) ? IIO_EV_DIR_FALLING : IIO_EV_DIR=
_RISING;
>                 ev =3D IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
>                                           IIO_EV_TYPE_THRESH, dir);
> =20
>                 iio_push_event(indio_dev, ev, timestamp);
> -               data->prox_stat[chan] =3D new_prox;
>         }
> +       data->chan_prox_stat =3D val;
>  }
> =20
>  static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
> @@ -713,13 +715,13 @@ static irqreturn_t sx9310_trigger_handler(int irq, =
void *private)
>  static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
>  {
>         struct sx9310_data *data =3D iio_priv(indio_dev);
> -       unsigned int channels =3D 0;
> +       unsigned long channels =3D 0;

Use DECLARE_BITMAP(channels, SX9310_NUM_CHANNELS)?

>         int bit, ret;
> =20
>         mutex_lock(&data->mutex);
>         for_each_set_bit(bit, indio_dev->active_scan_mask,
>                          indio_dev->masklength)
> -               channels |=3D BIT(indio_dev->channels[bit].channel);
> +               __set_bit(indio_dev->channels[bit].channel, &channels);
> =20
>         ret =3D sx9310_update_chan_en(data, channels, data->chan_event);
>         mutex_unlock(&data->mutex);
