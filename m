Return-Path: <linux-iio+bounces-24256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370BB8561D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 16:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AA177E1D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9430C0EB;
	Thu, 18 Sep 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAATNUa2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075E1A0711;
	Thu, 18 Sep 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207394; cv=none; b=LWZ+aYyKygw5PmBoxr+QBF2ZPiHI8qdGJV+lDzlNrKejeI9XeQyPUVldkP/Y55U6FPCfU0zkwoc/GDzFAQkjd3OFyo6VFY9KMqLZyB3Cgr33qETMSfNM/PmrnJtYzfx3Szu8h4Me1vIJ31vpuMoq02aCRz6GQU4yJhhONUfsb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207394; c=relaxed/simple;
	bh=9A3Zwtl5Gjog2hEmrIHEtNxqtc+8JhKSvYW/b141A+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMNCrfzGQ+oN3A4+D9IzzSlfvhXCcoQmylDmeQMplVGB+72PYl2w+9pVw/Q/baxuJWVJ/Dxnkc7Wz+ywyHKaZQPkpO00YfCHj8zGWkOfvTm9IBunPNrAmXgycfk18r6cusiElhzR0i3xeMQcBBwfiuwEBalE/SsErsE9/2F3bvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAATNUa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A99C4CEE7;
	Thu, 18 Sep 2025 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207393;
	bh=9A3Zwtl5Gjog2hEmrIHEtNxqtc+8JhKSvYW/b141A+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAATNUa2SMfq/Nqqbsq9mMU/u0MR3Itm7UsokrqwtRgIHQdpSI0LlnhhulZKTAW97
	 07jzawnfxg2F9wVKucMpWLa5PWtJ5hBfNNf6ZlYyDHP6KmBD4+R/XyCP1yOELZydIR
	 5T8Mvbio8l11mPbK+XZXIJUBCjUXAByvVQLqmKaw+w9C6j3xoIu++FRTeOMY/QuZ3G
	 sFNROo3iMhFBVy4fS+2Dm9UuYzQn3gfmt9xjqw4A7YlEl6tbD5YuwWxRMN/ErfdBCq
	 6k7ENiSrPGBS/DqEThZEmbNNPT4a2UrTDkuCWmoPDZ5bEkGHSokcRTQJKtxsviu8MP
	 VvX5ZqWHiRgZQ==
Date: Thu, 18 Sep 2025 15:56:28 +0100
From: Conor Dooley <conor@kernel.org>
To: victor.duicu@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	marius.cristea@microchip.com
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250918-utility-utopia-c5c1da0e2969@spud>
References: <20250918111937.5150-1-victor.duicu@microchip.com>
 <20250918111937.5150-2-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxQLi/SDkGHxja8c"
Content-Disposition: inline
In-Reply-To: <20250918111937.5150-2-victor.duicu@microchip.com>


--vxQLi/SDkGHxja8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 02:19:36PM +0300, victor.duicu@microchip.com wrote:
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: '^.+d$'

ngl, I think this is being too clever for it's own good. Just list em
out please. Otherwise
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--vxQLi/SDkGHxja8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwdnAAKCRB4tDGHoIJi
0tgOAP0QBmAzRfTgMw7aHR0pYUGXJJAJpL8o+ObBSLAUFz9RDAEAumU/mkiMEr/z
dtIVXtZ8bY486PsOq9Gds4nVt2Fxjgo=
=bn6P
-----END PGP SIGNATURE-----

--vxQLi/SDkGHxja8c--

