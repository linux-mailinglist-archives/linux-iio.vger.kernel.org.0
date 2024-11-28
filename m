Return-Path: <linux-iio+bounces-12770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE79DB482
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017DEB22829
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC9015443C;
	Thu, 28 Nov 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIBYsQPD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0901547EE;
	Thu, 28 Nov 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784594; cv=none; b=fv/KWGHMrAa9QXyR5SwPZ57jmCc6/hqj79OXqDvVgsArwenKIUz/hynL5MGgi7jrDwIsqcmtSvl6cx36ThLoG5y8DgztcF6QCbmMF/eApkmZIyWM8CxVVfDFr9xY3f7/plTbmNdbEUuEuNu3jUSULQqeA5OqaeRaGuwZeGnXrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784594; c=relaxed/simple;
	bh=iAQrajyZwAKlx0GJCBgLYQqerCJHLKdAJsNL5fRH1EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAlGSo9v0CiPQiT82rWXdQ+5SpBJXVP5HoHQc38n0sKiyGiKZ0e9F/SeoYj8mJuhvFdYtdCRPPhD5HQ//K5HN6u9vq4epM/B9I888Ow8Xytb09bJWkL6AOyOTMMhNeqaOAKPOlNVptRw+IcFwEtusdBTK/vVsjmc/61XqHbMkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIBYsQPD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de79c2be4so563846e87.2;
        Thu, 28 Nov 2024 01:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784590; x=1733389390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfhFYuYieXmvJXDGOA9mP/3xPmE5z5AUMkwtuYyYGmw=;
        b=LIBYsQPDDH17CjkRxsPsmLv8OTg6QYYZy30POkMCO6YV+2PgD5GKfP9hJQ/LQWsAUZ
         H9HIFyU87uKoZfZTMqa8WeCm+ksmb5Rbh5eIpcvo0r45NWTriBxN3gZQOvEptGD6AT1V
         0PYY7p3oE395tManixYTH14dCh8ddjKhaX1BvrhsNiMiKJBoZxqwPhiSkH3pRo9eFLd7
         NEIy1ZJYOOdbiDcwjCty4bgR1522BmZ/W3anInaRBM10if593ipTrVmU3owcfmc5kGih
         v1XVL6dpV8Pum0JpcQF/Tv/qQjInG3CNBCqbV+AE0jotsQTql9fWDVvIBNaJkvFd6YJe
         X97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784590; x=1733389390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfhFYuYieXmvJXDGOA9mP/3xPmE5z5AUMkwtuYyYGmw=;
        b=LECE/wova1hgnNWJYj6VIrH19MmEckhx/cKFyxjj/nKAuLfT2zeZBby3FJvPM5Ybaq
         HKbcy4z9EImMET8+5PxKdsfTNJcsYa/dT86qkNqPm8hnYLtNLGGhANS6hCrM+PYW4vLY
         DFtkdATKWIsugSRHoXNakRLtww9h/LQCCyN7Sst12j8xxwC6N35X4vkLqQNPwHXvhf//
         pfIszbOugMR1ReAplGRbAsco2d1mTj75YCrSdVcYdLrR+rpmcF4h7QhZEy+rCEYD9Vz8
         Q7dYhLTiRKUK44hVLvZhRHIHr+cfEYGue7zxyisIB5igOfLhBvKQawriFeAR0gIRFIL8
         7L9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkHHDqVWDU++VNl3YkRZ/HtPCalElhU+XFA8mi/UvUNex7TtzxEszhwwYbRqftZyIAXN/6E9xJtpbJ@vger.kernel.org, AJvYcCUtEWExq4ZyyL7K/NEFz8ktBeeQ3OoPQLNDzUf4XXk18R0C4TgIRB8h9CILBomTCC3BKSl2Ezhgf3F9GfyJ@vger.kernel.org, AJvYcCW4NTTPZ6Wap3BhadlTHJjZ1dyVeV/OLRGjwlm78TgovvnbX8aVIiBvIuRW4V4nvFpKk45qYgVMuv8F@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRn+Kf6ihqpyPQcoRE6LZJacK76lY47WxPQ71TrgNjLnJY0w0
	rdZSW+tvtcOGrkBE4CIe+x2tl4U3njI6470IQzVqHA/NiWXF9Psu1I1ewA==
X-Gm-Gg: ASbGncvNsZ0sAfFlpJbOWMPGOTdnKxs+eMfk8VSTa8ac45qoXhOiq5b4/ZUz5Hdz1Ld
	Q7pZcqcSt8/XdrPbVzNPUmr1NfsSKkJdvHk0vUWXUHpxc6W4JrGVZDh5mcWrTq61leYLcM5tgBF
	ASmWd3GUiJYIKzLExs2BlJIWfw7T2vBsAyMlGhZxbbr5FptrErRT2b54pJ6BOAxV+llKaXrcm6g
	tAGTw+s7lY/X+bnAyJckwE2d33T6N59loYpOpMzNp9GSU16dIfk
X-Google-Smtp-Source: AGHT+IEWEZPLwI4fPFTskvYqirjFAckRCvq1D6tvPFe2z73gUpZu4Bod6skEOn+aYKVpRCH1gy7cpQ==
X-Received: by 2002:a05:6512:690:b0:53d:eec1:a03b with SMTP id 2adb3069b0e04-53df00aa172mr3631254e87.3.1732784590213;
        Thu, 28 Nov 2024 01:03:10 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644aa9dsm117739e87.110.2024.11.28.01.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:03:08 -0800 (PST)
Date: Thu, 28 Nov 2024 11:03:02 +0200
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
Subject: [PATCH v3 5/7] dt-bindings: iio: kx022a: Support KX134-1211
Message-ID: <48b50cbda3d6c3a58a7b7c9ff23ed4dc7f418a5e.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2duNzWQ/96gyQot0"
Content-Disposition: inline
In-Reply-To: <cover.1732783834.git.mazziesaccount@gmail.com>


--2duNzWQ/96gyQot0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM KX134-1211 is very similar to KX132-1211. The main difference is
supported g-ranges. The KX132-1211 can measure ranges from +/- 2g to
+/-16g where the KX134-1211 supports measuring ranges +/- 8g to +/- 64g.

Support the ROHM KX134-1211.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
  v2 =3D> v3:
  - patch number changed because patches were dropped.
  v1 =3D> v2:
  - new patch.
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


--2duNzWQ/96gyQot0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMcYACgkQeFA3/03a
ocUplQgAuGxA2lMy6PjX4v5fQg1z4AFkvxc7b2ZTg0us3jd4Ixg7J2V1cwGc+Y0D
S0enf207brxO+t5leAoV9Iix3CzjXdKeicAQb8HlFToNfH1AblG3BDO0U/EKh4Ug
9QWs3iTMuVmBRwG+9D0e/9C6AHVO3ycw7Wo/SUCGLcKb59vlWOwhnv30mfHRusL1
rgcJ/A114xazA95a5OK2DcnI5fgIe8yK6dBkcY2tXIFXagxicCuRQIGgNlqKF2xY
uabl/s760SEYEk+PUn9Y8w5YUhDvCWFceKA0FLt9TZucZF/KMJCXfT3j4dxOSCFd
vjazH2cyhHvJFioCA5yK8BckI+4VAg==
=lZAw
-----END PGP SIGNATURE-----

--2duNzWQ/96gyQot0--

