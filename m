Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3233F0106
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhHRJzY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 05:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhHRJzV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 05:55:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54339C061764
        for <linux-iio@vger.kernel.org>; Wed, 18 Aug 2021 02:54:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c17so1488746plz.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Aug 2021 02:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VwfHvnqCRsnGRLQb7+4hr06ev38uPq/YrqN6UtSEWlU=;
        b=JvV7R1f0WysaPGkET5c/hWWQhMpAhylj6yUrmP5pNDIkWUjl44aE8LKvUTwCAs6YRM
         hU6XTSHQeifjKC0MV04mFNJb5CXOfhMd2970IjLe82heppaXzogIkjQcFVjYmuZMcVi6
         vNkxfxzOsax0nK/i3rjf3GdJa6B7b1m98Jx5DmTcDHB3x2ArYOiOjtVTMZr5nxtB+xty
         Yytm84UcxhGCEjHuPRJl6VMhawh0zKxXikV2c2dMpDe8W1PsQx6Zd1Sv55fJ9YVnA53S
         Z6vJSWapQD+CU7AnHgGp9M4prXDgJOO0rOxOjBj7yT76HJjOn92bFt9TGkpcF6J1Mhx/
         c8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VwfHvnqCRsnGRLQb7+4hr06ev38uPq/YrqN6UtSEWlU=;
        b=VxEUsZzU2macuzlt6ZvSbtnL0K1vjyiCdm7uYFRJq6Sye7CnJllawhSj4trTccRhn7
         dltJQLkOzjOc6C7VGf/QXEpCJcglNG7MbqYQTPVE6BHvfZJxQUIuO4SvEYmQtrWZgnDh
         iyNJ8SU4Pv+sJMFtoHvyfPIbWgkWl9xUEnLFE2iG7d3u4kxjKTBvjS2hRdetg7QfxaMw
         MLMcMjluwzN52iAnxDLkL77d0y++AdmrT/BBRXjX4U7CRzFLFwDWkrN1wIIK3k9ZLCvy
         gFF7wpAv8KCoQIS1KfNsRu7KInCOAAaC8SWk4OZYJjVEyZA1tqIF7jLwve5OSxD1+gH9
         lhRg==
X-Gm-Message-State: AOAM532rapPSQZaj5w+eZjYSueH3h0imPnAQ8xj2UkNGE3SDbV+ukhLj
        Yk/hpywY5+fjV8dUjxZvF8vWy4Tm6Rz84e0WpV0=
X-Google-Smtp-Source: ABdhPJziOTg1DETcaOg2p1sixATuhb0ffbhzVLkYo2vpwY1N73wXGBIbXPO1ZJkYrUVqvQcPy32IZMUFbHE05faF6Gc=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr6637953plg.0.1629280485757; Wed, 18 Aug
 2021 02:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210818080525.62790-1-nuno.sa@analog.com>
In-Reply-To: <20210818080525.62790-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Aug 2021 12:54:09 +0300
Message-ID: <CAHp75VekRA=U0CUmZWj+3Q4t2CB-51EdtphT_Mt_kAvyPK_fFQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: ad5770r: make devicetree property reading consistent
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

On Wed, Aug 18, 2021 at 11:05 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> The bindings file for this driver is defining the property as 'reg' but
> the driver was reading it with the 'num' name. The bindings actually had
> the 'num' property when added in
> commit ea52c21268e6 ("dt-bindings: iio: dac: Add docs for AD5770R DAC")
> and then changed it to 'reg' in
> commit 2cf3818f18b2 ("dt-bindings: iio: dac: AD5570R fix bindings errors"=
).
> However, both these commits landed in v5.7 so the assumption is
> that either 'num' is not being used or if it is, the validations were not
> done.
>
> Anyways, if someone comes back yelling about this, we might just support
> both of the properties in the future. Not ideal, but that's life...

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 2cf3818f18b2 ("dt-bindings: iio: dac: AD5570R fix bindings errors"=
)
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
> v2:
>  * Updated the commit description and added a fixes tag.
>
>  drivers/iio/dac/ad5770r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> index 8107f7bbbe3c..7e2fd32e993a 100644
> --- a/drivers/iio/dac/ad5770r.c
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -522,7 +522,7 @@ static int ad5770r_channel_config(struct ad5770r_stat=
e *st)
>                 return -EINVAL;
>
>         device_for_each_child_node(&st->spi->dev, child) {
> -               ret =3D fwnode_property_read_u32(child, "num", &num);
> +               ret =3D fwnode_property_read_u32(child, "reg", &num);
>                 if (ret)
>                         goto err_child_out;
>                 if (num >=3D AD5770R_MAX_CHANNELS) {
> --
> 2.32.0
>


--=20
With Best Regards,
Andy Shevchenko
