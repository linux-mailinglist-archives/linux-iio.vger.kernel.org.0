Return-Path: <linux-iio+bounces-8472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D1951F6F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B271C20EDD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D51B86C1;
	Wed, 14 Aug 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJwyiW2f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB11E53A;
	Wed, 14 Aug 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651615; cv=none; b=T3vjNCDES62mF+5OBKugrWlFILhTIWcELKJYpmn7dTeK7D8kZx2AjSICdUrrWd6/b5waZp/A5XvIF414TPzrWGDikJeN2R/kXFWLnIWB1jGJX8+IeRDuY3N2tQn4J168iyxDoAgH+5W5KyqMjNR1AUQM+b0bu1zzaf6EXUdF/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651615; c=relaxed/simple;
	bh=ZLTngYn1Z/w0Gi1BAHMxJnppaowKvDzr41t/hl18FBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2LY8+UJTPxuloLdP7h+g1TNy9JdVjpQgRf8vxIPhaYFmkb2iGq2ymcK3TARhwaIP8qPAdyx6qgJD73ZmWYChYnfkGrbvfvI94cTTvksnCcFPhMZT7yyGCbDnsT6udpL3OhDQzZa98fDUC3V5fjO8B8xQ6tVJx5EYBMQe8XwakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJwyiW2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69674C116B1;
	Wed, 14 Aug 2024 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723651614;
	bh=ZLTngYn1Z/w0Gi1BAHMxJnppaowKvDzr41t/hl18FBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJwyiW2fEb6yJqIMEUVk0U/2ZW9bpV3GyVFFoK6HcvR82Ao0Eu3xY7hsalODcfBaJ
	 asN0q/bcY4liJ3PNQUx7P056qD3/a7EVOMSKR4vc0LWuBMINWEweo8drTMbLkvZYdv
	 +o4It89/QM96H+PCCscUM9zjYjWr5JihtFZTQ1OooFqioztpuaOBqIvd03E8j/4tj4
	 OEvCxnNABjMkR7jkzEBBhP0UDW45+dhEhRDX311Pz0nvtR0g9zYVpeITRqbERZ0Zog
	 UUkFEDFE1oO64prmLpfFkeHGms+6Sx9xdPqdXYDqLnaQYO00nKXUh1fwvViTjitm0g
	 SGPMn2s+RodYA==
Date: Wed, 14 Aug 2024 17:06:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
Message-ID: <20240814-riveting-prenatal-1b6892877da5@spud>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240723-cabbie-opossum-6e551fe246f2@wendy>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PKGRGE32xX0ZFe8k"
Content-Disposition: inline
In-Reply-To: <20240723-cabbie-opossum-6e551fe246f2@wendy>


--PKGRGE32xX0ZFe8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 09:58:30AM +0100, Conor Dooley wrote:
> On Mon, Jul 22, 2024 at 04:57:07PM -0500, David Lechner wrote:
> > There is a recap at the end of this cover letter for those not familiar
> > with the previous discussions. For those that are, we'll get right to
> > the changes since the last version.
> >=20
> > In RFC v2, most of the discussion was around the DT bindings, so that
> > is what has mostly changed since then. I think we mostly settled on
> > what properties are needed and where they should go. There are probably
> > still some details to work out (see PATCH 5/9 for more discussion) but
> > I think we have the big-picture stuff figured out.
>=20
> Thanks for the updates. I'm on holiday until rc2, so it'll not be until
> then that I can really take a look at this. Figured I'd let you know
> rather than just ignore you...

Finally got around to actually looking at the binding patches, but since
Rob got there before me I didn't have all that much to say. Thanks for
looking into the graph idea, and I think I agree that it is worth
excluding that until you're actually going to use the crc checker etc.

--PKGRGE32xX0ZFe8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrzWGQAKCRB4tDGHoIJi
0rb1AQCyQWlmrcF9aDLgp/rABhBhWgKV3D1Mum4bbi6LMRejOQEAowNlXyZCJxs4
JteWQsOMct51J5TErk+fRtSNQlOe2wg=
=SUd6
-----END PGP SIGNATURE-----

--PKGRGE32xX0ZFe8k--

