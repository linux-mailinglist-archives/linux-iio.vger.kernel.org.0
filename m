Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAE3DA802
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhG2P4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbhG2P4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 11:56:35 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469F7C0613D5;
        Thu, 29 Jul 2021 08:56:29 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id s11so3616768qvz.7;
        Thu, 29 Jul 2021 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=+uUxus+I/qDkyNVZJYnAq6q/M+T1B9Eeaa1wkaDimA0=;
        b=goa4h9is93rBWcWJrvlUc2qw1Fg2fDeFtv51Er5yWAdtpKFKRibPzGoeg5cXo8CZai
         SjIUbvqCcJ5ecQ57elSccw2ZJ0xusWlMX/vw2W1QD3/GH1pf0fCZRfTv0DWKZMUEDZn/
         xQPXNi5VZy96TofP2QEQL6kbuyCph7Y/0owf4Ax77B9Dss2znwIICmAjBvKqXM9ThtmX
         4PLhO0Z9tha49QsufzF7mqg1l6+UfEkY11kGaEhkW5s9vgwUXjwFgcLNKF8aEOrbMTUa
         VMqQPlgII7gn1dIyPkQXUeuDfHiNKWTFUAoRtdbsk4I1+H/9G3CkiLmqARg8FWohY5CV
         9MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=+uUxus+I/qDkyNVZJYnAq6q/M+T1B9Eeaa1wkaDimA0=;
        b=txG6TNld2x+JJAsA6lid2EULvqv520bI7Ku9CRSYd7CkRamfj0UYNw2dGHU5uNlCB2
         B0Y8JF8vCYiQ1fmbzjkQk4GOOy/e4+tKXAuExl5xZXFtiM/wwmhy1xRkZy62nglNwC6R
         7zY6uv4NA7bMXvhJsTbU+H70XyGZa1K3vZIryN57zJcJIC5WyUKsy9T+cCmk+oHYuVqw
         RH34tTN6AVxApITJ0ZrLKFCcuDekF53JBHN9x+ExcICMFwatOAU/fTYAozcaGcQVHBRN
         xL/104NDSyjTw1nFwu2PI+fDkfPFR7a5WyF2er+HHoVjZilYhmCgBd85/G90RkXqIXb1
         nsIQ==
X-Gm-Message-State: AOAM532gJuOAnI6Rp61ZmnAl6CjQkvyBVHHVLjTv9kY9ItUf9AEKYntT
        iQv6smzQS5boT8fDN+tMxEo=
X-Google-Smtp-Source: ABdhPJx+uui86bSzYTRdgeJnCpoJIWoN2R45VdAk9UQsVNe5R/mFDEmZYlocDB4VGLrZhqmHbGl0LA==
X-Received: by 2002:a0c:8e09:: with SMTP id v9mr5915123qvb.15.1627574188404;
        Thu, 29 Jul 2021 08:56:28 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x7sm1357406qtw.24.2021.07.29.08.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 08:56:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 29 Jul 2021 11:56:26 -0400
Message-Id: <CD5QWB9MW1H5.3SSPWGD5DR6J5@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-6-liambeguin@gmail.com>
 <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
 <CD4CE5OQT5TJ.2BFPBRYK7FCOW@shaak>
 <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
In-Reply-To: <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed Jul 28, 2021 at 3:19 AM EDT, Peter Rosin wrote:
> On 2021-07-28 02:21, Liam Beguin wrote:
> > On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:
> >> On 2021-07-21 05:06, Liam Beguin wrote:
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> >>> Add support for these to allow using the iio-rescaler with them.
> >>>
> >>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>> ---
> >>>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-resc=
ale.c
> >>> index d0669fd8eac5..2b73047365cc 100644
> >>> --- a/drivers/iio/afe/iio-rescale.c
> >>> +++ b/drivers/iio/afe/iio-rescale.c
> >>> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale,=
 int scale_type,
> >>>  		do_div(tmp, 1000000000LL);
> >>>  		*val =3D tmp;
> >>>  		return scale_type;
> >>> +	case IIO_VAL_INT_PLUS_NANO:
> >>> +		tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> >>> +		tmp =3D div_s64(tmp, rescale->denominator);
> >>> +
> >>> +		*val =3D div_s64(tmp, 1000000000LL);
> >>> +		*val2 =3D tmp - *val * 1000000000LL;
> >>> +		return scale_type;
> >=20
> > Hi Peter,
> >=20
> >>
> >> Hi!
> >>
> >> My objection from v5 still stands. Did you forget or did you simply se=
nd
> >> the
> >> wrong patch?
> >=20
> > Apologies, again I didn't mean to make it seem like I ignored your comm=
ents.
> > I tried your suggestion, but had issues when *val2 would overflow into
> > the integer part.

Hi Peter,

>
> Not saying anything about it not working does indeed make it seem like
> you
> ignored it :-) Or did I just miss where you said this? Anyway, no
> problem,
> it can be a mess dealing with a string of commits when there are
> numerous
> things to take care of between each iteration. And it's very easy to
> burn
> out and just back away. Please don't do that!

It was my mistake. Thanks for the encouragement :-)

>
> > Even though what I has was more prone to integer overflow with the firs=
t
> > multiplication, I thought it was still a valid solution as it passed th=
e
> > tests.
>
> I did state that you'd need to add overflow handling from the fraction
> calculation and handling for negative values, so it was no surprise that
> my original sketchy suggestion didn't work as-is.
>
> >=20
> >>
> >> Untested suggestion, this time handling negative values and
> >> canonicalizing any
> >> overflow from the fraction calculation.
> >>
> >> neg =3D *val < 0 || *val2 < 0;
> >> tmp =3D (s64)abs(*val) * rescale->numerator;
> >> rem =3D do_div(tmp, rescale->denominator);
> >> *val =3D tmp;
> >> tmp =3D rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
> >> do_div(tmp, rescale->denominator);
> >> *val2 =3D do_div(tmp, 1000000000LL);
> >> *val +=3D tmp;
> >> if (neg) {
> >> if (*val < 0)
> >> *val =3D -*val;
> >> else
> >> *val2 =3D -*val;
>
> This last line should of course be *val2 =3D -*val2;
> Sorry.
>
> >=20
> > I'll look into this suggestion.
>
> Thanks!
>

Starting from what you suggested, here's what I came up with.
I also added a few test cases to cover corner cases.

	if (scale_type =3D=3D IIO_VAL_INT_PLUS_NANO)
		mult =3D 1000000000LL;
	else
		mult =3D 1000000LL;
	/*
	 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
	 * *val2 is negative the schan scale is negative
	 */
	neg =3D *val < 0 || *val2 < 0;

	tmp =3D (s64)abs(*val) * (s32)abs(rescale->numerator);
	*val =3D div_s64_rem(tmp, (s32)abs(rescale->denominator), &rem);

	tmp =3D (s64)rem * mult +
		(s64)abs(*val2) * (s32)abs(rescale->numerator);
	tmp =3D div_s64(tmp, (s32)abs(rescale->denominator));

	*val +=3D div_s64_rem(tmp, mult, val2);

	/*
	 * If the schan scale or only one of the rescaler elements is
	 * negative, the combined scale is negative.
	 */
	if (neg || ((rescale->numerator < 0) ^ (rescale->denominator < 0)))
		*val =3D -*val;

	return scale_type;
> >=20
> >> }
> >>
> >>> +	case IIO_VAL_INT_PLUS_MICRO:
> >>> +		tmp =3D ((s64)*val * 1000000LL + *val2) * rescale->numerator;
> >>> +		tmp =3D div_s64(tmp, rescale->denominator);
> >>> +
> >>> +		*val =3D div_s64(tmp, 1000000);
> >>
> >> Why do you not have the LL suffix here?
> >=20
> > Doesnt' LL make it into a 64 bit integer?
> > I left it out because the second parameter of div_s64() should be s32.
>
> It just looked really odd with 1000000000LL for all instances, but then
> 1000000LL only for some. The lack of symmetry bothered me.
>
> To me, it seems as if we either need to support old/small crap with
> int being 16-bit, or we don't. If we don't need support for 16-bit,
> then we don't need any LL suffix, since 1000000000 fits just fine in
> 32-bit. If we do need 16-bit support, then we need LL (or something)
> all over since neither 1000000 nor 1000000000 fit in 16-bit.
>
> I think the compiler looks at the value of the constant and not the
> size of its type when selecting how big values the mul/add/whatever
> needs handle. So, adding LL feels like the safe option. Further, I
> guesstimate that the runtime cost of adding LL is zero and that the
> compile time cost is negligible.

Thanks for the explanation, I thought it might matter but I agree that
the asymmetry looks odd. I'll fix it.

Thanks,
Liam

>
> But maybe I'm missing something?
>
> Cheers,
> Peter
>
> >=20
> > Thanks,
> > Liam
> >=20
> >>
> >> Cheers,
> >> Peter
> >>
> >>> +		*val2 =3D tmp - *val * 1000000;
> >>> +		return scale_type;
> >>>  	default:
> >>>  		return -EOPNOTSUPP;
> >>>  	}
> >>>
> >=20

