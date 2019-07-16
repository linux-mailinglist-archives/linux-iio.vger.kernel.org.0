Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532246A1FC
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 07:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfGPF5G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 01:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfGPF5G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 01:57:06 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FD5206C2;
        Tue, 16 Jul 2019 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563256625;
        bh=D5P/0cciCBLLV8edkfbmxH9MXlUtVXXP55OjXzJVHXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3uhJ9L+FqigzOrKND681vJ5hhwiArpJJVbv3JgWanLAUTMXeYhU786ksPC7sYjk/
         ygfQStGSXv61FWU+/ntaWF0FrRhG33+jXNJ/+vsoMo58z4WlYUAaiedC9ThdtDs2gr
         NoNgqVytqN06tAz2kuU76xZe991kuyT/W9Fa+nUw=
Date:   Tue, 16 Jul 2019 07:57:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH v2 1/6] iio: imu: st_lsm6dsx: move interrupt thread to
 core
Message-ID: <20190716055700.GC23126@localhost.localdomain>
References: <20190715081514.81129-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20190715081514.81129-1-sean@geanix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This prepares the interrupt to be used for other stuff than
> fifo reading + event readings.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>=20
> Changes since v1:
>  * none
>=20
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 78 +----------------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 87 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 77 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 38194f4d2b7e..2b938d87ae34 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c

[...]

>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> @@ -1117,6 +1201,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, i=
nt hw_id,
>  	}
> =20
>  	if (hw->irq > 0) {
> +		err =3D st_lsm6dsx_irq_setup(hw);
> +		if (err < 0)
> +			return err;

Could you please put a 'newline' here?

>  		err =3D st_lsm6dsx_fifo_setup(hw);
>  		if (err < 0)
>  			return err;
> --=20
> 2.22.0
>=20

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS1nKQAKCRA6cBh0uS2t
rELwAP40VSCSQfc7ut8jlG7RfyA2jajFcho4yJa8vvcRcvX3AAEAxPh6DxGvxMZs
jyKWh4OK8k7AJ5EX0h21Zi9lMsGmzAs=
=7afI
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
