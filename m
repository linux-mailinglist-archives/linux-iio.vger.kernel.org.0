Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAFC3673F8
	for <lists+linux-iio@lfdr.de>; Wed, 21 Apr 2021 22:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244070AbhDUUFD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbhDUUFC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 16:05:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711EC06174A;
        Wed, 21 Apr 2021 13:04:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h11so12265772pfn.0;
        Wed, 21 Apr 2021 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XjzN9u1XIIKrwLXg1Uzzb9MFJ/8VoXvqNDETrQxkadw=;
        b=C17XDn7x8WjbYqnuZh0oV7kAyn/5X9FuN7UISLXRsiRpepFCSJtBQKhqNHIxdXU2dg
         2Oot3/Htx1Y76VEy1PcJI9XKoWra1tl0ee7zHBFrOVuVu1taH0n8ks3a3yvkP8Td46Bw
         vbrgHVEkTD8Uh02AVpEUUdlcW5XL1u20ee6ANa4ZX5urDn4SuQsYAEz1wblOiuG2URGs
         RiB0MQyzTdC1f79Vhnrcryx24+846Up8xJF2utKXmcScRy30z4+DdGvN1KZmd8qa8Rez
         0NxkBWigNE/c88R+P+hXNDoWC4BqLV7J2IqyGvWtoYL0ezmjiCHaVcPxSLEf0IgxsYnU
         gNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XjzN9u1XIIKrwLXg1Uzzb9MFJ/8VoXvqNDETrQxkadw=;
        b=JfGXvpQdrAVwsRri1FxII58/mx8WFdHY5SE1qfA3SJ+ZU4M4FsCv2knyOHw2GY2f7j
         4bAHr00Rt4E+SmsJvogEzfnss8DdKD6Yo2NEkTYMqVE4cTuaq8L1RLkEf3KDkWaNKeQM
         +6Ai8xvm/sgrq8ayZ6ZCYgr0AFNR94HbQXFGFtPCyfFWVvKeMiJJ0Qz9o/sCHPgxQAXa
         7wCwg46BKQXfYnivGahHC3pyZQ53TFsm4X00eJGTjAwR33FdTyI5QVrXOoAVDQHtwhnp
         cYyMDHL5R+1imtNQEXJDisMaeXSAJypkPcEGrAMcjFI7t1Wg2b7hWJTfjcbEDU/kjmbQ
         Zt4Q==
X-Gm-Message-State: AOAM530wWhqdZfTX6YUD9KyGVHSqlfrDTe1qrjv5szH1I2odiNMPsH+I
        65d6FLD0le/o6IBYx7EcCyS6Ah0K+p7RzMx3GIg=
X-Google-Smtp-Source: ABdhPJwub1TU9sxoOWlwWB3mxYwEjKWkASS051OVNMOo4AAlDsnlN9U1pTo/XAZ5qxTMavawyloe5UfAxuEZq8TbqPA=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr3271003pgs.4.1619035468939;
 Wed, 21 Apr 2021 13:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com> <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
 <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
 <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com>
 <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de> <CAHp75VdY2NXJJGkT=so847wjxS3iCrsiZsvBR-V68XVM7HeRyw@mail.gmail.com>
In-Reply-To: <CAHp75VdY2NXJJGkT=so847wjxS3iCrsiZsvBR-V68XVM7HeRyw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Apr 2021 23:04:12 +0300
Message-ID: <CAHp75VczPd5kNBTD+LroYnVo31azYHBD8RZdy9RaQEK3KvObHQ@mail.gmail.com>
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 21, 2021 at 11:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 21, 2021 at 11:00 PM Lars-Peter Clausen <lars@metafoo.de> wro=
te:
> > On 4/21/21 9:41 PM, Andy Shevchenko wrote:
> > > On Wed, Apr 21, 2021 at 10:05 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > >> On Wed, Apr 21, 2021 at 1:14 PM Linus Walleij <linus.walleij@linaro.=
org> wrote:
> > >>> On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com>=
 wrote:
> > >>>
> > >>>> I found a non-kernel example
> > >>>> which uses a similar equation [1], but in a different form. The ma=
in
> > >>>> difference is that the Arduino code interprets a raw temperature v=
alue
> > >>>> as a signed integer, while upstream assumes it's unsigned.
> > >>>>
> > >>>> [1]
> > >>>> https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/M=
PU3050lib.cpp#L111
> > >>> Oh that's nice. Room temperature as mentioned is 20 deg C
> > >>> I think?
> > >>>
> > >>> The divide by 280 part seems coherent in all examples.
> > >>>
> > >>>> Still, even if assume that the raw temperature is a signed s16 val=
ue, it
> > >>>> gives us ~35C in a result, which should be off by ~10C.
> > >> Actually here [1] it says in chapter 3.1 that room temperature is 35=
=C2=B0C.
> > >>
> > >> Range: -30=C2=B0C .. +85=C2=B0C
> > >> Sensitivity: 280 LSB/=C2=B0C
> > >> Room temperature offset: 35=C2=B0C =3D -13200 LSB
> > >>
> > >> [1]: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
> > >
> > > So, if I'm reading this and the register description right the value
> > > is in the range
> > > -32768..32767.
> > > -13200 defines 35=C2=B0C
> > >
> > > 50000 as mentioned by Dmitry is actually -15536. So, it means that th=
e
> > > more negative a value is the higher temperature is shown.
> > >
> > > Since it's linearized scale, now we can see that
> > >
> > > (13200 -15536)/280 + 35 gives us 26.66.
> > >
> > > Does it make sense?
> > (13200 + x)/280 + 35 =3D (23000 + x)/280, which is what is in the drive=
r.
> > So the only bit missing is the cast to s16.
>
> Cool! So, that cast needs a very good comment then :-)

"will need" (since it's not yet in upstream)


--=20
With Best Regards,
Andy Shevchenko
