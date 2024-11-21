Return-Path: <linux-iio+bounces-12450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E089D48BA
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A2E1F2249A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2E1CB329;
	Thu, 21 Nov 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL99SWv0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054B4502F;
	Thu, 21 Nov 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177302; cv=none; b=MchfSTRqNCGi01qoH5HUfGsLc8SfnhiG4VjIBNZEjVeF4YWHYjDzmTvWr+sWJSiEnDu0U7EthG9Jka/sI5nhRwLa92nWOJXAixd2UEKic+zKH2ChFPUAhsIGKRKSksrfncSX9xu1ZI9PjUSdSp5XvwFYeOULipbrqV1eA7IJing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177302; c=relaxed/simple;
	bh=eBuaFTPsyQJykGH0VszjvZETRY6TC4PFlE95VjKRQc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZRgHisRj6R7XPr3sKsUMLwiyf1q6aFVQHw/A6qPKc9YQA+VIG9AkoamnO6SJ4nrrrWCibVTjgVG6mRtKRWJBZwmSUL7lV3pP9eCcqRjGxCuHEgfq7J4++MOtfwL1MssYFH9dPYD4Ul2EVVz+C/axkNu7g+gwIkxlT6YHYrg+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL99SWv0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53a007743e7so619978e87.1;
        Thu, 21 Nov 2024 00:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177297; x=1732782097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxsH47pyuzzcy8deLj7BAaJCTtPX0VhoHVXiRse14mM=;
        b=UL99SWv0vjDNY8qZmJFYdTpxuQoKtQpie+wfOnwe3F+EdbQuRRO5nrOt001/8hsFwU
         UWD6bHA4sGikfFHqyJeforYlx3XaGKf/py66LRiTtlCDq7ywAysv2dmSOToe9snGlUEI
         3Ep67/IUJO9Ri0nL75p015RWn/6cSd1MKoyZFdPcCVdsIaAB8Gtf9dbuWy0CW/i2LrAm
         Aem7z1fQLZk7Hv3R6M5u94pGKv2Z8f6fMScZYWvVfFaTgbPMgt/fLhYSQKE7OtkU/Ey2
         CkL0BnMMfofdBfkUgeNd5UZ+Bs+4RY7Vu8KteUgJ6GXWArqRiTkF6FvkfhruGjgmboXA
         AG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177297; x=1732782097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxsH47pyuzzcy8deLj7BAaJCTtPX0VhoHVXiRse14mM=;
        b=haadKNFEv0sBf5U2Yq0UqIhpXKo4CySMzJGFsL1ic8YN4xDPbt7apfCJYawtbpQMNt
         M2coOUG1fQHcZcjqWbMDQQLsH8qec8zb0MTE3NFfSg6WxHC6S/WNKM4WgF/vghFUPRpR
         alB94y1oKPwQpUKS0uLp86sG+Lh4ryXfN6/Xk06/qmwbTZUX5JDzh4iU0TX9mFTruF2i
         aUWizqocm3jOBv9Xq/Fu6ibrZxrc4EgFzpIQgkJpzpi1MG/CEKRjzkXZCQEPAzkp6YWJ
         JHoXzFT5KZzxjGfPiM4+HcsQDT06ZpmHQVh3V7gLLo56ZuxkQyxKYJBgt3pG8S3l5HMF
         ZAhw==
X-Forwarded-Encrypted: i=1; AJvYcCVUZysWFfC210+/iEZTQYludchm9YqK6DaA62bmuOmewY6LIYF/40mNkW+ghFHjloD2jClbHUl4FQCK@vger.kernel.org, AJvYcCWchrBNn6A4lkDoaxfvSvMkXPAkg4nIj8j6X8tsUde446Es510hvJvFzi+YrZpZu1vuRZk7YwpYFgRGthdx@vger.kernel.org, AJvYcCXYPlf2bW5vJQaNWjxyP9hgujEnQk13a6eWjbxprD2KxUjTZBizQR+uQtg94plDZwdnq2PFBdFBRx8M@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNRIrVOx3MWvbltlhaBTjqZzP92L9WqtoQV6YSrzuRpy1iAhG
	9/YvN2YZjqRgDAg9ofCstsJESG4N0lFWTCAEqLV0DqP89yGu0WZA
X-Google-Smtp-Source: AGHT+IHfknFjd3pbOWmUjS/Ujetybo/zVW7dEoFRdakdwkdNaqeIXqb2fVL9Umt77JLVCIZmNIXCFg==
X-Received: by 2002:a05:6512:118c:b0:539:f1ce:5fa8 with SMTP id 2adb3069b0e04-53dc136debcmr2522795e87.49.1732177297087;
        Thu, 21 Nov 2024 00:21:37 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd478053sm892541e87.230.2024.11.21.00.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:21:36 -0800 (PST)
Date: Thu, 21 Nov 2024 10:21:30 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] dt-bindings: iio: kx022a: Support KX134-1211
Message-ID: <8d0ae2f58678f4daf2e24c8f4a8419cd5d225db8.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8NVcjGRzBb87Z38U"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--8NVcjGRzBb87Z38U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM KX134-1211 is very similar to KX132-1211. The main difference is
supported g-ranges. The KX132-1211 can measure ranges from +/- 2g to
+/-16g where the KX134-1211 supports measuring ranges +/- 8g to +/- 64g.

Support the ROHM KX134-1211.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Revision history:
  v1 =3D> v2:
  - new patch
---
 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml=
 b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index c973f4941a6d..f07c70e51c45 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,23 +4,24 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM/Kionix KX022A, KX132-1211 and KX132ACR-LBZ Accelerometers
+title: ROHM/Kionix KX022A, KX132/134-1211 and KX132/134ACR-LBZ Acceleromet=
ers
=20
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   KX022A, KX132ACR-LBZ and KX132-1211 are 3-axis accelerometers supporting
-  +/- 2G, 4G, 8G and 16G ranges. The KX134ACR-LBZ supports +/- 8G, 16G,
-  32G and 64G. All the sensors also have variable output data-rates and a
-  hardware-fifo buffering. These accelerometers can be accessed either
-  via I2C or SPI.
+  +/- 2G, 4G, 8G and 16G ranges. The KX134ACR-LBZ and KX134-1211 support
+  +/- 8G, 16G, 32G and 64G. All the sensors also have variable output
+  data-rates and a hardware-fifo buffering. These accelerometers can be
+  accessed either via I2C or SPI.
=20
 properties:
   compatible:
     enum:
       - kionix,kx022a
       - kionix,kx132-1211
+      - kionix,kx134-1211
       - rohm,kx132acr-lbz
       - rohm,kx134acr-lbz
=20
--=20
2.47.0


--8NVcjGRzBb87Z38U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7YoACgkQeFA3/03a
ocWIAwgAzFqwd4u/wqT6iXH2Lleh4XIFJmVjFsLnazw4BUiJmqAuXjb+cvg0tdNz
1k1+vA99NTnGUf72+NrxG4d7zDYwdpwe2XUpkd46w33y6GjBzyr8EbiFyUi12M+g
IJe+OSXqdAq+Mq5L1XVsUXa7OMLv5mZCrFat8d6J1VwLZN3EUgV75Paytxukqf34
3xtrvymgQ820Hwn/l9MjsrIkic/QEcSWlReyhpRvY0wznqK1a6P3I1Z9kf6X7Yme
mdA2mvb24mZ4wBYG7fphAydiaUFW0Fi1nH2YOcv9xOhUyIMKm9VBSkaRS5bfdU1P
CxF/vvkDAPtHAj1frd4oJMJgWoepOA==
=1HJX
-----END PGP SIGNATURE-----

--8NVcjGRzBb87Z38U--

