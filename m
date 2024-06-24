Return-Path: <linux-iio+bounces-6794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3D91427B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5A31F256FA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 06:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D790208CA;
	Mon, 24 Jun 2024 06:05:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D1208B6;
	Mon, 24 Jun 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209117; cv=none; b=IT2S/Sz43BsIY/mTnlATCcBJkGEVGn32QkTg/jZJHtld/6x52oQQJ3YIMjJpoJ5LZ4N3D20i8kVMHFzjT3V67xAVIbifYtXcO1o0pu0uBNrGsN+P1rBLDCg86kU3S8x6wGw4t8CrHJN+UFZjGo6HH0WVQ//wBQ8MEzVonIqlD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209117; c=relaxed/simple;
	bh=nX9bqQjZFp8P1j34oX2PBFHzvpt8zyD/vC3kpmgdvgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hBG68TqFsKqoh7VtDtxduAqDNaEg4dFNcJnbZtQTCIxAKhBSRKF2qmCbP88Ovuxh1RBaGAVfOFsXqgZkerUAWL+EPM5qaSPB939TAwEclScmeKGMl8Cke0H2OjFDeVRnzK+/r119SQ8G3tThApD0fOkYGYGS/nAPJk/YkowfCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1sLcpC-000N8W-3D;
	Mon, 24 Jun 2024 08:05:11 +0200
Received: from [31.220.119.164] (helo=mail.your-server.de)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1sLcpD-000AOA-0m;
	Mon, 24 Jun 2024 08:05:10 +0200
Date: Mon, 24 Jun 2024 08:05:09 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] iio: adc: hx711: use dev_err_probe()
Message-ID: <ZnkMlWIewq8s_XeS@mail.your-server.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NPQkkl0HGmmU9H1y"
Content-Disposition: inline
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-4-49e50cd0b99a@baylibre.com>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.3/27315/Sun Jun 23 10:23:58 2024)


--NPQkkl0HGmmU9H1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-06-21 at 22:11 +0000, David Lechner wrote:
> Use dev_err_probe() to simplify error returns in the probe function.
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Andreas Klinger <ak@it-klinger.de>

--=20

--NPQkkl0HGmmU9H1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmZ5DJQACgkQyHDM+xwP
AVHJ3gv+PRSmvwbaW2ps2R6YXJOC29aMqR0YVYDpdDqIf3xvOIhYnprCAA7bcXC+
OX/Rs0lUvs1HwTDFrrF2jXesHX88JYQoB591HXOje5Hi4quzkyZcow3kRdV9AyQo
3r4Y5X3M73ywkTrn4Xx+oFewOVo0TQflZdxl9YBzcOFkIZPh8d8p3B/eTII/n1Pr
BartrbGrHK8pBu5pOPzLxJKQoDXqbAkV8sAGbBGm33Ow/Y+X2TA10VylOmi1FGlZ
YmVcyA9zQlXy9zy4zZpOyX9awx7trBJAcaHCVu7pwNlaleGwbQZSiycBzrYOyOi2
VBH9GXchSoyECiz+1bmqdKuGebpJMCvHq1DPeT4oCBftE1MGRz035qU6o2+7RvQW
iEhzKLo8wXBrOwmCOjTrCOsX76Uycbp50vjhuqsqpDHlpA2oJKIMT6hoOVlCnL41
CM58is3YqqssMMaE7XaiwGsCqZ6annaoIrQY/PdtGtw8L4x4UNmTE1OV4szDejAO
FZwXdwBE
=Py/z
-----END PGP SIGNATURE-----

--NPQkkl0HGmmU9H1y--

