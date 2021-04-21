Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C07367403
	for <lists+linux-iio@lfdr.de>; Wed, 21 Apr 2021 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhDUULw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 16:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243166AbhDUULw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 16:11:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBDC06174A;
        Wed, 21 Apr 2021 13:11:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p16so18334140plf.12;
        Wed, 21 Apr 2021 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RkFq+WTKPnknfBHcwURsKsbC56aRMx/+TYGJN/qfkmE=;
        b=UTU1ijCUY92UJxa+2byPgMpXP52WesnucfN5saxEpcrcVMzbJwDV6SnbskmMMKT8x8
         WdZTbFtOCpM6mHF0FK8cbVzW2nJ5Cy7mj4JckyKHnprjPIBhrWUaKWT2BL9XMpPcbhcR
         XUtv3x1o5dqShadMyDcvab289354gj1+GRWzKYZ4wtf/0qLeMGvBC6VZ1QmFvOpL4K9I
         T8hTF19NAFVltSySpEWAwph6VhgmhcXyjXKEoZvYOy9yZozTVQp0tocRghJLlqJpUv44
         QozzKrw72IPeCGt9+1jgIQ50mG0ykfx6hEU8nl8XX1yjz/KFQtpAuvGA+zERS9W0OpmL
         z0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RkFq+WTKPnknfBHcwURsKsbC56aRMx/+TYGJN/qfkmE=;
        b=ElPzOYOPBBq+9qxj4oiyeAhaYBWHE3wEA7yPlyvgu5wkGP+Ayi0V/REGnncoxaGSZ7
         2tNiA37LYdwSD/Hmx4YGYftSzg6AYezdzoXbl95nT9B3jS0E6RaX4LrOzC7jgq9OVd/i
         D0fQO/29DFgM+CMNUpEAV/2m4a4eJGOYdsbbpjE3Bg7wz0tzGJYcpj82JClf37A/yIKX
         edTu3yG9OQufY8gIKh2jxwL8Doswdc7Mjs6KQ0B/28EVsya282iw3TOjThAJZOZ0KPRL
         huGKB3Twtl+/6jzelU0BVA61kozZ3YE/MBzgSdogPGSWAHMIsgF4HjLp33E37CeicjZS
         VF4A==
X-Gm-Message-State: AOAM532uajyxpEfrY5poOtWDQjdYt6aWR4PtUKhd3rYAb8oHc0suGIXT
        4ALTQ/t1y9lxEh/2MkzIMJBXsnUT9XUO7DvfnUH/fRov++w=
X-Google-Smtp-Source: ABdhPJwa2fCGoovooxB++Y/d3YlMQ9eVF/7RDUWoSzgMuw1JRV0op1H+JLC1ql2AsSN998Eu91uRdTcqPi/arphb4Ag=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr35142349plq.17.1619035877358; Wed, 21
 Apr 2021 13:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com> <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
 <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
 <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com> <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
In-Reply-To: <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Apr 2021 23:11:01 +0300
Message-ID: <CAHp75VdfM=Seaa=K6f=zium+2jYusccy6oEF6GuMCZDL5SM_YA@mail.gmail.com>
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

s/higher/lower/
Sorry for my signness.

> > Since it's linearized scale, now we can see that
> >
> > (13200 -15536)/280 + 35 gives us 26.66.
> >
> > Does it make sense?
> (13200 + x)/280 + 35 =3D (23000 + x)/280, which is what is in the driver.
> So the only bit missing is the cast to s16.


--=20
With Best Regards,
Andy Shevchenko
