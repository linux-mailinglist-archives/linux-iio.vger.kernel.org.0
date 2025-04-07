Return-Path: <linux-iio+bounces-17755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA8A7DC61
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A61E3ADFC0
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B923C8A9;
	Mon,  7 Apr 2025 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YROihR9L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899D238D27;
	Mon,  7 Apr 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025791; cv=none; b=BcEJXYHejL9pDhVwUkjJh+oATQdb8Jnzp3GECpm/bkJPS783V5wZSQTSPm4OG2abdUPG8pwCMxXMAsXzoKAD8waaWZrkOYGSLSk573iiG3Vr7JB/9caipviabNdtBYNxCB13mjcKKYhTgPSq1ikbW1VO477mNnMfyQVhXaL31kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025791; c=relaxed/simple;
	bh=GG0FbHW98GA8nLlASB1APu+LSyoziWqFH993IrgInAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAV5VAkIocEZwa94i9Y40E52Jp2S2qVqi6ZOtTGhmYZV6ULErasn64XwBZ1jI1hcGSzLfjtsYJb6nTwh2cy4OIwdjODuRMXOCpospE0WpnU8/UpbnDfw975pq6TGe/+989ZEftoymvBpGc+hN9iceaKfek9gPIDNAJqxJi0Ng/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YROihR9L; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549946c5346so5033848e87.2;
        Mon, 07 Apr 2025 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025788; x=1744630588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIvoKoc5sivfRuz4kaXhGJp5sspXW/jKkyEKwtPzqrg=;
        b=YROihR9LReRXQeMIlmbTc5elcgG+cLeKaEK1buwTerZ89pTkr30P+Roycj0rnrQvkT
         m1VIOHICyq2gHo/6fINhTEwBlFE9gs418BwnZlh/jnSJhZk4ICHd/DjlZpcIoKCeAFFZ
         dXXg9Zt41PSki+rVob8+3w3z4zvWy6qu8X+IHwoQf0aSmXxgdXy+D0nSmbdY859rt/Ck
         xQ6fbA13nQcTVmpBg7/wDZHKirM/Bhj6MlLtWI04Vfp7sL5hCytlE3aKSYGD3FMLtwQu
         CJEvQmbU4RsOnNZMpUHmXGW+hDrHfoRz9KHffA499WQpk6b9BNTmRoD3pUNNA21b5RTd
         0taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025788; x=1744630588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIvoKoc5sivfRuz4kaXhGJp5sspXW/jKkyEKwtPzqrg=;
        b=BWlEnY+s+gCq2kPQ++tKtSGAkdWja6I3YGh/TFEGj8SZjS0pXDiK0hDK9XXWHWFTXi
         2rEaBLhIeQUiA5eQagWqhv4ZUGqaki5kL+K4BMNVMJBSMMC/moC4IojKPB3huIkHL6oK
         1WoB+CCrbhNNMYNL+hB1nTBgTJHTOVuD/KAi3X8M5gP/H3miBcrs7lFQRtbr88ZmwTGk
         GC9ufyrohCPAxVPYkjVCBv3Inve/ndwfEEOD3mqVJRcZn5ZOHxC/fV/CGpx1cIKW2vs8
         jRBqKdZvfUEbTLh8391KiO/iyqLaPpLiEY7qYVThz+s1CPs5Rg+uXPt/AHRQtNuXtZVg
         6BRA==
X-Forwarded-Encrypted: i=1; AJvYcCUxUVy6qSrAu3/lw3QIZoCzOdzw1tlqEuFRiDcu6pqMpMg6J2XKP/appdI/EjvZz/34xuakNuZa/zsX@vger.kernel.org, AJvYcCWRlKuarJKEU2UdOfug4bcIaCanvcR/l9xA49mEVD6gcp+UNdG7+P58YXnpDkpmXOnmnILDpleepd5v3Uqo@vger.kernel.org, AJvYcCWSXClEaU5zs1MDbr6WbA1XCiZd++TpOLPFg1RX6qlwVaThUlPF7ldCHyd6ad8GrSritKHrcw3iOhHt@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbCqf2a09nXrkNnWjDC4oVLjH1iWCH8NTrW8Gvb5gzQLeq/US
	GYD+9a5DIgDfz2L5riGnimCA+fiuvQRYuHNhgxcOY0CmmA4vjExD
X-Gm-Gg: ASbGncvuBE+7eWVBoMg2syQAAi6uIOLyMwevTb9L9J84o5+Un3Hx4SZULMph8phM4Al
	PJsUmcJZPNQ4RAp+X4UmbJrE/jxwETfZC7Jj/IJrOKCFxtj5ptXzoJIuM/jw+TWVTnrVSjsyjAm
	YvFie7v73dSY8JJ+K8p0oEWXkb92Y6Om44USoEdH2EIFWqnlFniLlZ/IOwJjPGkulAPGOVBp1lL
	QB+JGVLtPMBrfYPbiL7OZpvMMMjOxEb2C8yLUuAPBHGLQKi+9myK3hRU516r10f2s6uDulIRH/u
	kb6qO7o7ljKNxsln2wgdwBRuld1ALAlValzDiMZXndkJlmHFCv83ZlB+PzyclQ==
X-Google-Smtp-Source: AGHT+IGnEUXtNUmpditN4kH/NEFSAsG1PRIf8trdr/dXmWV0/EQ93agz6fKxchHyh2Zkq7tTKh6FdA==
X-Received: by 2002:a05:6512:2316:b0:545:1082:918d with SMTP id 2adb3069b0e04-54c227dc802mr3814153e87.41.1744025787997;
        Mon, 07 Apr 2025 04:36:27 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e65d5d5sm1212186e87.195.2025.04.07.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:36:26 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:36:23 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] iio: adc: ti-adc128s052: Use devm_mutex_init()
Message-ID: <efe4a039e2bfbf4dcf30743f6b7b88fce3b9ee39.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qHDgxrxO2/k9xrVt"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--qHDgxrxO2/k9xrVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Jonathan:
"Whilst it doesn't bring huge advantage, now we have devm_mutex_init()
it seems reasonable to use it and maybe catch a use after free for the
lock"

Switch to use devm_mutex_init() while working on this file.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D>
 - No changes
v1 =3D> v2:
 - Check the return value for the devm_mutex_init()
---
 drivers/iio/adc/ti-adc128s052.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index d0702d403fbe..d90a5caa028f 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -172,7 +172,9 @@ static int adc128_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	mutex_init(&adc->lock);
+	ret =3D devm_mutex_init(&spi->dev, &adc->lock);
+	if (ret)
+		return ret;
=20
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
--=20
2.49.0


--qHDgxrxO2/k9xrVt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzuLcACgkQeFA3/03a
ocXV9ggAjAvhMburUFitoEPxSf44CrFFj1TgxOMWcy3SPbgGwo6xuaL1a6QJKfnJ
GbqcvFb7HgzEJLDLbEDgtUec/2vgZgvaB6UgPKdCgWX15PmHL2Sjos+kgPcEQSue
lLat/SXeHbqjZWnNGwCf154sPGjwIW9lWWM1IU6G9UQe+pE6xvFia3mk7cJEM9Cb
BMPGJbGfojNUL/+QjKLJO25qf+D2+z7gv+4WYHL2kjR13bd2NOwgIy4GH0J/GLwO
l92cLNnu362cICQmPjyDgaUeIrXsaanabCBt89LGLyxpnf/IigDKqXFKBD678Vpc
0OMX5yPT3MhnpdZqzSxgW0JTRrAuww==
=DMOJ
-----END PGP SIGNATURE-----

--qHDgxrxO2/k9xrVt--

