Return-Path: <linux-iio+bounces-4990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E38C385F
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 22:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7399E281A9A
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 20:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064AF1EB2C;
	Sun, 12 May 2024 20:44:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565B1E502
	for <linux-iio@vger.kernel.org>; Sun, 12 May 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715546657; cv=none; b=FE+WcuOzQSs5U1ol+My2XubUk9xM1sRKbxkf+38m0BJaVlMEbabbBhmFMftT5GbhOSNPq9DPIZ/UzqpX+lY08ZJrGuJG5o5DNiwFT2CSWA+4KCp45LckkkJmIAP3FtiU4JE0OT+oP2V/N3bYdZQpiEqldW4FiQBrRO7MYinsVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715546657; c=relaxed/simple;
	bh=/oqgBdQbpz1EdJq8JtahDo/qxK18RwArIcIFqdWyy/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXxhCFrhuZww00oTanTYo1bHrR4wcJ+6jtTYUzPKI0qhSdF8pzQIm6/4BvoNfYNug1JjFFSaVkQYyIySc+8q0WnqY94M0cvEuUeQvN0xoLVPuUUX+klwQSAaAGrqvCtzMHly/sQZTF5ah77aGWLYBITVAL+tBOL3WLLmtsy8cGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6G3H-0007Hj-Ix; Sun, 12 May 2024 22:44:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6G3G-0012hQ-RK; Sun, 12 May 2024 22:44:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6G3G-002zWc-2U;
	Sun, 12 May 2024 22:44:10 +0200
Date: Sun, 12 May 2024 22:44:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de
Subject: Re: [PATCH] iio: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <4xgl4un4qh3qtbjnhlkesxladd6b2vvct2d7e3i3jznauj4vh4@w4v2jcvg7eec>
References: <20240508072928.2135858-2-u.kleine-koenig@pengutronix.de>
 <20240511142006.27facd74@jic23-huawei>
 <vffn6ntzcnps64kczm5rryuiqcjpz4sev2y4nier6divyg5srx@rdzojlblraqb>
 <20240512124742.632b0435@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wjerliqybijrgorv"
Content-Disposition: inline
In-Reply-To: <20240512124742.632b0435@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--wjerliqybijrgorv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, May 12, 2024 at 12:47:42PM +0100, Jonathan Cameron wrote:
> Anyhow, should be there shortly on the testing branch.

OK, the testing branch was updated now, and the change to
drivers/iio/imu/bmi160/bmi160_i2c.c looks fine.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wjerliqybijrgorv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZBKhkACgkQj4D7WH0S
/k6o4wgAtMyUHlRd09WlwFE5BIcW6OGvkTA8rC50NV63X7uZ3LNn1lMjrqH+dScH
bOPWAkF9BMh6t3s1cWW9vSrHok7tz54AwJGyNV45hkli77QcaixIMyyjdOUmo9d3
ogRoBjsN+LVCC5ksZteKxuBVj3dQwtG7esh598JbmAZm2bIDcAB2pO0PELq4BTFM
n0Joztq0BREKz0l/z1JVopyyS23J2heM6/ieg647M3X0aQmtzxd/+8nTnq6v3YEB
d9QEpF3gKBqERJDtATEaCyAwcz8NVojfUTeG5fOAjxVDl5SwxRUKBmm+v9lwZ7Za
F+zcXTxuzgmY5ydmJtBooTGf7mk+6g==
=Je5Y
-----END PGP SIGNATURE-----

--wjerliqybijrgorv--

