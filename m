Return-Path: <linux-iio+bounces-9923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B8989E64
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 11:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4461F21274
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63091885A1;
	Mon, 30 Sep 2024 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj4zb/r9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3AD78C9D;
	Mon, 30 Sep 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688749; cv=none; b=X+YvLWxEc142HkF8DT5L//7ZXGC3yQ7ETCLLJIaakbNqJsedUYXC8Wv0+RfZ7vYqHsY0/TAXB6KHh/hOSpk/uTFlFuKfV4DbOwL4nDXQz6Ozcc0oAMu5qTnrxJQ31sTivKEJ+PHUoU/8YavfR8toiL9zJ/v2iJfNbwERvH3S+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688749; c=relaxed/simple;
	bh=xuiwIaxIkbOHoM0aTEL4ISfBrGnoJf3bN4UoKM/m9nc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=RvFwMCzRyhdnhha81Ft3TJsV5GaexjNjjJagOuuhu6flHYpBnHwuiLSEb7lln1rOz93rXyYz8fWN51/CRIaLMlbvXefJ22ytGTscgI09CJcIyHW2pNAo0ECxZABqTiEOTVRPJwoD3gXf69x6GUCN1LoUT5222EHJMJ6OEGROTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj4zb/r9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so37757175e9.3;
        Mon, 30 Sep 2024 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727688746; x=1728293546; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3gTkw7xTKBFjfPeQAsDpHjrUZGDOhEfBOfuDgEB4wY=;
        b=fj4zb/r9vXXjVgYXTtCYN3R4ZjT9KoH7podq46KuWMcYoalfg5zX9fonv9itwvWops
         pVkIBqes3RN8C66sqWT278+xDak5iYNUVQpzLpfOnRj4yktNRabHRvE1yYZom8xTBwfK
         oXC3wOsmVoeLxTKa9vkznuGhiodxbN4JCqT2kYeQPxZDCR2S7uV3NWZhElTKKRT/e4Ec
         l1goOnxEiligoprE2pRkQCv+kLf8w0rgNxuldRMUnMWmcLmrUjYFpODCNwupZGcFU/i/
         ph4sjspNHEDBXNu1AeqAEaUcf5U/sTqWMzNW/iqQwOd8e667BRqqZj6zbxjpZ9zgXjla
         Z9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688746; x=1728293546;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3gTkw7xTKBFjfPeQAsDpHjrUZGDOhEfBOfuDgEB4wY=;
        b=LPsoWFNmA2nd09rtnKP2mkCM8IeYQDyaOKC7A5vfWQWv20m+qkMb/4geuup17LcAgL
         PV30nm53HGiwdlANThSWHjkRQCzAuk9KhkWpNniZFipJ79u8fT++zXDKCnLpRxO3OaY2
         x/687IQ6sQdNoHCb26XyQBmg2jNhVkLVpvOXKG1sOBf37LIyQBuAhzzM7trUuLnhKnqd
         Slilxs46q5tvqWZ+uWoqq4wQlW6WbvY/Jog5WO+1q/Q14AM8cOT0CmOCL0LnmbZ80jUg
         naI98Nnh7ZDcoYucepoDiK7GyObMyjjII9wdRHm+1EurjI2mdegvr/dF90VzXxJ3qQ/v
         bYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4XUYocow2AURzBBFX3Y8jBTA1Ntp2DaBkYv9u+c6QJt54KypJ9vI09h8YLycJfrXDR+56fgHlyqc=@vger.kernel.org, AJvYcCVjEZmvkND43xmFccpYAXR5QeUMiFrDPJ1ZfpqRvtpisTqMujOYZ+6qX6CM7Trf2Hxf3WQQOMs7bz5mfCND@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvTy+mMc8Os7Sf3Udy1dErT72rsTNmLzkqhAmn/0URyanq+1n
	/a4nNU1bh3vdeYIeLQcaXM3vp6BOOXO34vrXuUnYF1fSMEhj0gnA
X-Google-Smtp-Source: AGHT+IHvj6MxPbBC4GQ3YDX25WnDza1AQMy3zlrwhwybHipguZmMLNodxIBVpYIPClX0B8gEJMO49w==
X-Received: by 2002:a05:600c:4ecd:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-42f5840e216mr87243025e9.4.1727688746036;
        Mon, 30 Sep 2024 02:32:26 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddb4csm145264235e9.6.2024.09.30.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:32:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240928162843.4eb63f29@jic23-huawei>
References: <20240916-iio-pac1921-nocast-v1-1-a0f96d321eee@gmail.com> <20240928162843.4eb63f29@jic23-huawei>
Subject: Re: [PATCH] iio: pac1921: remove unnecessary explicit casts
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 30 Sep 2024 11:32:24 +0200
Message-ID: <172768874424.228843.16360087197143367783@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Jonathan Cameron (2024-09-28 17:28:43)
> On Mon, 16 Sep 2024 14:00:05 +0200
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
>=20
> > Many explicit casts were introduced to address Wconversion and
> > Wsign-compare warnings. Remove them to improve readability.
> >=20
> > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
>=20
> No fixes tag on this one. Its not a bug, just a readability improvement.
>=20
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> There are a few cases in here where I think the cast is about ensuring
> we don't overflow in the maths rather than for warning suppression.
>=20
> We all love 32 bit architectures after all ;)
>=20
> Jonathan
>=20
> > ---
> > Link: https://lore.kernel.org/linux-iio/1fa4ab12-0939-477d-bc92-306fd32=
e4fd9@stanley.mountain/
> > ---
> >  drivers/iio/adc/pac1921.c | 43 +++++++++++++++++++++------------------=
----
> >  1 file changed, 21 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > index 4c2a1c07bc39..de69a1619a9e 100644
> > --- a/drivers/iio/adc/pac1921.c
> > +++ b/drivers/iio/adc/pac1921.c
> > @@ -240,8 +240,8 @@ static inline void pac1921_calc_scale(int dividend,=
 int divisor, int *val,
> >  {
> >       s64 tmp;
> > =20
> > -     tmp =3D div_s64(dividend * (s64)NANO, divisor);
> > -     *val =3D (int)div_s64_rem(tmp, NANO, val2);
> > +     tmp =3D div_s64(dividend * NANO, divisor);
>=20
> For this one, NANO is an unsigned long and dividend just an int.
> Either the s64 cast is needed because dividend * NANO might go out of
> unsigned long range which might (I think) be 32 bit on a 32bit machine
> or it doesn't.  If it does, then you need the cast, if not you don't
> need to use div_s64 as it's not that large.

Oops! While removing the casts I was only thinking about the sign change
for this case, which would not be an issue being the dividend always
positive. However you are indeed right, this would overflow in 32-bit
architectures. Thanks for catching it, I am going to reintroduce this
cast and the other similar one in the next patch version.

...

Thanks,
Matteo Martelli

