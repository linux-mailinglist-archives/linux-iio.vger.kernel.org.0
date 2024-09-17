Return-Path: <linux-iio+bounces-9631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2457397B4D6
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 22:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571361C22631
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C3318DF78;
	Tue, 17 Sep 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Viqs6ibC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44016132A;
	Tue, 17 Sep 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605770; cv=none; b=PJ2OizWqGahvaq6qhkJn3vz/RpZuDVhLcthe/11y5GBr9t/GhPUXcHYhNyNMG5+AvIv6xpVRFWPr2Kw7tawlee09s/iHhavav/suoTQpX+O618a4XPNx/dnx2RMyeMNCi5sGWqp3whiM8MV/iabBh4EdhHORXaFQ5VPa3ClHdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605770; c=relaxed/simple;
	bh=QVQ9Zf3POETeZPyRHvVlkQxaUC5jEAfKRbazajSyRKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lED/a6BwtgWubXaZ0WKLek43+NhOhFYqu68lCZl2J52zDg1zR1Me8xmLNwdW2IfZ719L2GDu1yL12OmtutOdgjS38ahs9VQcuoojVu7BKTm9F/5sxM0m23TPS9Wq5SXDHORiNkJm46QEo95o1rWWG+inwmSgLPsqI5NcmgZO4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Viqs6ibC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75035C4CEC5;
	Tue, 17 Sep 2024 20:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726605770;
	bh=QVQ9Zf3POETeZPyRHvVlkQxaUC5jEAfKRbazajSyRKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Viqs6ibCrVs1RM3yE7hLJ16SYpsdipLV5ZsFRlEVLJT3gC7wHbrRElsOdNy5ScAuj
	 UxB7TTiwxpv9BVGZDEuVLvP+RNxkN3zCXJxyEKs9RtCVi1+JP1fZfvDF2Ma8IItUwz
	 JwlfoG7B/r/g2G8qmI9qwFrLJqQFlIdoUTx0b5r3W5lyZocyUAZZ3DpwFoRhFJpk2g
	 IGUSfwlH0EzFqVialqLgHMEkULolr/ms836YC1kVjQhnoh+wHAKfJkLlxQ4mpWW2p0
	 Jdr3XbBFasS7ZwPyhNOdVY0CkVJ7NESCzMRBomD2GplB6jQnR24YHUcjpsFk3PY5HP
	 g0AiUFktxiYTQ==
Date: Tue, 17 Sep 2024 21:42:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
	Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Message-ID: <20240917-frail-caboose-772b9818b0ac@squawk>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
 <20240913100011.4618-2-Jianping.Shen@de.bosch.com>
 <20240913-curled-cement-0434c7b56e17@spud>
 <4b2e30c8-8fdb-4084-9fdd-adff904fb325@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+eyKeeMKboF2FCjP"
Content-Disposition: inline
In-Reply-To: <4b2e30c8-8fdb-4084-9fdd-adff904fb325@kernel.org>


--+eyKeeMKboF2FCjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 06:58:24PM +0200, Krzysztof Kozlowski wrote:
> On 13/09/2024 19:54, Conor Dooley wrote:
> > On Fri, Sep 13, 2024 at 12:00:10PM +0200, Jianping.Shen@de.bosch.com wr=
ote:
> >> From: Shen Jianping <Jianping.Shen@de.bosch.com>
> >>
> >> add devicetree binding for Bosch imu smi240.
> >> The smi240 is a combined three axis angular rate and
> >> three axis acceleration sensor module.
> >>
> >> * The smi240 requires VDD and VDDIO
> >> * Provides only spi interface.
> >>
> >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > 3 reviews? Doing well for yourself!
>=20
> There is certainly mess here, but that's correct. We both reviewed older
> version and then new version was posted ignoring our tags. So Rob gave
> review.
>=20
> Changelog is so vague that I have no clue...

Yeah, I figured something like that had happened. Just a tongue-in-cheek
comment ;)

--+eyKeeMKboF2FCjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZunpygAKCRB4tDGHoIJi
0r1YAQDYdNL/jpeu8uUfphQMDTqSMNwIH83uTwHTOEQ2cU0/7QD/YyaOt5YUrt+s
K00NgY5PAxrOS8OS1N5KzmmHykckMwE=
=rDJu
-----END PGP SIGNATURE-----

--+eyKeeMKboF2FCjP--

