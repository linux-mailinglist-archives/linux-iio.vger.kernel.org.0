Return-Path: <linux-iio+bounces-15920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCCFA3FDF3
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF0C19C6509
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD11DE4E5;
	Fri, 21 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozPlYk25"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20536AF5;
	Fri, 21 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160267; cv=none; b=lAwhZjGp5P6fUdilflHPLc4dw6E4c0qy7kqxI+CKdMcdJ7Q1CP+xQ7pSmwB45Bp9z+ZLj+VWfzMZq3kcYf4vb4IgB0KkkuK9KIH9m+42ny1dqIeRptWkcVyArqJZoWBpYXNKjXYjhb9O6abPTuHJcTuKWilTO/JdK1YAVqMpFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160267; c=relaxed/simple;
	bh=3eesD+pD1KF9e3md9IM3g/43wZo+3VaylNPe9qmeh9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qve+qtwM+OwOmjGPY0yOlaecWOYBySO2iP4emERTWoePNnxB4aQ4FnEQF3aV98/yjBKNcTVypfSZTNUItPo6PIR3V5V+94WlHmwENYtlVLi4lEab9jElxJtsKWjjL5wWLd7/O7Rfy+8x2kSonprwjUCIc3sGbkI7qCwvS1EaBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozPlYk25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84109C4CED6;
	Fri, 21 Feb 2025 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740160267;
	bh=3eesD+pD1KF9e3md9IM3g/43wZo+3VaylNPe9qmeh9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozPlYk25Sv1/W22RXkC+Dk7Ja0YpByE7SnV7XkW1CPS0aIvrKTlMX6oUW7KN4trzJ
	 bZiC6qKvIVszmCZwHVMtHhiKR7YnnscK1F+b9h+bC712M9up/m1r01pEsixy/5+rWH
	 Zy93kS33GWZwfNkacuU+EAcGYBTmYdoVLFP3zuYZKtLyc5PGLRgbZZxDMoLblgLIAQ
	 CuB0j7iuKpYavK8SUKOKI+7m4ZG2HCcDTP2ZhkgSfs/rliochoTNmLfBkvO3fqgriB
	 g2tu1Y65a4CMjHTU6nbgZYOIyVosC/gJcl3TeKMCnCJqTSUvColxR3lAH11zdrNGXi
	 GyjppZh9GNJmw==
Date: Fri, 21 Feb 2025 17:51:03 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] dt-bindings: iio: adc: add ad4080
Message-ID: <20250221-chip-bonus-7088cf66b558@spud>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
 <20250220135429.8615-13-antoniu.miclaus@analog.com>
 <6d4e65b9-1392-46e9-ac2e-0c4ef2239fa0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4HdKVL/1015tmiZQ"
Content-Disposition: inline
In-Reply-To: <6d4e65b9-1392-46e9-ac2e-0c4ef2239fa0@baylibre.com>


--4HdKVL/1015tmiZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 01:30:11PM -0600, David Lechner wrote:
> On 2/20/25 7:54 AM, Antoniu Miclaus wrote:

> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: adc-clk
>=20
> Clocks don't need a name if there is only one clock.

And if they do need a name, putting "clk" in the name of a clock is
pointless!


--4HdKVL/1015tmiZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7i9BwAKCRB4tDGHoIJi
0ic1AQD112FQkzi58+uQbPA6iGAsG1+q6jACUzdDERijSWlVDAD/UrcSGJwU8Ues
5JRLjc8KX7hYFVUKHCxI66nGpJayZwY=
=kQtY
-----END PGP SIGNATURE-----

--4HdKVL/1015tmiZQ--

