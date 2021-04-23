Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584D0369443
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhDWN5P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 09:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhDWN5O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 09:57:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CCBC061574
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 06:56:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so1218099pjx.5
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q2r4TMc91iaMtJTQ7NpNLrQzrRAOSL+yBUctMmDUgT8=;
        b=Lh3vBTaKzo7RYM3gWDxxg6uF8uDtxcqoiEoIollP1ajJA2hzGNnXqNf93Z85+Kd6gk
         T/Hx5y9olwcyx+ol97CKojeGMysNZh+5Y7W+/1tCZ7fX+BHG93KpRwFglelciwrhv4u3
         EiovBKAt7bDJQ/ZQsF+tGw8pPZDfdLpxolBRJZS053BkCERT7hE3eqf0Ai0r7ek2FAS6
         mzLpcwWCTgQepEpeobQ7ZrQNiYtHKy8sLWpgcgmjRGpL7x7eTKEGTKteTF2q1ijZYLkP
         Kjr7XTy+jRGR1Rps3+hgRwzGrxOoTCJwRtxAeYqcZlNxhs/z2yW76aqYtcNEVnAFjA0Y
         xjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q2r4TMc91iaMtJTQ7NpNLrQzrRAOSL+yBUctMmDUgT8=;
        b=tyZyuLKKffvAPfBE+yTM23m470k+yZTQ7lNk1ZYjkT/Jv0G/dk/bGs8lmtCJeKL74Y
         f1LifvN1SKExc1yUDmBclj/YiwM+aSAqRPYaYgoj92sN55c8/EKenQuR7CU50RX+LpaK
         wEs+uElOkRohQkB1rhO2zgbrsOounDx8E97dA/PYk5EK+4WqUX2i7qs9k2bzpg/p09yi
         FtNI2Zoz/dJG4dxInT7887p3V8ZZ+2z4sTurSUFJxiUlm6kGt245OMIAtGPOPIZcm5RJ
         Sn2oVrIbRXUXXERSkF7FW1GwmxEZ9Wbo9SK6ODCWqkBYM1PXEeqzapEZOT+hdIHMid7/
         hkKg==
X-Gm-Message-State: AOAM531jJYaTn6J76uG5X1Dd10ibXzh9kGRj6uYoC9UxwoiDmQiXTq8v
        /BA0Sk3MEb/aryWRZ7H3+frgy69vGcH295ue/kZ62Hredps=
X-Google-Smtp-Source: ABdhPJy1MrMXRTBMj2hx9cbro8v955XxdSqTyEJC5uX9RS9rEJJjczzbFLdL8fQ6jV2TdsqFhAxMyxudPpVyMDVJAfU=
X-Received: by 2002:a17:90a:2807:: with SMTP id e7mr4676418pjd.181.1619186197993;
 Fri, 23 Apr 2021 06:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-7-nuno.sa@analog.com>
 <CA+U=Dsphpu97Et6sgjd+9TUEHTw7xq44M5yL=CFtuCEU9QLxQQ@mail.gmail.com> <CY4PR03MB311220A749133B44C778F9F799459@CY4PR03MB3112.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB311220A749133B44C778F9F799459@CY4PR03MB3112.namprd03.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 16:56:26 +0300
Message-ID: <CA+U=Dsp08Hv7KtV_K=mG9RfDWpTezhPa0Xjp_R7jZrAuOqKz_w@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] iio: adis_buffer: update device page after
 changing it
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 23, 2021 at 3:20 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Sent: Friday, April 23, 2021 9:33 AM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: Re: [PATCH v2 6/9] iio: adis_buffer: update device page after
> > changing it
> >
> > [External]
> >
> > On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com>
> > wrote:
> > >
> > > With commit 58ca347b9b24 ("iio: adis_buffer: don't push data to
> > buffers on
> > > failure"), we return if 'spi_sync()' fails which would leave
> > > 'adis->current_page' in an incoherent state. Hence, set this variable
> > > right after we change the device page.
> > >
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  drivers/iio/imu/adis_buffer.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/adis_buffer.c
> > b/drivers/iio/imu/adis_buffer.c
> > > index a29d22f657ce..dda367071980 100644
> > > --- a/drivers/iio/imu/adis_buffer.c
> > > +++ b/drivers/iio/imu/adis_buffer.c
> > > @@ -140,6 +140,8 @@ static irqreturn_t adis_trigger_handler(int irq,
> > void *p)
> > >                                 mutex_unlock(&adis->state_lock);
> > >                                 goto irq_done;
> > >                         }
> > > +
> > > +                       adis->current_page =3D 0;
> > >                 }
> > >         }
> > >
> > > @@ -151,10 +153,8 @@ static irqreturn_t adis_trigger_handler(int
> > irq, void *p)
> > >                 goto irq_done;
> > >         }
> > >
> > > -       if (adis->data->has_paging) {
> > > -               adis->current_page =3D 0;
> > > +       if (adis->data->has_paging)
> > >                 mutex_unlock(&adis->state_lock);
> > > -       }
> >
> > So, continuing from my comment here [1]:
> >
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/li
> > nux-iio/patch/20210422101911.135630-6-
> > nuno.sa@analog.com/__;!!A3Ni8CS0y2Y!u1RyPNeh8e5m7lPfDa5H5ZjT
> > hA9TdsLGvk2m1kFQBbAKe40PmvQS8O8N-f-GEg$
> >
> > This can become more elegant, because this block:
> >        if (adis->data->has_paging)
> >                 mutex_unlock(&adis->state_lock);
> >
> > can be moved right after "ret =3D spi_sync(adis->spi, &adis->msg);"
> >
> > And then the duplication added in patch [1] can be cleaned up.
> > So maybe a re-ordering of patches could simplify/remove the added
> > duplication.
> >
>
> Hmmm I'm not following you :). What's your idea? You mean the block
> inside the 'if (ret)' in case spi_sync fails? If so, we can move it but t=
hen
> we cannot do the goto jump... you mean something like?
>
> ret =3D spi_sync();
> if (adis->data->has_paging)
>         mutex_unlock(&adis->state_lock);
> if (ret) {
>         dev_err();
>         goto irq_done;
> }
>
> I don't particularly like the paging stuff after the spi_sync but this av=
oids
> some duplication for sure... and reduces some lines of code :)

Yeah, this was the suggestion.
No strong opinion about it.

>
> - Nuno S=C3=A1
