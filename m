Return-Path: <linux-iio+bounces-24300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB43EB8AC6C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65745656C8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56B93203A5;
	Fri, 19 Sep 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MluRj6aU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0F3D6F;
	Fri, 19 Sep 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303245; cv=none; b=U5wqvQRwp7auuGIfCdtx/6RMiW8/ukvYcr2uyuWVX+1FBpa7biJAB6UsLv+k1RxkiHyclBx2FUBUWt4DEuNm4ELdvPxfrZyerr9QSBWtrLUzhpwKhUtmZ72oXqftUgdBYKKkh76RweqS4XCf4CwsnRXMTbsR2zKnxam2ET1UGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303245; c=relaxed/simple;
	bh=vCQ6D5J5CAQvg0sdxYgrNskq7byvIRLv4uaL0udKG5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV73co2PFH5NgcbyC6MXUlKKps1hA9bWegJyHfgabeeAYcNAG5XGvqh1QNP8j6kJ93Vh4N9AGIpsDqfREASMYbIorqfN8VygJcctTsY1hHpHjjVOe1ymdfvFo7bIpW1yM3++VvNdaRPtitp8hHHKFo3aM2BVUg5w8nWy45x6qeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MluRj6aU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20681C4CEF0;
	Fri, 19 Sep 2025 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758303245;
	bh=vCQ6D5J5CAQvg0sdxYgrNskq7byvIRLv4uaL0udKG5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MluRj6aUTxugWNeqizksmK6Xf8WHDHwsmsc4uKIIr8cLLYnoEFztphItYn9OW2WCW
	 XH3gl1WUqXBQlkk0WLhI/4Mu/OyHW2QG812cXJK5zagYX8Xu9rxuFPQ5f0i7a2VZlG
	 WZ1UJS7YS30BZs9kIgLA6HCKtxfyS29SomBCFFYDnUrG+gzDyDf2k3PqQeLap6pFKR
	 fmKuUt45BHB3lNoihgsPQst6AUY+nM1lZC5Dw6bpT9UDya5VyQ+QGV04aoM2rKtiGf
	 FKhjZnPxi3nI8QA6ql2faacp35mEAj8KPMQihWTcQNk6H+6tXBZZsbOEo4g/Z527yA
	 8Bfgge0xchO3g==
Date: Fri, 19 Sep 2025 18:33:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: adi,ad4030: Reference
 spi-peripheral-props
Message-ID: <20250919-donor-skimming-8ef77871d68a@spud>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OIKEdUZQ//aS5+WY"
Content-Disposition: inline
In-Reply-To: <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>


--OIKEdUZQ//aS5+WY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OIKEdUZQ//aS5+WY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2UBQAKCRB4tDGHoIJi
0sEdAQDxz11ig5hXac9ko6qT98sPo3xb5h8BBmPkcSHyGeyvGwD/a3YEKu1YBCWF
t0Vxll2Kdg4KTtl++zkY86UxJKnyPAE=
=LQyr
-----END PGP SIGNATURE-----

--OIKEdUZQ//aS5+WY--

