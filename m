Return-Path: <linux-iio+bounces-904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2023F8118EA
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 17:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9121B20E3D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D5333081;
	Wed, 13 Dec 2023 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of14jwS8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F92D604;
	Wed, 13 Dec 2023 16:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F673C433C7;
	Wed, 13 Dec 2023 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702484150;
	bh=ZqEBUHrDEyZ8vkQ44qaY7mZTN79QNnv4TScFFLk5+vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Of14jwS8A1sZTdZkNDvtnyx9NBrsJmwu737MeFhswh8XXSiBr2ZlfgLkFFrPcrseI
	 KBcM5cBSsQI+UcM3ZZiTaTN7Z+MQcE0kNpaiv/87K0My92Xf6wn+fJ9tCyX0BvTMEK
	 4PBODvEfrqMvCS7WA1uhWfnGh4AxbqVfm8Uk/2qq4+9TKTTHIk/F18X554kqp+4ouc
	 tPoBmbP+R3AfoxCxjYfcY6zRfw/WnD8pW4s4gXIz2s2oUgpI4s1VJaJ3djMcjeSYDL
	 NuClBDQsLOdksM5b9yt/M59A5QY4GBocz0L1+lEPL+NqscUSFnFbawvcoAr43/KY5D
	 fF5lXh+JjohfA==
Date: Wed, 13 Dec 2023 16:15:46 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Message-ID: <20231213-jogging-void-79416ce73560@spud>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
 <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B/2uj1twGd2QJ9G1"
Content-Disposition: inline
In-Reply-To: <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>


--B/2uj1twGd2QJ9G1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 05:21:19AM -0600, David Lechner wrote:
> This adds a binding specification for the Analog Devices Inc. AD7380
> family of ADCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Having read the patchset in the correct order, this patch now
seems fine to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--B/2uj1twGd2QJ9G1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnYsgAKCRB4tDGHoIJi
0tpwAQCxYBiFQmCqom4mwWDb0e1I7dm/40px79kV8XltCtJiWwD+MU13YNO77cic
ua/woQGNvZ8oc4ZH3wH9XYPxa+n7Ogg=
=nkrt
-----END PGP SIGNATURE-----

--B/2uj1twGd2QJ9G1--

