Return-Path: <linux-iio+bounces-25894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF49C32727
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 18:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 744F24E596E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E8337BA4;
	Tue,  4 Nov 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnTKPisQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457A32AAD3;
	Tue,  4 Nov 2025 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278690; cv=none; b=TuUGKygbRdLErAKBjaJ2cVO6nNfEmcUoNAJPyVzWNKE5Z3xrh5N5alHynRDwWHrLwA3iCiMctfBLWPzbzvm4KXnEBC70gJgSfEvQWtZdjrBagArFQReit8wD8DN/pPwYgoMNnpZjoTiWqUOyxbZhSXXn0O1J1mDH5WVRQnDUfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278690; c=relaxed/simple;
	bh=pzBl7iZ91Vkn2SNmLv9/NYadQVe55zk1C8rWcdyTcB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L44EtUBtzvDtfuCJJuOz929P3XrZo7mHnRZIYfBk84EgEKe/Io2t7EasHeL+IUpc88Fk7dL/eMg4oZFznM+1/HjLjK4ZoGN90LARrlsnFfcKHzt+r+3sSuFvg/rXGOo5gEoKi8HaAXYHGTPWgV/6DrESW4fSDZWZ0sCw2EL2GXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnTKPisQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C10C4CEF8;
	Tue,  4 Nov 2025 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762278689;
	bh=pzBl7iZ91Vkn2SNmLv9/NYadQVe55zk1C8rWcdyTcB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnTKPisQtvIXIzN8Wc/4qz6G+U1FAGHGeUWJ+iNfI88O0pD9ECVcgoedfcn9G2JqC
	 +z91XSHN3qwGbJq5G2IWZqXdIsvxSOa/9JcAFpUEXqJ3/4yiDqwlz3Nhfwy3FkDnxV
	 IMLv713UJxlhEdLpeP2VG5tDLxFI3lpMF9nFmwVZsoTWR1H7jwn9Zh2YWsL3RFKPDo
	 NORr/2fFnIEdq+UHv3ZRVJj8BPSfjBUz3NH9ZF/PzmBCCRnrfS/5Kb17nvR9LSTvxW
	 HfsqGVWKcpHGmNExa3CwzI9kPPyb04thXt/0l+8L3kgIII4/hhVulP/Xah1xwh72xq
	 Oo6jSS0M81O+Q==
Date: Tue, 4 Nov 2025 17:51:25 +0000
From: Conor Dooley <conor@kernel.org>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 6/7] dt-bindings: clock: rockchip: Add RK3506 clock
 and reset unit
Message-ID: <20251104-mutt-spleen-31e1569f1674@spud>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XwEcfcP8fWBdW6sU"
Content-Disposition: inline
In-Reply-To: <20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com>


--XwEcfcP8fWBdW6sU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--XwEcfcP8fWBdW6sU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo9HQAKCRB4tDGHoIJi
0uaGAQC70hgTvw58pbDLBEgpxS4nv6VOjgX0/hvlSXn51hnNxQEA0RfzwEX7fvDS
nSJp006hB3JEGBvJVIUugAZGLO6lZQ4=
=vHNi
-----END PGP SIGNATURE-----

--XwEcfcP8fWBdW6sU--

