Return-Path: <linux-iio+bounces-25828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4A3C2AB7C
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EFB3B4F44
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF442EA151;
	Mon,  3 Nov 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KgOoiL/3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0C2E9EDA
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161906; cv=none; b=PHDlLGyHDe792mbIIJOU79A2XB+cgRjeSoWWheCK8ETjfOQj7S7tp79XM8qJZvU/eyrg9J+4mc4lJFEsplprRgQFnl4d+S4A8998ZQyDHYlK8/zNmO1uHSZY+9dnAfSB4gLWcfZWE/3dACKxpyT9S4/bDeo8taNIIte1jb4O2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161906; c=relaxed/simple;
	bh=J8wpUcNN6eKIe2BNft5mcvC6Lwm7D6CpSo7ypNdqnRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evXp8fFMluY92i4B9cSWsiaM/0Qvpi5wKi+5zgBxUYHF1u62abN0plLUdjePcYoAifGo2Q6VzV1gHtUAziNd7XwfGyrWBY6Ofrn7QBOtPpu5UnSXAbx1h5ACsOa7mTl/vpwhoe6JUsAtGdGx5NskKo80oF3f1kIFhxOeqzHttrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KgOoiL/3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so485842a12.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762161902; x=1762766702; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8wpUcNN6eKIe2BNft5mcvC6Lwm7D6CpSo7ypNdqnRg=;
        b=KgOoiL/38Rtc+gBugYUplM6MQImn/eksHW+v/7hDUGOdNaqbui3Zibgq6fuSrhxWsX
         5f27zsZJaevPOgMQFFOuH39EXGDOQed7O5WIJfkgs7vCsB8oqIzUeM2RDlRbw4HZkjCh
         GQ1NE1AxHA8gtomYJsZTV5id+0K8kKZQzUySeEh7AjXwcMfhnKf972K/wzryOxp118kK
         7hBndlOoG7u7BSZsY/fy1I7XK22rw5ab1tRPZyiRB6THvJipbkoiJRgPNhA+ST5zWaEW
         89PsnG8ZfDdJFVHhhtZnZoEvbhKM7GN8/k+XT9MxvbjlEeS/1g7B+GDHJ3272RiDJh9r
         4+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762161902; x=1762766702;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8wpUcNN6eKIe2BNft5mcvC6Lwm7D6CpSo7ypNdqnRg=;
        b=TdJsaL/9IDdgI59Q+EEsrfG2SwP8kayyvmona7aqULmz7oADvy4jnp0j4zpe+D7ZQn
         9WaAZnqzD2CRMwM5vfq/jBslbWclHZW+9ParoNJYRPaPoPbBxxhXFI7L1Xbi+ce6DnbM
         eQ2hyrA2JdSLEhbwM6HotSGiNCg/77pjcG8AoZUuYAtFXi3NXPSd5UsW7dl/wS1m5Lxc
         c7dbgudWY4w6NXDbg4AfImtut8NPfeQxt9CBWvat1eSYWxq0rive3aziz1GVUAX+0JGi
         OeUD3m3WroTRlfesymmNcYWXFtrHAHgqfAzYpPCycTXMEVSbIUoiUvPFUnTWurAtH+mh
         Tzyg==
X-Forwarded-Encrypted: i=1; AJvYcCW/DNKpVluulG2xF0zW2c3g0V8Xsn9VZRkUBP/MvF1fzmaHXqUqYeZkUZJXKIpHtTjJM+CxaXlKd8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSd/QL4K3KPSnJrrhSqkAAetBLOBXC4TnKiZWdTlIldrD4PKh
	b60dywB3tTeWKd3e0+PSQhftRhCgEOstTXV39C0rYKo4QJxHoAo5gP+qZhb7o43BdMs=
X-Gm-Gg: ASbGncvLwnI0DVdDhtbiBb15ggSlAIKVx+gXFTtkHwh1QGNUQTuu3ZlVxhJQijr23wr
	fWkEg7xyGVFhMvWXp/3+m/ymuAp6D6gyaIAW/7TVpI1wXDH+XhIGWTAut2d5li0TrZPWCQImIX3
	0Y26A45OdU5yoxIU4LSk4rT794vJs24Fq0vQTNr8cTC+Z3bZ/GAoieQC8mFkhFnthOIgWdtqJ5L
	q7B+8y3dcnrtYRY1uD7FOFH5wZydyQDSHkx+CkzN0M9Gqy6jxp4lTq0qTbwIxBU6sE7OO/HLC9K
	VrYhPxP4GibN1/iRQwT+IniZwCxOCGNV6qJzTnxDxg7VoMFxXqBoSSIyEfa/gzYOlFDGPhsPY9j
	AkODg0EWNCg3IkTt6iVnUeyPFfB32ceX/WXL5S7n0Q8uVP277zgF8/WDzU5UYdCWRk+CvPLi2gW
	0HKNPi9/jfv1ws9SpiB5Zge0lnpdm+0zC6czyDeJxgptx4CaoyPg==
X-Google-Smtp-Source: AGHT+IH5hULo+8FDQ2WYcjV+y6dq0RuxLkwQQ2iO35o/+oBwlQsLx4u0zvThA0iUaycg5B4WYA5Ppw==
X-Received: by 2002:a05:6402:2750:b0:63c:683c:f9d2 with SMTP id 4fb4d7f45d1cf-64076f78d17mr10299643a12.12.1762161901830;
        Mon, 03 Nov 2025 01:25:01 -0800 (PST)
Received: from [10.203.83.103] (mob-176-247-82-42.net.vodafone.it. [176.247.82.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64094ec0921sm6848587a12.11.2025.11.03.01.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:25:01 -0800 (PST)
Message-ID: <87f68357d52fe6406bab42d5bfb41e4addd9d301.camel@baylibre.com>
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 03 Nov 2025 10:24:54 +0100
In-Reply-To: <20251102111648.73422267@jic23-huawei>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-2-flavra@baylibre.com>
	 <20251102111648.73422267@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MnvrRlCym1HWP7zf9aXq"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-MnvrRlCym1HWP7zf9aXq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-11-02 at 11:16 +0000, Jonathan Cameron wrote:
> On Thu, 30 Oct 2025 08:27:44 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> > for the iio_chan_spec struct arrays makes all sensors advertise
> > channel event capabilities regardless of whether they actually
> > support event generation. And if userspace tries to configure
> > accelerometer wakeup events on a sensor device that does not
> > support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> > a NULL pointer when trying to write to the wakeup register.
> > Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> > ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> > initialization of struct iio_chan_spec arrays, where the
> > st_lsm6dsx_event structure is only used for sensors that support
> > wakeup events; besides fixing the above bug, this serves as a
> > preliminary step for adding support for more event types.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20
> In cases where there are only a small number of options for what the
> channel
> arrays should contain, my normal preference would be more data over
> moving
> the complexity into code.=C2=A0 That is have two struct iio_chan_spec arr=
ays
> and
> pick between them based on availability of the interrupt.
>=20
> I haven't checked the whole series yet, but how many channel arrays
> would we need to support the features you are introducing here? That is
> how many different combinations exist in the supported chips?

In the current code there are 3 struct iio_chan_spec arrays; we would need
one more to fix the above bug, and one more to add tap event support; so a
total of 5 arrays (each of length 4).
As for struct iio_event_spec, the current code has one array (of length 1),
and to add tap event support we would need another array (of length 2).

--=-MnvrRlCym1HWP7zf9aXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkIdOYACgkQ7fE7c86U
Nl+o0Qv+L1+kfzgrRneLLXOc6I57yrBmlGbdoXM7PhnsMsoM78a2fFO+EYxJFd03
HFVM63v6jyl14NDLXiY5YX3XoaMDCdafqimlBYX5EbqBBXzALeyLjAd5ZYwDBfc/
YBdFYRwKAOxwbSN/nLB1nqbNf3vpzU+mZRArVLz/AeyQQXAgpPmKXee4HzXb0nko
af7ywKzE31Y6XznU7887dRt9HyuGqzE1qzb5CBEZqjaULhCHzpqIpdMnlVpMwFjD
87Ff1q69NuNiJW153aakIYHQaZFd+olGvAWZChmaUlNCEsUpzf/sySDdiz2GVnrR
zZ5GP+a6/njT7AJtKCsYbrqmECMR5NsErlHDCAkanTUvuAtoR8p7EXrunHDpleKk
5lhli1jyQNRTsdskptXSJ8PdSogB0noRrIe/E4EAOjHS/bQ4UuIxt18nLSE5KKJI
pHj04/HaNglVynOq/uYuzfkDAkfOei/20P3RpFJHhuBDIdIx+doSmyGlOOpMIy+0
u0RTrkCu
=ZdQR
-----END PGP SIGNATURE-----

--=-MnvrRlCym1HWP7zf9aXq--

