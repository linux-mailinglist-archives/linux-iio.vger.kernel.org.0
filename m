Return-Path: <linux-iio+bounces-5461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF638D3BBB
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324311F2632C
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A563181D19;
	Wed, 29 May 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRm21IPB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6367139588;
	Wed, 29 May 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998666; cv=none; b=LgUpIjKm+P+cs1dOcp5nu9GsU554Phw5S7QorWQ3MaeSNR0KfK6W5wtdBwvRuWGgmw3vmL5/Fw8f1rYob1Tm7NUqwe8TFj3s6vN9hWHlloc/u450325mq0ux8OdOMrQmZWMFpfE6XyVkeKwCl0k7BWnI6ChPEaBgHwhMqtwEO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998666; c=relaxed/simple;
	bh=DWKbl03/nXco70baKk+AHssQc5Q/D3vG7XftkkCmshk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjhP5r3vwBUFqVeIPsBD1e4lyvxyQAOscokcnHh8mN0GhmVcf5VDzNu/+TieZtBKZdnB2rxNIJTrVol7hZ2IvkFOsWq4wIg2fbTSF+IeG6S5Ik2SKqO5bpGoCyABFMb45EmlUXgRt8jCnlZvcdUXOuMYgDq/NbO+AIFZy+wiSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRm21IPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE1C113CC;
	Wed, 29 May 2024 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716998666;
	bh=DWKbl03/nXco70baKk+AHssQc5Q/D3vG7XftkkCmshk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRm21IPBmyqMapQh1CCFxQSxVoieejoEDj+RAl/vnlmcFMnXq8XWmNsMgR1Ki4N1M
	 bL3Oyh3kjXr9tdyh2YTqkEUlLgLB56bEEh1nEeTgk+wNxxvivvCKUqc4vOjwJnTYFk
	 tnsvy8dsaHrv9s5Pqn2SOb2Ipc5frnK9ORnmmKQEGExLlSRwUZH7U6G679vUNQ2P4P
	 vilpJCEwTGsr8LfOoTS41m03bQtE33isFsLLCjhGCN2cjnqNGn/bNaHeOvw8baQ3Pm
	 URjRZlPf7kV3G1retDhorzNl9tlVCcE0tsLCEN0+fR03ZGryT/miYM4b1HSQgx7XHf
	 plyE080/zz/OA==
Date: Wed, 29 May 2024 17:04:22 +0100
From: Conor Dooley <conor@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240529-slit-verse-0fb06f3556fb@spud>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
 <20240527-arguably-said-361184ad848e@spud>
 <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
 <20240528-filtrate-cloning-b9152322a3da@spud>
 <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1fQrEwqMuWGtDjnv"
Content-Disposition: inline
In-Reply-To: <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>


--1fQrEwqMuWGtDjnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 04:38:53PM +0300, Ceclan, Dumitru wrote:
> On 28/05/2024 20:52, Conor Dooley wrote:
> > On Tue, May 28, 2024 at 03:16:07PM +0300, Ceclan, Dumitru wrote:
> >> On 27/05/2024 20:48, Conor Dooley wrote:
> >>> On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 Relay=
 wrote:
> >>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>>> +      adi,channel-type:
> >>>> +        description:
> >>>> +          Used to differentiate between different channel types as =
the device
> >>>> +           register configurations are the same for all usage types.
> >>>> +          Both pseudo-differential and single-ended channels will u=
se the
> >>>> +           single-ended specifier.
> >>>> +        $ref: /schemas/types.yaml#/definitions/string
> >>>> +        enum:
> >>>> +          - single-ended
> >>>> +          - differential
> >>>> +        default: differential
> >>>
> >>> I dunno if my brain just ain't workin' right today, or if this is not
> >>> sufficiently explained, but why is this property needed? You've got
> >>> diff-channels and single-channels already, why can you not infer the
> >>> information you need from them? What should software do with this
> >>> information?
> >>> Additionally, "pseudo-differential" is not explained in this binding.
> >>
> >> In previous thread we arrived to the conclusion single-ended and
> >> pseudo-differential channels should be marked with the flag
> >> "differential=3Dfalse" in the IIO channel struct. This cannot
> >> really be inferred as any input pair could be used in that
> >> manner and the only difference would be in external wiring.
> >>
> >> Single-channels cannot be used to define such a channel as
> >> two voltage inputs need to be selected. Also, we are already
> >> using single-channel to define the current channels.
> >=20
> > If I understand correctly, the property could be simplified to a flag
> > then, since it's only the pseudo differential mode that you cannot be
> > sure of?
> > You know when you're single-ended based on single-channel, so the
> > additional info you need is only in the pseudo-differential case.
> >=20
> Yes, it could just be a boolean flag. The only thing I have against
> that is the awkwardness of having both diff-channels and
> differential=3Dfalse within a channel definition.

What I was suggesting was more like "adi,pseudo-differential" (you don't
need to set the =3Dfalse or w/e, flag properties work based on present/not
present). I think that would avoid the awkwardness?

> >> As for explaining the pseudo-differential, should it be explained?
> >> A voltage channel within the context of these families is actually
> >> differential(as there are always two inputs selected).
> >> The single-ended and pseudo-diff use case is actually wiring up a
> >> constant voltage to the selected negative input.
> >>
> >> I did not consider that this should be described, as there is no
> >> need for an attribute to describe it.
> >=20
> > I dunno, adding an explanation of it in the text for the channel type
> > seems trivial to do. "Both pseudo-differential mode (where the
> > one of differential inputs is connected to a constant voltage) and
> > single-ended channels will..."
> >
> >>> Also, what does "the device register configurations are the same for
> >>> all uses types" mean? The description here implies that you'd be read=
ing
> >>> the registers to determine the configuration, but as far as I underst=
and
> >>> it's the job of drivers to actually configure devices.
> >>> The only way I could interpret this that makes sense to me is that yo=
u're
> >>> trying to say that the device doesn't have registers that allow you to
> >>> do runtime configuration detection - but that's the norm and I would =
not
> >>> call it out here.
> >>
> >> No, I meant that the same register configuration will be set for
> >> both fully differential and single-ended.=20
> >>
> >> The user will set diff-channels =3D <0, 1>, bipolar(or not) and
> >> then they can wire whatever to those pins:=20
> >> - a differential signal
> >> - AVSS to 1 and a single-ended signal to 0
> >> - AVSS+offset to 1 and a single-ended signal to 0
> >> 	(which is called pseudo-differential in some datasheets)
> >>
> >> All these cases will look the same in terms of configuration
> >=20
> > In that case, I'd just remove this sentence from the description then.
> > How you configure the registers to use the device doesn't really have
> > anything to do with describing the configuration of the hardware.
> > Given it isn't related to configuration detection at runtime, what
> > you've got written here just makes it seem like the property is
> > redundant because the register settings do not change.
> >
> > Instead, use the description to talk about when the property should be
> > used and what software should use it to determine, e.g. "Software can
> > use vendor,channel-type to determine whether or not the measured voltage
> > is absolute or relative". I pulled that outta my ass, it might not
> > be what you're actually doing, but I figure you just want to know if
> > you're measuring from the origin or either side of it.

> >It's more to the "software can this property to correctly mark the chann=
el

Your quoting is scuffed here, I didn't write this!

> as differential or not". Hope this is acceptable. But got it, thanks.

As long as you've got a description that tells the OS what the property
actually represents, I'm happy.

--1fQrEwqMuWGtDjnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldSBQAKCRB4tDGHoIJi
0h+hAP9HgtxHzbYOpeOdlInP38k8mCjUNQ1jOet2R9xFvyi7KgD/awfrNzpr6Grq
gw8D1Luo3VGZOSo+/h2GPMl/zY/iNgQ=
=GSs9
-----END PGP SIGNATURE-----

--1fQrEwqMuWGtDjnv--

