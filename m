Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2F3D849C
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 02:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhG1AVw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 20:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhG1AVw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 20:21:52 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB3C061757;
        Tue, 27 Jul 2021 17:21:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w10so172801qtj.3;
        Tue, 27 Jul 2021 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=ieU8fOn6s7zZr4BKBCLnzcFzUpNY4Uo3GJhrUvPuu4g=;
        b=AIAsv0AlWgs1k360wEg3aMEqUQrT1BKCRb290p2lu9WwvRCNh8hLmPiCraFUhPzjpl
         1x+VmTtHpsY3djNoRPKuN2wg2iTH+P1cemMuJ4l1NduNzvtqK3ZObQSRYPKLNFocWL6D
         8KekdovqCNPjQnModVah6v34yWwtKKuw28wzksIUUYCuOeK/i1ev2Kb73GVkaazBuK3M
         MYsBN0P2aNP6exOM5Wt256oBnvqIXwaRz/r1c7aitxsxglGTlG2v7GVkJ3U9FM4Zp8RP
         2iWh5NgQetBTtUsY3e6+4XpZUp8wmGkZf4JXZm5YymNQzSMmnUClKd40KUyduLXGu5Rf
         5u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=ieU8fOn6s7zZr4BKBCLnzcFzUpNY4Uo3GJhrUvPuu4g=;
        b=K8ZaK1roKcI8FlN7hgX21KnEfa6N7LQQZvHxelWYJ6Z6H11XP0EpwMsKxmxu/p3gkr
         Pxi0/A5yTvhRCBkAN/70uzou/aUuhyySOAsgA1miVousVrVHzbdlQG8gpIaqbsJOO81l
         hrQB3LC7Ltkfi3ajr8T+DwdZlkOoapiWx6PBBlbP4uUgSm4/LsEXOUkOhKwlRNlnPW3y
         EPVgN6cMtYEIT3VfkK52rKZyazpafuoqPOOs7/mggjE9nsmBQQsyMWgZK5JXpR4YvM4K
         jTUhKcy0Kh+QtAjS5aizWEyT7aD0nBl6pvsX0BU3xhNMIG4FzyjIciVHrrPez8fPKvse
         Hszw==
X-Gm-Message-State: AOAM533BgqWyeDTIg7HI8DbiN49DwmC1/Cg0HMvNQKLIT4Ws2KIhWiyR
        mgVrjZ4eBf2ouI7/UvmAL9I=
X-Google-Smtp-Source: ABdhPJy8/TiXPSDBefBE/yQ/IwZqAhSmSMbgSyZSbc3eEOQbjykxuX8ldZd1YJ7sjbSuVEjd4i779Q==
X-Received: by 2002:ac8:73c2:: with SMTP id v2mr22147267qtp.86.1627431709652;
        Tue, 27 Jul 2021 17:21:49 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id a21sm2533000qkk.74.2021.07.27.17.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 17:21:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Jul 2021 20:21:48 -0400
Message-Id: <CD4CE5OQT5TJ.2BFPBRYK7FCOW@shaak>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
From:   "Liam Beguin" <liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-6-liambeguin@gmail.com>
 <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
In-Reply-To: <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:
> On 2021-07-21 05:06, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> > Add support for these to allow using the iio-rescaler with them.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index d0669fd8eac5..2b73047365cc 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale, i=
nt scale_type,
> >  		do_div(tmp, 1000000000LL);
> >  		*val =3D tmp;
> >  		return scale_type;
> > +	case IIO_VAL_INT_PLUS_NANO:
> > +		tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> > +		tmp =3D div_s64(tmp, rescale->denominator);
> > +
> > +		*val =3D div_s64(tmp, 1000000000LL);
> > +		*val2 =3D tmp - *val * 1000000000LL;
> > +		return scale_type;

Hi Peter,

>
> Hi!
>
> My objection from v5 still stands. Did you forget or did you simply send
> the
> wrong patch?

Apologies, again I didn't mean to make it seem like I ignored your comments=
.
I tried your suggestion, but had issues when *val2 would overflow into
the integer part.
Even though what I has was more prone to integer overflow with the first
multiplication, I thought it was still a valid solution as it passed the
tests.

>
> Untested suggestion, this time handling negative values and
> canonicalizing any
> overflow from the fraction calculation.
>
> neg =3D *val < 0 || *val2 < 0;
> tmp =3D (s64)abs(*val) * rescale->numerator;
> rem =3D do_div(tmp, rescale->denominator);
> *val =3D tmp;
> tmp =3D rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
> do_div(tmp, rescale->denominator);
> *val2 =3D do_div(tmp, 1000000000LL);
> *val +=3D tmp;
> if (neg) {
> if (*val < 0)
> *val =3D -*val;
> else
> *val2 =3D -*val;

I'll look into this suggestion.

> }
>
> > +	case IIO_VAL_INT_PLUS_MICRO:
> > +		tmp =3D ((s64)*val * 1000000LL + *val2) * rescale->numerator;
> > +		tmp =3D div_s64(tmp, rescale->denominator);
> > +
> > +		*val =3D div_s64(tmp, 1000000);
>
> Why do you not have the LL suffix here?

Doesnt' LL make it into a 64 bit integer?
I left it out because the second parameter of div_s64() should be s32.

Thanks,
Liam

>
> Cheers,
> Peter
>
> > +		*val2 =3D tmp - *val * 1000000;
> > +		return scale_type;
> >  	default:
> >  		return -EOPNOTSUPP;
> >  	}
> >=20

