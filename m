Return-Path: <linux-iio+bounces-17754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEA1A7DC5E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0095170D9F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C37237194;
	Mon,  7 Apr 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQTWw3xw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879F51C5A;
	Mon,  7 Apr 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025780; cv=none; b=AhjtC23Pnqetfv1fjstTANDvLpAT0+W8hdi+8Kjx6i2trHGLjM/17l+mtV/MP02JRkCoca3cL9idXA24uKOgWsw3mlFocKLgmh+L3/J1rN4kaIcIKgn9w03u8ytRaIYB+E3bE8Mb3m87Zt9/8tIxCNempkBX2gczqz+GZrtIKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025780; c=relaxed/simple;
	bh=MxYirPcg7T1+nJvqAKo/63KukNj0KJ4u8JdzTJzEO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRAxshx31USC77iyb0yw5m0lATfo9Fb6pvi8AtpwKqm5pVcTv2CzJaNqYQ3zs7QPohf1zsdwD+YIdzb2vGrV1Ado9Ly/7l1TA71nkvIxZkLhmL1oKWbLnn76DJBQylSH/Soj54scEer8o/jL5nlPDIOif8ZQ3i7vl9oODtNKMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQTWw3xw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54acc04516cso4869531e87.1;
        Mon, 07 Apr 2025 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025776; x=1744630576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6BeKUOweUvfpGj1ohccp8brekbwVQ7DsDFM2oFUjBw=;
        b=GQTWw3xwAbC6xCqWwEs/8EZriN2TOmS4MRIxnTrQti87IzqcHL/N9QA+8iD2W7lHQ6
         EEM73Yel6JxnnhSTLUsn+UeFCnjaEn5ATeTzXsIY1SN5OtNYonwF2G9EGP60sWvjKDRp
         2jGWw7HWOiEu4KNL7+I8mz/E21Wei2Xai2yrMApPB5Sxj3w1IS98qqRmsBn6p3RUwUci
         Z6IYKYyFkHvHa/7iqx9xlvCMWWJRY1nR45K6eHs1a5xTNVJ2aGrzC/rf21Jwq/jNxiSH
         hshcooiMLNMJh20ch9VzC9s3IuwQcfiCMZEJUOD+C7ROJN3EcA5qQ9V6Os3qmTzdWEaA
         j5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025776; x=1744630576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6BeKUOweUvfpGj1ohccp8brekbwVQ7DsDFM2oFUjBw=;
        b=T50/SPuPQ0SAf51Um7i7gwQop1EKDlfkP5AC83Wm6cON8oywkTWFYKsucwMgNQSDc2
         +0KU8o6/Zl8gi/SH68PWyJMCYo9aLciVIY2T/0LNK4FiMOWh7SMLYxW6ubiOIlPowOdz
         JtZ8MnZRxD7PYPB6yKXAdgh3ZJqbCHFZS95kLuZaE7nlJYt6uoRE9bpphH0zcGyZ7+Zk
         JCtYOXYC16PzQjj1VkM4ox2SVkcbM4in4xhKFh6bFKn0ARu+Jwd0ffNMMdWE71UO04zc
         gAL9J85Tp/39QINaoBz6iOJgozwBMg96nQUtOmH/P048t+GiWvsNoI1R08J7JBuOJ/nC
         wBtw==
X-Forwarded-Encrypted: i=1; AJvYcCUAF26nxx1S8Zgie3d8QRxmchEF4TolTjlnuLsqfP/CT1EKetbEd96NtS6SNnNvDPMbIjQbnVnB8rOW@vger.kernel.org, AJvYcCUHnKbtZS63p8TdkB0hoKQdTEjwD8SOfjfwBmPYOiPa5QcBRV3B1EtOTwrBz+icGpC+5FqUNg8IsdbDVY1D@vger.kernel.org, AJvYcCW3KD0NHkpY40AfSdWc+lC9p02520gMV8DSiIUU+Lv5CIANMEtJWsELd5CI2rjKZ39JChi1hfypF+yv@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmhEz2ZQ6OImRF4aM608KCXipFHuT2q6iwbyhYow3p6xJYlpK
	l9bRZ5gcQC4VsKkIkvmcdrM2G53He14DvI5mPrHiPCPoK4y6tXtj
X-Gm-Gg: ASbGnctQsB9D7L7+BhzkMVtTlzrRh3X23aJ009ybrCxLjDhh1ybLmWdW7y9ZZseqQe1
	SFD4pxykltmCLWHuInw/+Zhp6l2vbjGdd8ArC3LpcryfJKRJWYZrlqzk2mnuaSu3ads1hYNXQPl
	AwOUT619/sDU3KeiBnbavAsbZJAMCa/Y1uPna/WALC3j4eF2tyla+ctaAk8Rzv8CWlH3pLDS7VR
	9tNd+tP/a9SgmFcAS7lk6qnL2RkYnmLelDqTMsKyk4E45a1+YPE1VjcuSRllh1kHfn3CJQKQmBo
	RFHGi8Jmtw2jrCY07ZvejNgcUje2nfs1DtS4C1C0z2dyyN5oD6k=
X-Google-Smtp-Source: AGHT+IGj31lRuBREjFo3rRZxA4ScwO5XxI8BkCbuvTyHaUbHVOvi9He1bWiKVn8f8CwfuRWSMSx2FQ==
X-Received: by 2002:a05:6512:b10:b0:549:8ebe:b3c8 with SMTP id 2adb3069b0e04-54c297b796cmr2130691e87.11.1744025775960;
        Mon, 07 Apr 2025 04:36:15 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e6370ebsm1198490e87.130.2025.04.07.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:36:15 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:36:11 +0300
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
Subject: [PATCH v3 3/8] iio: adc: ti-adc128s052: Be consistent with arrays
Message-ID: <bb58002accc696bd4a8fbbab37100c6fa0c29941.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VsehE080HpBA2KA1"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--VsehE080HpBA2KA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ti-adc128s052 driver has NULL terminated ID arrays for the
of_device_id, spi_device_id and acpi_device_id. All of these are
terminated by having an empty string as the last member of an array.
Only the of_device_id array uses the /* sentinel */ comment.

It's better to be consistent.

This /* sentinel */ comment serves no real purpose these days as people
are used to seeing these ID lists terminated with an empty array
element.

Drop the /* sentinel */ from the of_device_id.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v2 =3D>
 - No changes
v1 =3D> v2:
 - Drop the comma from the end of the of_device_id list.
---
 drivers/iio/adc/ti-adc128s052.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index c5b2374322e4..d0702d403fbe 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -185,7 +185,7 @@ static const struct of_device_id adc128_of_match[] =3D {
 	{ .compatible =3D "ti,adc124s021", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
=20
--=20
2.49.0


--VsehE080HpBA2KA1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzuKsACgkQeFA3/03a
ocWO4ggAxZ/4Se5xlbg4oXp/F4/kU3H8C79ZFifTb1LZHFjjFxRxi0w36fgHS85D
PS9q9bSe3kT9LKhLN5tomLuXEgkQkyO+sh0IUTuVhMWwI1izf31lOrLt2QHCHtK1
OSbiLw/Y1UxlemQGOnnfwOjCYIs40rYDNHwEUByJK18IJRf50iZv0g6/BuQliomo
Gm/Bkf1NKz0C+Efs6OxFE1H7Bn563C1X1nTJz9hh7c7FpjUVmZmd34xvwCLAo+et
l0UGESOtkSv09ppPAU4AGyq1f070qLnXzagOJFDu6KImzk5XIQPXYWW/TW/SDqNz
XP+M2S0b4R/DUYG4TzpIbnS+ZO+SLA==
=hlny
-----END PGP SIGNATURE-----

--VsehE080HpBA2KA1--

