Return-Path: <linux-iio+bounces-17145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DACA6A146
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DA78A7BA0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033F21CC58;
	Thu, 20 Mar 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLdw0f4b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ADE1F03F2;
	Thu, 20 Mar 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458961; cv=none; b=l++ekHPNvFeMwYRE8ug69lwzk7N+AtaTm+MiIv5eVuzJr9vWgYGjVLnQkQuskaX2h+A1LfNA/A18QPXrS2hk9gpZvs+qa0H7qFLk4I421y6nzA8XcXY5D/CU8RmKAsMcvsMNui6d2P474DILhRW9is0n4NiofzaVIwyjD7y+Xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458961; c=relaxed/simple;
	bh=rfrGCEwRtZ0PL/qA4K2Cp6Uvn1b+ahhEYwkEeGG7VTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMhyWB9wxllzXD9Uj43G+lffmXdbRCxsRIeKNBJ+kKJNfYZpP5nA4GAhDXJv6xscB4n0WwwZ2meaHinmrPzVI0Sqyr8V1RU7ujA3BcYZhKno9Y2mn5jjWMtVZWRS1NRG35HaXK/8pFUBDsW5LTpBd5oPvdXATMaoGXreJFXL0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLdw0f4b; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bee278c2aso18188431fa.0;
        Thu, 20 Mar 2025 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458957; x=1743063757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OoU0n4R4D1F2R5x/ShDbsQnHtEUfbe2asAvBV8tcGg=;
        b=LLdw0f4b87mIauC5FlWQmr1NgVcsk9OBfUKgDH1h+KuDEhqe+Nig4fU6DqsFCtk1Uu
         y/it+1VmdT+AIocW6X0pQexEoEkMRt6b1Dxa6lJHAGtPw1hL3kBoLMKKm2Xb+Lx7NJ+I
         cLxM4HUun9DO+pztfPsI4J5lF60U5PVZ7e3zSjLFeRShny/27E0lGd0/1+iIQwWlQkAi
         jGA7t+uwxYb5TzW5TZMbhJ8BaGdheJgP10XWzIobFWkDE8lNHkxpCrfSES2OwFd+w/LH
         Sg6Maj0GEwfglQ980ub2MsKH3n6JHNulgcdYSLWHZnnhU74QdUC9E93ddrS1SkJRZzA9
         hjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458957; x=1743063757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OoU0n4R4D1F2R5x/ShDbsQnHtEUfbe2asAvBV8tcGg=;
        b=FFZhcji9uVDThbM+FAIqNdUdnEz2zHh/QqpBFhnyfTJZ1WAk6lC2On88BAFvm5+3b1
         bfFarxu6Bh6mdC7RDyD0I07VqnqwJEg2Gxg3sRArD70EWPhc2Px4B2eYpf5mzoEa6iH6
         Br+skExoGe8zGlAfssGORmM6WZgt8htbm5mvIio71NhSnLa5sD1PLcvb+6L/iUOEiBH6
         YRC+rIMX5WRcNirvG66Du7k78taTC4x2JrFVIO+20o0n88ZXDILbBMewZakjnD1h9IyH
         6q3T+v+phmwYgbpeyd9JapEOt40DN/Ge/eXquS8lNWqAJVVzqCOVEGpMnEsyNTa91x/5
         ljrw==
X-Forwarded-Encrypted: i=1; AJvYcCVCkFAPgU09T429h14rbCzfJ7An0ywDKn/S+ss/8dlqgCJXnYJWQfaHdYF1mtB2QwEOueXZQL/1fPDdB7ru@vger.kernel.org, AJvYcCWn0kdJEGne9vd3JtM+GOCS+3UAGEDP4sNOxmoqnMiCek4F/PtTrlHS4JSwyD+YXMuPWMysGIXJS84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjz1/tNcVyHVa2SQUE2VM/cq6kYlUfZXD7pgkvr3seZgVMKob
	hYWWwNvTCLO8PM3rAJgNP0hO2Hu9VZaZb/l7evtla+uMZndYUH5K
X-Gm-Gg: ASbGnctFS9CIaz5bpo7+9mXQ2SP30RYwTDLm1w+D0SXqRzXL/BpBozberHEagA/jwt8
	3TjGBUQjTlQxAfOcl/xSr2TroJDHiYYrlJx68thqcJmDBZfy6H1YlYFdojIVnj94nNcix4Z3+U+
	X90KfhuelCAfVPfBIzRXK0FVerlIKnI3AIuF2/wmq1RZo3MijpRZDir1tB/YOpvB1fCnJ+nuXi6
	Iqm8OzgXhm2zwH8x685PpxC4TAwMQeLxYtrWpzCw6+iJ2e5iPLNPPomXUM6vsl5lBSakqvj2xp6
	YvUJj+vx4Rk6VdZ7dHsAd0cOYkW205PCGRWN7IhlLAOepvWsFMw=
X-Google-Smtp-Source: AGHT+IH3fm8FNBWiUkBfnf6bu7MhKV8fJRkd/25D65njkHt0LY1jHS+01UXwYXkyujpdyMeJnxtVOA==
X-Received: by 2002:a05:6512:6cf:b0:549:68a7:177c with SMTP id 2adb3069b0e04-54acfa85f7cmr829383e87.7.1742458957073;
        Thu, 20 Mar 2025 01:22:37 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8373sm2208194e87.22.2025.03.20.01.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:22:36 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:22:32 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v9 8/8] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <77876e237f4018204282da93b791765e48f75859.1742457420.git.mazziesaccount@gmail.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dq5n2oyD23PDV3jL"
Content-Disposition: inline
In-Reply-To: <cover.1742457420.git.mazziesaccount@gmail.com>


--Dq5n2oyD23PDV3jL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D>
 - No changes
RFC v1 =3D> v2:
 - Drop MFD and pinmux drivers
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b96fb864227..2e4416b59930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20547,6 +20547,11 @@ S:	Supported
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


--Dq5n2oyD23PDV3jL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfb0EgACgkQeFA3/03a
ocUeRwgAzJUU8j+bjeTXYGaTngfwjF7zAcumZBQ4d1YBYT4dEfmDI8Y49orVH1hA
Ttx/WeB8lsPCKJpIZOJF8A6aSInSf8X0nSBUz7cALxqgtTEs/dpMFx0nqOiCgBrr
iW7sKz8nQDz4EYNfGzEIXyNBYdwVOGc9XpYuUdvf8c2Q3Tq0zE5BX73POJhgOBLG
BbiCKUAaNDDTskLGxTMNsDOJjIoT4RuqDcjm4bL6iJeprKO2XXhElqhYGvqPP6in
qJctYZXl0J2L6bULNuHdsooBm5EDHpkgHJmXRMsCPpFpCkDNWZGRl5fIi9QxIwAW
Mc3kxl0NTXrAww4mnnUpKStbxoYEFg==
=aDn1
-----END PGP SIGNATURE-----

--Dq5n2oyD23PDV3jL--

