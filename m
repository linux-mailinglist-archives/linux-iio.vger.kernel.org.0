Return-Path: <linux-iio+bounces-8377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F74594D52B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F851C2086A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD14338FA3;
	Fri,  9 Aug 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dza6BCoS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8517C7C;
	Fri,  9 Aug 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223088; cv=none; b=F8ienx9We0WvD8siaRD3YJtS3hrRRUSHFrOQ7Wn+BqpzniTcN7mQoNo2GANwtbLywphSyF5KyVFA12xKzluT2SHWkhyFkfJADxbBlZvlkSIKwTQlA1y5fDyyKZ80Ca5JFa/OtNW7rYxO3oVrBCa5rM9uxvUV/+0FMZGvcEs44rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223088; c=relaxed/simple;
	bh=hrnmeErojdiA+I0k4NgvkckjQHkW1luP3yBhEUDmQ/4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LdouMNy6F6zkb73ZUTUxUnG0Avxcl+0VBvLwJizzZbEAGm9HwEjlJ5m7PIsEsckn5D4MLwm5rizy5k2JdYxhUS00WsYA4ab7uqeTMz3Ww31OBcl/3rr3FB3+PZMqPt/NVquXAHt6wMr+UptBu+cEIuTI5vnFDNB968f5ZXrUN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dza6BCoS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so30067041fa.2;
        Fri, 09 Aug 2024 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723223084; x=1723827884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA8BUMo2DWii/pf5hxjTIaLLXUnl8JdFP7LfFEv3HGw=;
        b=dza6BCoSTWXfA61ulTG9Sw+NiwjF5qfwx3Q+g/IaAyESfrNCFx24A3pKNbgRQ2t/cz
         ye5b9AVlnpqGXqfjRSQKA0njMSVLoyJMrZAmwaozPKnLf62OUewYtEyYu01Q+Twpisii
         ZfnIIr3YNAdffWUsHonBurr40ALoDjCjcdzAvqqniW6TRJIdULBiDuK4cP/IsxSaAiVh
         wxnRep9yZVvlHGPKxBfNIMx9CvVET/k3BRCqb6MslXhr+oHy+2DrAudctj7AuHL25Hty
         Xvao+9DkW5n077ukV/mHJesNYNbvCbUreorpVlPzmWORKEUcgIpWqNJn28/Jew6jHcQ5
         +0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223084; x=1723827884;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CA8BUMo2DWii/pf5hxjTIaLLXUnl8JdFP7LfFEv3HGw=;
        b=cJ1YR+/hMLT6g5nEeKic6TwWGx+LUCLmkGETOHxzkyVaVzBSaymCFqwnL1fiwopj2U
         yLzZeHnkk8dKmWhworOro6shCnMBqGU3S1FA7cGM2/YpOHI8pWyOg2DDSz2flwsK4xLG
         VWdrmbbpgkEqE0+NFZ0mSrfQrHw1CFQ+cNETSicrdyRFQSbJDRkL78IDbb9WaSXImpHf
         gPT3hVyZUUDYHq/TxaWN921jYpxMWVWxMS+LVaK1oZ012BcdShMw57+QjLL0H9aJEEO/
         d6wgTFxjlKF3jL8C5BUry1a6DPSGHnxLzLimuHWsw4odWVqsad0U3BOszKY/0u62UjBZ
         uhyg==
X-Forwarded-Encrypted: i=1; AJvYcCWI15/KWXQLrbCrXgeQhmgkvt1pSsamJovhdhHa43EtTpT1waBmHucsoC03eWzJMO389QaNdaa6dUNpBOPD1XXvlZForWm8JFtAcEElTV/n8F4fe4aMnoai7Y3WDCSRIp1sWSUIgcHOyO4mZ2EkfgotO1WMqzhI3zbf7dmer5CDwIY11YbzFDs9
X-Gm-Message-State: AOJu0YwRWM8wf+sGRBbCU99J8vpHWdB871MSwWcoYK+sHhWOK16u/X/d
	lJOTCVj3yqCA2dPKzk5cRMbaoS1qY/YR8kwxRxo1KTCZcNurwOTB
X-Google-Smtp-Source: AGHT+IEogaHQ+6erGmkf2603lsnpyfvBNsTgKIdI7sJBTj58O9/d5ZootY8/r4dSB4VYNpignB5Ccw==
X-Received: by 2002:a2e:851:0:b0:2ee:7a71:6e3b with SMTP id 38308e7fff4ca-2f1a6c777bdmr14272561fa.27.1723223083892;
        Fri, 09 Aug 2024 10:04:43 -0700 (PDT)
Received: from localhost (host-87-20-57-122.retail.telecomitalia.it. [87.20.57.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a1b3dsm85626915e9.40.2024.08.09.10.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:04:43 -0700 (PDT)
Date: Fri, 09 Aug 2024 19:04:42 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Matteo Martelli <matteomartelli3@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: dan.carpenter@linaro.org, 
 jic23@kernel.org, 
 kernel-janitors@vger.kernel.org, 
 lars@metafoo.de, 
 linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66b64c2a27042_51cac37047@njaxe.notmuch>
In-Reply-To: <66b63af81a153_27fed37066@njaxe.notmuch>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
 <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
 <66b5c5df76766_133d37031@njaxe.notmuch>
 <93f18533-da95-4f29-b6d9-8b8337a4cc90@wanadoo.fr>
 <66b63af81a153_27fed37066@njaxe.notmuch>
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Matteo Martelli wrote:
> Christophe JAILLET wrote:
> > Le 09/08/2024 =C3=A0 09:31, Matteo Martelli a =C3=A9crit=C2=A0:
> > > Christophe JAILLET wrote:
> > >> Le 08/08/2024 =C3=A0 21:28, Dan Carpenter a =C3=A9crit=C2=A0:
> > >>> This error path was intended to return, and not just print an err=
or.  The
> > >>> current code will lead to an error pointer dereference.
> > >>>
> > >>> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > >>> Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0=
A@public.gmane.org>
> > >>> ---
> > >>>    drivers/iio/adc/pac1921.c | 4 ++--
> > >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.=
c
> > >>> index d04c6685d780..8200a47bdf21 100644
> > >>> --- a/drivers/iio/adc/pac1921.c
> > >>> +++ b/drivers/iio/adc/pac1921.c
> > >>> @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client =
*client)
> > >>>    =

> > >>>    	priv->regmap =3D devm_regmap_init_i2c(client, &pac1921_regmap=
_config);
> > >>>    	if (IS_ERR(priv->regmap))
> > >>> -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > >>> -			      "Cannot initialize register map\n");
> > >>> +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > >>
> > >> The (int) is unusual.
> > >>
> > > The (int) explicit cast is to address Wconversion warnings since de=
v_err_probe
> > > takes an int as argument.
> > =

> > Ok, but:
> > =

> > 1) With the cast removed, on my x86_64:
> > 	$ make CFLAGS=3D"-Wconversion" drivers/iio/adc/pac1921.o
> > =

> > doesn't generate any error.
> > =

> I can't reproduce the warning in that way either, but maybe CFLAGS gets=

> overridden in that case because with the following method I can see the=

> warning:
> =

> $ print "CFLAGS_pac1921.o :=3D -Wconversion" >> drivers/iio/adc/Makefil=
e
> $ print "CONFIG_IIO=3Dy\nCONFIG_PAC1921=3Dy" >> arch/x86/configs/x86_64=
_defconfig
> $ sed -i 's/CONFIG_WERROR=3Dy/CONFIG_WERROR=3Dn/g' arch/x86/configs/x86=
_64_defconfig
> $ make x86_64_defconfig
> $ make -j7
> =

> drivers/iio/adc/pac1921.c: In function =E2=80=98pac1921_probe=E2=80=99:=

> drivers/iio/adc/pac1921.c:1171:36: warning: conversion from =E2=80=98lo=
ng int=E2=80=99 to =E2=80=98int=E2=80=99 may change value [-Wconversion]
>  1171 |                 dev_err_probe(dev, PTR_ERR(priv->regmap),
>       |                                    ^~~~~~~~~~~~~~~~~~~~~
> =

> Built with gcc version: gcc version 14.1.1 20240522 (GCC)
> =

> Same thing building for aarch64 with gcc version 12.2.0 (Debian 12.2.0-=
14)
> =

> > 2)
> > 	$ it grep dev_err_probe.*\)PTR_ERR | wc -l
> > 	2
> > =

> > 	$ it grep dev_err_probe.*PTR_ERR | wc -l
> > 	1948
> > So, should the cast be needed, maybe another fix could make sense?
> >
> It could be assigned to the ret value if that would be preferred:
> 	if (IS_ERR(priv->regmap)) {
> 		ret =3D (int)PTR_ERR(priv->regmap);
> 		return dev_err_probe(dev, ret, "Cannot initialize register map\n");
> 	}
>
> Otherwise a more generic approach could be to let PTR_ERR directly cast=
 to
> (int). I would say that if it is always called after an IS_ERR() it sho=
uld be
> safe to cast to (int) since the latter should guarantee the pointer val=
ue is
> inside int size boundaries. The similar PTR_ERR_OR_ZERO also casts (imp=
licitly)
> to int but it also checks for IS_ERR before the cast.
> Maybe another solution could be introducing a new macro that does the c=
ast but
> before it checks the ptr with IS_ERR(), I came up with the following ev=
en
> though it doesn't look very idiomatic:
> =

> #define WITH_PTR_ERR(ret, ptr) if (IS_ERR(ptr) && (ret =3D (int)PTR_ERR=
(ptr)))
> ...
> static int pac1921_probe(struct i2c_client *client)
> {
>         ...
> 	WITH_PTR_ERR(ret, priv->regmap) {
> 		return dev_err_probe(dev, ret, "Cannot initialize register map\n");
> 	}
> }
> =

> Maybe there is already some similar use case?
> =

> Anyway, if in general it is preferred to avoid the explicit cast despit=
e the
> Wconversion warning I would be fine with it.
>

Adding another simple alternative I didn't think of before:
        ...
	ret =3D PTR_ERR_OR_ZERO(priv->regmap);
	if (ret)
		return dev_err_probe(dev, ret, "Cannot initialize register map\n");

The warning would still be produced due to the implicit cast inside
PTR_ERR_OR_ZERO but it could be fixed for all users with an explicit cast=
 if
there will be interest in future to do so.

Also used a bit around:
grep -R -A 3 'ret =3D PTR_ERR_OR_ZERO' . | grep -e '_err.*(' | wc -l
69

Thanks,
Matteo Martelli=

