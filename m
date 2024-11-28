Return-Path: <linux-iio+bounces-12768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DEF9DB479
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED91FB232A6
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034FE15359A;
	Thu, 28 Nov 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUkk9yYa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2552F88;
	Thu, 28 Nov 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784561; cv=none; b=pZIuAcrRYbfE6P4ZqtltAMN3uMGcu/jLNbCIEQvR1FoAn22mNcODXxts4TgtqFl2Kw6YqunqszfPew2uGqCGLa7akPqvKn0vFBG4MPS5t2ICYRCzYOZRJItPUi1kaTcPwPS9jJ24EqWkEYT1uIGlrJMULIX1gVeuDoeGgwrWYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784561; c=relaxed/simple;
	bh=wogo9VGIJAygc2Sr0Tv8SWUOA4RuthVnDtCsa9yr6Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrLjVnU0vyetbM7WUsYd1gGD+s1jMwQVSLIMvinZUf5W5PbvJ9FMOjKzm/4WXPN6VKebVHImsiY6zZe0LTOLDH+QBa2CSpSyKOhCPMBd7BB82JQ/QGTumDC0oiugcAxX65TLKiMiFmCJMI9XpFWOgsxMN/TyEKQtuHHt+HiDsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUkk9yYa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso485210e87.3;
        Thu, 28 Nov 2024 01:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784558; x=1733389358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkaT6GSi0h0USs77Nou+cNjAX2d6sAXqEVvVzHMrazM=;
        b=NUkk9yYaiVK/FQKlG3vvk8skYeyu2mlIDfEUZCaJrYUNgvx1np1fxUCR4kOVPQJJlV
         OHO2wRvPgKZYYaLC8fKpHYi/uLxvPDTcqP/CdJ5uLk9HQJbpoSeynXpDrLkgHkojmFHm
         5fVf1nnv25BS72YW0kbRQN3u2Kzgu3m3LMseoAXOPIdpqKPpVsKhMYL8vJR8L0wxC56Q
         GR6KQCiWfjNHq8aIoGesPuozaMC72FqufA1VE4Fx3Nvw3ywk4CUZ/Q/wcCXhLCi+uc1D
         PaIKx7eTOa09rubUisYGKpCuKLqykIkygEZfMt6mKyMtRzwsjiVzM1uJxT8RYuJklcCY
         4C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784558; x=1733389358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkaT6GSi0h0USs77Nou+cNjAX2d6sAXqEVvVzHMrazM=;
        b=lHEEKFTEsg/7D1phS+1u7ilk5vaKKzzny7Pu521K/X8ZoTlREZeCpg+yPrLSqNWBW9
         u56Ijf0tpaIZyzKK8g+cZdkPsU74A2AYLuSeeDIhfYXbGnNpSvyXJ4xmIIV0sk+jtN7w
         JS0KFPP4Dzatu/d1px6YVGgBp6bC0RYI4FqoXLaGRRgGXUFLdmOrd9VJ+JZaDz7USw7D
         FE6uae29VQlC2cZe4LEIR3S1NDsGbL76Q9mEVxnOrsQRLLIdsphpTmqKnCk5eCw2J/zW
         KxOcY25VMBenELl+sIBQhBNKyhPLu8Zq83WBJ7A38cZ6W06eVPMup3FqKi6EoF2Qvw3w
         dgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFrkpzu8K+JRqwkHd2BlV3lfhEyYDSLdAL+Ykdyom1CkuQlxvT1dVxdj117WWahHH1LNS7Ny5WIRwO@vger.kernel.org, AJvYcCVmCi3Xz0lGsPkd0MrwjQpwg6dc0jhYZgxGQqgsPOIxeZXqnnGfHbI43UIzw+qiIUA2jAOG9BZOtAiSLsa7@vger.kernel.org, AJvYcCXc0gEJRs7OrO11ZmLofHRgMgAXoD5NIqOrssiM5GDO2uvbvEmDZsFswWEKzVN5Y7Sgj+sbRqVG/RAg@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMB4x/kAwwGEUfF3/sepSo7O/nlmV0jATa8jBfo91K1JYva7h
	kC57x3Eh+9oQJwLv90+PXGapdWbSjCnjep6u4KKhv4xsvXgT7K69
X-Gm-Gg: ASbGnctyTe5xN1A5R0V0d0p0dVtCTp2NWnxgYfnhUu3uglkqJoSSrrKoNkdwsuATKdR
	34jl391yAUPeKfRG9uxZ7AlOVtg6BuYnMCZH2k+fTG6yplzxpvIdshONrpA6nMifOGA21cyuoMT
	0eWbifM1+VbYwIgSeWmowwpqOZmy2gAoxD9SaSHJ1nmsLfU6pwpxPLdoVhCBJp96D7CJm7lWFIU
	UBKhqqKt1Y/dN0hE1JAyc54ptVBGE+hav/oBWsAmgU3kCnBNsuG
X-Google-Smtp-Source: AGHT+IGLT+OKjkl9lcTLnLsX6TsK+HNSFvnOVrxJ9IZlF/dGdG3pyUlg5ez9GA9aFKI6XkZMMUF3/g==
X-Received: by 2002:ac2:4884:0:b0:53d:f0ff:d244 with SMTP id 2adb3069b0e04-53df0ffd256mr2534506e87.22.1732784557955;
        Thu, 28 Nov 2024 01:02:37 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6449d7asm116544e87.107.2024.11.28.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:02:36 -0800 (PST)
Date: Thu, 28 Nov 2024 11:02:29 +0200
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
Subject: [PATCH v3 3/7] dt-bindings: ROHM KX134ACR-LBZ
Message-ID: <2efe2bf7078704be3f020663960fef563ab21aca.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W0EZVz9CK9ZZWO3Q"
Content-Disposition: inline
In-Reply-To: <cover.1732783834.git.mazziesaccount@gmail.com>


--W0EZVz9CK9ZZWO3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom the software point of view, the KX134ACR-LBZ is almost identical to
the KX132ACR-LBZ. They, however, have different g ranges and ID register
values which makes them incompatible.

Add compatible and information for ROHM KX134ACR-LBZ accelerometer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
  v2 =3D> v3:
  - patch number changed because patches were dropped.
  v1 =3D> v2:
  - Improve commit message by explaining why compatible is needed.
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes.
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


--W0EZVz9CK9ZZWO3Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMaUACgkQeFA3/03a
ocUpBAf/TkcGrKf+EG6jRpQEekU+Kjw6WDGDe8ij2TlqErd8wfITx+7rWcrCubev
5yH+RBUuMHitlxL5nVC1NiIwLy7cRf1b/QsiGrNYz6tsMiXtf2ltn1DMYQfR6ORa
kTWPcLZQYi0Jhmb+ttbNz3Qa+vNut9YEQorHSage6BBok3e8Vn+hkyRL78c7v3np
49zWMZisC7XEDWh6/yhkTK34KLjCZNatLLvJjpvEi6TV4aO1026fCn4Xx/DLn9B5
iifQ3rO/UPw+0GmF+mZOgQOAdutAg5fRn6pU3mtcAxn99QUcD9isare3iwuGPKSW
+cnR6lbkCNY1qmwlqPlep41q34+UNw==
=rM+o
-----END PGP SIGNATURE-----

--W0EZVz9CK9ZZWO3Q--

