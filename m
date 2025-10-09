Return-Path: <linux-iio+bounces-24887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A10BCAF96
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 23:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27A23C7FFE
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE61155C88;
	Thu,  9 Oct 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CIMTSYHM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66911EF09B
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046458; cv=none; b=sfErRClE9hebgfK4D5v7IYaPY/ja4LVLrAogMnkny+H6X5GT9QcY4sb6hdXQMz+7LMkLsuQ53EsKA6791OQ3FLkuQPAt++Cl8tawNYIVdscQ816prUdRMKD9q2BuZR2cLY5t2HufdMXxh7Z/jbfQix94CHfaUUZPQ5Acneokeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046458; c=relaxed/simple;
	bh=ZZnY9wKua9FhBSZBzBS1QceJr1z/G+W1YK7xp9uzrH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSA1hy1E+2L22h7YdBbFuTkprDWJPemQWYZ7pUSEVIyfDMGke/iFSh2En7kkpXSPN6sBU/FraMiRPeqx4fulrEMwnA6QFjSFXkC6Gtvxh4oaolnYbf1hianWElz9wZA1ypm7VE+AzIIIJiohtiluF2dmvTmCeI7EztDUqGjUwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CIMTSYHM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ZZnY
	9wKua9FhBSZBzBS1QceJr1z/G+W1YK7xp9uzrH8=; b=CIMTSYHMF6qQSaraP40g
	KUQwXi1cGEz0toCRoWkOE7pgOTTIwc9Knhk4TtKZTyXWEcdZOUoajPEU997KGjXl
	cBIjM4JNBd5cf1OnJntlvo3TiSq1PTK0qE7k/gg2KWMJz+oKFYOThf5FX5woZxq6
	SqOAnDCGamKIKhkK5FYIA5IeegaMuRqlvGpPV6tE3zrusEAVplyxyY9RfBr88rE2
	Y/DdxabkTcFD4oyJx+EH9Cyy6LparLp3DdifPR26PsCgSnDr1z8JPhzEpGNJ97Pn
	QUU9OG5X0bqdnBPBylniHXLI0nA7SMGpliTaoR98y6x70w3DpGvnd2Dt1zpB/3V9
	9g==
Received: (qmail 1230338 invoked from network); 9 Oct 2025 23:47:34 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Oct 2025 23:47:34 +0200
X-UD-Smtp-Session: l3s3148p1@GKizv8BAhocujnv2
Date: Thu, 9 Oct 2025 23:47:34 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/2] another 'interrupts-extended' replacement needed?
Message-ID: <aOgtdqUKePXIjRNs@shikoro>
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
 <20251009203509.GA3296392-robh@kernel.org>
 <CAL_JsqKYqw0podCR7rQefg5c1-1-Z5xN9H7zGVrZzCTunmdRUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XCT3oaqySS3OM+kp"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKYqw0podCR7rQefg5c1-1-Z5xN9H7zGVrZzCTunmdRUw@mail.gmail.com>


--XCT3oaqySS3OM+kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> However, the "interrupts: [ interrupt-names ]" depend is not handled
> correctly. It would allow 'interrupts-extended' without
> 'interrupt-names'.
>=20
> I'll make a fix.

So, even after your fix, the above dependency needs to stay in this
binding document? Did I get this right?


--XCT3oaqySS3OM+kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjoLXYACgkQFA3kzBSg
KbYlOA//Qtan59PzAItivntlZhuBuI1ONpFDyCe4huRHJQO5I/uRyu7lviGBaOTZ
f3No3PWNfn9NzzyVE5DPfoXZktfG+5OaPeQGNDd4dUnJ9hWG03GWUAWkxfoqxH2S
QPGW0d6o8XJ93h6wyqjhn7S7ysFqyQ7T9Uw+w9FR4xejEWHZBUOd9D3PeN9dGGmw
Lr8CwHDl86rv7cCOQd7TCvqpG+uBdjgWz5s5daAF4z4SkE0RTc+Jjf1Bjz6iuqu7
tFD0En9ZPYnwBFRg4gp2q+Oct6AvBcIJzSFh3RzakUsyjKfR6Sm7f6715X/d/Dyb
l2jAVO6FW0cFMHNDJUGwltAI6ETROc1skTVhwJFtXxqWjGPiTe9HVM+dH852LVLG
+edRP1GhfZMOLqZ1MI3ClLLZmGMnJIPSRHB0U/rcBkpLuy8nf24l57htqCQgmZS8
eeJU0LmYlx9nz8ucj09YWp990Qt5HH2cf8VN8cKQjf5k08hKtSmgq0IDetN+Ow5b
IOybHZqF/xnZ8+ZpcNh93Gm9BspS0v19LWrtOsrS2omW6s5h30jUFqfwkmeE9vYh
TEK42sI92LmqCcXd6PprfmGeY8ZFRV3wnbvbzZhwUETM60W86I6IztKBaOJ1crdx
UOGGQ83f+UKTLRrPtDGyB8X5PKz56rI3ZARVajUQww4KzTLgdRU=
=LphF
-----END PGP SIGNATURE-----

--XCT3oaqySS3OM+kp--

