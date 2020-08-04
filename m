Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA623B62F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgHDH6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHDH6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2020 03:58:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24028C06174A
        for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2020 00:58:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g19so29200031ioh.8
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2020 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMZf2t9EcjlJ4jvHRNWow+fwJFtPbegbegr9EI3Rn3I=;
        b=gTJwN5BL9ze+SRbn2vAaVUOswNTugj2bAhZr/Y0GfGZkFZLVvt5l5nRZjN88rsS2Nz
         05WVcCBG27/xPlsb/hjPo5Iau0aPcwp2sDMNp2E2M8K9L+WHLmY3UchhwKlXf49mHZMO
         nCIA9IoAk0+dtyF+nAVFVRirPeX8s7dZ2ol5+ojbfn5odwrsgzioTkOszEd+6F747u/t
         AH8FWX1WzRmhfnXTaKLYoIzNrgLxpeUM0FZiRhB6BTyQL7XqOWfDOUrWyNFTHzRNC4V7
         b4n1AxP2TBKZmV9re43OZ495tglmvaler52wLc6TNvLhND+x881+JLv6iTGSRFBiCh5V
         gNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMZf2t9EcjlJ4jvHRNWow+fwJFtPbegbegr9EI3Rn3I=;
        b=XwUTZZCMi1gMpXhF2ulDQ/fMbNNwLKqZZWR5se/1v6Wb5G3vIeDV9FOO5RviJOx25v
         IUxYPV7dPLnSFFBIfjsSP2ylujWSlq8tWiRrVCRIAhWhJsPqctevEIRt5jjIB/7/ykEC
         13+tAeXqI9x1/UOGITR1H1i0SJVATgGJ41LmTA30nHg8rADvMp4E7p4b8p2xvkN2YM1e
         mMHKp6V2Z1S//HbOXEhmKU2xmZrp6znVZT6PD+2GU3nROWpRbyhkC7cJHjF12Bd9N9Cd
         fg0FWb6FZEEYxD9GzM3o3rca7c8OaKTSwquWNJ3IFd0NzzoKxfyRVRJHxW1xZvasA9eC
         FXPw==
X-Gm-Message-State: AOAM530BQySd70Ci58OHG6WQ4Yj7rICa02sTRKqaYkRqRUHrdVDSFGEB
        TV/hOlE60h/q/Nt3E0YglpMhVbUQEw2epe4wZZfesQ==
X-Google-Smtp-Source: ABdhPJy1L3R+qgiqlRzr8WKIrpgTbp+M9wSv7fjCzoXuZEvcxj/HVoDdZcPtPcQltAlCaNi4V/ltgb7GuNBIk1UBBGM=
X-Received: by 2002:a6b:ba89:: with SMTP id k131mr3815610iof.133.1596527893889;
 Tue, 04 Aug 2020 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200803151656.332559-1-cmo@melexis.com> <CAHp75VfmSfmezqwwRfHZ797Y9rYDu3hgL5vGvPwbzGjCXsKWcQ@mail.gmail.com>
In-Reply-To: <CAHp75VfmSfmezqwwRfHZ797Y9rYDu3hgL5vGvPwbzGjCXsKWcQ@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Tue, 4 Aug 2020 09:57:38 +0200
Message-ID: <CAKv63uuFNOksmDUKEapvX60gg9QE+32Dak_2=M2cYeueFiHjPg@mail.gmail.com>
Subject: Re: [PATCH] iio:temperature:mlx90632: Reduce number of equal calulcations
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,
Thanks for the comments. This is indeed a cut-out section of what I
wanted to submit next.

On Mon, 3 Aug 2020 at 18:35, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 3, 2020 at 6:17 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > TAdut4 was calculated each iteration although it did not change. In light
> > of near future additions of the Extended range DSP calculations, this
> > function refactoring will help reduce unrelated changes in that series as
> > well as reduce the number of new functions needed.
>
> Okay!
>
> > Also converted shifts in this function of signed integers to divisions as
> > that is less implementation-defined behavior.
>
> This is what I'm wondering about. Why?
>
> ...

The reason for this is that whenever something is wrong with the
calculation I am looking into the shifts which are
implementation-defined and might not keep the signed bit. Division
however would.

>
> > -       Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
> > -       Hb_customer = ((s64)Hb * 100) >> 10ULL;
> > +       Ha_customer = div64_s64((s64)Ha * 1000000LL, 16384);
> > +       Hb_customer = div64_s64((s64)Hb * 100, 1024);
>
> Have you checked the code on 32-bit machines?
> As far as I can see the div64_*64() do not have power of two divisor
> optimizations. I bet it will generate a bulk of unneeded code.
>
> ...
>
> > -       calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
> > -                            * 1000LL)) >> 36LL;
> > -       calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
> > -       Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
> > -                               * Ha_customer), 1000LL);
>
> > +       calcedKsTO = div64_s64((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
> > +                                    * 1000LL), 68719476736);
> > +       calcedKsTA = div64_s64((s64)(Fb * (TAdut - 25 * 1000000LL)), 68719476736);
> > +       Alpha_corr = div64_s64(div64_s64((s64)(Fa * 10000000000LL), 70368744177664)
> > +                              * Ha_customer, 1000LL);
>
> This is less readable and full of magic numbers in comparison to the
> above (however, also full of magics, but at least gives better hint).
>
> ...

These are coefficients so there is not much to unmagic. I can keep the
shifts, if you think that is more readable or add comments after lines
with 2^46 or something?
>
> > +       TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
> > +               (div64_s64(TAdut, 10000LL) + 27315) *
> > +               (div64_s64(TAdut, 10000LL)  + 27315) *
> > +               (div64_s64(TAdut, 10000LL) + 27315);
>
> Shouldn't you switch to definitions from units.h? (perhaps as a separate change)
>
> --
> With Best Regards,
> Andy Shevchenko
