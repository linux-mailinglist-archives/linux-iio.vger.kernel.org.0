Return-Path: <linux-iio+bounces-23158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDDDB32082
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C2916BED3
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367B82874F1;
	Fri, 22 Aug 2025 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSUsad4e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF72820D1;
	Fri, 22 Aug 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879932; cv=none; b=cvv4s4v3sXQViUIxRmTlVtUYC2wN6JWBcoLy46YDMEqeenP7i12/vT7rP+vB7/jXnKlk6mq72bPWB0k975ByL8EM0cpFiZSSo8ai5GvUWAWPc2NrR1QESGPjAl5sifWf1mwowaFJXMPFqkUZlg1L9JnH2E/rfqzzBQ1Fo51tEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879932; c=relaxed/simple;
	bh=3XIFYtGxxwJwgPJb0lOhj2GeXj1omDgPu0uvMaRzNig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRI4DC64DuEA87ocUfVp4DMcxhAZS22h+aSt4C6YbIhFAXl2DxUyZygnuUoExp/LxRFf0YGrfhi6VfTkea9V4tLShx3EpWkzQTT/ybhroPrCk1aA4UppniK8w6JwlsA9UAz+JH1Qais4zTwONS+EKV3lTFzYuUp8fNOqlT3n5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSUsad4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBF9C4CEED;
	Fri, 22 Aug 2025 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755879931;
	bh=3XIFYtGxxwJwgPJb0lOhj2GeXj1omDgPu0uvMaRzNig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSUsad4e9O5kFPhd/C477iPgtX7nigf1Fa2KaWL0huVsJw9K6PQ7KGfnH5Z7W2nE3
	 lDdIkuNsNVLqkvJEKdo3uI2j8yhXKZXoyv6/jmbFUDM8XAxbmdn6UOE36Elyn2pMdC
	 6JjzwRXl64DvXc2GLv/mP77KAgtOn58z/IWXYr66b6VGo05gxPpmStOP5YMZoQf6qj
	 uWK+UVwi/pWZN8OZaq/JSWbCZ5BcQP/t1mf6wkJCQleKBmFlhdz0lSD2qoiUsfIsoo
	 tzGVPa2GyjReQ6Cm3JR1SJzjDfnbkfRbkYGM7zoZ4erQT+MDMkGCcBVn06/h2JyLqB
	 PPSpMRfoRGVYA==
Date: Fri, 22 Aug 2025 17:25:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>
Subject: Re: [PATCH v1 0/2] Add MAX14001/MAX14002 support
Message-ID: <20250822-nugget-evergreen-ff73d719d3e0@spud>
References: <cover.1755778211.git.marilene.agarcia@gmail.com>
 <20250821-haziness-squeamish-81713e94d079@spud>
 <aKdyW1rWlwNFg85k@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AX4Rg82iYesdb+Ep"
Content-Disposition: inline
In-Reply-To: <aKdyW1rWlwNFg85k@debian-BULLSEYE-live-builder-AMD64>


--AX4Rg82iYesdb+Ep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 04:24:11PM -0300, Marcelo Schmitt wrote:
> On 08/21, Conor Dooley wrote:
> > On Thu, Aug 21, 2025 at 10:36:06AM -0300, Marilene Andrade Garcia wrote:
> > > Hello maintainers,
> > >=20
> > > This patch series adds basic support for the Analog Devices=20
> > > MAX14001/MAX14002, configurable, isolated 10-bit ADCs for multi-range=
=20
> ...
> >=20
> > Something gone wrong here? There's already a v9 from another ADI
> > employee on the list:
> > https://lore.kernel.org/all/20230710042723.46084-2-kimseer.paller@analo=
g.com/
>=20
> Yes, my procedure for finding parts for GSoC projects failed to find that=
 set.
> From quick read of v9 thread, the reason for that not being applied was l=
ack
> of detailed comments about device data transfer handling?
> Anyway, I guess the only thing left to do now is see what can be taken fr=
om
> Marilene's set and applied on top of Kim's one.
>=20
> I'm sorry for this unfortunate situation.

Eek, saving grace I suppose is that the experience of writing the driver
is the most important thing to get out of GSoC?

--AX4Rg82iYesdb+Ep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKiZ9QAKCRB4tDGHoIJi
0p/kAP9+RxKZYE2iUXq4RygEdBTZzZCE19keuT4GqcjKb37svQD/bULFmfYXAPCy
uJUoFcdfn1X/rPSIru3w7z1FDKJ19gY=
=HHfT
-----END PGP SIGNATURE-----

--AX4Rg82iYesdb+Ep--

