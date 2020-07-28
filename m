Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32BF2312CC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 21:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgG1ThL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbgG1ThI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 15:37:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AD0C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:37:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id il6so521337pjb.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=WOytNOYdjoyQeyYGVaSbj/fyQAzB+x+3wm3EXC3QX2Y=;
        b=SPKVrvhRFhpeKXlLyjw5E/NFgSx9MbKRg+6J4RzF9Amj9FdlXPwWWQ3/aSD74RQ02O
         bAMVX7KZIAkurguRcNjvMsQkSEK7EvCUjs49sCDJTCre8XUB0QMH7tMWpZsvrmsGS083
         bnde4uXYzHj3iAWiYPYZRyv00gpaBHgLvbhSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=WOytNOYdjoyQeyYGVaSbj/fyQAzB+x+3wm3EXC3QX2Y=;
        b=gH/XNeKj1h2ki7u0OAFDNsdDW3Ky6dEWsgr0DR3hYCpcswfK9HuDAopKceoN+lttuJ
         UxbpqmfFlhRHETQ1Hsep+MQEBKkuFsnRvMBebXS4LWqON94sIRnPwK1JUQFBzUvcN21+
         x2uH/PxZUxNTYalLrzdElEaLFt7w+IJZjwqfTNO6PGRFxdWnhqLV+CiojSz3CvdnSUo9
         zZLhO5/k1xhBkcMm0W+NrVumNU8gfCEmb57Yxkn3cpDnDyIdoTE5S1S9JrnS/zD20Th/
         Pc/xa7+bUsYmuOwCuwbJWhQV4+poF9LAy4cS7mlJDXZLMD1vl9K6WZfe6KJFln0AsY8J
         oMUw==
X-Gm-Message-State: AOAM531H7J0z4D+fZHsyjgS1/nSdj0Zeb5ICB2M6fn5aLyvMw/DFQAEX
        LXwCfcsv14MX5mHwK0GP/LU7PA==
X-Google-Smtp-Source: ABdhPJyAbJyTn98AQzC1WWA2O6iMJbhi2p9+5jYQ3N7r4vZaonu2H4R7Z6jDh72fQ1+hADV9yUmRQQ==
X-Received: by 2002:a17:90a:a58d:: with SMTP id b13mr6400002pjq.55.1595965027396;
        Tue, 28 Jul 2020 12:37:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a193sm1837778pfa.105.2020.07.28.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:37:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.7.I3a5582a3e1589e351f6335b39f52e5ccc5f46b61@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.7.I3a5582a3e1589e351f6335b39f52e5ccc5f46b61@changeid>
Subject: Re: [PATCH 07/15] iio: sx9310: Use long instead of int for channel bitmaps
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:37:05 -0700
Message-ID: <159596502543.1360974.12774369809044939362@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:50)
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index fb5c16f2aa6b1a..2465064971d0a7 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -538,13 +540,13 @@ static void sx9310_push_events(struct iio_dev *indi=
o_dev)
>                 return;
>         }
> =20
> -       for (chan =3D 0; chan < SX9310_NUM_CHANNELS; chan++) {
> +       for_each_set_bit(chan, &data->chan_event, SX9310_NUM_CHANNELS) {
>                 int dir;
>                 u64 ev;
> -               bool new_prox =3D val & BIT(chan);
> +               bool new_prox;
> +
> +               new_prox =3D val & BIT(chan);
> =20
> -               if (!(data->chan_event & BIT(chan)))
> -                       continue;
>                 if (new_prox =3D=3D data->prox_stat[chan])

Why not make 'prox_stat' a bitmap too and then xor them to iterate over
that bitmap instead?

>                         /* No change on this channel. */
>                         continue;
