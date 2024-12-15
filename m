Return-Path: <linux-iio+bounces-13504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0309F24A3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 16:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444A51885E7D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068218EFED;
	Sun, 15 Dec 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSRXQgpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5DDDC5;
	Sun, 15 Dec 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276812; cv=none; b=oaFRLkE4PV7yUxeBQLLNMGzPRgNFY3b7RwCOvQZouhmCEQa9CuBKVqqF2VyUlRPTK/OAERD/3TyWImJy5xNAadpaEcnsWqb2SvrZwAHfvqH+7rPfiETeZhRof54njXYfCqpHMPAyRDO/bC3UKvPL+U+SMDN62v1p1pmi8aRZXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276812; c=relaxed/simple;
	bh=y23FOLBTiB16HEELVlgnSAcNUDlCnKMjS+oum5r/7hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6Fg6jFXCKUH9Z+N5hd/GuC5uSjUO3NzW8Y+9kvnl/YWgX1f/T7B71QJv2SwSEz39BpQnwvV8dq8KU4KsBu23nPAielCLuFaSVd+0r0/hp4AAZy99hKr2U22Su/ZLhdgPBuR7ryMhV6TMy405Dlu12xXfempYC7vJJsYpCbyYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSRXQgpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2383BC4CECE;
	Sun, 15 Dec 2024 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734276812;
	bh=y23FOLBTiB16HEELVlgnSAcNUDlCnKMjS+oum5r/7hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSRXQgpxHrXEr221x/S8InYJBo6vHQOIs/uSxBgdRsTJfHKToH/DjSpAwN6QFa9lg
	 rEZvIdN2fo2qWve0ysj1ZWrWNoKrhtDy5Da+Sn8WcM5nQr1OvpY0FQfgT3X4Y6HrG9
	 ZI0dCWeJlWJmaJlp5QkSqjCUsOtdNTUhEVyg1mkbkrJhMFtSmg5WRe8FE9cLJhOU4d
	 OP8bKE04FHYbY08pPqo8Bm1UQVNPfL2BbB4teGgF6o4zx/YtiE1iKYr1eiJC8rjCuh
	 DFrz+GJ/JNr87xI0clG236WrVo4CNVMjVgb+VNN8rH6HHIjaIjpuEvTuIxtmY5bjXg
	 EHfEdczIEDDoQ==
Date: Sun, 15 Dec 2024 15:33:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20241215-ought-ambitious-d330fdfdcddf@spud>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
 <20241206-apds9160-driver-v2-1-be2cb72ef8f4@dimonoff.com>
 <20241206-comment-tissue-7964de6bdcd3@spud>
 <Z1NYhR9Y9T0OUCHV@uva.nl>
 <20241208114141.31df6a8e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jQPKVG1EHZbCIf8V"
Content-Disposition: inline
In-Reply-To: <20241208114141.31df6a8e@jic23-huawei>


--jQPKVG1EHZbCIf8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2024 at 11:41:41AM +0000, Jonathan Cameron wrote:
> On Fri, 6 Dec 2024 15:03:17 -0500
> Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> wrote:
>=20
> > Hi Conor,
> >=20
> > See my comments inline.
> >=20
> > Thank you,
> > Mikael
> >=20
> > On Fri, Dec 06, 2024 at 04:33:36PM +0000, Conor Dooley wrote:
> > > On Fri, Dec 06, 2024 at 11:09:56AM -0500, Mikael Gonella-Bolduc via B=
4 Relay wrote: =20
> > > > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > >=20
> > > > Add device tree bindings for APDS9160 driver =20
> > >=20
> > > Bindings are for hardware, not for drivers.
> > >  =20
> >=20
> > Indeed, should I change the commit message to remove the "driver" part?
> Yes.
> >=20
> > > >=20
> > > > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > > ---
> > > >  .../bindings/iio/light/brcm,apds9160.yaml          | 51 ++++++++++=
++++++++++++
> > > >  1 file changed, 51 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9=
160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..525fba52f156df3b78e=
24d7d0d445fe9d882eaa7
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > > @@ -0,0 +1,51 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Broadcom Combined Proximity & Ambient light sensor
> > > > +
> > > > +maintainers:
> > > > +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com> =20
> > >=20
> > > How come this differs from your author email?
> > >  =20
> >=20
> > The author email is my work email, this one is my personal email.
> > The first one might change while the other one will not.
> > Is it required to have the same email here?
> I don' think there are firm rules on this, but there are processes in pla=
ce
> for changing email via .mailmap and where relevant patches updating
> to a new email address.  A note in the commit message would be appropriat=
e though.

Ye, I wasn't intending to raise an objection, just checking if the
difference was intentional.

--jQPKVG1EHZbCIf8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ172xgAKCRB4tDGHoIJi
0jNJAP9yVRE4G0oVarvTtLhBF6X5qJR4lt0ode2LP1h9r7uXgwD+ISMKOpivvSY1
zlnZLNbESlYyaSHXQE2t+Q4uXN8aHQw=
=1zbL
-----END PGP SIGNATURE-----

--jQPKVG1EHZbCIf8V--

