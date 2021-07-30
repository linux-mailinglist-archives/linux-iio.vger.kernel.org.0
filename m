Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2903DBF54
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 22:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhG3UBz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhG3UBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 16:01:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD883C06175F;
        Fri, 30 Jul 2021 13:01:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b1so7337904qtx.0;
        Fri, 30 Jul 2021 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=ovjBFNSiawdQHcKdOlHtSlcBuEI3XhXWSoNsDsUz0us=;
        b=pYKy0DKMYi0XVsBsDwixMFZSwPN2Aqik83vQ03BQEOR0IgGpUdT34Oi+NaYLLPs2KB
         eIxWvTC5MdI0w8G2YrqYQD+CchRv6SMErcitvCBmn9NfsVMOMvLKRGrm8k9VOAJXuedn
         prMBilQSGGI6L3yHudxEA84xlem8rZd/XtDzq6NpH2kThOi7nxcM8JBuuNGUteb7uibE
         2mAd6wzpKokeUvBGPs1GLS2IMRbnLkJ3FKwhh/vjGH0mfQKvhwZLD1eSKvcT+HPQg3PJ
         QjhwlO99ZtCwItvJ/3UPkqTML6aH72Cdpb1Nsa6N97VPWC/HayMAuRxJm08BkYEZGkaY
         iTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=ovjBFNSiawdQHcKdOlHtSlcBuEI3XhXWSoNsDsUz0us=;
        b=aK6pKYPRJIfn+E4Ny38LkKWsCEkRKUow3rH38kXmFpZeuGVjYrSRhhZJrQrD6YiPmz
         NbRmf9MHVDhcJpJ3DwN0NvB8yc5+VI3sF/2SChLSG7NYe4K4MNzoalVNPP459Mxv2+a5
         hSZhZFtfbbN5bWMYoWJKMF1DfiEW3oF4xDqmCCxpHCt5zyQuWJeGSp6FuqN8fgxb7/gq
         payDQmNt2nHgQMH3QeruEzigibWgftAy69wagv8q3M8vBkbcDsvCtNP7pGX+pemmSrzc
         ZiLFcIcRjQ5ldFDPm7vXwIBuaX5jmxe2PUvgKUDDt7LNVvkb81T3n7QB0mg7N66lOJct
         otQw==
X-Gm-Message-State: AOAM533ypzm9ZueWVLRi9MJ8gf8KD44HHeEqhjchFxkSc3p3fPNSwlko
        JDNnSxIeUDyJoHhElAEVBdo=
X-Google-Smtp-Source: ABdhPJwio/JGNcV3B3QQff9W+dNcWyW7PfN6RpV7tdZruURZOJJ8ajrB4ysZe5Dhuma7WWxBmJ7kBw==
X-Received: by 2002:ac8:7452:: with SMTP id h18mr3905848qtr.206.1627675309051;
        Fri, 30 Jul 2021 13:01:49 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f13sm1417357qkk.29.2021.07.30.13.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 13:01:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 30 Jul 2021 16:01:47 -0400
Message-Id: <CD6QQPL9EHY9.YIM3VQZ89I9P@shaak>
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
 <8448cecb-16b3-96ff-dfa8-3933325ef946@axentia.se>
In-Reply-To: <8448cecb-16b3-96ff-dfa8-3933325ef946@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 30, 2021 at 3:01 AM EDT, Peter Rosin wrote:
> On 2021-07-30 08:49, Peter Rosin wrote:
> > On 2021-07-29 17:56, Liam Beguin wrote:
> >> On Wed Jul 28, 2021 at 3:19 AM EDT, Peter Rosin wrote:
> >>> On 2021-07-28 02:21, Liam Beguin wrote:
> >>>> On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:
> >>>>> On 2021-07-21 05:06, Liam Beguin wrote:
> >>>>>> From: Liam Beguin <lvb@xiphos.com>
> >>>>>>
> >>>>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> >>>>>> Add support for these to allow using the iio-rescaler with them.
> >>>>>>
> >>>>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>>>>> ---
> >>>>>>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
> >>>>>>  1 file changed, 14 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-r=
escale.c
> >>>>>> index d0669fd8eac5..2b73047365cc 100644
> >>>>>> --- a/drivers/iio/afe/iio-rescale.c
> >>>>>> +++ b/drivers/iio/afe/iio-rescale.c
> >>>>>> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *resca=
le, int scale_type,
> >>>>>>  		do_div(tmp, 1000000000LL);
> >>>>>>  		*val =3D tmp;
> >>>>>>  		return scale_type;
> >>>>>> +	case IIO_VAL_INT_PLUS_NANO:
> >>>>>> +		tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator=
;
> >>>>>> +		tmp =3D div_s64(tmp, rescale->denominator);
> >>>>>> +
> >>>>>> +		*val =3D div_s64(tmp, 1000000000LL);
> >>>>>> +		*val2 =3D tmp - *val * 1000000000LL;
> >>>>>> +		return scale_type;
> >>>>
> >>>> Hi Peter,
> >>>>
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> My objection from v5 still stands. Did you forget or did you simply=
 send
> >>>>> the
> >>>>> wrong patch?
> >>>>
> >>>> Apologies, again I didn't mean to make it seem like I ignored your c=
omments.
> >>>> I tried your suggestion, but had issues when *val2 would overflow in=
to
> >>>> the integer part.
> >>
> >> Hi Peter,
> >>
> >>>
> >>> Not saying anything about it not working does indeed make it seem lik=
e
> >>> you
> >>> ignored it :-) Or did I just miss where you said this? Anyway, no
> >>> problem,
> >>> it can be a mess dealing with a string of commits when there are
> >>> numerous
> >>> things to take care of between each iteration. And it's very easy to
> >>> burn
> >>> out and just back away. Please don't do that!
> >>
> >> It was my mistake. Thanks for the encouragement :-)
> >>
> >>>
> >>>> Even though what I has was more prone to integer overflow with the f=
irst
> >>>> multiplication, I thought it was still a valid solution as it passed=
 the
> >>>> tests.
> >>>
> >>> I did state that you'd need to add overflow handling from the fractio=
n
> >>> calculation and handling for negative values, so it was no surprise t=
hat
> >>> my original sketchy suggestion didn't work as-is.
> >>>
> >>>>
> >>>>>
> >>>>> Untested suggestion, this time handling negative values and
> >>>>> canonicalizing any
> >>>>> overflow from the fraction calculation.
> >>>>>
> >>>>> neg =3D *val < 0 || *val2 < 0;
> >>>>> tmp =3D (s64)abs(*val) * rescale->numerator;
> >>>>> rem =3D do_div(tmp, rescale->denominator);
> >>>>> *val =3D tmp;
> >>>>> tmp =3D rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
> >>>>> do_div(tmp, rescale->denominator);
> >>>>> *val2 =3D do_div(tmp, 1000000000LL);
> >>>>> *val +=3D tmp;
> >>>>> if (neg) {
> >>>>> if (*val < 0)
> >>>>> *val =3D -*val;
> >>>>> else
> >>>>> *val2 =3D -*val;
> >>>
> >>> This last line should of course be *val2 =3D -*val2;
> >>> Sorry.
> >>>
> >>>>
> >>>> I'll look into this suggestion.
> >>>
> >>> Thanks!
> >>>
> >>
> >> Starting from what you suggested, here's what I came up with.
> >> I also added a few test cases to cover corner cases.
> >>
> >> 	if (scale_type =3D=3D IIO_VAL_INT_PLUS_NANO)
> >> 		mult =3D 1000000000LL;
> >> 	else
> >> 		mult =3D 1000000LL;
> >> 	/*
> >> 	 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
> >> 	 * *val2 is negative the schan scale is negative
> >> 	 */
> >> 	neg =3D *val < 0 || *val2 < 0;
> >>
> >> 	tmp =3D (s64)abs(*val) * (s32)abs(rescale->numerator);
> >=20
> > Small nit, but I think abs() returns a signed type compatible
> > with the argument type. I.e. (s32)abs(rescale->...) where both
> > numerator and denominator are already s32 could just as well
> > be written without the cast as plain old abs(rescale->...)
> >=20
> >=20
> >> 	*val =3D div_s64_rem(tmp, (s32)abs(rescale->denominator), &rem);
> >>
> >> 	tmp =3D (s64)rem * mult +
> >> 		(s64)abs(*val2) * (s32)abs(rescale->numerator);
> >> 	tmp =3D div_s64(tmp, (s32)abs(rescale->denominator));
> >>
> >> 	*val +=3D div_s64_rem(tmp, mult, val2);
> >>
> >> 	/*
> >> 	 * If the schan scale or only one of the rescaler elements is
> >> 	 * negative, the combined scale is negative.
> >> 	 */
> >> 	if (neg || ((rescale->numerator < 0) ^ (rescale->denominator < 0)))
>
> Hang on, that's not right. If the value and only one of the rescaler
> elements is negative, the result is positive. || is not the correct
> logical operation.
>
> >> 		*val =3D -*val;
> >=20
> > Unconditionally negating *val doesn't negate the combined value when
> > *val is zero and *val2 isn't. My test "if (*val < 0)" above attempting
> > to take care of this case is clearly not right. It should of course be
> > "if (*val > 0)" since *val is not yet negated. Duh!
> >=20
> > In fact, I think a few tests scaling to/from the [-1,1] interval
> > would be benefitial for this exact reason.
>
> So, with both these issues taken care of:
>
> if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
> if (*val > 0)
> *val =3D -*val;
> else
> *val2 =3D -*val2;
> }
>
> (bitwise ^ is safe since all operands come from logical operations, i.e.
> they are either zero or one and nothing else)

You're right, this should've been a ^ from the start.

Thanks,
Liam

>
> Cheers,
> Peter

