Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CCD2314A5
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgG1Vcb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgG1Vca (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 17:32:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C58C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:32:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so706104pjd.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=nog6I1ImyNyq0+O1gfRhInkU2I7Jgi2bEICANP1hoBw=;
        b=YK8aGH7hGj9Nh6bAPQGpVfyPuUN02hUZ+fVn6ryvf2tirGFUVzuzD4fUiRq8a4QYS+
         grQHh7nvHbbXR/0d9nx9zOzqiWJKYbBXC6HV8bcyIELt2xk9opR02IU5ztm7C2XDaS7G
         mixfOgJxHyYaYryaQrM1zPmxoMl6q4/pB86Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=nog6I1ImyNyq0+O1gfRhInkU2I7Jgi2bEICANP1hoBw=;
        b=G+apW6UzIg//jiQxwQcigWXIt+EgcmQvlZ+uKswrDZxgEHfPqHbqVn4J23B5YmCb/F
         HzTUJ9bHWuDzbUuv+3Z04FcDVvxFVlBQy8YJHpg7LFrZ0qF/iwnVytvpsAG6KAf69adJ
         tKWlKByNrr4PaMoMOpj3qU73TTdMAXp2g2laDmQtLiAzZkcsHl63J5K1rJGDhBqt4QZT
         a7mnQj79izJ3nKv28ozkfjNjJdtruFRFQYA5Jn6mnrsdChwUMFtmGzJUdBzkD1f4rOu1
         D5NjLJkEGxxfHNIGd9UfV/2GWdIXcJxyOG3gfssXWFL1uELrhdj1uX06/8wFTXR8mXAG
         lF/A==
X-Gm-Message-State: AOAM533MOLDyuYkfNaazY8qhbXocWSw/2c/ks2MDH3q5tLH6JyzxM54C
        /WOlgeBc76CmLnVnpKc3K4ZwCw==
X-Google-Smtp-Source: ABdhPJxfaoR6u1bnMbcNU4Ms4jruAX1+/p/Idf0FpyzChRlmxP09b+wzBqi2CIeuf6OuBlcixrnPJA==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr11281085plo.201.1595971950196;
        Tue, 28 Jul 2020 14:32:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id f8sm18693pfk.107.2020.07.28.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 14:32:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid> <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com> <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
Subject: Re: [PATCH 10/15] iio: sx9310: Simplify error return handling
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:32:28 -0700
Message-ID: <159597194837.1360974.9212489704079396891@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 14:23:29)
> On Tue, Jul 28, 2020 at 1:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Daniel Campello (2020-07-28 08:12:53)
> > > @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310=
_data *data)
> > >  static int sx9310_read_proximity(struct sx9310_data *data,
> > >                                  const struct iio_chan_spec *chan, in=
t *val)
> > >  {
> > > -       int ret =3D 0;
> > > +       int ret;
> > >         __be16 rawval;
> > >
> > >         mutex_lock(&data->mutex);
> > >
> > >         ret =3D sx9310_get_read_channel(data, chan->channel);
> > > -       if (ret < 0)
> > > +       if (ret)
> > >                 goto out;
> > >
> > >         if (data->client->irq) {
> > > @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_=
data *data,
> > >
> > >         mutex_lock(&data->mutex);
> > >
> > > -       if (ret < 0)
> > > +       if (ret)
> > >                 goto out_disable_irq;
> >
> > Why is this condition checked after grabbing the mutex? Shouldn't it be
> > checked before grabbing the mutex? Or is that supposed to be a
> > mutex_unlock()?
> We acquire the lock before jumping to out_disable_irq which is before
> a mutex_unlock()

Does this function need to hold the mutex lock around get/put_read_channel?
It drops the lock while waiting and then regrabs it which seems to
imply that another reader could come in and try to get the channel again
during the wait. So put another way, it may be simpler to shorten the
lock area and then bail out of this function to a place where the lock
isn't held already on the return path.
