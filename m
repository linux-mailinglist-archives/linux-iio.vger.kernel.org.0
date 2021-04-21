Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623343673F2
	for <lists+linux-iio@lfdr.de>; Wed, 21 Apr 2021 22:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbhDUUDR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbhDUUDR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 16:03:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515AFC06174A;
        Wed, 21 Apr 2021 13:02:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g16so16619206pfq.5;
        Wed, 21 Apr 2021 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Qyp/SaSpx2QaR/O3ktXfVPl7r6y112gEmrmW7KDUZg=;
        b=oAGpd+2gxjfzRRlJg8jdyoqvbHFc9dKi+M+tFrVHqDxo8RvOG65eN1631D9W3zT3Jk
         c+dKp1T+LhS8YthfD/p24IE4qwTgEuh58NHmdc3fEX1vwQ1I6gZEJt69LWbCH0MgFz1k
         aAKCIkKsvzfPIn+ugKjWOMebJgomSUbYQ/OkboLtzPBZdIdtpIBvHQlHAftKYviJEG6Q
         RwNk/1DnTZGc1Sy/0rM/cQhDuhYF1f7ypWRIQRhYy57jKZBcCXvzEcCY1n1vqVvKVF/3
         ERS45/hpOeL9vfteyz2QPKqvpUbcuj4iKqeBmVRYXeClr3HRpCJmGjPc1v1cxb+Ky/f/
         /EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Qyp/SaSpx2QaR/O3ktXfVPl7r6y112gEmrmW7KDUZg=;
        b=iu+TnJMQM8q7WSrwbB444ifeYR5a1gnc1hL5BlmMyLHkXhkIEk4wFdjj9v+ax124wl
         pMYjyyZkAFm7jMyIlOVY6XbnzNIRh3XglIzFV8dzMyiPLEV0yiOClM9H7JLOVSEQYn2o
         fWZLAeIFw1DPf+7Lklp20h8QmcFUWPHeyrlO7FKZOieuJcxHVR/+D7uQ0cdyS7f6q+Nl
         LdHYZ8WGroQLsf6gB11JeCN6ZT6po4k1oxJfgHGpmKrP1u+8+JSb1IVCUyv9s3MqcYhx
         KI7b2tKBAfRfbq22vd4smMrH1k3WgDwV039Y37vqmSouCqRwd4MHwqCZCU7wRIGaAcgc
         ANzA==
X-Gm-Message-State: AOAM533EHAoOQHrXLawj8YV2A241nLMaGp5sYVdsGnFQzlT+4GjIgWYm
        y+K+D5RTEerXwSU61FaW4ZcQnsTS2NwI6tukRVI=
X-Google-Smtp-Source: ABdhPJxPeGyQ8pM+y4VkkqKG4BlH6BooLC289o3V+Ew+IQ41aZrLpkzla4kxmDEAel+lb3m8qLSJFJoCKaHhEL2nRQ4=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr13805381pjr.181.1619035361909;
 Wed, 21 Apr 2021 13:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com> <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
 <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
 <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com> <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
In-Reply-To: <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Apr 2021 23:02:25 +0300
Message-ID: <CAHp75VdY2NXJJGkT=so847wjxS3iCrsiZsvBR-V68XVM7HeRyw@mail.gmail.com>
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
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

On Wed, Apr 21, 2021 at 11:00 PM Lars-Peter Clausen <lars@metafoo.de> wrote=
:
> On 4/21/21 9:41 PM, Andy Shevchenko wrote:
> > On Wed, Apr 21, 2021 at 10:05 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Wed, Apr 21, 2021 at 1:14 PM Linus Walleij <linus.walleij@linaro.or=
g> wrote:
> >>> On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com> w=
rote:
> >>>
> >>>> I found a non-kernel example
> >>>> which uses a similar equation [1], but in a different form. The main
> >>>> difference is that the Arduino code interprets a raw temperature val=
ue
> >>>> as a signed integer, while upstream assumes it's unsigned.
> >>>>
> >>>> [1]
> >>>> https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU=
3050lib.cpp#L111
> >>> Oh that's nice. Room temperature as mentioned is 20 deg C
> >>> I think?
> >>>
> >>> The divide by 280 part seems coherent in all examples.
> >>>
> >>>> Still, even if assume that the raw temperature is a signed s16 value=
, it
> >>>> gives us ~35C in a result, which should be off by ~10C.
> >> Actually here [1] it says in chapter 3.1 that room temperature is 35=
=C2=B0C.
> >>
> >> Range: -30=C2=B0C .. +85=C2=B0C
> >> Sensitivity: 280 LSB/=C2=B0C
> >> Room temperature offset: 35=C2=B0C =3D -13200 LSB
> >>
> >> [1]: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
> >
> > So, if I'm reading this and the register description right the value
> > is in the range
> > -32768..32767.
> > -13200 defines 35=C2=B0C
> >
> > 50000 as mentioned by Dmitry is actually -15536. So, it means that the
> > more negative a value is the higher temperature is shown.
> >
> > Since it's linearized scale, now we can see that
> >
> > (13200 -15536)/280 + 35 gives us 26.66.
> >
> > Does it make sense?
> (13200 + x)/280 + 35 =3D (23000 + x)/280, which is what is in the driver.
> So the only bit missing is the cast to s16.

Cool! So, that cast needs a very good comment then :-)

--=20
With Best Regards,
Andy Shevchenko
