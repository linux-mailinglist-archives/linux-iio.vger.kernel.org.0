Return-Path: <linux-iio+bounces-8340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EEE94CB64
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B7E1F246B5
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9C178364;
	Fri,  9 Aug 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F29ZTZ9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB31779BA;
	Fri,  9 Aug 2024 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188708; cv=none; b=EBd2Wg0k3phBj0UstQXUuIk7sB+KKnsC9k2HPajygdfMdoHgAcdjRxfdjmxMhEWx9sdY2P/G262X27YIARjI6MBlEzmz1xi5a0INWw2KSFgFjrMYHub2F56mQxsgcoPnOYz7jb3ePD0FcQ5nRsXS1NEgFM8av2aJOFpPCdYd/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188708; c=relaxed/simple;
	bh=hNU3ozueY40LRoCvofvYQKhPPd3iK5bl8NdzeAq74qk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s8pPlgXeLgneImskjFtPH7PDkLkHfSy5n0lF9d4zgUxIsrFdCiT+CqfiuL1+pVfz5EMNjH/BveIpnA5UA0qlPvmEvG9PkpEJaIpoRyc+kI74vNv+/QLrr3xILgoygAiRF3w0jKglUQG7EJKmgsEJ9PTgac6NbkkuYg/BAL2O+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F29ZTZ9B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so9914945e9.1;
        Fri, 09 Aug 2024 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723188705; x=1723793505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0HItoXUY0vD1gfIPgJQfdPpyuKVG6YHUkSKI7hGTZg=;
        b=F29ZTZ9BkdxV4XT+FLVaHghXpbUsc3kSbp6ZHa1tsaLH0eXJKcrFfAt4Y1vT6EUULH
         quXvMt8ArW5x9isQvmKDHhfAbm/IIradAerV6HOT9CedeulMKiFLEw8BwSBqbnSkQl1x
         8qCazVtHTkNCp+a3t+Pvdfd4N45zlCK1fT/meHiJmjbUzQfVNR/OPvgEm69yG6FUi7ex
         n1eq+HyC3bjyRE0KpEDojYN7MJ250RyJZxiIO9f0Qg3sEhb4TtKYgpFWYpfHVsY5MNu+
         ytQPmiQcP6jRvUYOyxYIh6MKBM67lt9z9oC2DDKbCmkVhHBwRvXPsJxVjIQjgFppPIDL
         ZueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188705; x=1723793505;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m0HItoXUY0vD1gfIPgJQfdPpyuKVG6YHUkSKI7hGTZg=;
        b=rw8pkbw3z5IUGlLJo4kEB+7VgDTfcPlzAiU/hBCrDDBXny+1UR1TB9Ub47Y1/7iUHa
         +uVvLzFZOdqluhXMIfnY3UauYFv5kVuLWwa/R8lcYM0beNumGIOu9OZo/kC4nqH3oeIU
         U2V9tDDGIlVcRi/LfbGC5P2WCp2s0LFpwfRdzJ+DlW75HnHCGKTGWTrHPALESWaJJCwc
         BPpVSWxRCcVGr1EygXUvN3GrBdPasx+n/bc1VAeTRQOdkxJixSO87YVpQ57coqe8tj1f
         r/CiVLjo4YHOTiW48mj/zRJfcb9YUxnP5WJvnVZO5Dh8iXXdhRmNQPknB3GPmU3xW36z
         bi3A==
X-Forwarded-Encrypted: i=1; AJvYcCWbXRbE2v1NoiE88ZXbog563Cc5mpjxXmwvl+H5FgYbAm2+N+MAB3Xal+R8q1kcURFO8SK7r8JVa9BZ1KwqcKeriOcDbGqNsiYEDMcT7ij8r6CubuNKWDpztvUD2XRi8lSODmNj3lBJuHv2jAO81fF+L3C0hMkxXyMMgVLVGjB3eHU5LYLqpsl6
X-Gm-Message-State: AOJu0Yx1Kkio3bxVxfPbWyuIgOF3TW2vVmR2fbWR8oBhiK29XUUVZTBu
	o/vaugtMvyrMqXGvZEvSD0OzfK8RCHbJTstAyvOmUsS2YMKOp8s3
X-Google-Smtp-Source: AGHT+IHxM0Qxjf5+EXhqs8UX+4V8VT3XBx3QV4lPRJsN9yOxLS3fnFSOCpAf7E7SairwYIE7IZO7Kg==
X-Received: by 2002:a05:600c:3c8c:b0:424:7871:2e9e with SMTP id 5b1f17b1804b1-429c3ac6ademr5658885e9.6.1723188705113;
        Fri, 09 Aug 2024 00:31:45 -0700 (PDT)
Received: from localhost (host-87-20-57-122.retail.telecomitalia.it. [87.20.57.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d272290c2sm4422682f8f.92.2024.08.09.00.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:31:44 -0700 (PDT)
Date: Fri, 09 Aug 2024 09:31:43 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: jic23@kernel.org, 
 kernel-janitors@vger.kernel.org, 
 lars@metafoo.de, 
 linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 matteomartelli3@gmail.com
Message-ID: <66b5c5df76766_133d37031@njaxe.notmuch>
In-Reply-To: <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
 <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
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
> Le 08/08/2024 =C3=A0 21:28, Dan Carpenter a =C3=A9crit=C2=A0:
> > This error path was intended to return, and not just print an error. =
 The
> > current code will lead to an error pointer dereference.
> > =

> > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@pu=
blic.gmane.org>
> > ---
> >   drivers/iio/adc/pac1921.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > =

> > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > index d04c6685d780..8200a47bdf21 100644
> > --- a/drivers/iio/adc/pac1921.c
> > +++ b/drivers/iio/adc/pac1921.c
> > @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *cli=
ent)
> >   =

> >   	priv->regmap =3D devm_regmap_init_i2c(client, &pac1921_regmap_conf=
ig);
> >   	if (IS_ERR(priv->regmap))
> > -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > -			      "Cannot initialize register map\n");
> > +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> =

> The (int) is unusual.
>
The (int) explicit cast is to address Wconversion warnings since dev_err_=
probe
takes an int as argument.
> =

> CJ
> =

> > +				     "Cannot initialize register map\n");
> >   =

> >   	devm_mutex_init(dev, &priv->lock);
> >   =

> =


Thanks,
Matteo Martelli=

