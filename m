Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21A7395E0F
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhEaNxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 09:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhEaNvd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 09:51:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A149C0610F0;
        Mon, 31 May 2021 06:31:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 5so5530106qvk.0;
        Mon, 31 May 2021 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=OnDIUFyOX09LueOMLXguitQrR2khWTAPtxOM12rfEY8=;
        b=fRTnbf43AwoS+szL4BdFMBgLNrRZ0Ws8/g3iDNuhYXNpPlDFXvkP0FT39SxOizp/sb
         qr5LBftcQDsm4hJ+ilW5TH+suVQTtyAhUcGF/FNbpFvhFIEFoyJ5+ThRCwuI+ofz9dwb
         FTNG16CAF+x0PYmpSIwTtwkeCF3YCg9lLYXQISwR7+VL+1Hfn7JAwGGdLvopUR0QSdsw
         uZ7QcJwRE4KxleNjGJqjmzyaBWIDuf+x/kDPukOfpwaNoa9iUKx+onhl9nwTCTBf7DfD
         wz+vdCeObzvc5CDXt1ufizC9Q3+17h+pMOYH1qBrZncbjJWN2eFpKO4NZ/4Kh/kvv4df
         Geug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=OnDIUFyOX09LueOMLXguitQrR2khWTAPtxOM12rfEY8=;
        b=f2V4nrqFXl805c1l31/TW8bDxuc9o0TauS0+JzAZtCRCUetIqe4vq+WIKUBhv+tUz+
         zXrJy4IsKFcWKCgYxrnl73insQXsQw5vB0Fxxr8oHuB1ROXRsEHtvtv6Fmsm/XRghjME
         ClnedAE8zLSBRUK8sjK4dZ5fY6VK8FCJI/80fQQKZZLYoZLpE+SzDu99ZLzsKF6L8p7S
         VIwioX3DkXpr/9eY8ednvBBAtcYg9m/npXhuYTKbTgghOFAva06WztAz7rzsY7DHd0eg
         4X8vTN5r9x/5fLuRs3SB2JOCw54/1qyma1160Ii6D8RiuodlT9Ku2fjw3HDCnR+ztGIX
         uoWA==
X-Gm-Message-State: AOAM530ETEkKEUpagtav8CTYEd1FUfPJXlK7BG1MliIH61/v1jfTfohC
        9OyavE50isTVgk9ezP+wydvcRC3ce8WPmg==
X-Google-Smtp-Source: ABdhPJxnTWnTn/Rz7jx70DYMb3UJHB6DLgwI34KAIQ6nOsgpE/n2WKEC2N0XhkGZc+ErUUNt3j5Xzg==
X-Received: by 2002:a05:6214:b0b:: with SMTP id u11mr17089481qvj.9.1622467910918;
        Mon, 31 May 2021 06:31:50 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h6sm8260817qta.74.2021.05.31.06.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 06:31:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 May 2021 09:31:49 -0400
Message-Id: <CBRGVFX9GJMZ.22AK6P7RNXMES@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 2/9] iio: inkern: error out on unsupported offset
 type
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-3-liambeguin@gmail.com>
 <7e6e7e30-80b6-adfd-abda-7c9ac5333a47@axentia.se>
In-Reply-To: <7e6e7e30-80b6-adfd-abda-7c9ac5333a47@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Mon May 31, 2021 at 5:45 AM EDT, Peter Rosin wrote:
> Hi!
>
> On 2021-05-30 02:59, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > iio_convert_raw_to_processed_unlocked() assumes the offset is an
> > integer. Make that clear to the consumer by returning an error when an
> > unsupported offset type is detected.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/inkern.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 4b6a8e11116a..dede4536d499 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -595,8 +595,12 @@ static int iio_convert_raw_to_processed_unlocked(s=
truct iio_channel *chan,
> >  	int ret;
> > =20
> >  	ret =3D iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
> > -	if (ret >=3D 0)
> > +	if (ret =3D=3D IIO_VAL_INT) {
> >  		raw64 +=3D offset;
> > +	} else if (ret >=3D 0) {
> > +		dev_err(&chan->indio_dev->dev, "unsupported offset type");
> > +		return -EINVAL;
> > +	}
> > =20
> >  	scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> >  					IIO_CHAN_INFO_SCALE);
> >=20
>
> This breaks the implicit truncation that happens for drivers that have
> offsets of type IIO_VAL_INT_PLUS_{MICRO_DB,MICRO,NANO}
>
> Implicit truncation might be more appropriate than an error?
>
> However, to error out on fractional offsets etc still seem appropriate,
> but
> there are corner cases where the existing code did the right thing. E.g.
> a denominator of one or a fractional-log2 of zero, but a big denominator
> and
> a smaller numerator would also just result in a relatively harmless
> truncation.
>
> I don't know if it's really right to just break that?

Apologies for missing these. You're right that this change shouldn't
break what used to work implicitly. I'll rework this.

Liam

>
> Cheers,
> Peter

