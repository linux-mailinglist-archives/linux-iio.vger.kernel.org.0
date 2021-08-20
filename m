Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38F3F2849
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhHTIWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 04:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhHTIWR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 04:22:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E14C061575
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 01:21:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so8414976pgf.5
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VK/hEmBwSjcbOGKG+JPCR+9UqW8jwiQdNgYDKZJCOA0=;
        b=GmjdQrW/k8fXOp/RL/hDIvfngbVg2t7hMjQR7Bbvt7A7e1qm2TgQRTsg1Z+46fjvoe
         kLMTKTDw97XAV9wh2Vpk1hQqswPllOfV6oyuETNrviWxQAVx2Z/skpHVVcD8YKyNpUHV
         azGIqJ1i7N74oPn77+bidFVkzstEFGGeFtG03Scu1nEnZraHRzhH5aPFeqRxQhEsBPF+
         RdNYQA5HJdTjLXLiTzOUwReqwdVDcuBlDig97RsUaXTgE2BFOK6E/gVw2oS9iDGFzDc4
         mDMyc6ITcKgAo3elAFTfOxapGDzTlTEVgu4Y7/abc0/FYadpGUE48WBuZnfrjqJiMsWW
         TO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VK/hEmBwSjcbOGKG+JPCR+9UqW8jwiQdNgYDKZJCOA0=;
        b=K4M6otpR+lH72zTt2/3WsGpvwOwrGKokebeE7FpaSpWauxvKIVUTTiphUSYS6ncJ8e
         lM6wGBXIU613A3xp8VI0dpuJvNmy7YCeuHeCjSUBrDEenSXf9o5DPCCBTk9dRajVXfnL
         XmAhsyHgbkh4YH9tYkBOXO8q3uaDKFQXXoRz4WYMF4nAPIdRyNXy4+5Z8MRK0lYD9odz
         ovsuqhYG22V0aQTKF4Ojh2IoXPmJZ9wQampd3lOQ/t7w/y+vVuFQ7+zBe2J2pP3YPT/9
         ++Vn7gOWjiNkrsp/LTS3GghX/Uu28QxuzeRu3WnHJ3wS+gGsF8N+zCvk8a67IwEzqsOG
         g1Ig==
X-Gm-Message-State: AOAM532aXwzqQ/Qju+yyXLhCVgMY6S2EeSDx2PMVxk3tz/+45vXjlCPg
        B8m2KDh5UKMYQCYfofttaQMt2W9iVGAteIeOw6Y=
X-Google-Smtp-Source: ABdhPJyIRtmDyr7SrbSr3VjPCwNa5prVFA3IJJYogaip5ISM9j78eHR6h/XNlnjwB/REagVVnt93lXffH22bRH+l7Vo=
X-Received: by 2002:a05:6a00:2343:b0:3e0:f9a0:c1fa with SMTP id
 j3-20020a056a00234300b003e0f9a0c1famr18772601pfj.72.1629447699205; Fri, 20
 Aug 2021 01:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210820065535.6994-1-nuno.sa@analog.com>
In-Reply-To: <20210820065535.6994-1-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 20 Aug 2021 11:21:27 +0300
Message-ID: <CA+U=Dso61XreVxxz8a3cSO+LJrdQAJAi--3Nuv5nRG=buuVCcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
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

On Fri, Aug 20, 2021 at 9:53 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Check if an optional reset gpio is present and if so, make sure to reset
> the device.
>

Just one note/question inline.

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> index 3b4a0e60e605..37903e9fb90f 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -1470,6 +1470,7 @@ static int ltc2983_probe(struct spi_device *spi)
>  {
>         struct ltc2983_data *st;
>         struct iio_dev *indio_dev;
> +       struct gpio_desc *gpio;
>         const char *name =3D spi_get_device_id(spi)->name;
>         int ret;
>
> @@ -1494,6 +1495,16 @@ static int ltc2983_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> +       gpio =3D devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OU=
T_HIGH);
> +       if (IS_ERR(gpio))
> +               return PTR_ERR(gpio);
> +
> +       if (gpio) {
> +               /* bring device out of reset */
> +               usleep_range(1000, 1005);
> +               gpiod_set_value_cansleep(gpio, 0);

Datasheet mentions that it takes up to 100 ms for the device to fully start=
-up.
It also mentions that the (command) status register will be
unavailable to the user before this point.
Page 16, Conversion State Details section, second paragraph.

I think there should probably be a sleep here of 100 ms.

Other than that change looks good.

> +       }
> +
>         ret =3D ltc2983_setup(st, true);
>         if (ret)
>                 return ret;
> --
> 2.33.0
>
