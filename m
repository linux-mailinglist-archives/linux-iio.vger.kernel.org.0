Return-Path: <linux-iio+bounces-25895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16E7C32877
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CEB460D93
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002533DEFA;
	Tue,  4 Nov 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnhGjIHW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3D33BBA0;
	Tue,  4 Nov 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279781; cv=none; b=gpdI6tnNjfoHIHGaY5rnj6H4YqCqJSD9raK4lAILdLlv+42gzT9AkRyTYe9XFEPxLjI7LEYTxu0ctd9Il32/fl+Ft5nb9psL3P7m8/JbGa4YzmWscE0/rSQiLKHY30h0MKENne4lZ7O4DeYqKYf6KIoEM9HwoCXfzwmM7FwzXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279781; c=relaxed/simple;
	bh=ql8bH6ISA3scHDJpfX5uYzON3vULJf2EuvFq48iU7hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf4HckZ/E+JHcwF+SNFzuRM3Cu2lX0KEOJaHY0rK7cmp+fKYxZjm+VdNKrP86TZHsOUdlCGVE56Oh1xq6LeZhK3WZS9owk8hFJDrrjKO97aMbOspD0VIyU6YQyFU+Lic9ILGj8U8URbh/3E7pCrG7QQxswvKeaam9W8Vbu1rm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnhGjIHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC93C4CEF7;
	Tue,  4 Nov 2025 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279780;
	bh=ql8bH6ISA3scHDJpfX5uYzON3vULJf2EuvFq48iU7hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnhGjIHWIjChcS4VdpnGSFNDr06U6BvJVRuCIK6AZlBeaeX25YFD/bDeJHSUhwT3x
	 HGCCgaOrPILd0myXXiO2s/G0Ci06LKaZa4OqTzFWB2WtSasSe7pVDIeMV+Bs3p5+VZ
	 ZyTpQ7TcvBkMhRMEnGSlgHbfIzLHOdKQsmyfP2UviIC63Gl+GtMOOkJ4tfnWxVkT9q
	 +X88uH2MSIOHonzOnKiJP0bPZld3rDrGZyTEM0UTjXKbPjO6b2jLdFhaVbpz96BEsT
	 FODcmvxwt4cWFlPL/dedkuZZ3v/k0JIbmN8feE9Wxg7Y6MzvGr/ziLacQlpRRLfla8
	 P/FxFwHbMm29g==
Date: Tue, 4 Nov 2025 18:09:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: adding support for
 Microchip MCP47FEB02
Message-ID: <20251104-underpaid-lego-d6aaaf9f24b6@spud>
References: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
 <20251103-mcp47feb02-v2-1-8c37741bd97a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ShfumN7zZQPXHxJ9"
Content-Disposition: inline
In-Reply-To: <20251103-mcp47feb02-v2-1-8c37741bd97a@microchip.com>


--ShfumN7zZQPXHxJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 05:50:29PM +0200, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and
> MCP47F(E/V)B(0/1/2)8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory and an I2C Interface.
>=20
> The families support up to 8 output channels.
>=20
> The devices can be 8-bit, 10-bit and 12-bit.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

This all looks fairly sane to me, although I'm sure whether the issue
David and Jonathan were looking at has been resolved.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ShfumN7zZQPXHxJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQpBYAAKCRB4tDGHoIJi
0isZAQCA3JwnySinDGM7Ua6U9FkWnQtbzKOC5isieEjweQED5AD9F6NsgbhlWhsh
cKPAQ5fjtz/fdGChv4Fx35FmAS93bgo=
=SId6
-----END PGP SIGNATURE-----

--ShfumN7zZQPXHxJ9--

