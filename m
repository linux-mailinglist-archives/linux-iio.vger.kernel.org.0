Return-Path: <linux-iio+bounces-6848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49759157CD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 22:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5732878DB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 20:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F53B298;
	Mon, 24 Jun 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsfj1GpF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF4262A3;
	Mon, 24 Jun 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260366; cv=none; b=PSP6RLjI3lNRm8nBNx81UZYUc9c8SQSJI778Tl9FjYz/p+W2qgqtalrBpvazb8AYjoDViXqdRwi/M49DHsqFww/Z7AasMswddJ/bSNIObdypIU3Lall2TsY+VzhIu68zleDUpGJmZLpUNvv3cLXVAv5WrbO5UrJDIDjwEWterUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260366; c=relaxed/simple;
	bh=ZWI+WtIGvYR17UMqNz82vONbomXghatUFx41IPHG+Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8OrEVA+P1dzeVcDIRynBSoFLZ5lm0c6VdEyhNeXR8+g+gquXKAHAogVYs3u0Xyarb7sPFCj3LdNtzfXKA6TSJTn9UNvhwttGjxkrWlxycGy+PdW9lkV9OGg2jDWLPmtTRjhaWpvFJLAhLGroeQR7axmZYEfWFewTXioCq7PEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsfj1GpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D5BC2BBFC;
	Mon, 24 Jun 2024 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260365;
	bh=ZWI+WtIGvYR17UMqNz82vONbomXghatUFx41IPHG+Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rsfj1GpF+DATbbyRJCT6poW+insoX30ZAW2hE8B0AcLmrqgtYhWql/E2S3P12ZVPW
	 BD3y5cMyDr/INGeRkVRyOKe4+gM1Xt7xIWsVW1uRF2frmmU0xOrNZRn9QYWG+L6lKn
	 7FMmBNu9p6VbC314s7ck3H6MSMNCAqT5krvuvpBIWJKwJaXGMEieKHPs9SRezzkMyt
	 axgZMNt9X4U+PAgRPG+loxyu0ohtIu0gKUHh3JwkkFrjQNAGt/njBq6Nbq7oEokcSZ
	 zPYJfpwtxH8u2o2IcM73gBuvpWKQNDLbZNcRge3ujbZsWqk/wPbZqNyRRJjFQj+kVy
	 JYIw3pcH5uiYg==
Date: Mon, 24 Jun 2024 21:19:20 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: add
 EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
Message-ID: <b14f6796-8269-46e4-9ca6-af248af04ae5@sirena.org.uk>
References: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
 <20240624-devm_spi_optimize_message-v2-1-58155c0180c2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klKchanc5XDrotyy"
Content-Disposition: inline
In-Reply-To: <20240624-devm_spi_optimize_message-v2-1-58155c0180c2@baylibre.com>
X-Cookie: Allow 6 to 8 weeks for delivery.


--klKchanc5XDrotyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 03:10:30PM -0500, David Lechner wrote:

> Fixes: 17436001a6bc ("spi: add devm_spi_optimize_message() helper")

That's the merge commit for the branch, not the affected commit.

--klKchanc5XDrotyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ51McACgkQJNaLcl1U
h9BZ9wf+IIY2+Y7WZRhxJpLD8QVSVUWu5cYLBLaYaeTTxTIXwMW8ypwpi1B64DdC
A54h+ludYMBKi6TajsFxkHhwEpxhijMIA1Pvq5UL1umhsCtjd6wQ6k+sfaHdStQ3
A7kmwTpp9BmFEis0zer9oA7uaBQZUyGuY8p9J/zt/tyr4g1HW6pqZbm4YXzg4G2Y
Nf5v7M2FPWnqT7BQmhmpHRVAHH9/LJzr/odZhwiGPUTzVFieQuUW4tFO9UR35ie1
hMtclZteO0DmdWG8/GEHMMnDr30tCcA2K7HwCGC0mftxzbFu/kc6xk/yrEjW1GcG
QcdQ3/5Fto6hyPa3yjIrmSEylF/V4A==
=xY5J
-----END PGP SIGNATURE-----

--klKchanc5XDrotyy--

