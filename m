Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1420F2312E1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbgG1Tkk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgG1Tkj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 15:40:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63805C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:40:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so1109925pgc.8
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=JnSoXvhnrCfqq1IVWszLYrvihUBdm83Lj44jYdRdMcc=;
        b=iv4onD3Q0axPdhjPEQWHtuqyzI77tyLiN+xmtu+WNHS9v9p/q/rDCJ8iyKFN/gqtxb
         tPgvAIFTgJ2rCYVu0wXWuUe40pCCt/cAMTlQ7haEDHYEJC++ZGQWVET3Bf/wARWgPqN3
         jVE5YRzQGHlUqg+xYBtPJ6PxLXrZ7C23fDmVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=JnSoXvhnrCfqq1IVWszLYrvihUBdm83Lj44jYdRdMcc=;
        b=HQXXyembU2XxInGYjGaWXeGYacNRFrpr8u1DYw6zSQwU8PEVHyuBl+w4LS2eKC2BUE
         1zwsFAXwng/0cy6yQvebYdOH4DPXB1bNiAOv2f22rQSeqA1IcUVLzj31qR8RpTQuUblp
         s2fgViZO3986aUDg63fR6xy98UEuTrviJRpnpDowsFZAzsFMEkxyzND9niPIsF0OCUBj
         bVpO8fN11zj8ImPEETRliH+Pm/Icf9RsKAenniuGKqQZrZJC0CDnpyQ4lKxiEgTyao41
         0Abos+jdOVs7XkXjVPgF6ljh5DAr95GNBm1CLVzzlRhdMOX02irnJA7RQZuQ1nTooJam
         tmYQ==
X-Gm-Message-State: AOAM531ufeCb5pb+y6rhFhCQcns7TxBPrdmwzh2tlZxnQOeBb+GnK8DR
        Yu5Hcl50JY2UPS/E1x5foAluew==
X-Google-Smtp-Source: ABdhPJwdqO+peLZuIrIf2EXNYz9eMWKLPKmq06FaQ4DBBzeI8IjM+GcWNrZ8R37eE4hwpm1iVcMfRg==
X-Received: by 2002:a63:d446:: with SMTP id i6mr24699884pgj.438.1595965238995;
        Tue, 28 Jul 2020 12:40:38 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u23sm18952725pgn.26.2020.07.28.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:40:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
Subject: Re: [PATCH 10/15] iio: sx9310: Simplify error return handling
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:40:37 -0700
Message-ID: <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:53)
> @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310_dat=
a *data)
>  static int sx9310_read_proximity(struct sx9310_data *data,
>                                  const struct iio_chan_spec *chan, int *v=
al)
>  {
> -       int ret =3D 0;
> +       int ret;
>         __be16 rawval;
> =20
>         mutex_lock(&data->mutex);
> =20
>         ret =3D sx9310_get_read_channel(data, chan->channel);
> -       if (ret < 0)
> +       if (ret)
>                 goto out;
> =20
>         if (data->client->irq) {
> @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_data=
 *data,
> =20
>         mutex_lock(&data->mutex);
> =20
> -       if (ret < 0)
> +       if (ret)
>                 goto out_disable_irq;

Why is this condition checked after grabbing the mutex? Shouldn't it be
checked before grabbing the mutex? Or is that supposed to be a
mutex_unlock()?

> =20
>         ret =3D sx9310_read_prox_data(data, chan, &rawval);
> -       if (ret < 0)
> +       if (ret)
>                 goto out_disable_irq;
> =20
>         *val =3D sign_extend32(be16_to_cpu(rawval),
