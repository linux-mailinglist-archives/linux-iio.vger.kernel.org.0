Return-Path: <linux-iio+bounces-13031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B689E2768
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97FE164E48
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25151F8AD2;
	Tue,  3 Dec 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu9SbOiK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CF1F4283;
	Tue,  3 Dec 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243308; cv=none; b=N4FdqdV5143F1sT88/FWrF7ngIbqSRX7pafCcgrmtHK+zzzkXo3CjkoUg/Tt5Jvp85r+z5MaT89kUJeDWQ1884ygGurNs+bhNb+BODDynpfUSstD3wwYgXsSXKfcGw2fhON32c+PhL9Dx9x+9zIAXCg2jUQXFn3EeCYbRKQpSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243308; c=relaxed/simple;
	bh=WA9WK5xt/YZ5TBsjm5H9d3XA02FoCiAuwBjHtqD7DI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwY7xLqaN1fBI8jefumxoNaxxRdz/FNaAHf1jvsP7Db+Xs12zv4cTk4zxnI/9yseU/JZNmdVJyuVrB6MFCKPdv1H3qg2+UT/H1yBQ72FuWKw3MdMS+ClQF/HPE2KBejex6mDGdihl2vllBfexqaycPpdvAVS2JKrHUSgD7l3v4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu9SbOiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1A5C4CECF;
	Tue,  3 Dec 2024 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243307;
	bh=WA9WK5xt/YZ5TBsjm5H9d3XA02FoCiAuwBjHtqD7DI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gu9SbOiKMIRWdhGnOhlKEZM0/Ed5+XlHK954RHDcgiIyGrU+dgacczRCqaa4MYJt0
	 Atzb7NsfeSTqERoOmUAA6UbjJOoCjcLsWvaFY1AcQkg2xJ2EmWe4G6ZWFk9XCrREam
	 3zFsyunrFH4ycdr/YsF53IGukbh0PwHRA8AVYPx8LTlxZ38B8N92EA5L91rgq68Zkm
	 m+9eLB8Lvqc7ybLyNTVHk865LCgmNC3FLbDc4oKH/71swiLZ4TNEnZpoq9Ni8s1N0J
	 75ze2+0FQVIlGt9OYbXVnmclzjsizLnRVM5bkGM8ex6jCBz0jpTlKIBVSs6Fxsxc+/
	 cmOlLKWFTeg6g==
Date: Tue, 3 Dec 2024 16:28:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: accel: fxls8962af: add
 wakeup-source property
Message-ID: <20241203-famished-satisfied-13c6f350a387@spud>
References: <20241203-fxlsdt-v2-1-ef523461b507@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2p5oSk5jhsUPyj0M"
Content-Disposition: inline
In-Reply-To: <20241203-fxlsdt-v2-1-ef523461b507@geanix.com>


--2p5oSk5jhsUPyj0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 08:22:11AM +0100, Sean Nyekjaer wrote:
> Add a wakeup-source property to the binding to describe whether the
> wakeup interrupts from the accelerometer can wake the system from
> suspend.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2p5oSk5jhsUPyj0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ08xpwAKCRB4tDGHoIJi
0iQtAP9KMNDYQjqQXpZeoqZTkyBQ65EW+ZT5zt7Y77XsYDLqbwEA4aMEZxQJzAYQ
P2xyf9mRg0sLbRBbQQvsnOeSPddI7gQ=
=i+Lh
-----END PGP SIGNATURE-----

--2p5oSk5jhsUPyj0M--

