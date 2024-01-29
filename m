Return-Path: <linux-iio+bounces-2016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B2C840731
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 14:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E812B28A16B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B33651B3;
	Mon, 29 Jan 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQwMq6Ow"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81064CFF;
	Mon, 29 Jan 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535552; cv=none; b=YNI7WuchZtL/pwkq2B6lKc2UVIli80KhVTECfE84VvPZUjXj4BlJDbgCrEX6kVLM4A3wdpbiBdxMy96jEqJlKmq1gBmhFPCbUKe2wSdp+vra9Do6TSGwGeUKg1264giof3yyCiGWoDiULb50i1+COmqCiU+rudP+PrwByPvSzwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535552; c=relaxed/simple;
	bh=V/3hFkSu4cb1bB/S7wA2/GXPf5ZeD69SZvv/w1GcqZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv5iflu4lnEfY7GcGG7CyofhANY43Xfrzaj58F1zptB9B5PDtEHhAvlfziOmCYCQxbwCAhv/Oaiuqu2IQli+lyiPWZJL+XPHO8Vjam26YNByhScNou+n512/edQVXe+6DCjhVq7HTQIas1OOGIba34/dBjd9zq2BxQVsAKx7sQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQwMq6Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11B9C433C7;
	Mon, 29 Jan 2024 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706535552;
	bh=V/3hFkSu4cb1bB/S7wA2/GXPf5ZeD69SZvv/w1GcqZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQwMq6Owq240njlgRe5CMDnxEgJr0SLerkrEKNKUCuDYn9Zwxke7i0JWoyTC2/nLI
	 4tzgbv8Nixz5HXeHzLnXHvBIMfZ/QB6CoDZEmf42bnmtajUk/f6F5n+nGSbX0YRS4e
	 gG9W5Sus6erf97VHVxtbLk8QJ+17apN5+eN+VK+22fCvAo60qndmckL9JefVKLP8jK
	 WfqDI6DTFdqBLCGXNh+0LauKcDuRw2ierSzI7cCtG2UdkTaI+FVZjee2U3vMXZG9U/
	 G5xZorDyaMytwpjhaJozsyDGywlXxbKb0fLUB2J8XGPQ9zbhMiVeJubUW+KrLi6VOO
	 DCJRWQ70llq6Q==
Date: Mon, 29 Jan 2024 14:39:09 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <Zbeqfb_pJ4gXQvc_@lore-desk>
References: <cover.1706441008.git.lorenzo@kernel.org>
 <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
 <51f4782f-09d8-448f-a693-e0c711bee18d@linaro.org>
 <ZbeoczLjkGG8pogL@lore-desk>
 <b17b63cb-9c05-477e-9e0f-3027c5e45d00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5jl+p0wNpNB07uPt"
Content-Disposition: inline
In-Reply-To: <b17b63cb-9c05-477e-9e0f-3027c5e45d00@linaro.org>


--5jl+p0wNpNB07uPt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 29/01/2024 14:30, Lorenzo Bianconi wrote:
> >> On 28/01/2024 12:25, Lorenzo Bianconi wrote:
> >>> Add device bindings for asm330lhhxg1 IMU sensor.
> >>> Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> >>> all the features currently supported by asm330lhhxg1.
> >>>
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yam=
l b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> >>> index 28b667a9cb76..7ba3de66a2e1 100644
> >>> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> >>> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> >>> @@ -49,6 +49,9 @@ properties:
> >>>        - items:
> >>>            - const: st,asm330lhb
> >>>            - const: st,asm330lhh
> >>> +      - items:
> >>> +          - const: st,asm330lhhxg1
> >>> +          - const: st,asm330lhhx
> >>
> >> lhhx is compatible with st,lsm6dsr, so some explanation would be useful
> >> why it is not included here.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >=20
> > Do you mean something like:
> >=20
>=20
> I meant either explanation in commit msg or adding lsm6dsr fallback.
>=20
> Best regards,
> Krzysztof
>=20

I think we can use lsm6dsr as fallback instead of asm330lhhx (for st_lsm6dsx
there is no difference), I have just used asm330lhhx since both asm330lhhx =
and
asm330lhhxg1 are automotive sensors.

Regards,
Lorenzo

--5jl+p0wNpNB07uPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbeqfAAKCRA6cBh0uS2t
rLPKAQCzfgpU8D+z+snQFpouHGLcvmabjBp8Zi7mj3wwGOSvJgEA+dVg+q7LDh7/
tDi+FVGze1MajdAbnh6PVOeLBhZNbA4=
=0k67
-----END PGP SIGNATURE-----

--5jl+p0wNpNB07uPt--

