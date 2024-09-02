Return-Path: <linux-iio+bounces-9008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8535F968914
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10C51C20D6D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356620124A;
	Mon,  2 Sep 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyVekpqI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F113E02B
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284550; cv=none; b=oB5R7lBTJahIKI17tMh0ZQVgbH349KpeirHac2ZsyP7SIperAk2Se3cM42InbRnfVfhddWMxOkfgNb2y0Se5cw3s/m9chAyWpeATy41ZcMPCYkNZYyc/NR+MFrI16YOzgw0XijDbb0Sn3zK3AtcR6XnVE/bypYUkwW0w34zEGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284550; c=relaxed/simple;
	bh=hTs1PU9EZtlDTa/CVIJstcdEmKFwSnUgPAon3CWhyr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opUR//cG8Kx38ECpkEPY4hY3IMNu5HeK1/4sDDwMEBXuRCZOIT5FcpD5M0LqL3hwZ251tLQ2Y/adJdhBOKE7bD1fa+fswlFBZ8+ulhu3XWd/eVQhsZCTABZH+fDsC/rpbagqG/rTt0+oSoaZjMntXxA8GSZv1478eiWIsHoR8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyVekpqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69300C4CEC2;
	Mon,  2 Sep 2024 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725284549;
	bh=hTs1PU9EZtlDTa/CVIJstcdEmKFwSnUgPAon3CWhyr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyVekpqIKGdsCBjl6zaVX0+FiuDYxw57a25BMo0SUqwQiW2994BH11qEwi+W/X1uh
	 xHupDMwG853eOII7jZjq0sWWYKfbmV1oAYvuXNJKP1FpdZxsH5GwZ0zjvp2DniYGr+
	 PXRdZfQh92IiFquDcLmq5sDk5pIldwIEQRzCBZ1ltTbpoqq97nDyc/BqN2GZkEUHZp
	 eh6fnDunTuqsT2fGKbJ6mH8Bcx3us+BinnBUb38JXTHYohw0p0NQKL0usgqXsDjAXe
	 ReNEtJWePQOVgcfA+2hr5PnXVmeW7Hp8KpQ2VmJE+9Da0hJQU+PNvLvzZqZ2dX1wJX
	 OyC4MYxcS3OFw==
Date: Mon, 2 Sep 2024 15:42:27 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/15] iio: light: st_uvis25: use irq_get_trigger_type()
Message-ID: <ZtXAw-n6tlb49lTg@lore-desk>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-14-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lMf2ctlMj2SAIbNx"
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-14-jic23@kernel.org>


--lMf2ctlMj2SAIbNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 01, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/light/st_uvis25_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uv=
is25_core.c
> index fba3997574bb..4a58591c3bea 100644
> --- a/drivers/iio/light/st_uvis25_core.c
> +++ b/drivers/iio/light/st_uvis25_core.c
> @@ -174,7 +174,7 @@ static int st_uvis25_allocate_trigger(struct iio_dev =
*iio_dev)
>  	unsigned long irq_type;
>  	int err;
> =20
> -	irq_type =3D irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> +	irq_type =3D irq_get_trigger_type(hw->irq);
> =20
>  	switch (irq_type) {
>  	case IRQF_TRIGGER_HIGH:
> --=20
> 2.46.0
>=20

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>

--lMf2ctlMj2SAIbNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZtXAwgAKCRA6cBh0uS2t
rHbSAQDU+a2cFFB+B8yqp0PrsY6DNV2iVR+EZHeQVllg/7qYHQEAwB9GtGkJiHiz
odxm1kuRiydcr8g9nh1Bp+4+Bqj55Ag=
=FiBr
-----END PGP SIGNATURE-----

--lMf2ctlMj2SAIbNx--

