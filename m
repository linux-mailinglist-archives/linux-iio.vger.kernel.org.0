Return-Path: <linux-iio+bounces-7449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DFE92A7D4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D59E28214D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF7146A79;
	Mon,  8 Jul 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFChjORz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6E78C73;
	Mon,  8 Jul 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458400; cv=none; b=MoUJ7V7vLRdrodF9uDg0jPIrUIZaholCULIFkWzeEEQILh28+BH3PA6VXYdkTn/pc1lD8fo6oQmdBylyfmrSRSZWTVYAhgb/I4DdiGC8Sc/GKh0f3yYo79EliQY6jrhTtss8zQW++qLqC5uT+W5twpdd0UiiMTHATdaMxBSmUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458400; c=relaxed/simple;
	bh=2f8q+yRV/YZzbTa6kjlhS3zOQvqRz+hKZA8xbKefsrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx6aSBgNZ2jrPk2YUBj6XUyRbzYKe4uwriF3I87NraeKt3k2k+A10JR060prL7w5tokWBoWdogoDvw6nYRWrn6LyKwCSzqJBZPyCbf6Pee10mbW8Gxn34Fvv/lVvAAWxQ+Q4In7HfibarUnC1u+9j1RqlRX9dxILNR14zpkFACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFChjORz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01740C116B1;
	Mon,  8 Jul 2024 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720458400;
	bh=2f8q+yRV/YZzbTa6kjlhS3zOQvqRz+hKZA8xbKefsrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFChjORzkrSRvpg0qf9hHSbnArYrOkY2sDIzeW6p9z7TqmeC+oJ+lqIgmqsWPWaeb
	 /7ehneH/7J8a87SH/FobPdKtg1kLkzFzs5LKXvgu6MWhxlXfN+vFA6MTC1pWY1xjr6
	 81c/TamG9SfB12BBHulwa/DwF/6k/alnZ4ZpWZrsoH595EycNULqwhjDeltiMQ6my8
	 b4OHVObh09TD7m5mKkw/ht1cK55lt3T5VKIVEtoyLyyZTUaT/Gr9tkoLmGsPKm18OR
	 onmyzQ/y6Kkhqy6afMMv5jQBss2zA3ejKWoDv5dYLWRirE+jXHF4qlMUmoOraH1Rps
	 j40p/oiBWYNyA==
Date: Mon, 8 Jul 2024 18:06:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: BU27034 => BU27034ANUC
Message-ID: <20240708-tropical-stifle-0aca848ad340@spud>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
 <c39f9c67b3c07a27d7a13109c7b69cff9cfd2b9b.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v12WfoeUb24sNLN2"
Content-Disposition: inline
In-Reply-To: <c39f9c67b3c07a27d7a13109c7b69cff9cfd2b9b.1720176341.git.mazziesaccount@gmail.com>


--v12WfoeUb24sNLN2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 01:54:12PM +0300, Matti Vaittinen wrote:
> The BU27034NUC was cancelled before it entered mass production. It was
> replaced by a new variant BU27034ANUC (note, added 'A'). The new
> variant gained a few significant changes, like removal of the 3.rd data
> channel and dropping some of the gain settings. This means that, from
> software point of view these ICs are incompatible. Lux calculation based
> on the data from the sensors needs to be done differently, and on the
> BU27034ANUC the channel 3 data is missing. Also, the gain setting
> differencies matter.
>=20
> Unfortunately, the identification register was not changed so there is no
> safe way for the software to distinguish the variants.
>=20
> According to the ROHM HQ engineers, the old BU27034NUC should not be
> encountered in the wild. Hence it makes sense to remove the support for
> the old BU27034NUC and add support for the new BU27034ANUC. Change the
> compatible in order to not load the incompatible old driver for new sensor
> (or, if someone had the old sensor, the new driver for it).
>=20
> Drop the compatible for old sensor which should not be in the wild and
> add a new compatible for the new model with accurate model suffix
> 'anuc'.

Since you say that the "old" device should never be encountered "in the
wild", this change seems fine. If it turns out that it is in the wild,
the new compatible means we could resurrect the old driver etc.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--v12WfoeUb24sNLN2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZowcmwAKCRB4tDGHoIJi
0tiaAP4sGu3u4NXB0ToW0RMaH2jH1yXUHtCuWfIAvY3lKfNlfwD/UqcHOyuamhTn
WUqCY0E3qrPVCZPbSm10PgDJrOGqiQE=
=j56h
-----END PGP SIGNATURE-----

--v12WfoeUb24sNLN2--

