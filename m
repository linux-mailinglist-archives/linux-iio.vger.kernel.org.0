Return-Path: <linux-iio+bounces-132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F8C7EE8CB
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 22:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91791C209E2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CE4654E;
	Thu, 16 Nov 2023 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz9TUSeg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4333C483;
	Thu, 16 Nov 2023 21:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F05C433C8;
	Thu, 16 Nov 2023 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700170312;
	bh=HkqW/xbxkGnLq1viptkMdud4OyAiGVdBsU1lpf5TE20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vz9TUSegoI7rqv//v7Cqe/+3+YqU9uRvzmIzQ8nHFagHeFeuhIQJeI2U/j3BH+bDH
	 KzKEsLIy5+ryc5ae8pcTCdeScD7/geUH0qLHvIHcvXpePlpfXMti2xu0vUl7YtNKfC
	 Rdu8rUiDYIMQ14XgCRihB56d86XXeRA//c2UFvekXJWByh2fYBsNWrs50wT7oX9VrH
	 aMnheh2RrHl1cEljKEgrlgf+7OKjhm10Ah0ZmLD1vxdfFRpkA5QZrdTlT3/GxXTEz9
	 R06QnSlaEjDdH6UR0K8HhkmMJCRCqqeZjC66QNRrsH9Oxvk5en0ydWc+V/juPEIySk
	 dzt5lUokVfXug==
Date: Thu, 16 Nov 2023 21:31:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC193X
Message-ID: <20231116-uncork-onscreen-d041bbe3bb3f@squawk>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
 <20231115134453.6656-2-marius.cristea@microchip.com>
 <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
 <20231116-channel-variety-cc7c262924ad@squawk>
 <9d0749ee-08e5-4630-b1b4-27d6aa436b29@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qy1pUtZjnv7Y8u6G"
Content-Disposition: inline
In-Reply-To: <9d0749ee-08e5-4630-b1b4-27d6aa436b29@linaro.org>


--Qy1pUtZjnv7Y8u6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 09:00:50PM +0100, Krzysztof Kozlowski wrote:
> On 16/11/2023 19:21, Conor Dooley wrote:
>=20
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: interrupts
> >>
> >>
> >> I don't understand what do you want to say here. I am also 100% sure y=
ou
> >> did not test it on a real case (maybe example passes but nothing more).
> >=20
> > As far as I understand, the same pin on the device is used for both an
> > output or an input depending on the configuration. As an input, it is
> > the "slow-io" control, and as an output it is an interrupt.
> > I think Marius is trying to convey that either this pin can be in
> > exclusively one state or another.
> >=20
> > _However_ I am not sure that that is really the right thing to do - they
> > might well be mutually exclusive modes, but I think the decision can be
> > made at runtime, rather than at devicetree creation time. Say for
> > example the GPIO controller this is connected to is capable of acting as
> > an interrupt controller. Unless I am misunderstanding the runtime
> > configurability of this hardware, I think it is possible to actually
> > provide a "slow-io-gpios" and an interrupt property & let the operating
> > system decide at runtime which mode it wants to work in.
> >=20
> > I'm off travelling at the moment Marius, but I should be back in work on
> > Monday if you want to have a chat about it & explain a bit more to me?
>=20
> Sure, but which compatible contains "interrupts"?

Yeah, I did notice that - I figured you understood that that was meant
to not be a check on compatibles, but rather on regular old properties &
the rationale for the mutual exclusion was what you were missing.

--Qy1pUtZjnv7Y8u6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVaKOgAKCRB4tDGHoIJi
0smuAQCNpa1dlXPZqWLjgqP8b+I5SvrWhzNufcLR2XSaUA5qdQD/WziAESAZdybU
8u9x2hZK43Ao6LkoE6nWOYKlAOu0uw0=
=zWfv
-----END PGP SIGNATURE-----

--Qy1pUtZjnv7Y8u6G--

