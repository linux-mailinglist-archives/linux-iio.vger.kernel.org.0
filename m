Return-Path: <linux-iio+bounces-7349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE7A928724
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19941C22B90
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040E1487E1;
	Fri,  5 Jul 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+BJXgsR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C7147C9A;
	Fri,  5 Jul 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176827; cv=none; b=XfY6GtL1cffLU5xaAljVZ1YDqPhHQ/pvOLVhJEN7PT7FM32AP3tPaXuisiMA6iFOxng6OdZzhCHBAmBbkT/VY9/1F7EGS2i786w6q402t23F9S3tLG/aZRScsKXpX0WbLzyrPDOQTwY4TYA56W4r9LcLfsVrS4yKB711p98M0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176827; c=relaxed/simple;
	bh=qKkyA/OEiarq3Cu5dnyZolNDKQ7uDzU+/xEe4OWVAHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iqWsRrg2Dsi9E0xuDIACFY/CAubVGBCvAsXMfBdpn31Yx52LoFjktGF5pIoKAcsAeb2JBji3KT/BrqAofW2vyVFJS3adzOd3RN4HaDOTlbvwr3SVt+Q1F4/wwJo7Pi35Haq1G3zjpod/msw42tIMFVTf505nbYCsXGR2O5Wr9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+BJXgsR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebe785b234so15885621fa.1;
        Fri, 05 Jul 2024 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176824; x=1720781624; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRAjEbKy41y922PAz0ZWcE1W0/5JX1SMyg6UmO5aenw=;
        b=k+BJXgsRs0hqzwiJ47vHJPWqGlLdZznGrYRVVtxiJe4VK44C2FCXY+ySAiPAZB6HUq
         uhwz0+SmWZNfW/RwsP/k28MpJJ/sUPOUPsqHt6I/VKefTefWmLNIupyylTLJzLMv5ax9
         sGhliCtNC55RWgTwvGtEBBuOWRUyqbY0u25uSQkrutDJqiUMTpgLt+21eil0Gq7LgSWr
         uATSvP8xVlkBxDzkGyG6RfMxoBA1eq1LkWNzc+ZCVhq4YLHQM70PN+/oPm+S2zMFhZKk
         MWYhvu7F6+1lqoeBPH07VF7YAExTeL+FZI6znXusrn1iZDZEsu8btKhUN8CmuUGKL7R2
         pdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176824; x=1720781624;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRAjEbKy41y922PAz0ZWcE1W0/5JX1SMyg6UmO5aenw=;
        b=PqFVEUUuNcYCIQ4G0/J6XJvMXXS5CrfaL+6A3Ysr9hhEoh8oWbmvBZbXZnPW/WNgE6
         d8o2CQZtDWF3KjlwQVMBgnDw2qTLlvWE/rHY5xv36wjsMlaVazrd9sCXShvQ3FwlqFUc
         2sdoG9HzmfhOGX7gIx33yxgx+1Ba4yAk3JpHwlhtVE3h6LR813Y5jl6pjZtLejdjhaxn
         2z1iu4bHCs47PMEkx/8w04d9EF+eGw45onAgrxvz68FObJFlDUV4Te7OIl45MEozkYFl
         9U6mW8XiQ6f4SRwYcMEfZq6w2j7ErGrV4+LyOuBBvN61VQER2g+ZRc+zGu7Qp+BgOCyU
         ro7A==
X-Forwarded-Encrypted: i=1; AJvYcCUUbdOW7KKN0YFJ4U1WPB1UdoyI+MVbfKg8tPSmTYdeGk1lHtiYVdVTcAahxh9WvOltHOpuUCIvfNqalmBpM67uDsLc5LsxQyUTkcH+A8fSsENX2tF+KFBT7wWm/9UGJoSiopH8P9qY3PIMfUxN6hEm2BCSqAojUztgCeUgZgq0/82esQ==
X-Gm-Message-State: AOJu0Yx54EaKRYqkqqbg4X8xA87qza71VELzjrITMKptNvIK9SV7bCJz
	RWDnKEl0V9JvFJhktL6wYfHs2tJmf6fJS4YrggFJJIHWykLVWYft
X-Google-Smtp-Source: AGHT+IG5pFX0JIHydFbn7F5mxXoV40dw5fYJcQcTUdqsM7K2J71rrBdal1dyjN8jzCdEAeAaud77tg==
X-Received: by 2002:a2e:7405:0:b0:2ec:18e5:e686 with SMTP id 38308e7fff4ca-2ee8edd3240mr27830661fa.33.1720176823243;
        Fri, 05 Jul 2024 03:53:43 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee855d0c99sm8161071fa.90.2024.07.05.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:53:42 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:53:35 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] ROHM BU27034NUC to ROHM BU27034ANUC
Message-ID: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ujrdyYBASYRGAsW"
Content-Disposition: inline


--1ujrdyYBASYRGAsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As discussed here:
https://lore.kernel.org/all/ff8d6d14-6b48-4347-8525-e05eeb9721ff@gmail.com/

The ROHM BU27034NUC was cancelled before it entered mass-production. A
replacement was developed and named to BU27034ANUC. (Note the added
'A' in the model name). The BU27034ANUC has several changes that make
the old BU27034NUC driver unusable with it. I was told the old BU27034NUC
should not be encountered anywhere.

Hence, this series converts the rohm-bu27034.c to support the new
BU27034ANUC instead of the obsoleted BU27034NUC. Additionally, the
series adds a read-only entry for the HARDWAREGAIN to help understanding
what part of the scale is contributed by the gain, and what by the
integration time. This is useful when figuring out why some transitions
=66rom one 'scale' to other are failing.

Revision history:
	v1 =3D> v2:
		- Split the one large patch to patches 3 - 6 for easier
		  review. (Please let me know if you wish me to squash
		  them to one).
		- Introduce new compatible for the BU27034ANUC and drop
		  the old one.
		- Add styling fixes as suggested by Jonathan
		- Fix the lux calculation coefficient selection logic
	link to v1:
		https://lore.kernel.org/all/cover.1718013518.git.mazziesaccount@gmail.com/

---

Matti Vaittinen (7):
  dt-bindings: iio: BU27034 =3D> BU27034ANUC
  dt-bindings: iio: rename bu27034 file
  bu27034: ROHM BU27034NUC to BU27034ANUC
  bu27034: ROHM BU27034NUC to BU27034ANUC drop data2
  bu27034: ROHM BU27034ANUC correct gains and times
  bu27034: ROHM BU27034ANUC correct lux calculation
  iio: bu27034: Add a read only HWARDWAREGAIN

 ...ohm,bu27034.yaml =3D> rohm,bu27034anuc.yaml} |  11 +-
 drivers/iio/light/rohm-bu27034.c              | 343 +++++-------------
 2 files changed, 89 insertions(+), 265 deletions(-)
 rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml =3D>=
 rohm,bu27034anuc.yaml} (66%)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
--=20
2.45.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--1ujrdyYBASYRGAsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0KoACgkQeFA3/03a
ocUnVQf/bvXCL868Vs3MaXAPXghCzM5LKfB8ZqJjbwtLrzJhnTDvB8b48dqDPdB9
g8XvVwpTnPPEjER1KLgpSTuwARGsdhylm21VYBDY8+7qv4X0ftzyIJw8CUnrjTqM
WwaUsK4LX/aLTvT9Dy7FNwpY2p9srtiVwFtUE0iG7VIAjLhQ1RW71ezrixHjCWlv
8DSowKVepUQ7/M5zC1yDDuVeTsFkymnCtmGcxxL++TZ2vQzKkIO/35u2njCEI5aj
pwydo546WvVkhK4tTIG9TcW9oxdCeEXFhZbkl7IvPH77CYkeYY/hFWt2dxclBe33
QvZ8SIcv94hp6vKNxz5D0wcbwg+y3w==
=2JSA
-----END PGP SIGNATURE-----

--1ujrdyYBASYRGAsW--

