Return-Path: <linux-iio+bounces-24947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A889DBD0271
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BC43B95A0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B591272E61;
	Sun, 12 Oct 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PK5ameuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3A239E81
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760273243; cv=none; b=XcLx/LIsNX52KqW7RjOhl7PSYWgMkeQdIl6hRXsFbRC2jJPO46eLc0QOCOQqdSO60+t+3BpfILf6wcWniT6kV7d2kC7OlXfsxsvSJdtGH68eYKjUcYMyFKGOtCoF9UGNr0Te1EDm9TUunNim0W3AQetaSSIv/OGiXKNCSPLuje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760273243; c=relaxed/simple;
	bh=CBBYnJpjOU4vyevnhDhjveUxsy0q7jAyMChntHTAues=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W99+eGqJ+UViKkPGiR4fqHbodXbyelxm2VDZRbieJG1ihcnnmHYMO1nja0SbVIPWLJKptOTBVd8O9Zq0Mo4LktQxWyZQ7Hlf5/ghOlG6RhrHby9394SpPPJjm4IeOwKgNAJIurJqJSvWRxvQam958N4aWHYgVMXrMEgjYicfma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PK5ameuj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6394b4ff908so6798759a12.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760273239; x=1760878039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhkPjWye0v/CRg6Sux+Zj23A52ehYTsrcw/cUMPqez0=;
        b=PK5ameujmujMbxqQ6De3wHRBKSHMypl381w7sTUTR1skq0II1+36/YOw36lQqnFAkT
         /XcHUZZOEA48yOS46veRxoM5YgYF3xHc5PnKlrwNwxYnwJP8P2invy4C2yAKg4uYjgiB
         XDljXNaWq7pKBL49ptnBos2UrfRqwN1Tt6/xMz6MBDivvcr5jsUHxmPyf8Fk/ZgcHybw
         K2YXQ450DbPGvwo0pAHw4DbSsHGvIffHGmKBKMiI0dLBi/fMbuZCEmGy4qxUrrt750wF
         72fOmXOfrfWLUipB/iMP98Xs5uo/mVYwmXj0I1OX8Au7boZ3Nc8bdKvbkinUnTUhUshA
         +qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760273239; x=1760878039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhkPjWye0v/CRg6Sux+Zj23A52ehYTsrcw/cUMPqez0=;
        b=WjbceO1Skwi5UrhZ8ouZX6HyVzIyEo2/WkkECrIVTUOTXL2Ax+HKhwwHMMpuVzkltq
         KrNGpul7N68eis+sgQ5Hz/9rIXf46e5FcPIMlc5NRaLhvbVbS2Ga0dCy3KpO8jJo0HVY
         3vlKzro+Kfd5z/ill6ydm4pZWWktlQc8zU9vkvaB9Nlzp4IVQ+ky1Z9vlC2n00hG7ohi
         R9yet152jeuaHHj9EuEuL9+wOirKT6Z8AStNo+0mGXdP8zgSl3UgQXxD66hIQQsnp20z
         7bAS/tW03ugBL4LJo9/AoFxjNOgVBGiL2ASOZVZk61oGYAAoDw/xIEF/CovDh3XfcRT9
         RFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcnosIEtAf9iaSV6OWsCZ3zvIsoCkUhlJXGPwVpN1U6QW7kW3e5Y9Jhy0Gdly8o4Vw6RnxBEh3dv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhoMctUffc+Bp81gmVu4KwQlJBgsUxQlfQYHKeI7lNaBGv10rk
	rj3N9yvN2l+EBfol6US/GKuBKk4MlCqmiGmJY7aOU5b1hntCUwPzaeupZ4WZAbH0nn8=
X-Gm-Gg: ASbGncsW6uUp9Lugp4Wjt64qO663yn5MhzvMEY0wZ1tOU3r72tY1w1KBm0Eb4WKPweB
	V75ABNZquAzu9NzLSWT9Di8BwTsaraUIB21p2rB0ctYc0YA0/wHEu9q/JW0netE0YH2CotUe/ji
	ourzissgD9bIG73SdSKL5f567HvNqfmzEI8qc8X36qQNIvte13bsqN44xSz82hV/+fQ76ybiZfW
	YxDr4UwlhMO4Xs7Jvp8L4I8SoOr7E3dIwa9zwVycMMQikaQ3bq+v82mkkqHQWXsEJLXkb/oGBk7
	dbl16RpJDqYObK7+u2x2xQr2Jb5hSzquhoyPdtfZCwLRu7FRiLYXKvS/MfvS4BuyJ65Ao8bNdM9
	7ONZOFmffluuZtN5mBVDS1JY4mUGFoaajpYRzvu24rZG/6g==
X-Google-Smtp-Source: AGHT+IG3Lin9fp5Y+TvdZgmG3Cp7Bgv9FLi+0botQEgTHu/FgzwkhVJoMv/Si/w+XlinrToToa/q1A==
X-Received: by 2002:a05:6402:5205:b0:634:5297:e3bc with SMTP id 4fb4d7f45d1cf-639d5b5e42bmr17124135a12.6.1760273238733;
        Sun, 12 Oct 2025 05:47:18 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63a52b1d644sm6951247a12.17.2025.10.12.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 05:47:17 -0700 (PDT)
Date: Sun, 12 Oct 2025 14:47:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>
Subject: Re: [PATCH v2] iio: adc: ad7124: fix temperature channel
Message-ID: <l6bq6yqq6iqac3jlnwhzpymbne5e2ulkupl544qlyot3po546g@5seccwwkxrns>
References: <20251010-iio-adc-ad7124-fix-temperature-channel-v2-1-b51b411faf36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="grh6t46vmthgfam7"
Content-Disposition: inline
In-Reply-To: <20251010-iio-adc-ad7124-fix-temperature-channel-v2-1-b51b411faf36@baylibre.com>


--grh6t46vmthgfam7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] iio: adc: ad7124: fix temperature channel
MIME-Version: 1.0

Hello David,

On Fri, Oct 10, 2025 at 03:24:31PM -0500, David Lechner wrote:
> Fix temperature channel not working due to gain and offset not being
> initialized.  For channels other than the voltage ones calibration is
> skipped (which is OK).  However that results in the calibration register
> values tracked in st->channels[i].cfg all being zero.  These zeros are
> later written to hardware before a measurement is made which caused the
> raw temperature readings to be always 8388608 (0x800000).
>=20
> To fix it, we just make sure the gain and offset values are set to the
> default values and still return early without doing an internal
> calibration.
>=20
> While here, add a comment explaining why we don't bother calibrating
> the temperature channel.
>=20
> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at=
 probe time")
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Improved commit message.
> - Expanded code comment.

I like both improvements, thanks!

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

--grh6t46vmthgfam7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjro04ACgkQj4D7WH0S
/k5Xfwf9HrjoGT+YGLNrvWcqiZQXyCzR+q/R7M/WDAese1yLBIs8Db7Sxje8cv0e
RHv0Xbkp9i7iIIQo9Jy2ObgS+gTDae+c1HLzGnU8J9IC4/Zyavxo/pNy/lme0C1V
4N5pDxB8vlUkh65VSvQy6JIDY9HBS/gtyNg7mrhPEZPmq7Q2J7Tm+c4HoQV0LJik
hhUX0qxv/HJCZgtEeBXkeaCzE5jx4T4RXXXm6E84HgjtLqFSvdI/4gFAy1e7A41W
/KpBFjGq9aB1gfhESiBLW9gqyjx3LDUcVWFMloeWipcXmC+1SOC3rsn6Nt8VmN5J
dmSHh+W+6EFSyY+yA7osqMvevuj9nA==
=PFQ1
-----END PGP SIGNATURE-----

--grh6t46vmthgfam7--

