Return-Path: <linux-iio+bounces-2322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A090184E7C0
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 19:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549AC1F2C600
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD68C1A;
	Thu,  8 Feb 2024 18:34:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED292EEDA
	for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417293; cv=none; b=Ul87fQ5eO6BKh195lTcFiGNNrWttzfSBkwTd0mDbSTUoKRGdJr7x0yEJGmyVDj5Z8vPMUKvWIEbCIxtcu4VUoN4QvTR5XaI9gSXAC08GE6dhvxaKepoFJLVcXR2iUZMz1KqCRBvV9gsamx/fhJb0GsBl36tnukNZL3dLfwCxIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417293; c=relaxed/simple;
	bh=1aRmuWlF2QDle0A+ZSnE59oYD9kL4AGO1glUmPyKhsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6yaxMjaNFfaqSq7cM7jrD1MeCoqc66Dy5Xh2ETx9NgG1n1wrMUd11Ru00/0yiJR5a8t/DohPArOxui0mmjEE6ublhK9x+G3OvEjdFaepkfTLDpqGro5p8Ckd3IEVIy9b0DG8a2o4h9qFkYfmmH2PTNWC8Tzisu69d/YMyowR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44840C433F1;
	Thu,  8 Feb 2024 18:34:51 +0000 (UTC)
Date: Thu, 8 Feb 2024 13:34:48 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] counter: fix privdata alignment
Message-ID: <ZcUeyN8OF49CGqij@ishi>
References: <20240205-counter-align-fix-v1-1-4821ced960ab@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfpFMh5fMMg+vb7Q"
Content-Disposition: inline
In-Reply-To: <20240205-counter-align-fix-v1-1-4821ced960ab@analog.com>


--vfpFMh5fMMg+vb7Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 04:58:14PM +0100, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
>=20
> Aligning to the L1 cache does guarantee the same alignment as kmallocing
> an object [1]. Furthermore, in some platforms, that alignment is not
> sufficient for DMA safety (in case someone wants to have a DMA safe
> buffer in privdata) [2].
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
> ---
> William, if you prefer, we can do something like in IIO and add a
> specific COUNTER_DMA_MINALIGN define
> ---
>  drivers/counter/counter-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 09c77afb33ca..073bf6b67a57 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -34,7 +34,7 @@ struct counter_device_allochelper {
>  	 * This is cache line aligned to ensure private data behaves like if it
>  	 * were kmalloced separately.
>  	 */
> -	unsigned long privdata[] ____cacheline_aligned;
> +	unsigned long privdata[] __aligned(ARCH_DMA_MINALIGN);
>  };
> =20
>  static void counter_device_release(struct device *dev)
>=20
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240205-counter-align-fix-3faebfb572af
> --
>=20
> Thanks!
> - Nuno S=E1

Hi Nunon,

This change sounds reasonable, but should the comment block above
privdata be updated to reflect the change?

Sincerely,

William Breathitt Gray

--vfpFMh5fMMg+vb7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZcUeyAAKCRC1SFbKvhIj
K2uKAQCtAQlKVVfSHYytz3yPKmn8UlTAb1PnEFurWgETKgOudgEAk2eZ7juK/pFK
NVX8354QmhdURuqLfYQzkyPvv7KYxw0=
=NICx
-----END PGP SIGNATURE-----

--vfpFMh5fMMg+vb7Q--

