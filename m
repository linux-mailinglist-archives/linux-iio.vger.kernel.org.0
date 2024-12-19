Return-Path: <linux-iio+bounces-13682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F679F833C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8934C16B0EB
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FA81A256B;
	Thu, 19 Dec 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyZO3JlG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0C1A0B12;
	Thu, 19 Dec 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632804; cv=none; b=ra3f+y5hasaC8OPx7xJEYeOe+9W03viVogMLgeRKOx8g59n3UwSrBrjt0bze0eKhjMvSMjdBhIUXfFfri886Y1yct/OM0Q1VuyFE4bzIvHAtPaujmx1tvi6RwZOPNEffC16r9S5j4HTOuTMeTsmkJqLftxl7QkiDR9fHNtEm5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632804; c=relaxed/simple;
	bh=PXBsRxZhmi+gRU8Ewb3RrU6nlQeOo6CurTgsxR7ntTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j36GelxrQc6v4oYplJXZI/5+1dMdZ4CZr8L3Ihuz3lv9HjkFL9rGJwirbUuXcHXDxEgJjNpkGZoVp3CUkBCfaB/lVYZEDnEYHAqPtY1aYy8mm3JZkvLPLrgZGGvbRZI8CVHpuP48J3nmnCMxczHrL5hdGTm6wVEuN6FL9mnAwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyZO3JlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B560C4CECE;
	Thu, 19 Dec 2024 18:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734632804;
	bh=PXBsRxZhmi+gRU8Ewb3RrU6nlQeOo6CurTgsxR7ntTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyZO3JlGB4XdVZoin2PD1zfI15ruJD5Y4jzefw/9UU6RMX4uh+PHVPYeFwLaEw9tF
	 Uqa4EXB1bH+jJd5gwxlte+ADi0r1BNlxdu44NoW0n8cY/Q+PJTdQlOKRWFY/Cg4Tum
	 Oe/D5eB+mcQpsj0bMHMT/jw3CnBdVuajA6g9cp+gaUpZcWDeZgWdS9msK/0gGr4jF4
	 R+w7HV+vKXFAt28+ZOGsFedu9iKqwet9wETZip27i/Duhww7dUwLda2zzm7hTcj9aB
	 Cb/7HDoLqlozsOmgDDPKmzyLKvL+ezl/gtyiNwtERJy0yVQcC9IcGVIgkLdFdc1IC8
	 MVZPKdKbfMK7w==
Date: Thu, 19 Dec 2024 18:26:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: mgonellabolduc@dimonoff.com, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: media: clarify stm32 csi & simplify
 example
Message-ID: <20241219-backspace-tameness-defc6e43cf52@spud>
References: <20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com>
 <20241216-apds9160-driver-v3-1-c29f6c670bdb@dimonoff.com>
 <20241217-brilliant-jubilance-54641c6ba990@spud>
 <20241219153249.39b49561@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PVdqPFf4XmF9Pl8z"
Content-Disposition: inline
In-Reply-To: <20241219153249.39b49561@jic23-huawei>


--PVdqPFf4XmF9Pl8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 03:32:49PM +0000, Jonathan Cameron wrote:
> On Tue, 17 Dec 2024 18:31:09 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Mon, Dec 16, 2024 at 05:55:40PM -0500, Mikael Gonella-Bolduc via B4 =
Relay wrote:
> > > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > >=20
> > > Add device tree bindings for APDS9160
> > > Note: Using alternate email for maintainer
> > >=20
> > > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> =
=20
> >=20
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Conor, any idea how we got that title on a reply to a completely differen=
t series?

mutt bug? I actually noticed that the subject line was not correct when
I sent the mail, but I thought it was a visual bug in mutt rather than
one that affected the mail itself. mutt sometimes lags pretty badly for
me, there's a good chance I queued up the actions required to delete
the $subject thread, jump to this patch and initiate the reply-all
process during one of these periods of lag? I'm not entirely sure of
that, but I do know for sure that I saw the erroneous subject in mutt's
"mail configuration" screen after I had hit y to send it.

> Anyhow, I'll assume you intended to give RB to Mikael's patch!

Ye, content of the mail is what's correct here.

--PVdqPFf4XmF9Pl8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2RlXgAKCRB4tDGHoIJi
0nMqAQDqvugOEEgubwx8CJbxAlr1rQwGFWYqGyIkMYPXKGn2IAEA9cuJTXkb6s76
a/oFGOgV+Iom8cwyo6UaoYwlRHc4agU=
=1xX/
-----END PGP SIGNATURE-----

--PVdqPFf4XmF9Pl8z--

