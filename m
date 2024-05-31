Return-Path: <linux-iio+bounces-5542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D88D64EB
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B378E1C24E26
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425CB57323;
	Fri, 31 May 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK7s6oD6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06681CF9B;
	Fri, 31 May 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167242; cv=none; b=ciOILIKeQJJttFzILm1XSxlNuL4jeljSwo8bGjRrOLFhRRdtX6kLDIVI2MyVJ+evqe2amN/WSftL6U6ShiR9zkVvy0FAo6+SICNwnNQrvxeP0upp5duQd2Gd0f1+DfAbkOVfkh4aJx9IUCLTsuLAEKbohIhb94V83fa0huxBwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167242; c=relaxed/simple;
	bh=5fZlWsVChO9de455++itdnUm8abWuXufPQEk6Jo6n/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXpCFwVMCT7B5NK4K7nHM1J1GBaUaVKzFOcIvpO+Jza18t8TK8LtEGjdGfnaKi/bid2kC2TgyCkOEL9+nDvrzkCZmHr6tZKWf/y5Ly1T2008NfBkQVsikJhuyow0YMYOB4Y3HDb9ncehLQKcgeS2Vd6C0uJ80J2mFWaCSEMl7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK7s6oD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598BBC116B1;
	Fri, 31 May 2024 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167241;
	bh=5fZlWsVChO9de455++itdnUm8abWuXufPQEk6Jo6n/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OK7s6oD6igiliCnbwcsOXieG8i+nZDOb34iAd6aa/7aOJE1dG2CaCV4q3nm2/HJiW
	 o/M9R2Z4WwpZ+L3GKI7kc9fGgc/xxKr1lfgSnRv65NxIBI/lZRL5BR6bMjo5ppVgpu
	 36hy1uyR1IEPJSHisdZOc0NNIJh37O51lUWdohFJD9M8/cCGu4U+vK7UuXgjGzpoll
	 kPX3cJKif0vDuDlcSmw/X4PgHanxvVKg5Lacewt8c9kN8AEzNRl4+Fe9on3VjpWQKa
	 wkDg5RQiQtDARHpFZ0o+iYetorZOItoglxwZOaNwUlNKFl2/ro5l8Tp7WhyffLtFjE
	 pGc696/46GO+g==
Date: Fri, 31 May 2024 15:53:57 +0100
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
Message-ID: <20240531-relocate-sassy-fd31e418845b@spud>
References: <20240531133604.1380-1-ramona.nechita@analog.com>
 <20240531133604.1380-2-ramona.nechita@analog.com>
 <20240531-dairy-king-5a4e6c09b670@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3hx+xfsV8K1ufwsd"
Content-Disposition: inline
In-Reply-To: <20240531-dairy-king-5a4e6c09b670@spud>


--3hx+xfsV8K1ufwsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 03:51:56PM +0100, Conor Dooley wrote:
> On Fri, May 31, 2024 at 04:35:52PM +0300, Ramona Alexandra Nechita wrote:
> > Add dt bindings for adc ad7779.
> >=20
> > Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
> >  .../bindings/iio/adc/adi,ad7779.yaml          | 87 +++++++++++++++++++
> >  2 files changed, 110 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad777=
9.yaml
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x b/Docum=
entation/ABI/testing/sysfs-bus-iio-adc-ad777x
> > new file mode 100644
> > index 000000000000..0a57fda598e6
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
> > @@ -0,0 +1,23 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> > +KernelVersion:  6.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Reading returns a list with the possible filter modes. Only supporte=
d by
> > +		AD7771.
> > +
> > +		  * "sinc3"	- The digital sinc3 filter implements three main notches=
, one at
> > +				the maximum ODR (128 kHz or 32 kHz, depending on the
> > +				power mode) and another two at the ODR frequency selected to
> > +				stop noise aliasing into the pass band.
> > +
> > +		  * "sinc5"	- The sinc5 filter implements five notches, one at
> > +				the maximum ODR (128 kHz or 32 kHz, depending on the
> > +				power mode) and another four at the ODR frequency
> > +				selected to stop noise aliasing into the pass band.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/filter_type
> > +KernelVersion:  6.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Set the filter mode of the differential channel. The current samplin=
g_frequency
> > +		is set according to the filter range. Only supported by AD7771.
>=20
> This patch is really confusing to me. Why is there a file documenting
> the sysfs interface for a driver that isn't in the tree? Shouldn't this
> patch be part of a series that adds the driver? I suggest you speak to
> Nuno or another collogue about how to submit a series.

Colleague*, auto accepting vim's first spelling suggestion strikes again
:)

--3hx+xfsV8K1ufwsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlnkhQAKCRB4tDGHoIJi
0nXXAP966lZ8z3VVf9rnxuQw1i1VXpZKPKxSQiG466XA5dsYqAD+I8LN4L4lVZig
X0B+rTyY5jhEO206qTbesfcpsvoivQ4=
=D6pP
-----END PGP SIGNATURE-----

--3hx+xfsV8K1ufwsd--

