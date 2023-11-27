Return-Path: <linux-iio+bounces-442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526F7FA848
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABECB2108C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE13A8FD;
	Mon, 27 Nov 2023 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN1SxPcI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453E3A8E7;
	Mon, 27 Nov 2023 17:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770C3C433C7;
	Mon, 27 Nov 2023 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701107318;
	bh=UHxgCDDpAo/TxqcZDLyIiJF5h1XhVDW7jP9JPkLTBt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RN1SxPcISU2nHhglBq6qAmJ+oN3vU4+IcHatPGKa53DrpVh2LUopXY3+SEBIw5s52
	 IO94PmRohQknBtqgQQuLHO6Ib0wkxbIuO5npalmjI1hfDdWpD26dbbb6LytYkrZpzp
	 8Re/mS0uzKBFhkWLJNaA4He7grhgcrl5IE2FWijVcENnh4D1rwvBHen5m6SFP0BWKM
	 OxqcHVokM+3RmuTobceMcY4es7HktXPtC+A77P6yLeBMLa3ve7u/AGtW9kN4w6GKdV
	 boxWQLP4OumtkEr+WxkuExOKi0enfTSA2Y+cvD76rFzFaknU1QZitdUUjvPjNkpiBw
	 nRy8iYXQqujHg==
Date: Mon, 27 Nov 2023 17:48:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ana-Maria Cusco <anamaria.cuscoo@gmail.com>,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740
 Attenuator
Message-ID: <20231127-mothball-straw-6bb5b4f7cfba@spud>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
 <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
 <20231113-discourse-sushi-e8fea2450a44@squawk>
 <20231113-left-patchwork-09a1f88b0fa2@squawk>
 <20231126163922.74505322@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gWy9DPXI/ieLWrLw"
Content-Disposition: inline
In-Reply-To: <20231126163922.74505322@jic23-huawei>


--gWy9DPXI/ieLWrLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 26, 2023 at 04:39:22PM +0000, Jonathan Cameron wrote:

> Trivial thing but Ana-Maria, I'd prefer a cover letter even on a short series
> like this. It provides a place for general comments / discussion / tags to be
> applied and it gives it a pretty name in patchwork.

It also helps patchwork detect when things are a later revision and mark
the old ones as superseded, which is rather nice :)

--gWy9DPXI/ieLWrLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWTWcQAKCRB4tDGHoIJi
0kl3AQD2InbgMa+Bs8tamaz6fpZwTHOtM7oAaIsxd5gmoHI86wEAjyHlrHoH2AQf
jfQwFWRp6C1rwfFNxrnhItnr0B7+OwA=
=6kNv
-----END PGP SIGNATURE-----

--gWy9DPXI/ieLWrLw--

