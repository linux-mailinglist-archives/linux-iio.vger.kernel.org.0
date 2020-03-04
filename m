Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC8179AC4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 22:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgCDVSN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 16:18:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45519 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDVSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 16:18:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id f21so3502986otp.12;
        Wed, 04 Mar 2020 13:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btFxI1AY902XfnaAbQ65M1jnLtqbJ2OeOdebXmzbiT8=;
        b=HrgFjRhWzaQHkAI3vNc7+HytZ01Wr0Dz4sMaw2UVaZFnuBjfR4TEcv4rhqM+ZLsI5/
         GK7CHt4XYQmlabtfqTHhMAPpOZYDA2eS35+9dNCJumVMrzQLUFhd7dpT1tiIDpgWxtkE
         zRNGmLDrwoO5x1UCOvcv/V25aCRb2Gt3Mzu/RPFKdNdviZG1/jdfdeAbYPlxefCuItpY
         74508y7QtZUQx04AmAbPC6ss1g/skvPHZAWGznrEaME1lAba508HB+N0xH4pMLb5jC3l
         QBXyTyDIV4jJyxDlL9CBJQZG9xamQCVxNVETHIOFBx41eWFzSotNemL9TB9D2O7Ts8l1
         RDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btFxI1AY902XfnaAbQ65M1jnLtqbJ2OeOdebXmzbiT8=;
        b=uDI1uAcxgJVB59oYUJ2dnw0shkHn92toW/27BGH9gN/KkXo4ZSBdIfmjdDXSKEhLVW
         Ti/H8CVPIJuTwC6DyrB5XxSfrL5s76AkNh5AeWUO5oVzDwZGLBY0gWagybkBlLKXXY6v
         fNIaP8akUop+CP0KK5ks4fMk12m803Vp0tvnL4mffeHhoV3eYQSCKhs07G5sd11rtAqn
         eT0IQTRg/qHPwDiRw4IvzveyvgbZTCF4hnkPzHaSddEPo3y3w6ohFH7XJWd/8OzEmbuV
         6kKMyqzkkoOuQIf555reStNGGrV7iUtrL1Hyo5kIhmHFgBP1ANoYeM1rDQREWQG/pgXS
         os8g==
X-Gm-Message-State: ANhLgQ1C4c9/2qNZyeZBuNNu0F2/AePOUbWuNz2L3tMVJ4Gns0huIncN
        x+AhU5TP3uY1WrJqdJZduXHQXee4FuKRyfC/ATriV/b1
X-Google-Smtp-Source: ADFU+vuKMWo98jcRpBlk+SPgl3sQeKW2MIMB3GnOgWY1Yk1k25I+PGlDa50ZrasHDUNpJAgCWqru+lt2za3rFdN3HHM=
X-Received: by 2002:a9d:6a06:: with SMTP id g6mr3674841otn.305.1583356692708;
 Wed, 04 Mar 2020 13:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20200304093633.32264-1-alexandru.ardelean@analog.com> <20200304094105.2586-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200304094105.2586-1-alexandru.ardelean@analog.com>
From:   Matt Ranostay <mranostay@gmail.com>
Date:   Wed, 4 Mar 2020 13:17:36 -0800
Message-ID: <CAKzfze8KMLG=GbMvZ9eydOer5wZw-i7_5fJVjpFcZ6fqyoHgJQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: potentiostat: lmp9100: fix iio_triggered_buffer_{predisable,postenable}
 positions
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, matt.ranostay@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 4, 2020 at 1:38 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
>
> For the predisable hook, the disable code should occur before detaching
> the poll func, and for the postenable hook, the poll func should be
> attached before the enable code.
>
> The lmp9100 was attaching a poll function but never detaching it via any
> IIO disable hook.
>
> This change adds the detaching of the poll function, and moves/renames
> lmp91000_buffer_preenable() function to lmp91000_buffer_postenable().
> The idea is to make it more symmetrical, so that when the
> iio_triggered_buffer_{predisable,postenable} functions get removed, it's
> easier to see.
>
> Fixes: 67e17300dc1d7 ("iio: potentiostat: add LMP91000 support")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>
> Changelog v1 -> v2:
> * forgot to call iio_triggered_buffer_postenable() in
>   lmp91000_buffer_postenable() in v1
>
>  drivers/iio/potentiostat/lmp91000.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index a0e5f530faa9..2cb11da18e0f 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -275,11 +275,20 @@ static int lmp91000_buffer_cb(const void *val, void *private)
>  static const struct iio_trigger_ops lmp91000_trigger_ops = {
>  };
>
> -static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
> +static int lmp91000_buffer_postenable(struct iio_dev *indio_dev)
>  {
>         struct lmp91000_data *data = iio_priv(indio_dev);
> +       int err;
>
> -       return iio_channel_start_all_cb(data->cb_buffer);
> +       err = iio_triggered_buffer_postenable(indio_dev);
> +       if (err)
> +               return err;
> +
> +       err = iio_channel_start_all_cb(data->cb_buffer);
> +       if (err)
> +               iio_triggered_buffer_predisable(indio_dev);
> +
> +       return err;
>  }
>
>  static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
> @@ -288,12 +297,11 @@ static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
>
>         iio_channel_stop_all_cb(data->cb_buffer);
>
> -       return 0;
> +       return iio_triggered_buffer_predisable(indio_dev);
>  }
>
>  static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
> -       .preenable = lmp91000_buffer_preenable,
> -       .postenable = iio_triggered_buffer_postenable,
> +       .postenable = lmp91000_buffer_postenable,
>         .predisable = lmp91000_buffer_predisable,
>  };
>
> --
> 2.20.1
>
