Return-Path: <linux-iio+bounces-24601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B1BAE5D5
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11C424E287F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098626CE2F;
	Tue, 30 Sep 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSk6mHgj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6B185B67;
	Tue, 30 Sep 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258426; cv=none; b=MLrXEAgGtpI88ZXfU9GTHgDZKN0WvZ5qo8yxRR7jtiHPRQc6tG0AP84X2xbyBDYH2OJVPFBcH5JXyt265z8RT5tNXnXwLT7FOfO3RVW1ozQ/pdqhLMP9Maa0D9OkXlDXGJ8fUR4i3vUAOWYVSGlolUpWN3cTP/tnsSujC4m13d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258426; c=relaxed/simple;
	bh=drTo33egfm5GQgaUudBqBZy/rkzWjAc416PTsApORdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1MspTq/BoaxchkZiyJIiJ5AuPolrk/+C3+KEmnx2GP5fm9NuAaUEzMsAeW/GVaAqmnnRlPKr/0OgfzVEpYqFZClObFl7M/njUO6ukeJZj7pDvMA3In7JB+qekvuxdsu1RASnMHbGfPUdCiciYNhfrTG0Lj6EM0TY0q1NM3e0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSk6mHgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077A7C4CEF0;
	Tue, 30 Sep 2025 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759258425;
	bh=drTo33egfm5GQgaUudBqBZy/rkzWjAc416PTsApORdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSk6mHgjGNgl8amItTB3Jzmh5prCSylwHe70E6I6b+KT/56c2tJ/JSOBdkmPVCFvF
	 gFPeXrVlA2lKvIY8UHuonY+tZjbpTcrCi5xDuZjjjhnAu6z9WhHC3M4fCoRzgEahX4
	 ju+CtyJb3fIU1aM+XCQyMDGMieYoBG8RPCDfXQQjPQoan33FYGALGdaxSUa7Qx4JWC
	 qqqzUQ6jF1i3v0B+OBj0NR1AtdYQnUYWYecP6kAvwhaHB7ayil4CiyO0kHW3p5yaRh
	 Er73CLPNOvn9uGGikOMCYIGQpSG4M8DgWa9SSim9LpctpCvoIclQbHBmam4gTxQjT8
	 1arnbt3GBIrXw==
Date: Tue, 30 Sep 2025 19:53:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: iio: adc: adi,ad4080: add support
 for AD4084
Message-ID: <20250930-dyslexia-favorite-4d2e5de5ee8e@spud>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
 <20250930103229.28696-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="meIxlFm1Llwmmx66"
Content-Disposition: inline
In-Reply-To: <20250930103229.28696-3-antoniu.miclaus@analog.com>


--meIxlFm1Llwmmx66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--meIxlFm1Llwmmx66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwnNQAKCRB4tDGHoIJi
0kwSAQCsD4ZOtiE45jzKkl5ch3BUubUR8MbEW/JtyhMBAKlUtwD+LxEqMS0OFSJj
R05ugugE4oQyd5y0Q6rPDLZZtk/KBwc=
=QldZ
-----END PGP SIGNATURE-----

--meIxlFm1Llwmmx66--

