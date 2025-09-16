Return-Path: <linux-iio+bounces-24171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3DB59BC7
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DF93BF667
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654F313267;
	Tue, 16 Sep 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fARFydGW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A63335BA6
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035474; cv=none; b=NNr9jc7OIf+5ArxYu8qrsag1HFzypIWTaVLlYBj2GLWdTwbSuh+0TpqCg5QK+g71c9uW+TN2tgcj7ZL2PYcu+Kh3umUhOw+RRT7WHEIHs/Eqf9JdY583Gy5AZz3HLc1npB2OP/Qk+V1FeJX3J9S2kWaC1MTXc3msQd703i6mLcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035474; c=relaxed/simple;
	bh=rmOaDep9iDvIkVV5SOO3btdvNEg4fjn3ZIsqxvgs9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTRPbHsS1xNn5HWdY9IXtGAyLDqyzCSydp93CQbWzLHvzGTlfjtjg/S0+lsHh3KJWRvlybRg+WqonwUxxpurof3HuJx063/V+wLb5f1ZxhoXrUNTmTndUOjkUVnW56xSV3Pl8f43dm9Lm8nkuy3o9Eb59pJ/EzKUpgzZe6YEgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fARFydGW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so38709315e9.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758035471; x=1758640271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmOaDep9iDvIkVV5SOO3btdvNEg4fjn3ZIsqxvgs9l0=;
        b=fARFydGWUDs3Y1yIu9PeJvgd9JeExzEDi0HEQ3gzKF7bRe7OC5iIjm8aeOVBS1lJ73
         k+stB81Cnwgt0KMjGGxj1F28HgeCc6wyYirwWIhI/CBqrGJevPQ9v5sMo6yCM4wyEhB7
         xBzhqVMyCwgpc6Tm9Nz7dtOVPIKwq7IyRRQDYrq2uvoGtklHivAzYuD0zz1uOBtCtk7i
         2uzEExAYgGUQTPx8LfDfjAUF6QxieX4CpS0Mrnt1ftjM+bb+mcfvRJaKFD/kCVD5yWcY
         W/JnSUvYy2vIOACce4BTthGLdKKjt4Nsyp/20TM8aZ/doWkpdpY9dTNc3KxcZrFSwUSO
         BW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035471; x=1758640271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmOaDep9iDvIkVV5SOO3btdvNEg4fjn3ZIsqxvgs9l0=;
        b=rmI9PnCUUPgtBKXM4VFUIpn5+OsSSN0XTxfaPpJAtVAyxkDgp51tCB36Aqe0LOMdHh
         tRdzN4RzIGLHS9HX7+0Bb0kXx7x5zYLPkwG9tN1qkWns7wZb/f5eriTCIWOsE4lQp+V7
         Z74kafva+VInFN1lR77ZdaP8ZWAHOPhoGaS0LCCGH1fSPBg0m6cCoXIfvHhxwo8ikYw1
         dr2Q1tLrDBV4gI5rWXu3HuzrpXhKAbO6dGJDxQjGl7xhsYziKXL7w60DYksW7Y8N4lC/
         wQzsGN91GmbzE1u2qiJeRIFHviS9zLz2zLPGeIDRAFcWB8JEdcSqOEg6ybDLW9jgIgsg
         P5hg==
X-Forwarded-Encrypted: i=1; AJvYcCVSb5rzlDrLZRaI5Tg6+BJJUWdK8A306sQqDlI4YGTT4L9ZksAQgxv8k+DSTDfuYXBD1l5dbDkv5kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyepZYTdCOxBPyDiRoS6A/qKFi+cKvkDtyDFZt3G1c04jqS22Xv
	GAPfz7ufmznfZq6cWP4mvbV5u42conCA1NWLX+j/fsKDlGZZ3bsDjrzF2B9m7mfkPng=
X-Gm-Gg: ASbGncu1lEE0X6Q57Bt4Yd/RW5WFQ3/ogvZkOQhYyQh6DBTju59cgfe6/prA6xH+JfR
	gvNfodz+pcbFekH95WTvRkM3HOYww1sq7k6SEtdxBMLq5hjkPEGe8Iaba+2Gr+/2qPIJ9NT391p
	KCugNg5uBCGl4fWwwtji9P70R4yJGl34t8XToHzeXC1BxpWRWsOovHnvpw3s1vZF7B+DqalSfAW
	24NAjGmQ7iOd4b6rm5yzEkUqYTWUhCkoHq8hn+N63WJJMxNIAio/oGOEPY5sm1CH+Rp4I5jE7ms
	yTz1ZrHlq6rKo0FXyEqdR96LoTEsF4nOJPFBWfSzeqR+G0hq1KCdKg6qdoTs49aSdoFSRD2E0yt
	7Qtc4COCWuRJJZh3WxrbfzyGRGhP0pfotiqc594W3DcLy3pI1XMGrrvbkaKp11/lu
X-Google-Smtp-Source: AGHT+IFjwopgYVPo6VKMtYSKedXcVrli8pwqzXpfa37U2o4471Lcz0KQL5QMmQQhJ8xqhKe1X6WGiQ==
X-Received: by 2002:a05:600c:1992:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-45f211c8437mr143544675e9.2.1758035470631;
        Tue, 16 Sep 2025 08:11:10 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e01578272sm241914915e9.9.2025.09.16.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:11:09 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:11:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cy5a22gjj6esxnjr"
Content-Disposition: inline
In-Reply-To: <aMlnp4x-1MUoModr@smile.fi.intel.com>


--cy5a22gjj6esxnjr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
MIME-Version: 1.0

On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regno wr=
ote:
>=20
> ...
>=20
> > > +MODULE_IMPORT_NS("SPMI");
> >=20
> > If it's exactly the files that #include <linux/spmi.h> should have that
> > namespace import, you can put the MODULE_IMPORT_NS into that header.
>=20
> Which makes anyone to import namespace even if they just want to use some=
 types
> out of the header.

Notice that I carefully formulated my suggestion to cope for this case.

> This is not good solution generally speaking. Also this will
> diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e. mak=
e it
> invisible that some of the code may become an abuser of the API just by s=
omeone
> include the header (for a reason or by a mistake).

Yeah, opinions differ. In my eyes it's quite elegant.

Best regards
Uwe

--cy5a22gjj6esxnjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjJfgkACgkQj4D7WH0S
/k5bVwgAg+5I7FGikPiLyM6nJF2xieob+ruwdkRFDohxfb7PQp4RA3i332VcbQXW
uPoXcpVKI3rBmxcqdXznCt5nec30ko8fgwZAb31BtOXwOf+VPlXIz5wDU5CdFQs+
35qgGyJnn48yhisyQx02GgDm/7esFho8zJOIaKvERuPGZ391HpLD4+z6Nxavy5JH
ZgxR7eIMcsnuF9vidUZhFi25abs7LFmJ72MF4i2N41OEdA/SMG9rpkEFBk5moBvK
qRRqVUDpCMxyDH6MddhP5CmgVUiW+3ucV17tdWKlnjjxMJx5rFb8BJD+jZx0Iuo+
HRtugRPqfdauF5Que8FvEqOdkDDLIw==
=R2qg
-----END PGP SIGNATURE-----

--cy5a22gjj6esxnjr--

