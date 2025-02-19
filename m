Return-Path: <linux-iio+bounces-15785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1853DA3BE40
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42E83B03F2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224BF1E0E11;
	Wed, 19 Feb 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDTxzSnG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D71DF26A;
	Wed, 19 Feb 2025 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968337; cv=none; b=o82CuosiJqTI+Z/Vxnt/Fo3B6WMTTOyPnKGIWo5UFChbOfVQKUxJ04S2dC6Y4uaP4INXw0FvAJ8AmOajfaKSGaALM4ukqvepGjsA4RJKgD1c42COQV1hLjixAUALdkU2VkZbfxb7VIpEgrygZkQMI2lgaYajDmwzD3KHaWIGqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968337; c=relaxed/simple;
	bh=IBbz+wObyAhqTzMziGPirWIFuoReTJvh68cD9yxqDCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxDYu+iaQWfZtHawTB+yHuhzxTUf+0pfVfHw7kbhRNtnhf8bkRMvbSY2lvFrM2h1dwbGapDZekVTHRyhaCozrf62X0R4pHK88FFBYkMFEko524Vh3zd3shMjAv/EYmLgf7kAprn789D9eH55J5a0+NJdSGtsj9ecYWbVKFCrHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDTxzSnG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54622940ef7so3351812e87.3;
        Wed, 19 Feb 2025 04:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968333; x=1740573133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=872sDDSaszSL1+yhyVainkn552F70TCEUEKtazE+wZs=;
        b=CDTxzSnGy23+3naIwWYEaxwQFE1u/TNZ3nVIN+chfbtMwKQaSwonP3tmnFGO0gLlJN
         A+a7U80U3CNibHCY7vFy6K11xhKklkgTcv4wjiJed6twmrM2xNbd2o14i5A1tAjuW0lU
         cTRrGEsJAPKbaWXbhcg/5qm/f4aN9sLYWgWw5do31V1S1o279qQX2aYVlHyRNCDX0Xxb
         J/ZMYRDkXnuw1AHNFovHRF9khAGpLMlRY2udxNtWQVvVzHmFqNcr0ZjdQIEB8udQEL5u
         rF1ZWuNuMEIJoExfvHfJsmKhoIKggBZ6/jwOTCKTuXvCtv63KEz+tya3ruMrAVAJGz2B
         1O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968333; x=1740573133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=872sDDSaszSL1+yhyVainkn552F70TCEUEKtazE+wZs=;
        b=qXuEdPPCfOy6T+nYhYOX4Jid0ef2BvtU1jFUvAuKCSLfw1OECaoSLHVKCOGOk1Cygq
         St0NnbdF0sdGZq3NG77RVjRpykekYn0WG6yJIQbwXIYCp3jh/i0ej7eiYe2EStOe1B2c
         SfAdr6z/J8Sux/zdJC0icyIR3RiATroE3P4nxv02rhIbbUJ9KVD30KuuQKUE3JNXTPCn
         nismSX4N48XZ5eM3jVU8XkWBi8+pH0qZ4C9X2KE5EcTMBQx23NOVxrZAv3u9swjW0pR1
         gpOeIqpS3mwngXtDcu13urPLSfupdkb9Ewrnw1RFwtn6yjo9FxYciq6/uTeN27OursXl
         9O4A==
X-Forwarded-Encrypted: i=1; AJvYcCVeYSslkE/YfGP2yopsqMKHeP+A+p5rTLYpXwG0ExA3S2sNTKKKKyM3gKKwUthaWtL3dSPkLgCwF3dN1xOKe/niXzI=@vger.kernel.org, AJvYcCWW317SxU/JOakvWcyNKTGYfRtEuEhkFvYNs0SjPnAFGmOre+08LlF0h6kBFmIGLb/SAD5GJW3BSlZn@vger.kernel.org, AJvYcCX6bA9cUt4siduePMTBNflhaz0hhWn7+juCJdLCp+au0P/cBNc77r3zLkJRdIuFcGLcSF2/31ghsIhR@vger.kernel.org, AJvYcCXdT3QBlC57XSgCDRlOmRyMEUYBOg58T8Fld6grfwZ9+kOxlcPoDCQ608pTazK9i9MsD6XjPwSvX62Ss8rJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Z9LR52SugG9bd0/0n85dB/N2KViui/UgV8MTf3SFHoJ9dHO1
	ngjWKwaUkVeZ7WL7qyoPKVLN3LJqZ+5lH1gIcsm1GJetbQKxEKMY
X-Gm-Gg: ASbGncvECr9KO0FdwtefXKi/CMasV++SPxEiNsplmXi2Xse/gwXRRkLHGmGLUDGucXq
	0d5jX5h/55K06x2f5MOZQO0gCfWYPnb/XIbl4eX9Uyr9O7jVa39Rw/rqdU2VrUuBnG3SMrVO2Av
	UsTfKKtzr+pfizGJsNmK9uFzm/qIYS6pcRnDiUkVYq5DEboaLxc5IgDZ0aagyaGKuq6UleeY8S3
	2OHdfGAR98blluWwxvkSQbx457TSv3KNv4xkd4hp4kE0gaLOJ0C9xXcHGoMztPgpRhXRPWCRjDV
	19Gl+dWoUfDnu8TMIXT6NQ==
X-Google-Smtp-Source: AGHT+IET+JJuBMU3Y/6jzse1ZgT54+aygXA9AXNLRXFpXqkVIx7/7mkYzYqgDRV3tj+3kjGQpH/r/A==
X-Received: by 2002:a05:6512:2249:b0:545:c08:e17b with SMTP id 2adb3069b0e04-5462eef2242mr1448277e87.23.1739968332998;
        Wed, 19 Feb 2025 04:32:12 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452f6efbf5sm1596646e87.18.2025.02.19.04.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:32:11 -0800 (PST)
Date: Wed, 19 Feb 2025 14:32:06 +0200
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
Subject: [PATCH v3 8/9] iio: adc: ti-ads7924 Drop unnecessary function
 parameters
Message-ID: <3155f491753944d6511d058a09f6f6c505d551f9.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LHcdoEmAz0cVNgKv"
Content-Disposition: inline
In-Reply-To: <cover.1739967040.git.mazziesaccount@gmail.com>


--LHcdoEmAz0cVNgKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Device pointer is the only variable which is used by the
ads7924_get_channels_config() and which is declared outside this
function. Still, the function gets the iio_device and i2c_client as
parameters. The sole caller of this function (probe) already has the
device pointer which it can directly pass to the function.

Simplify code by passing the device pointer directly as a parameter
instead of digging it from the iio_device's private data.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
This commit is compile-tested only! All further testing is appreciated.
---
 drivers/iio/adc/ti-ads7924.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index 66b54c0d75aa..b1f745f75dbe 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -251,11 +251,8 @@ static const struct iio_info ads7924_info =3D {
 	.read_raw =3D ads7924_read_raw,
 };
=20
-static int ads7924_get_channels_config(struct i2c_client *client,
-				       struct iio_dev *indio_dev)
+static int ads7924_get_channels_config(struct device *dev)
 {
-	struct ads7924_data *priv =3D iio_priv(indio_dev);
-	struct device *dev =3D priv->dev;
 	struct fwnode_handle *node;
 	int num_channels =3D 0;
=20
@@ -380,7 +377,7 @@ static int ads7924_probe(struct i2c_client *client)
 	indio_dev->num_channels =3D ARRAY_SIZE(ads7924_channels);
 	indio_dev->info =3D &ads7924_info;
=20
-	ret =3D ads7924_get_channels_config(client, indio_dev);
+	ret =3D ads7924_get_channels_config(dev);
 	if (ret < 0)
 		return dev_err_probe(dev, ret,
 				     "failed to get channels configuration\n");
--=20
2.48.1


--LHcdoEmAz0cVNgKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1z0YACgkQeFA3/03a
ocUemwf9HQbiR77d1KNj4kGgWfMEpDY2y5qIlebPXJe94y1jkU+LPoFK/3yoptzd
1zmwZZHfvEO8pbuI5ZEkCVEtMIm8oD5KrC63b2fO3tB9AbXnHv/PIa7bGXmp4GRA
8qgD9c6WVzM0+j2WwUFzFq72g76QBdy+Ge46vYTR3FBmL4sNzrXOBlMYZ2SH/XcA
xbiF+7BSaInu5Xjlyg3hte9M1kZ99s+LzUDgNbE0Jv73W2vzK0bxqPbVZ+Jv/H30
hQ0EnHDjiZp1Jxmtcq6tkD4lzqD1OkLpToE3swDtstzlGyp5SXtx2npiiOKIebCO
XtHxNfk7lMQqw8ZSQdOZ/dCKUPnxWw==
=p/2t
-----END PGP SIGNATURE-----

--LHcdoEmAz0cVNgKv--

