Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275363F284D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhHTIXf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhHTIXf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 04:23:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92FC061575
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 01:22:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so3398942pjb.4
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F45pCEgyMo1wOE40L5dnIDSyzxp53nUYQbH42FphtlA=;
        b=ZO1CPfRqgXdoXei9mkax/+ssO/W/307I52xf9EQ33pu0FAXNo23sYW3n6MG1mxdvsP
         tzjvg1SE5BCKREPgzuqzYSzUzYzZe2zOmQocjRZY9jYxroHboeom6RMa55i1pO3rxjLI
         NzYFgueEOmaGCjsMfGzyXLP6RlWp5pgGMaUYWyudxD0dAoL14FJS/WVVw8Bc6M3hf/mN
         4iYsMsbQVEtO0GrG9JLqNVjyu9FPSoYo+3qdG1B6lCU3hJktV92IkYyN4T9rIIukV+9k
         fdxxnPCk3aSxt1rUEpBiy0zpmQvZSyByE7xMH72RHc0FgrgM2dn6Vl/sUisfu/mXh6t3
         4oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F45pCEgyMo1wOE40L5dnIDSyzxp53nUYQbH42FphtlA=;
        b=tEFUQ9+Ip5fh4Saubquoxpgg/7VW61Uz+vurIL3u0n3+bqtX7qtz3l80Qy1ggN1Asc
         wJmVPoyHIgofWA1Q6v8DS4Q2czZTURuNCT7S69SickfykWH8FD3eu7VmcJZYCnOTlFtW
         RPTYy21zgZSxouca9MAZb7K2/CIRfVXYWUOtuRGcctEx9WYT8iGqFjseCHu/UdOkAgwK
         09wh6BWN1LDVt0Yj7CU/xHpWtIossv73/xODaJ3tR66Wos/JCpE+EXmdJpfRWAm5dJyL
         8JeZJ45entAs9jk9+ABJTCHlN/nCQRtIz77+v4nPdEV8+o7t5Ad3yDamjWiYrSZNf6EQ
         L2Pw==
X-Gm-Message-State: AOAM531zQzAHZyFb4fQRefo3xp8Gna4IIuC4s1uv8BVoM5HMwKrH6+6I
        bc8gb9ergPuubtZd3LKHAicpBZLvzXQRtBeNqrI=
X-Google-Smtp-Source: ABdhPJxXLigUtaV0vnWTYcWfdjOvRugPXfC7Zfg+DrWgWwfgQfbs8riiBLD7WTMS6XVavkKb7dtR0jbzw5fhN+WnJSE=
X-Received: by 2002:a17:902:d487:b0:12d:89d3:a6b with SMTP id
 c7-20020a170902d48700b0012d89d30a6bmr15949089plg.52.1629447777328; Fri, 20
 Aug 2021 01:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210820065535.6994-1-nuno.sa@analog.com> <20210820065535.6994-2-nuno.sa@analog.com>
In-Reply-To: <20210820065535.6994-2-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 20 Aug 2021 11:22:46 +0300
Message-ID: <CA+U=DsqgbFUWcAF=S6bz_mOqN+MHjprQxMXZajkeNKAdGquLSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: ltc2983: fail probe if no channels are given
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
> If there are no channels defined in the devicetree, there's no point in
> probing the device. We were actually requesting a zero sized 'kmalloc'
> array but since we were not touching the ZERO_SIZE_PTR afterwards,
> nothing bad was actually happening. Hence this is not really a fix but
> rather an improvement.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> index 37903e9fb90f..7dd2f1dd3685 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -1275,6 +1275,11 @@ static int ltc2983_parse_dt(struct ltc2983_data *s=
t)
>                              &st->filter_notch_freq);
>
>         st->num_channels =3D of_get_available_child_count(dev->of_node);
> +       if (!st->num_channels) {
> +               dev_err(&st->spi->dev, "At least one channel must be give=
n!");
> +               return -EINVAL;
> +       }
> +
>         st->sensors =3D devm_kcalloc(dev, st->num_channels, sizeof(*st->s=
ensors),
>                                    GFP_KERNEL);
>         if (!st->sensors)
> --
> 2.33.0
>
