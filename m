Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD51AD87A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfIIMFw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387569AbfIIMFw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 08:05:52 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094AB2067B;
        Mon,  9 Sep 2019 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568030751;
        bh=fdigoUTffB/YcRLH0g6Rzk1AueXka0EMM5q4qfh48CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqp7l06NRosiKdNNsIgIfLDo148/sRoFsGYz7VpyhLdMIspX9IGGfffhoALCU02Tz
         d+TP0PyY1DGv++G1u3rmVb9lR4gMNXZK63p619/K2BzhjI+YpuWZaMaB0mg3MLkEFr
         33BPaNBBnAZ0WuJ6+Du28u2C89+5ebsDtX+OS1P0=
Date:   Mon, 9 Sep 2019 14:05:46 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190909120546.GE2990@localhost.localdomain>
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <20190909112846.55280-5-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Report iio motion events to iio subsystem
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v4:
>  * Updated bitmask as pr Jonathans comments
>=20
> Changes since v5:
>  * None
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>=20

[...]

>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
>  	return IRQ_WAKE_THREAD;
> @@ -1668,6 +1726,18 @@ static irqreturn_t st_lsm6dsx_handler_thread(int i=
rq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw =3D private;
>  	int count;
> +	int data, err;
> +
> +	if (hw->enable_event) {


Maybe I understood the issue between the buffered reading and event generat=
ion.
I guess it is a race here between when the device is generating the interru=
pt
and when you set enable_event. I think there are two solutions:
1- trivial one: always read wakeup_src_reg
2- set hw->enable_event as first instruction in st_lsm6dsx_write_event_conf=
ig()
and roll back in case of error.

Could you please try that changes and double check if you are still able to
trigger the issue?

Regards,
Lorenzo

> +		err =3D regmap_read(hw->regmap,
> +				  hw->settings->event_settings.wakeup_src_reg,
> +				  &data);
> +		if (err < 0)
> +			return IRQ_NONE;
> +
> +		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> +			st_lsm6dsx_report_motion_event(hw, data);
> +	}
> =20
>  	mutex_lock(&hw->fifo_lock);
>  	count =3D hw->settings->fifo_ops.read_fifo(hw);
> --=20
> 2.23.0
>=20

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXZAFwAKCRA6cBh0uS2t
rOiXAQC558sdMcTmFfXvCMFG4l2im3VbjqBLp6ymGEJi/KErHgD+OHLimq/96kGR
IjNHeUN1LyD7Oc8ToW0V0nc6cnhpHAE=
=Gofq
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
