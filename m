Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AA13BAE34
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGDSGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 14:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGDSG3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jul 2021 14:06:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB7C061574;
        Sun,  4 Jul 2021 11:03:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y9so10693541qtx.9;
        Sun, 04 Jul 2021 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=kH+2+z6bp9mCEzwdOoqJHzOsDTJvzIhbBl/Spavl6Z8=;
        b=iJJMsn73sRp3fblvCzaSri5qJ7lq3iY2GFDZcJ+M0LZAzX1DX36VaUpdYhuNCdRYhL
         qIiuF/tnICTsFAsHH2M8tHv6BSDYNZNfY1I85+qnoIO981nR1SHRT+1dJt5CBd2IqcKm
         qEAdmXn7aemOeIfR+/7GonoAFM2M5hgTdeRmiiG13XVpmrYuW1TPE172EySL3fibNlvX
         JEp4pmlymlhelS3plMdZc/Nnrl04d7WyggdLNtGtadSbRAfyePdw0jFac3p+Y2fk+Zjg
         o9Ihu90SDm/IaF7+SPspvl3/HAU+3NP7vCQvJFekZPNSukwoXybTLA5BYi2OrtpYnfib
         Cs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=kH+2+z6bp9mCEzwdOoqJHzOsDTJvzIhbBl/Spavl6Z8=;
        b=RcGSavoZBNaxnVEThGxBdTvCzGrGYGk1MrTYB9lyfnFVjS+/qrkYeaobphAyOq2c54
         X7wjoCy9GbDGyTZ0BcJBiAJOuONSNhOC1qZyC2MFEMlYmXy1fCrF7QyI2tLIv137pYsF
         lt+KZAv4QtrW55HlyX+FXgICmRuxv0vJ1QjBTy0g14EyRJ0F+/WUDtMzSi30015hFkPB
         tNc2sSb1lchy+kUhwVUS2Vcirqp2iwfrFEe6gFfZFjjt/MzOeufYMIhKx8o8IIhRVYLC
         PBL4ipB4uYwWn13esrSzTV41VPBdptW0bCTYWUEnGHZ96g3S+a8AsmyR2uKGeJnEWSPI
         Irqg==
X-Gm-Message-State: AOAM532e2bzb4fTEtmVHd89NhG1X8aM9Is7D3+5oOYrzH0AKIacCz59s
        d/f3CNFy77Z9/EJt3qXm0tw=
X-Google-Smtp-Source: ABdhPJw+r5KJc+NXmocsDxn0LpNLvrGDLwtoLSWdp+GS42u50cM/5H4Y03a+EK80EQPShoK+e1RgzA==
X-Received: by 2002:a05:622a:170a:: with SMTP id h10mr9347927qtk.276.1625421833445;
        Sun, 04 Jul 2021 11:03:53 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s65sm1802586qkd.66.2021.07.04.11.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 11:03:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 04 Jul 2021 14:03:51 -0400
Message-Id: <CCKJY96Q4FYN.3DIC7GLU3C8QN@shaak>
Cc:     <peda@axentia.se>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 03/10] iio: inkern: make a best effort on offset
 calculation
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210701010034.303088-1-liambeguin@gmail.com>
 <20210701010034.303088-4-liambeguin@gmail.com>
 <20210704172643.074cf8c6@jic23-huawei>
In-Reply-To: <20210704172643.074cf8c6@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun Jul 4, 2021 at 12:26 PM EDT, Jonathan Cameron wrote:
> On Wed, 30 Jun 2021 21:00:27 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > iio_convert_raw_to_processed_unlocked() assumes the offset is an
> > integer. Make a best effort to get a valid offset value for fractional
> > cases without breaking implicit truncations.
> >=20
> > Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed va=
lue")
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>

Hi Jonathan,

Thanks for taking the time to review this again.

> Looks good, but a few really minor comments / questions inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/inkern.c | 36 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index b69027690ed5..e1712c1099c5 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -578,13 +578,39 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
> >  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *c=
han,
> >  	int raw, int *processed, unsigned int scale)
> >  {
> > -	int scale_type, scale_val, scale_val2, offset;
> > +	int scale_type, scale_val, scale_val2;
> > +	int offset_type, offset_val, offset_val2;
> >  	s64 raw64 =3D raw;
> > -	int ret;
> > +	int tmp;
> > =20
> > -	ret =3D iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
> > -	if (ret >=3D 0)
> > -		raw64 +=3D offset;
> > +	offset_type =3D iio_channel_read(chan, &offset_val, &offset_val2,
> > +				       IIO_CHAN_INFO_OFFSET);
> > +	if (offset_type >=3D 0) {
> > +		switch (offset_type) {
> > +		case IIO_VAL_INT:
> > +			break;
> > +		case IIO_VAL_INT_PLUS_MICRO:
> > +			fallthrough;
>
> I'm fairly sure you don't need to mark fallthroughs in the case where
> there is nothing in the case statement at all. That case is assumed
> to be deliberate by the various static checkers. I am seeing a few
> examples as you have it here in kernel, but it certainly isn't
> particularly common
> so I'm assuming those where the result of people falsely thinking it was
> necessary
> or the outcomes of code changes in the surrounding code.
>

I thought it was always required with `-Wimplicit-fallthrough`.
Building without it gives no warnings, and after looking into it a
little, I found a bugzilla thread[1] that confirms what you're saying.
Thanks for pointing that out.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D7652

> > +		case IIO_VAL_INT_PLUS_NANO:
> > +			/*
> > +			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
> > +			 * implicitely truncate the offset to it's integer form.
> > +			 */
> > +			break;
> > +		case IIO_VAL_FRACTIONAL:
> > +			tmp =3D offset_val / offset_val2;
> > +			offset_val =3D tmp;
>
> What benefit do we get from the local variable?
> offset_val /=3D offset_val2; would be alternative.
>

Apologies for that, will fix!

Thanks,
Liam

> > +			break;
> > +		case IIO_VAL_FRACTIONAL_LOG2:
> > +			tmp =3D offset_val / (1 << offset_val2);
> > +			offset_val =3D tmp;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		raw64 +=3D offset_val;
> > +	}
> > =20
> >  	scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> >  					IIO_CHAN_INFO_SCALE);

