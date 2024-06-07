Return-Path: <linux-iio+bounces-6000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F2900591
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 15:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F10D28F84B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F931194C62;
	Fri,  7 Jun 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMb3bxd7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1C192B89;
	Fri,  7 Jun 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768209; cv=none; b=DDejizQtjqs8R/cCD7B5HWz3eUxJ3Scv1TeaLFalAM/gPbem9axnFupKFLRHJ49YgUe3rUNm3HLADqy12bREN5c2S3YBAXwWiIQWj8HZ3QROfKwANkdVGBRB+V6FqZOCkSKhl0a/iSqDCzDaMy8XTd++fqixaV+9RBXFVm3SbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768209; c=relaxed/simple;
	bh=J3Q2NHWabKrL51VoOEHdO3g83jYnFH97tx0Ovxxu7GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUzT9sNG36DQBaxsquua8ufMsN+znpxjyn3UKVIBEQPvbOoE/XFJ5AExgIk7sUjEXltsZcFwOsv9UlZcwVOqaw7tRtzPvVfnDgyoH9UCKHHyypKE59NXofDMvhqv7UIjrHITErlBPVbtEMIK9R8JfpNmSgpXq1Z+75vhNw5ZwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMb3bxd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C694C32782;
	Fri,  7 Jun 2024 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717768208;
	bh=J3Q2NHWabKrL51VoOEHdO3g83jYnFH97tx0Ovxxu7GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMb3bxd7bDkhsePcksW5TwgcfxMFBEhFom1G4L8II8kiDHynqRja3h3+no2W9jneu
	 6KqsOoUt0hnn7ejSwBjuY/U525zM/eI1bfGD2lzsaRLWGbQgnUetNWpglVAHCD9XJO
	 nvNS93ZO3lyRfTig/7gCzOfVgPf0ybkU+lEEYiony5F1zp3hcDrV4+T0L7UK3SlLmw
	 md2FzNK+gjyRHUfixO01066MqqMwvEJSJGVS679KleQf4khYw6ozQPeyQtrPvgSTzB
	 WQgYLS8EN8hMLluw5n1gEWEtM6NzsyQItvc0mx0QJraWMbfywRQQ1S7TeTA7Ic+hSD
	 hvuL/zD+Xp5RA==
Date: Fri, 7 Jun 2024 14:50:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <ZmMQCDCZxyGwqodL@finisterre.sirena.org.uk>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
 <ZmIUwHhjAUzZnfW5@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qI6iHgwpg0f9g5j0"
Content-Disposition: inline
In-Reply-To: <ZmIUwHhjAUzZnfW5@debian-BULLSEYE-live-builder-AMD64>
X-Cookie: Your love life will be... interesting.


--qI6iHgwpg0f9g5j0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 04:57:52PM -0300, Marcelo Schmitt wrote:

> As far as I searched, the definitions for SPI protocol usually don't spec=
ify any
> behavior for the MOSI line when the controller is not clocking out data.
> So, I think SPI controllers that are not capable of implementing any type
> of MOSI idle configuration are anyway compliant to what is usual SPI.
> For those that can implement such feature, I thought peripherals could re=
quest
> it by setting SPI mode bits.

The issue here is the one that Richard highlighted with it not being
clear exactly what the intended behaviour is.

> But yeah, it's not that evident what this patch set is all about and why =
this is
> wanted so I made a wiki page to explain the reasoning for this set.
> https://wiki.analog.com/software/linux/docs/spi/spi_copi_idle?rev=3D17176=
99755
> Hopefully the figures with timing diagrams and transfer captures there wi=
ll=20
> provide quicker understanding of this rather than I try to explain it with
> only text.

It needs to be apparent to someone looking at the kernel what the code
is intended to do.

> If you still think we need feature detection for MOSI idle capability jus=
t let
> me know, I'll implement what be needed.

If the devices actually require this mode then we can't just randomly
ignore them when they request it.

--qI6iHgwpg0f9g5j0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjEAgACgkQJNaLcl1U
h9AqnQf/Sw3+3u1jlifM436XxwiJrI915dgJkJtO8XgDa7yq3BbchNaCXyysgWcw
F+1obK5dbZTYucs9pQTRZH8nEBaSp9L0gig10FOl7yCn/9lU38OsTdoSaLdpIRrR
3R8I7+cvb/MSuXtEr//60B/FdwqJWIr6MrcGUthcfaLmqCKG0hAhnS6xApTMe7Vm
nIr34BLwguhZV4XLYrwDQyHykrUb3AXE4ZjeRl1KoLkBLFnIClA9xtERhChfBV6w
cVigAm+47zM9rFDMMEVpNSJrvxKVsiBHLCPQeb2s1PV6W6zFNo92DvbWJ25JHorg
1DTAfQye0KFPWH3791yHviAmyx2biA==
=oZkx
-----END PGP SIGNATURE-----

--qI6iHgwpg0f9g5j0--

