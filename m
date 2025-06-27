Return-Path: <linux-iio+bounces-20997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61184AEBC91
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A1B6A32C5
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA42E9EBC;
	Fri, 27 Jun 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2PIXGHE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3923208;
	Fri, 27 Jun 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039609; cv=none; b=sqsOTvSCkRx3rygkZfLjAVnrgoxoh5Dw7UzpGyIU3wNTu7yiZRIyg57qEOiDM9dvQTge5tbONCf17wPRaZHv3ZqVwaK+6h1a5uqz/xkmooQakH3Udups5/sMkPqetzqmC79vqvGlGp/z8NQTDJgwlbbkb7Wx6YdH4BM01WbZcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039609; c=relaxed/simple;
	bh=9jvEQ9I22Mhlsd+LxJZ4oHjg0gKuzAh0ToNhXaQgrpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs8SMHqW1JfQedE9v25vzcupc9uqn5kDzOpTWx5+qpRXa1gzuudgDNqenR6yHC8lxMsAgK5ug+1x6ZM75vyhXqPB6F6qM4+P7UWQW7zvwZfiD7xmMmxu3mr4l2DTbWYU4Q6suYzHDxHSavQOh/0XXC/fgr0APjHjyhVr5hBO2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2PIXGHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE1C4CEE3;
	Fri, 27 Jun 2025 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751039608;
	bh=9jvEQ9I22Mhlsd+LxJZ4oHjg0gKuzAh0ToNhXaQgrpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2PIXGHE/PIjk2eDAc/MPl8v1olroLzQzQ5N7Art4TKnw7Y/JDV72yh7d0qcKcw68
	 UgsFSysnsboCT9wr1010yB4dmIynxsWaFSikE8rw/5BA3TrdS65ZE7l0jl04EHuxJO
	 2GOT0nxqJhDmMIfHSo1N85/YEBBp/65e0trzeq5sDbiHY9XdRsxb8luQ1FAheRPJ2a
	 hoiN65nrtqvpEbPAKYVmeSQ+yTebSXYVUW7LUMnTvTb2/sHiVg211ij6N8SE36fNXI
	 QeORosy2Y636/Sh0a/w8EKPuG1e4RJ7jDT/+Ba/yidThRoXlHNSDexIuKlZAuYJLEy
	 RneUfat3/2WBQ==
Date: Fri, 27 Jun 2025 16:53:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, robh@kernel.org, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] dt-bindings: iio: adc: st,spear600-adc: txt to yaml
 format conversion.
Message-ID: <20250627-rage-oat-14141026cf28@spud>
References: <20250526-overtake-charger-6c5ffcc2bc09@spud>
 <20250626205733.6354-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0y+6vaV681sTCfCv"
Content-Disposition: inline
In-Reply-To: <20250626205733.6354-1-rodrigo.gobbi.7@gmail.com>


--0y+6vaV681sTCfCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 05:54:01PM -0300, Rodrigo Gobbi wrote:
> Hi, all,
>=20
> Just a gentle ping here since it was already been reviewed.
> If there is any other concerns, let me know.
> Tks and regards.

This is all I see here, a ping with no context is not very
helpful. I have to go look it up on lore to see who reviewed it
etc. In this case the reviewer in question is me, so you're looking for
Jonathan to apply it.

--0y+6vaV681sTCfCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaF6+cwAKCRB4tDGHoIJi
0sEuAP0XXkr/zdyXCCujaPGWlfN2pKqB7teOqvhq2sk+UHO9tQD+MpTvyNNFmJ8p
o2nW19m3IMiJ8OyL3Yss+7hndGZA+AQ=
=qBDa
-----END PGP SIGNATURE-----

--0y+6vaV681sTCfCv--

