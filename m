Return-Path: <linux-iio+bounces-5774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C38FBA92
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E55E289AC6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A114A0AD;
	Tue,  4 Jun 2024 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCFTq6bI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE012CD98;
	Tue,  4 Jun 2024 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522509; cv=none; b=ROGXoj4btj5LB5aNPu6Jds7dG8vJkw9FFXWaITZjWjosnyLCvH4TfiVm+VSnVCD3uejbip72tL3mUjFIcDhHAeIbFap6aJmZXMKT6MDG/tl4qV7D+H8USLmnFuSlN0U75RMePEGf6ncLKs/fsFlqR69kxNdDdhIEEhF0mo0U+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522509; c=relaxed/simple;
	bh=rRDxOWeUiHafYT7mmG5QjiuGRWsUjsAqRMJ7TY6d9as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBnfRxkRLby7HYdTIkNG97MfJTA48dthHUzy7ZE5y8WGhaTAIEc74AFcs5Ij5B6PTQ5I46AXKEDYiZQXkt0O0cEykFil8E3igE19ye7oULdOSG4TUbIFOvV25eBT+lO06FetcwyO4Cn3cpQ444uQIsZXGptRhwQnO3RfiNZW+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCFTq6bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D820EC4AF07;
	Tue,  4 Jun 2024 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522509;
	bh=rRDxOWeUiHafYT7mmG5QjiuGRWsUjsAqRMJ7TY6d9as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCFTq6bI8aU1iNJg2BF1d/ksx6zZResvDeZFLppKdWhyq2KXX5ThmbB5kmljiKyqC
	 wlGXb2+RzCBKJknAl54SUKLi/KCoAuSpvK3AGuMyKE6j7+6URZKtXuDytQPZNGHUxs
	 b3oMjACJqrkHFYZtod8yshlg8BRWCPfETbyJJcGyzaYkMT23uwZR0d9SiKL7ka6pli
	 ITUtBDDbiULL0/taAD+3LATduUfUz+936VBZAHqFtrRyQSkfKQ3L8IhG7tnm0ixad+
	 4syQQE0vDp75dSPosUaDAMZjOjuzk//nZAHP54L1d28wQnWSuOznuK2RoI9VAhMC3O
	 wVbJBwv4j2OAQ==
Date: Tue, 4 Jun 2024 18:35:04 +0100
From: Conor Dooley <conor@kernel.org>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v5 2/9] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240604-regretful-veneering-767defdbc23b@spud>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
 <20240603-ad4111-v5-2-9a9c54d9ac78@analog.com>
 <20240604-darkish-paprika-351ad2f72e96@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+B+POWgoa4oRXj9t"
Content-Disposition: inline
In-Reply-To: <20240604-darkish-paprika-351ad2f72e96@spud>


--+B+POWgoa4oRXj9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 06:34:34PM +0100, Conor Dooley wrote:
> On Mon, Jun 03, 2024 at 07:23:00PM +0300, Dumitru Ceclan via B4 Relay wro=
te:
> > +      common-mode-channel:
> > +        description:
> > +          This property is used for defining the negative input of a
> > +          single-ended or pseudo-differential voltage channel.
> > +
> > +          Special inputs are valid as well.
> > +        minimum: 0
> > +        maximum: 31
>=20
> I think this property, since it purports to be a common one due to the
> lack of a vendor prefix, should be documented in adc.yaml.

Oh you did and I just read the set out of order, nvm :)

--+B+POWgoa4oRXj9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9QSAAKCRB4tDGHoIJi
0s3xAP9xfERgJYWwp91JSzbDRFKYw4w5xo9wAGNdd/S/HIdDswEAxtiq3TzF7k/n
AzODJFBDz7sd0os8z8tIIfjTeSg8pgc=
=HnPT
-----END PGP SIGNATURE-----

--+B+POWgoa4oRXj9t--

