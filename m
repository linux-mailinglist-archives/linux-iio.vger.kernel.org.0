Return-Path: <linux-iio+bounces-23888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4964B49849
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742997B2885
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF431B10A;
	Mon,  8 Sep 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkbjJDGD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5A3164BE;
	Mon,  8 Sep 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356059; cv=none; b=HPulH4viNGa5yHBKgeH5dSeF4/TsP/0XxBj7eZNRyUUXJfVRvfI5jxdv1kC7sYR/kAhuFs1S3/ZlQdgJCBrEKCN35xp/FtMPe1BMFFPs8azgETlJpdHwxlbTDbsp6uxWf32kFrAMMQDF17bAvFCVJV0upqzRMHuFGmpZ3MtcfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356059; c=relaxed/simple;
	bh=eHyvwJfyU389ryIw9y/fXvZZGhXTbqPRmEfdge7Hf/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJtJPmIzTM7ZXfDHHj39n/wYxxpKIszbIOVvnAeisU9+pnFyQn8r+bAYjvx5Jx8H5n5m4ElrInubY8HZFekEDO59r/j+orpGqIcVyyN+fP1oK0BxGSUO6Lod8yaU9EMm2YPxbmHqJgrzij0UHM1RA3r5AyTZsyQ6GJ7ozfWM8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkbjJDGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907EDC4CEF1;
	Mon,  8 Sep 2025 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757356059;
	bh=eHyvwJfyU389ryIw9y/fXvZZGhXTbqPRmEfdge7Hf/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkbjJDGDAOAwuIcxTiyeNcnMAibwJDmZDKdSAwoS6l0v4PlnvQRXLeFzqfmRZFPgq
	 n5ZyVa1eYYCUYP9rtmUcIE5k+kyHRQVjBJ//KZpTd/m9y9rFpRoHEvbrpJ6GNY4jzo
	 8NmGbh9jdHZty3P28rCvMtR6Dpuq9k7B8jPuWrI4t608Ilc0oISOHsjEtDwrviqNMj
	 WGmbO/ONqt2L7LXskRlgkrQE0qKyzhZ+5aQqTFVq37g5NFm38QtuEdyIK7HRoADmjE
	 HUGskPhWDPC7c8tIZTzF4BykhAQAttZJkkspBQhpIEaf7irdF2XGiRt8wLKrEyQwdA
	 iv8lvdbx0B3ZA==
Date: Mon, 8 Sep 2025 19:27:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: iio: adc: add ade9000
Message-ID: <20250908-postcard-emerald-0f27e15d9c71@spud>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
 <20250908073531.3639-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q63LfRDEp4aXS8kd"
Content-Disposition: inline
In-Reply-To: <20250908073531.3639-4-antoniu.miclaus@analog.com>


--q63LfRDEp4aXS8kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--q63LfRDEp4aXS8kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaL8gFwAKCRB4tDGHoIJi
0hTSAP0YebM3AhQ/e14L/VcDm43KjoYrVD75tOv8wYIt7CyxUwD+MMel4xlGVahT
y/bsB7qjppN3Jzqi8Dbau1NZ3RXCjwo=
=8jxI
-----END PGP SIGNATURE-----

--q63LfRDEp4aXS8kd--

