Return-Path: <linux-iio+bounces-16033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B8A42BAC
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582D63A89AD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4122826658C;
	Mon, 24 Feb 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUOACU9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC526657F;
	Mon, 24 Feb 2025 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422094; cv=none; b=TJO8LyTO7TpDNC1jJabKXYVIcaFEHF2dRubG5N1cCJKqVGuqjH0NMk7OgKXBZ6kHhyyIInU2duE2WYU3J9fxxZFBJ+q6fFOvPv0+/nR0iWrlN0JczwmoIvHid3/a8mqOpm0MOCgafpyuzCMJX/4bHOvBMUp7s5bHW+hOacOsyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422094; c=relaxed/simple;
	bh=4jFstp2yKjGUClc2MbKgYIcVr4Bcc0n/feD0l6rPrxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9NvRB7FR2l5zGKSkAvJG6Kd+zOpAywFhoIWToeJi7BGbeZsMtjTxw5QYf0Mluhcu44Jus89KvTkZTS7kBH/nmjHH0n/HoGaW8W+oPX7rGFtxT2XTfNLonyKdDji+eEjIMNBSHhyhF9RAecswPy5vW66pNk+vwOlX37E8eHLIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUOACU9p; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30761be8fcfso42647651fa.0;
        Mon, 24 Feb 2025 10:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422090; x=1741026890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIkYf97P4n3NLrtzlwokY4ULnxlvFjbpCf7nMOEO/04=;
        b=fUOACU9p8dywKTpB7TAhNInEn61U2dy7Fas+kC+LCRUNtWB9geZZTP07kscvQpz2bm
         C5gxE49iYtkbYlkTboRWwd0gbzXsOJRIspzJVhMNeeudZZummPxFPsqXRKZs9OnOY6Xa
         U1An7gKh2d/mRXJX4LiHxbrp0TvfQ31WAE/cZ7Bivt5Yj1B31wCdoCjUV8Gy7yhNWeHo
         mHjNZY7jE5ZJ2XBzBmrZZifien38Cfi4QmG9gK3frOJnbUwH99cAjQWhg1u99I3OEzTY
         QKOilYFGABeY/trqCo+161MGeJ6lf68ddcv34aeenRhc1djZYULVSGPxUEO1bx3Fqzi3
         V0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422090; x=1741026890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIkYf97P4n3NLrtzlwokY4ULnxlvFjbpCf7nMOEO/04=;
        b=SeQXETAXqF/IVYx85aKDgaA4DPq47s0D+aLYGVdNwGDbhRzxr7gUEYdKxp3ZHkfKie
         Kl24L77dxeabmVB3V7nv2v9Rc4ogH+7dgPLbhC48aI0Jy/Q4QE6PI/xSSJIOhe0nVTqG
         URB4zSErFoduFsUTd0GrnQpnC4tJzXhvZdQKmp2UpVBgI0rqJagLLO/ymYQ1UwIauf4p
         UZgmy4M2T1Uo0jqugCcnID8/mDQhZKLhFJHzmS670M8wYvwIKOajU0riPQ1n2nc33bL3
         dqdCUKVWUQNtnfi+NIbdnQVOwcrboMgStYolFvmtZaUVE3XjJWr9B7eYNUSTwlKrXEob
         32Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUUK171rodNrDny1jN/fqCjJpwhDp/5vkfZu7ryPpwo2/UaQ+nvg8ieitYuhawZBjP3Tp4CySoDNc2U@vger.kernel.org, AJvYcCVjs7SLTYwWf4TjO80IB8tawGzoV1l9J0/Da/ztDS6rxCuaXZjdWqmX/pnMtIFvoemjMKucSJwrtC07B2p3@vger.kernel.org, AJvYcCW5f5qV7j6gG5/xdNoIOoAGLYvezw8XT2kMOIIAYCiaOTG8Lw7+yNfpTCN3Ljz31J1GpW1013pzyaaAPw==@vger.kernel.org, AJvYcCWWh/QAUHll4J/jnJ1UIfH8gYOurzgPXDCZwC9sSmdlpr54ZTvRLVYnGeXomrH8pmNOn+F1rVp6F7dE@vger.kernel.org, AJvYcCX2ynzqKmydYCVe3bPxALSPXALskqdV8tRCRj3K9gPF251NzvZ3y9gTKa9wx1ui5qmo9BnqLu9p003Lo1Ae3ers0YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQKERffKPKvOep6v6JwxDs4r57w170mujq6yauES4njl6Jdpi
	pJ06mihfsLH4JnXmwKATg1nZzLq7HXwXPzB4+Y2Ltz/pcIdDW8Kw
X-Gm-Gg: ASbGnctSU3E6xfcTe7gQ6OkqWlJOkVOiJi25IJ0UpBeeOXQQZFxxdmUXTynZem5AsqB
	0IPqmZF6Qpv2Jf/wjTAjjX3E8gN6Dofht+wI1TKXOKEvr4CKgowi/0sB7+xiSXvRic8f4HVoCvZ
	5eXgKALFt3kwbDiY/jAIr75iW/qUmYCsD/+bMHnSl1fUc+ng8KBxNOL7Vgj57QDIGzgzwNE+aGB
	U0TpljS3pydUN7oDiK5CjDrCKf3dCzqN5YIqdvxM/xekkKl86PoV6ZidDieJh50ZpVOa+D3Y572
	KAxFb0Hha3SEojD8J6sG7K+jH0XAmVXK
X-Google-Smtp-Source: AGHT+IHlnu2JCoyY3lnko7RRFUdy6VX59uK9aMyzAe5hg6Irx/qYyxzQ9YwTyDI8XMZofmwi5dO6yA==
X-Received: by 2002:a2e:b8d1:0:b0:309:2627:8b04 with SMTP id 38308e7fff4ca-30a80c247d9mr1391031fa.9.1740422090039;
        Mon, 24 Feb 2025 10:34:50 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f4f4csm52781fa.61.2025.02.24.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:34:49 -0800 (PST)
Date: Mon, 24 Feb 2025 20:34:45 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
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
Subject: [PATCH v4 09/10] MAINTAINERS: Add IIO ADC helpers
Message-ID: <b062f5bda18027f0c0065f2188066857f8a7d573.1740421249.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="79e9OjSnaY+N0AU8"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--79e9OjSnaY+N0AU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the IIO ADC helpers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
RFC v1 =3D> v2:
 - New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..c1821fa8099b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11200,6 +11200,13 @@ L:	linux-media@vger.kernel.org
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


--79e9OjSnaY+N0AU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u8UACgkQeFA3/03a
ocW+9Af8DzpO7JQvFk19s1ybEKwla19U9LNwZ5BXpTh5F7Sbx9QSapqq4w5p3Ijx
n1Nbw7YsRZQbIYwgPxStUkCvZBpBDfJE13MTYfUxkOBeOGCVMAAnaCnfEkcxGh3Y
a925YCi71Zvym2z3CEYACgy3xnJJz9lcIVJJxGgd31r+SU/WLJOl1Pz4I0y4rGDU
H76m8ZBZD3J4TQXZ6Tv2pCGQLcHC+iwBBusM1gdSUiZLaPOSOBajG03Fs/WEF5VR
sQJ4h6TLnt9o4jAi6nWhACiOJCr7mRl5Qk9MtmA41fvdOtLbVLNusbAyBg/SxvHp
5gmIG9ti8cVRqLbOOZy1Ht2BGlxwdQ==
=2wGR
-----END PGP SIGNATURE-----

--79e9OjSnaY+N0AU8--

