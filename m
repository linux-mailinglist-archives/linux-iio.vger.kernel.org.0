Return-Path: <linux-iio+bounces-11948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38369BF220
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315921C26332
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5223205ADC;
	Wed,  6 Nov 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9HLUjdY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AA1DFD87;
	Wed,  6 Nov 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908026; cv=none; b=hTHHI/mqhbVqMDrlZKjPePVjZtMfaJ8wm6bULXBoBF4mRmQ5JP0bIkQKRKfssH8FKRlATuHw5Y7MrYUmv2REivPc66Vk2Q8wkFEmiQjU2jZL3TvySL3DDKDKuO3dYVCI03XYVATcRoahotQjNnPZ7dr1yCquhD81RVv6qg11R28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908026; c=relaxed/simple;
	bh=8lbGqJHY73uBPSfmVU0xiiMipRoMO+tIzDfLTjIAcsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVGbzCPHTvxO2Yqn8F9P3KoqaiHJecx9BK7FQXkbnyuEqM9jBDITZzrljsjNlUJVjqq6PICCyUktw2pZGnLJwbMV4JoOx+j9nQ45TjzBLU3UCC4bLX/oujwpy6279eBmaNuEm8vLdtOvuiTxqai1Ub2TenNX7UP8XeHgpDFka00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9HLUjdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5410C4CEC6;
	Wed,  6 Nov 2024 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908026;
	bh=8lbGqJHY73uBPSfmVU0xiiMipRoMO+tIzDfLTjIAcsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9HLUjdYW5h5t1seMKXIJdTeuV/CNRnbkeMRfrndnvvTDRfKUNSp6Z9XDby6clIIM
	 bLs489/CO5wZLoo2eCGT6LqmBTL17VarDQcxBryeLBpgP/hW0HutPxG5PPf+fKr5eg
	 Kh0Z9z/I1LbAxbjj8saNVsCFBVtf9OtuXgmhhKKxuuz8l0M7Xkkrj8FBiD51mm9TBw
	 Is7tVVVxbYWf0zA7vRTtCF3VPdLAjONcj+ygU1VpGOyZ00ErphvqHLfduS0HfneXTI
	 ZxeJOcrcCZ1O/R+r5ciyRNDq4TjVec9nxM17ni3alXrh/Mx9Gl7u7nCvXj+HAioA/V
	 DbHCf8vYNaP+A==
Date: Wed, 6 Nov 2024 15:47:01 +0000
From: Conor Dooley <conor@kernel.org>
To: ahaslam@baylibre.com
Cc: jic23@kernel.org, krzk+dt@kernel.org, dlechner@baylibre.com,
	Michael.Hennerich@analog.com, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: ad5791: ldac gpio is active low
Message-ID: <20241106-tableful-outdoors-298ad815a107@spud>
References: <20241106103824.579292-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mn0ppnsPgnjOw68c"
Content-Disposition: inline
In-Reply-To: <20241106103824.579292-1-ahaslam@baylibre.com>


--Mn0ppnsPgnjOw68c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 11:38:24AM +0100, ahaslam@baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>=20
> On the example, the ldac gpio is flagged as active high, when in reality
> its an active low gpio. Fix the example by using the active low flag for
> the ldac gpio.
>=20
> Fixes: baaa92d284d5 ("dt-bindings: iio: dac: ad5791: Add optional reset, =
clr and ldac gpios")
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Mn0ppnsPgnjOw68c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyuPdQAKCRB4tDGHoIJi
0vRtAQDWYbkkjwjfH/Jyh9+9Vb+PhqhYnbpRCwL+og1vGe8BAAEAnfAYAHLqHTQe
M8c6kYLdS4J10mF3AdkqXhE34m6FqQc=
=h8lz
-----END PGP SIGNATURE-----

--Mn0ppnsPgnjOw68c--

