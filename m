Return-Path: <linux-iio+bounces-8375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB8F94D3FA
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 17:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C446AB216FD
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91040198A05;
	Fri,  9 Aug 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahnxmxkb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07B168B8;
	Fri,  9 Aug 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218685; cv=none; b=F0cUOukAa1Oqw/KJPnWfY33n77r82rr1Wh1ywpLc8lOUSvMuLpGQ59SAKvM9oKkfeXXeyCsqmljXO7B74iyRD5v14fKshcDozcQOljmMHvId0A4+LbF0UFoxLaV7pMpIkrPjazWKFBPMjWKAFaQ4NLU5rlHjNk/btJ5TLZ8FMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218685; c=relaxed/simple;
	bh=hd5zNE5+zWumVAjFm0XVJQp/mAXvj77eS7dwn84251c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DOolO4n8wa7rhzU6dW1/lbMG/9LYcpO7dSWVbJUMnOlsnJtCpS9HyusumC29l7ozRXxGE5Ssbc0ROZqII7EgncO2cfXkSzhLDvl7Foubz6PKuFSl54OtXuwGEq9F+l32IBdic+q9rbv45rcMLQBX42rWdnrIpfEfmQPyTH7CVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahnxmxkb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so14830015e9.2;
        Fri, 09 Aug 2024 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723218682; x=1723823482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZTujf5Zs1EDU0Z1KT2lmwI5sHT0BQmNKS6WrYiVFJo=;
        b=ahnxmxkb9KQFXD4un7ybLEXi8f3CqGsYP3gQxrzGY8SP8IQBsPvfec+DfySpbDbZjE
         bmjUiBPzwKQq4/hgJzpTErU25AeEgZk7wY/qT1KDS/shJG2Gz0QW4R+9lkWYSvZZKxM6
         i+G6vsTNX7Ru+6ZzoZosNediurjfk9J9eD8fn2G9SHLBNoGyGoUbvTLSFd90LbHifkdj
         t2Htl6zkeEDJ81jwCU6/E7daWI3Dj3EsUdp/9GFj/yycHAZn49C1x7j1TZYUCouO0XbO
         rGZspbW+tsY0WxBlRqbjf7h3GQzSEyaxJb+pxPy5SWQNAe1ZpDesOmKLVW6P0cO9sBHK
         9qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723218682; x=1723823482;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZTujf5Zs1EDU0Z1KT2lmwI5sHT0BQmNKS6WrYiVFJo=;
        b=ulXbk6eBylt1sIDcxjt601fpzPd0OWOB63WgAwBSWBXc/2H+dkYu1ybm30wJXoohUM
         8FqGUuHyGamyGcKPgJHfiWXUf6EPEzWSOFDaU5cPP/xMJzGiRoeTh9mJbNAvXhEfvh9I
         Ek2nJoVDtochAGxUof2iEDOaxpHIgUBBrwKuSO6qs50waYIiXC8+//QC5e1POBL/0o9y
         W+DdvueujKVXzRwBkDnRo7k67Glw2gjj8QoLg4XTfvpbXc3GDmgIRaEglEaGCp2C60fg
         C+rRi7GAAI4uJ/SAOLMlkAZiY2z818l8yjCo0MSAT8Gw00iMB3sFevYjAf+2Ruv9K85R
         cDpA==
X-Forwarded-Encrypted: i=1; AJvYcCVUHgPAydOhY9sRwS0BObLf/KkvxvLrDNJzhuDqAKBTHN9TkE6JcJjCx/iCqg2mIDH82fPjz5soNCozULiO@vger.kernel.org, AJvYcCXg67SeWUvkrHDqGArfvUFUk4CW6gqm9Qo3HZ52Eh76p3Lq/9WIYLXpxqTupkxDYPRBvhHuq5gVcUselhoi5O8=@vger.kernel.org, AJvYcCXgnVoFNnkRQcsihFr7DMCivhw+7vWJNXTEiz+v4atfHlmXPnHJZRnTx//8O4d+1FACd0Dmfq/29dfp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/3KjBn6vs47FmrJCYhcynoIf2dwdVx+RjUrpNlf4PCB2wPL9
	fWG3u20fS00GEYItXONB7HIbWwaqSQKWtGQZz8omLgYQzQdRBvnB
X-Google-Smtp-Source: AGHT+IGYj5j70epkeFIRqQMWluaYBwJtAUzZZ2J886RgmY+kRXmvdAJ6fQZ+NM964Qzt7m1bltHC+Q==
X-Received: by 2002:a5d:65c4:0:b0:360:7971:7e2c with SMTP id ffacd0b85a97d-36d61cd2a7cmr1667118f8f.54.1723218681787;
        Fri, 09 Aug 2024 08:51:21 -0700 (PDT)
Received: from localhost (host-87-20-57-122.retail.telecomitalia.it. [87.20.57.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718c020sm5673980f8f.55.2024.08.09.08.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:51:21 -0700 (PDT)
Date: Fri, 09 Aug 2024 17:51:20 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: dan.carpenter@linaro.org, 
 jic23@kernel.org, 
 kernel-janitors@vger.kernel.org, 
 lars@metafoo.de, 
 linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66b63af81a153_27fed37066@njaxe.notmuch>
In-Reply-To: <93f18533-da95-4f29-b6d9-8b8337a4cc90@wanadoo.fr>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
 <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
 <66b5c5df76766_133d37031@njaxe.notmuch>
 <93f18533-da95-4f29-b6d9-8b8337a4cc90@wanadoo.fr>
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

Christophe JAILLET wrote:
> Le 09/08/2024 =C3=A0 09:31, Matteo Martelli a =C3=A9crit=C2=A0:
> > Christophe JAILLET wrote:
> >> Le 08/08/2024 =C3=A0 21:28, Dan Carpenter a =C3=A9crit=C2=A0:
> >>> This error path was intended to return, and not just print an error=
.  The
> >>> current code will lead to an error pointer dereference.
> >>>
> >>> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> >>> Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@=
public.gmane.org>
> >>> ---
> >>>    drivers/iio/adc/pac1921.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> >>> index d04c6685d780..8200a47bdf21 100644
> >>> --- a/drivers/iio/adc/pac1921.c
> >>> +++ b/drivers/iio/adc/pac1921.c
> >>> @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *c=
lient)
> >>>    =

> >>>    	priv->regmap =3D devm_regmap_init_i2c(client, &pac1921_regmap_c=
onfig);
> >>>    	if (IS_ERR(priv->regmap))
> >>> -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> >>> -			      "Cannot initialize register map\n");
> >>> +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> >>
> >> The (int) is unusual.
> >>
> > The (int) explicit cast is to address Wconversion warnings since dev_=
err_probe
> > takes an int as argument.
> =

> Ok, but:
> =

> 1) With the cast removed, on my x86_64:
> 	$ make CFLAGS=3D"-Wconversion" drivers/iio/adc/pac1921.o
> =

> doesn't generate any error.
> =

I can't reproduce the warning in that way either, but maybe CFLAGS gets
overridden in that case because with the following method I can see the
warning:

$ print "CFLAGS_pac1921.o :=3D -Wconversion" >> drivers/iio/adc/Makefile
$ print "CONFIG_IIO=3Dy\nCONFIG_PAC1921=3Dy" >> arch/x86/configs/x86_64_d=
efconfig
$ sed -i 's/CONFIG_WERROR=3Dy/CONFIG_WERROR=3Dn/g' arch/x86/configs/x86_6=
4_defconfig
$ make x86_64_defconfig
$ make -j7

drivers/iio/adc/pac1921.c: In function =E2=80=98pac1921_probe=E2=80=99:
drivers/iio/adc/pac1921.c:1171:36: warning: conversion from =E2=80=98long=
 int=E2=80=99 to =E2=80=98int=E2=80=99 may change value [-Wconversion]
 1171 |                 dev_err_probe(dev, PTR_ERR(priv->regmap),
      |                                    ^~~~~~~~~~~~~~~~~~~~~

Built with gcc version: gcc version 14.1.1 20240522 (GCC)

Same thing building for aarch64 with gcc version 12.2.0 (Debian 12.2.0-14=
)

> 2)
> 	$ it grep dev_err_probe.*\)PTR_ERR | wc -l
> 	2
> =

> 	$ it grep dev_err_probe.*PTR_ERR | wc -l
> 	1948
> So, should the cast be needed, maybe another fix could make sense?
>
It could be assigned to the ret value if that would be preferred:
	if (IS_ERR(priv->regmap)) {
		ret =3D (int)PTR_ERR(priv->regmap);
		return dev_err_probe(dev, ret, "Cannot initialize register map\n");
	}

Otherwise a more generic approach could be to let PTR_ERR directly cast t=
o
(int). I would say that if it is always called after an IS_ERR() it shoul=
d be
safe to cast to (int) since the latter should guarantee the pointer value=
 is
inside int size boundaries. The similar PTR_ERR_OR_ZERO also casts (impli=
citly)
to int but it also checks for IS_ERR before the cast.
Maybe another solution could be introducing a new macro that does the cas=
t but
before it checks the ptr with IS_ERR(), I came up with the following even=

though it doesn't look very idiomatic:

#define WITH_PTR_ERR(ret, ptr) if (IS_ERR(ptr) && (ret =3D (int)PTR_ERR(p=
tr)))
...
static int pac1921_probe(struct i2c_client *client)
{
        ...
	WITH_PTR_ERR(ret, priv->regmap) {
		return dev_err_probe(dev, ret, "Cannot initialize register map\n");
	}
}

Maybe there is already some similar use case?

Anyway, if in general it is preferred to avoid the explicit cast despite =
the
Wconversion warning I would be fine with it.

> CJ
> =


Thanks,
Matteo Martelli=

