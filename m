Return-Path: <linux-iio+bounces-4008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3291895B80
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4822F1F22F0A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53615AADB;
	Tue,  2 Apr 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4r9wybi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB015A48E;
	Tue,  2 Apr 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081639; cv=none; b=urPJSIvZyrgYk/crfbAkO7jHk9ro2tFV5Fw4TPFozUjXTlCebDW4QiGd1WPpmBmtHZF+kEFEhvwrx63BLevssAf32/KM1d9YyE2cc/qNxvQVQo8TPRFyhlw3pN12BUu5qcLbDLFPD8A8dl767jl7pClzbYqM2cJ6Ejo26XGAHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081639; c=relaxed/simple;
	bh=0YTwPhIjhWtfNp3fXF87Ps26AUeyHHhqjOU4o3I4gAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKmUE5KPPH1E4Ez4PbFUe2x9EbBz+pebdaHeDIwW/d/iGv6khQPRVpZ7VEMUwsLIAMUbfcxkOF5D5iR3B5Q8qL0CBKBKcAbTGMURliTTtdUt5IAMg2teoTiqVt5wDN8eKW8djyRPaJo5X7ERdTUq9l+km9Rpv6eDrNQzwOfiCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4r9wybi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CBEC433F1;
	Tue,  2 Apr 2024 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712081639;
	bh=0YTwPhIjhWtfNp3fXF87Ps26AUeyHHhqjOU4o3I4gAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4r9wybi4p7CnI7HEyYyasIcn2Rl3AJZlRgi6BleUj8pw69C6O1fPNp2em4T0G+bg
	 asamfJx+jxiWBUAlhJ1J6BIk+UVd66wCJw12CHYlj612I9l0MLwms4i9HYcJ5SqkaI
	 MKWvtPf+Fe/n1hfb/gvXZ85KAKt/s4vvoGw0tAucknQKNiv3y0LRj3D7i0KLvMOCi0
	 kLS8mR76ElCQnuIs2WCzvV0IBAjh3BKzoqByMpWjZ7BPT1GAgc/RFfrtexSwsCDkkJ
	 nMo+mJhUKR0jS7Qc4vstAl1ipef3hlGyswzVucDdiwvvUqqoUyOYi4mIqo1I6hKDGy
	 9taWZfFmFTsZg==
Date: Tue, 2 Apr 2024 19:13:55 +0100
From: Conor Dooley <conor@kernel.org>
To: inv.git-commit@tdk.com
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
Message-ID: <20240402-smashing-humorist-5a74b2582fa6@spud>
References: <20240402090046.764572-1-inv.git-commit@tdk.com>
 <20240402090046.764572-2-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yo7qNO8wXl2wlDZX"
Content-Disposition: inline
In-Reply-To: <20240402090046.764572-2-inv.git-commit@tdk.com>


--Yo7qNO8wXl2wlDZX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 09:00:45AM +0000, inv.git-commit@tdk.com wrote:

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> TDK-Micronas GmbH
> Company Headquarters / Sitz der Gesellschaft: Freiburg i. Br. - Municipal=
 Court of / Amtsgericht: Freiburg i. Br. HRB 6108. VAT ID / USt-IdNr.: DE 8=
12878184
> Management / Gesch?ftsf?hrung: Sam Maddalena
>=20
> This e-mail and any files transmitted with it are confidential informatio=
n of TDK-Micronas and intended solely for the use of the individual or enti=
ty to whom they are addressed. If you have received this e-mail in error pl=
ease notify the sender by return e-mail and delete all copies of this e-mai=
l message along with all attachments. If you are not the named addressee yo=
u should not disseminate, distribute or copy this e-mail.

Well, I didn't get it in error since I am an explicit CC, but you sent
this to a mailing list...

--Yo7qNO8wXl2wlDZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxK4wAKCRB4tDGHoIJi
0icZAP4vg6Dj/avYBhdglU1LMYCa/t62xqIzvVUNMZKDI7fnUAD+NZBuKKOUeaWI
aWSuehW2ThmOcoKaJbQGhf/dwlFCTgo=
=C2ym
-----END PGP SIGNATURE-----

--Yo7qNO8wXl2wlDZX--

