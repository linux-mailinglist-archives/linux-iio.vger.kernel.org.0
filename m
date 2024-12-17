Return-Path: <linux-iio+bounces-13590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AC29F5656
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B411A7A3C5A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D21F8930;
	Tue, 17 Dec 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5w9r2zm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304871F8AF0;
	Tue, 17 Dec 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460276; cv=none; b=FqHBbcdDkS4teCXTAh/AluOYIO0BntQT/jIeLydh/W12k/hsthYxgRB/MF4y3B1xWrz5G1pZ+KRFjmZedSl4NgX2fyJDdFg5+Av4snM2jb+vDnNFdOb5YIKDJd+0UicjogR/0l2iUbLlMbNAvgBmQJk/RMAfYS+zbNFjk12CvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460276; c=relaxed/simple;
	bh=GAObJk0Yfgosp9KMX93U3UB5Xlzjykd+Mc2oGONgf+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXdEPKDdV0cd0BRvgPvlxqKcUouf7GVZMmCtFyGqGT0o/hn9GUUKP5EAkX9JjYeVfxHX592USV3CCSZpVkadSPWM01MCjivrze/Fo57Y/PH9sBX3p28xdZi5+h1j+24WL50wO0pkbdStZ8dPcxDTIjb6B+QbWlWcBGRjfkDpjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5w9r2zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E75C4CED3;
	Tue, 17 Dec 2024 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460274;
	bh=GAObJk0Yfgosp9KMX93U3UB5Xlzjykd+Mc2oGONgf+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5w9r2zmvH38bUiC7L1IG1hZEQKRiYiWgHXHjtZpDK8tueiGuNL9DHxuZP+WFdzpK
	 qO7eredHd1CBi1srQC5xF+fDqUM4QMAQsM0h2a3utvPhxbhNdUFJa4o+OL3/VAFf/d
	 9WLzv5Ler4SPOgxYAHpD3rmdRjIGtUgaFCTa02DdswgHOPYuFWk73G+b16/O+rSEDr
	 i2YkGHX0ioKOxtFMlYo+ukKWtYw7DUEEWecQtslMaW4OGLTfX0C83iLFbwM0NTwjOL
	 WlBJlze9cZCZovx9SMA8XmF3hfJWArvbTJVmltW0Przx3FSa7NDKowz0EFAZA14npi
	 RyfPJXXoYPeOA==
Date: Tue, 17 Dec 2024 18:31:09 +0000
From: Conor Dooley <conor@kernel.org>
To: mgonellabolduc@dimonoff.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: media: clarify stm32 csi & simplify
 example
Message-ID: <20241217-brilliant-jubilance-54641c6ba990@spud>
References: <20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com>
 <20241216-apds9160-driver-v3-1-c29f6c670bdb@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CpCfpLzPvqQyQS/7"
Content-Disposition: inline
In-Reply-To: <20241216-apds9160-driver-v3-1-c29f6c670bdb@dimonoff.com>


--CpCfpLzPvqQyQS/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 05:55:40PM -0500, Mikael Gonella-Bolduc via B4 Rela=
y wrote:
> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
>=20
> Add device tree bindings for APDS9160
> Note: Using alternate email for maintainer
>=20
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--CpCfpLzPvqQyQS/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HDbQAKCRB4tDGHoIJi
0mzSAP4l0iYkVJ4K841MVb5zASg1PE5Xsu7UgDMqFS1oGZTfswEAum0NTyv0erzv
MIXXCRJhOqlFKFMKxHlFYcJd0jzGfgw=
=rX52
-----END PGP SIGNATURE-----

--CpCfpLzPvqQyQS/7--

