Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537523E95B5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 18:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhHKQQc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhHKQQc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 12:16:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F51C061765
        for <linux-iio@vger.kernel.org>; Wed, 11 Aug 2021 09:16:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f3so3345926plg.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Aug 2021 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=im19tzjiWVYQXLLVlA7WWvG77k0EDKaCUCQfQ3S9ku8=;
        b=a7GvZtApA21CRmU82sRy/yz86mdsXtr8WMpj6OL3EynAw1Idq5pc3SX41jm2fet2/R
         wKuBFlzdtlCJ9vb0BLE3X6hcd2Pvj00Rp18u6Mhyi1zkpJr4bpRhyOKYMPVLPKupTS00
         oRr60NGArJk/ZFe4EY5Q903hZDakXgGzcck0iboEMH/hnibEkttEk96XYamXonoDeQjn
         /iaad0O8EoSSoqP3ldKEMLqsVCR55NCw32xAL8R7cj6oI6NLJXefyPgTWq6AHKPdBIHw
         V3N1r031XgfnVFngUa6LS+lxM6miuCavE6rdklJwjPHAf4qG6MAWk1RUrt+NzbKYzPeT
         GI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=im19tzjiWVYQXLLVlA7WWvG77k0EDKaCUCQfQ3S9ku8=;
        b=XCDiXrShBXgRNsX6qiuLzrP4a/r9zL3vAgZpOWVcwc2HD1cU1UQ7mT/IV0j0Z8YTY7
         XEQyc/r0d1/JKun3bzmRrd5yGAbUA3WVlTN11aAHuWr9I81i81020yRaL3TpCjYIMnsQ
         irYhxMnb2kLhFINjKxx+KnAo2ikZFv18SrnaemLg2KiH1H74s4Edsv6QCdMx7XoYgXbl
         A40EVTp4rGBEBN+yeO2Sf8L7M0V49fQs4qtYxYQjPM4Cl8YQMxnbFtfyQAu3o9gSZ2aY
         ozRsILQvhNSiWeWfudnwUdr3bAehYhpYhPnzL572/EvOZLxc8N2czHtk4PRIafq1m6/E
         7vWA==
X-Gm-Message-State: AOAM5317N4I552GF+Xbmfzn6jdxOMzIdux0760f7uQ6gRk20XCob4c7/
        9WFGZfNhZ8EyHtTjHVRF3A7jjoMVMmbDB+ReSmg=
X-Google-Smtp-Source: ABdhPJz0lwCAF+YpVFmHLk4FG2vGKy6KLR7RFPyH3ykLrI3fQQ1Ki/AGttET5dgvvBHKDxZtYUKQ2NucTP1eu1FLHqA=
X-Received: by 2002:aa7:860e:0:b029:3bd:7e49:7a14 with SMTP id
 p14-20020aa7860e0000b02903bd7e497a14mr35411454pfn.40.1628698568287; Wed, 11
 Aug 2021 09:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210811133220.190264-1-nuno.sa@analog.com> <20210811133220.190264-2-nuno.sa@analog.com>
In-Reply-To: <20210811133220.190264-2-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 19:15:28 +0300
Message-ID: <CAHp75Vfp_u9mbnUzcBXdv_RmFu9m4JK0=R5us6j3bquG4HzRvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 4:32 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

Thanks for an update, my comments below.
Depending on Jonathan's wishes it may or may not require a v3.
If you address the minor issues I commented on, take mine
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> There is no reason to assume that the irq rising edge (indicating that
> the device start up phase is done) will happen after we request the irq.
> If the device is already up by the time we request it, the call to
> 'wait_for_completion_timeout()' will timeout and we will fail the device
> probe even though there's nothing wrong.

> This patch fixes it by just polling the status register until we get the

This patch fixes --> Fix

(see Submitting Patches for details of this requirement)

> indication that the device is up and running. As a side effect of this
> fix, requesting the irq is also moved to after the setup function.

In entire message irq --> IRQ

> Fixes: f110f3188e563 ("iio: temperature: Add support for LTC2983")
> Reported-by: Drew Fustini <drew@pdp7.com>
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> Tested-by: Drew Fustini <drew@pdp7.com>

You may save a line by unifying Reported and Tested with Reported-and-teste=
d.
"Reviewed" is usually a different story.

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> index 3b5ba26d7d86..657eb8cb4be4 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -89,6 +89,8 @@
>
>  #define        LTC2983_STATUS_START_MASK       BIT(7)
>  #define        LTC2983_STATUS_START(x)         FIELD_PREP(LTC2983_STATUS=
_START_MASK, x)
> +#define        LTC2983_STATUS_UP_MASK          GENMASK(7, 6)
> +#define        LTC2983_STATUS_UP(reg)          FIELD_GET(LTC2983_STATUS_=
UP_MASK, reg)
>
>  #define        LTC2983_STATUS_CHAN_SEL_MASK    GENMASK(4, 0)
>  #define        LTC2983_STATUS_CHAN_SEL(x) \
> @@ -1362,17 +1364,16 @@ static int ltc2983_parse_dt(struct ltc2983_data *=
st)
>
>  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  {
> -       u32 iio_chan_t =3D 0, iio_chan_v =3D 0, chan, iio_idx =3D 0;

> +       u32 iio_chan_t =3D 0, iio_chan_v =3D 0, chan, iio_idx =3D 0, stat=
us =3D 0;

No need to assign 0 at least to the status.

>         int ret;
> -       unsigned long time;
> -
> -       /* make sure the device is up */
> -       time =3D wait_for_completion_timeout(&st->completion,
> -                                           msecs_to_jiffies(250));
>
> -       if (!time) {
> +       /* make sure the device is up: start bit (7) is 0 and done bit (6=
) is 1 */
> +       ret =3D regmap_read_poll_timeout(st->regmap, LTC2983_STATUS_REG, =
status,
> +                                      LTC2983_STATUS_UP(status) =3D=3D 1=
, 25000,
> +                                      25000 * 10);
> +       if (ret) {
>                 dev_err(&st->spi->dev, "Device startup timed out\n");
> -               return -ETIMEDOUT;
> +               return ret;
>         }
>
>         st->iio_chan =3D devm_kzalloc(&st->spi->dev,
> @@ -1492,10 +1493,11 @@ static int ltc2983_probe(struct spi_device *spi)
>         ret =3D ltc2983_parse_dt(st);
>         if (ret)
>                 return ret;
> -       /*
> -        * let's request the irq now so it is used to sync the device
> -        * startup in ltc2983_setup()
> -        */
> +
> +       ret =3D ltc2983_setup(st, true);
> +       if (ret)
> +               return ret;
> +
>         ret =3D devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler=
,
>                                IRQF_TRIGGER_RISING, name, st);
>         if (ret) {
> @@ -1503,10 +1505,6 @@ static int ltc2983_probe(struct spi_device *spi)
>                 return ret;
>         }
>
> -       ret =3D ltc2983_setup(st, true);
> -       if (ret)
> -               return ret;
> -
>         indio_dev->name =3D name;
>         indio_dev->num_channels =3D st->iio_channels;
>         indio_dev->channels =3D st->iio_chan;
> --
> 2.32.0
>


--=20
With Best Regards,
Andy Shevchenko
