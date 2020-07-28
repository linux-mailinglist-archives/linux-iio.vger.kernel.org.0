Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B11231160
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgG1SNp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1SNo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:13:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DBC061794;
        Tue, 28 Jul 2020 11:13:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so275076pjb.2;
        Tue, 28 Jul 2020 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPvjG9j2BN8cyR/cfGBwubrHZFbmpe+LnsdHjeHgIHY=;
        b=ivPrXV3XQfUlY3N7dYX4C2l6t69FyxrMyVjXxKjveIYf3UXNduBmBDV+qVkbc7/rPS
         41VPioIz+Cjkc0Sw+b1HN+2wcVXB9Nq/XAyRFj9og1Ie4bLJK0ki4etgh1/O7ELmYkwq
         4bAzCSfid37szaEDieuPHVHf2HiwxYs4hOBh+O3icByuZg7kKPtf0ZQDnSMhYvtX6nbD
         63/tVYKXJ9VcLX27w4GJv6BsG64t87prELZG2sqk3c1xLKb82U9/gPjW4UtjjEbWmojN
         x4lUgeqNo3gMNXggb7pN8vUkSP4TGzNNDQD2oXmsHYNHcYNXctMUcamHfkupCpRKLmFq
         T00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPvjG9j2BN8cyR/cfGBwubrHZFbmpe+LnsdHjeHgIHY=;
        b=UsTrSAQZEPfrVy+C6ROz94ZT2thW2KVvCXfSUAt200rFxPmBLZ+oICWE2i1XVKNxZh
         wF8DPWqflFR1K6oWExpm57yOFy6YCmYZ41sBc7nps+hmGFSA6aDI6Qz5xsBp3WXBCAmy
         q50bONbfx6sT2imqPR053WpCGg0aZI9LOADJrquRWV2dsSuQz61sSa1EtuC7AixdzTut
         /vD6u2WG4HgAgJqupRb5ANsuB2YiIofSQvgm0EMAPD3ZuD/oKObVSkJowE8e5rNUMoiS
         LmDeNI5+5naiHckC8pOPZB1yfRtFTth0rUMgEGVrud2IxCt0zfbB4cJH6POdQMih4rkz
         O5XA==
X-Gm-Message-State: AOAM532N7AQBuovbzZYiO6sAXlvYAQG1kR2LXARwhPHbY8KDACLiU1V4
        HFWrQphIMrelsCrvQrC47nEadj9pNaAYQfHOI6I=
X-Google-Smtp-Source: ABdhPJwIXmuOZrbZg1gTuoHvLx6ZXV/fM05llaPrvjjgJ6UmCiIC516oRmzyXP7SToFyF9NEhULt84v7421hRVwqVEA=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr8571455pla.18.1595960024217;
 Tue, 28 Jul 2020 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.7.I3a5582a3e1589e351f6335b39f52e5ccc5f46b61@changeid>
In-Reply-To: <20200728091057.7.I3a5582a3e1589e351f6335b39f52e5ccc5f46b61@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:13:27 +0300
Message-ID: <CAHp75Vfq7NqP=iTSELE7=ntiG5P24ig_cPoUFB1t4AwVXTFNOg@mail.gmail.com>
Subject: Re: [PATCH 07/15] iio: sx9310: Use long instead of int for channel bitmaps
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
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

On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
>
> Uses for_each_set_bit() macro to loop over channel bitmaps.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/iio/proximity/sx9310.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index fb5c16f2aa6b1a..2465064971d0a7 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -136,7 +136,8 @@ struct sx9310_data {
>         /* Remember enabled channels and sample rate during suspend. */
>         unsigned int suspend_ctrl0;
>         struct completion completion;
> -       unsigned int chan_read, chan_event;
> +       unsigned long chan_read;
> +       unsigned long chan_event;
>         int channel_users[SX9310_NUM_CHANNELS];
>         unsigned int whoami;
>  };
> @@ -279,15 +280,16 @@ static const struct regmap_config sx9310_regmap_config = {
>  };
>
>  static int sx9310_update_chan_en(struct sx9310_data *data,
> -                                unsigned int chan_read,
> -                                unsigned int chan_event)
> +                                unsigned long chan_read,
> +                                unsigned long chan_event)
>  {
>         int ret;
> +       unsigned long channels = chan_read | chan_event;
>
> -       if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
> +       if ((data->chan_read | data->chan_event) != channels) {
>                 ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
>                                          SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
> -                                        chan_read | chan_event);
> +                                        channels);
>                 if (ret)
>                         return ret;
>         }
> @@ -538,13 +540,13 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
>                 return;
>         }
>
> -       for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
> +       for_each_set_bit(chan, &data->chan_event, SX9310_NUM_CHANNELS) {
>                 int dir;
>                 u64 ev;
> -               bool new_prox = val & BIT(chan);
> +               bool new_prox;
> +
> +               new_prox = val & BIT(chan);
>
> -               if (!(data->chan_event & BIT(chan)))
> -                       continue;
>                 if (new_prox == data->prox_stat[chan])
>                         /* No change on this channel. */
>                         continue;
> @@ -712,13 +714,13 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
>  static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
>  {
>         struct sx9310_data *data = iio_priv(indio_dev);
> -       unsigned int channels = 0;
> +       unsigned long channels = 0;
>         int bit, ret;
>
>         mutex_lock(&data->mutex);
>         for_each_set_bit(bit, indio_dev->active_scan_mask,
>                          indio_dev->masklength)
> -               channels |= BIT(indio_dev->channels[bit].channel);
> +               __set_bit(indio_dev->channels[bit].channel, &channels);
>
>         ret = sx9310_update_chan_en(data, channels, data->chan_event);
>         mutex_unlock(&data->mutex);
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
