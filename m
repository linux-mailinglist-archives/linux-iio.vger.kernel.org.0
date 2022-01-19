Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F41849404B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jan 2022 20:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356964AbiASTFh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 14:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356952AbiASTFg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 14:05:36 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1744C061574
        for <linux-iio@vger.kernel.org>; Wed, 19 Jan 2022 11:05:36 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p5so10319595ybd.13
        for <linux-iio@vger.kernel.org>; Wed, 19 Jan 2022 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EaZyfOoMLEkSok9ijG+OY14umVQP0UqIXegtGhL1RE8=;
        b=JlRPqZXYafVV/X1cy6KtGd7Oq2XGypjt8tGtOaTrdL4R5rOMYGNOpiMOg6H7T/zChw
         mSx0aXXLhIC09fKIelE4RLBuXhuAE79QVJhhcGkjNwRFcz1013qcMH+CdcF23ojDtEgH
         u1eMvvoEVVnUngUHATWfJNNqJryaZh484O/IXCeriP6A2ALthZiOur31QLDPtb1MBxFc
         BFckgfwdLwSoTxuIQ0Y5xv2PPOPRZ4PdOGg9myxLTU0UonlaGsT29AD07K2Y7zif5tXy
         TTsGm8AYaFF+UCweB4DOscqDJuwcPhhwzAhDY503pt4zrcyH5L+kJVIR+t/bDaRq+3u9
         IF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EaZyfOoMLEkSok9ijG+OY14umVQP0UqIXegtGhL1RE8=;
        b=p56CMgbFzxmWvrwlT/KrYnxQaKEaz2U8r3dl46w3kwBfRbETPNTKOuuV8xzgli1OU8
         7hXexItVUSfziFFZyE1asi3nZ2oWLldGsGx5/WDWqNmibC8KXZmui6XRW5mAi39bEzUr
         aXVNfTEeDqt7WjzR+vHwxok+tanUjrAJC81hU+IBF6kQ8APxfPdwny7QHLr1dnMijgWI
         FK5Klpm2BkRupmdGZmyvf+F9caiYu3aa83xVnvFHGeKSRr7J/5H97OZxLcBEdIuQr3QQ
         Imz14wXKVqmxtog/jb/DSqBChQ4Ckn+Oj+d95U3CT6zkvW+BocR4QzCGt8gb+DERPQWq
         ij4g==
X-Gm-Message-State: AOAM531Mr/8DILyw33lhgg2EGXeXkJ2hzIFPvOT3rQ1VU/z4805TFUx6
        u514P/hKyeXSq2FDywWL7C1jIs4uZe76kuSVfPw=
X-Google-Smtp-Source: ABdhPJyZlfBlJqM4mLCx1hFwrlAzfizsBSsaEaAcCKzpq9IWzRzfsplgRMxXC30zJrLmdzHzBKsHXvn6LRPdW7X9qgI=
X-Received: by 2002:a25:7445:: with SMTP id p66mr12039260ybc.623.1642619135839;
 Wed, 19 Jan 2022 11:05:35 -0800 (PST)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
 <YW3ErLKGtmyhSFd3@smile.fi.intel.com> <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
 <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
 <cd43fddcf9b74f6eaa4dd5a8cdd71bf2@realtek.com> <CAHp75VfB2FULb_jfQNg0wF9Z4jPkrKfmw6hSwtLg8Y1NhKks8g@mail.gmail.com>
 <YW/7oKPZORexnyN1@smile.fi.intel.com> <YZPvIKYsEM4zPZp7@smile.fi.intel.com>
In-Reply-To: <YZPvIKYsEM4zPZp7@smile.fi.intel.com>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Wed, 19 Jan 2022 21:05:25 +0200
Message-ID: <CACAwPwauWAcin3Vj4cOM1uejrCz-eRX_3Hp_iZFap--yuXK0jg@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hayes Wang <hayeswang@realtek.com>, nicfae@realtek.com,
        wlanfae@realtek.com, pctech@realtek.com, security@realtek.com,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pkshih <pkshih@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
        =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
        Kailang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "info@ayaneo.com" <info@ayaneo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Any news from Aya-Neo? Have you fixed and issued a new firmware, please?

Nothing I heard of. Anything I can do to further help with this?

Best regards,
   Maxim Levitsky

On Tue, Nov 16, 2021 at 7:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I filed the form, Cc'ed this to more people from Realtek, still no respon=
se on
> the topic. Does Realtek really cares about their IDs?
>
> Any news from Aya-Neo? Have you fixed and issued a new firmware, please?
>
> On Wed, Oct 20, 2021 at 02:21:04PM +0300, Andy Shevchenko wrote:
> > +Cc: another set of emails from Realtek as per Hayes' email.
> >
> > Please waterfall to the people inside Realtek who can answer the questi=
on.
> > (Note, you may access this discussion in full via:
> > https://lore.kernel.org/linux-iio/CACAwPwYQHRcrabw9=3D0tvenPzAcwwW1pTaR=
6a+AEWBF9Hqf_wXQ@mail.gmail.com/T/#u)
> >
> > The problem here is to have an official confirmation of what 10ec:5280
> > ID is from Realtek's point of view.
> >
> > Context: the current discussion and a patch state that it's related
> > to gyro sensor. Is it so?
> >
> > On Wed, Oct 20, 2021 at 10:36:12AM +0300, Andy Shevchenko wrote:
> > > On Wednesday, October 20, 2021, Hayes Wang <hayeswang@realtek.com> wr=
ote:
> > > > Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Sent: Tuesday, October 19, 2021 5:59 PM
> >
> > ...
> >
> > > > > > > Realtek probably should make this ID marked somehow broken an=
d not
> > > > use
> > > > > > > in their products in case the answer to the first of the abov=
e
> > > > question
> > > > > > > is "yes". (Of course in case the ID will be used for solely P=
CI
> > > > enumerated
> > > > > > > product there will be no conflict, I just propose to be on th=
e
> > > > safest side,
> > > > > > > but remark should be made somewhere).
> > > > >
> > > > > Any comments from Realtek, please?
> > > >
> > > > Excuse me. I don't know this device, so I don't know who I could fo=
rward.
> > > > Maybe you could try our contract window from our web site.
> > > > https://www.realtek.com/en/cu-1-en/cu-1-taiwan-en
> > >
> > > Thanks for reply. I will try my best, but I am afraid that what you s=
uggest
> > > will be a long loop (and I believe the people behind that form are no=
t
> > > technical, they probably won=E2=80=99t understand the topic). I think=
 you may pull
> > > strings inside much faster. Just ask somebody who is technical superi=
or in
> > > your team / organization. Ideally inside company you may have a dedic=
ated
> > > people who responsible for allocating PCI and ACPI IDs.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
