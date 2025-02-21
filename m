Return-Path: <linux-iio+bounces-15921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49319A3FEA9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 19:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6946E179D17
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095D2512DC;
	Fri, 21 Feb 2025 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bAOhibSY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C61FBCB1
	for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162201; cv=none; b=GIelgVzd0Tf6zZmpK3vBY0xpnUQMsno9C6ZtAHriaMY/SYNGkBr6jOTn4yUAz6xHQqgYo6qsGRc3kUbrl/rW79bwAC82AHLX5Hno7MJNLK1/H95bWP7A+V580iBgqYxa3oFJsquqM8MaLjhT0r2jerWDvBrbDrpO1YYjyAZXNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162201; c=relaxed/simple;
	bh=5Sstzqulzxx1Xgtw+JSHLfqp4G1czlx6w0BBxZdkSMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRBqLRq9egQpLxCrtyo3Wz5hquTYDpT+cqP9kQzkvwkHyOEYTIYUG3oCOUfHZxPm6a/Dm7o4cT9zVlmMO2JpSuBydpRPerF8VicWDv6qacIZWZsLCxg4njPeGnX2SEYs3VRwY2FvNzY+DTzmU0m3vQTIusj6fK0Eb4uVdfnE7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bAOhibSY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4399deda38cso15111365e9.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2025 10:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740162197; x=1740766997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=th8yrxkMThU769WhjFxHrdz9XTdkTJGT+KOp7C8Zlhc=;
        b=bAOhibSY2MIBEmkhUWxp5GtRyBIOayT7DurInC7eNeLBi98MmvkWl2EWZMmqIH5FtJ
         OBLeK6KuRJDF65qoCz/3gtP1eCEaK/hhJw0KOj8MH8VmbHCTD1YsimFSwhd0lL7kxhOj
         LCaJphPgPblb0dlsCwtuIqER6YU5AuPQXJTVRl+sMFNFVhENRPYJO6N6LByUpZ5TCcKE
         3lrExO+d6FIT1NXNR9qLBKYcZf4aAQ3IrV7SBaLB/lU2tHUlEr1S6EwH0f12kiBdC87s
         hyTPuRjf6rt73dutd+beA4tDKi8Sfx50JWO3+IePhW0LzynFDmsqm0HQdkpIjKOMQ4X4
         +Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162197; x=1740766997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th8yrxkMThU769WhjFxHrdz9XTdkTJGT+KOp7C8Zlhc=;
        b=LB2FbYTp6oaG5VOx/nlhikq/RTOy4wNefKERpfQpRSnO1LQVBpklPtU1ekplZOzsv+
         Wy+8IV9lgmy9n8cy7+MJlpad6mBXRQ3o8yQgItAreGtspQSscQnGPGg5MVc9xEHEYTxv
         yid+8v5cjAWQgWHh0cJBxc+DqXk0UYiSaWf9qw5zVDKcKoUYZDzBlt4pDwJZQFKLoEuy
         0hB8ewSeBwL3cEjalVQ37i2DCpSTY//ELuk7SA7YGrN5L8J7Z30L/JtOt5Honp6grF8x
         0puGcM5CpFqA3sR80jJQuO+s9PUyMFYinLjRKqjW3SUi/8wrdaFuf25qbYaFsjfjBLBP
         8NGg==
X-Forwarded-Encrypted: i=1; AJvYcCWPey8XFHGVSk0a0EY5PvZ2r1jBHVaTIwZGnx3izhsGikxRn5CRsdwgguOV81K8yco53n+1kZY3KnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxli7iUYFGLUWb0kwtK6o2Ke4MKyQFItB5EOKICEtKS+FsZu60G
	+A7sFxXAO2hNx/PT7s8BA5kLC/HDFCvOSOxShKIpHo4zuYYtep6FVXWY/pfSCGmO1h30pE7epdt
	I
X-Gm-Gg: ASbGnctVN7vbuoEzFtzs6odbNSwS8GWRVucBsLK4Hw8s3NcURXAJ/nzBNP/W+ZgFvBc
	IRF+VKT9VmxCUQpqWMTdxsYu5FgLc2vV4llB8+jZq2TgTtPqV9nXurU/vr8nv6bc/3j0f95q+Py
	k/y4rQTnz6iVwJNjt1TePixGc260qbwFdQgA0C+1O33AUjqMdIy7b3wk9el45VBxqNIpu8s0DgT
	h0/TRr/qAUZ84b2SW/e5a1/BdFUZ15R4xRRvKWoZWMjhS5YzuIrjUWdi25/7chlYnQ9t6PFoPsz
	AumK4rP4V48o8lVCTjfnJGG4cy8uFMWIkL0UHLbPlmePoYZ2NCZ44b++33+z2j3FnnY6
X-Google-Smtp-Source: AGHT+IEEv9jJoOqK4wU/WLY5aJb4MUk8hee1zG2GF9Mz7v921Nw5FUH2tmhLwPyMSNB7LzcGEXhc0w==
X-Received: by 2002:a05:600c:4688:b0:439:9ac3:a8b3 with SMTP id 5b1f17b1804b1-439ae1f2f7bmr39021375e9.18.1740162197079;
        Fri, 21 Feb 2025 10:23:17 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce4e9sm25246275e9.4.2025.02.21.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:23:16 -0800 (PST)
Date: Fri, 21 Feb 2025 19:23:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: adc: ad7124: Implement system calibration
Message-ID: <u4jzabqmlzkfonite46s47kux2wvqkzvmn7plzfjytvk5zlc7n@uvafd2iv3vog>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
 <5ee955a72e6f5226233053a883e8897ae325b568.1739902968.git.u.kleine-koenig@baylibre.com>
 <f3f074fb-312c-4f40-818a-05de28b229eb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2wz2le7tw7r4bfak"
Content-Disposition: inline
In-Reply-To: <f3f074fb-312c-4f40-818a-05de28b229eb@baylibre.com>


--2wz2le7tw7r4bfak
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/6] iio: adc: ad7124: Implement system calibration
MIME-Version: 1.0

Hello,

On Tue, Feb 18, 2025 at 01:37:45PM -0600, David Lechner wrote:
> On 2/18/25 12:31 PM, Uwe Kleine-K=F6nig wrote:
> ...
> > +	mode =3D ch->syscalib_mode;
> > +	if (sys_calib) {
>=20
> Could save some indent by inverting the if and doing early return.

ack.

> > +		if (mode =3D=3D AD7124_SYSCALIB_ZERO_SCALE) {
>=20
> Probably should claim direct mode here to prevent calibration during
> a buffered read or other operation (this seems to be missing from
> other ad_sigma_delta driver calibrations functions as well).

I think the right path forward would be to claim direct mode in
ad_sd_calibrate(). A difficulty is that ad7192_write_raw() and
ad7793_write_raw() call this calibration functions while having claimed
direct mode. I wonder if it's expected that the driver automatically
recalibrates the channel(s) when the parameters change? In that case
we'd need also a variant of ad_sd_calibrate() that doesn't claim direct
mode. Anyhow, that looks like an additional thing that probably should
be unified?!

Best regards
Uwe

--2wz2le7tw7r4bfak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme4xI4ACgkQj4D7WH0S
/k7UXwf/asCpOGYC1bRb5zWl2zHeBan2pAXhK7eme4JPYE3CO/e0qs6baL0C7wEf
HYQQWMZIEPlpjPI9dFCZU53a8kWUdm6KVLyOhq+mbnQpdK/3JwTlyrYWyFFhLKXD
SxIyASm25vp1U35Aq/Uu9rKyE8vhcSumTKz/opOZZVossXjiLJIWVIV8EwCEKgVa
X1v6lEoEshjZKTPZGMfeJQInuoSnSBzKlMXAm4t6Yjk3PviQNNwPHjOVI5NXeKKb
7xyrSisBSwG8bJg88MTYilsmdJLVCsbUY3Xr6Sa+LOwZoHNX8huwgXJTo1QOMr5R
n/kEYiANKezBiRewWj3yAmO8T6+9aA==
=6Zhd
-----END PGP SIGNATURE-----

--2wz2le7tw7r4bfak--

