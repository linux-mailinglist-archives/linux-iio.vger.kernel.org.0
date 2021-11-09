Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2144A838
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbhKIISH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 03:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhKIISH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 03:18:07 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EF7C061764;
        Tue,  9 Nov 2021 00:15:21 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id l43so36928616uad.4;
        Tue, 09 Nov 2021 00:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rtQs6j/Tm8dLc64xSXahWAxIc1oOwGIaWX22GHV5zpE=;
        b=GTZ+Eolk0qHglY4KGiRYpDlbuKBm33j6rLTvOonaqbJCrUnbKAmILLg0f0qgKTCp5s
         6snIijBnG8XANUlqLhKoOirNY07s2E1VGJQUSMVqJWrGmpcU87Qrji5JKi38VqnCTF5J
         6tW7UZmLIvZingYlaxX9g+l+HHHW0gK0ZAMJX+yyWWM7q3lEh4m1HcpYZ3uayuHd0GSX
         J3IuVSa/lpWIejSiNjCwdlL/Y3DsepjqN4KM3gVlYZ77WU4oX6/4XAJZltKS9q6FKaV0
         0PmmFKaLy4fqF4b4QQ5gTKamp6j+Iq7qT9A3bgrOl5vYDea4sBhPFTvrk5OCUd3AWeu5
         AE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rtQs6j/Tm8dLc64xSXahWAxIc1oOwGIaWX22GHV5zpE=;
        b=fVZGkvdJNIBgOd/p5WbAOFJ0i2PbrJ+Nn3XTVVVxxsQNBMSzsjl8GuSMKhe42fGvHa
         wa4xAcRmQsCr5/xrArYEttV2ptUptfRdvqUNUB4O3KchjdX3wIRFrquufFp+A1SMsqyN
         JKGJqem6DSAoDplR0RiD9gRE/Ki0glZE3/kNXb6b+6fZcYibY/giOk0UFTAuwL3flhd1
         bPUmKxxAGirjLVgSRgadxJqZ+AXtqDBgQPJYr3yJTgZsH6hj9W8QjsaUU/C9PdNIDEpS
         GWIoMAzdfIlnmIN8bgDLvpB33ec89vBhaChXF/thD1nzIWxFDAfJfrZhbv0Qsr5QZTjz
         toFw==
X-Gm-Message-State: AOAM5314Sm94566gIs3wiS2bHE6XwXmr4i6epsBibupaYIjpknZeQjRZ
        ZJe9FRmlkN8s73+FVl8oTKnY/Qbz1npsYmadiXg=
X-Google-Smtp-Source: ABdhPJyX7ZiC8tTuQH95UGaZR23hNqfa347+EkS/MHYig0jEKfPnC5Xco+e8L61HTi8gyyYwFYyg0meXPvN/rqB6eRg=
X-Received: by 2002:a67:df07:: with SMTP id s7mr8983102vsk.42.1636445721133;
 Tue, 09 Nov 2021 00:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-4-andrea.merello@gmail.com>
 <20211028114154.19e596fc@jic23-huawei>
In-Reply-To: <20211028114154.19e596fc@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 9 Nov 2021 09:15:09 +0100
Message-ID: <CAN8YU5P97Au5Sq+43czRygGo4saywhR6BzefAsNz8ffDB3uEcg@mail.gmail.com>
Subject: Re: [v2 03/10] iio: document euler angles modifiers
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

Il giorno gio 28 ott 2021 alle ore 12:37 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Thu, 28 Oct 2021 12:18:33 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > This patch introduces ABI documentation for new modifiers used for
> > reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 5147a00bf24a..f0adc2c817bd 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1965,3 +1965,11 @@ KernelVersion: 5.15
> >  Contact:     linux-iio@vger.kernel.org
> >  Description:
> >               Raw (unscaled) linear acceleration readings.
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
> > +KernelVersion:       5.15
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Raw (unscaled) euler angles readings.
> Any _raw entry should also include what the units are after application of
> offset and scale.   Or you could just add this as more info to the in_rot_raw
> block as an extra sentence explaining that they are euler angles.
> That will lose the 'KernelVersion' information but honestly I'm not sure we
> care that much about that.

I'm unsure which block you are talking about: I see there are two
blocks that refer to rot things: in_rot_quaternion_raw and
in_rot_from_north_xxx_raw.

Looking at the 1st one description, it looks very specific to
quaternions to me; the 2nd seems very specific to its own thing,
whatever it is.. So I would just add the missing information (unit) in
the new block just being introduced, if this is ok for you. Or am I
missing some other block in which I could  coalesce this new euler
thing?


> Jonathan
>
>
