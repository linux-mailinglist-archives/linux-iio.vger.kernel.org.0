Return-Path: <linux-iio+bounces-16205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE9A4A24C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 19:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717313B92A0
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD61AF0C0;
	Fri, 28 Feb 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzRFEN4q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F5277001;
	Fri, 28 Feb 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769191; cv=none; b=FUywNRPGm6yuu0zZaIm9d1Zsjm/gJlqbDHbrBVOskKcr/bfc4Mc11Fx8FY/kcow5brKG5QVeTSr9WwgE/nN3RLURzzZvDd5ARvvy2FSpwEo9CMDJQA5zFb2fOyh9c+M9qcWDGFkUQxYpqxoY1NGXAPNNjKatq7IZFJOOoqx3ZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769191; c=relaxed/simple;
	bh=V8TO8kJvdzGkByRvxotHz25r5Pr/JTfV5defoqrC03M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIABIv7YHEY6ZAcCPO0fMDEFKHv6Uu9eTObPmRJPhqGJIktyn+tYOgfqmob65Cy4d6enGbbAvBhRiS+WJZEQZJsHP3TmGzuqo0I4i6CCmooQ0wJFidu3E7fObBSl0F2bskWLeek7XslqWS98IL2HxLr8P3ZthQ1AWNkLfy5Yicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzRFEN4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2974DC4CED6;
	Fri, 28 Feb 2025 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769190;
	bh=V8TO8kJvdzGkByRvxotHz25r5Pr/JTfV5defoqrC03M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzRFEN4qoxk+OLKPqEaSZXjz+7JVBrDji4+ZrJPCMWsW8323Hn4LbuD2m+yEuR7+4
	 maZFJwcxu7jV+6oej+cMIitQ680qOQwSHT4rrwgkqomV6MCqmAZm/iFatUI3w6kde4
	 J7wGZDfymze/KiIfd7WC4CVZkTyFfkvYTFBqdhzVgFrw+4kJS/Kxv6nmLcygwu9oCX
	 U4Nog4yAXjNwtnEyfyTXJyzgsxSM856n6/BK48Cs3Oq5k+fQ6ODD3IMw1pS1SBdgJa
	 kddQ8nV9wQML3po67NFktAuRVEUShPZN5fCnUKS/tF2IaTv9L2fvbR876luHf+wj2P
	 PPdoKbjA3owIg==
Date: Fri, 28 Feb 2025 18:59:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: Add rockchip,rk3528-saradc
 variant
Message-ID: <20250228-aging-catty-3e09df499f0b@spud>
References: <20250227184058.2964204-1-jonas@kwiboo.se>
 <20250227184058.2964204-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kcYt+SH3XA+Svxpf"
Content-Disposition: inline
In-Reply-To: <20250227184058.2964204-2-jonas@kwiboo.se>


--kcYt+SH3XA+Svxpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--kcYt+SH3XA+Svxpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IHoQAKCRB4tDGHoIJi
0v55AP4uv6g/zpHbFmNUhaEZ83d6AZyP0AVS/FuShq/Vo/xOagD+JRT1vizD6zSK
x680FeC4UCRNAlWGNnW/x+bSs2jqCgs=
=5SMi
-----END PGP SIGNATURE-----

--kcYt+SH3XA+Svxpf--

