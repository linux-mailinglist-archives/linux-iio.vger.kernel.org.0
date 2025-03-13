Return-Path: <linux-iio+bounces-16772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6487FA5ECC2
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3414616B998
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD61FCCF7;
	Thu, 13 Mar 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+cl27qf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A31FCCF6;
	Thu, 13 Mar 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850382; cv=none; b=Ez+qJykACE/Qu3I617T3lmUDtw2m8kZHC3Ltxj9nG1cGNwcviqdpKBZoLvSnyC2L81W+bFsCankYBJ4i2zhjRsvLTX6ypHHOnDG47ibEy/z27jx9lrL5iLu+ExVpjx3fyFvUaD82KowilpiY6456YuuQMsB3FxSzwJZ6QGtChfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850382; c=relaxed/simple;
	bh=n0SVsHyR6EoCcFAY2/LAsmGhJrUUQYSj8Chmf9am4lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRXrg/nID3ylYdLsXJnCX/fZvqXg7IFjfx99NylL0vWLPzLZZVxGAj5mpAft2MGKhLJ8L67WKQzbAx5giXmovoAWNP/N2Cw/V44QLnbFz9FjQdzudF1BhT7kSJU6K4Y1CHACErXWWSfxc+dhI+OWGjQ7dDrAMwyZDy11r2db8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+cl27qf; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so7069181fa.0;
        Thu, 13 Mar 2025 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850378; x=1742455178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sGRfKfkSMXdVNodt1qncjZLVCs8iVRcv5gAdLNHn/k=;
        b=O+cl27qfe09gAEKdJ5HT1iVFjnNiL3nEcyXSqjelAf9tJ64IgPWEJWdZcji3nPdldS
         +9zVZFD6REmyElDDhkTD4zK9/kFyvQEb28qLLglQ9uIvOWTA3mEIOb4yxPfojyFymNR4
         Q5jv2w+Wb6WmIzh9OUDYKbHZoW+bbGp/jwXTkr9Z7fbamyu1LevH4bdIw5hBlOzMfOqq
         wX3FMo9BIuzimRChHNa79DdL1+c4pgtR7KO9TUVUQg2CGqOIlTZBWaU/OEU9bkVFALUI
         2BGdFXrTSEScldvkZiAbSBqlpmhaqePd2W5EiKkkZNqCtR9MzEIxo2WQ+PW6dvSbgRLn
         CKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850378; x=1742455178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sGRfKfkSMXdVNodt1qncjZLVCs8iVRcv5gAdLNHn/k=;
        b=Hhw7lgmr40w3s9NZpGu4676bPfEK+iOnfptwrt4EEts5Q2Nv7rzeHaN8M2z/Jafgcu
         6Im8hXztmRL7o9659yrk/YevIpwDfw8OhNufSdl14SZB4JB56zj013rqfYzBt35W8DO+
         r9RHtSBdUYXaPj30keDtfAULpisrWshPfG/WZXLfFACzVVRfsbNlveii3/H0hsFB6/IR
         hpjJZ0gpk9wJcYU7bWojQLHWkUsxSNgMArxDnYVpvlCqGQhOMDvjoEtssyq97W2tduMm
         h+31vW8/88gnODTEGwIHmU8FqMCYAqhdgxhy2og4ezZeJpwxPwZJ0RF3gBml1EWHc3hN
         fvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYmYGHGn9H73fVtyOHtbEzmUJhoj+U09Hye9dFW+NDBXvkl5lxV1V7wK7WBpBGBcDMCETD0IHyOOE=@vger.kernel.org, AJvYcCXIGJF4bfp1qbxOtJdDWL1uf5vklO7TyIpZNFZn3IQFaxz5nTyR4Eo9ISpbPvzAAqdjN1DP9caui8BcN+OH@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxA1OaW7ov9tVQYhJxKUn1NS4oYAA9qbW1TxzVHVLkyUq7fjN
	u2SJgaL2XQmXKN0BpfB+mLLmk5K/LeGCmIlLk3EXfsrTv9f2UXMV
X-Gm-Gg: ASbGncu+VmGSJpst0uNsn2bp0SWfoATHUDClIQ/bPvTym/NKNtJSlqa0Y2zaWBxGWS3
	Q/55bls3Jd+ogiZrGNMg5ApfdjfHi2MmJlUd6wb2zTc7ZK9+5xD+We+6OqIFIeVivrsyq0Zmmj1
	9KAeJDdRbIZ8rmOoRtXDEa/Q5eAYdHDc+eCtQKU7KPSgSoBWTxnStBwLPMyOOpNzlsIxmJsVGII
	F1Pz+YrtY50DC6/erM0KWS7A1q6gqeJXbFLgMQOABUYBW9a1fTGF174/j0SA2tQunCgIAiTHvpX
	CA87teGRHEOon+vucbw6xR+yhBcsjHdhJlwpNPkoVm4SPrQkf1Y=
X-Google-Smtp-Source: AGHT+IGQybJME/eHLwFuV27tvE9BUSfRm63u84/I2lmI9Ho+q0jC6ylUarSomK4/MrCpR7FZdqAJjA==
X-Received: by 2002:a05:651c:1504:b0:30b:d0d5:1fee with SMTP id 38308e7fff4ca-30c20517ce9mr49485861fa.0.1741850378293;
        Thu, 13 Mar 2025 00:19:38 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d1df4sm1220641fa.5.2025.03.13.00.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:19:36 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:19:31 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v7 08/10] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <ad536f7172afe26191ffe53a79f476fe7f308617.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iIbLP7dRMJm7ztNJ"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--iIbLP7dRMJm7ztNJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D>
 - No changes
RFC v1 =3D> v2:
 - Drop MFD and pinmux drivers
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b96fb864227..2e4416b59930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20547,6 +20547,11 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
+ROHM BD79124 ADC / GPO IC
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/adc/rohm-bd79124.c
+
 ROHM BH1745 COLOUR SENSOR
 M:	Mudit Sharma <muditsharma.info@gmail.com>
 L:	linux-iio@vger.kernel.org
--=20
2.48.1


--iIbLP7dRMJm7ztNJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShwMACgkQeFA3/03a
ocU06QgAgdNvKYKZvtObcBtJwd35/z1TwFVNAaDnUXtFosVDStPPIBM8v1TDxJ/R
fcxaAPQ7TA12KWIoHQ1BCS+XI/FbmbX7YWJxmCb8Cmtvf9izmZqVtAmbR2hwK7b+
kALcbclH2OZ8mBLEMuRcptbu/JCw/BYZRB820JLrHlpP4sCFm3LG+7Q9b84ZnlCw
oq/mxZVgAzeR+xy/FC6/KCI0/TC6/bCnc3gjUestHfegsIGzLJKJtwSlHdy0mKoa
4WcNliTvCkUI5JTiNen7puMk4qYP0ENo12yqlrxt5ZkmH/r44NhGVN3C0ZQNf8bi
gLiC0J1/NjUI9ZV1cD9vpJCKoWV6cw==
=IRuL
-----END PGP SIGNATURE-----

--iIbLP7dRMJm7ztNJ--

