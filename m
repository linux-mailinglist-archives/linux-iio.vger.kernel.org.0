Return-Path: <linux-iio+bounces-23866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339BB47B99
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F8A16AA1D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8326F2AC;
	Sun,  7 Sep 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="0ETSsvJz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD820CCDC;
	Sun,  7 Sep 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757251711; cv=none; b=a8eWiJbn2JgFs50Ri6il8MlNRcJWXROcEiwVvgcg75lWWMZ7iU81586eu7rqq+GbR46NMBa3CjR6tAEYHu0Uzf07RwgsY8E/UMjUBHggCNl2Ah5cjhAT5cwbL7w56M8LHXV6ah3ympgvU2fzlPZ16gkUI3y04V9TRaAsAodfUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757251711; c=relaxed/simple;
	bh=MrzV9Rjf7EUUbLYejOVlndigmbYDasdkNrWu/gS9J3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhN94exKBQwezpDOQAi0bjtybOu4fhjO/Iwllafv2d/luniDAETVG9ElAPMRqBUO6Cg5EPp627NIeaFyOeHibVMjhWs/32kZZyB2ELj5smQbaYTIBkPuelkzTWhUsrOIIUenMnOgchzGVri3IV9n+6/7+8/QLETVmV0VuyQXLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=0ETSsvJz; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id CC7ED173BE2;
	Sun, 07 Sep 2025 16:28:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757251700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRV0CYl9dJ5OvfyCTDVPftDZYrpVy5qen15z0pM6M84=;
	b=0ETSsvJzgxGU3DNGG5nxdtg9+o64BhpDTndbHFFegV57VBPQcepUWWwJynkJvxUmdDHAza
	K5OehEhsXc9ezO5e3jlXhsVVdpNxWNIY9t0Gw07kZFBV8BKT44BbEzY5nnKmJ8RdJvXSfp
	3JpnpFmmCPFqxiaAK73JADS2uJW6vtuvUfXPbxYf3QZ28vIckG76KO1j/l+Y7PPqELXWZi
	IJtNDNya6f93idLgayOUlvG9EyJBUCNYhLTpjXbHr/9WKOChrmktydCyFm4wGiO1EqgLuV
	Y/zl+xBVxlq24j9262Jtpcl8xr8K31ydKEeYo4ri4qHYG1ve9ze29bHtSYQjZQ==
Date: Sun, 7 Sep 2025 16:28:17 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 09/10] iio: accel: BMA220 add event attrs
Message-ID: <aL2IcVfzCTXSg3Ol@sunspire>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-10-petre.rodan@subdimension.ro>
 <20250907141515.0b49012a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WtUWaLUBm97qTr0k"
Content-Disposition: inline
In-Reply-To: <20250907141515.0b49012a@jic23-huawei>


--WtUWaLUBm97qTr0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Jonathan,

On Sun, Sep 07, 2025 at 02:15:15PM +0100, Jonathan Cameron wrote:
> On Mon,  1 Sep 2025 22:47:35 +0300
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Add event attributes not directly covered by the IIO API.
>=20
> These must be accompanied by ABI documentation in
> Documentation/ABI/testing/sysfs-bus-iio-...
>=20
> We need to pull out of the datasheet generic descriptions of what
> they are so we can consider if they make sense as general new ABI
> or perhaps map to something existing.  In some cases it is more
> appropriate just to set a reasonable default and not provide a
> userspace ABI at all.
>=20
> Key point is that custom ABI is effectively unused ABI because most
> software is written against a bunch of devices and has no idea what
> the new ABI is.=20

I see your point. From all ot those maybe just the interrupt latch function=
ality
is generic enough, I have seen something similar while writing other driver=
s.

=66rom the datasheet:

" The interrupt controller can be used in two modes

 - Latched mode: Once one of the configured interrupt conditions applies, t=
he INT pin is
asserted and must be reset by the external master through the digital inter=
face.

 - Non-Latched mode: The interrupt controller clears the INT signal once th=
e interrupt
condition no longer applies (default behaviour in our chip).

The interrupt output can be programmed by lat_int[2:0] to be either
  unlatched ('000') or
  latched permanently ('111')
  or have the latch time of 0.25s ('001')/0.5s('010')/1s('011')/2s('100')/4=
s('101')/8s('110').

The setting of these bits applies to all types of interrupts."

Many thanks for the detailed review, I will prepare a new set in b4 and skip
everything event related for now to keep the set smaller.

cheers,
peter

--=20
petre rodan

--WtUWaLUBm97qTr0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmi9iHAACgkQzyaZmYRO
fzCx+hAAsF4LKBl1GcGqiY7z2d/dazn/m7vZydS3pLQojsBLQi96ccsGMVAsjfUC
RfUVPWIDxzSBitb9fBrRYc59rqe02Q0Ud1+zPrQeGeX9yjbSDW0QLE8sxFeutH4g
G9UQotYU+wbFLo5GmJU5K8nbEy6ROp11hEVoYKY/taL2yk0rbgHpTxPms7FT7AO7
C9k9JfceN2iGvAlz8RLeAD0K/A+PixeRQvMBfHaVEjEHYEBB9A0OPSb2Jhqw7rie
106kHZ4XC+G7mbMiZNQv8suBRfUQLqbHZuvqQG4oJ7nq81F7SMk9Wqx+FqD7bx2R
c7KabRTXJ+4ZA9kthpncTjda+KRF9wvmZOou6CHFJw2e1NFTYzZFDHg+dx2qrgbS
D6Ea2WBW4gb/ZXqzPLr+sPjcHczvbsM8aJZsERExIwuitZNx6GGeFqiphgN1VZ2w
s6eGU7YDxGIcpmbaMoHNWE5tc6wlQBjp4a4xI3usLu8mmBynuxwGbTRCopcKdRbF
kJJ90XzyxECfw1a5S86BxpDLIv/z5R+TQMt8+ryYxhCWZJbkH83aHoME9h2opWVM
jmFLPmnyNRyXDk8me3xyknHzN9hOmrSHiuRRIbTUlSQSfCZYPf6ZBh2ksWQ1LiYz
UxYzOmfz42taVTXBwUgRZJAua/eSG+w1138HzNjlijl5cq50ta8=
=XeHB
-----END PGP SIGNATURE-----

--WtUWaLUBm97qTr0k--

