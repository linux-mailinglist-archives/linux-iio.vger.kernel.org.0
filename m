Return-Path: <linux-iio+bounces-25629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B677C1C9B4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 18:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D704F6447CF
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147E350A1A;
	Wed, 29 Oct 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOYx8S1r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CD2EF662;
	Wed, 29 Oct 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759271; cv=none; b=FGuWrRGd4nMRgyA4hOteIWN3KYLNuNPtrt9JdKcEOG/vPut4pzhPYzFCL8SKGG3K/v5AGipb7hJFIrtNzrb/xRFGwMeWho3MfogBJsJ6JGZ+o91kY7uqIjgYDSJgn98PD3TNV2W3Mq8TNSSQoGPePbcBiLnlZLnrEtEXsbfd4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759271; c=relaxed/simple;
	bh=cQ6u8qLg9RAS3sQx0DZqTPCs2pfg037ebM1hlPoMVXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ42OKdX2YGK3Fqla5TtbNeBGWGuvwKamvXh//0nFDGGjS67ovO+oNhQtrJXlTp/sn0a4cJ9Q4Ea6AhABi3NZZ/QXbjJvvCj241eB7OiYtRcaOAHQyMtAKiPaoPQv8QmF+NjBfklm3ewIhTSSV7fFfTTIh3/A4Y7hWH8256VMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOYx8S1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F1EC4CEF7;
	Wed, 29 Oct 2025 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759270;
	bh=cQ6u8qLg9RAS3sQx0DZqTPCs2pfg037ebM1hlPoMVXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOYx8S1rgIjusrjqz5VxUMOjhk3aNW3LmV8MgkEo9Y9VNnbrIfBVxoYuTwPg0nHtL
	 mcCUbVOpfKeEC1cN2axA3/YfwSHw1NIqe+l2nK9wdbUGlODAR5j0KGXqdlUsCcKo07
	 XCEA1Sj+AH3NDzVhiD/KqQZnOFBZHietE9xwzC47GnjefybvJdeFi2qNXV2PR3moN6
	 JuIWWbFOA95vl2vJtR9ZATQvdc/V691BkICvNgzU5sjWx/dpSRdnpb/uThT8ht6YzC
	 tgn1SCfDnm6Inqnf3/WDDK/5H0WPp64DjCCwtyPt4eJAvSv7otHsWS2HNvgyyBd+mc
	 zqMge5B1EBpoA==
Date: Wed, 29 Oct 2025 17:34:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Zhiyong Tao <zhiyong.tao@mediatek.com>, kernel@collabora.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add compatible for MT8189 SoC
Message-ID: <20251029-gamma-unmixable-05a8c5dc0960@spud>
References: <20251029-mt8189-dt-bindings-auxadc-v1-1-cd0496527a70@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kATwFr4KYeHZakeU"
Content-Disposition: inline
In-Reply-To: <20251029-mt8189-dt-bindings-auxadc-v1-1-cd0496527a70@collabora.com>


--kATwFr4KYeHZakeU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 03:52:53PM +0100, Louis-Alexis Eyraud wrote:
> Add compatible string for MT8189 SoC.
> The AUXADC IP in this chip is fully compatible with the one found in
> MT8173 SoC.
>=20
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--kATwFr4KYeHZakeU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJQIQAKCRB4tDGHoIJi
0laNAP9C38Qssv8uwb97bAU24YVQ1YwFUV2QSTpsq2dvEnILjgD/ZpYNtjV63fqu
FACQa0/m0zVdoiWZl+u4KK02fETcsAA=
=yxko
-----END PGP SIGNATURE-----

--kATwFr4KYeHZakeU--

