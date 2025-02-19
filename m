Return-Path: <linux-iio+bounces-15782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB1A3BE3C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4F13A843A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA6F1E0DE6;
	Wed, 19 Feb 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9BnB0TC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272951E0DD0;
	Wed, 19 Feb 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968289; cv=none; b=ofGKkgZwA+XN5hhvNkjnHQZTE9pxqlTrJCED+DprbxX2w610m/sPzYHLabkvdTNkBkJuOab6URWZGEDhml2tqyhn2LA+ze1LaNhZAweQ00aRrs8iz9FqFvhyMyM5Mg/fvY9mb15MES1BNTavgsx3mL5Z7C5bADlQE9vr7fJ66tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968289; c=relaxed/simple;
	bh=l4lUpmHuMR9617shjfZBPRDF5NOsdDEGA4OIBTz+Rhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvRpAI3AIcXP4Schep2KcZfBspTxZVhg6lewub6SvrUOr135qMeY6cPY4l6OHqpPZe/4eRQ4wdUTqmLmT0CoB/7ixtny79DrkEZRaTiunp/Zk5aqYHI/OzhZf74r/36rETcVM5AgbmxeEl+jacTxF2xwS5q0QIc/OwziiW5YEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9BnB0TC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54622940ef7so3351003e87.3;
        Wed, 19 Feb 2025 04:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968286; x=1740573086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9YlWf0udibHi5PYSeWM2mVi7/K2aWeL2dI07eP9SBw=;
        b=D9BnB0TCYLwTXndY1dbL5XdnSbtdKVnnWp5MRlikSQNtr9F02Tnmg0ccpsIKoHVJki
         Kl/wh5MHZoI9EWtG/73oTWARGRxxLdGKvHlGeJ6fG4uNZbSLsI/4x16YbE0+wmK85txa
         IT66WRbHbuchwBxxSVb72gzO1fDJFLWY1Qp5wMeL5oYNVCy80Jm8f/kRrtztuUrFIVgd
         NWXXcoTjwfR8TKP+0xKtKJKKAyHZWdQ3wntqQP3QQswdbiKEjKT/z8EyXnqGeWh3I5wI
         dT5pAXmLgq6dZKZxjhEK/xFQWy6UZPjP7+ULskSgbk/r3aH1V3bVkx2kOWFWGGmPf499
         jrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968286; x=1740573086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9YlWf0udibHi5PYSeWM2mVi7/K2aWeL2dI07eP9SBw=;
        b=sI5IFEpvO60jtTe7XoGMZSFssCeQvAgwAOqJdJmycpPlfb6eNBaghW4YfBoevtowvw
         BScm7TBzWlOOdxr23QCP2ZTRcAqfu3S4cmsAmjXDS0BMUjPpoE2YS9EpBok59Keri0oF
         SQNen1zgj0uY5Lo/7DfUJ6UVs9+0bpCu7jl1jcckooi7B4m+zvI1PWF3Yz2KShF28ecW
         mNZwgUrAF1YHPNBJQFEwX6UM1tisYlzSOUy5zfrrU4l9GzPlIa/z2W1RbY6J6oARFZX5
         S34wyGbXk4MMWa527pZB/UijXxegBlYCI/KGhBIt8rynrIk95h02ND2nUUy6FD3PkMvz
         fvww==
X-Forwarded-Encrypted: i=1; AJvYcCU2mMwnbC7l4QBW5cf55xx69m4m4N7BCDhWzcZkNDjn7MNsOyHywxE3422ZvWl0a8gNCQ+udcz0AIxM@vger.kernel.org, AJvYcCU5CtvcT3jCzFE4HQL/UPJMvd9HUUT5IBGh5T+J5iIy7CrRLNCoxNuyPBPlSoK0K7dgw6PHifMvxeV9zaR5S0y/ryU=@vger.kernel.org, AJvYcCUG9M2ith40fSVEZ0btexDkoh5fVSDaGr5I3oTHROXM+xbBuHVHpHEc8Tpja9CtMonqL5gTX1zIRUU6@vger.kernel.org, AJvYcCVyDvNH2VecR2wvDfBKB8RL2axyKPyLyOTZ7Z+U33yiBSIdgWj42RLbkUkeolNnfgRXYUfzMrFc8+z/f6KZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUinekAwe+r1z87B+U7XK4qWKqLnfl+EVo53ZaiWxJbD3Xxhw3
	O8Uv1JmCbA+DBbrUEZPiPMkhN0H3JRFlQBPffg9nq6/PM6NWXgqK
X-Gm-Gg: ASbGncvKItGOEBr2J0ZJ7xfZgGuSoV6nKV0d5157wdRoQLrAwC0Zv7lMU4AlCvpFLCg
	d9RyLq/jpxWJ0w7UtzuirQLuzWPCbGjSRziFt+rFartbp7ffWb63bANwX45vfnhFkW5nkKiHgI/
	UEi3N/plu/hpNyqaQGAGzG6sr7ikuyfoV8K1nPmzZIUKBt8vFhFzmWO9gEQ22wiR4eIzKantY+5
	JK+CkZX6FOyCgIBgAbDazftKZ8vrGQEztAdsdei0TLBh9wkuuDBC9ZnchQoe5IOPW2fAD6WOjre
	VPbvV+p736ohHsvNZLnuDw==
X-Google-Smtp-Source: AGHT+IECGLbBg8/Gfg56YN71xZxnO3b9XbM0HqSAvG6g7x6DJxq2h38ifv+YIKS+tWOSHyQD921kRg==
X-Received: by 2002:a05:6512:131a:b0:545:cc2:accd with SMTP id 2adb3069b0e04-5462eee4789mr1463016e87.20.1739968285827;
        Wed, 19 Feb 2025 04:31:25 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f08332bsm2121536e87.48.2025.02.19.04.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:31:24 -0800 (PST)
Date: Wed, 19 Feb 2025 14:31:20 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v3 5/9] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <33dd64a9f43ded7809e9d96de81c975cf9d68a5c.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cgogUbgcoimvAkuI"
Content-Disposition: inline
In-Reply-To: <cover.1739967040.git.mazziesaccount@gmail.com>


--cgogUbgcoimvAkuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
RFC v1 =3D> v2:
 - Drop MFD and pinmux drivers
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfe2f53fa74d..2021327e665e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20299,6 +20299,11 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
+ROHM BD79124 ADC / GPO IC
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/adc/rohm-bd79124.c
+
 ROHM BH1745 COLOUR SENSOR
 M:	Mudit Sharma <muditsharma.info@gmail.com>
 L:	linux-iio@vger.kernel.org
--=20
2.48.1


--cgogUbgcoimvAkuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1zxgACgkQeFA3/03a
ocULuAgAjZavIzHTPjKXGVeBG0YHgO77wmABK9DsiC/qVjVCqjKymrPlKSOoz6De
5KuSLf6blVfl4g3VNLi+25yKc4rOctFr5iyTV5pWFzIhidkV55fw3PMIYnYL/foR
+iRaRpl8okONUYuxsiSQLZe2IRTrforggRQXW5JGu+PLTzlEgcZ4Gw5t1bDijmFC
3jNohUynNb8Iw/5w2Hnj0mqL+Z18jb1hZoJF9M2Ns/mPwQonGf0yi6Q+4kNzp86y
YE4yqyf/e+fzMC7Q7hUzGvRonL2iulD5a5D7XR630YImkpeMwLEM0DZGqYAO7qTT
252ljGVsQsIiefcFr0UagxfopFPVuQ==
=V7e1
-----END PGP SIGNATURE-----

--cgogUbgcoimvAkuI--

