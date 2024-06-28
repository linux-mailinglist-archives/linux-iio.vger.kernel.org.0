Return-Path: <linux-iio+bounces-7000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7310291BE59
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 14:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF0D1F23C6A
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276315572B;
	Fri, 28 Jun 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2GYbI1n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B71E898;
	Fri, 28 Jun 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577064; cv=none; b=gKXsK60ib6PFcWaK4N7+NTY4nUgYfes5o1tVcO+21MiWbR/ZZ4lw3vY5SD1B2Q4Pr65cnfx5XF2zuN5h7BeYqcRbe7dtinIv5WrglvktpWB/jPuf+Gm5qfG175n0ZoN2R+vLUAGxUY905dY63DFMse1OA0SiNnSVLOwd6vwx25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577064; c=relaxed/simple;
	bh=lPJqidH6rh/hlQuWyzH6JWqpzeGhRdafVAMs4oSHz4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoPiKMQn730OVP6ZnhzKtoJbLj5CF7X1+DGfU5g+8fN1lnzM2ZNbuBoA3c4jtATqNynDIEoiLf0HOJgpxZDo9QWnf4ly7PjXq3M7xD4iUvgrB8qpr75Qtw6KOPxFoGKHfgNHhzhhfXatx+zof7uoL0KxlJIHfysXWHsu/pFqpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2GYbI1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0990C116B1;
	Fri, 28 Jun 2024 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577064;
	bh=lPJqidH6rh/hlQuWyzH6JWqpzeGhRdafVAMs4oSHz4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2GYbI1nQ/yRuFUoE73M98TleeFTikguAos6EIvQhQHMmeptwXiBxBZu97ptu8dRC
	 ZGFHqwpYzKjKOYqx7iszA/QHESDYTXOqKJeVKfmrgIr/bmf992ebpNrUEKX5Ob/QKK
	 8qIl6Hfov8OaIqS5yN08WC7bUgnrg1xW1KIaH8gLNO1JY+mnqWq1ybNWDvL/jvklWK
	 qfPM1sfex6KWU4vttFtXTlUje4z6efY3Uo3A82rVXk6W8VGtJg38sJIoA0SFRwOHfH
	 A7ghmVbjUc/wNQguxLYcQgDWcOidHQNUI/MeP3XEZ+8IBVd2z33vhrCuwUYL+OCb4Y
	 mSG1TTbQP9vbw==
Date: Fri, 28 Jun 2024 13:17:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Julien Stephan <jstephan@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/5] spi: add support for pre-cooking messages
Message-ID: <15effa16-696a-4cc5-941b-375d1bbc31df@sirena.org.uk>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
 <Zn6HMrYG2b7epUxT@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HJ5q/Xqa/ExsXZ/6"
Content-Disposition: inline
In-Reply-To: <Zn6HMrYG2b7epUxT@pengutronix.de>
X-Cookie: divorce, n:


--HJ5q/Xqa/ExsXZ/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 11:49:38AM +0200, Oleksij Rempel wrote:
> On Mon, Feb 19, 2024 at 04:33:17PM -0600, David Lechner wrote:

> I have a regression after this patch set. My system explodes with
> following trace:

Not looked at this at all but were you able to try a bisect?

>  Call trace:
>   0x64f69bfd319200
>   spi_async+0xac/0x110
> 9H0[]6 spi_mux_transfer_one_message+0xb8/0xf0

Could you run this through addr2line please?

--HJ5q/Xqa/ExsXZ/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+qeEACgkQJNaLcl1U
h9DIsQf+LObiaHYQilaxnoCMNm6d/Ie3c221fUY6BfaRAVRU7kBHxpM1/DtRXMzN
B+OJxgTKmT726SMZoT+JX+fRfF4GWYQhPpM47Ic6leC/uwk8EjhNGT5rHXCUutIN
58EmKsfMBn2KI/L4avav/nigQE0hsB7EJK8QnjsYEi29TdZVWXEGiRTJRK3VoDTI
Xd1vroVy2Y2NCVjkW6QvxeSmdYtcoYtH/SUH5omPJTDea3+5kyLnHO2Ufftsluo5
C0hJrSchIpWOPBU704f0MQ8ZscKPsVEa8Cjuqf2w3qyBcs0ORGWlD7HJdtfP8BGB
vCyX+tJs4JccE01WgzZGfEQoreK5Jg==
=vIz6
-----END PGP SIGNATURE-----

--HJ5q/Xqa/ExsXZ/6--

