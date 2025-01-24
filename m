Return-Path: <linux-iio+bounces-14553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16380A1B6DE
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 14:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6173616D0D5
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FE140BE0;
	Fri, 24 Jan 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTJp66Nb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863935947;
	Fri, 24 Jan 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737725723; cv=none; b=UCf5qc3so8uEXM4vVy6f9NgPFEaUg4tH1JppHyjJwbwEd+dmkrkmr0KncoJ0+oF4ATwi7ovfN42RvF8L4dSrhLEv12K5xWAQaUVV7orWWZvDvN2DgUaTNoZ4+dJ1U0+oDegPhkFM8NOF+qtLqVHOUG90KfYM/3KQ/S1O+SyYdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737725723; c=relaxed/simple;
	bh=TFsv3UfKcQEUe4LWmZy8joE4lsGXNnzFnSR4/jdYIys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9qhGKc1udjEbopnLJCCa8E0Xi8dU21en7g7xlrx4a5gxrU9X9N5t3FPTLm2HA83lbIvJN9ktQtm9TKDc1JHGvkVhHAqWzWrcumNrtb9rsInoXN9oBPaR4eVTqEWBnC+FoDxYCkgf+Mojzdv770spXlWHPOeh476DruuR3pHmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTJp66Nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59869C4CEE0;
	Fri, 24 Jan 2025 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737725723;
	bh=TFsv3UfKcQEUe4LWmZy8joE4lsGXNnzFnSR4/jdYIys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTJp66NbwqsqB1XJ7zHZLaZXKg9oppm5xJfJAH4QCuyr/X87rCiPyEoc3lb6+nZ+r
	 1CDAZ2ivTmLGmmmcx3mRqcI4wUs9JyVOiisZxS1thOMPu4n0IoD24apM+fbtDkfeIL
	 SFDFdQhdal2g4MZosJX69gh7BYs83RF27p1Ki9U7O8hQLMqwYA2kQneUAJjpfGenNe
	 0SFV7/m5GtN1rKeMU6o6cgsecWpufiYP+KuqKUIQ/yWJLot6shH4INjcxZy2Kaz4YU
	 79VTQe1LJ7tVXkCJyH6IpTkjuL3R+W6FgWfcB1/Ibh08iPQeLDzFjPmbSq06V0J4Y6
	 WZhBhAbB/5HYA==
Date: Fri, 24 Jan 2025 13:35:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: David Lechner <dlechner@baylibre.com>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 1/7] dt-bindings: spi: zynqmp-qspi: Split the bus
Message-ID: <ecac5293-ae70-4575-b706-58f877bacc92@sirena.org.uk>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-2-sean.anderson@linux.dev>
 <9f40295b-484a-48e8-b053-ff8550e589d7@baylibre.com>
 <46a7eba6-a705-4543-b967-e83ccc89e7d4@linux.dev>
 <6afc379a-2f9f-4462-ae30-ef6945a83236@baylibre.com>
 <2784cc3b-0b8f-4116-b34d-0de4ff56cf92@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pkerz/Ef+rgcHpyv"
Content-Disposition: inline
In-Reply-To: <2784cc3b-0b8f-4116-b34d-0de4ff56cf92@linux.dev>
X-Cookie: Earth is a beta site.


--Pkerz/Ef+rgcHpyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2025 at 05:37:16PM -0500, Sean Anderson wrote:

> Your patches LGTM. I will use them for v2. Mark do you have any comments on this
> approach?

It looks fine.

--Pkerz/Ef+rgcHpyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeTlxQACgkQJNaLcl1U
h9A/1wf+LwQC6JmRuJILYtffqfOtSDabDTmR6snmnjAjefCBKxfO/hAcNc2Q7Pex
z5hBWE5wI8Jospu0Z7tLTxnMTss99sjFPY8eVjqmNNxTqaT9hi6XbA7v6ZyRCRcs
In3EdL438Uqrs9m79GE4fqgSzniu+eKpo1gUnLDLP7cl2FgKs0VHPuaZzYFZ+PUj
X056bLr6i0jiwp5nMGKfWIG2CPtu3DkqtNNhlJNfmDwhe5hCEHGu/eimVFcxFXw5
W81T1KHx52bmeUWbhnDLaAsP99WaCgwt4VarQxGBRIF1wEvTxKvig3Vvd+7rMV9E
ZY/0pvaRX8141lF0IY4P9VBE1AddWw==
=3e6Y
-----END PGP SIGNATURE-----

--Pkerz/Ef+rgcHpyv--

