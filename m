Return-Path: <linux-iio+bounces-5772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4935F8FB9FC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFB11F279BB
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF914A09F;
	Tue,  4 Jun 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3F4MXeR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DD1448ED;
	Tue,  4 Jun 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520891; cv=none; b=T9hbAYHxBUOsYXOBitcxAz6o22bFszJn+xLxu6l45afbffNfT9qF8OHSoDCg8Tf4xxDcQ5M91sNOcoK6AIGJAHGw+SMDWH/NmpJdGcm0yY75VQ1gSyJhNTqSux/IX1P/LaR3DQhVHiSsEEFQaE9pj2JONn3P3RmpD1AvH5Hh1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520891; c=relaxed/simple;
	bh=zZwqUq8UB3lZw8ZHq67It6f1xU0qfYN/Y2P5mJdxAdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmsR7+HvLBO119m53u9/3o5R7ka3blz8gWcBvmDeUcipMtoDlkauq7DRJ+bJDBzuX0DxmKpywo4VzX+UqKw2SSgZYAzaw8ssnX4MeUH/FPg8L+Ps0L2jq2Ysabab6FBphA7DDed3qKkawC2/plmpbt8pBNFyemvEdg25NAkE0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3F4MXeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4837EC32786;
	Tue,  4 Jun 2024 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520891;
	bh=zZwqUq8UB3lZw8ZHq67It6f1xU0qfYN/Y2P5mJdxAdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3F4MXeRwse/SRBce+SUr2Zq8RPX6shwEcJjxK2xHFQBuRmx9ddeDTT0Z0z/+vlgy
	 4LEFj4W/GluV7dfuqbAwXpOg5ngW9vpCN8aEHg4cMH251DwyTmyypeamNl/QgMyGjL
	 zYEdon02Z504wlLfv1Pg/yOIXJ7GO23o6usmfiHYinxqCb6lfyyz+LjYaBZJa36RVK
	 Y/Tyt87X1dweLz8GM84dyKlVFU3woCoV4gMAicx3Zg9U+qv4vxWvrH7FfsHcQYzuHv
	 /7/n1GiWsqZp++oxcKrALz9OeLAXe/rpfhwbKFqFLXFIEmNmMS6r8LOKw8QJKY7tab
	 UeJB1BLE4LKgA==
Date: Tue, 4 Jun 2024 18:08:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bindings: frequency: adf4350: add clk provider
Message-ID: <20240604-chatty-evasion-40e72edcfcec@spud>
References: <20240603112447.23308-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0nhjNXGCDwJyc3Zw"
Content-Disposition: inline
In-Reply-To: <20240603112447.23308-1-antoniu.miclaus@analog.com>


--0nhjNXGCDwJyc3Zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 02:24:43PM +0300, Antoniu Miclaus wrote:
> Update dt-bindings for clock provider support within adf4350 driver.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--0nhjNXGCDwJyc3Zw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9J9wAKCRB4tDGHoIJi
0g60AQC/gTaqrRaPMs415GO1W7m6CIY/OIQHl6mCLEwsgm1I0wD/Q6gdDQMspBiL
5kFL9DQhwkE3j7EpG1Hy47/njbkGGwI=
=ucf/
-----END PGP SIGNATURE-----

--0nhjNXGCDwJyc3Zw--

