Return-Path: <linux-iio+bounces-2691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E73858A40
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 00:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740FB1C22A44
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BCA1487FB;
	Fri, 16 Feb 2024 23:41:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099F1482EE
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126865; cv=none; b=USuwZHbQQ9OBZbQr6byG9VSKuYszACyHp01ZunbmLDnqDIQ6A7xUt69HbKU4mSFb1YzJVYyX3IHKZFldQXNt27nigL6baPc2a6Aypzrcc9ogpIQkGhNDhsSUlhM4s57wambKysiYlWJMaTzKw/ZZihm6VAdTuX3qfsjtNlwbeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126865; c=relaxed/simple;
	bh=L/DwlmUu4QhvfAqVBD7lJ8DPNfvdYhQ2H1zcVh5tcbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWviqJW+8F8aDojVD+hFxxT5nZVRphYlPuFORm9AXMPZYs4ctBylLdY30IN5I/de/xo/zTZfSyMrTlDrlJ5615HeO75orl0jJprQXh+fNzXUI0C0uZ4v4ffNephMYZZAJDvqw2332iHj33ZMj49g1GXZQmBKWemRK8ojQhHQWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D04AC433C7;
	Fri, 16 Feb 2024 23:41:04 +0000 (UTC)
Date: Fri, 16 Feb 2024 18:41:02 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] counter: fix privdata alignment
Message-ID: <Zc_yjo0A3KO0EoU0@ishi>
References: <20240209-counter-align-fix-v2-1-5777ea0a2722@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J46OH5VjARc2dVzB"
Content-Disposition: inline
In-Reply-To: <20240209-counter-align-fix-v2-1-5777ea0a2722@analog.com>


--J46OH5VjARc2dVzB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 04:50:34PM +0100, Nuno Sa wrote:
> Aligning to the L1 cache does not guarantee the same alignment as
> kmallocing an object [1]. Furthermore, in some platforms, that
> alignment is not sufficient for DMA safety (in case someone wants
> to have a DMA safe buffer in privdata) [2].
>=20
> Sometime ago, we had the same fixes in IIO.
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/base/devres.c#n35
> [2]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kern=
el.org/
>=20
> Fixes: c18e2760308e ("counter: Provide alternative counter registration f=
unctions")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Applied as commit b6dce0452a02, thanks!

William Breathitt Gray

--J46OH5VjARc2dVzB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZc/yjgAKCRC1SFbKvhIj
K5u1AQCljJl+XRruP0qoI63Yjx0y0wDN1yIuIocH4WQ9O+QrTAD9FhJwyhmWsNxv
PAjD9z+Vg1r7nBY+Hs0ksjTGyTP/igM=
=jkqq
-----END PGP SIGNATURE-----

--J46OH5VjARc2dVzB--

