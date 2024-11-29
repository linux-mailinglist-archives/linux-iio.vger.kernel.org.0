Return-Path: <linux-iio+bounces-12820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB19DE96F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67587B231D6
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926E14658F;
	Fri, 29 Nov 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoG9mMV0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335E82D66;
	Fri, 29 Nov 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894340; cv=none; b=TulH09QdFMVg5yHb8Q0NJ5tKDIezuVcxJzbcFKQbtasRjvYSELkhqn80zAtac7+0TGF+J+lPCXProqftxd7Pxxd49NUw8pbD/qhKS/JSB+fPOmpntypM8S5NhPzoY2skLghiYNSHCIM4FBdxiyXQxgy0FYaubj6chPxMPrIwog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894340; c=relaxed/simple;
	bh=ean5uOlXU7YQbgBBWb9aZHQqsCwn5eYutohhiNlRqTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfoDv6dg2JwrWcbeFTKSMl1g4s8Se+PQEEFv4Mm9DaX06xSwtHBX6kqeULoVmW8artF7Age3LURFaZT4s5JUQexYRAxXnoPK3lcRPrSmyYJpGiZDPAXPtLd8qRU2eN9k1XIbTaE8WuuIt0zIeN+T9mJaNzEaBa3okfqBxw+frPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoG9mMV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C25C4CED2;
	Fri, 29 Nov 2024 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732894337;
	bh=ean5uOlXU7YQbgBBWb9aZHQqsCwn5eYutohhiNlRqTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoG9mMV073BwdFpzgwm5oS2YIjkvCAmK2/Khxy7gYgPfFm5fi8CT+kXgVfF1W7DGD
	 6a0dxAB2phRo3HDQGm59dm3LAElH9dw8c9R15sb1OU0L7qBzc96IJAt7aMruWRW9w/
	 WD9DTScv0pQLTFmJMbgsAMOB3VmD1OobY83rJjc5PMojqJ8qCo7u7qHBDpITN45SvR
	 5oMTrhz9Tiig1rzIicPmW8UIvvqP+XYip3eFUSHVWGWabsboX9EDzlWEogm48BaQxd
	 GdjJLBHkzt4/PAvIUBX0l/qyJuBfxCMmha3PwWzD30YJXqWnv50A7YCSDR099zCkjC
	 5SsPhf402dS6w==
Date: Fri, 29 Nov 2024 15:32:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: Drop BU27008 and BU27010
Message-ID: <20241129-decency-haphazard-f121207c90cb@spud>
References: <cover.1732819203.git.mazziesaccount@gmail.com>
 <3be66a8ec15fedd18ef13afae48ebb182196da13.1732819203.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gIB4Jymb2ZQVY78O"
Content-Disposition: inline
In-Reply-To: <3be66a8ec15fedd18ef13afae48ebb182196da13.1732819203.git.mazziesaccount@gmail.com>


--gIB4Jymb2ZQVY78O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 09:35:35PM +0200, Matti Vaittinen wrote:
> The ROHM BU27008 and BU27010 RGB sensors got cancelled. I was informed
> they never reached mass production stage.
>=20
> Keeping the bindings around is waste of maintenance resources. Drop the
> bindings.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--gIB4Jymb2ZQVY78O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0nefAAKCRB4tDGHoIJi
0lvDAQDShvcW9sCaieKogYV80HikoC61aNp5Aqv8B02YZxACQwD9GMVpciDmMUWI
GJfDGfpK6cajesUxhn+0uds7tAKergc=
=diSv
-----END PGP SIGNATURE-----

--gIB4Jymb2ZQVY78O--

