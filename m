Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8C74BDCD
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jul 2023 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGHO0R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jul 2023 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHO0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jul 2023 10:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00236191
        for <linux-iio@vger.kernel.org>; Sat,  8 Jul 2023 07:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B2B60C22
        for <linux-iio@vger.kernel.org>; Sat,  8 Jul 2023 14:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B54FC433C7;
        Sat,  8 Jul 2023 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688826374;
        bh=DunqYoIpm1PZQ+tTkbVuGfSMZUrnG32eHHVFIvBwAZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pz949dAN2ZuB/yRNJbIyIymGQdduU+Wbwh0WovaoHkcu9BpPM33jWgVPYTc52C3N1
         RYqj6QkQF0sTwjuIsGQdqujyLew6ygZZ4Gb9jXBZ7GQKbOyJ3Bm+F9RWV9zMaJhh0n
         Tki8BbV1rgZi6QrUhCZUQZcmJk9M8iKPXP+sAuEqWZsClZ1z+DZe7Yde8qp5yT7Ky0
         3R1oiiP/lp5pz4ARA8CkdziEQIke7C6Cuv1tUm/WVhFHl0LKCm8CZ/5Z2Rli5fSQxG
         j/BWl9kuPMOnBehC5menVL0eFGwzGZ1X7jLwLGnWXndtpPbe46sjn0Ud7OGM2LmylG
         pTDTrEPcZD2+A==
Date:   Sat, 8 Jul 2023 15:26:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: read the full fifo when
 processing data
Message-ID: <20230708152609.1e3486c6@jic23-huawei>
In-Reply-To: <20230705155834.00000989@Huawei.com>
References: <20230623082924.283967-1-inv.git-commit@tdk.com>
        <FR3P281MB175727439E7D09F88E44C421CE29A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
        <20230705155834.00000989@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Jul 2023 15:58:34 +0800
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 3 Jul 2023 15:19:52 +0000
> Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
>=20
> > Hello Jonathan,
> >=20
> > any news about this patch?
> >=20
> > Thanks for your feedback, =20
>=20
> LGTM.  I'm traveling however, so I've just been marking stuff that
> is ready for queuing up in patchwork. Will send replies when I actually
> queue them.
>=20
> https://patchwork.kernel.org/project/linux-iio/list/
>=20
> See patches labeled 'queued' which I'm using for this purpose.
> Normally I'd just use applied and push the tree out the same
> day.
>=20
Back home. Applied to the togreg branch of iio.git.
However, as mid merge window that will only be exposed as testing for 0-day
to poke at until I can rebase on rc1.

Thanks,

Jonathan

> Jonathan
>=20
> > JB
> >=20
> >=20
> > From: INV Git Commit <INV.git-commit@tdk.com>
> > Sent: Friday, June 23, 2023 10:29
> > To: jic23@kernel.org <jic23@kernel.org>
> > Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux=
-iio@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.c=
om>
> > Subject: [PATCH] iio: imu: inv_mpu6050: read the full fifo when process=
ing data=20
> > =C2=A0
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > When processing data read the full fifo data in 1 time. If there
> > are several samples in the FIFO, it means we are experiencing
> > system delay. In this case, it is better to read all data with 1
> > bus access than to add additional latency by doing several ones.
> >=20
> > This requires to use a bigger buffer depending on chip FIFO size
> > and do an additional local data copy before sending. But the cost
> > is minimal and behavior is still better like this under system
> > heavy load.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > ---
> > =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |=C2=A0 3 +++
> > =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=C2=A0 |=C2=A0 4 ++--
> > =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 19 +++++++++++++----=
--
> > =C2=A03 files changed, 18 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c
> > index 13086b569b90..29f906c884bd 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -1345,6 +1345,9 @@ static int inv_check_and_setup_chip(struct inv_mp=
u6050_state *st)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->reg =3D hw_info[st=
->chip_type].reg;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(&st->chip_confi=
g, hw_info[st->chip_type].config,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sizeof(st->chip_config));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->data =3D devm_kzalloc(regmap_=
get_device(st->map), st->hw->fifo_size, GFP_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->data =3D=3D NULL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -ENOMEM;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* check chip self-ide=
ntification */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D regmap_read=
(st->map, INV_MPU6050_REG_WHOAMI, &regval);
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h
> > index a51d103a57ca..ed5a96e78df0 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -179,7 +179,7 @@ struct inv_mpu6050_hw {
> > =C2=A0 *=C2=A0 @magn_raw_to_gauss:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 coefficient to convert mag raw value to Gauss.
> > =C2=A0 *=C2=A0 @magn_orient:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 magnet=
ometer sensor chip orientation if available.
> > =C2=A0 *=C2=A0 @suspended_sensors:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sensors mask of sensors turned off for suspend
> > - *=C2=A0 @data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dma safe buffer used for bulk reads.
> > + *=C2=A0 @data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 read buffer used for bulk reads.
> > =C2=A0 */
> > =C2=A0struct inv_mpu6050_state {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock;
> > @@ -203,7 +203,7 @@ struct inv_mpu6050_state {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s32 magn_raw_to_gauss[=
3];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_mount_matri=
x magn_orient;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int suspended=
_sensors;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 data[INV_MPU6050_OUTPUT_DATA_S=
IZE] __aligned(IIO_DMA_MINALIGN);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data;
> > =C2=A0};
> > =C2=A0
> > =C2=A0/*register and associated bit definition*/
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c
> > index d83f61a99504..66d4ba088e70 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > @@ -52,6 +52,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 fifo_count;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 fifo_period;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 timestamp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 data[INV_MPU6050_OUTPUT_DATA_S=
IZE];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int int_status;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t i, nb;
> > =C2=A0
> > @@ -105,24 +106,30 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *=
p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto flush_fifo;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* compute and process all comple=
te datum */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* compute and process only all c=
omplete datum */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb =3D fifo_count / by=
tes_per_datum;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fifo_count =3D nb * bytes_per_dat=
um;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Each FIFO data cont=
ains all sensors, so same number for FIFO and sensor data */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fifo_period =3D NSEC_P=
ER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_sensors_timestamp_=
interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_sensors_timestamp_=
apply_odr(&st->timestamp, fifo_period, nb, 0);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* clear internal data buffer for=
 avoiding kernel data leak */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(data, 0, sizeof(data));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* read all data once and process=
 every samples */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D regmap_noinc_read(st->=
map, st->reg->fifo_r_w, st->data, fifo_count);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (result)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto flush_fifo;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nb; =
++i) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 result =3D regmap_noinc_read(st->map, st->reg->fifo_r_w,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->data, bytes_per_datum);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (result)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto flush_=
fifo;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* skip first samples if needed */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->skip_samples) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 st->skip_samples--;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 continue;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 memcpy(data, &st->data[i * bytes_per_datum], bytes_per_datu=
m);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 timestamp =3D inv_sensors_timestamp_pop(&st->ti=
mestamp);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 iio_push_to_buffers_with_timestamp(indio_dev, st->data, tim=
estamp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 iio_push_to_buffers_with_timestamp(indio_dev, data, timesta=
mp);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0end_session: =20
>=20

