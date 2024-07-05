Return-Path: <linux-iio+bounces-7352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F188D92873A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC641F26561
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FB149DE2;
	Fri,  5 Jul 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBYUILDz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF1148FEE;
	Fri,  5 Jul 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176896; cv=none; b=TNoofjCmkjbDRcuZt/0aBG2YPspKRXp7m4VE7a4OtmUV/fqk7I0Wkrps0GKAfKJvcEPGONDU6c6/pheBDhEM4dHEBkzd3+4fwcxUoiAwnzrB68y7Ir6VYMqoZydcDwAo2moJqjWJ4563szMcoSs0VRcXRqp+JFl7SXpIXlLDvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176896; c=relaxed/simple;
	bh=B6zA9xaRR+yus+M/2QT3KHrJr2/GrdzB64cxur5Apes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRUajdJ+b77zlZ+J5UQKB0lbwhHGJEQIXDlcSC5PMtmq9HN6qZzJnLmDn9aXdt+Om7PswHVtzSHsKjgOWMznI56VgOK0LnP1tbCyKdiQm76JTICd5QW0M2SYN6MjV84MPbj6b0M4wc6bjlEn/JOVmes34CX5eGqjJsRBGY1z8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBYUILDz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e829086f3so1616331e87.3;
        Fri, 05 Jul 2024 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176893; x=1720781693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=liXtfBQ59HSNcmRKVJya0/oz8H1ltZnF6eEI6Ipav1Y=;
        b=WBYUILDzTmtnz//E7w5iO0V8T2pza5GU6wEjMxlFywVE4M4OcOI1A096qRmOFmzb4z
         Fw1FkULihIPQxPQDaqEZP5yMdVE0+iwNflZQgHDhvffjqAvEWo2hIT6qsj08FFdZvnz7
         V5xaYCXIxhzmDTrvGXdRJmWRgmNWLtJEkBlV2c/q7R0cfVBpCDg/KSHZaId+4sHMvtuF
         WYDZ007QEAPDBQo9LEduXR6f7Tbp/SYT0MyR26Wulfe31xT/OvsLB/vN3EthvRAf20fC
         dNdLHbme5mECZRZPj7RBaRAc0d+M+wTMVV3iyTf8ssTSOt5NpiKsGFNPLX4105vb7IcH
         /kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176893; x=1720781693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liXtfBQ59HSNcmRKVJya0/oz8H1ltZnF6eEI6Ipav1Y=;
        b=cT3mqEU6HuNlahz/Gdq0T9cyYEGjFJSRg0mPP0Q4dQ3zgrQ17wl/6jysTxU8KSATOO
         wLK1VPjtYWBw3vCGThWTDuSsefFujcOCLJ0Qrig/GtLX6ZSSeShIyk7WVXMpSaXtoOHU
         1Pq2gyX+CNIoWHgLwIt5HLdxnLtDVo8fzv+ZKNDx3j6GfHgPhdfZTySF/Yys4nxCQWJ7
         czUtuavhaWvRRNuS2nS95ZgZkbKsYoa/4QFlJahpQ6UvQOkunaCmd5bdGXpbRceKE1YL
         TbWqldM6XXafFWpO7OIgeLOrJ/0Cj1K2W7n6YivnjpFafWl8e7siTRmCY/aaf0cPfzue
         yXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbEAxoEipBDebidGXP4U1mSsNe8a9/kSQTrOC/zJOmDxrBpiMRdyd0QstPvio9ldOPx/sYNJnIJLagrY9hPzXAwKGP3Mfv3Qox1RM7g8Mh6LH2lEH7JQilBd4ltkVf3AuNU639E5ONwI4RXa4e+o2MCT+VCOKqtxmVUKUdyAsQNNHNwA==
X-Gm-Message-State: AOJu0YzIuXgMMCouK9s8Ofzwzz2cTxZ07re2hOGDTwrOK422KuzBJBgz
	6pJPZP1zPRQKQdxs6E+E5FrrYkLXUD8p5b7ABCrTe0922eTMaKN3zhDz3g==
X-Google-Smtp-Source: AGHT+IHRv4oZcpCirCT7C8Be0J+Fy9n8wVOWTYNFmxXs1v9j7H3rtDO1QE8OeI7NfPl0pDC05bRs/Q==
X-Received: by 2002:a19:9106:0:b0:52c:8024:1db with SMTP id 2adb3069b0e04-52ea06d307fmr2789397e87.63.1720176892473;
        Fri, 05 Jul 2024 03:54:52 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e9ff9f201sm494834e87.27.2024.07.05.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:54:51 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:54:47 +0300
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
Subject: [PATCH v2 3/7] bu27034: ROHM BU27034NUC to BU27034ANUC
Message-ID: <ed8b963b0cd3a84c06a494c79969a136d5abcf92.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1aSZBAn0WnMHHwaM"
Content-Disposition: inline
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>


--1aSZBAn0WnMHHwaM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27034NUC was cancelled and BU27034ANUC is replacing this
sensor. These senors aren't compatible from the software point of view.

According to ROHM, the BU27034NUC was never mass-produced. Hence dropping
the BU27034NUC support and using this driver to support BU27034ANUC
should not be a problem to users. We however need to ensure than people
who use old kernel with the old BU27034NUC driver don't get the old
driver probed for the new sensor.

Prepare to use the BU27034NUC driver to support the new BU27034ANUC and
change the compatible to prevent probing the old driver with the new
sensor.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/light/rohm-bu27034.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index bf3de853a811..f876bb21ffa5 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * BU27034 ROHM Ambient Light Sensor
+ * BU27034ANUC ROHM Ambient Light Sensor
  *
  * Copyright (c) 2023, ROHM Semiconductor.
- * https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/b=
u27034nuc-e.pdf
  */
=20
 #include <linux/bitfield.h>
@@ -1507,7 +1506,7 @@ static int bu27034_probe(struct i2c_client *i2c)
 }
=20
 static const struct of_device_id bu27034_of_match[] =3D {
-	{ .compatible =3D "rohm,bu27034" },
+	{ .compatible =3D "rohm,bu27034anuc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bu27034_of_match);
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

--1aSZBAn0WnMHHwaM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0PcACgkQeFA3/03a
ocVGuAf+MAUFsaRwmZ1zr2JIeU8iQc93/vi0mjcEP4QJlryIhW0DJhIFWdyTjv5E
0843I3DXvVguLBsAwzd1ekkm0EWiHLEPQ7kLBYK4nDsznuTxcWqPV0vJW4f5lp7n
WPyfP6SnNVL+rTJQIj+iM0YOmmWmyv2qhH3QZ9Mp6+JlnhZz6sqgDR7/TzdO6QKz
32UqfMNOw79u9n+z7ByDhfgONUQwokKpjFP1EYI4IzhSuFk+Le6iauTC/h1WaFDw
T0ldM2KqREM8wfzS5Lntq5S0vGEFOMcDkFKm9JrKy9LEIoEz7NFO++0rOzt/RKO3
v3fe1+nTiiPeOO+V151HQRmJvDsRBQ==
=A706
-----END PGP SIGNATURE-----

--1aSZBAn0WnMHHwaM--

