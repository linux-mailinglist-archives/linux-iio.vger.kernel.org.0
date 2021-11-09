Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE944AB11
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 10:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245034AbhKIKBT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 05:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbhKIKBR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 05:01:17 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF0C061764;
        Tue,  9 Nov 2021 01:58:31 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id az37so37393607uab.13;
        Tue, 09 Nov 2021 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6SCzafxlbGRyr2tFR/3yTcdmhOfLXB8smhgQj+VN/mM=;
        b=VTkNp8JKdqfJwZbB9WiYq3hzv1C+MVgoeu4f0AgfS8nd/lX5XzvaAaAjoI4q22YWzH
         34bUQWvpyuzmpqKNimm1GWvRZantxOdacjMp2MPvjLnUplnodIVlIY64ixYqBZ3B75at
         b251cXbXFjz9C9QNRTzyBhD714W4Jl1AqEavwNYezSpJVU7R52lFrIH66Rds/f7HiwlI
         38xUkNU/Z39tPL83FPYFATJtgL4H6Evr3txKrDkRceOhOU/ImoeuCrqpx7iYX411ZIDP
         D5hY8C2nv4j7BSSrXvJk3XrvHquH0FshVs1A4FEIYL+Zbt4Ieo6DuYL+iulYixT+S6BJ
         edVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6SCzafxlbGRyr2tFR/3yTcdmhOfLXB8smhgQj+VN/mM=;
        b=iKUDkpqj4tQxRRDS37SohRR6C2V+ZHgDbzM4IJl7phNyWQz5Egl2p+Mo6EPdUvM19q
         V7gGj4a4un44PfPCRaCTa4VsquGTr165fG7xn8nd40nKI+sL9VrYq/phYs1jI7Ga9mfq
         D2nuNQl+ojw3pYyQEp2Sjr6aESnViv4A7pmgWRoK27teY3jAm4pkf4bZBphAdomL5iwa
         fsQ0QxRNX0Ito7r941KhU41OHVpPreDry9zC6GrbP6A5HFOsJPiZvuLvE9NQ/wRqcFQl
         SKOKjuFEzNHCosl6MFUM0IybT7tkHnGNyDu/y+HJ/TICKUsfuWqEt3WXvgn/+1q9+yxI
         zCbg==
X-Gm-Message-State: AOAM532gF8c3RQpWXxFbcPNncvibdumaUcsiBfyPEHU9NJ+2YvhCqc40
        CqFqi3zcSyzLKTcwHgAfqi1mCco4nR93EPXYowODQL7ErvM=
X-Google-Smtp-Source: ABdhPJzlS1Ynl/Lq56tV64dzEqzYvWPv4HJJLkXeWWxceP6vLUbok+OHObpb4urfoRG72McMdMg8hg0yrJ5LOHnHO30=
X-Received: by 2002:a9f:3d85:: with SMTP id c5mr8509886uai.12.1636451910511;
 Tue, 09 Nov 2021 01:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-5-andrea.merello@gmail.com>
 <20211028114557.5b4db778@jic23-huawei>
In-Reply-To: <20211028114557.5b4db778@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 9 Nov 2021 10:58:19 +0100
Message-ID: <CAN8YU5M1-tqXaAokjzZJ5aLY_PwK7-3O3PtEFEQ+ONwTLcK44Q@mail.gmail.com>
Subject: Re: [v2 04/10] iio: add modifiers for linear acceleration
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 28 ott 2021 alle ore 12:41 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Thu, 28 Oct 2021 12:18:34 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > This patch is preparatory for adding the Bosh BNO055 IMU driver.
> > The said IMU can report raw accelerations (among x, y and z axis)
> > as well as the so called "linear accelerations" (again, among x,
> > y and z axis) which is basically the acceleration after subtracting
> > gravity.
> >
> > This patch adds IIO_MOD_ACCEL_LINEAR_X, IIO_MOD_ACCEL_LINEAR_Y and
> > IIO_MOD_ACCEL_LINEAR_Z modifiers to te IIO core.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
>
> They sometimes get forgotten but we should also update
> tools/iio/iio_event_montitor.c to handle these new modifiers.

I'm not so familiar with this tool, but it seems like it has to do
with IIO events, which the bno055 driver doesn't use. On the other
hand the modifiers I would add are not used by any other driver right
now.

So I would say that it would end up in adding things that I couldn't
test.. Or is there any test infrastructure for this? It seems trivial,
just a matter of a few defines, so it shouldn't be an issue indeed..

> That can be a separate patch, but also fine to do it in this one.
>
> > ---
> >  drivers/iio/industrialio-core.c | 3 +++
> >  include/uapi/linux/iio/types.h  | 4 +++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 2dbb37e09b8c..a79cb32207e4 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -134,6 +134,9 @@ static const char * const iio_modifier_names[] = {
> >       [IIO_MOD_ETHANOL] = "ethanol",
> >       [IIO_MOD_H2] = "h2",
> >       [IIO_MOD_O2] = "o2",
> > +     [IIO_MOD_ACCEL_LINEAR_X] = "linear_x",
> > +     [IIO_MOD_ACCEL_LINEAR_Y] = "linear_y",
> > +     [IIO_MOD_ACCEL_LINEAR_Z] = "linear_z"
> >  };
> >
> >  /* relies on pairs of these shared then separate */
> > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > index 48c13147c0a8..db00f7c45f48 100644
> > --- a/include/uapi/linux/iio/types.h
> > +++ b/include/uapi/linux/iio/types.h
> > @@ -95,6 +95,9 @@ enum iio_modifier {
> >       IIO_MOD_ETHANOL,
> >       IIO_MOD_H2,
> >       IIO_MOD_O2,
> > +     IIO_MOD_ACCEL_LINEAR_X,
> > +     IIO_MOD_ACCEL_LINEAR_Y,
> > +     IIO_MOD_ACCEL_LINEAR_Z,
>
> It might be useful for other channel types, so probably drop the ACCEL
> part of the name.
>
> I'll admit I can't immediately think of what, but you never know.. :)

But in this case what should I write in the ABI documentation? If I
state that this is something that makes the gravity not being included
then isn't it intrinsically tied to be an acceleration?  Or, I do
that, and if someone eventually finds another use, then she/he will
change the ABI doc?

> >  };
> >
> >  enum iio_event_type {
> > @@ -114,4 +117,3 @@ enum iio_event_direction {
> >  };
> >
> >  #endif /* _UAPI_IIO_TYPES_H_ */
> > -
> ?
>
>
