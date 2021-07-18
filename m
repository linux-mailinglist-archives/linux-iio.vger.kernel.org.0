Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9193A3CCB9C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhGRXrN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 19:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhGRXrM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Jul 2021 19:47:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E16C061762;
        Sun, 18 Jul 2021 16:44:13 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c15so7514036qvw.6;
        Sun, 18 Jul 2021 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=svpjNqOkfJIQZQ1rk3lE2BdsUxTlWwUiTxu51bKxU00=;
        b=hgz8FS4QJf9RjLEyIBkcKMIfFxyZZHBZQKHwydjPYJUqa/SllD5T/gSi+XVk1/+ych
         y6JzLyYFjnrAw5lgs4gTQk+Mou8PbzcK7+YKw2O6TLEoiuu3pK4j9TNjjQApX2zfM/jF
         Rw6DPVejQpmbJ+I/p6VJkZHvFhK4qe/gsUB5nsm9J0cFPXof9jF6Yn9yoDOyuIggUgx6
         USIuyt9XU2F5rvE9i7/83mDYzrj7gSFj1+X0cbDA3YPWrwoILUFpn1eR0S4YQ5IvV0A1
         08uAMwMqYgtj6otKb2akq5gaNWlxZQC3KZMP0bX0IUM6ZCnQYkQqvVYx59GUcbc9SN+R
         TU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=svpjNqOkfJIQZQ1rk3lE2BdsUxTlWwUiTxu51bKxU00=;
        b=TdT9YxgLYs/2YhVIGBH8vVB9ipP2Qu5PR5esW9COwPvstybWAMdEhnGMRtaaMsfWxk
         B3xASPKOB+SbfDhRNd87Ept/gl1hAwQMpusC5TxAWW05nMBy4ejbZwkMwh8EdwdZrfmM
         PSQCne5hvkYeR7qGAmSwqQcUXcIa+FuTME/Sz4viIG2cNCQmQEo042gPOH1Sjz4QX+Nv
         p+uwhm8/KEt6fuhpya8VVosNo4djDHg+hQU9EnnzKFT4IVs6Xjbbvx1VYMxcwtbw9mgm
         sqJpc1v5rRoS50e6is3v6UbcGK924hX+3R/HU4OA4OrlVcIIqX/fPYJQ+tTexGqr/OBm
         xuJA==
X-Gm-Message-State: AOAM530lqqPblohHvl8uhY7T4jM0uXBP9xHrqENAkxgUrnCnzF1745Eq
        NWRDQO0L4w1YCJFt+SQ+VCk=
X-Google-Smtp-Source: ABdhPJz8RB6oYos+iSFqC1MPav8BuN6Q69Nk/j5NM+OxmrwJ2xVssNoJUb3Mscox1HaBfPbUiJiINg==
X-Received: by 2002:ad4:56e4:: with SMTP id cr4mr22156376qvb.54.1626651852442;
        Sun, 18 Jul 2021 16:44:12 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id d8sm7225123qkk.119.2021.07.18.16.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 16:44:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 18 Jul 2021 19:44:10 -0400
Message-Id: <CCWNYFYK095U.B3ZVEH0JYVLA@shaak>
Cc:     "Peter Rosin" <peda@axentia.se>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-6-liambeguin@gmail.com>
 <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
 <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak> <20210717175551.20265ac4@jic23-huawei>
In-Reply-To: <20210717175551.20265ac4@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat Jul 17, 2021 at 12:55 PM EDT, Jonathan Cameron wrote:
> On Fri, 16 Jul 2021 15:18:33 -0400
> "Liam Beguin" <liambeguin@gmail.com> wrote:
>
> > On Thu Jul 15, 2021 at 5:48 AM EDT, Peter Rosin wrote:
> > >
> > > On 2021-07-15 05:12, Liam Beguin wrote: =20
> > > > From: Liam Beguin <lvb@xiphos.com>
> > > >=20
> > > > Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> > > > Add support for these to allow using the iio-rescaler with them.
> > > >=20
> > > > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > > > ---
> > > >  drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-re=
scale.c
> > > > index 4c3cfd4d5181..a2b220b5ba86 100644
> > > > --- a/drivers/iio/afe/iio-rescale.c
> > > > +++ b/drivers/iio/afe/iio-rescale.c
> > > > @@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indi=
o_dev,
> > > >  			do_div(tmp, 1000000000LL);
> > > >  			*val =3D tmp;
> > > >  			return ret;
> > > > +		case IIO_VAL_INT_PLUS_NANO:
> > > > +			tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator=
;
> > > > +			do_div(tmp, rescale->denominator);
> > > > +
> > > > +			*val =3D div_s64(tmp, 1000000000LL);
> > > > +			*val2 =3D tmp - *val * 1000000000LL;
> > > > +			return ret; =20
> > >
> > > This is too simplistic and prone to overflow. We need something like
> > > this
> > > (untested)
> > >
> > > tmp =3D (s64)*val * rescale->numerator;
> > > rem =3D do_div(tmp, rescale->denominator);
> > > *val =3D tmp;
> > > tmp =3D ((s64)rem * 1000000000LL + (s64)*val2) * rescale->numerator;
> > > do_div(tmp, rescale->denominator);
> > > *val2 =3D tmp;
> > >
> > > Still not very safe with numerator and denominator both "large", but
> > > much
> > > better. And then we need normalizing the fraction part after the abov=
e,
> > > of
> > > course.
> > > =20
> >=20
> > Understood, I'll test that.
> >=20
> > > And, of course, I'm not sure what *val =3D=3D -1 and *val2 =3D=3D 500=
000000
> > > really
> > > means. Is that -1.5 or -0.5? The above may very well need adjusting f=
or
> > > negative values...
> > > =20
> >=20
> > I would've assumed the correct answer is -1 + 500000000e-9 =3D -0.5
> > but adding a test case to iio-test-format.c seems to return -1.5...
>

Hi Jonathan,

> No. -1.5 is as intended, though the IIO_VAL_PLUS_MICRO is rather
> confusing
> naming :( We should perhaps add more documentation for that. Signs were
> always a bit of a pain with this two integer scheme for fixed point.
>
> The intent is to have moderately readable look up tables with the
> problem that
> we don't have a signed 0 available. Meh, maybe this decision a long time
> back wasn't a the right one, but it may be a pain to change now as too
> many
> drivers to check!
>
> 1, 0000000 =3D=3D 1
> 0, 5000000 =3D=3D 0.5
> 0, 0000000 =3D=3D 0
> 0, -5000000 =3D=3D -0.5
> -1, 5000000 =3D=3D -1.5
>

Understood, thanks for clearing that out.

Liam

>
> >=20
> > I believe that's a bug but we can work around if for now by moving the
> > integer part of *val2 to *val.
>
> Yup. Fiddly corner cases..
>
> Jonathan
>
> >=20
> > Liam
> >=20
> > > Cheers,
> > > Peter
> > > =20
> > > > +		case IIO_VAL_INT_PLUS_MICRO:
> > > > +			tmp =3D ((s64)*val * 1000000LL + *val2) * rescale->numerator;
> > > > +			do_div(tmp, rescale->denominator);
> > > > +
> > > > +			*val =3D div_s64(tmp, 1000000LL);
> > > > +			*val2 =3D tmp - *val * 1000000LL;
> > > > +			return ret;
> > > >  		default:
> > > > +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
> > > >  			return -EOPNOTSUPP;
> > > >  		}
> > > >  	default:
> > > >  =20
> >=20

