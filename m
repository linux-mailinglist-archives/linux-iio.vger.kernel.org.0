Return-Path: <linux-iio+bounces-9401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC23971EB8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBAA2817BC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7DB139587;
	Mon,  9 Sep 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQEmJJIK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A458ABF;
	Mon,  9 Sep 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898002; cv=none; b=XEqBB7Em05Z++C5YvkQca3NK+nsNw7GaQFpcpFgWGiO9XUppyIouloF3CM/4J+M3u5c9aW91UrghGoLDuOccUhRPPM04lHBUhLWnU9h8K6BbnrdGSXfGvVOX6o6W3QsGkRWZHxTpO/+wLqmG18UkTyCPinSHLuRT3XMl/xkbuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898002; c=relaxed/simple;
	bh=mDVnefQAJunAzspN/WsR1bpxkh1iGXg4R1jTU0SJ5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbTU/2XJ0wXK1O1mnCfbhBcUztgrLYBeqjNDN2uLxCsb4bj8BWGk5DmKl6AtEkiLANr0TGi2AXuW3RzVP3OmbEP/xVZifk/YxDf2UAA7ChCBu95CFGET4M5pQKWGGaFSmT/4L0qzsgsc2DqbX7GzuSe3DWauR0jf10CA2pZXsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQEmJJIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B56C4CEC5;
	Mon,  9 Sep 2024 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898002;
	bh=mDVnefQAJunAzspN/WsR1bpxkh1iGXg4R1jTU0SJ5zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQEmJJIK9i4b2nmvW46aeXYhPMA9/zZm4b9452RpqaHyyfkPcFmPcyapYTH7uULRf
	 S7KnvUrSKOR2mHjaMKH45hlLSYL30kjOy/3TGdGj2qqgXfvIcRVaddtxnD3NdCUtjX
	 OB2+1RWxjcPQYrYfVqcbFjLrnrX1lS3DLAas38fqEWpEvqSUC9oQuQlWmYqp3bZwrE
	 5xuX75HATmmF5uE06MMgwjWVO5HBkiPH1XaE2tFzC1iXNISST+0NWDQqzKxX6w1dpl
	 YS+UMuBPszxoNcrja40bWNGGOuL7ZtYoqTk1GGbY5JvWoUINd5EzCrNbZ9DQ+/Dm8T
	 GFY9EJmyH5eJQ==
Date: Mon, 9 Sep 2024 17:06:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Message-ID: <20240909-retrieval-guide-da2a35e571a5@spud>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
 <20240908132925.331c5175@jic23-huawei>
 <20240909-dwelled-specimen-949f44c8d04d@wendy>
 <1dca9ce52e7c701c7fb6cbbc723e9dff5d0ace8b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QJgtZu1F/+wMZDUF"
Content-Disposition: inline
In-Reply-To: <1dca9ce52e7c701c7fb6cbbc723e9dff5d0ace8b.camel@gmail.com>


--QJgtZu1F/+wMZDUF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 04:03:17PM +0200, Nuno S=E1 wrote:
> On Mon, 2024-09-09 at 13:46 +0100, Conor Dooley wrote:
> > On Sun, Sep 08, 2024 at 01:29:25PM +0100, Jonathan Cameron wrote:

> > I'd also really like to know how this fits in with spi-offloads. It
> > /feels/, and I'd like to reiterate the word feels, like a rather similar
> > idea just applied to a DAC instead of an ADC.
>=20
> The offload main principle is to replay a spi transfer periodically given=
 an
> input trigger. I'm not so sure we have that same principle in here. In he=
re I
> guess we stream data over the qspi interface based on SCLK which can look
> similar. The difference is that this IP does not need any trigger for any=
 spi
> transfer replay (I think).=20

Right, if the trigger part is what decides it for you then I'm wildin
here.

--QJgtZu1F/+wMZDUF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt8dDQAKCRB4tDGHoIJi
0s4xAQC4NATh6G425B4WZvd5sGTC5i3wnUDbjaIlQmp/hHwjPQD+L1esehPkEcGt
6094n/y+3K7GbjRT7uSXeGW9wQf2LQo=
=Wl47
-----END PGP SIGNATURE-----

--QJgtZu1F/+wMZDUF--

