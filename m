Return-Path: <linux-iio+bounces-8519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A635995571F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73D71C20D39
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A841494C9;
	Sat, 17 Aug 2024 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxAAmHKO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA5328B6;
	Sat, 17 Aug 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889555; cv=none; b=FDR4npA4PwD97ZjdVU4MXiVuu9WabLcIu8JtAHT1nbVB2cnSTMRpNsiN1A8d94FaIJvOtonEByBC8oHi36N8KA+bGT8BppjuG2OSMUenNcKBeLnjTaDfTfXPhL+6VtTEjqv9lS5rR6I3JVYbaHOzoR7Hrxk0tnyJ5H1qhLi5IG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889555; c=relaxed/simple;
	bh=v6b57yf3wz+dSaYGrQVKJodqx8Mz1ILLpwhO2dENmng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVjfok+87El3zLk/r18sLpKqeO3kQLnLRCkZhJA37BNXHh4+qyBd4bmdvdyHY/dl73+TyN4cVCfcfMHG45C9JL9thF65ajB7/wNBUniy2RiQyj+E4tW7wLkC1CuPuN1ifpUfOH+TdeVtF9P5p7BxfKNEggVzNoJvCeRhnvI4vEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxAAmHKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E9CC116B1;
	Sat, 17 Aug 2024 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723889554;
	bh=v6b57yf3wz+dSaYGrQVKJodqx8Mz1ILLpwhO2dENmng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GxAAmHKO634jdtokS9+MJLYSQ36Fe1athlg3GrHVE/Eo4ASS6OFTmYTsyFvW9rwAR
	 PXpqeKY5hXgz08F7O1bOZ/Jmy+rOKepr0hCi/QeSSIV/YusEClryHBSyhEa4+KYXwg
	 512RdpRbjcvLNQbIOj1Z+xlSHPHZaX77i0XmivYhjNr7dgwMCB/ndoeBXr5BMTRW4V
	 1gltLmKhqMJTRMcdn8UotJP3zbMDCSYEmSkE54896FyalfkTYxZnEBmlV1EQnXYQkd
	 j/mY6fEZxXZ+cTBm/7mpF2hkqeY/vGDMTguiO+VtYvlBVln/dHyYEki/zvpWqAx3ph
	 SFl3DJrp/uTjA==
Date: Sat, 17 Aug 2024 11:12:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for ad4113
Message-ID: <20240817111106.0c141c90@jic23-huawei>
In-Reply-To: <20240809-autograph-sugar-e79e54fd7a24@spud>
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
	<20240809-ad4113-v2-1-2a70c101a1f4@analog.com>
	<20240809-glowing-discard-87263f656a7e@spud>
	<67eb7f5c-3f20-4831-a0cc-e407ac3f24ad@gmail.com>
	<20240809-autograph-sugar-e79e54fd7a24@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Aug 2024 16:09:07 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Aug 09, 2024 at 05:32:08PM +0300, Ceclan, Dumitru wrote:
> > On 09/08/2024 17:21, Conor Dooley wrote: =20
> > > On Fri, Aug 09, 2024 at 01:33:24PM +0300, Dumitru Ceclan via B4 Relay=
 wrote: =20
> > >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >>
> > >> This commit adds bindings support for AD4113.
> > >>
> > >> The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-t=
o-digital
> > >> converter (ADC) that integrates an analog front end (AFE) for four
> > >> fully differential or eight single-ended inputs.
> > >>
> > >> Added ad4113 to the compatible list and the "avdd2-supply: false"
> > >> restriction.
> > >>
> > >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >> ---
> > >>  Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml | 3 +++
> > >>  1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.ya=
ml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > >> index 17c5d39cc2c1..ad15cf9bc2ff 100644
> > >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > >> @@ -28,6 +28,7 @@ description: |
> > >>    Datasheets for supported chips:
> > >>      https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD4111.pdf
> > >>      https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD4112.pdf
> > >> +    <AD4113: not released yet> =20
> > >=20
> > > Am I meant to ack it with this placeholder? When will the document be
> > > released?
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > >  =20
> > Not really sure tbh, up to you. The document will be released in the up=
coming months.
> >=20
> > If it's considered best to wait until the docs are public and send anot=
her
> > version with the correct link.=20
> > If not, and maintainers consider that these changes can be accepted even
> > without viewing the datasheet, I'll send a patch when it goes public. =
=20
>=20
> I don't really care, it's just to Jonathan I think. I'm happy enough
> with you adding it when it is released.

Given some companies never release public docs (mine for example rarely doe=
s)
there is no requirement for datasheets. So this is fine, particularly if you
come back with a link when it is available.

Thanks,

Jonathan


