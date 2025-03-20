Return-Path: <linux-iio+bounces-17144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0CA6A139
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5B7462C62
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647B22154E;
	Thu, 20 Mar 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPX3pBL1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4071EBFFF;
	Thu, 20 Mar 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458945; cv=none; b=SKOTAxHxdCjUuBHRUr4wKezCMSagfmS81M0ud/Th8WlSCofn9Vc2NIFJkEu9Zz6lj/gjlLQ957SeQQl+uUu0N0uxdRTHPeCiabstVOBKme5hq2OUlGVTdySA7Osw3soKPttaxq25oMP2JCIkYMTkSEwowRYoPoJnqxqHpXk7zfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458945; c=relaxed/simple;
	bh=LcKythHWTu3cvrkJmA/M35tDVU9XgXQ2PjiWeTXt5E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1j52eozt3HknvR1nRlqSD+nSYVj83dAjBYeqkXCiX493/FCswsA9vn8vVrf05WkYHw+/KUSbypBmMORn4cnoj0xLnvNRyL1ZT0nX6zDFziVUhlMnE6LpYVKYPxaS/HCZPmrhuiOgTAyrWeFX6nOwGmSBqywEFNgbHB1IZHJnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPX3pBL1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54ac9d57173so1787241e87.0;
        Thu, 20 Mar 2025 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458942; x=1743063742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pmd/n1xd7k2T8XMZPqYkLOsLsUUybFUobREHXbcUvsY=;
        b=CPX3pBL1Ch6amIXSdTKt/v35evaoMMfQSbvkEBNkW5M+1/MC2AWMUz/chGrjL0CnOm
         GDj2P7bxQmivPR83EwSJQopOsdVLFdawsuFlQY5qs60CT1tSRcGcScc/mPQ4CEm12dPS
         yP29s6Qx8Bu8hUbpRmTVvTpsL0BmffyoLxQiO9U+sczCGt4jz0SNIA6c2Of63r404+f5
         9MaWo7IpJXa8u8kYFRc1A4i1ehtwsuFTSpCx/ggFptECHjn4Yc+vK+Ip2P66O05df+al
         23VF6JTN0N/Yai61pmmipkZ+CRE5VAa1lES9ha6df4pJuI6cbpSCJa53W8X9tUvEdWTW
         PE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458942; x=1743063742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmd/n1xd7k2T8XMZPqYkLOsLsUUybFUobREHXbcUvsY=;
        b=n1XpzgFVLhDidYuhCi7NOQR51JzNDB1sxreyFmzz2mhg3x6bk56G+pznPgTDcXZmfW
         EiREcE70bSewZbRCydvlL9hfpNaI4Pyg7XcaP+2LLGReAIib4aRYOj/59gxWWXuoDeK0
         Z0dV4HGztp9mJ1hNt4e4WPy6tOAFhHBLsAdZ4xns2Yn2cshwyQaR9OolQZRWtEwapbc1
         Ytl6xtsEViGG+zffn61WJg57B/Db6cc/tsPcCeGxH8Dh9djiq87HtCz0U3s8xebjs3vO
         5A8Ay/ojYzcMny8lXumzGQP5lwB3kxJ0ICmoPG8X0QcyRd5GbXmMhacsBPNMVqZqRN2H
         6wrg==
X-Forwarded-Encrypted: i=1; AJvYcCVNg1bud73dKcn5oFJWDzL+w41VHuVmpwCF2Yie2wIilxr+ivXmQnudxxbwlpnGXBZ+oKLNZVzfiVCv3Op3I+Fa2Zk=@vger.kernel.org, AJvYcCWVYVq2AsxnqGi5WiGEftXbDUGwd53Rh4rUn38rFIY9RbEb92VatpF2ZZW1sOa6P0nmX//4NedRiBoFxQ==@vger.kernel.org, AJvYcCWVYgWmX0CEKzTQ/vvEd9KtE9fPYSHXM++797WBDO6ADjnTV6W8c3C/hT+0KwkO+ffbRdTAXP8zWIl3M40h@vger.kernel.org, AJvYcCXJ8HGSD/tnZGb8fliLL9DNCTTko501mWCKAANsvf+z2FR4+/ETrrpWPTeZGzhf3Gs1QiAw4/UW2xZo@vger.kernel.org, AJvYcCXqEDM9D9Om65UFRL+g/WZ2PwMC0dS+YFAWZz6gg9F8lzDI0sEfcCxPw38joiM9v4QV1+eDI1hWmj6M@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/t18TN8GSV2Juq3NSfE32CL0HMyu4M5z/u52+dt3/0mQxamS
	QGnV/52R1bjH79WJovdmPlHc6fDQOx5ExubOW6nG+JyiBovyz3lI
X-Gm-Gg: ASbGncurbgTsyZmGZRj0VPDvQLH/WM21g0/YOI+VPdKkCCEXp5/FfK31SVgsvBmgMIC
	WANs6d5x9tY6EfsePrnBxZRBjFXnoaajHXwvuPIpNWjDHePlj1wFRVWlwvn4ImZO5bS7bZjvB5L
	IYu6mjRTTYI6FKqqhrSh+rJCMuCulGFpJir6MD7f5kawOi92/cmZqkBtKGI/SSiOJ4G6zf0RUNu
	mZ1iH04U0nXByAE6VNrj+apmU3NYYfVLx+ky0gmepUIbbeDFERIuB1eYtA23+0O8ATymoca3DO+
	AvnfpW4PZ3xD2hIZytTUHLRjm8h+7rYsiYbziBagEMJVM90wFRI=
X-Google-Smtp-Source: AGHT+IGN7jQq3CGHj0RH91IeY9Q032+tQbArvaah7gKQeusMKWEMnoW/5Hlgr2n0AqqsWIEjFWFNPQ==
X-Received: by 2002:a05:6512:1596:b0:549:981b:169d with SMTP id 2adb3069b0e04-54acfa81f3emr851829e87.3.1742458942033;
        Thu, 20 Mar 2025 01:22:22 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864d7dsm2141832e87.130.2025.03.20.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:22:19 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:22:14 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v9 7/8] MAINTAINERS: Add IIO ADC helpers
Message-ID: <c81db29201f10b50f03971bc43fc6fc1c63ec4c8.1742457420.git.mazziesaccount@gmail.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LU4zmYhbxNu61z52"
Content-Disposition: inline
In-Reply-To: <cover.1742457420.git.mazziesaccount@gmail.com>


--LU4zmYhbxNu61z52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the IIO ADC helpers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D>
 - No changes
RFC v1 =3D> v2:
 - New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..5b96fb864227 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11208,6 +11208,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
=20
+IIO ADC HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/adc/industrialio-adc.c
+F:	include/linux/iio/adc-helpers.h
+
 IIO BACKEND FRAMEWORK
 M:	Nuno Sa <nuno.sa@analog.com>
 R:	Olivier Moysan <olivier.moysan@foss.st.com>
--=20
2.48.1


--LU4zmYhbxNu61z52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfb0DYACgkQeFA3/03a
ocVHKAf+MPHPcl8h0q9Jo2dudYpTD2nDzKrEj8KICCiF9YQvvTj6RSGXVd9Z6GuP
wYX9UYNaarCpcpiEwOh3jytWvUcVHt+9fxwz3Z4ObFLXUqHQTg4ymKwT2zOWUDYq
6ukaqXl+8NSVAoXVH4FbjfZsfiMWb3TeXdckgpEBCBIl9/rQIzf0X5V7H8RQke23
P0gNLTiQJI4H+OymLXMlNYIkVPaZ2JFwEuiP+ZHYyuJvOvj4MOKT7t5coSbcs0T6
JqoYlU/55pcjASW4oTUL7VhWMjnL0UXLJLRjLJjJwMs1/iZuwpKNXrTKKYewEts9
1tvceWn+PujhGuuNVmJTjoZH1mnJNA==
=oGui
-----END PGP SIGNATURE-----

--LU4zmYhbxNu61z52--

