Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59A93DBF4B
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 21:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhG3T5v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhG3T5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 15:57:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8AAC061765;
        Fri, 30 Jul 2021 12:57:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c18so10590922qke.2;
        Fri, 30 Jul 2021 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=d39UmHx/rD1fxNzcvE+aTA7xZLmNIyrxYT7eIKaIFus=;
        b=Gm0WN9BQPGd+TzXpCY+GlXzP5mQia4jiszKTDi2MAXCssTtttncxkNQOGZUYKbxlut
         lvzBroin1mPUl/4kdA3YozIj6bgGuyHDFZ1PRBUbpLFGDp4fMXBpFGKCWdXhvXkrJ/aQ
         wDLUXDxctOpB/bI061QcCJylxGK24mcmWAmVMqSq09ed29tN1HTvTEJmBCqAE/EJPc75
         c04mNVCxeDrt52EGNvqPZNQY1FEdVRX1OzMtzbfERcuRIH9xX/wqj5K3pB0I7lFWCUt2
         y7z29iVJ4jU57wezetGMJhMNYwWWQDrgbux8AQPCkEt1f4WcWXkTH3m8u7ILxAqkJPAT
         G4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=d39UmHx/rD1fxNzcvE+aTA7xZLmNIyrxYT7eIKaIFus=;
        b=nzPGawMmaze/G6JzzNRs5EPydsj7ZUIrSiPQRL1MwQvR39ixfjpwnjr/Kr4mlPkqL7
         c2RErbgyFczoV4t2VbakNGECR41XIfZaH9t2EWtEc46v3tQZIoBdfPk23g+qLO2GXm0S
         Eu2ukpq/WNuaGeGyWUtDvkaxsIfibQAJuincsFkqegCwXDOE3bE7jaw8sfxmOM4ZEq2C
         bDd0Qc4zMlz7BL5iMq5x6isrvGW1DLnms2u3jpJSclo0yRmmMTZ8s96dIqBckpc3e0g1
         Ey6oFUzgnE2OkZjX0Fiha78CYDsJLLKQRwvlZ3Okvg1PlYYi8BLjCnOkp98OsrJhi5kD
         VuAQ==
X-Gm-Message-State: AOAM5330WfwQ8bi9cKz/djaawsr1QTSsH3Tx8pSkjbF2wU1zOgY23CMz
        PKk94Kx2489EBumTpVGEWOTe6dhdwlbIew==
X-Google-Smtp-Source: ABdhPJyqr4p7EmYdObvWrh4HfzSZRvmRzyPG5T/zW5qITOYKzE4Hswr/snKH75aYhKllhmad1ccsJg==
X-Received: by 2002:a05:620a:903:: with SMTP id v3mr3846940qkv.235.1627675062426;
        Fri, 30 Jul 2021 12:57:42 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id d192sm1410757qkc.51.2021.07.30.12.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 12:57:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 30 Jul 2021 15:57:40 -0400
Message-Id: <CD6QNK3LBY59.DKBWN8531DNM@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-6-liambeguin@gmail.com>
 <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
 <CD4CE5OQT5TJ.2BFPBRYK7FCOW@shaak>
 <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
 <CD5QWB9MW1H5.3SSPWGD5DR6J5@shaak>
 <a77e7a18-67dc-5bc5-427b-89d6b1e82b85@axentia.se>
In-Reply-To: <a77e7a18-67dc-5bc5-427b-89d6b1e82b85@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 30, 2021 at 2:49 AM EDT, Peter Rosin wrote:
> On 2021-07-29 17:56, Liam Beguin wrote:
> > On Wed Jul 28, 2021 at 3:19 AM EDT, Peter Rosin wrote:
> >> On 2021-07-28 02:21, Liam Beguin wrote:
> >>> On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:
> >>>> On 2021-07-21 05:06, Liam Beguin wrote:
> >>>>> From: Liam Beguin <lvb@xiphos.com>
> >>>>>
> >>>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> >>>>> Add support for these to allow using the iio-rescaler with them.
> >>>>>
> >>>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>>>> ---
> >>>>>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
> >>>>>  1 file changed, 14 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-re=
scale.c
> >>>>> index d0669fd8eac5..2b73047365cc 100644
> >>>>> --- a/drivers/iio/afe/iio-rescale.c
> >>>>> +++ b/drivers/iio/afe/iio-rescale.c
> >>>>> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescal=
e, int scale_type,
> >>>>>  		do_div(tmp, 1000000000LL);
> >>>>>  		*val =3D tmp;
> >>>>>  		return scale_type;
> >>>>> +	case IIO_VAL_INT_PLUS_NANO:
> >>>>> +		tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> >>>>> +		tmp =3D div_s64(tmp, rescale->denominator);
> >>>>> +
> >>>>> +		*val =3D div_s64(tmp, 1000000000LL);
> >>>>> +		*val2 =3D tmp - *val * 1000000000LL;
> >>>>> +		return scale_type;
> >>>
> >>> Hi Peter,
> >>>
> >>>>
> >>>> Hi!
> >>>>
> >>>> My objection from v5 still stands. Did you forget or did you simply =
send
> >>>> the
> >>>> wrong patch?
> >>>
> >>> Apologies, again I didn't mean to make it seem like I ignored your co=
mments.
> >>> I tried your suggestion, but had issues when *val2 would overflow int=
o
> >>> the integer part.
> >=20
> > Hi Peter,
> >=20
> >>
> >> Not saying anything about it not working does indeed make it seem like
> >> you
> >> ignored it :-) Or did I just miss where you said this? Anyway, no
> >> problem,
> >> it can be a mess dealing with a string of commits when there are
> >> numerous
> >> things to take care of between each iteration. And it's very easy to
> >> burn
> >> out and just back away. Please don't do that!
> >=20
> > It was my mistake. Thanks for the encouragement :-)
> >=20
> >>
> >>> Even though what I has was more prone to integer overflow with the fi=
rst
> >>> multiplication, I thought it was still a valid solution as it passed =
the
> >>> tests.
> >>
> >> I did state that you'd need to add overflow handling from the fraction
> >> calculation and handling for negative values, so it was no surprise th=
at
> >> my original sketchy suggestion didn't work as-is.
> >>
> >>>
> >>>>
> >>>> Untested suggestion, this time handling negative values and
> >>>> canonicalizing any
> >>>> overflow from the fraction calculation.
> >>>>
> >>>> neg =3D *val < 0 || *val2 < 0;
> >>>> tmp =3D (s64)abs(*val) * rescale->numerator;
> >>>> rem =3D do_div(tmp, rescale->denominator);
> >>>> *val =3D tmp;
> >>>> tmp =3D rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
> >>>> do_div(tmp, rescale->denominator);
> >>>> *val2 =3D do_div(tmp, 1000000000LL);
> >>>> *val +=3D tmp;
> >>>> if (neg) {
> >>>> if (*val < 0)
> >>>> *val =3D -*val;
> >>>> else
> >>>> *val2 =3D -*val;
> >>
> >> This last line should of course be *val2 =3D -*val2;
> >> Sorry.
> >>
> >>>
> >>> I'll look into this suggestion.
> >>
> >> Thanks!
> >>
> >=20
> > Starting from what you suggested, here's what I came up with.
> > I also added a few test cases to cover corner cases.
> >=20
> > 	if (scale_type =3D=3D IIO_VAL_INT_PLUS_NANO)
> > 		mult =3D 1000000000LL;
> > 	else
> > 		mult =3D 1000000LL;
> > 	/*
> > 	 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
> > 	 * *val2 is negative the schan scale is negative
> > 	 */
> > 	neg =3D *val < 0 || *val2 < 0;
> >=20
> > 	tmp =3D (s64)abs(*val) * (s32)abs(rescale->numerator);
>
> Small nit, but I think abs() returns a signed type compatible
> with the argument type. I.e. (s32)abs(rescale->...) where both
> numerator and denominator are already s32 could just as well
> be written without the cast as plain old abs(rescale->...)

Understood, I'll get rid of the redundant typecasts

>
>
> > 	*val =3D div_s64_rem(tmp, (s32)abs(rescale->denominator), &rem);
> >=20
> > 	tmp =3D (s64)rem * mult +
> > 		(s64)abs(*val2) * (s32)abs(rescale->numerator);
> > 	tmp =3D div_s64(tmp, (s32)abs(rescale->denominator));
> >=20
> > 	*val +=3D div_s64_rem(tmp, mult, val2);
> >=20
> > 	/*
> > 	 * If the schan scale or only one of the rescaler elements is
> > 	 * negative, the combined scale is negative.
> > 	 */
> > 	if (neg || ((rescale->numerator < 0) ^ (rescale->denominator < 0)))
> > 		*val =3D -*val;
>
> Unconditionally negating *val doesn't negate the combined value when
> *val is zero and *val2 isn't. My test "if (*val < 0)" above attempting
> to take care of this case is clearly not right. It should of course be
> "if (*val > 0)" since *val is not yet negated. Duh!

Oh I see, thanks for pointing that out. Since at that point *val can't
be negative because of all the abs() calls, we could also just check
that *val is not zero.

>
> In fact, I think a few tests scaling to/from the [-1,1] interval
> would be benefitial for this exact reason.

Sounds good, I'll add a few more cases for this.
Thanks,
Liam

>
> Cheers,
> Peter

