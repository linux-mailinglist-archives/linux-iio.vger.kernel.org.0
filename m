Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9822D356
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jul 2020 02:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgGYAij (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 20:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGYAij (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 20:38:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18898C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:38:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so6418652pjw.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=pE53PJx4zNCD8hPNEyyoRgUlvBxFwC1YpIyf6QdTrM4=;
        b=KM4knRI53Zyrr7+T3D4cTXIMmixLqzJjLyc3IJWY2KWtsJUJbZTmlK8sGX+ycYUjAa
         47piqNY3VzJWvvQXdPbMntSeItUbmcgvNMIp9BcOyZUi1hMkV2u7wwjZGFppnV0Or9jY
         RiAuHtxx91o0YEvW+wAJgOn3XOKnpLyQ0rGEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=pE53PJx4zNCD8hPNEyyoRgUlvBxFwC1YpIyf6QdTrM4=;
        b=MCGYmGrBm+aCqmBz1rWr0filUGUFq1MAwaQjfPe+Kx4x/S5jXw5LuSx0gzTuEnM0Mu
         wp79PafjBnCkhzvUNd0N4AdL61Zc4ixpqdrKXbH2FbnWH/eStQ87p853gcIOjSXwInj1
         yZjxJ+3iNMIjJRBAPhcbBgSg56d7Y7z8TUaA7ocN2yqHRn6WYnbCkfyUYGOp5hC9M6PN
         icth8ZyqfhDS6pBjcnn8lTNJW9eXQNsP9e4iNCnqoz8WtGJBIg2kZZnG4Ao1ZIR6kkJn
         H8eomj3GSRVBm0sbki8XvesvM0c9lc9pYZSg4UQWeCKNVoyIgWuFMdNLoy95mDQboyhQ
         Y4Pg==
X-Gm-Message-State: AOAM533/36DdIGHYLPb2QO0Z9+qgSJLo0Om5fV8I/yNpBAXY5rSahuSa
        GxrA92OeD1vnQNjLNadpf/2FdQ==
X-Google-Smtp-Source: ABdhPJxj5Tg+zb8ZgMg/j5mqGfeeFbFGe/CKiDtOXX/s8FL5QvRC3pmbz01OwKqfw+YqAmzMf6jWNA==
X-Received: by 2002:a17:90a:89:: with SMTP id a9mr8170235pja.171.1595637518234;
        Fri, 24 Jul 2020 17:38:38 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c187sm7538391pfc.146.2020.07.24.17.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 17:38:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WKTsCB=7rDSgjqE5w00SsayBd5OT9O65sjkiM9crS5aQ@mail.gmail.com>
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-6-swboyd@chromium.org> <CAD=FV=WKTsCB=7rDSgjqE5w00SsayBd5OT9O65sjkiM9crS5aQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: sx9310: Enable vdd and svdd regulators at probe
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 17:38:36 -0700
Message-ID: <159563751654.3847286.14653890659248238783@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Doug Anderson (2020-07-24 15:02:23)
> On Fri, Jul 24, 2020 at 2:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9=
310.c
> > index 1e1f6bba50f6..ad6ed100c7a6 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -919,6 +929,23 @@ static int sx9310_probe(struct i2c_client *client,
> >         if (IS_ERR(data->regmap))
> >                 return PTR_ERR(data->regmap);
> >
> > +       ret =3D devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(suppli=
es), supplies);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D regulator_bulk_enable(ARRAY_SIZE(supplies), supplies);
> > +       if (ret)
> > +               return ret;
> > +       /* Must wait for Tpor time after initial power up */
> > +       usleep_range(1000, 1100);
> > +
> > +       /* Update sx9310_regulator_disable() size if this bug is hit */
> > +       BUILD_BUG_ON(ARRAY_SIZE(supplies) !=3D 2);
> > +       ret =3D devm_add_action_or_reset(&client->dev, sx9310_regulator=
_disable,
> > +                                      supplies);
>=20
> ...but, but...  Aren't you storing a pointer to stack memory?  How
> does that work?  I think you either need to store the "struct
> regulator_bulk_data" in your private data or just make two normal
> regulator calls.
>=20

Doh, no coffee today.
