Return-Path: <linux-iio+bounces-20417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1EAD535E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E007A2AE7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F32E6122;
	Wed, 11 Jun 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB+OkxzF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A862E610B;
	Wed, 11 Jun 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640377; cv=none; b=Oxu5AKrfFusWjyOtCX5reZPXpS8edG3cGNJ0fFzJugNAn0Z7r5/Kc8h5sMVWbwmnkyvIEogWSD2+OcPnXh+5NdhIONX5vZHJvmQot8Kz3maQqNxZwMS/GlqxgaFpHSGJL2DLFsppUczHWVboRbn7zYIG+39wsECOI7U52oqJt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640377; c=relaxed/simple;
	bh=cuL/gnq/gn/v2XXovLUaVPiE6Y9kxenTDBpAhcvSFog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6fWRcx1A/Dc2pfpUSl+e5+e2GIJNqt6MYHmeQfpKQYWXs4jQh8nZbx+pwAdgP6yXbmOzHCDSzIp0W6zZt6mEauE3KJW/eIZVnV9xfxicfpezIqypvLokEVr6g5i6ai0OaTMRxHyPiI2Hmtq6C5RaOf3ztc+GLM4Hji2c6gTS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB+OkxzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E41C4CEEE;
	Wed, 11 Jun 2025 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640375;
	bh=cuL/gnq/gn/v2XXovLUaVPiE6Y9kxenTDBpAhcvSFog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FB+OkxzF/JTkIABV3hZpRIBuk3D+cl0hLPtR5s//hJ7x70YRGgWCw5cRt9djzjTKx
	 NaPRoPJGUt7Qxwjv/+Hk2Gboyqg6TRSjdOJb5bmwQujFGTkHcHv9oe+u3zxRblOtFE
	 a+LJD4KRpv2w5g7rKZQgjQOr2jpRr5j9Su+E4RBzrAt6xhRwkHxlDd5VRTDMJtuUvG
	 X3WN1/q0ZFW/cQ4j+ufuMPcbCFFTV0e6kATr9sV9+w4qfbXk1kLX9uvuXefQwQ+KIs
	 q8GYmBwxblMzQqbLVAX0A/GaTZbI+q6FaNPH4Z9QwdXvPNFepj1pzHgZMKOlgnFtBv
	 fmC+G/lveDWsw==
Date: Wed, 11 Jun 2025 12:12:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Da Xue <da@libre.computer>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC] spi: expand bits_per_word_mask to 64 bits
Message-ID: <b3d2a914-77be-4be6-bd43-cfaea7e450c9@sirena.org.uk>
References: <20250611000516.1383268-1-da@libre.computer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bucA20IzGsWOGyc7"
Content-Disposition: inline
In-Reply-To: <20250611000516.1383268-1-da@libre.computer>
X-Cookie: No skis take rocks like rental skis!


--bucA20IzGsWOGyc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 10, 2025 at 08:05:15PM -0400, Da Xue wrote:

> Most current controller IP support 64-bit words.
> Update the mask to u64 from u32.

The change looks broadly good, the only concern I have is making sure
that the controllers are individually checked for support and impose any
restrictions they need.

--bucA20IzGsWOGyc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhJZLEACgkQJNaLcl1U
h9DHHgf/dHG/rr6Bv2YtqYL+Ket5fd/hqjQ86KroqI0toxCmA1eE9KbCpJt6vXZc
oJed5XwyXWhlOInKHxFal9yCkn2RDV3B8DI4XYOc4L+PXKJXFSsFu/Hcck+5Q1hr
OWTFIVJVM8g082nL9ds4yHZgBXhuoA6om8/y3vLSSymOYV2r3muV9TLtuLi7RRvp
cffMdI7ojL9FHwYhYl/q+9K/NBqP95o4pdPY8mCjJUhGGxJhr6PlhV3rRC/Xwsyc
XCcE3aGY4vwURe2IhfiK+9ZIk+SnzaQ3lkdtdmAW5oaP6lE162f8hgLFjnDBegiH
LVe9SYAWS++X3iV5XYI6XUvbTbkiYw==
=7Xzl
-----END PGP SIGNATURE-----

--bucA20IzGsWOGyc7--

