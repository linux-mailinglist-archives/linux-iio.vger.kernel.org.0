Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB88E343ADB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 08:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVHoh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCVHoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 03:44:09 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B9AC061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:44:08 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j26so12887580iog.13
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2q71OD67pGjc49k7ytNMN66b3ueVPJSuoqC1QriKVQU=;
        b=p8qkZRDw80N2ruyh4uTTIOxfivDEj7bdggXp0FnTdRynamh2/LacAmr/iSnt0Ry8af
         kpslNx6cRy5SeIFdkM6jpTW8IsbOeNYQNn9qHOJ1B9I3O7meLbSkNODBdVInnG+xPF7D
         PE8TbJHmBtaaPgEuAzP4HnvGAVHdqqRPxeAntdIps35AAFE71W285D/tiiQt/h2S2N8U
         7xO8wzobeNHTs9AczhRk3G9rziKHDHND+0A838xfUpam3tT2iKIBGH1BcdPgKi4xdRAy
         n40uhrn220dgaexob2SQqstpNP1b0jx51/pArhAZbi4qgoajHU2f6/UnjkWRtVeAPQGc
         9Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2q71OD67pGjc49k7ytNMN66b3ueVPJSuoqC1QriKVQU=;
        b=h6b8LmdPR1bozMghkdFcFF2aXfFeJaZXKdHkbasT6BIcNuBrI5Sp/65X8QKZzBhVxd
         MezLaHnECA7paudEG/zg7ORrWJln97xxf2yXvKiDMLmShI6SYHMF96TRQu46Xs3mydY7
         22hje/iryRAAp25cL1Ij1+9kxjmdOqazsCLeM3qsryf04PtjgpZWQHkptixwamBQOytO
         Sd8n7a9oL8zT36cVUB4YaaNiTh1bYW+47n3yjX88FnhkIRhUJ9qAhK/a9kv5sZLbaYpu
         w9JhWMP3NwRtOWv+nkt+RztI3DnJnenCshpxmldMUA5v5rbcZDg2ABlus3PBcFika+13
         L8BA==
X-Gm-Message-State: AOAM533yRTt3ibWN8jmoX3FeKbviLaf5uATrNusi3XlvJK4oIIvxK1qj
        nMt9M/mvx9Ha+iIW7mpA/Lc3GyA5wJNWshwn0ec=
X-Google-Smtp-Source: ABdhPJzgu8imTxi6KhkPIpSiLEx5ZOp5uKWcG41DNmHX4Ut2WOPChl7KtuerbT9tlZAXlvbZT27oqkbQNmNPllmVSb0=
X-Received: by 2002:a02:9663:: with SMTP id c90mr10152824jai.16.1616399048362;
 Mon, 22 Mar 2021 00:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210321182956.844652-1-jic23@kernel.org>
In-Reply-To: <20210321182956.844652-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 22 Mar 2021 09:43:57 +0200
Message-ID: <CA+U=DsqiYC7Gq3N_htgAmLrRXBvJtfV1urFoG2aYVf=G15hB9Q@mail.gmail.com>
Subject: Re: [PATCH] iio:accel:adis16201: Fix wrong axis assignment that
 prevents loading
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 21, 2021 at 8:34 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst running some basic tests as part of writing up the dt-bindings for
> this driver (to follow), it became clear it doesn't actually load
> currently.
>
> iio iio:device1: tried to double register : in_incli_x_index
> adis16201 spi0.0: Failed to create buffer sysfs interfaces
> adis16201: probe of spi0.0 failed with error -16
>
> Looks like a cut and paste / update bug.  Fixes tag obviously not accurat=
e
> but we don't want to bother carry thing back to before the driver moved
> out of staging.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: 591298e54cea ("Staging: iio: accel: adis16201: Move adis16201 driv=
er out of staging")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Himanshu Jha <himanshujha199640@gmail.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/adis16201.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.=
c
> index 3633a4e302c6..fe225990de24 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -215,7 +215,7 @@ static const struct iio_chan_spec adis16201_channels[=
] =3D {
>         ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, =
0, 12),
>         ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_=
X,
>                         BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -       ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_=
Y,
> +       ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_=
Y,
>                         BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>         IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
> --
> 2.31.0
>
