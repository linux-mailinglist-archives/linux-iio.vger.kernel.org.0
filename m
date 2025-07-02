Return-Path: <linux-iio+bounces-21222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D981AAF0C10
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 08:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8871C03AC7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E249224244;
	Wed,  2 Jul 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LwiNaZiM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD751FE46D
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439420; cv=none; b=Zxq59vQQqoiKHdcSz05tPsinTC/IbN5PWSYtrQuczeY495OYATnBNvUnRlxwnazZtaeYsJkJBNHivc73HuK7LhQT67ibowZZdI0ngKqWnLkOIu45m3acS3kBAkByYdidFP/KQQqBji4qDK0kWXazyS6GMO5IvF4G6PNlKF8pnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439420; c=relaxed/simple;
	bh=9eFrBc3CS0s5eRZe4TX90lJvu9nv4qiEyGC/5tT/NJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0SkxRsWcZAS6RBt7mMtmoWgN4TG7FqeEqoQSyh1xPrgxymx6SzkJlV59GQ1MkixdYYncM+8PV3o/dSI41lhodaU3LqaRNs++TMa+ERrgeGItw2qNtN5tolJeCOF3fEueWYm50hkeDX/3zhPshG9/z00GDA3bATVi2cADHOfLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LwiNaZiM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0c571f137so1230106566b.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751439416; x=1752044216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOe6l+hnnDWpgVQ5T2IRCQobbWufOXU+GDUIqrC5HMg=;
        b=LwiNaZiMzHhn2KFZckUaLewPH9CeLnf7H8fAHswS8PAbQMmmlA0U7tqphTWKEl8pjS
         WfdGVoOY68s95unSQSu/2R/YBnFUDRCoGFMRPTkwwlGCg/QQjkYf0RUVB8AacvX613IH
         D9zGCtEyYbcAckUxBV4sBLnQLVKmhZ8rbU8l3oV82GBktlnUOhvy9QWK6TYJJQyS8IoY
         Epg0SK1NTQCSB0DDphWVs7WR3DtiZWZQX10n000OGxyJTv/qFOERZCEpCu90f3dzQtQR
         RUzrr8xiYi54WuUv5e/jeVTWo3NKAyT2ERTyhsi9wb0jmac6kAifg+l3eY98o9bt0rJP
         3OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751439416; x=1752044216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOe6l+hnnDWpgVQ5T2IRCQobbWufOXU+GDUIqrC5HMg=;
        b=cH1jwA/YLosEa35xIlkWz4VT+tm0e56BZXemUXjTFwz79trvhhyMmPgsnLzh8Pd61U
         TZguW5mNKOUc6SO0cF6U81EBAHgVoGhAvMwV8VEP379WIGn8bMxf4bJHJ+Xl+5SaS1oZ
         DGD+v7rfhD64CfqEAm1URnbADTlSCnLnEr4RfvoHer5YgNYPbC+U73oT42w35HRvbjj1
         5g7QkBlH5Ldm+qhBbNBokzTvsdTN0m8R0lx7QheCnvvKAehgbjsElLO8hnGA22kcMuMN
         JzEqvr4agEEnJo67VrwnzW2OR8l6fMmNnP8C9illlSxp8QabM2PDF3tcDPg/RUx9yfne
         N8VA==
X-Forwarded-Encrypted: i=1; AJvYcCXF0gjoxtT1T0HQdKm5daLiR8U0KyiEZjWDSK6KrsbzF2rL7W7nBv8uByLc+VzIrKR4/7aUsunkndo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcz4V22X0Iea7CcN8vKef0yamjnKYxcVhX8AsMHDziiUwKx6N
	2WjcS1D0pNhXtrcnWE863270k4OQDvQWduXu9egC5E3WLhLctQ2PM8UVPZ+6yMfFyyc=
X-Gm-Gg: ASbGncuAsv876RffFktauB8IqVUwWQ4PXVFC2NXGOEXOeQVETmylWxRiW0j2GMwG9FY
	qqIWY3img7RgwyK2ab0C63qsCkylayVL4/ZNwmFS1FJVxNabLMpEdgYWkoXFkhmSfYaD96yvqiC
	BtNp6wHj3O6XfOZoNoR1PqevE2rpOa+rP0toYaxrQpKPhD6taQpJzh2Uj7heUntN/K0mgVW8gsW
	n4dKGgWUeVNR7toIngYrkw7mKsqm3+OTtxc75kcjEwPUrAxPe9FEP/Wk08ZxZoAT35rkxXtgUGT
	1foDhAu6ZVCgK49Yx38U9Qr9KXqT0WxS1yFd5PFa2YkNDXNzQNXQg7FOLR176zq2y1MmyiAnACm
	Zhl2SEa2JEuHcfe3JvY6Ec2oupCMH
X-Google-Smtp-Source: AGHT+IFoKsJw94/wzTydj11IzCh3YDjPAxZ2CqM2G/p7cByZKvSoN+eZ45qdXfS7kzmYtM3eR/AecA==
X-Received: by 2002:a17:907:944e:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-ae3c2c8b851mr173206666b.29.1751439416184;
        Tue, 01 Jul 2025 23:56:56 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353c01237sm1039763466b.98.2025.07.01.23.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:56:55 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:56:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: drop use of chip info array
Message-ID: <iqs5ktvnz7rkskwgnsdanhezfztdzckcr3e34afk5ece7ap7e6@my2rms6gcrkb>
References: <20250628-iio-const-data-5-v1-1-9e56c2f77979@baylibre.com>
 <20250629182531.6666f690@jic23-huawei>
 <pmqc36lr7filq6gu6bplg62qb4bx7cc7nx3ylsjuczv52cdlxr@2bdgzwobw3mv>
 <20250701183751.5701fb7e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfbpqpdlkxekel6h"
Content-Disposition: inline
In-Reply-To: <20250701183751.5701fb7e@jic23-huawei>


--vfbpqpdlkxekel6h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: drop use of chip info array
MIME-Version: 1.0

Hello Jonathan,

On Tue, Jul 01, 2025 at 06:37:51PM +0100, Jonathan Cameron wrote:
> On Mon, 30 Jun 2025 10:15:14 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > [...]
> > The patch looks fine for me. I remember having considered creating such
> > a patch, too.
> >=20
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Applied.  Thanks

Huh, I'm surprised. Did you address "Current title kind of sounds like
you stopped using any chip info at all!" while applying?

Best regards
Uwe

--vfbpqpdlkxekel6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhk2DMACgkQj4D7WH0S
/k6ldgf8D5R6jn04kD9601IWxrhm0/1ydI1jKkdQJVXQg0urrnxnfosugDc9C00b
w05kCnwGWQ6zTd9bRe1Hah8aG8amdMNqZM4e/GlzPniEz1Gyr4Fc4RmZkrfGCZH4
3z7bjTtN5fGFxYRm+eEbIn8fLE/Xlxsui2jQP4HhKCXKSaj7U86aCraYXN5P0pRe
nnSEFudaUUZPzsEJVLDCIG/iAW3Fqt+OmXTuRE0wtrQhgJ1vZcFsr1TO0+eIpNJe
Nmdc4cR2mHhhoo4xNl/xSCiI+iRkQSnYvzRcRmZHpJ6Uve/oYJ16THMsJbk1swKy
XmOtdaXQXVbqdEyuGDqBOT9SblXazg==
=jPAf
-----END PGP SIGNATURE-----

--vfbpqpdlkxekel6h--

