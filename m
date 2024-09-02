Return-Path: <linux-iio+bounces-9007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8566968913
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E2D2830CC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6A19C56F;
	Mon,  2 Sep 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pglp0dhu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC018028
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284536; cv=none; b=rwk6/o+ARNzK1JkA2ewE+WSeBvhA/70miINFUr7GhAG3MAcyCKq9TIBuWd7Z5n6YlCkTffk47g2cVttOGFcinKXYM03/xZOJ+DZNBWJ8EmbHis4GsaZUT9+6hFddg+KgznVD2AjskDC2+TmoJsSaZWr+18Zn3akrrbFonoK3atE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284536; c=relaxed/simple;
	bh=hRSEpuhAgj4ezTfArsrqwd1rHC48ecAdz9O/nGlIWSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqeXXl0Y9yyGYXENwdoLrVNziHUfYKzQr5aMUBXozpTj0VBVe5rq5JwMWxHnyi/6HWW2gn1OnDBVZOOv18j4V0dKOyE9l2NIPsMWWp0q0v3VYoG8649IwchlkAwe2tSuwJ1Q2qqETkhe22geUaOexMB9Dvv5QP5ovOijAp6nSKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pglp0dhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D545C4CEC2;
	Mon,  2 Sep 2024 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725284535;
	bh=hRSEpuhAgj4ezTfArsrqwd1rHC48ecAdz9O/nGlIWSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pglp0dhuxcJy1979ZgS5WiQT05cITgC7rFX3Ouir+2t3PR2u9fHLaTm3FxDSkEO1C
	 3vpfKPFWVfHzXpqyE78aGNIxdzwFT15E78LNd+J2GGwHKQuePwD5eYDINybAlAhntK
	 sLHFphbYmo6q+lBYhdKdJR6jpm4UuF7K+qW197dPdzjh4q8wR0uWfn9z5XmXri/wI5
	 sveULwXXrwQQWhiPtqgoMdDMgW7Eh+C8mWQ5Iz307lBX3tEzlyO7y4SBB97bXBMbGi
	 OmBL1OV/ycoY3dU2vp/1R3I/OLV+7ZiH7Se298VUpKM7qYOJBKN3G/bfWxIqo+upWQ
	 51n9DOhusjOKg==
Date: Mon, 2 Sep 2024 15:42:13 +0200
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
Subject: Re: [PATCH 07/15] iio: humidity: hts221: use irq_get_trigger_type()
Message-ID: <ZtXAtcj7PXWEJv7C@lore-desk>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-8-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F5WBqPhbbgbDusqw"
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-8-jic23@kernel.org>


--F5WBqPhbbgbDusqw
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
>  drivers/iio/humidity/hts221_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/=
hts221_buffer.c
> index 11ef38994a95..0272065cc44a 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -81,7 +81,7 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
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
>=20

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>

--F5WBqPhbbgbDusqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZtXAtAAKCRA6cBh0uS2t
rGD/AQCofVt7trGap6oYt56NXGWUZPZ56N0bMaKVMhxd7AfBVgD/SbX7rdLT/vYJ
s9fpKDTHxZlfYAFGDb4PtkqkUcCWGQM=
=fXVq
-----END PGP SIGNATURE-----

--F5WBqPhbbgbDusqw--

