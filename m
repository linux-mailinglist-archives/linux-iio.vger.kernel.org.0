Return-Path: <linux-iio+bounces-8447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A195097F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 17:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6536D1F21E2E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44321A073C;
	Tue, 13 Aug 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkIJurtD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD792AF0D;
	Tue, 13 Aug 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564428; cv=none; b=CJlJLC3gQUkjqCpvxb4cgztbEORj1Tq+Smw/iV0wzh5KLFus8bmqjUEbYfSUu2pNwmo1g0xut5Y5+mJeoLrWBJ9x/+tqXGLjFsfspOpqFlVzRem2aOksyblao9UlHey6pUbbeyIOkPqLW8w8Mls3xAl3kiyJe9l5MAcWxnpzHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564428; c=relaxed/simple;
	bh=DdTCI3gkopnMJUu1J01m1xt6VNeTSSWjSzHqifhjVXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4RmR8KTFhosIKqlH1f41NtUclIsPFBFxgbrBip7bkA2RimeKIzlO/BjAp3FjtH+ppoD/VwRjBSU9dB0p/5LNQrWv13KbqwxzUPcdekeo293RsOR8qT5d3R/MjrL2Cg2pGy386H9eRC7G/KXKR2Aj84+HsMV8ODeboYyzxD6Vdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkIJurtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2441C4AF09;
	Tue, 13 Aug 2024 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564427;
	bh=DdTCI3gkopnMJUu1J01m1xt6VNeTSSWjSzHqifhjVXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkIJurtD18H8ADp/clvcDCVMJmXDcroXtvJvPgVYPusA/52lVkXskC0l888qsG59O
	 wGJLHhc200Zytyv63+BgoWib32CAyBL/A4rD2DJ4VpAQUCD3VgggFnU1KnlrAIaim9
	 Th02T7qjB5JTURtX8rbUvfB3zVfwvlu4gzQOJhATfeay36OvPRhkMq+hwZ3T8uWmuI
	 GPZtI9f68IfBlQAgk1Z/E5TgOwYKk42yk7v1lMDS7Fznc1DG+YY7KvxftetbrxknTp
	 OW8718iNFeBaEJfHkHIHUvdS25zmxWpxOnVvMfUJTdm16UXChtnlRdfKpiIdcagnbq
	 F84FlnIVxA6pg==
Date: Tue, 13 Aug 2024 16:53:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add EVERLIGHT
Message-ID: <20240813-rectify-rift-f823808e039f@spud>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
 <1c79a109a7e91927a9380d2aee91fae32848d7f7.1723527641.git.jan.kiszka@siemens.com>
 <20240813-moaning-scrabble-48599c03b459@spud>
 <3a12b661-bcc7-4563-af91-08f521afffc1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DDxbQwtUaeWQU0Dz"
Content-Disposition: inline
In-Reply-To: <3a12b661-bcc7-4563-af91-08f521afffc1@kernel.org>


--DDxbQwtUaeWQU0Dz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 05:46:28PM +0200, Krzysztof Kozlowski wrote:
> On 13/08/2024 17:41, Conor Dooley wrote:
> > On Tue, Aug 13, 2024 at 07:40:40AM +0200, Jan Kiszka wrote:
> >> From: Baocheng Su <baocheng.su@siemens.com>
> >>
> >> Add vendor prefix for EVERLIGHT Electronics Co., Ltd.
> >>
> >> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> >=20
> > This is missing your signoff Jan. With it,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> The next one as well...

I had a longer reply for the other one ;)

--DDxbQwtUaeWQU0Dz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZruBhwAKCRB4tDGHoIJi
0uJlAP4m07kV7aFJXCRWd9S+qaGpwTtRrJq5cFPTAmlkD+vONwD/Sw4i3LhAMfGE
LDadGzWYNCDPHc74f0yeFnq3blVA4Qs=
=T9k1
-----END PGP SIGNATURE-----

--DDxbQwtUaeWQU0Dz--

