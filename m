Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8960822A721
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 07:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgGWF7a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 01:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgGWF7a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 01:59:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E928C0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 22:59:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h13so3594065otr.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TrXK3j0wrRkT89+ouAm8VUbl/mVY4HgnuPjriUnC6LM=;
        b=Bk5d3u9OkipqLxXGMW0BJbtsRe91ZDcHxMP0NSts3KuiI5L86MFR4vDNmMogi86j7s
         QpORn3HeJzx8guTk3Ek3lLb6kjG93uM4bHA2Cc4+ITlvnri8Q4SHBiWi6v+iAAxJ5dSW
         AM+9Y6hOPLByuScTvzNW7CyevUxwdfhIu3BXfJ301Kj6IpAGG7yztoujFIwFcHwQgnDm
         TgVNI+XAYVbzEwnQwERDCzxxxmwplo/Lm18Y6I64UUPDI1A9v3Z2MOtXdDAZYzi0pMcq
         6JV33TIOqM7lzzIg53yG8yvnXg75y715oXAtiqZhgGfpJHBIDWhIZuGle0uWXaPUDZ8B
         KibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TrXK3j0wrRkT89+ouAm8VUbl/mVY4HgnuPjriUnC6LM=;
        b=e9NtFyaMd8jc+17JroW/7Qy6tKKHLDfV9oO9gjcLrTJiQZhnfhhrG6R2cGl4N3cmkB
         5oO/ztmCLAAiscEgDRudBhg5j1gUGJj2eORR73lVyiudw6DUB4CA7rEISlcuLBkQQ/jM
         BWqgrxFT50sskCpIv+KbSBChxbYql8TYpFrlFnX6yyjzYQi3AgFrUpKrqMcWNTCAXD54
         SavhiDD2TgG1UmdzLH5GFxzRm6WBBCD3QgxsoHOiA+MYdqt+E0OK7RdSM2aMeTN4hbCB
         boNcyGGJZz00xtR3WV3mEm0ayjS6Zghhn8kypp4tnOY0eHOmdpinsv5rl1H898PEWnxq
         vo0A==
X-Gm-Message-State: AOAM532EH4kWfpEPFElR6vpN3sJ8MijDK9T3MXxil8wFZTabmFTWSAap
        D9GfKSlhDptxdeArQX3BfgCvncO7OKDuNtcGAAc=
X-Google-Smtp-Source: ABdhPJzw2Cm3kCoP0VFU2d3hlLA86qzbPoh+dsmLHLFtS3V7IerW8v6upF4ZC88cY3DCmSej9rXGhqwlmJJ76MO9D+o=
X-Received: by 2002:a9d:480d:: with SMTP id c13mr2981416otf.224.1595483969300;
 Wed, 22 Jul 2020 22:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200722142515.897378-1-jic23@kernel.org>
In-Reply-To: <20200722142515.897378-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 23 Jul 2020 08:59:17 +0300
Message-ID: <CA+U=DsosVjmWBAhPeQeipuq4AfOR4fPoDYJMQ96L-2Fb39ZF+A@mail.gmail.com>
Subject: Re: [PATCH] iio:dac:ad5592r: Fix use of true for IIO_SHARED_BY_TYPE
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 5:28 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> struct iio_chan_spec_ext_info shared element is of type
> enum iio_shared_by, not boolean.   It's like the enum value
> will for IIO_SHARED_BY_TYPE =3D=3D 1 =3D=3D true, hence no actual
> problem has been observed.
>
>   CC [M]  drivers/iio/dac/ad5592r-base.o
> drivers/iio/dac/ad5592r-base.c:491:13: warning: implicit conversion from =
=E2=80=98enum <anonymous>=E2=80=99 to =E2=80=98enum iio_shared_by=E2=80=99 =
[-Wenum-conversion]
>   491 |   .shared =3D true,
>       |
> Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADCs/=
DACs")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/dac/ad5592r-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-bas=
e.c
> index cc4875660a69..456bf5292c44 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -488,7 +488,7 @@ static const struct iio_chan_spec_ext_info ad5592r_ex=
t_info[] =3D {
>         {
>          .name =3D "scale_available",
>          .read =3D ad5592r_show_scale_available,
> -        .shared =3D true,
> +        .shared =3D IIO_SHARED_BY_TYPE,

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

>          },
>         {},
>  };
> --
> 2.27.0
>
