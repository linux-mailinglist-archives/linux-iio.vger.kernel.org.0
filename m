Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA503CDC6D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhGSOwY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbhGSOuv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 10:50:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E6C0613B4;
        Mon, 19 Jul 2021 07:45:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id q15so8234014qtp.0;
        Mon, 19 Jul 2021 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=+qAeaJCZPqO/HVsIw3gOHNEnkqH/VbzFWNwRdJqpOrw=;
        b=chGmklXFlHaJdMw7VL24uwTgk+Ncrr3GltNArjBTjhgv9aOKWl4unqCMqzXYS/GREU
         af9olIRWxmV7LoIlqmiFvjNAHTj/y8iJFAgq2yPOTiW0yh6DIaORMpOdFgsYlpoN1yon
         7Wok7/91K91OB14MIFrE9TGGmEnx9YP4izp71QNW2VOT1LXJDzzZKWkEyODra50k0A0q
         gGsRJzvXzFCR8apLuXu08Iv99/uY39Ivjp5Mvw3bpr0Is9pidXWD+Ae2dXcRDIuE8gNz
         YY2UWAXbNSFRKwa7Kt2nv0uGYYL5QsAGBSue1FYqnjCSw5wp64tE7o1MmeTtV7/HkrW8
         Qwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=+qAeaJCZPqO/HVsIw3gOHNEnkqH/VbzFWNwRdJqpOrw=;
        b=le8lJIgpQtBsqu+XODtYHmev0b64EGpz8mIm30doPUigWlq5ExmeM5b5Qzfws+78Sx
         O8wnfE4ZqgRU8BIXbGbLa5ZDL8urMi70QYwEPhITDznOjb0tq9eOdkE7MovfbwwZ4KkJ
         WsD6e/fjjflu/Cp/vlGLh5wDgZUS7J95/rlQTkFV4uKBhUbHb5CJFxaiFVXo0k4xDn7c
         pftU0lFr76RbbwyDQxoeWaDmDF9RBrt9K5iGAxhwvRqbnsLHM9+9LgbO6FjhgRDTWgVf
         VB5++f3JhNoHmwIHcCz8Vr6LrYZ8FKbh62e74iBftnTjjFwC+YZumxtICpNo6FgAcxGe
         8z9Q==
X-Gm-Message-State: AOAM533Lk1XAvgJ0vui4zISe3maqfOKLtb01YirsbbTBil9jogQ0hJkc
        USyJPNfKwUfJeMdjBXcVbeIrADCAWoem7A==
X-Google-Smtp-Source: ABdhPJzvJBDWHwyGheIS1L0esL3PE5kRH/FI+uyHcJkwi/3SpWvAKSx07TbBJLgsZmR3mewTpwJp4A==
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr22426827qtn.114.1626707731696;
        Mon, 19 Jul 2021 08:15:31 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id c2sm8307508qkd.57.2021.07.19.08.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:15:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 19 Jul 2021 11:15:29 -0400
Message-Id: <CCX7RIIHKCA3.246SJ5U1XSOJK@shaak>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>,
        "Jonathan Cameron" <jic23@kernel.org>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-6-liambeguin@gmail.com>
 <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
 <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak> <20210717175551.20265ac4@jic23-huawei>
 <CCWNYFYK095U.B3ZVEH0JYVLA@shaak>
 <e6358b95-aaa8-dd66-079e-8ddec547c5a2@axentia.se>
In-Reply-To: <e6358b95-aaa8-dd66-079e-8ddec547c5a2@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Jul 19, 2021 at 4:31 AM EDT, Peter Rosin wrote:
>
>
> On 2021-07-19 01:44, Liam Beguin wrote:
> > On Sat Jul 17, 2021 at 12:55 PM EDT, Jonathan Cameron wrote:
> >> On Fri, 16 Jul 2021 15:18:33 -0400
> >> "Liam Beguin" <liambeguin@gmail.com> wrote:
> >>
> >>> On Thu Jul 15, 2021 at 5:48 AM EDT, Peter Rosin wrote:
> >>>>
> >>>> On 2021-07-15 05:12, Liam Beguin wrote: =20
> >>>>> From: Liam Beguin <lvb@xiphos.com>
> >>>>>
> >>>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> >>>>> Add support for these to allow using the iio-rescaler with them.
> >>>>>
> >>>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>>>> ---
> >>>>>  drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
> >>>>>  1 file changed, 15 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-re=
scale.c
> >>>>> index 4c3cfd4d5181..a2b220b5ba86 100644
> >>>>> --- a/drivers/iio/afe/iio-rescale.c
> >>>>> +++ b/drivers/iio/afe/iio-rescale.c
> >>>>> @@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indi=
o_dev,
> >>>>>  			do_div(tmp, 1000000000LL);
> >>>>>  			*val =3D tmp;
> >>>>>  			return ret;
> >>>>> +		case IIO_VAL_INT_PLUS_NANO:
> >>>>> +			tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator=
;
> >>>>> +			do_div(tmp, rescale->denominator);
> >>>>> +
> >>>>> +			*val =3D div_s64(tmp, 1000000000LL);
> >>>>> +			*val2 =3D tmp - *val * 1000000000LL;
> >>>>> +			return ret; =20
> >>>>
> >>>> This is too simplistic and prone to overflow. We need something like
> >>>> this
> >>>> (untested)
> >>>>
> >>>> tmp =3D (s64)*val * rescale->numerator;
> >>>> rem =3D do_div(tmp, rescale->denominator);
> >>>> *val =3D tmp;
> >>>> tmp =3D ((s64)rem * 1000000000LL + (s64)*val2) * rescale->numerator;
> >>>> do_div(tmp, rescale->denominator);
> >>>> *val2 =3D tmp;
> >>>>
> >>>> Still not very safe with numerator and denominator both "large", but
> >>>> much
> >>>> better. And then we need normalizing the fraction part after the abo=
ve,
> >>>> of
> >>>> course.
> >>>> =20
> >>>
> >>> Understood, I'll test that.
> >>>
> >>>> And, of course, I'm not sure what *val =3D=3D -1 and *val2 =3D=3D 50=
0000000
> >>>> really
> >>>> means. Is that -1.5 or -0.5? The above may very well need adjusting =
for
> >>>> negative values...
> >>>> =20
> >>>
> >>> I would've assumed the correct answer is -1 + 500000000e-9 =3D -0.5
> >>> but adding a test case to iio-test-format.c seems to return -1.5...
> >>
> >=20
> > Hi Jonathan,
> >=20
> >> No. -1.5 is as intended, though the IIO_VAL_PLUS_MICRO is rather
> >> confusing
> >> naming :( We should perhaps add more documentation for that. Signs wer=
e
> >> always a bit of a pain with this two integer scheme for fixed point.
> >>
> >> The intent is to have moderately readable look up tables with the
> >> problem that
> >> we don't have a signed 0 available. Meh, maybe this decision a long ti=
me
> >> back wasn't a the right one, but it may be a pain to change now as too
> >> many
> >> drivers to check!
> >>
> >> 1, 0000000 =3D=3D 1
> >> 0, 5000000 =3D=3D 0.5
> >> 0, 0000000 =3D=3D 0
> >> 0, -5000000 =3D=3D -0.5
> >> -1, 5000000 =3D=3D -1.5
> >>
> >=20
> > Understood, thanks for clearing that out.

Hi Peter,

>
> I just realized that do_div assumes unsigned operands...
>
> :-(

I noticed the same thing after adding the kunit tests.
I added patches for that.

For IIO_VAL_PLUS_{MICRO,NANO} specifically, I have something working but
I like your approach better so I'll work on it a little more.

Thanks,
Liam

>
> Cheers,
> Peter

