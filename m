Return-Path: <linux-iio+bounces-7017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1091C2FD
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE73D1C22945
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A51C68AE;
	Fri, 28 Jun 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzY94ja1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C81DDCE;
	Fri, 28 Jun 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590036; cv=none; b=ZWu28ALrSw3iiB4Sd/EFNhTL0vXTVjpyWG0RDY4xeZXUppMBRzKXQ1oR7TnuEJ46Ooxb9w/lHAeOnYz2sMm1vwBEjQkZhuKWgEGAn2T4LdpGLKC1nu+XNmt7aQsUucJvsBfx2VeXNyyN02b/jbtH35lAMV2QUPb0zftUF9Kw1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590036; c=relaxed/simple;
	bh=f2DbslJCY1gFdYcU6f+K7BGTq549TBoQpQaAN0WbFCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip9RvnmpuAwCyABuTp8pUhzTdgQGYMLjzG5GUuAZ0KNEvuH23KdE+Gb3dr3MeX7KlpLXx4YX9LilwZTwbMPnynunCy0/Ciehf0xD7pYBbyo8DhNFeLUSdOQ41kNl+a/w2nfeQBrrxXiz/7N/GC7gT6LYzu2lJjrQhgNq/aOudQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzY94ja1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA11EC116B1;
	Fri, 28 Jun 2024 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719590035;
	bh=f2DbslJCY1gFdYcU6f+K7BGTq549TBoQpQaAN0WbFCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzY94ja1U0YcPSsXed2k98HFyvkihNwVvJObp3QA1rt/FRFUm+HeB9lKnlA5UYfs2
	 aKswXYw03UB9U9gWKz3BebX/Gt57f0m4YPm2HLxdZc6SuPZxR4N/ICj+BkHn5Jhx4C
	 EwkWKOFUIfe76cGObwNDCnB5JsBO9N0XVjTXw80nrcx0Pp4uup7blUYlqgLFS8ttqJ
	 x+wgrmpR7fUU31qZWd61wQ+n+j/CZVOEA7ByhnnOsuMh6rxOxI+yqCPV/3pYDKF4EH
	 xRXp/1vdfto9EzNlj3e+wf4TBh8fUTgwthTjkyz4J8RbZ7W86XTImJh5wv92z4XTbT
	 0KPqVHymsOJbA==
Date: Fri, 28 Jun 2024 16:53:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 00/10] iio: adc: ad7606: Improvements
Message-ID: <20240628-trustful-urchin-741943d2e98d@spud>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lfrz9cr24dwOHE+X"
Content-Disposition: inline
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>


--Lfrz9cr24dwOHE+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 02:48:18PM +0000, Guillaume Stols wrote:
> This series adds the following improvements over the current AD7606's
> driver implementation:
>=20
> - Fix wrong usage of gpio array
> - Fix standby that was documented as ACTIVE_LOW but handled in the
>   driver as if it was ACTIVE_HIGH
> - Improve dt-bindings documentation
> - Switch mutex lock to scoped guard
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

You missed Acks from Rob on several patches that he gave yesterday:
https://lore.kernel.org/all/171952025424.477297.14698127361119381011.robh@k=
ernel.org/


--Lfrz9cr24dwOHE+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7cjgAKCRB4tDGHoIJi
0vGqAP9kkiynQc0u8lZgHbdNgoQtzknMP8zXuThf1eqF4APomQD/aHqSEiu1w8U1
G7zidcdXu37DkZjIbBGQTemOMyhyZw4=
=ipV1
-----END PGP SIGNATURE-----

--Lfrz9cr24dwOHE+X--

