Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A038B3CBAB6
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jul 2021 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGPQtW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Jul 2021 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQtW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jul 2021 12:49:22 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3ADC06175F;
        Fri, 16 Jul 2021 09:46:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id gh6so4864859qvb.3;
        Fri, 16 Jul 2021 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=HP1IVoWcUpu03pWKu0gr3nGbUe2QQvaIWAyGYYu+z1w=;
        b=mqJCK1pNCVfRQuUhhlmEroh0rRPLLlGVvX/WjOBWhGD68OuP+GV1nToJawuBzPDvSe
         AWrjkAdX8xFsSb+unxnsYfN5R/IX+pK0KMu2+NmfufPLz+ye5Qtsh4Qz/v/m2/fab+EX
         2VUJFZia/PsjBKmpKfjdRArdTsvH7rviYuH5C8A2LuCYFK0Z4sgfRpppR3jtxvSus+PD
         SMzsNww5SL3vZp6qsYBOaUHY/HK3eN8PgRYT9M1a3ViBsid45BIPCwoM/9u93UueG7Zw
         SJFw93DFUBXYOiRTkNY8KkgEpKZw2e3ZnoNNcXk92x7HgiJYu3Ie3LBl0Ev1e2eZfZ8X
         yi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=HP1IVoWcUpu03pWKu0gr3nGbUe2QQvaIWAyGYYu+z1w=;
        b=eMwpUl89j6BV+/T4CktCbWDAKhgP57wW+VMUGjHkXOIHYIqWjWAiJN1KfyGHhT0Z7+
         HtpWFIWJ0Fei8gnPr4owxma3bT750r43E61MrEV/wd+1to7Wl7ysWxoe7Pnubl0hERJy
         92sS6rKQwhngH6WYljIXuRa7ChfBowQ8/d8uBJvPSjF4KbtTxq0W104Bia/ZKXa9sF0X
         Goh4t5mMBJXvmTg8Uc05xGiogv/d1w/bXiy96BiLuyvrEuYCTyPAsixpea/N0JqMfw3U
         PPXuAnGx+UkXMpxzoHm81cwDqM7O/5TSf5k4HkPHxhe/0lhsAR5s5cOxqgdgXXg7O98c
         N8cA==
X-Gm-Message-State: AOAM530IUHeEhXMC4BEPXDqxlrbFURv+ZQag47kdtKvIK6slhzmsA9YC
        xqbQQP30xOh33PerrP7domk=
X-Google-Smtp-Source: ABdhPJzaxFYkpff91JN66s0Lj90ASfGjvlnrk5Eh1Ear4i5wXDTDvhYM4qFtfaBA5ck/E3PzfXm4Yg==
X-Received: by 2002:a05:6214:230c:: with SMTP id gc12mr2759813qvb.42.1626453986228;
        Fri, 16 Jul 2021 09:46:26 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o18sm4276568qko.63.2021.07.16.09.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 09:46:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Jul 2021 12:46:24 -0400
Message-Id: <CCUPTHKOCEWC.3NLHJ5ACINRYN@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 04/10] iio: afe: rescale: reduce risk of integer
 overflow
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-5-liambeguin@gmail.com>
 <e83ee306-2421-c327-7627-18ae2a7928a8@axentia.se>
In-Reply-To: <e83ee306-2421-c327-7627-18ae2a7928a8@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu Jul 15, 2021 at 6:23 AM EDT, Peter Rosin wrote:
> On 2021-07-15 05:12, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Reduce the risk of integer overflow by doing the scale calculation with
> > 64bit integers and looking for a Greatest Common Divider for both parts
> > of the fractional value when required.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 774eb3044edd..4c3cfd4d5181 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev=
,
> >  			    int *val, int *val2, long mask)
> >  {
> >  	struct rescale *rescale =3D iio_priv(indio_dev);
> > -	unsigned long long tmp;
> > +	s64 tmp, tmp2;
> > +	u32 factor;
> >  	int ret;
> > =20
> >  	switch (mask) {
> > @@ -67,8 +68,16 @@ static int rescale_read_raw(struct iio_dev *indio_de=
v,
> >  		}
> >  		switch (ret) {
> >  		case IIO_VAL_FRACTIONAL:
> > -			*val *=3D rescale->numerator;
> > -			*val2 *=3D rescale->denominator;
> > +			tmp =3D (s64)*val * rescale->numerator;
> > +			tmp2 =3D (s64)*val2 * rescale->denominator;
> > +			if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> > +			check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {

Hi Peter,

>
> The white space should be like this, methinks.
>
> if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2))
> {
>

Sorry about that... Like I said in the cover letter, I'm working on
getting kunit tests running for the iio-rescale. At the moment it still
requires copying part of the code over and sure enough I forgot to copy
some of it back. My apologies for the noise...

This is what I meant to send:

case IIO_VAL_FRACTIONAL:
	if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
	    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
		tmp =3D (s64)*val * rescale->numerator;
		tmp2 =3D (s64)*val2 * rescale->denominator;
		factor =3D gcd(tmp, tmp2);
		do_div(tmp, factor);
		do_div(tmp2, factor);
	}

	*val =3D tmp;
	*val2 =3D tmp2;
	return ret;

I'll also move the opening bracket on a new line if you prefer.

> > +				factor =3D gcd(tmp, tmp2);
>
> And I just realized, gcd() works on unsigned values which is a bit safer
> for the
> scale factor. But here, for the actual values, more care is needed.
>

I added negative test cases to take this into account. I'll update and
resend. I'm going to find a way to get the test cases ready for the next
revision.

> > +				do_div(tmp, factor);
> > +				do_div(tmp2, factor);
> > +			}
> > +			*val =3D tmp;
> > +			*val2 =3D tmp2;
>
> And beside the above points, the whole mechanism seems broken. The
> returned value
> in the third argument to check_mul_overflow isn't useful if there is an
> overflow.
> Yet, the code continues to use tmp and tmp2 in case of overflow. And why
> do you
> first multiply tmp and tmp2 without checks, only to then do the same mul
> again
> but with checks? Or have I completely misunderstood how
> check_mul_overflow
> works?
>

Again, my apologies for this. It's not what I meant to send.
Hopefully the snippet above makes more sense.

Thanks for your time,
Liam

> Cheers,
> Peter
>
> >  			return ret;
> >  		case IIO_VAL_INT:
> >  			*val *=3D rescale->numerator;
> >=20

