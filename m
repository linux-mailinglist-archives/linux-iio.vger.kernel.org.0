Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07494113B1
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhITLoE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhITLoD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 07:44:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4192FC061574
        for <linux-iio@vger.kernel.org>; Mon, 20 Sep 2021 04:42:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 145so2022339pfz.11
        for <linux-iio@vger.kernel.org>; Mon, 20 Sep 2021 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XDqZ5c03fXIP0U9JwSib+CxaH9k09jf27wW6KOJR7Z8=;
        b=i0tMVeT0Fv+rixr3A5YebrYegYWcupr/fwE41SE7kINjzQ1SOPIQQm8vyZ3eIgpntE
         lva9ng+ZGrTtTOsBh8TVvXGZbCxRvV/XfJNoXf9v9MkR9IbZWw7NwSuf4/gD9CVK2iIC
         sJbqBFYgQORhNQArdd0CMDF5dwvOWENV78foeMwn0ZrUJaTD5WkoQwE+CwUm1wuBaFR1
         sqfmc9n2EDpqlQ0UtB6LbJZksucV71Hbd4J2sz2yAwNxajQe4tyhQ7+aMWHM/160uPeG
         lEbObF9VuvWai1g3r1K82M0qS4Wj068Koz4TCuMe7zlrRTN/wZeVBSDHKFXhBK4tXSZv
         /BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XDqZ5c03fXIP0U9JwSib+CxaH9k09jf27wW6KOJR7Z8=;
        b=aLcirHrGYXF0d1ULPUrD/MqHOel7ZDR9qe2LuWr+WkgdiYQ88sYkSxFvDxTxYoPl1r
         hWB+Y/hhG7yfIgl6aOe45yiwYMloowjozt8zzjlU53fNtw8amC/BMIg5GCFbPVRXA+sS
         GrRVKjOPxoP0tUnakYVBcs//18a7oJ+89ml7DO8rE2G57li1b0W9RUEnv/x0OUEoA46r
         jPsoYNJ+DFisR8JwpWxWHhCiaIB/y7l21si+7AFJwzOl8+jFBdel9nndA91SN1RdkkFG
         oJdlhivabru/V88Ys8oB1hoFgqQaS/Y/CO0Y9lcAmGStGidjrtrSXREEpQkz1jK4v1Sh
         IR+g==
X-Gm-Message-State: AOAM530mY19W9WI7XIJ1he/Ym4Bnzgl4PcRJRDElh4NUTCdJut7MGuaL
        oPtMcoxjhOrC8I6PkK1VIgj8moM+Mj6ZeaBoqA8=
X-Google-Smtp-Source: ABdhPJzcOxdFFT7m4AyfNXROAqXLaxfeEf2hg7Eh69sLQXm3wiNGiAAvoyKiZ2saO3SeWD0bCTmwKDhYRLsT8lDQgzo=
X-Received: by 2002:a63:1262:: with SMTP id 34mr22959009pgs.356.1632138156715;
 Mon, 20 Sep 2021 04:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210920090047.74903-1-nuno.sa@analog.com>
In-Reply-To: <20210920090047.74903-1-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 Sep 2021 14:42:25 +0300
Message-ID: <CA+U=DsoVS74-eQ_aj96QU1ayTd4WKg7FgZGDnt=W81sDjXk7XA@mail.gmail.com>
Subject: Re: [PATCH] iio: adis16475: fix deadlock on frequency set
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 20, 2021 at 12:59 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> With commit 39c024b51b560
> ("iio: adis16475: improve sync scale mode handling"), two deadlocks were
> introduced:
>  1) The call to 'adis_write_reg_16()' was not changed to it's unlocked
>     version.
>  2) The lock was not being released on the success path of the function.
>
> This change fixes both these issues.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: 39c024b51b560 ("iio: adis16475: improve sync scale mode handling")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16475.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index eb48102f9424..287fff39a927 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -353,10 +353,11 @@ static int adis16475_set_freq(struct adis16475 *st,=
 const u32 freq)
>         if (dec > st->info->max_dec)
>                 dec =3D st->info->max_dec;
>
> -       ret =3D adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec)=
;
> +       ret =3D __adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, de=
c);
>         if (ret)
>                 goto error;
>
> +       adis_dev_unlock(&st->adis);
>         /*
>          * If decimation is used, then gyro and accel data will have mean=
ingful
>          * bits on the LSB registers. This info is used on the trigger ha=
ndler.
> --
> 2.33.0
>
