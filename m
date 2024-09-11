Return-Path: <linux-iio+bounces-9443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2692974E91
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 11:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E29B2769D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2A176FB4;
	Wed, 11 Sep 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJjzRxav"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FE39FF3;
	Wed, 11 Sep 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047129; cv=none; b=awWygwLHKDVpve7T9Yp03NfSeSpAT3CGWq6JnVNvq4bApwYLoOYxudCde8xvyFekiskbvNUbeG7qtag9wDy0xTSFdIEwFOo8hKP2e1z38c3ouoA2lPmFPCcN2MGUkxmyEKvKlfECQNfC93M6EXjN5t7aGeGO8Epc4kCFhDFUcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047129; c=relaxed/simple;
	bh=/lzMI7lkxr5HsSnA+lxh+jsNOBfgAGNRVFfGoSf7mKw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=fWJp4yB9Q5oFrf2t8QAcy/tZwhoY9oUuhaKJGA3P+rP5bvdBMFLi0kXOkB9Qqe0WLqg2w89fJftkk6dwK5U4HPatK/e/Vj4ndKwPiL8cw+YQ6sxRNkhG3IXN3244qNUy5aqLmUYZxb5mT1g6xrxt7Br/N0ItiQlMV1P8gYLFv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJjzRxav; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so2112025e9.2;
        Wed, 11 Sep 2024 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726047126; x=1726651926; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4x9BHS5aQyg7uENQ+SBZxMU+e63nWlznvFKpVlIk0s=;
        b=mJjzRxavfLPZuzyb2voMIFHMfiqCmy+KnZ70wdS47hDVdbCdCfq7uNXttdphsD8MkR
         YUo0WbilpUNUOjovHGhdAUZDsqNhOioVd6LYSRWkpuLKxcjj9QDZB0Kt0/09qR12Ijxd
         5DmBb8V+TzHs3fF/4ijZodxrWMHsOkEuk2GqGhpD9GZKtU1NxU+XP5IA3kNR4eP8RR/l
         VlD5J1oKyOoGxu6FeWalduMeaTEA3cZbRz4bI4X+5njnf8KlWcXiCuJrhodYp8u9ATTB
         qqQ4CzXjj4pIg5J1G4jg4intpOd2Upx73px/Bn9SuUR8IIBPQTMsKY8nhhfpP5k0nLo+
         ZY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047126; x=1726651926;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4x9BHS5aQyg7uENQ+SBZxMU+e63nWlznvFKpVlIk0s=;
        b=lcj/V/IivWwuzlCSFrqbWGq5wFL0kalkD+mr6XpyS/UoBH690CAag8kE9AfK9nXMjj
         d0/ujG1ngTY5DYDhHukECS1lo1BVfkpUmmsmtrVRcazFD6YZ5eTcBE1b0zUt/x5MX3oQ
         oNkP6E4Hw8Y9jdIhSMYTxUearFwJHJjyo8oNijavpFs4Sc2RILrHlYrXfRNv0byNXWwb
         jXiQzeOBRjBzXfR9vTIbCpStc5YCK/67r39J3Ax7ssYEtFcJh0OL+XSKvhR+VVnmW77P
         V+6KWi+m1g8cAvtKa3zfLQSIsvxRHeyBUGUEvw+WSqEeg8Mdqb5v2m6wYpmndkLec9QS
         +tdA==
X-Forwarded-Encrypted: i=1; AJvYcCVRu0U0vqq6R91nmg0tjlerEXfCuLQ/31hihA7g4PRyF+8Hns4rGgYBj27q5P4N5kgzs8//1/6AEN7U@vger.kernel.org, AJvYcCVYZb16XT2FcVFjS+4/LfpMNNsgbD+FXW+D6j4RJjAVGlqUH5tSNVID1/4SagQGptIkTsFtcSBcqK/6O30to5A=@vger.kernel.org, AJvYcCX2VCBpxKuMDllx5UiV9LI9TpNYshJyDFDsJEcPnqxPiN+APHr8PgpQDZtRRvFSyQ2uAarRxHzhVt644X4m@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuko2dNV1LmUc2kCY/o0Q3Z2Y55EnO4jnQ+EJBMBtlJsR55zPd
	6zfBtk391Q8nNH27QlQDU5NIYzJReB+6E38xT3A86pE4fUDMAfWr
X-Google-Smtp-Source: AGHT+IFbLHZHNt2KPl6UEzHc2ky6htjZsB+AjOtpRdJPobywwu0/p+5pXgEu5bcyv7QAq0jXVYjE0Q==
X-Received: by 2002:a05:600c:1d98:b0:42c:b995:20c8 with SMTP id 5b1f17b1804b1-42cb9952455mr66838275e9.24.1726047126003;
        Wed, 11 Sep 2024 02:32:06 -0700 (PDT)
Received: from localhost (host-79-40-24-8.business.telecomitalia.it. [79.40.24.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c272esm169792685e9.8.2024.09.11.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:32:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240810113518.2cbceb66@jic23-huawei>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain> <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr> <66b5c5df76766_133d37031@njaxe.notmuch> <9a98aab5-bb68-4206-9ecf-32fbf6c9c7ef@stanley.mountain> <20240810113518.2cbceb66@jic23-huawei>
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 11 Sep 2024 11:32:04 +0200
Message-ID: <172604712407.3581.15543200034844778072@njaxe.localdomain>
User-Agent: alot/0.10

Quoting Jonathan Cameron (2024-08-10 12:35:18)
> On Fri, 9 Aug 2024 18:18:13 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
>=20
> > On Fri, Aug 09, 2024 at 09:31:43AM +0200, Matteo Martelli wrote:
> > > Christophe JAILLET wrote: =20
> > > > Le 08/08/2024 =C3=A0 21:28, Dan Carpenter a =C3=A9crit=C2=A0: =20
> > > > > This error path was intended to return, and not just print an err=
or.  The
> > > > > current code will lead to an error pointer dereference.
> > > > >=20
> > > > > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > > > > Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0=
A@public.gmane.org>
> > > > > ---
> > > > >   drivers/iio/adc/pac1921.c | 4 ++--
> > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > > > > index d04c6685d780..8200a47bdf21 100644
> > > > > --- a/drivers/iio/adc/pac1921.c
> > > > > +++ b/drivers/iio/adc/pac1921.c
> > > > > @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client =
*client)
> > > > >  =20
> > > > >         priv->regmap =3D devm_regmap_init_i2c(client, &pac1921_re=
gmap_config);
> > > > >         if (IS_ERR(priv->regmap))
> > > > > -               dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > > > > -                             "Cannot initialize register map\n");
> > > > > +               return dev_err_probe(dev, (int)PTR_ERR(priv->regm=
ap), =20
> > > >=20
> > > > The (int) is unusual.
> > > > =20
> > > The (int) explicit cast is to address Wconversion warnings since dev_=
err_probe
> > > takes an int as argument. =20
> >=20
> > I don't want to remove the int because it's unrelated, but Christophe i=
s right
> > that the int is unusual.  We really would want to discourage that.
>=20
> Applied, but I'd ideally like a follow up patch removing the int and the
> couple of similar instances from this driver.  Anyone want to spin one?
>=20

I can spin the patch, but at this point I am wondering whether I should rem=
ove all
the unnecessary explicit casts that I put to address Wconversion
and Wsign-compare warnings. If that's the general approach to help readabil=
ity I
am totally fine with it.

> Thanks,
>=20
> Jonathan
>=20

Thanks,
Matteo Martelli

