Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1DA9ABA
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 08:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfIEGes (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 02:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfIEGes (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 02:34:48 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E652168B;
        Thu,  5 Sep 2019 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567665287;
        bh=GzK6PrAVscyJU1Tjk+D75j4Pg1myyim0v28cBh8g8yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2I7xTMXlFrzTzOj9nZwROuIHeUKF20hc9LTz59vKLfbwNcqGCb8ZxqZVWLb6Npvy
         EZMptAcIHSd+6Ca/I19ZxRZH0GnTvNiYOplg2A+6rJkXPB6gIlwqf44E6gVyuOvvKH
         joe47nN/WTHVSwRkD/hVX1s/VrxW4gbCGm9zUs4Y=
Date:   Thu, 5 Sep 2019 08:34:41 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v3 4/6] iio: imu: st_lsm6dsx: always enter interrupt
 thread
Message-ID: <20190905063441.GA31578@localhost.localdomain>
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-4-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20190904091732.112281-4-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The interrupt source can come from multiple sources,
> fifo and wake interrupts.
> Enter interrupt thread to check which interrupt that has fired.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  * None
>=20
> Changes since v2:
>  * None
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index bb72800bf99b..513506caa460 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1613,19 +1613,19 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(st=
ruct st_lsm6dsx_hw *hw,
> =20
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
> -	struct st_lsm6dsx_hw *hw =3D private;
> -
> -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> +	return IRQ_WAKE_THREAD;
>  }
> =20
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw =3D private;
> -	int count;
> +	int count =3D 0;
> =20
> -	mutex_lock(&hw->fifo_lock);
> -	count =3D hw->settings->fifo_ops.read_fifo(hw);
> -	mutex_unlock(&hw->fifo_lock);
> +	if (hw->sip > 0) {
> +		mutex_lock(&hw->fifo_lock);
> +		count =3D st_lsm6dsx_read_fifo(hw);
> +		mutex_unlock(&hw->fifo_lock);

This chunck is unnecessary since read_fifo() will check number of available
samples in the FIFO and moreover it is obviously broken since you are runni=
ng
st_lsm6dsx_read_fifo directly instead of using fifo_ops pointer.

> +	}
> =20
>  	return count ? IRQ_HANDLED : IRQ_NONE;
>  }
> --=20
> 2.23.0
>=20

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXCsfgAKCRA6cBh0uS2t
rOoRAQCdIdtZ4OT1MABCODFQJbUXhLg/kfP9T937AhWtspvTkgEAvsGMTf5fvSw8
5h7qU9fyzOi/exDb3fnO9yKiw3Q8SQc=
=91LW
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
