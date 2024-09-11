Return-Path: <linux-iio+bounces-9448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C6975AD3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C7C2838AF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1F1BA863;
	Wed, 11 Sep 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0nDtLUf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF418C357;
	Wed, 11 Sep 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082937; cv=none; b=uIrwU7ZnNk6gTVGhpX31mekAWWUXkd0qZmmW7mm97+fwVJqjaymCV8/DYKZMtoZHNMjNwr6n1ZsbNrLFvLbWgWnK9HepSDVZKuIkPHuOWHA5F8vWbKot6QZCgPm4oF8ojRwjYGZt+QEk14VmFaqt+qIjW7So00Ebfl0H0iinjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082937; c=relaxed/simple;
	bh=T59rRg4dwHWf7KWGVsIxvIu6KQZtNF20xzVnDzCyhtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4i4//Qn8l6Wg/oDds1Gtedcoe9sw1bSsxtYxEqmepboDRNMVC7IMQJxFvBCl/W+mQ6XlmNKOPa0BxpZfntybX1kob2ibn7lOE4R0sOvacqz7DMFQPJK6+W3+fFfvsc+vbAz03zDp8txBjTczqhjH4DOjRTVBZwTq4s/UVTwLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0nDtLUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2D0C4CEC0;
	Wed, 11 Sep 2024 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726082937;
	bh=T59rRg4dwHWf7KWGVsIxvIu6KQZtNF20xzVnDzCyhtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0nDtLUfXMABcLr6ks2RSEg7CCf6CImgpC68zc9IPTwacQ7o+Oqld1UbbXTXZlGKC
	 83mDleEPxFTO6WPWwy0/14+lRXXYianiJfyu2XE8agczCxqRug/FzyTjEpTfoAkMT7
	 7Lk6YZ4Qd0Z0PgNDyDud56CARPZYaPKdhqOEFJYx7JTqrRiepONcmiocP7ZD58fce2
	 hN0SAW7DrvjARIsDFYoGzX6cqn4AnrqsSmIOj5Czl9Qet5hs4cb71UpJTQ7pPa0fWB
	 EoDM7yDpZbsMYU7EUkpjPyNaPTIcNnZlWtnLJyD+/7/0dsJSfLk+X3zwWXx+5Bzcye
	 tBBn5dcGjsR3Q==
Date: Wed, 11 Sep 2024 20:28:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Message-ID: <20240911-unfixed-faceplate-cb1ffe239125@spud>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
 <20240908132925.331c5175@jic23-huawei>
 <20240909-dwelled-specimen-949f44c8d04d@wendy>
 <1dca9ce52e7c701c7fb6cbbc723e9dff5d0ace8b.camel@gmail.com>
 <66090d3e-bf6c-43ee-9dc8-7bca449d448f@baylibre.com>
 <f54646877c2a68d01e15db31ae21224053f87439.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JeA0oE2RwfhgVEAi"
Content-Disposition: inline
In-Reply-To: <f54646877c2a68d01e15db31ae21224053f87439.camel@gmail.com>


--JeA0oE2RwfhgVEAi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:16:24AM +0200, Nuno S=E1 wrote:
> On Mon, 2024-09-09 at 12:19 -0500, David Lechner wrote:

> > So I think we could make a single binding that works for the the AXI DAC
> > backend/offload and the AXI SPI Engine offload. (I don't think it would
> > be so easy to integrate the AXI DAC into the SPI framework on the driver
> > side - and hopefully we won't have to, but the DT still could use the
> > proposed SPI offload bindings.)
> >=20
>=20
> Hopefully not...=20

Yeah, I wasn't really trying to place any expectations on how the driver
would look. My motivation in talking about offloads here was to see if
the data direct switch would help at all in trying to ensure the
spi-offloads stuff was being handled generically.

That said, I do think the current implementation binding wise is
probably capable of supporting both directions with little to no
problems, it'd mostly be the kernel's (proposed) interpretation that'd
not be up to it?


--JeA0oE2RwfhgVEAi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHvcwAKCRB4tDGHoIJi
0miWAPsHuPjsOWcESVczdK4JMl/e/qDVkATpitK3BEhGVmGlPQD/ae6Jf2DfgwQ9
T+hgsDy6ENpgZKWuPPz52CyHhExI0Ao=
=V+bY
-----END PGP SIGNATURE-----

--JeA0oE2RwfhgVEAi--

