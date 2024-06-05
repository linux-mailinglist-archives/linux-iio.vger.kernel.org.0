Return-Path: <linux-iio+bounces-5846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FDB8FD495
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDC28A8ED
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465D19538D;
	Wed,  5 Jun 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrMURcwu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C692194AF2;
	Wed,  5 Jun 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610354; cv=none; b=eL5m4d1qQLJOZdRlt+oKRa/06mjEV19YEQU5iDck9PnLmm/sibL2LbbIQdQyJSGZ8rlTKoefsw/yOW49o7lsuN9ByQsNnpQopwT96sQQwqVCOYsnl2GlzbV5aaMKUKJuxXigUjcEtaDWudcUscVXQsnaJAjsG95+b+5xO7agKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610354; c=relaxed/simple;
	bh=MlvNgVj4fQJhtJpvOR56OtZo/7RnNN+byUpDdksFa24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byC6b8hVL645YFPmGej6ueZkGI02LXui1Ihg20IHOwwU3YhG21s8QGfScZJXrUdphRXqjlXYV7S8KuofUw32I2VMGRTyIEIdAWeLETgI0FoHiPbTmUterX7GpMxX3GQHXJ9X442aO+jefF4fhPT7dMeXPSmi7cbMLzFbtJGCmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrMURcwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57BDC3277B;
	Wed,  5 Jun 2024 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610353;
	bh=MlvNgVj4fQJhtJpvOR56OtZo/7RnNN+byUpDdksFa24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrMURcwu+iYMslzyYa16PXakUEA+1hjvw+IpjhBqvYHdV1etn8CfWhdWdSXTZnyVI
	 0CVSLb1VRdzpy8mphwP7fcE6PaY1JtP3YDDPTtlQlsXH7gyGnL0hXb85squQVuvAJ/
	 PaZLxDedik4G0llqP84wacq8dCmUP3jecyXhqJQTf5Yie90k74+PhpJxp16wyrx5lU
	 szsWfcLYCQPympOTZl0VSY67OprOOLCRREKhYPmN34mdZ7+TzTBeXoHQNeSDnc9cwi
	 Bv9a0dmCGZpC9+4LWaDurnOmx6MwxVSPRRXqN4g1Tb4exFdVQ7Wr/5+Hn7K6CCUHX1
	 HRFJo0dzA6qcQ==
Date: Wed, 5 Jun 2024 18:59:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	p.zabel@pengutronix.de, sboyd@kernel.org, mturquette@baylibre.com,
	samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: sun50i-h616-ccu: Add GPADC
 clocks
Message-ID: <20240605-gotten-womanhood-bdf59e37baa3@spud>
References: <20240605172049.231108-1-macroalpha82@gmail.com>
 <20240605172049.231108-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LFx4I7HbdWhk8dXt"
Content-Disposition: inline
In-Reply-To: <20240605172049.231108-2-macroalpha82@gmail.com>


--LFx4I7HbdWhk8dXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 12:20:46PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add the required clock bindings for the GPADC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--LFx4I7HbdWhk8dXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCnbAAKCRB4tDGHoIJi
0kX8AP9j7Ujnh1M0SPJcvXm+HGXg7/2y7jZWMvjd91ECw9cDhwD+JqEK16ZzO2CX
qDyU1hXiBzYJ31hkTFPTQYa0KKQz6g0=
=iIUs
-----END PGP SIGNATURE-----

--LFx4I7HbdWhk8dXt--

