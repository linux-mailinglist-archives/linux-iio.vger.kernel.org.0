Return-Path: <linux-iio+bounces-12448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E511B9D48B5
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A510A283496
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5A1C9B9D;
	Thu, 21 Nov 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2m0vZQF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8A1CACE8;
	Thu, 21 Nov 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177266; cv=none; b=lIl+YvhfQBXHnCZG1/he1klrRXtXoZqkFEV7WqACWXN17NytILKbBJxvRgY5y1qvNJ1F6H3IimNFYJaRF+NjaVVhI3Ho6J198fFn54cONuo9J/N5rEVPiH96QWDEC5CSR6uMYpyZM1L6ghmjN7pZ6BcLdmO8B4mLMvOK2bLqdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177266; c=relaxed/simple;
	bh=YXH017JA7rXf3Ha7fPn0GQ2Azhq4k8FSj95fLOD9lz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpeQ7Z038PzUlM8M0CuCzcCqGCjjpUef7gGXPJiooWyOiKvqG2F4bMxnht/7fOVIYYpk89EVldq4+DuO3FnJQriqilVjkLcMpDno/7bDtUai87SiVd/YmTC+GVRMBarkdZFPTWqyE2XUOTK//PiDaaAA+WW2Ta8f0NsbLCF/C+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2m0vZQF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb49510250so6925281fa.0;
        Thu, 21 Nov 2024 00:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177262; x=1732782062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjTBJQdW/deFc59xWASUDW+0/Ls2P158bu8ZfEU7/Rc=;
        b=l2m0vZQFWXcOQ5u36wr2CnlxnY2Wxv1ID9wos8/al4+X3l274dNKayc+uPAcvKilt6
         MUv+qcaq6NGL9fY9D4odZ3XYPDJYCN6DopAH07F/izV4hZS75jOpQHutUTYo2yJqLkro
         97dRyeAhVNPsmI37IgC0pudmbYXwU2UztefKUJMFbMyB/srQNtZukU9CqT3pn2T3T6c5
         6geGxSy6JpjeOpq8YBYQj+dRLhAmILTsZNJKAZ9ZFswv7z19QQ4egTxBsD7TiIUdIXJT
         CPhuUIzmyMIXcw8Qppg2PdFt48coI/SVnhN6Sj32H7G87TC4QudcINadluycpiDtgY6D
         mosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177262; x=1732782062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjTBJQdW/deFc59xWASUDW+0/Ls2P158bu8ZfEU7/Rc=;
        b=ZqtsxPouXHGAUCByZryVEZmmdAy1d4Gv209c/pM5vDtCAzmU6PgeQJllPi2NVWbYq+
         ayS/4fJd3YRJ+OyGCThwpHqmEqVCxjKGHKREP64CWvb4MvsYOOBSRGmS+2Pl/WC07pLU
         GgoV5WzO/YoHufFkrdbxL6p0mjsAAI2PztVTQOiM7PzPgCmqcS4vTIsPPFSYP1SQUx8r
         lVeVvzbD/AddLUyravcvxZEs4WQNbecyH3lO592bYMOxruymhJT0v7p3vGKRdYodrs5C
         cxOSTUB0+KtH3EHxn719POtNBOgQJft1dcja6esuEamB4098AW2oK4mywQehD6oQydJJ
         8DIg==
X-Forwarded-Encrypted: i=1; AJvYcCVFkkgspKccXPY+9qZpS4GfmwWvp1vRS0A7v1KzynH6HE+J9gE8Hx+GatONmhHxAiNM32dj/Oypurdd@vger.kernel.org, AJvYcCWCze3Z9o/ZMLxIDsszIXzz0AC/GI+M0UxwQIBlKsui++AiqJacZQPyBZJfbeqVYiVXdoo1thoF/7IHkCVB@vger.kernel.org, AJvYcCWlaPBZJhcaXl64efoKbor8X53GdUBZh+EzneeFXiynEttXYojgQwYEMjSnuKByGxR0NiPqmYwQ+Wj2@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyQ7HjHlyWFvja+7FjLHdjxlVoZKIaKa8SQUkrWB85mTUqskw
	M8wGy270MgR9vHlidajdHGVDYxu1kF7i6MoMbY/1IjgJGUPKaWNe
X-Google-Smtp-Source: AGHT+IHIeZelgBKhIrZrbl/c+jDtLkhO0KDO2uuyEqqBjg8KZi6cq7elkK/970+OAKKq/9kCLQq8JQ==
X-Received: by 2002:a2e:bd84:0:b0:2fb:955e:5c17 with SMTP id 38308e7fff4ca-2ff8dd01cc1mr37322001fa.40.1732177262376;
        Thu, 21 Nov 2024 00:21:02 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff698515basm18120171fa.23.2024.11.21.00.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:21:01 -0800 (PST)
Date: Thu, 21 Nov 2024 10:20:56 +0200
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
Subject: [PATCH v2 5/8] dt-bindings: ROHM KX134ACR-LBZ
Message-ID: <ff43d7a1df37760c3cb4a0a7f1cf7e26b9b894b0.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JJ6HfPVGJDHQrfTz"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--JJ6HfPVGJDHQrfTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom the software point of view, the KX134ACR-LBZ is almost identical to
the KX132ACR-LBZ. They, however, have different g ranges and ID register
values which makes them incompatible.

Add compatible and information for ROHM KX134ACR-LBZ accelerometer.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

Revision history:
  v1 =3D> v2:
  - Improve commit message by explaining why compatible is needed.
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes
---
 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml=
 b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 66ea894dbe55..c973f4941a6d 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -11,7 +11,8 @@ maintainers:
=20
 description: |
   KX022A, KX132ACR-LBZ and KX132-1211 are 3-axis accelerometers supporting
-  +/- 2G, 4G, 8G and 16G ranges, variable output data-rates and a
+  +/- 2G, 4G, 8G and 16G ranges. The KX134ACR-LBZ supports +/- 8G, 16G,
+  32G and 64G. All the sensors also have variable output data-rates and a
   hardware-fifo buffering. These accelerometers can be accessed either
   via I2C or SPI.
=20
@@ -21,6 +22,7 @@ properties:
       - kionix,kx022a
       - kionix,kx132-1211
       - rohm,kx132acr-lbz
+      - rohm,kx134acr-lbz
=20
   reg:
     maxItems: 1
--=20
2.47.0


--JJ6HfPVGJDHQrfTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7WgACgkQeFA3/03a
ocUqlAf/awCX2E90ZyYjthBI0VIAMvKlb9xM8+ElnWNAT/PyoBtumSOgeoIB63kw
qAblb+kLNoqtIB57L/1yijohk3fzfvcYMB3R41p/uvJsFStY48qYP+15+fD1pJoP
2imWjPg0GT4iHIxPcvlnM4edDVIrVaymh1gCmAciUrqmnuiwr4lYHUf6frvjK4gd
wfReS6ZYjZxzNUvOCwI7lq6mNFugqpFFHj4Zz/vKjSP9Layvvlr88OcjpKorrz6S
Xf4K9DYu/UCkxFc5mvodMuThU3llfszyEOhVzskqFmFDS0NdNyOnKI6hFbwfkrtc
r5sa9l15eTfpDAqphTt4fRF3hLNJDA==
=sq08
-----END PGP SIGNATURE-----

--JJ6HfPVGJDHQrfTz--

