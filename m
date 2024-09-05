Return-Path: <linux-iio+bounces-9193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCE96D737
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC5A1F23FDB
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65453199E89;
	Thu,  5 Sep 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn4rPZlm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17966199938;
	Thu,  5 Sep 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535997; cv=none; b=ZoIMjakvLtnOldYeC1uBaG4KUgp+wwsEni3PsCd1X8ESsMIacby0VrhArI0TQlcOFxAxDO9r81SBF7/DcFRzvm82cwfHDQ/+nyTMsKDzvXBwKDRlHOSLD/+JK+AXHaWddwwrRDa1xwHYffx+mwR1BTkAjmjdEFiKs5y7uxX2Hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535997; c=relaxed/simple;
	bh=VWk0KKM+pEC2Fxd/uZoZaHJwBnxhNaByHYWWjXspupw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+PZ5eul//gCaIfKjWRzaSk4PvEL49YSCXVa5V2D8Pf8h2EV6wVH8dSKZD4WXIkXmwiPacQaYuQI6v0eqgXSNBxwI/RdIL6SrYPu62aMYmRQUi3LyaPQQ090U7eDVqhn8/Mnbz1QoV9AHg6U5RCLPm+XXuvpipg5OrCymStmxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn4rPZlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D5C4CEC3;
	Thu,  5 Sep 2024 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535996;
	bh=VWk0KKM+pEC2Fxd/uZoZaHJwBnxhNaByHYWWjXspupw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cn4rPZlmwgMcVVU+MrRIC0Yjz3jTout7qWJji7d3q+7Y7YqTAyEcMW/f3hDXdtPSJ
	 RTETa4ysBQk9weJrSdjM5qSQfU/UX35eT9DKaz6M79YTVXtTy+aAVWejiZckaiLw03
	 K5tqZONOWD9SX2Bl+C3M2Jf1i11KxGyFiY1LITuE97vzWZfVCaoQRhGnqlVsEpxYrM
	 TBGqJ0fTuBxxkSdo68FbuIH1DqOMQAYzxYoGTRWsUnIZX5KFkFdl7r2dC8schnl7el
	 7c3pivYAM+o4q6/SUIKg9pYAz3XDmgOolIvFegh9O1ZGXGm5+EYz9294l9Up8AwswX
	 erdM46Mn8OGNQ==
Date: Thu, 5 Sep 2024 12:33:08 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
Message-ID: <52894eda-f484-43b2-b9db-04bd14fe6e18@sirena.org.uk>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SQPEeGKFbXTry+H6"
Content-Disposition: inline
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
X-Cookie: The horror... the horror!


--SQPEeGKFbXTry+H6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2024 at 04:57:07PM -0500, David Lechner wrote:
> There is a recap at the end of this cover letter for those not familiar
> with the previous discussions. For those that are, we'll get right to
> the changes since the last version.

I didn't reply on this mainly because I don't have anything super
substantial to say that wasn't already covered.

--SQPEeGKFbXTry+H6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbZlvMACgkQJNaLcl1U
h9B4rAf/ZoKEQN8Ha9T7PIsTC+93EBkvUTESMJz+87Yt8sXAwKjxCQyi8uUB8CNZ
nXIsSzqp4bZS3nhAuQovxgJwoZ7/TA0RdlzT2aE5WxJL4diRUaQpPvJpwmGKRnHB
qqC+w+b7QBpnp8LaQnxAc2Sqyp08GQavoGgPpL4CggM+wh7v2LihCCZEg1+Fv4R0
hGhMF3ZKNp8v1yvIungM8leb/ooqY8fhKQoVjf4HVXngZLl4qQI7Jk+b66MeSWrV
yOGB5unNKl9zGFr+Pma0F5NlEhC7/H6PwKts2skY3+heBw4WNnkrZgY++0m8uJvk
Dx5B0OmMI2x8J5WiAcULkVIW+TOQWA==
=JKTd
-----END PGP SIGNATURE-----

--SQPEeGKFbXTry+H6--

