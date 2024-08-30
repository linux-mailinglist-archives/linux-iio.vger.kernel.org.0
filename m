Return-Path: <linux-iio+bounces-8896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF09664F9
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CFF28446A
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE151B3B35;
	Fri, 30 Aug 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCkCpvEe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83471B29CD;
	Fri, 30 Aug 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030371; cv=none; b=EMHT+BniQf/5/3sBtrgNHX7eTNeGwtzytaS1XcU+zNAgwggclvCYsDgT5LKa7t0fo5TakfcdzBvB1JDa1sZ3ISCVJUewSvMh7qlQvkGu33yT518pkFWSI0ZUBcgrk6Ciu5EwKIzszMg5dDoQqMfBXle4x8lFvjh+6VmH3dNCBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030371; c=relaxed/simple;
	bh=JPD/QwW76Ru7sqSaOhnm/av9Sp9NONR08vZrOEyi/bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYXIXHljYtBGG1v1q91CtL251R24dV+aPFIiSofzhn6hjeybyuxXEpy5v/ovWN/oMOc8WP96TIcrj6hj6mhNUyl3KhtC1/Kcd1v2mBZAR00C5fS97+kSkElWkDTybngCm7LuKfyYfJEHQcN9JVNny1wJ34ixOeUIakecRmpSqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCkCpvEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51A5C4CEC2;
	Fri, 30 Aug 2024 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725030370;
	bh=JPD/QwW76Ru7sqSaOhnm/av9Sp9NONR08vZrOEyi/bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCkCpvEeQL5ChVrD7gCgu2Eu3kG7nCRZuAL9n26aCzSyfZ/QVABCXdJpKB7mckCDG
	 fwUD+uBNLlLRnNDKvGqAverga/5VMvDSjqRaPalMMYOVz1I2zVzW6F6+4630dm1GH7
	 swTSwxxyALzhcvrG6se6T+b0LDnMT8xB2G2+GHKomdMQI/uzRI/5PMXY3hwOgucW4D
	 ihVPtCKmHtlC21K9ZjkHIw48SkufC6AQYszwDsUjX7eXexPO7I+m3epyJFVVvUD0zh
	 buRvuWFyWN61LEX5n9sw6vWS9vqVFhY7tcpd8w0FAJlwYerCXLHUkdwuJsWl55x9bu
	 OrQk9N6jU0mvA==
Date: Fri, 30 Aug 2024 16:06:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Message-ID: <20240830-deviant-surging-4f617819ef47@spud>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <lets4c46zg4rzfqrjakeby3oa3zhxh4nyfcg4vxhfnufcpaxak@xmzdwb47xhx5>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/bLGyJppz6CoDdEB"
Content-Disposition: inline
In-Reply-To: <lets4c46zg4rzfqrjakeby3oa3zhxh4nyfcg4vxhfnufcpaxak@xmzdwb47xhx5>


--/bLGyJppz6CoDdEB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:16:36AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Aug 29, 2024 at 04:46:59PM +0100, Conor Dooley wrote:
> > On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Add bus property.
> >=20
> > RFC it may be, but you do need to explain what this bus-type actually
> > describes for commenting on the suitability of the method to be
> > meaningful.
> >=20
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 +++++=
++++
> > >  1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.ya=
ml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > index a55e9bfc66d7..a7ce72e1cd81 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > @@ -38,6 +38,15 @@ properties:
> > >    clocks:
> > >      maxItems: 1
> >=20
> > You mentioned about new compatible strings, does the one currently
> > listed in this binding support both bus types?
> >=20
> > Making the bus type decision based on compatible only really makes sense
> > if they're different versions of the IP, but not if they're different
> > configuration options for a given version.
> >=20
>=20
> Yeah, in general the parent defines the bus type.

Right, if the bus that's being used isn't spi anymore, you should be
able to detect that without a property. However, the device that "left"
the spi bus is not this "adi,axi-dac" it is the adi,ad3552r. I think
this property is actually representing the bus that this adi,axi-dac is
/providing/, rather than the bus it is "consuming".

--/bLGyJppz6CoDdEB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHf3QAKCRB4tDGHoIJi
0q0JAQDaaVEWcprCBvDgrtMFvN7YqkRvgR3ujGgzpLVEhj3diQEAkMkm8736yvab
r6qI+ZSEElTKzztkAKMHoqCBHrICAAw=
=KcN/
-----END PGP SIGNATURE-----

--/bLGyJppz6CoDdEB--

