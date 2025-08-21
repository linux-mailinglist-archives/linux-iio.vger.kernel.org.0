Return-Path: <linux-iio+bounces-23113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9DB301B4
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8187E3B7BBD
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF8342CBB;
	Thu, 21 Aug 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i77FBwAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008491FE44D;
	Thu, 21 Aug 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799615; cv=none; b=ppH6l+YelXlWhUuD6ZNb/L1UQZM+EM9OIAM5wvWIF3EIfh1EebvDojlQJjYBkocI7dnZYxFiVf8LE5c4DZH66Vesw9mKo5T9dUjeVvL/mZLU9adW3bPPITgVUPJwtZbjp2R7BK0sqcTNTs9yw+wKhEoAMX1jxl1uWRseqg+5268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799615; c=relaxed/simple;
	bh=L/oJic+hclWcb0OI6z6PFM6TWuSsr8HbYDJJztF2IHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEHQhIR2GEHgtjVzDxMQb19ZyUoftr3egay7nJ9XX5lajsDgPfweVb6ZClwIEpJzlcLY7jBkmj3VK4JdcPCNdYRsTynth4Z47e7WWs4xQV1dVZOy07iIDi1u3EjdcUKXonZFIWb00fRHGtPsnH7kWfXsw5ddMOxsdB74FwdhZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i77FBwAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D557C113CF;
	Thu, 21 Aug 2025 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799614;
	bh=L/oJic+hclWcb0OI6z6PFM6TWuSsr8HbYDJJztF2IHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i77FBwAj5KCJ1unBguppDBo8oE61T2JpPjBkc1QTmATgP+nvT6ovEVnJB4nnCupgV
	 EGei9Yw/8szzsDdUF4mk+iNg3nq7pZ2PzDJ3ftUYE4RWNjXHosxGX0TOJxoXfyRTPe
	 uOsxzNMsRNtIR3YBkO/Vt/EN8f+Rm9brNDcGg/YMYqWnnOLLKItKL0agfqz4htTpn6
	 jPKbL2s1bj0R/qFZjTQXjXcWzmDIUVXKaksq4GPtti1HjpTAWTXxIlghoK3TIeeiYL
	 pepjs4HRi6TEQt9u2lu49/ZpUrzI1VrIbE2TiqReXkhW0QwXtiaZzvj5K7YSE21kWL
	 rppp67bMMl6GA==
Date: Thu, 21 Aug 2025 19:06:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>
Subject: Re: [PATCH v1 0/2] Add MAX14001/MAX14002 support
Message-ID: <20250821-haziness-squeamish-81713e94d079@spud>
References: <cover.1755778211.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CmbokF2ke1ZZ2/fW"
Content-Disposition: inline
In-Reply-To: <cover.1755778211.git.marilene.agarcia@gmail.com>


--CmbokF2ke1ZZ2/fW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:36:06AM -0300, Marilene Andrade Garcia wrote:
> Hello maintainers,
>=20
> This patch series adds basic support for the Analog Devices=20
> MAX14001/MAX14002, configurable, isolated 10-bit ADCs for multi-range=20
> binary inputs. Besides the implemented ADC readings, these devices have=
=20
> more features, like a binary comparator; a filtered reading that can=20
> provide the average of the last 2, 4, or 8 ADC readings; and an inrush=20
> comparator that triggers the inrush current. There is also a fault featur=
e=20
> that can diagnose seven possible fault conditions.=20
>=20
> To keep the commits simple and organized, these initial driver support=20
> patches aim to upstream only the features related to reading two register=
s,=20
> one that contains the latest ADC reading, and another one that contains=
=20
> the latest filtered ADC readings. Though, _raw and _mean_raw are providin=
g=20
> the same results in this initial version since the data averaging config=
=20
> interface is not implemented yet. For this, IIO_CHAN_INFO_AVERAGE_RAW was=
=20
> used to return the filtered average of ADC readings. An additional patch=
=20
> documenting the in_voltageY_mean_raw interface can be added on v2 if that=
=20
> would be desirable. The idea is to use in_voltageY_mean_raw to return the=
=20
> filtered average value, and also to set how many ADC readings (0, 2, 4,=
=20
> or 8) are included in the mean calculation. I would also like to know if=
=20
> you have any feedback on using IIO_CHAN_INFO_AVERAGE_RAW in this way.
>=20
> The changes were tested using the Raspberry Pi modified kernel version=20
> rpi-6.6 on Raspberry Pi 5 hardware. For testing, the MAX14001PMB evaluati=
on=20
> board was used, which contains two MAX14001 devices. According to the=20
> board=E2=80=99s circuit configuration, one device measures current and th=
e other=20
> measures voltage. Due to the evaluation board=E2=80=99s circuitry, the de=
vices=20
> also receive an offset that allows them to measure negative values. None=
=20
> of these evaluation board-specific characteristics were included in the=
=20
> driver code (neither the offset nor the current channel capability).=20
> However, they were considered in the calculation of the values read by th=
e=20
> devices. Should the code that applies these board configuration parameter=
s=20
> be added as an additional driver file inside the IIO subsystem, or should=
=20
> it remain only in a user application file?
>=20
> The code was developed during the GSoC program as part of the Analog=20
> Devices Mentorship. Many thanks to my mentors Marcelo Schmitt,  Ceclan=20
> Dumitru, Jonathan Santos and Dragos Bogdan for their guidance, reviews,=
=20
> and explanations about the IIO subsystem code.
>=20
> I intend to keep sending patches to cover all the features of the device.

Something gone wrong here? There's already a v9 from another ADI
employee on the list:
https://lore.kernel.org/all/20230710042723.46084-2-kimseer.paller@analog.co=
m/

--CmbokF2ke1ZZ2/fW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKdgOAAKCRB4tDGHoIJi
0ndsAP99s7LMlpgxtMf7eN2DmaSN0b8LV21wDZYkD2RqSqpaoAEAz2PZfylULpkf
XMvWyYRkXnivvg/7pKONfBaScDs7gAg=
=ShSV
-----END PGP SIGNATURE-----

--CmbokF2ke1ZZ2/fW--

