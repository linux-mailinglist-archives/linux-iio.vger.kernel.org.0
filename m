Return-Path: <linux-iio+bounces-5541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF718D64E2
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA231F27D99
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B0974042;
	Fri, 31 May 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUPuWP/N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA56BB5B;
	Fri, 31 May 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167121; cv=none; b=hPaxruyDykBhhB3YanQeaIKWZJnbHc+BZJukBkQ+eARxnWpk+8nwkYVzmu7cnFJ+Wwlb8ufIXBDRjxl2WF9yppbzNMDisDJmvclFu7rHez4Oehx/cvwFD+CYKSsc7xu2CdSRUQiupfqNCllxW5xWNIsjeRQWW0mdZ9yHozVlJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167121; c=relaxed/simple;
	bh=Ae/1bmVsvqbG6B0tErv/VXtZn0uXW6lgfBUNSSQ8+WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI6fD5geVys2M6WVbsNeAHuopYsd7LhN2RK7dp0FSzz9kgHrVwr86MRqdu7NTLkyzBaDjamb1Gqr02s0t7WRJcr1pmfGJ0KLKkXvS3Pb4JQSS07kNv+N4Jk/DOL1Y+DZ8v5pA0qjI/VBKKF1iGki7CjV+AFG0O4sekBlP8u+Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUPuWP/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9B7C116B1;
	Fri, 31 May 2024 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167120;
	bh=Ae/1bmVsvqbG6B0tErv/VXtZn0uXW6lgfBUNSSQ8+WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUPuWP/NDWVhvoLbj8KjV6psJrmPnhMlanG7TZaEzkQQi4aOi5CWURBgKHd3lV+dG
	 CBD0wObeYLSplCbJTbIBTR5Nbtbbk1WwKB8fxITOqnKAdc8soCoMb6ZqfEWX6uCoBC
	 qir5TTbY47RHYjy3CpVnb8z5k+fSyvBGYgYbXs08UXLXCprOEB8Mwb7arhsduTcp/e
	 BCul6CSJQHh9hGc8m4qWSPiz83P1061AgFVWeAUoaAny/U6mkxvrOn/QdWnmaMZC/y
	 f1qwAoBO6RI5P2bWY/B6wOXQwPaopyVzXI8QOEeWJzEXoiYH7fr/Im0poQyylJpA46
	 BG2cwdEX45GMQ==
Date: Fri, 31 May 2024 15:51:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240531-dairy-king-5a4e6c09b670@spud>
References: <20240531133604.1380-1-ramona.nechita@analog.com>
 <20240531133604.1380-2-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rxHMfQVAKZ8I7VeB"
Content-Disposition: inline
In-Reply-To: <20240531133604.1380-2-ramona.nechita@analog.com>


--rxHMfQVAKZ8I7VeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 04:35:52PM +0300, Ramona Alexandra Nechita wrote:
> Add dt bindings for adc ad7779.
>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
>  .../bindings/iio/adc/adi,ad7779.yaml          | 87 +++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.=
yaml
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x b/Documen=
tation/ABI/testing/sysfs-bus-iio-adc-ad777x
> new file mode 100644
> index 000000000000..0a57fda598e6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
> @@ -0,0 +1,23 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> +KernelVersion:  6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible filter modes. Only supported =
by
> +		AD7771.
> +
> +		  * "sinc3"	- The digital sinc3 filter implements three main notches, =
one at
> +				the maximum ODR (128 kHz or 32 kHz, depending on the
> +				power mode) and another two at the ODR frequency selected to
> +				stop noise aliasing into the pass band.
> +
> +		  * "sinc5"	- The sinc5 filter implements five notches, one at
> +				the maximum ODR (128 kHz or 32 kHz, depending on the
> +				power mode) and another four at the ODR frequency
> +				selected to stop noise aliasing into the pass band.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type
> +KernelVersion:  6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set the filter mode of the differential channel. The current sampling_=
frequency
> +		is set according to the filter range. Only supported by AD7771.

This patch is really confusing to me. Why is there a file documenting
the sysfs interface for a driver that isn't in the tree? Shouldn't this
patch be part of a series that adds the driver? I suggest you speak to
Nuno or another collogue about how to submit a series.

Thanks,
Conor.

--rxHMfQVAKZ8I7VeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlnkDAAKCRB4tDGHoIJi
0ictAPsGZBONtNVkwdopjcHTZfSSRPRg2VpecEAmz7u/SHamQgEAmtnrs3jl3KAr
cjQW7yIlAi71HXWZ6fEPLKCYc98DOgc=
=J4bf
-----END PGP SIGNATURE-----

--rxHMfQVAKZ8I7VeB--

