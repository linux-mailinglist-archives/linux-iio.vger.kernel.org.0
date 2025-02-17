Return-Path: <linux-iio+bounces-15689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778BBA38607
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239551897EE7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC622540F;
	Mon, 17 Feb 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQv7pnK/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93477212FA2;
	Mon, 17 Feb 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801901; cv=none; b=k0qqiPpw1Qq8Rv14pT5Nvr07lbtYLae5thnjFFRHnDwaEHMd3ymH7ZhCWMMbgQdqa3Hc92V3sHIpnRkLYq5OnrRTNRl6meWOFpuwnfquRabc1KLIRiUVA8jZx1O230M6vt7rPmhZWaak2NA+/rz8pBmpsH19dj6rvNMUW8aXXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801901; c=relaxed/simple;
	bh=BysXgtPBiIvEVUwuCbk70Ntt9mEGd5mUR/DZjy2NLtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mpao2dySAet5V3F6sDlY1j4zcWng2EWF9f7JVUGrzKgytq3MW6fG4YmSmNoLPD2cMPDnDHUX89F9b0XP6bPLuQFlkRcZn+Enq0BKOXqfcyJ9TbDB1s1HnEW/v80mRt3c4dHHrNMawxxdOZCpZzx+ElXCkmCj4gjMHWzk4xl/eA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQv7pnK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF979C4CEE8;
	Mon, 17 Feb 2025 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801901;
	bh=BysXgtPBiIvEVUwuCbk70Ntt9mEGd5mUR/DZjy2NLtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iQv7pnK/8yLiUJ6pfnVb80TY0F7EGz4yRCgoxTi1P7vmZoFPDz6nyelPUBKAhPBbZ
	 MCAQDnZo67ud76eUMZsCTX0ZMYY6knQ2BX/jTUkJi8SNYOZkceHtpQY2ACE5UKMhXl
	 IM9DXZmYfqp7Zv64UOC67eNaVwC/TWMgtKLVxiTrpZUHjk8CIO/CGAHbuFZs6SEQKN
	 F9tspgoIGJVLX+3g08V7xMC34W0u/6ZDoV5cepFJ0DgWPfwO5qhoglDQm4HDj9Td0E
	 jIrJEaJdaXehQIMVT71FvitvHb6++i+IV6fpfGHg8u3FC9EhYLfms+3A6KF1cxs8lJ
	 riNoP1vbuV0tw==
Date: Mon, 17 Feb 2025 14:18:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: light: al3010: add al3000a
 support
Message-ID: <20250217141808.314c2b83@jic23-huawei>
In-Reply-To: <CAPVz0n1TqscXQvyyD44FWZtRvV6kqAdbD0AYYCmyJOqG_DgOsQ@mail.gmail.com>
References: <20250215103159.106343-1-clamor95@gmail.com>
	<20250215103159.106343-2-clamor95@gmail.com>
	<20250216144201.6238345c@jic23-huawei>
	<CAPVz0n1TqscXQvyyD44FWZtRvV6kqAdbD0AYYCmyJOqG_DgOsQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Feb 2025 16:44:58 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:42 Jo=
nathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sat, 15 Feb 2025 12:31:57 +0200
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > AL3000a is an ambient light sensor quite closely related to
> > > exising AL3010 and can reuse exising schema for AL3010. =20
> > Hi,
> >
> > For a binding like this, also explain how they are different enough that
> > we can't use a fallback compatible.
> >
> > Thanks,
> >
> > Jonathan
> > =20
>=20
> Fallback will cause use of inappropriate driver. As I have already
> told, hardware configuration matches but data processing from sensor
> does not.
Absolutely understood.  The point is this patch description should
state exactly that. Say something like the register maps are incompatible.

Jonathan

>=20
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++=
--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al=
3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.ya=
ml
> > > index a3a979553e32..f1048c30e73e 100644
> > > --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.ya=
ml
> > > +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.ya=
ml
> > > @@ -4,14 +4,16 @@
> > >  $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
> > >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >
> > > -title: Dyna-Image AL3010 sensor
> > > +title: Dyna-Image AL3000a/AL3010 sensor
> > >
> > >  maintainers:
> > >    - David Heidelberg <david@ixit.cz>
> > >
> > >  properties:
> > >    compatible:
> > > -    const: dynaimage,al3010
> > > +    enum:
> > > +      - dynaimage,al3000a
> > > +      - dynaimage,al3010
> > >
> > >    reg:
> > >      maxItems: 1 =20
> > =20
>=20


