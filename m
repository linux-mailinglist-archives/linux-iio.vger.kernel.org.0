Return-Path: <linux-iio+bounces-19210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C73AACDCD
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC621C2055A
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242A21F78F2;
	Tue,  6 May 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="IEEm+hjl"
X-Original-To: linux-iio@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7AD4414;
	Tue,  6 May 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558756; cv=none; b=d4Jnvpqba6YKYIemLNMJ865G9mDlJGbhWBDEjP4oV91BwMdnH7LUWdFaqO7YBcvoQPGULzPKyIat9LT9wiK9RKKAN2j+cEuNOAbehhziuTINfsPln+t6jNvS6sI7Hrqkhv5RHgeaYUJbI2JJeVE4LHSuknnvSh1QdHm2+r2hb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558756; c=relaxed/simple;
	bh=qxoVSBxApwQxjJlos0MEto/+Ak7aIzkLjzRqyzvgXEo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2qofwUFbHKqHXZXc8fVm3Sy6X5s+DBHKVHqyEAksGKDJrnNe0B3+v0xpnWtG0fHlpyNzZjeN6+aqy3JFJuIsiaqv2Rh5PQbdqLTmT4Dao4w6OV5wu5y1vX6JNMQV+2hpNMICY4HjxeZvdKS9shhxQPnr/hlvNKXWH/x4RJo5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=IEEm+hjl; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1746558602;
	bh=qxoVSBxApwQxjJlos0MEto/+Ak7aIzkLjzRqyzvgXEo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=IEEm+hjlK8eeP1ze36FEn5/gPKYfBReu24zkiVvLgrXcSuKhb5eqEgpsi6JTlOXF/
	 tNYVIjtnr/3zhKpM5c2mAXJpDMZyzOyqnuev57lcpbUxnT6OIXRF+YdubuMT2Uu+Ae
	 bPF3aFyJua8kijAdcdDrqU2WYyiVXUE0QW5Nb/GWWLUneRRJByK3nVpjDTZrdrA9MM
	 UtMT3vI07hia9JWW8FZNbuCkAhpqeJdY12xwHX0/cPRXBlHaO8ZHD+rj0qCQ2wMmef
	 ObHQAK2c/wEwbGyI2SzGDPzzomNG452Dlkwf6irHGSBV0RUxQjHRN6hhAYx3J2MvWQ
	 g5i96NYCWtyHg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8D97010736;
	Tue,  6 May 2025 21:10:02 +0200 (CEST)
Date: Tue, 6 May 2025 21:10:02 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: ssp_sensors: optimalize -> optimize
Message-ID: <5a64aa3034c6127d7587de9b7045a12892c01ee5.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
References: <f6e465fee5a824a67be1ae7c3bc1b72adcf9471f.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mn5jzsztpgpqf7g5"
Content-Disposition: inline
In-Reply-To: <f6e465fee5a824a67be1ae7c3bc1b72adcf9471f.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--mn5jzsztpgpqf7g5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/=
ssp_sensors/ssp_spi.c
index f32b04b63ea1..b7f093d7345b 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -104,7 +104,7 @@ static struct ssp_msg *ssp_create_msg(u8 cmd, u16 len, =
u16 opt, u32 data)
 /*
  * It is a bit heavy to do it this way but often the function is used to c=
ompose
  * the message from smaller chunks which are placed on the stack.  Often t=
he
- * chunks are small so memcpy should be optimalized.
+ * chunks are small so memcpy should be optimized.
  */
 static inline void ssp_fill_buffer(struct ssp_msg *m, unsigned int offset,
 				   const void *src, unsigned int len)
--=20
2.39.5

--mn5jzsztpgpqf7g5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmgaXooACgkQvP0LAY0m
WPGdww//TGdBAuGF4H5rxorbkBrhYyXIAsA3YL+Vc6GN2vWpE83drPbbyk2mkSwj
8s4mHryP1Q73NfiJUPtbrtzTYKznMOFVx4hZ651erxtBpQIA160IRvz47e2+d9sH
5XEJM+OlnqdCrAy/GuSm8XTSZa76CCRd2aZ/vn+LcXTqSDflx5lAmgjXvq+j+seS
ZvdYSe4V+46Q/D4hgsTCdyKVfSyvWckxEJqU16xbWWlNfRTGF8S7c0KfJ41iXZuh
QkZ2PI/083xhgExPVxbodX0X6cu/TQzA2xg23u9Mw/0+92pu+vJz0xnBoSw0a12C
770zTbPfv04G9N+Owt+YlaHOJfSUUOr9448QY9JSbi6SmIRT9GAGhM18PGPC/4af
7iihZazHfU5sBUDRN3TXIN6/DTpLCW0sESgtnqsR4FmD/H3525y4LpBGmijbVkst
xC3ThwE8SNYIlKatutqPZSgUXR+e7btC6H2BOWx8wGBX2HlcrqrDsq8x1FYqeULd
oXTM3FVu9ZEUb4wEZF9FpPFXLAqyRGgfyXsLfZcLgCro/VabGBGb196fDJ2WeDLr
xyYvIoGod+XUNKGsVM/yCko55NclyNIckKoPgEzHi1o/HS9WoIpl2gMZyeZf22V7
Eb/HwysYBXP063l4xO3dgFk4gQLjRHnwwPldoQJcp8HnoeZXt44=
=6AuU
-----END PGP SIGNATURE-----

--mn5jzsztpgpqf7g5--

