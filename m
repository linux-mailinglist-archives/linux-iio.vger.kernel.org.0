Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68822F5F
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 10:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfETIyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 04:54:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45884 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfETIyL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 04:54:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so9347936oie.12
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hIKV/w2j66E6QI9UOehoIwAQO7bXnT3t8ap2YopZgBY=;
        b=KVbnKxIJUPI2ryT+pdmyeObntTTDS28A/42YGHaOMdZpzz8h3ueHjRi7AvrcBIB3ih
         TH3pgo1b2BMrHpQUvSuQ9L/qohKAXohTq+uxRVe1J2q7yr9DWN/PwKsTzrX2+FnVeXvH
         VkBMpKsmAuJjh7QWxWvdJ2TvTfyeUmT1ppdBKZsrLkKDPZcsBn5jZIxfzRMbGPkeeU9M
         ShwcfDkQb35ouotEybTOvUdgIhfVBYrd1Voz3c6y8Pmz+YUk1miTjtn8h+OR0uP86NOQ
         xRrgcU7zcVYVnyzWQLnLvUeZH9oQgzkpSoN+KMiy7jFmMGllMyX/IzQZAmebRBiJqd4v
         qWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hIKV/w2j66E6QI9UOehoIwAQO7bXnT3t8ap2YopZgBY=;
        b=aF13p6s17uu/jvq1u6F0yAiYhyqOdxK50MDc1j01QJoPeZuzLU6G463puix/FMB6q1
         Jc6VNpxSCJroaPfU/Fq85PwdkaVc2eAwrdDP+InmDHaAH78FCl3C0pMhKyhO0y3FbRwG
         xnDDu6x9Okl/CUIlSi3vs3Vy2OS8356ORnEKalEnYIIZH2tNWsGsQX8C2JYFGhCcmXhs
         vESuS+n45c9DZ88SB5oub7vhalEGdtXhhmO/tgxY0fPra+ZDdKWGx4LnmEmjJeQIyUcb
         xQz6z1Snr7nt/jd98rMTjPmc3nvI3yZ97a9PrqP2CpGiDMEFY5ouFrSOLcYz9l1+YCUd
         UlxQ==
X-Gm-Message-State: APjAAAW2y1Uicrp06lALCXiAZgZz4T88gZipxcC+n5tJg8B48mv/SYVk
        zyrEPVWlX18nQhsb3KGOMipWrH10ixaHJAdYBSIjbcNpCdM=
X-Google-Smtp-Source: APXvYqxr1ru2jmLJxBackc92D97sSS00hm8KoIknvpQMCEhESXEO8Uia718GUII4tMPjmBnwoPmtJ1na+N2O/+GHNZA=
X-Received: by 2002:aca:6208:: with SMTP id w8mr22215737oib.128.1558342450784;
 Mon, 20 May 2019 01:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190518213511.23253-1-barbara.fernandes@usp.br> <20190518213511.23253-2-barbara.fernandes@usp.br>
In-Reply-To: <20190518213511.23253-2-barbara.fernandes@usp.br>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 11:53:59 +0300
Message-ID: <CA+U=DsoaujpbnMGb8TB=hQoV1rnEpKwmwxcyNKVnw2Z=oCHq4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7150: create of_device_id array
To:     =?UTF-8?Q?B=C3=A1rbara_Fernandes?= <barbara.fernandes@usp.br>
Cc:     linux-iio@vger.kernel.org, Melissa Wen <melissa.srw@gmail.com>,
        Wilson Sales <spoonm@spoonm.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 12:35 AM B=C3=A1rbara Fernandes
<barbara.fernandes@usp.br> wrote:
>
> Create structure of type of_device_id in order to register all devices
> the driver is able to manage.
>

Hey,

CC-ing my work-email
There are some issues with it and mailing lists; I'll hopefully sort
them out in the next weeks.

> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> Co-developed-by: Melissa Wen <melissa.srw@gmail.com>
> Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> Co-developed-by: Wilson Sales <spoonm@spoonm.org>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/a=
d7150.c
> index 4b1c90e1b0ea..072094227e1b 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -655,11 +655,21 @@ static const struct i2c_device_id ad7150_id[] =3D {
>         {}
>  };
>
> +static const struct of_device_id ad7150_of_i2c_match[] =3D {
> +       { .compatible =3D "adi,ad7150" },
> +       { .compatible =3D "adi,ad7151" },
> +       { .compatible =3D "adi,ad7156" },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad7150_of_i2c_match);

nitpick: you don't need to add i2c in the name
so, this could be just
MODULE_DEVICE_TABLE(of, ad7150_of_match);

but it's not a blocker for this;

So,

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> +
>  MODULE_DEVICE_TABLE(i2c, ad7150_id);
>
>  static struct i2c_driver ad7150_driver =3D {
>         .driver =3D {
>                 .name =3D "ad7150",
> +               .of_match_table =3D ad7150_of_i2c_match
>         },
>         .probe =3D ad7150_probe,
>         .id_table =3D ad7150_id,
> --
> 2.22.0.rc0.1.g337bb99195.dirty
>
