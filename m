Return-Path: <linux-iio+bounces-5775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A56D8FBAB3
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505CDB2ACE8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281E14A09A;
	Tue,  4 Jun 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS9JgKcI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C1146D6E;
	Tue,  4 Jun 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522546; cv=none; b=WzZFJIvbKg8K06vr089tfnVEZkyFK5S7lVgQbu1MX9virftEf6U2SPNobRME1Q4IVaJ+cm3OfhneeFEmKBxgKKKKP5QjOUVVGnwf90/EkeRWoVX7Y+IsO2FiYTSJcJKY2xcmSGA6ePdANzHAHn7RpzKKCbGtXG3tbmgU/8QQSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522546; c=relaxed/simple;
	bh=LZ2gZVAxd7B/Z2dlVqxhZwIjcAne3l5f3dO6vlVXRfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU0Hq2lmcyj7wxnJXKMpHnKH0ZwXZS00H1qU7LeBz2Iyyc4SnFHKd3eZurp5lHPFd842QwBh0em4JnI4BfN+VMlTVfIJmLaLLMC6z5UHjOvgjmrUQJ87yDJOaXzNKX5BCd6gVEnUWbOh/DyaLkj5k9TbhlD4zvpWo5esO/FOxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS9JgKcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D55C2BBFC;
	Tue,  4 Jun 2024 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522546;
	bh=LZ2gZVAxd7B/Z2dlVqxhZwIjcAne3l5f3dO6vlVXRfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QS9JgKcIiNG6uXtpVgBhRgZb55zKms71XzqF/eG9cvf5dD5lGUtH54nyYFI7D9SRD
	 JvJXcXaD2QFeelL7XW6A0qpWSMR6sO7je1NCpdeYc838qQAGlrZMDSdyqroujk7Mcj
	 obOX5E6L+94VWonx1vl3wawwOj86bbxsRqBe1gI8+RucbsbyO9u7KBcfqjwf05x/af
	 8zFsQ7HdUwflojN/7w7Sg8KmJQBulENlN6yLBpQboU59Hsc5oSRYjkczw1zTwYKR66
	 DAJmgYwbhpfJ6ESbYlHra5AAE1d+IJrCDwrnxqo+Y9vmmAI+cuJmJZdWRfJjrX6UmD
	 LyCF61lPrrOow==
Date: Tue, 4 Jun 2024 18:35:41 +0100
From: Conor Dooley <conor@kernel.org>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: iio: adc: Add common-mode-channel
 property
Message-ID: <20240604-sandpaper-aliens-05dbab5b2df5@spud>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
 <20240603-ad4111-v5-1-9a9c54d9ac78@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S+XBbKqsoN+A5IiA"
Content-Disposition: inline
In-Reply-To: <20240603-ad4111-v5-1-9a9c54d9ac78@analog.com>


--S+XBbKqsoN+A5IiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 07:22:59PM +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> There are ADCs that are differential but support to measure single-ended
> signals on the same channels by connecting a constant voltage to the
> negative input pin.
>=20
> This property allows to properly define a single-ended channel that
> requires two inputs to be specified. Software can use the presence of
> this property to mark the channel as not differential.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--S+XBbKqsoN+A5IiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9QbQAKCRB4tDGHoIJi
0s69AQCGC0ulZogpvt2PjR9FhR2Kajq4+cr21kDIPAPAvYplqQEAlLQ+9SbyGuPb
HbMhaYbM2JEWx6RqWpi7jSIWZNaANgk=
=L/dt
-----END PGP SIGNATURE-----

--S+XBbKqsoN+A5IiA--

