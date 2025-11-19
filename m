Return-Path: <linux-iio+bounces-26320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7153C70AE3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 19:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1BCE4E651F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A46314D2F;
	Wed, 19 Nov 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHvFGoGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E613002D0;
	Wed, 19 Nov 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577521; cv=none; b=lgopxxRuWtORiLNpZ4l45ZXlLzbrU7U2mcWw2RfsiR8ABK8DgbmPFdN2RADrEzZGmNw3OU82472NoJd4FDCMJ9ygTjzLwsYIDoq/Zh9D4fvgmI8/G86fqD6Uxzpem/a4VjLlifguc4YIBfMEJjtdbP7iiRU3uuZR3Qv+TqawHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577521; c=relaxed/simple;
	bh=HvQBiOaS5pNwDBn1SZfwxuH2i8dN0uHP5R2UidJ8f2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AisWOOY0zFs9AVVLIxYG9zsHqcfj4sd4GfPOUMw579iKqI8fMMXFYtnH6tSzhmfbQVmxwxC9Gosdlpw3NAs+lEQtiKO+0k3NmonNK3dsvswnavT+nfzx4Mc5QbIfhTR7GGzW2yrvAjukSk5qBhfioQUtx8to8qe/Xx5CXzrgB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHvFGoGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586AAC4CEF5;
	Wed, 19 Nov 2025 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577520;
	bh=HvQBiOaS5pNwDBn1SZfwxuH2i8dN0uHP5R2UidJ8f2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHvFGoGBQbpeh3Ni3x4IJx5DdnS2/e93jLB9D03/RIJXm/96BY2dqjfbMGk00/wn+
	 xILTablONNNvgBDYigt5TI84JTR6P7nw5p8qYYKUu2DcE4H6WUGLdYan6efnuedoPp
	 EMtWs2FM4lKHaoYzUXeD6j5fWqUQ0EP4Umo+K/UsPPdheYdqi/GZZOfHTWIaZy0wdY
	 I5YQtKgU7ktQ5PhthM0r8asw3i3hVp8l3zZmsLocrkoY1qMlr1JFZUEaj8/qXesVjA
	 6+ynL54GdF1AVYu50Y2LVwTIUSqoZXjOUwyVX1Kuc0XJXXlv9MSjugKI92ZOxlATm8
	 X5jNwrzhcajlw==
Date: Wed, 19 Nov 2025 18:38:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	cosmin.tanislav@analog.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: Add AD4134
Message-ID: <20251119-mandarin-amusement-70fe9914ecf8@spud>
References: <cover.1763478299.git.marcelo.schmitt@analog.com>
 <a8d891521ba8c9b4924ead29e5dba163b43d88ed.1763478299.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tZ/e2rX/dw+jzYoi"
Content-Disposition: inline
In-Reply-To: <a8d891521ba8c9b4924ead29e5dba163b43d88ed.1763478299.git.marcelo.schmitt@analog.com>


--tZ/e2rX/dw+jzYoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 02:32:22PM -0300, Marcelo Schmitt wrote:
> +  powerdown-gpios:
> +    description:
> +      Active low GPIO connected to the /PDN pin. Forces the device into full
> +      power-down mode when broght low. Pull this input to IOVDD for normal
> +      operation.

s/broght/brought/

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--tZ/e2rX/dw+jzYoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR4OqwAKCRB4tDGHoIJi
0tOTAP0XHgXpJtfu94jefXE8gIyVONQi6X1bq6MTbTE2RBh2BgEAzKvYVsdrdiRW
aZroxqroO9GpPwbaUHnG3vSKJFwf8wg=
=18KS
-----END PGP SIGNATURE-----

--tZ/e2rX/dw+jzYoi--

