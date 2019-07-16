Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F656A228
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfGPGPB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 02:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730485AbfGPGPB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 02:15:01 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8474621721;
        Tue, 16 Jul 2019 06:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563257700;
        bh=+sUNTqGTHNkGOygHfN5eLuuFsnEj4NGpt/mcoZyjJ8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGafdMIHZRhy1mtmC0LE/MIh1WGcRCkeGhyWirw+B8lDxozdJanCKNcg94OQTl4Li
         oXgJOPxIarz0TLCPKBAh2bhkMwUgSZ935H11w8GQlbqMWiN6DwikAipBmmdWMEdoij
         r1Enm3BzDfyoJFl5EK93QLkV414rfy4xH24J9Moo=
Date:   Tue, 16 Jul 2019 08:14:55 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH v2 5/6] iio: imu: st_lsm6dsx: always enter interrupt
 thread
Message-ID: <20190716061455.GE23126@localhost.localdomain>
References: <20190715081514.81129-1-sean@geanix.com>
 <20190715081514.81129-5-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <20190715081514.81129-5-sean@geanix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The interrupt source can come from multiple sources,
> fifo and wake interrupts.
> Enter interrupt thread to check which interrupt that has fired.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>=20
> Changes since v1:
>  * None
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index fc450eeb9870..0503abab6efc 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1215,19 +1215,19 @@ int st_lsm6dsx_event_setup(int id, struct st_lsm6=
dsx_hw *hw)
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
> -	count =3D st_lsm6dsx_read_fifo(hw);
> -	mutex_unlock(&hw->fifo_lock);
> +	if (hw->sip > 0) {

I think we do not need this if() statement since st_lsm6dsx_read_fifo will
return 0 in case

> +		mutex_lock(&hw->fifo_lock);
> +		count =3D st_lsm6dsx_read_fifo(hw);
> +		mutex_unlock(&hw->fifo_lock);
> +	}
> =20
>  	return !count ? IRQ_NONE : IRQ_HANDLED;
>  }
> --=20
> 2.22.0
>=20

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS1rXAAKCRA6cBh0uS2t
rP9DAPsFggeJzksVkObIKMUVK2Lb6LvDdS5NTeT+AyMk75mOxAD+KGDqdZaeh/Y1
FIhAYg6R/zjjPsOSe+/KnCOKJ5TG6wY=
=YqAr
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
