Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCC270FAA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgISQzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 12:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgISQzz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 12:55:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25ED320771;
        Sat, 19 Sep 2020 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600534554;
        bh=hPD5nmTleUNdciCgatfyNbWWU75jVeYYqg29NwTcazw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HMkaXbfrupGFKZIzqmFHzRJCFK1ZjXyPVCYskb46NfG5Xit0JpiThN2YgVohUN9EC
         XJQjmMofa9pQ2qaJovyemBjVC6OnMzACKiMmhWMkjN071fcAp/theqOSyK0D5Kk9en
         FkFIn91G7U4FthUxJjP5oVg10ojZmm1HVm2sI3xw=
Date:   Sat, 19 Sep 2020 17:55:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for
 fifo reads.
Message-ID: <20200919175549.79923ac9@archlinux>
In-Reply-To: <MN2PR12MB43905A2256F98BB5EFCE7DD3C4770@MN2PR12MB4390.namprd12.prod.outlook.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-19-jic23@kernel.org>
        <MN2PR12MB43905A2256F98BB5EFCE7DD3C4770@MN2PR12MB4390.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Jul 2020 08:29:56 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> perfect.
>=20
> Thanks for the fix,
> JB
>=20
> Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>=20
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Jonathan Cameron <jic23@kernel.org>
> Sent: Wednesday, July 22, 2020 17:50
> To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Lars-Peter Clausen <lars=
@metafoo.de>; Peter Meerwald <pmeerw@pmeerw.net>; Jonathan Cameron <Jonatha=
n.Cameron@huawei.com>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Subject: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for =
fifo reads.=20
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> We should not be assuming that we are reading a sequence of
> registers as here we are doing a read of a lot of data from
> a single register address.
>=20
> Suggested-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the togreg branch of iio.git.  I've explicitly added that
this one isn't marked for stable as it doesn't actually have
any affect beyond being semantically correct.

thanks,

Jonathan

> ---
> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c
> index d8e6b88ddffc..45c37525c2f1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -179,8 +179,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb =3D fifo_count / byte=
s_per_datum;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_mpu6050_update_perio=
d(st, pf->timestamp, nb);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nb; ++=
i) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 result =3D regmap_bulk_read(st->map, st->reg->fifo_r_w,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 st->data, bytes_per_datum);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 result =3D regmap_noinc_read(st->map, st->reg->fifo_r_w,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->data, bytes_per_datum);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (result)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to flush_fifo;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* skip first samples if needed */

