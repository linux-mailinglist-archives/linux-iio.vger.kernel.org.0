Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6E367577
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 01:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbhDUXDJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 19:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhDUXDI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 19:03:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F8C06174A
        for <linux-iio@vger.kernel.org>; Wed, 21 Apr 2021 16:02:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x20so38901729lfu.6
        for <linux-iio@vger.kernel.org>; Wed, 21 Apr 2021 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ihwBbr0wDU/pkGia8qTBJOVfFxizBeK/hnkFTc8CCWU=;
        b=IZ3haLM5tJgi14Jfg0jJ1v5/78eVhgD8eIYJUrR9Izelrt74oysMKCUZZLkwfJo5oF
         TV3VkBNz1mJ/1bePKD+xFSmIUYZP4B/qVg/n4GSkyARswtHbOWvFkiqg5WRNl1Pq5rnT
         gd0sHo1zYzyORfqIbFghSzcX7RqDUNmKaErsomEZ1aUxcC2+CQ20SeA5IYQ1jmt2sICi
         D/3//l0flWRzR7DdvSbmYWTZO8xfO5dPSbTiU0YQjCpqtkAkSuBKWz/Z7Nnq1Guws7ik
         w9fVyVM456cSTZVssMxCnDz3sRxLlsObrr3w0nGRNyIC5JkJBM1Y5ZqnvaT+MONX8S+I
         Kc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ihwBbr0wDU/pkGia8qTBJOVfFxizBeK/hnkFTc8CCWU=;
        b=mpMZzXnlx1UjRxUwLy7EPrnGlQgz9SYVWzLy/ipKEW/SiyYSQLbBPZrIpyk0J2yXBZ
         Q6owggzNpWWd1PTuy2f7a0TfCiHwBr9IGymdB0YCIOOM3KY8VDgM5GmtVicHuT5mjay9
         8LNX+rGNOpYN/NqtLWHilvzG2coSBLifZhoEaqdyxM/iU5bGygf7rBPc8uIWoPdhYedo
         J6MKrhIoBEIC6OyMzUZU9FdV6N3BFtCSszyRpzyZQ8fkSn6JfjVvpxKBNHFYjX14XiH9
         rtqRCdZV+0L/khsSkJ0ad9H3h0dysPJVSnl2MqH8ZJdhih82ClDtqNzIGYPJmiMJH6Wi
         Rz9w==
X-Gm-Message-State: AOAM532vIeWxmgnUZa/Ch6FDf/QUvT/oA/XTJ5FRhocXmuxp+vzYzI7i
        WrHAjZoVcYd2/FYmcFpQhl79KXoY5ceygvlc1k9baA==
X-Google-Smtp-Source: ABdhPJw6QtkcxmWSpbyIuuNgpDxk4vNzZQHC4Ez36jv/K20KJUzmzZ9d+mZdRDzjwhY8fJLVEZFGhEIo+t3auUc5w+A=
X-Received: by 2002:a05:6512:3a85:: with SMTP id q5mr347706lfu.465.1619046151567;
 Wed, 21 Apr 2021 16:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com> <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
 <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
 <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com> <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
In-Reply-To: <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 01:02:20 +0200
Message-ID: <CACRpkdborNeVNQEq9vf9N_CCkKqpBN-0g0FE-oJws4zTrxnXvQ@mail.gmail.com>
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Wed, Apr 21, 2021 at 10:00 PM Lars-Peter Clausen <lars@metafoo.de> wrote=
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

Oh nice find!

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

Yup there is the bug. (I am guilty.)

Dmitry will you test & send a patch?

Yours,
Linus Walleij
