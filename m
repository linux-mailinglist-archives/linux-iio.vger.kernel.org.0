Return-Path: <linux-iio+bounces-9621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7697A54A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FC6284887
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641C158DC2;
	Mon, 16 Sep 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz2AiclI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE01547D5;
	Mon, 16 Sep 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500287; cv=none; b=c79zYRRjmFiMUuz0aRWhvdi9AMT4zSCBbADo7ft7k86E0EurT0FCZmjIlirc9EOUvUOZCNpcyoXcfkGFYjs7INO7sWaGagE6l6dNAyWEvAOyeUeUTfu2sRmxEVGI6R3/LEgDDQfh5zH/m4qn+l4gv17McMkw7RWSNIbyiGGQCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500287; c=relaxed/simple;
	bh=iH6HjIrJbuL6jnQ4qIITYIVkexIlvUJC8T1Az4wwhjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZJ3dx+sBU72m5x2HUDvb+LvXDU+tioKmg3CoM6ZN4Ap5uSylbYb+azZG5nwT3foql85hw8RsUnl3byce99xgSVte6jzkHsZ71M/eZB0BSYoSJ5VB/cUPVjbp693A7NY3TNDPXoy/2EXmWzqy41D9CXM9Be2IPii0GDGw2sO9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz2AiclI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D37C4CEC4;
	Mon, 16 Sep 2024 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726500286;
	bh=iH6HjIrJbuL6jnQ4qIITYIVkexIlvUJC8T1Az4wwhjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mz2AiclI964HImlglHIM8ury/P0qXWLBOE1XegMCjyGpljfEpHwnrlGTN9usM0C99
	 gWAuRO6/JIovFWM1AxIwl8dAUKXBpYljfV1PYDMkM7RF9MM4bjDBZkgR8EUXiHHcfQ
	 1t3C99U0fwX4Lay8Yg3OK4nsIpksx4YcHYkPlATuLWJnuxG6JSotX1mduORwzArXzZ
	 SDzyT6ouBsGOFQhYYHXwe1PTSGN64BayU0ItSFRs15fFygOVKj8qdjxRp6Xetj7KWf
	 o9MZc3BFsWcfPtWv6Ut2HsY/lz+l80FdTSkw3UQIwFTfV52pE1/S/VUMNrkSL1UU5G
	 JC9W8GEnHZpVw==
Date: Mon, 16 Sep 2024 16:24:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andreas Dannenberg <dannenberg@ti.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Message-ID: <20240916-hardcover-vertebrae-1ca1fd387daf@spud>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
 <20240916-add_opt3002-v3-2-984b190cd68c@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QevM+ap8IyTxCOXc"
Content-Disposition: inline
In-Reply-To: <20240916-add_opt3002-v3-2-984b190cd68c@axis.com>


--QevM+ap8IyTxCOXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 04:56:38PM +0200, Emil Gedenryd wrote:
> The opt3002 is a Light-to-Digital Sensor by TI with support for wide-range
> spectrum light. It shares most properties with their opt3001 model with
> the exception of having a wide spectral bandwidth, ranging from 300 nm
> to 1000 nm.
>=20
> Add the compatible string of opt3002.
>=20
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>

Pretty sure I gave you an ack for this already, provided you added the
a description of the differences, which you have.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--QevM+ap8IyTxCOXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuhNugAKCRB4tDGHoIJi
0lX0AP42UtqigGmWrT7AHNuUBXtWG4giT+clsA+e5E56NY2bmgD/YpiqeJCwB+Tf
NhhceJ1/GKShyX9h7NmtxRS3u3ZrNgI=
=ZFvF
-----END PGP SIGNATURE-----

--QevM+ap8IyTxCOXc--

