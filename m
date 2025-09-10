Return-Path: <linux-iio+bounces-23932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2FEB51579
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 13:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E267BF188
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9B314B85;
	Wed, 10 Sep 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVK7Cqhj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5F31196C;
	Wed, 10 Sep 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503498; cv=none; b=AdAOYYMDITJOgB5oVRm2YeaghVDku7ZZJbvxTNdSav/AEZnnFjonrVXpslF261dHnyErdY70ySWyFd6hNziY/vs9yUSsGF/JZRqOJedUIt/EUkvJaG6qAegp9j5s2Ax0m7obZQsEvLZnxlg0PDzzlcYt/QhvuCvRHX9j8+/49GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503498; c=relaxed/simple;
	bh=zq7V+nrZQ2S/4HuoGCVc5PmsiPGh7HPzz75Wl1x3gLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPec9u2uAQ6jFTQy1T3UEWEItL5JAMKD095GjfTzo1eWmsuqAY9WWvzaGtvfGiEvOJX5bu3zTsgMQn6jHpnX3BX9HmeluPZJVltmkln50uPIBaSKaoLIEY2knA9IPEW056ECDfAVcgTPTcrW4ZptqpSEqOlrFYOMk18r0HL2OM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVK7Cqhj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6f434c96so6596597e87.2;
        Wed, 10 Sep 2025 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757503495; x=1758108295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3zdToe86hnctEgMf9tDB17r3wCkXqPbIRwRGrpOMK8=;
        b=YVK7Cqhjo/FmynAgtKvD+ohe1nl3DE3y6rUkGOAxLVtUo8d3MqwAPE6hZMILflnBF3
         sGB0ZWdr2jkYM7FizQB58R3AS3eMIE0H0N/UiTv/zd9lsV/JvPCtVP2wFNnbpx9pBFQy
         vBwyUu+bzPrRlLXovTDCJaNSx5FIvhMo772Budurhi5CcBUMQsC22nUi+qWhV0olHKpU
         uMAUefix0w0W5WKpa2alg8nH7iQxDsrJHXpwHv/KMHv2rMWCkddpUIltz9bLvXjujoli
         pplQ2wSj4bIevaYzuW8MdagXwKDdKqaKe+cTOLxESsgkuigakRo70GjAhs2pAJ93oZzb
         pjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503495; x=1758108295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3zdToe86hnctEgMf9tDB17r3wCkXqPbIRwRGrpOMK8=;
        b=rTZNGdazBMwBSxtjYPfKuzb/JK0RYWiAJZOIjqsx4txHm3t44Z3VljYatjq/VNr5CT
         Md+wmP43TiYPUdPuyD8AgTkpFhQEpN1dcezx+GaM8QapxPF+Sz6Cab8Agif+SdqEgR3y
         /ewshS+bxTY7brs/G7jrXp9nIvIB/6/EfOh214A0UIcprXAEmbkycfNNByqctPf/MFIM
         LKSSaaYHms8oVQJpdR1qFFZca4niq0KZ6/CPdVfcWzhZeRpcn7UXMx0fx6moHOo1kWsO
         PnjJ0ojsTj8QmdUVz5UdwSpUQDNjen8K+epX8W2cpwPI+M42VezXnyY3uzY5S0FiuGs/
         XYZg==
X-Forwarded-Encrypted: i=1; AJvYcCUF9m3gMAFqS5JPguBUjug24MnexagvZrCvAJTWkx+SUhro/zQVK2qwJs3YFFYt8DokCd5QVlTkR9U1dQ==@vger.kernel.org, AJvYcCVHPP8XWnTdA07wEJEyaA99xKFmF7Ibeg5We29miWPQoq2blTYhyqbie1oj/eyjKat9cHQnyrMJxR6GYqhm@vger.kernel.org, AJvYcCVqIdj6y/vrZVy1PyrGu/H/NYW/Bt0uy8FyDXb73TLPSJbzgOJjzm+5vJwQ4uJEes0Gv+Kyq/i4I/zB@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYuGi3kYCJGLJXOjYEPNlKpvHuVhqtda4JR78eF3v65+Jm7Pp
	CYHffO8LK+nq0NhqIsJuSVFM2Cg0vmZ7yY7QaZiKnFu4EKUFfKUusq4PxUXmxwhN
X-Gm-Gg: ASbGncua6Y1J2pyl41KC2sePmL6sOzEpZZ9jmCyDy559QLZFeR9emql6HOuYsnn6uXi
	TZygRPPEPMgouQi+Co+9MS/1p7aDxDc2aDP36ycLRys8pgBYVFSyxqV9HsX9+WgRyW6DTB01qQV
	tk9V2pUR0ux0jWHfY/BWIcu4XhTGZSzO619Iyclz2Ibr6AwrhFVPlK0mP/gu/DA6QUE3O0EAPbq
	AAXI2HRwiD0+RBRm/SnhXj0TRY2hdcgXo5AFg+L0oz7i/G02N9bogsDEwQiu/bNPvkpLxsEQllC
	+OsMFigKQcBnqs5xWnqMWz4MkcfJyyDK5ZYFWdX7G2FFxgQA4PaJnnfjxb+upqoKs/F8wxpCcTo
	mYx6tnHxTY4msmQpGr/OmS+6kUwItMrzoPSG68UL4
X-Google-Smtp-Source: AGHT+IGoimfA4HUKK6UJFhAh9sAz8Wg7yjyHBA2PL8ZVy+hKYkUKk2xBMCCC3qrfTctB2P73APJk6w==
X-Received: by 2002:a05:6512:2283:b0:55f:6831:6eed with SMTP id 2adb3069b0e04-562603a255fmr4590321e87.10.1757503494727;
        Wed, 10 Sep 2025 04:24:54 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568180679a6sm1204238e87.105.2025.09.10.04.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:24:53 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:24:50 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v4 3/3] MAINTAINERS: Support ROHM BD79112 ADC
Message-ID: <20250910-bd79112-v4-3-f82f43746a8c@gmail.com>
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6I5MuT6Q8fiJ/xQ"
Content-Disposition: inline
In-Reply-To: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=mazziesaccount@gmail.com; h=from:subject:message-id;
 bh=rWC+YvC4JADy5afIx4GhMrizCQAlp5Zfa8zbihvqrIk=;
 b=owEBbQGS/pANAwAKAXhQN/9N2qHFAcsmYgBowV8J0/B6xnHdclG86vvc++VSQXLzvzfTXu7qb
 TRcFl4wBIyJATMEAAEKAB0WIQQjH5/zBlvbx8soSFN4UDf/TdqhxQUCaMFfCQAKCRB4UDf/Tdqh
 xamWB/4v6vvCzQwmauU97d4lIvSpmOpmbrZUP24Bwd7x5lx3uKHZjei3+1Kezl3lsFR3Kz9ekWj
 DX4i2tCc+xqzNZt142XCYtfoLmmQ63ogDPyUQEZ5mUh83F+p+55km3oLvJH1MeBDHqAjIc03EW1
 bR81BJxiackUbyK/7R2Il+p4xEN7h/5JegXee7LdAvKX9NURED/t2gsEZYhn1KkK7EAQE8xnH/U
 6F8Txw/NUNtw3KvQTSgbHm4g9G2TOLtMZCSvTnaBvPyzScHF0ptJJ7qH3r2zoYYOJ6iFsyDC8j5
 ghNDGHCWQsMZa/Dcz+84iX16zCm9KvBRZtVUQ2/5xuP+bHX3
X-Developer-Key: i=mazziesaccount@gmail.com; a=openpgp;
 fpr=83351EE69759B11AF0A3107B40497F0C4693EF47


--d6I5MuT6Q8fiJ/xQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD79112 ADC in the list of the BD791xx ADC drivers
which are maintained by undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> :
 - no changes
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af1c8d2bfb3deb870d8df44b8bae22e7cffb5aca..8e78a1168c17d8c2c7056e99e19=
1d542ef0b95a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21864,9 +21864,10 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
-ROHM BD79124 ADC / GPO IC
+ROHM BD791xx ADC / GPO IC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
+F:	drivers/iio/adc/rohm-bd79112.c
 F:	drivers/iio/adc/rohm-bd79124.c
=20
 ROHM BH1745 COLOUR SENSOR

--=20
2.51.0


--d6I5MuT6Q8fiJ/xQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjBYAIACgkQeFA3/03a
ocWRJwf/dHny4VHf6/1fwuzIasj0XaOJwWhRF0uoMvyJo6BVz26jwwN4+EGC9yuy
KJBol1BF97FPQXrSNk72k3GhpCTIEGXq/iEPVZIxlAJC/1vMcL4Gq9vUIuyw3cm9
AwQ4WCtg1Pb2r3EL//lHR1iSF0abb9UEwP6SDhmh3NMr22cBp6KHk0RaqjYhu62u
GES7uo/MAqBVcyQvUcy9gQYk/mdgkcYaVfzDWiycgiOTvWxxqxCInHpLrj18b+it
dXC8kbmj2tczQv7U8HgH1gVZFOHn3D6NZbjJUPGLhdpGDkHl/Usxq8JdqSf8QLcB
VHA6vijQmBNOE0xT8s+LawPZWnZ5GA==
=62NS
-----END PGP SIGNATURE-----

--d6I5MuT6Q8fiJ/xQ--

