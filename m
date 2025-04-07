Return-Path: <linux-iio+bounces-17765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7348DA7E3D3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAD43A9DA6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB81F4C9A;
	Mon,  7 Apr 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmHQ9Jht"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86F1F4170;
	Mon,  7 Apr 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038549; cv=none; b=bBb651asd9flboNp+F3WStB5oyjsVB5CGjREC8G1bEnLi34Btr7O0Xongb/LWxXYK509ARVoi+fYQUBjXhvgssiAlqURbv4wL6h6VoVHYBWghw/0xFNaZgWWxpXCsorLjzfxniEZ71+v2onjQzHGWfO9hO+w43ojngQ2sppeO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038549; c=relaxed/simple;
	bh=YCN6WWntTK6lFqj7CR9ERNx4EvAMb5MyGa6XF4ejXew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1+15Nqo4qbRsLCrMKPn1+f/c+vTXR+hF3wmxagxBsDQyJ+bvk3gh7GFw52fSxzoXqwSNiBje8mthRKasuHCLFkd+neXFa+fzf6WQoF86V16cUfUiarZP1+GpBU7mGKLYC0ftgajhUH9LXhRE7oWAJHHvNqsLjsBz6HETwtADMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmHQ9Jht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27326C4CEDD;
	Mon,  7 Apr 2025 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744038549;
	bh=YCN6WWntTK6lFqj7CR9ERNx4EvAMb5MyGa6XF4ejXew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmHQ9JhtTbpijlJah3VpV202LCTUUuC6ouIesZq3krOs90WB057LCk7tzixUDZpZP
	 G3TYYn+3hq7XlKF3n5T1uIMpmxBgmPZCee8mvDcKdi87XfmezetXD7HXpS6RmU95FC
	 AOf+3l+nWDJE7A5lO4yBVb7ck9vqSnNZcYoEojgmhr311sF0g5L5ZYKaiLFHjOyp4v
	 jZB/2NGyAZ/0IOkWaN0HdiaCShC7nx8piihMs/1GtixSRe7CF5koiZc7HpsAL5wFjR
	 eFmUfHsgaBduh7yNjbpB32W6H2GlEN7yF4I5melxkL3FoDxcDFxee//QptZGwhvN6I
	 jQj+GkxrNKREg==
Date: Mon, 7 Apr 2025 16:09:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Message-ID: <20250407-uncolored-eastcoast-df8b67507382@spud>
References: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
 <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-1-72ed5100da14@tdk.com>
 <20250404-entering-rebel-fee1d02020b3@spud>
 <6012032b-d202-430f-9077-0869be27b481@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7asBmwWHhG6hyXv0"
Content-Disposition: inline
In-Reply-To: <6012032b-d202-430f-9077-0869be27b481@kernel.org>


--7asBmwWHhG6hyXv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 07:21:13PM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2025 18:53, Conor Dooley wrote:
> > On Fri, Apr 04, 2025 at 05:52:02PM +0200, Jean-Baptiste Maneyrol via B4=
 Relay wrote:
> >> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >>
> >> Add interrupt-names field for specifying interrupt used.
> >> Only INT1 is supported by the driver currently.
>=20
>=20
> Please run scripts/checkpatch.pl and fix reported warnings. After that,
> run also `scripts/checkpatch.pl --strict` and (probably) fix more
> warnings. Some warnings can be ignored, especially from --strict run,
> but the code here looks like it needs a fix. Feel free to get in touch
> if the warning is not clear.
>=20
> >> ---
> >>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml          | 8=
 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4=
2600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.y=
aml
> >> index 7e4492bbd0278a336587dc5ac04da7153453da29..f19cdfd7450e04e7c984dc=
987f3c23f5ad89a248 100644
> >> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.ya=
ml
> >> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.ya=
ml
> >> @@ -41,6 +41,12 @@ properties:
> >>    interrupts:
> >>      maxItems: 1
> >> =20
> >> +  interrupt-names:
> >> +    enum:
> >> +      - INT1
> >=20
> > An enum with one entry is just a const.
>=20
> It's not one entry and that's the problem. Instead it should be items
> with one const.

That was kinda meant to be a comment about the general problem of people
using single-item enums, given the other comment I made about there
being more than one interrupt the result was always going to end up
being an items list with more than one possibility anyway.

--7asBmwWHhG6hyXv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/PqkAAKCRB4tDGHoIJi
0tUAAQDnPBGo3ZLIl58q2uan56d9y6zlQnIczrevbPVjOmZS5wEAmZJkq2KFcx2f
nfUuELW4uizmXX+xIkiiNvk/8tnnNgY=
=EJj/
-----END PGP SIGNATURE-----

--7asBmwWHhG6hyXv0--

