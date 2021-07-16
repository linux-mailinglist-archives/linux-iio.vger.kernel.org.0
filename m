Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B533CBC44
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jul 2021 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhGPTVc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Jul 2021 15:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhGPTVb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jul 2021 15:21:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D2C06175F;
        Fri, 16 Jul 2021 12:18:36 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m3so9739986qkm.10;
        Fri, 16 Jul 2021 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=1r09uS1rxtOnlc1hkLX7O1w4u27LN+vnvyQRmy2lAkc=;
        b=WJP8YiJqBTwNfuiSM6T3BtIXFKUhUj8Mi3NRsfKuidYFfya1GF7d0BsGVl4vkeonzX
         ek/1jYxqudLe5cotv6gbYJLH0UUeHr+ur0kedfUncWAjgdxSwUgO6z+wI26Kz6c/aGBF
         0ZnufqlmCjGx7R8DJ2XEe8TW3nxiHYl0iFg8LXqaFqQe9uALNO+9Zmqfhiy/7vkpEqS4
         iYWlexEYMRfLh/5elCXGXijLOkq6sod60XZJ1aHyYqyff3LSE/M9pxiHpr/pDWzoE/R3
         4a5/yNjQN/+1QBDyJovqo5B6gQeDnTj0OmjQu2rPQIaI+Kq+z+hVDK3qilZOCkOgjkPX
         cnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=1r09uS1rxtOnlc1hkLX7O1w4u27LN+vnvyQRmy2lAkc=;
        b=YGwzVkPm5Myw6Yfmf6d4R1BCr02oWhcsnTcYSMlykxY1Gwwedo7/MjkaUiGtNY9jl9
         aJMuqgH3lyatewm2NJUK5nvSnM/SqhMJQXyOHb0GidvrdG3KZt56rrjiwqc2LzT+tT9Y
         v53FRCpcOrIjhiaivHg/7A9acpe3s0exb2Q/Ne5I9/qXfC7kBgka2EVMKY38YrEc5yZ3
         sAXoxfbrJsE0bnqrEo7gCZVrzX4OzFSpvQMVD/kiXAbgU9BV9WofnyNkfA5/wRJGxlCA
         EIzNypwsjZm1N/qIHFU5lvzhWSW3jE03K9081rChg98UfzlhQad9SpFZ4LLX5tE3SDmm
         Shkw==
X-Gm-Message-State: AOAM531LKV9yujNG0pUklNL9JnmA9uyeAJvsJns73EZKfbg5B6fmwPLM
        dgCixrHi+bmYLqT35krh/a4=
X-Google-Smtp-Source: ABdhPJx/1NDB3gesF4KpNANLA/3X4H8zBQvNdKbJmelf+kkEW8hYLzBlcX2sBukqg12tf4Zre1AEzw==
X-Received: by 2002:a37:5d46:: with SMTP id r67mr11492788qkb.12.1626463115264;
        Fri, 16 Jul 2021 12:18:35 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h68sm4342737qkf.126.2021.07.16.12.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 12:18:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Jul 2021 15:18:33 -0400
Message-Id: <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-6-liambeguin@gmail.com>
 <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
In-Reply-To: <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu Jul 15, 2021 at 5:48 AM EDT, Peter Rosin wrote:
>
> On 2021-07-15 05:12, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> > Add support for these to allow using the iio-rescaler with them.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 4c3cfd4d5181..a2b220b5ba86 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indio_de=
v,
> >  			do_div(tmp, 1000000000LL);
> >  			*val =3D tmp;
> >  			return ret;
> > +		case IIO_VAL_INT_PLUS_NANO:
> > +			tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> > +			do_div(tmp, rescale->denominator);
> > +
> > +			*val =3D div_s64(tmp, 1000000000LL);
> > +			*val2 =3D tmp - *val * 1000000000LL;
> > +			return ret;
>
> This is too simplistic and prone to overflow. We need something like
> this
> (untested)
>
> tmp =3D (s64)*val * rescale->numerator;
> rem =3D do_div(tmp, rescale->denominator);
> *val =3D tmp;
> tmp =3D ((s64)rem * 1000000000LL + (s64)*val2) * rescale->numerator;
> do_div(tmp, rescale->denominator);
> *val2 =3D tmp;
>
> Still not very safe with numerator and denominator both "large", but
> much
> better. And then we need normalizing the fraction part after the above,
> of
> course.
>

Understood, I'll test that.

> And, of course, I'm not sure what *val =3D=3D -1 and *val2 =3D=3D 5000000=
00
> really
> means. Is that -1.5 or -0.5? The above may very well need adjusting for
> negative values...
>

I would've assumed the correct answer is -1 + 500000000e-9 =3D -0.5
but adding a test case to iio-test-format.c seems to return -1.5...

I believe that's a bug but we can work around if for now by moving the
integer part of *val2 to *val.

Liam

> Cheers,
> Peter
>
> > +		case IIO_VAL_INT_PLUS_MICRO:
> > +			tmp =3D ((s64)*val * 1000000LL + *val2) * rescale->numerator;
> > +			do_div(tmp, rescale->denominator);
> > +
> > +			*val =3D div_s64(tmp, 1000000LL);
> > +			*val2 =3D tmp - *val * 1000000LL;
> > +			return ret;
> >  		default:
> > +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
> >  			return -EOPNOTSUPP;
> >  		}
> >  	default:
> >=20

