Return-Path: <linux-iio+bounces-7351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED81928736
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BB228500C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83B149C61;
	Fri,  5 Jul 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLqLq9je"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EB149C42;
	Fri,  5 Jul 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176875; cv=none; b=seEXsBd/MnPHYPNkCe/9+KONNjXlHiOCK/PU6C2Gh1e3nmZ3ufqe3QXjGEyOqiTl53SycRP8xXxP5HBErO95zotNKhvATc4NZEuTarp9jMXwwUY38t4QSdJfieV6DWmyc54FbUp4ppJ2u7rxoyf4eCUKFKAVtcFviEKTRHtzz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176875; c=relaxed/simple;
	bh=tUZZJwqoiFgry5Esh8LOVnwmGazsXJkRNcHTuOKUs2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfWKTw64VLl43nVC3FBDj5Z0rUESma+9dGYjou7puuyTLd8Wr2Uo+561lKlnPrBGUAIAClUP60V9XosO8B+UODVYhipRbD79PCikO2ODKALoRMVEb9+tYLlJJct4gSI6iPC3OVPKTMxK19Hr5NWFWjrOk0NwuQr1nAmZlp1nbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLqLq9je; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9fe05354so2199351e87.1;
        Fri, 05 Jul 2024 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176872; x=1720781672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YudsF8797mlyxY0rIdrjntR7Tkfynp2mWG0TkyJfInQ=;
        b=OLqLq9jek55fAA+THV4sIFCp93vdXiUwRLWSOd0bGFsy7TAlGH0bs6NhhUE46sdGk2
         v9ZIaG0zNjwihLzudVh6SXsfbClLfJ6O4BcefWHDQG1UwXQHISBul8YxJr3ukTtj/nxB
         cikzhpYma1FZjqBEAlZUNEuzfjW9EyHQhWEPiLF0PkrvFDzR6qOKrjdTNhBA4Iun3FWe
         h/EW0lmMc4ioZqrDvi0eyrLPbOiYbkMv/afJGC2S7cEqQXUjrzO7iABf7w/p99+J7Q/z
         iujkBR6G4B6W1DJCaR0vEf6M79EIwR+SskXXDeEgkBEhRGnwAaW1Xq4BDTRVPP0HMG0p
         WDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176872; x=1720781672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YudsF8797mlyxY0rIdrjntR7Tkfynp2mWG0TkyJfInQ=;
        b=Cxb/zYpsbYBmFR7rhJsYYP5txdt4URnbmogAjmQqAfEAubNcZtDfs4IGhYR3LI4sBc
         T79PBGuyIxHXs7y1c7ujyJIIRYDUTHi8o1IiQ/R8V6yUieRdTl6yMwh7jRkFZ0EtqUiC
         Hupoih2VAPB5sHv937+1duYx/rL0FGowPGZYNjpJ9tO8d9/Zii27JyMo64x2UyWkGWQ2
         g0+wSlA8CT9oj6LhAD0ROe7O5SqplVyp7iyzmXv6+v6G6JZdehjQUZO+IWQSXi9M0ERA
         eExFdaZJBFIo41cdthcYrl2Hwidv+dCJ0f7nzNoLF8WAlkaPpolADA6+9JE15AogGnA6
         q+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFsk4mxW5zVfO4tP+1nnyQZWaBipnNFcYbC7+rP+0kmDhruwoOEULWsLYnyuYWXoiIWXQZHk5S8msn/XDGfcp24MUVVSGkV/iVd5qx3p1dqK78qWxfOsVOKLbfjpZCs3KsylsRXmeIRkQu5M5hnw7WtmjsJSa6EidRIHTPkmQF7CYJiQ==
X-Gm-Message-State: AOJu0YxKIOaD3b7u5kAi5Dz7Azqt77YxmRVReyv8fiMYlCjiMCOp6fIN
	WItqgpDcmBAN8HTvSHtIHRAUDSuepWzymj9LvHJracwzAb4w9eS0
X-Google-Smtp-Source: AGHT+IFlfAgJaF4n7y57yfhMcwdEk5STkTRSh6C1LpCiPYzBQfbV1MnrgINsP5aLjcI5rsAGqEghPA==
X-Received: by 2002:a05:6512:52a:b0:52c:d6a1:5734 with SMTP id 2adb3069b0e04-52ea0619f2amr2945354e87.14.1720176871795;
        Fri, 05 Jul 2024 03:54:31 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea4bd571bsm249300e87.39.2024.07.05.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:54:30 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:54:26 +0300
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
Subject: [PATCH v2 2/7] dt-bindings: iio: rename bu27034 file
Message-ID: <f83cf0d6f5b0ed391703ea3908ebd65b3f6e5c87.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SjqWJoTgI/vdNz2Z"
Content-Disposition: inline
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>


--SjqWJoTgI/vdNz2Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BU27034NUC was cancelled before it entered mass production. It was
replaced by a new variant BU27034ANUC (note, added 'A'). The new
variant gained a few significant changes, like removal of the 3.rd data
channel and dropping some of the gain settings. This means that, from
software point of view these ICs are incompatible. Lux calculation based
on the data from the sensors needs to be done differently, and on the
BU27034ANUC the channel 3 data is missing. Also, the gain setting
differencies matter.

The old sensor should not be out there so the compatible was dropped and
a new compatible was added for the bu27034anuc. Move the yaml file so
the file name matches the binding and change the $id.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v1 =3D> v2:
- New patch
---
 .../iio/light/{rohm,bu27034.yaml =3D> rohm,bu27034anuc.yaml}      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml =3D>=
 rohm,bu27034anuc.yaml} (92%)

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
rename to Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
index 535bd18348ac..fc3d826ed8ba 100644
--- a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
+$id: http://devicetree.org/schemas/iio/light/rohm,bu27034anuc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
 title: ROHM BU27034ANUC ambient light sensor
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

--SjqWJoTgI/vdNz2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0OIACgkQeFA3/03a
ocUf3wgAgZxuhOXcplU64iJcrNxsv9qdBeoFMeSnLrlwEGioN4d7hIC0SNsxUXR4
a5ieRVtkO3fAE4Ny0o6TAMHWU1wFwnTP2IUUEuL4PSCNgIYDGqw3UieCEyHrJbCE
AJMHoepr/ZIffp++woyc2j7ncEgIm0H2XvfZal5OV5YY8wadn91VLN9BeRR1PY0o
biRn/6VOhuQeyXtebG6NuhpOsKmsTuwfKWptpm/FkAcxi2hmDIPN/HILhUP84PhQ
W+7lJr97kf3ziLgfWuYuvYLvxyT76pPSP+1rezXAO8maseZSGNT6BlPRyEffTakD
xy17NAGK57FtDxq6cb8AzP6ahmIbTQ==
=vJIo
-----END PGP SIGNATURE-----

--SjqWJoTgI/vdNz2Z--

