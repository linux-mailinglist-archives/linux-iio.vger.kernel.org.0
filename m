Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52916291313
	for <lists+linux-iio@lfdr.de>; Sat, 17 Oct 2020 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437868AbgJQQYl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437805AbgJQQYl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Oct 2020 12:24:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1AC061755;
        Sat, 17 Oct 2020 09:24:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x7so7836495eje.8;
        Sat, 17 Oct 2020 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/6V3G2pS0iQZfx+W1jRBDC69XLzC43FFM/6CPSrA9Q=;
        b=Mb7l/y0lTEQAwiCPHpZdkuuFvHUnYpMqZCoIxuGW/CkLxWvPMURzXMTPY35/Tektvc
         ar+q8WaHHQ0Nt/GCabmIg9v/Fbfh55Kcfyve4bzE2PSrmeughqxQuYzwervrsYrmRaKH
         LtVQ0TNfiiWeM2GVTQS+bf8rnjz+iJbC8ZmxTJurDYk59IQQrximctWWjW7jcp9kSWjW
         0YOqnVAAWEuu6Kvupgk3YZWE4H9+3/lf1AGGII/j/3hIGrD4yV/54sR7ec5i53fY2PJ0
         fgh6eQYno8LC2NWNVWqoWWVw9bOr5wBz1ABL8HB1AEWrxXwt7Af4Pl5BNXPXRQtk4BRV
         cB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/6V3G2pS0iQZfx+W1jRBDC69XLzC43FFM/6CPSrA9Q=;
        b=JQGzzIot4jDIHU1zJwwk3QbBX+U8HHMRv8Lzt++O+C918SzHe87tJ09rHzY60qLtNN
         vhpnu86cozzEBpF6bKel7tzmVMq9We9SE9VjV6f5FxBK+UW3kMgjNd4WJdAvMThgQdjY
         YYFErrTIfbrd7B24ylWhuKwfE7yQKuhuBcHuZgl+Jp3XLgzs2zCbW2GYgb6QaCospDFV
         rSui+MANYWWF/puX348s9iIdSO0+3ywOnM5QqWZcsad5+y51he/iDbCez231t1T2O9s3
         M/4c2w/sEwx5A9mFV6ZjHTWmN6jJTGEEUBkdvji27lakBH1toZcHmkIdIqqQon8kvsTY
         UJLw==
X-Gm-Message-State: AOAM532pTXAUDcw5cW+NLuRq/iVi8ZL+Oj1Qi7l0FmZOv3ynRHYl8KBz
        n3gaYW6P173v9gBgshT0nlrOG+BgaLC354c+aL9fEKmZ714=
X-Google-Smtp-Source: ABdhPJzF2+3ZIgOLCQvR2OG2EkAfu6+o/CfgWgqvonHqkXJ9AVKeiTSj5PjoOZ1xz2nSHAUaclcvx8Fg+EmdNtGHZo4=
X-Received: by 2002:a17:906:1a10:: with SMTP id i16mr9192336ejf.162.1602951879778;
 Sat, 17 Oct 2020 09:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201017160928.12698-1-trix@redhat.com>
In-Reply-To: <20201017160928.12698-1-trix@redhat.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 17 Oct 2020 18:24:28 +0200
Message-ID: <CAFBinCAqvqp14ygOzQW=OPi7CY5z7qAcvcUHZs7Zf6JaHbNYXg@mail.gmail.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To:     trix@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Tom,

(I removed what I believe are irrelevant recipients from this reply)

On Sat, Oct 17, 2020 at 6:10 PM <trix@redhat.com> wrote:
[...]
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index e03988698755..66dc452d643a 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -591,17 +591,15 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
>                 return meson_sar_adc_get_sample(indio_dev, chan, NO_AVERAGING,
>                                                 ONE_SAMPLE, val);
> -               break;
>
>         case IIO_CHAN_INFO_AVERAGE_RAW:
>                 return meson_sar_adc_get_sample(indio_dev, chan,
>                                                 MEAN_AVERAGING, EIGHT_SAMPLES,
>                                                 val);
> -               break;
>
>         case IIO_CHAN_INFO_SCALE:
>                 if (chan->type == IIO_VOLTAGE) {
>                         ret = regulator_get_voltage(priv->vref);
>                         if (ret < 0) {
for drivers/iio/adc/meson_saradc.c:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
