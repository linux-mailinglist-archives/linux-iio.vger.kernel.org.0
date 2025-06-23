Return-Path: <linux-iio+bounces-20916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 406DFAE49CE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36A51884E8A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE528CF7C;
	Mon, 23 Jun 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atBR1yoF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88B46BF;
	Mon, 23 Jun 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694610; cv=none; b=hp/jI8EbA9y3eAodcgRotiivW6NFWF0PrVw+ccEMBdA81d4xRV9jsXaT0r56ZmSdscrtZwmzZae4bGV0GV+AtcntvhYdgnLe0jwpLcEUKCkLrJ67ispb6hxSVk0/ACbajLIZQKNuW4ytAwQLPWuvw16lgOLUqT9TL6/OrMpweSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694610; c=relaxed/simple;
	bh=Im7cr83Qj96BXun7jEtX6pW1mHhhSCofTIbdw7BXGAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV6Qksg1Mp9j/p2KyrM7w506GpgZE5EEOitpmyTCooVFKxIAsXSxPxAPgH5IsU0t/2LbrECfuf5Z1c6hwhLcBXi+BFBZnvrUKJgGR8sY9zf9mossSlanZFHAtowaqsIvZoLx5V6CkcEXANcv+X0A4RODQtSXNO8PGVQLplZDnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atBR1yoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D21DC4CEEA;
	Mon, 23 Jun 2025 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750694609;
	bh=Im7cr83Qj96BXun7jEtX6pW1mHhhSCofTIbdw7BXGAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atBR1yoFU+LYSgHiG6FfHOYRHxWixoy6VDDNSRmX6HlDgDSB9Jv4nd7UNQlqj47Od
	 G4OPLzJxT5+8uYYO91siq9wfNkg0YEipbBrDfvOJcYPx2zVDHT3EPOJr56JMdhRbtp
	 dLayjTW/mQLLjwIMOyKdAcQZ9CfPJEyC7d4R+uN1ymebECTLR/GnbN9/8mGFjozy0c
	 TSQIm2I2e/ft+8p6gtogDFzEhrL/OoixSnx7ON6HCrwEphxzNV4laOKgdEIg6ddzi6
	 SP+MySsGpQQpqvVEaknNxmO5U20EZffXr9tphwHDrb8UUnfp8OQRDGZao0XNc7die/
	 e57YwXHtGQtPA==
Date: Mon, 23 Jun 2025 17:03:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250623-wackiness-unaware-e0e904064990@spud>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>
 <20250616-neurology-explicit-ec2a829bd718@spud>
 <eeb66815-3f7d-41fc-9d32-c28a3dda7749@baylibre.com>
 <20250621172808.6f304023@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bXfoSPrYbNtw7+sq"
Content-Disposition: inline
In-Reply-To: <20250621172808.6f304023@jic23-huawei>


--bXfoSPrYbNtw7+sq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 05:28:08PM +0100, Jonathan Cameron wrote:
>=20
> > >> +
> > >> +$defs:
> > >> +  reference-buffer:
> > >> +    description: |
> > >> +      Enable precharge buffer, full buffer, or skip reference buffe=
ring of
> > >> +      the positive/negative voltage reference. Because the output i=
mpedance
> > >> +      of the source driving the voltage reference inputs may be dyn=
amic,
> > >> +      resistive/capacitive combinations of those inputs can cause D=
C gain
> > >> +      errors if the reference inputs go unbuffered into the ADC. En=
able
> > >> +      reference buffering if the provided reference source has dyna=
mic high
> > >> +      impedance output. Note the absolute voltage allowed on REFINn=
+ and REFINn-
> > >> +      inputs is from AVSS - 50 mV to AVDD + 50 mV when the referenc=
e buffers are
> > >> +      disabled but narrows to AVSS to AVDD when reference buffering=
 is enabled
> > >> +      or in precharge mode. The valid options for this property are:
> > >> +      0: Reference precharge buffer.
> > >> +      1: Full reference buffering.
> > >> +      2: Bypass reference buffers (buffering disabled).
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > >> +    enum: [0, 1, 2]
> > >> +    default: 1 =20
> > >=20
> > > Why make this property a uint32, rather than a string where you can u=
se
> > > something like "precharge", "full" and "bypass" (or "disabled")? The
> > > next similar device could use something slightly different then the
> > > binding becomes pretty clunky.
> > > Can you explain why this is a dt property rather than something
> > > adjustable at runtime?
> > >=20
> > > Otherwise, what you have here looks sane enough to me - but I'd like =
to
> > > see some comments from Jonathan or David etc about your approach to t=
he
> > > excitation properties. =20
> >=20
> > This looks like something that should be in the devicetree to me. For e=
xample
> > if the external reference supply is high impedance, buffering is pretty
> > much required. And using precharge is an application design choice to
> > reduce THD at the expense of other limitations.
> >=20
>=20
> Agreed that this pretty much only makes sense in DT.
>=20
> In the ideal world we would have firm rules on when to enable buffering
> etc and then the DT would describe the impedance of the circuit connected
> and any other relevant properties and then we'd have the driver enable it
> only when those rigid rules dictated that we should.
>=20
> Sadly no such simple rules exist (as far as I know) so we just expose the=
 thing
> that gets set dependent on someone's judgement of the suitability of
> the buffering choice given the circuit being connected to the input.
>=20
> If we pushed it to userspace we'd just end up with a per device blob
> that dictated the mode to pick on boot and left it like that.  So effecti=
vely
> another bit of firmware :(

Can't remember if I replied to David's mail here or not, I pretty much
just asked the question because I didn't understand why the usecase and
wanted an explanation for my benefit. Probably makes no sense to explain
why a knob exists in the binding when anyone using the device will not
need one, but that does mean that at times with these devices that are
unfamiliar to me I have to have it explained to me why something is set
in stone.

--bXfoSPrYbNtw7+sq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFl6ywAKCRB4tDGHoIJi
0r3SAP0ZJKr60N8/8sBTeapWC+EhVNQdhP7AJbKB7+5RUca00AEAvJxZ7E174bBJ
XlvJPxI1q/Z5n6SnGKtpLpWtE5bcXQQ=
=BaA5
-----END PGP SIGNATURE-----

--bXfoSPrYbNtw7+sq--

