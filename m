Return-Path: <linux-iio+bounces-19480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC47CAB4E11
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 10:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E5F1B40F49
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952020485B;
	Tue, 13 May 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKDDfdOL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1DE1CA84;
	Tue, 13 May 2025 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124797; cv=none; b=YPVaCFT7jX9jCT28OTd6a7qhRhPPqmcSfc6Uwgv0BkJhdMiLLSPEZFT7CejWywxBIcgu5lNNqix10TjmLo2pmt9nQasSP1TrwLQ9LzdVLe3+1fWQU9uF9i7aYlAvkV/iHNQJzFDq0ZF/K0Gc63AxptX6NkamfpaW8Cx639/OiIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124797; c=relaxed/simple;
	bh=0gb8odRlRkLiLXlnF2fCsm07x6GoiutfjQ3jZJuOR7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNkbQbj+biBuJbvNLqcvIU3BajvYB90iU7OGiBIRRXN1Foyho0KiTQ0LJA4AkyvSlYOdPs+NvHn2FqaVnDwmK3VGaSwV7x41+UXvU8rTWXA0yT10lu3hLxMgZt6aun6qlk6eCM2rQjkO3EMnF8Xn9OpUgLiEEPk7VG6+paV2JhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKDDfdOL; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-326ba41006aso38626751fa.3;
        Tue, 13 May 2025 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747124793; x=1747729593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt5/RhfgUgCzd2EliRs4w8sIGdclbUiJRS770AgNwPg=;
        b=MKDDfdOLZB2F1y1TTyJrwCaiNSPQiL1rGZvph9K1+cZc2wG3lPVeet/mVv740aujTB
         8zIrN+LqVxnOXFq9qwl9L4kI4WWBdzraB9nfXoJnxpofz9oKSwLSG1zvWy6rr7jhZ9ft
         8gwgSyGScQETb3dJrA5Zk08MVY5PmrGb9szJN+81fQ2ZhKGRBBsNjeHIFK3w7Lqvp//G
         gkTCbEeh8wkKUz14041X4/6FhBm45Ixd4OZ53XsoApfWqewCGhuEQAnsMvIGuHjE+cPt
         mzs7JNikAeaj0oAj6w1GMtCInog5xqje/mh83Cd17rhhdRm1dHCvkNqlp8feTi/NEymq
         Pkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124793; x=1747729593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt5/RhfgUgCzd2EliRs4w8sIGdclbUiJRS770AgNwPg=;
        b=DyjiNvwFuK5VtZcC4wPELi9ZmZBbJN6J3lzYMVrVzqLx7KjSMMTi51LdtqtXTLyzTs
         8uooSH5n0XSqCrKRxstiloNkiTQxk++VnjWLt8yUnLKH/BH1Zcq7gIq3CiUCczx6L18I
         BiTF6GtMeJqMDgUJCOCKI9cjNWSdiXVQNAgdiAkeSEcAYjl/qSTVGfmC0mK1fxFNuFCx
         zCznND6QjHkxtQKTjCZwCFLAVmU/gL7laI8wYnFcXhVY2XjrGbCaVsxkKgsKmEzwUgNI
         koFXxpU9ehkAC6q8oxYBdVeAq2wwQV+9E+vurBnhkg/haztaQ2uTpMTeVlOvrFyKBoPD
         M5+A==
X-Forwarded-Encrypted: i=1; AJvYcCWAJJ9wnixuPwGqTwN6joiA7vMZT8G+c0ONv+s/jBL7pamJXZMBir0TnPtNTJt8d1dMPr79ux0fySqcQfSi@vger.kernel.org, AJvYcCX0NT+28orJJzfo/WJd8amQCDQvS+eLww2XlkFPVquHLQvqbPdWY1K2ZRMU9YOph1/h1jHKCRiPVRyF@vger.kernel.org, AJvYcCXupReCpaKGptVZeaubdi7cOP+aWBZb4jXiFjYAGLYqkOOkO6we4ofBQoVXf5EvAk6axbFtrrJnuT6G@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5mdsJBcBgIx7fz0TbCZtcQdaIuzAJngQlYPIyYqrX5u/x0eW
	dQ8xJ2vItA4LykN+EJSO0JppDMya5jTzfDM50FXXN2ZvJ9J2RfX343IigA==
X-Gm-Gg: ASbGncuRjZKhy1whOicjd3VgLplM1aenXPU474CJEjZ2rfZP93oZyDcY5Cd0G1weo6g
	rGYaQd6TlFx/ozsBgSRih1xeNEgh2fJOVt6+XjCPsyd+2V5UCbi8i+XfnCFCZrDvYJH/T4ztM+2
	QTcpmgat1j7ExLuXhhwOwHqpmbVs4heOq5jQX6pTdl3BdPt3EjPTttcPgb68DK/OSQlOyeMWgY6
	X6fTFApLrxRPVc39ZufgGsroqPqJkMJBdrz8lI14GH0/fGbHMeuKF/O+lme83+7MBGPISnbYEWF
	zINf2d6BDSpVq2bklvz/HpdSfVEt1fkDosGXH8aSPPxeHvdI+K1dXIs8iQ==
X-Google-Smtp-Source: AGHT+IFThdC9q2oUFNuCNb1b1ShB1pd+TCXjdm4EheUhnyWR8Ezsi0UXMoUStx/IgzdExg2XJZqpqA==
X-Received: by 2002:a2e:bd0e:0:b0:30d:e104:cd58 with SMTP id 38308e7fff4ca-326c469ea1fmr59343961fa.41.1747124792336;
        Tue, 13 May 2025 01:26:32 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c339a410sm16525401fa.2.2025.05.13.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:26:31 -0700 (PDT)
Date: Tue, 13 May 2025 11:26:27 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add ROHM BD79100G
Message-ID: <7deb4b69795c298ba51c9b198bc87000ad35cc9b.1747123883.git.mazziesaccount@gmail.com>
References: <cover.1747123883.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G87Qcv+pHgJx6oip"
Content-Disposition: inline
In-Reply-To: <cover.1747123883.git.mazziesaccount@gmail.com>


--G87Qcv+pHgJx6oip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
The 4 leading bits will be zero, last 12 containig the data.

Device has only VCC supply pin, which acts also as a VFS, determining the
voltage for full 12-bits. Specifying it is mandatory.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
index 44c671eeda73..10fb6e14c2d0 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
@@ -46,6 +46,7 @@ properties:
       - ti,ads7867
       - ti,ads7868
       - lltc,ltc2314-14
+      - rohm,bu79100g
=20
   reg:
     maxItems: 1
@@ -96,6 +97,7 @@ allOf:
               - ti,adc121s
               - ti,ads7866
               - ti,ads7868
+              - rohm,bu79100g
     then:
       required:
         - vcc-supply
--=20
2.49.0


--G87Qcv+pHgJx6oip
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmgjAjMACgkQeFA3/03a
ocWKOQgAqBJq56UJHZ3O4fsoQdwlHHtkxWpWWMhhskt5hACtrAkC2bd5hsnuKj9e
cRjbz3sfeF9fVcIACgZY0ZVfOrit+uZ7Ua4xp8WicU669IzZPq0prtmc7jHFMpyD
tmw9memptcbPeR8ZW2oULMX9x+siV179QLjZYk4VrypaEGtDP0JzlCYELExerrud
Tb2APbw86AGH6rMTQ3IqE48rJgcvHCu49OmQ32rxandrFWrEK7lxtazI05oDNHyS
PFBTvNJYxP+WOBSIUCT0iBnangeL0BbXDZYXaEp1bP6D3GzvDGc5BuXVxIIs/u+/
r/hfUvR3f853l8Ik4AfEL2dgeNUxGw==
=OtIz
-----END PGP SIGNATURE-----

--G87Qcv+pHgJx6oip--

