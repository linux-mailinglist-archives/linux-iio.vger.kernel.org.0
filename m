Return-Path: <linux-iio+bounces-15284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E75A2F4F6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 18:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D821889B04
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871624BD0B;
	Mon, 10 Feb 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YleC8u8Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05F1F4629
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207892; cv=none; b=ns7Zg95zXM3esQCC2StHsCdlaCLVFABqC1TS/8RtSYQ83c/8r6UwUJdAho5on6O7CwHdhVMjCfYhfp2O9JwVNX0aKJTm5XmAoqyJxoCZV3YTgkw5jMFZr1SHEqTPayA3sgf9a6/G3u2ydYXUQ8mRu7fQsCtLw8XQGn5rgAFNdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207892; c=relaxed/simple;
	bh=TNvVvDMtnBhkbb6djiuy2+Tcp3DRWNGcDElzA4KUyaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EalkOEoOF9Y56jSh8pPzjznAOQXWrScwFPVkVqboewIBKd7f0iiCGVDql7mPyEEzoL+iQkjVecNVrdmFAujB+VfIDWrpunxp2ejCgsxYIdHDWjov7B89UKiIO6x1pJ19BDBji9L3Djt8NfstzMe0hM69tmdZE7O/GqOsT/87sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YleC8u8Y; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ab7cb1154abso128173566b.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739207888; x=1739812688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+90ETqg4QGm+QbTFJyyG+TDYyYUSDmpdd3k7zXocpoA=;
        b=YleC8u8Yru8lIeyqOB04QUXIVBgWrxfEdEfIf0ZN1D4S8WhmWApBfe8qayDfMTeq5Z
         o2JCSXh5O7k+A3L/FGNmMNdW2eMKl40i4OorrjMUrtObdbybmZrrmBEmD4NH+Z9X+DLU
         9TTxDeOJxGYiPIfVkCpbpNe9GS85nAboKAP2YBs2ImO9ULdmPPzGrHuJ2Q1OClznk6oP
         VZ//RiW10I5PaIRaAd6/a5UDVgDeUkvciT0cL/HQF6WEJuiIie7AKwVqC+adC6kqNuSO
         Wx0YKQIUooeJvPdfYc7CyM1CsAWl5eOMGn9kZuKfPJ1EKwiryB7oem1xAPYSymqfVPgD
         W90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739207888; x=1739812688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+90ETqg4QGm+QbTFJyyG+TDYyYUSDmpdd3k7zXocpoA=;
        b=WLpR4LOkxq0yIe8gjFM7qZAyoqZVbJqo3t2yuEiZCrd8w03mkEx9gMhNX2Go0rI8A9
         5/rXEWj4uCNBvhh0svbxrNbrqY95HgF0zwWmYvzVLPh94Kah5bsy24uYLrLHHO0YFzbk
         A800ye8WZFSeiZcCqMvr84MZEW0emKkRHSMzmwIaPwQXpjyB3R9vjuYuxZCZOMTozfx2
         sCJZUIX/FdCC4I4OMgnB17Emd+JN1Bbtoar/mCuIE5anPvpPhGbY5ZRZ4Tym3dWR6pTW
         ELqaSYJVNyHJrvzG+GphIry6qD6lOQmEu4mIT/Bd9Z4negpB4kOIEWBcvGz1+BsBUxXU
         r33Q==
X-Gm-Message-State: AOJu0YxIpRqIJ9qaqLbdZ/ZGsx1w1wQPH9aaIEnwfl6DcJsBLVFJWH9Y
	YvUZwwGaqZVqNHPIvuYQbsR+RBsi609gbUorB3oz/2w6Im17uoqCNC2sCNvdGTxwIyirg8ZYuKW
	RAdmv5g==
X-Gm-Gg: ASbGnctzuS2SPyx/Y5KKY0muKYIO3++NRoMVcU9YhNtFx7cMoHm8aFTFx9X0YefVEst
	Ds4OwnQICMq+cr7z5QUBqZRPLFcn1vog3pxzxC0KJC56GTWqOdkhL79tWk5L4NsiTjpxrACuSY2
	pQ1GoGcuQQDlMBrxh8YAAOOoGL1FIXBGtEO+jCkfzeQPmlrVEa1WsoNxR7+fHQlM09sBQ8e9Z1M
	bDlVp/lvrS+JsZ552rBbG+nGVUHZdEkb7RHAT4oT4C6oIW0DmuvzrkkKM3XUcAtY0JRDB1/1ekY
	7PeWtcnzqU7xq9EljX86f2kKi3UIgqIA9MImLxelyuEsgpCjL47wYnYrAw==
X-Google-Smtp-Source: AGHT+IFSkc5CCWiveVrzDoUpYEk0a1KmIzui1+YLyRXN3QVAPVbP/mC9dsLMDeFoS9N0mJmMg/+qFw==
X-Received: by 2002:a05:6402:e83:b0:5dc:d8d2:e38f with SMTP id 4fb4d7f45d1cf-5de450839f3mr39108901a12.31.1739207887766;
        Mon, 10 Feb 2025 09:18:07 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm913347866b.143.2025.02.10.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:18:07 -0800 (PST)
Date: Mon, 10 Feb 2025 18:18:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: adc: ad7124: Really disable all channels at probe
 time
Message-ID: <ujesqicqo6h2kwqsizryvtu2f37ug3ckhy5y4mek4mf4rtke66@ifb3wnefkjcj>
References: <20250204115023.265813-2-u.kleine-koenig@baylibre.com>
 <20250208151824.6433a876@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fcze7psxeog4x4rz"
Content-Disposition: inline
In-Reply-To: <20250208151824.6433a876@jic23-huawei>


--fcze7psxeog4x4rz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: Really disable all channels at probe
 time
MIME-Version: 1.0

Hello Jonathan,

On Sat, Feb 08, 2025 at 03:18:24PM +0000, Jonathan Cameron wrote:
> On Tue,  4 Feb 2025 12:50:23 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > If one or more of the 16 channels are enabled and the driver is not
> > aware of that, unexpected things happen because different channels are
> > used than intended. To prevent that, all channels should be disabled at
> > probe time. In Commit 4be339af334c ("iio: adc: ad7124: Disable all
> > channels at probe time") I intended do that, however only the channels
> > that are potentially used by the driver and not all channels are
> > disabled since then. So disable all 16 channels and not only the used
> > ones.
> >=20
> > Also fix the same issue in the .disable_all() callback.
> >=20
> > Fixes: 4be339af334c ("iio: adc: ad7124: Disable all channels at probe t=
ime")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> I've applied this on the togreg branch of iio.git but you may need
> to do a manual backport of the fix to get it on 6.14 once that's
> released.

hmm,

	$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git to=
greg
	From https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio
	 * branch                      togreg     -> FETCH_HEAD

	$ git log --oneline v6.14-rc1..FETCH_HEAD -- drivers/iio/adc/ad7124.c
	cf67879bd428 iio: adc: ad7124: Micro-optimize channel disabling

the commit is not there. Did I understand something wrong?

Best regards
Uwe

--fcze7psxeog4x4rz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeqNMsACgkQj4D7WH0S
/k6zgAgAt7fMIgfYEfFiaS+iY6Z9rOQK4JVvMt3LWddG7gWakXEXRKSJ4TI46d9f
4hi2fTTAT5E56MMCIn0KSDnMqMDMeIXWg1PMCucKWqM2PET08OJ/Z8V4d2hUcuwy
FwU6Zctm5yF8t1+6OtCkeAFefeC3c2exIIQTCdJetAKMuW60uLViRpsEJJz/Bazl
bJ8elu7ib16euQnZy34whylwLggtUMNvBYrEX9S3fTZMbV6patwWALvqfvdHsXGx
v9hwUmIgcNEUwuSUD8d9ijBHBu6XnweiFqzZPiAV7WJgao7ORUlBl+UnQEsd6c4Y
zrJN75g9nZLT26t8zFNy0TBr62BBgg==
=r/YY
-----END PGP SIGNATURE-----

--fcze7psxeog4x4rz--

