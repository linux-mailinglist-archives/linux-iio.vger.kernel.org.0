Return-Path: <linux-iio+bounces-25462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F47C0DB7E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112EE3B3EE2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065023535E;
	Mon, 27 Oct 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdilJ13k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79E22F77B
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569415; cv=none; b=SELCO7KMmBsipnu/H0BhmrS3T3SsehfVoehVyrYAyYWbeUqSO6Z0nfh5+tvOXkervXq4y2WDsigbuUnJcSvF3tpcJcnKMiWjFPSuuACpmILxTsE6xhYsQ54aX3F12XXYaCmPgLxE6g+1RQqvoWYRE+RLLgBCQXdjoPNodEfL4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569415; c=relaxed/simple;
	bh=owXMmrUEulQkN2rVdVY6lyV7ab44pQVgz91FSsM7Eio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QREcukcNFwkTpstSFPZPrNFNPv/8xtuSYvkS8HruU5hicABJqBaizeazaBMJTKxOIsR0xa0EeOnqRaVOHn4gIhYn4triigMoBLEju7JpKUyMKdgtVZuumfbVD1pxAHAQRL7+z2r/jy2VmBCovKJmY2HdqfagDIBOk//4muolWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdilJ13k; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-592ee9a16adso7911048e87.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761569412; x=1762174212; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGLcTGux1kGK6VFWv3kDuODuaRdX7ioGDfZAgAbkDOA=;
        b=BdilJ13kLz8u6mn+ofF8A7UsmFRsEBLOX6VQkR7iavkJzRpKiVMYbVTVOvWXSEXjaJ
         ACucpnvZw6R+z1aYpEzZoGIvmz39e/lOIoxe1Eiz3LQJyhocOhYXygGmDpOU9ExVLmP6
         3jfu0ObCl1861cB5/+QoQOqLSPh0AOZUsMqaR75jRPxb0OuML2NKKQ/cBogutUCfClTl
         OWtCad4kGCwgi3WU7cT61Z2PppBRFPb2qEeoadrqTzFT2iWV6rJNOr/GsLKZPlnQ0ud0
         w5Msr2bDKxT6Wq5lSEI/2g/jOGW2KpbbyLxg8v8ZxPf4qhLGFVASyr0Ya8ZYurTqyk47
         6+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569412; x=1762174212;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGLcTGux1kGK6VFWv3kDuODuaRdX7ioGDfZAgAbkDOA=;
        b=HhBwGvux658P8DLuaowL7/i+1v3wpJXsvi6kJ1kAneGO/eKbrDhndpyujRwB91M9Cp
         yLXY90ulX2w4Md7wptSokCVljdaPkT9dIXSb+0ZBoaV/GdAkFCk7glPWDGk3OdjuE/Pz
         cQcRP7SlPx7aKMTt8xEimordL1u2eOg4OzokZnZAPkWSpcAyiwLOTMVq32Dty+eIhX+h
         WXjmihAWLmFwiu17AmAiEv9Ep65oJDvyYmPuX9ngkybFaLJdCiCOsiAL77ji2nmueJzq
         6IvihZlDDylTRaH2OqSLztcnBG5tuioCrKhCQXIX/3f2BgxCm3QdKjZzb1KwXO7Aamh6
         VdFw==
X-Forwarded-Encrypted: i=1; AJvYcCXNavu4/03LAP14y/8sF7Mc+Zglw2ZddfwxdtEdlxLErGpOvnU4GW/17hLUZ7lQhoqjRvR3Bti0vRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCQSgaODutjV5xl2pUwi8hgeq+Mu84uMpXYjLUIxk14SzQdT2
	3sNGGu13j2iFUIiEzai2y1rlVp8ZnLa7bnX7zJK71fIq4AfaEeRD0ql4
X-Gm-Gg: ASbGncu9xkxXw7MMUQ5ThVCyCSVTcKhA+T3KUgW0TzMziimohDsVqLjIFxK90qATNlC
	wkod0no5gh65OKdgs1B8eabb6+qppa8UpMA3Fg918bZ4OcP6HJ9LIcIdb2gAWTFviL0w0SvDqE6
	LX7ttM9VAxQpD2LC1HvxcwgARL21DlaDpnGWHO0mQN8IPioLyC4v8J4vxIi9FjVj/anbmsgf5/U
	H/R7E23UweEZeporOzhfFL7blpbUSLZjt/FRD2GiDpNmmUIUeZVfHbu/qxSgVunVMPXxk1s/5Yi
	zxT4dI43nE7kckjKHMEhDrl9PZLSX9C6hePvVV7A1/Sl8TGrv+NDzaCgFCAJetv3enKhftcX1V/
	vG+PoYJ3ZlrbduURctAYZEna8S4CXa/LL7U6EQZR1rWYpYl/bxBGQCxAnoowKff/KABScB3LrW2
	gTK98wU98=
X-Google-Smtp-Source: AGHT+IGP+TQYuhYnZerRm1alrcw337STtAJ2lCoFQRd7f1FQqiSzuno7UJBqjZ5UYTDXiT87Xmq4JQ==
X-Received: by 2002:a05:6512:3b27:b0:581:d8:a930 with SMTP id 2adb3069b0e04-591d85755dfmr12215972e87.52.1761569411934;
        Mon, 27 Oct 2025 05:50:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f68563sm2264179e87.67.2025.10.27.05.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:50:10 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:50:07 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: accel: rohm: use regmap_reg_range()
Message-ID: <cover.1761569177.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bffzJvZ3LHWNe2DG"
Content-Disposition: inline


--bffzJvZ3LHWNe2DG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use regmap_reg_range() when initializing regmap_range arrays

Clean-up couple of ROHM drivers which assign the reg_ranges directly.
This reduces couple of lines of code.

NOTE: Changes are compile-tested only.

---

Matti Vaittinen (2):
  iio: adc: rohm-bd79112: Use regmap_reg_range()
  iio: adc: rohm-bd79124: Use regmap_reg_range()

 drivers/iio/adc/rohm-bd79112.c | 13 ++++--------
 drivers/iio/adc/rohm-bd79124.c | 39 ++++++++--------------------------
 2 files changed, 13 insertions(+), 39 deletions(-)

--=20
2.51.0


--bffzJvZ3LHWNe2DG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/amwACgkQeFA3/03a
ocWtmQgAsMPzUfEy3bEHK5m1KsrSD3hzdQnnjlz4yKGzIdRBk9E9SjLfC1m4r2qu
vmw0tIO+R8jWAX3LbCaqj88mvJFaiCbFmjZM6EyfIheA4DjNL34HRizcMBqLR5Fh
V2Tq9kRv9kampBlozv4bLuaHNdTwXhvgEH/vzbilxiZPQJm+Ng8Ho6fyJgbz6zK7
Y0uKDY4OCdKlFcm7qDm6tES5SSGd5Ir5xAT+FKXIZVe88P0I2G0ZyznYlkkkPwVh
qEPUDrWbjH8OO6DXTcMzS3a5a59LbXKJlC5GBl6OsQm7IJa1983TRp580Fn+EmOM
Z2LEky/HL+7h/gLo9CyoujKsDn7bfQ==
=0V+h
-----END PGP SIGNATURE-----

--bffzJvZ3LHWNe2DG--

