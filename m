Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD836738E
	for <lists+linux-iio@lfdr.de>; Wed, 21 Apr 2021 21:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhDUTmK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhDUTmJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 15:42:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF27C06174A;
        Wed, 21 Apr 2021 12:41:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p67so24912315pfp.10;
        Wed, 21 Apr 2021 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nRBx/55JbHQxbFmenDwMWp+CYHgyy9UiP1byrqk81Io=;
        b=I1kdklP5Gl0iIFWPPfyW98fYUbH6ZFjxU9wdEv3H/VBi8p01xwntSWaqeCmq1aFAN+
         wbIWC4VeSuVkp2nMIdpFrcRP3Q0L46S4rvp6XVM7Se1Sr6Y8t0oDW2jlaSXjYDnsLygv
         7eSHbXYtmExIOfkm98qMa6cRJXX2N14JuO7jtktCiTcvijg55fOOat+pvE6nuGHdN5B/
         3+tN67/R9kPhP45NhyP5UuzFp7lcanYRgjRoUWoYlXcv9SZPzLgwlXOloICdf+QoMy1U
         a1gG0NbU8aXeOpog95RnsN7iu5L1Ky+8LwIGJyJA1gnTtcKsUzXIhgJiIicdA5qBa12u
         3Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nRBx/55JbHQxbFmenDwMWp+CYHgyy9UiP1byrqk81Io=;
        b=pYM2FoR2jh0HZUBEKlq7wPDzxb5Tqj39IDx5WvKBolVj9DcGVpJ5f9tLtpvKJuYI0i
         olDjp190Hmg0HSYh69bkLpc3Bvk60zl5y5dMr8WsPRgDCtUq1MMvHAogZphUE9SEZw4H
         DtcQNlVeR1lTVk6vMzBr8tacbj9b7lJxvBxjLUUVQi6b0Xysb81vrFSaQSbJ0R+eQBtb
         IqqdlmB9BQQ3dbsMgfOOHF5GpPPXGPsMEnf7DaSkgflVbOveu4EJVa4smaOsEnD/48cL
         C3L7xXU7TVuweHjLzkYySMwme3AOLccU4nYT0+bL5xTALILcsSZQt0zFJY6WvgTdAtSc
         Euow==
X-Gm-Message-State: AOAM531Fi79mucJef+Q1P3sGKf3Gl6sf324GwFiTMYvkDqlVkxvLb39j
        s7IAJ9McPOHt8adNbv2lrvjHHwNHlhYp+R6XEJM6kpOqiYo=
X-Google-Smtp-Source: ABdhPJwW4KtpJ1Nvt1U+nEt8BVDwRzPRIJApRIZsHKMKrffT0qyjL4mjYRXOJWp3XJzE5VyxNx7mBmgMFcJ6aMoeQi0=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr31633820pff.73.1619034095723; Wed, 21
 Apr 2021 12:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com> <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
 <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
In-Reply-To: <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Apr 2021 22:41:19 +0300
Message-ID: <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com>
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Nathan Royer <nroyer@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 21, 2021 at 10:05 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 21, 2021 at 1:14 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> > On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com> wro=
te:
> >
> > > I found a non-kernel example
> > > which uses a similar equation [1], but in a different form. The main
> > > difference is that the Arduino code interprets a raw temperature valu=
e
> > > as a signed integer, while upstream assumes it's unsigned.
> > >
> > > [1]
> > > https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU3=
050lib.cpp#L111
> >
> > Oh that's nice. Room temperature as mentioned is 20 deg C
> > I think?
> >
> > The divide by 280 part seems coherent in all examples.
> >
> > > Still, even if assume that the raw temperature is a signed s16 value,=
 it
> > > gives us ~35C in a result, which should be off by ~10C.
>
> Actually here [1] it says in chapter 3.1 that room temperature is 35=C2=
=B0C.
>
> Range: -30=C2=B0C .. +85=C2=B0C
> Sensitivity: 280 LSB/=C2=B0C
> Room temperature offset: 35=C2=B0C =3D -13200 LSB
>
> [1]: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf


So, if I'm reading this and the register description right the value
is in the range
-32768..32767.
-13200 defines 35=C2=B0C

50000 as mentioned by Dmitry is actually -15536. So, it means that the
more negative a value is the higher temperature is shown.

Since it's linearized scale, now we can see that

(13200 -15536)/280 + 35 gives us 26.66.

Does it make sense?

--=20
With Best Regards,
Andy Shevchenko
