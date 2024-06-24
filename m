Return-Path: <linux-iio+bounces-6820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B85915344
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 18:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DA02842AB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001AC19D8BE;
	Mon, 24 Jun 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEFFLmLk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE913DDC6;
	Mon, 24 Jun 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245834; cv=none; b=uupJryswhtuw8AfZ6EgmbgggGRhnZvI7xQQy+AUGuKT20epSh9wmukqCklLuF5egaidz+dgDaQPeQPOceHIJRBZ8wLw7p17ybH3937eFSBnZpqLAKINmNtIJhC4EbBDZBiKgx8EXEuygzC+CELr4pEjAlqpizsjDTLFLmzg0QOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245834; c=relaxed/simple;
	bh=G2sxdFsTxr7RA4qjGwfzOJNZ0GP/hd8MYF4BTgRUa9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds3vu1JzxPEdZbrRTsoYEYOPSY7wsbdBSY8A8vxB11uOFGeEUDEWwpD7wAZDABVPgTU79VDeZztbPDS7yGX5n1VW0SRnAH1tFYToT3XuFFqqVhWu7AKFa44Jn/wlvDIdWiduT67DDt7Qg8jf/f+MSQNNgHw/nYsWfIFSLstu3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEFFLmLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837D7C2BBFC;
	Mon, 24 Jun 2024 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719245834;
	bh=G2sxdFsTxr7RA4qjGwfzOJNZ0GP/hd8MYF4BTgRUa9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEFFLmLk85FB3OMDkr13U06FFWVqswJmcX2gW+8EJB6RjzQiod9Ejg6NLc190fdNG
	 fdSMX9SifwGwzGIY3J+gOftvmtvC6LSFmESQ8ptLBlj7E+3ZjQ32dw202T5Kv3i6Zr
	 VUlUY0O64Wf+8xJfzceSajyXuj61lRmM7vJpO4xoU5y0wn4yGTRyJD3N0prQyrUVGK
	 fxc9VRjKAU8bXqpuT75N/4h1DL6/702xSE0wjemij65BfqQCnpGFVz3SiwNdMXvvxl
	 vOxt5grCz6FOYSXLxOVwQkf5TfWX5p5tu9Hd3OfMmcgxbHaDN2o4E36eyYE6fw8TiC
	 zFmop9o8k8K1g==
Date: Mon, 24 Jun 2024 17:17:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 4/6] dt-bindings: iio: adc: ad7192: Add clock provider
Message-ID: <20240624-fernlike-angelic-6b0186582da4@spud>
References: <20240624124941.113010-1-alisa.roman@analog.com>
 <20240624124941.113010-5-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OEJS82OpTViVDGDG"
Content-Disposition: inline
In-Reply-To: <20240624124941.113010-5-alisa.roman@analog.com>


--OEJS82OpTViVDGDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 03:49:39PM +0300, Alisa-Dariana Roman wrote:
> Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> clock provider to support this functionality.
>=20
> The clock source can be either provided externally or the internal clock
> is used. Pair of clocks and clock-names property is mutally exclusive
> with #clock-cells property.
>=20
> Modify second example to showcase the mode where internal clock is used.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--OEJS82OpTViVDGDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmcBQAKCRB4tDGHoIJi
0qCPAQCEGx+ielhD+8g23GthfhGWy71wJMnkwWZvjo0RBnNTNwEA4r46R7KmHJqQ
GkVj4PUXo3oozwI3ziRn9W6tBTmU6Qw=
=4bTK
-----END PGP SIGNATURE-----

--OEJS82OpTViVDGDG--

