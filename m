Return-Path: <linux-iio+bounces-8983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769696865D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A3EB22865
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D551D47A8;
	Mon,  2 Sep 2024 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD7c3M8W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7951D3184
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277245; cv=none; b=Ek84Lly/mG9eZ/JADjwCzyPi5rEWXzHEdOWrFgdhmESgS++Njo/X7gnjb9Po9fXI2u07OStPrrNZzKVj7YOyO7CTUYwA6ymvHuh96I5Mc+xOHy3+PIhp3rgqtM+iYckKnyFWWC9xONzejJvH+7jnLzY0nwwTILYk9dkjfzcMrsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277245; c=relaxed/simple;
	bh=gIZ1o1AFZtRRrlAxRkmOJMgxPIdIzxJ5VEoVwyHEs9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2LZ3VzWsED73T+p25gxJCpK8wokkNfEuBA9PGZ8a+edlmkvn6UcE6+J43USZwJOU4H76uUdyJAX4et+vwkDntSABfZ1ok2ThRfrFQ5vB3DZKqcLv60fLyWMncNkuKrJwuNgbLrdKt+yuxWb6Y2408iiXUv00s/ZWJzy+hTXSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD7c3M8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43447C4CEC2;
	Mon,  2 Sep 2024 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725277244;
	bh=gIZ1o1AFZtRRrlAxRkmOJMgxPIdIzxJ5VEoVwyHEs9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eD7c3M8WfH+/nkh6KCqaK2pGBQaAssyX7y/M6T46WZY6DKQnpakAVUFx6pGmp+CW/
	 ID+6szYCbQdWcgocXWOVLZXnk7BTcydAf7OT1WWlXG4ZSe0V9tE8+9j8VAdcfUwc6m
	 EZsjr+J/ZNnXM2wSVSueo+rZfXfBBMTKa4kV70zwDlUk1sekOJ0TVkMp2K+VCaI+I5
	 B6jSuQzOzc16H32rWUyNwWQxig4isniq0NMuj2j1qS2nLtAHZYOdIAJqcxdKPWhwa7
	 NXPhzXzIar9aq22TAvuc59Gr6atAvwxRqCOuxW7Ms0ahP6jZCT/wwUtx74T8P148cl
	 S5Il642nhZDHg==
Date: Mon, 2 Sep 2024 13:40:42 +0200
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
Subject: Re: [PATCH 12/15] iio: imu: st_lsm6dsx: use irq_get_trigger_type()
Message-ID: <ZtWkOqhh5IrhSY4s@lore-desk>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-13-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g45kckY3CTN3ogd/"
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-13-jic23@kernel.org>


--g45kckY3CTN3ogd/
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
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index ed0267929725..ca1a2c24d7ce 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2531,7 +2531,7 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_h=
w *hw)
>  	bool irq_active_low;
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

--g45kckY3CTN3ogd/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZtWkOQAKCRA6cBh0uS2t
rLp3AP98P8TUXZpmE6CiOnSmM87CdKMBE2n1KnlFgwXCabqjwwD+NFdHzt5Ahwjf
obaZva+aMucchaEuvffhLI9NaUYmmAg=
=NakW
-----END PGP SIGNATURE-----

--g45kckY3CTN3ogd/--

