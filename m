Return-Path: <linux-iio+bounces-5839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A518FD385
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1261C23419
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA7188CC7;
	Wed,  5 Jun 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb59FgUV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95817559;
	Wed,  5 Jun 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607054; cv=none; b=ttFy13crnLREV6ZGi3e+NtqnlBTUwhhYHs5kHawsFaAWfLP3m7RCQvyFM7FhDr2OZ2y5xE6jqcFSJNPM6kPbEg0+F3CaRXy4mrQ+FqlDWQpSAMgBmA5JRmgdabCdiS7j/fqrsX4M+M2sgrAuoQd2JI+okpjdsXm6CByFGaico5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607054; c=relaxed/simple;
	bh=TQXvx/eq6+tK9m6rWfahgpjU73d15H62T5XSGj0YRlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP4pwWhxqyXFVkZjKjABTvNnPENaAGcFgUFOBQ1Jj8HLCbxVrJOeYAYaBxfC1OGgKRAxG8+/+qBOGBfcN/OuoZfnUbz6Obw+CdjnMQws8n5bvx8IpD2N49aoFpE5kjAX5gFHBW5ornBE5TKYqk+fi7IhoyBD2x7R1e1iwIzS1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb59FgUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43293C2BD11;
	Wed,  5 Jun 2024 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717607054;
	bh=TQXvx/eq6+tK9m6rWfahgpjU73d15H62T5XSGj0YRlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fb59FgUVidOmv2FTy0Ts1dQd7rjnHDh9i6TnVcZt7uQKnYGlUmzJBgEUf/AnwNhhF
	 DfA6o89+m0eDOocuCPZMINpcxHyJyCcpAeu/2sS+K4sFcdSQYS4/D+40aME1WxmUqF
	 bUk6FOF6qafZJ6K6cRngRfpU5oYUjL0Vj8Vq8Qyxt4Qf1yjXOxvbLyifIYRHh343Ji
	 59f9qEX2hy1IlDwaGhsLBstzuWeb3XwJWAChuK00Gkji9mUiHVfaR93f7OQyM+CavY
	 WEjNzY0+Pfbt8R7gtJ8Eq5xFcseL3F4pU+sFOsOwanAJL4J+vnnhpzssJVnN+5c+nO
	 aMINxvLPemS6g==
Date: Wed, 5 Jun 2024 18:04:08 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <d09485bf-bbb5-4a3f-84b8-54478c6d78cf@sirena.org.uk>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
 <5dcd9701-2725-4aff-9e73-d8f2e038be75@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wKVoeLpN0Xiqr2ia"
Content-Disposition: inline
In-Reply-To: <5dcd9701-2725-4aff-9e73-d8f2e038be75@baylibre.com>
X-Cookie: Simulated picture.


--wKVoeLpN0Xiqr2ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2024 at 11:37:48AM -0500, David Lechner wrote:
> On 6/5/24 7:24 AM, Mark Brown wrote:
> > On Tue, Jun 04, 2024 at 07:41:47PM -0300, Marcelo Schmitt wrote:

> >> The behavior of an SPI controller data output line (SDO or MOSI or COPI
> >> (Controller Output Peripheral Input) for disambiguation) is not specified
> >> when the controller is not clocking out data on SCLK edges. However, there
> >> exist SPI peripherals that require specific COPI line state when data is
> >> not being clocked out of the controller.

> I think this description is missing a key detail that the tx data line
> needs to be high just before and also during the CS assertion at the start
> of each message.

> And it would be helpful to have this more detailed description in the
> source code somewhere and not just in the commit message.

Yes, there's no way anyone could infer this from any aspect of the
series.  I think the properties also need a clearer name since someone
might want the accelerator functionality at some point.

> > Even without that we'd need feature detection so that drivers that try
> > to use this aren't just buggy when used with a controller that doesn't
> > implement it, but once you're detecting you may as well just make things
> > work.

> I could see something like this working for controllers that leave the
> tx data line in the state of the last bit of a write transfer. I.e. do a
> write transfer of 0xff (using the smallest number of bits per word
> supported by the controller) with CS not asserted, then assert CS, then
> do the rest of actual the transfers requested by the peripheral.

> But it doesn't seem like it would work for controllers that always
> return the tx data line to a low state after a write since this would
> mean that the data line would still be low during the CS assertion
> which is what we need to prevent.

With the additional requirement it's not emulatable, but we'd still need
the checks in the core.

--wKVoeLpN0Xiqr2ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZgmocACgkQJNaLcl1U
h9ArVwf8Dw4cgSZA69ycN+jnU1O7GS21AXkT9STiTg+vHwxg7SZJsCwtzQUGOUqF
M5EbV1HogtLSrpupF3CYPuXqR8KoM3oQ71kQwGIBY8YNkumwuixOpkDGYhGRAM1g
HZYoyKBMeEIIKJj+Em/CmdnB/q0I1uBLYWwAZ8WcrNt6fyM08spwl1hWdXZeHwCs
52Yh9wVOaJhoNAvkUTpFQH7WfcosMA/rt1Db2cNpREp7WlcsRAaBTioff1MxAYzE
QSaN4KAGa6mqj6fUV90RP5VvJgBuzW8NbLPPcmrtCrP3VOlL5L4XssJ4qKYLuDzA
kSFzJwGtzOVx2BrKpxReUjWERRNNFQ==
=g6Wl
-----END PGP SIGNATURE-----

--wKVoeLpN0Xiqr2ia--

