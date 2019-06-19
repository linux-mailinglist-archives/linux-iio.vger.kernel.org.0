Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7C4B1C1
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 07:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfFSF7D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 01:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfFSF7D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Jun 2019 01:59:03 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E4D208CB;
        Wed, 19 Jun 2019 05:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560923941;
        bh=6D6lKyhZa60JyW4nerW4VGLW8M/QlNqi1R8RzXpOp2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSFR7YNXyRKYnOgdcxE7lh71bx5VXf5wkw8cBMmUZMC55VbxryeQe0NyLIwbJB1Cv
         U2+sDEYanUNooVeen/canPZN1CrX6btZXwlQlEpxzCFyEW3K9UyFdTg+OmJlovdyAh
         vbCV95k1AkDP/Dh0wOG/5Kj+KGOGk3XwKKHIrowI=
Date:   Wed, 19 Jun 2019 07:58:54 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH 1/5] iio: imu: st_lsm6dsx: move interrupt thread to core
Message-ID: <20190619055853.GA4035@localhost.localdomain>
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-2-sean@geanix.com>
 <20190618155705.GA22268@localhost.localdomain>
 <EE6D853C-BA54-45B5-9912-A1C89F78CC32@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <EE6D853C-BA54-45B5-9912-A1C89F78CC32@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 18 Jun 2019, at 17.57, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> >> This prepares the interrupt to be used for other stuff than
> >> fifo reading -> event readings.
> >>=20
> >> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >> ---
> >> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  1 +
> >> .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 80 +----------------
> >> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 87 +++++++++++++++++++
> >> 3 files changed, 90 insertions(+), 78 deletions(-)
> >>=20
> >=20
> > I can't see why we need this patch
> >=20
> > Regards,
> > Lorenzo
>=20
> The interrupt handling isn=E2=80=99t only for fifo reading, so I think it=
=E2=80=99s correct to move it out of the buffer handling file.

Uhm, re-thinking about it I agree, it will be useful even for upcoming I3C
support. Btw I think you are using a prehistoric version of the driver ;)

Regards,
Lorenzo

>=20
> /Sean
> >=20
> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx.h
> >> index edcd838037cd..a5e373680e9c 100644
> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >> @@ -175,5 +175,6 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_=
sensor *sensor,
> >> int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> >> int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> >>                 enum st_lsm6dsx_fifo_mode fifo_mode);
> >> +int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
> >>=20
> >> #endif /* ST_LSM6DSX_H */
> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/=
iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> >> index 631360b14ca7..a1ed61a64a64 100644
> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> >> @@ -25,8 +25,6 @@
> >>  * Licensed under the GPL-2.
> >>  */
> >> #include <linux/module.h>
> >> -#include <linux/interrupt.h>
> >> -#include <linux/irq.h>
> >> #include <linux/iio/kfifo_buf.h>
> >> #include <linux/iio/iio.h>
> >> #include <linux/iio/buffer.h>
> >> @@ -37,10 +35,6 @@
> >>=20
> >> #include "st_lsm6dsx.h"
> >>=20
> >> -#define ST_LSM6DSX_REG_HLACTIVE_ADDR        0x12
> >> -#define ST_LSM6DSX_REG_HLACTIVE_MASK        BIT(5)
> >> -#define ST_LSM6DSX_REG_PP_OD_ADDR        0x12
> >> -#define ST_LSM6DSX_REG_PP_OD_MASK        BIT(4)
> >> #define ST_LSM6DSX_REG_FIFO_MODE_ADDR        0x0a
> >> #define ST_LSM6DSX_FIFO_MODE_MASK        GENMASK(2, 0)
> >> #define ST_LSM6DSX_FIFO_ODR_MASK        GENMASK(6, 3)
> >> @@ -282,7 +276,7 @@ static inline int st_lsm6dsx_read_block(struct st_=
lsm6dsx_hw *hw, u8 *data,
> >>  *
> >>  * Return: Number of bytes read from the FIFO
> >>  */
> >> -static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >> +int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >> {
> >>    u16 fifo_len, pattern_len =3D hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
> >>    u16 fifo_diff_mask =3D hw->settings->fifo_ops.fifo_diff.mask;
> >> @@ -465,25 +459,6 @@ static int st_lsm6dsx_update_fifo(struct iio_dev =
*iio_dev, bool enable)
> >>    return err;
> >> }
> >>=20
> >> -static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> >> -{
> >> -    struct st_lsm6dsx_hw *hw =3D private;
> >> -
> >> -    return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> >> -}
> >> -
> >> -static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> >> -{
> >> -    struct st_lsm6dsx_hw *hw =3D private;
> >> -    int count;
> >> -
> >> -    mutex_lock(&hw->fifo_lock);
> >> -    count =3D st_lsm6dsx_read_fifo(hw);
> >> -    mutex_unlock(&hw->fifo_lock);
> >> -
> >> -    return !count ? IRQ_NONE : IRQ_HANDLED;
> >> -}
> >> -
> >> static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
> >> {
> >>    return st_lsm6dsx_update_fifo(iio_dev, true);
> >> @@ -501,59 +476,8 @@ static const struct iio_buffer_setup_ops st_lsm6d=
sx_buffer_ops =3D {
> >>=20
> >> int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
> >> {
> >> -    struct device_node *np =3D hw->dev->of_node;
> >> -    struct st_sensors_platform_data *pdata;
> >>    struct iio_buffer *buffer;
> >> -    unsigned long irq_type;
> >> -    bool irq_active_low;
> >> -    int i, err;
> >> -
> >> -    irq_type =3D irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> >> -
> >> -    switch (irq_type) {
> >> -    case IRQF_TRIGGER_HIGH:
> >> -    case IRQF_TRIGGER_RISING:
> >> -        irq_active_low =3D false;
> >> -        break;
> >> -    case IRQF_TRIGGER_LOW:
> >> -    case IRQF_TRIGGER_FALLING:
> >> -        irq_active_low =3D true;
> >> -        break;
> >> -    default:
> >> -        dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
> >> -        return -EINVAL;
> >> -    }
> >> -
> >> -    err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_AD=
DR,
> >> -                 ST_LSM6DSX_REG_HLACTIVE_MASK,
> >> -                 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
> >> -                        irq_active_low));
> >> -    if (err < 0)
> >> -        return err;
> >> -
> >> -    pdata =3D (struct st_sensors_platform_data *)hw->dev->platform_da=
ta;
> >> -    if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> >> -        (pdata && pdata->open_drain)) {
> >> -        err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_A=
DDR,
> >> -                     ST_LSM6DSX_REG_PP_OD_MASK,
> >> -                     FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
> >> -                            1));
> >> -        if (err < 0)
> >> -            return err;
> >> -
> >> -        irq_type |=3D IRQF_SHARED;
> >> -    }
> >> -
> >> -    err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> >> -                    st_lsm6dsx_handler_irq,
> >> -                    st_lsm6dsx_handler_thread,
> >> -                    irq_type | IRQF_ONESHOT,
> >> -                    "lsm6dsx", hw);
> >> -    if (err) {
> >> -        dev_err(hw->dev, "failed to request trigger irq %d\n",
> >> -            hw->irq);
> >> -        return err;
> >> -    }
> >> +    int i;
> >>=20
> >>    for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> >>        buffer =3D devm_iio_kfifo_allocate(hw->dev);
> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/ii=
o/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> index aebbe0ddd8d8..b5d3fa354de7 100644
> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> @@ -36,6 +36,8 @@
> >> #include <linux/delay.h>
> >> #include <linux/iio/iio.h>
> >> #include <linux/iio/sysfs.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/irq.h>
> >> #include <linux/pm.h>
> >> #include <linux/regmap.h>
> >> #include <linux/bitfield.h>
> >> @@ -55,6 +57,11 @@
> >> #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR    0x13
> >> #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK    BIT(5)
> >>=20
> >> +#define ST_LSM6DSX_REG_HLACTIVE_ADDR        0x12
> >> +#define ST_LSM6DSX_REG_HLACTIVE_MASK        BIT(5)
> >> +#define ST_LSM6DSX_REG_PP_OD_ADDR        0x12
> >> +#define ST_LSM6DSX_REG_PP_OD_MASK        BIT(4)
> >> +
> >> #define ST_LSM6DSX_REG_ACC_ODR_ADDR        0x10
> >> #define ST_LSM6DSX_REG_ACC_ODR_MASK        GENMASK(7, 4)
> >> #define ST_LSM6DSX_REG_ACC_FS_ADDR        0x10
> >> @@ -804,6 +811,83 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(st=
ruct st_lsm6dsx_hw *hw,
> >>    return iio_dev;
> >> }
> >>=20
> >> +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> >> +{
> >> +    struct st_lsm6dsx_hw *hw =3D private;
> >> +
> >> +    return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> >> +}
> >> +
> >> +static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> >> +{
> >> +    struct st_lsm6dsx_hw *hw =3D private;
> >> +    int count;
> >> +
> >> +    mutex_lock(&hw->fifo_lock);
> >> +    count =3D st_lsm6dsx_read_fifo(hw);
> >> +    mutex_unlock(&hw->fifo_lock);
> >> +
> >> +    return !count ? IRQ_NONE : IRQ_HANDLED;
> >> +}
> >> +
> >> +int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> >> +{
> >> +    struct st_sensors_platform_data *pdata;
> >> +    struct device_node *np =3D hw->dev->of_node;
> >> +    unsigned long irq_type;
> >> +    bool irq_active_low;
> >> +    int err;
> >> +
> >> +    irq_type =3D irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> >> +
> >> +    switch (irq_type) {
> >> +    case IRQF_TRIGGER_HIGH:
> >> +    case IRQF_TRIGGER_RISING:
> >> +        irq_active_low =3D false;
> >> +        break;
> >> +    case IRQF_TRIGGER_LOW:
> >> +    case IRQF_TRIGGER_FALLING:
> >> +        irq_active_low =3D true;
> >> +        break;
> >> +    default:
> >> +        dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_AD=
DR,
> >> +                 ST_LSM6DSX_REG_HLACTIVE_MASK,
> >> +                 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
> >> +                        irq_active_low));
> >> +    if (err < 0)
> >> +        return err;
> >> +
> >> +    pdata =3D (struct st_sensors_platform_data *)hw->dev->platform_da=
ta;
> >> +    if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> >> +        (pdata && pdata->open_drain)) {
> >> +        err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_A=
DDR,
> >> +                     ST_LSM6DSX_REG_PP_OD_MASK,
> >> +                     FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
> >> +                            1));
> >> +        if (err < 0)
> >> +            return err;
> >> +
> >> +        irq_type |=3D IRQF_SHARED;
> >> +    }
> >> +
> >> +    err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> >> +                    st_lsm6dsx_handler_irq,
> >> +                    st_lsm6dsx_handler_thread,
> >> +                    irq_type | IRQF_ONESHOT,
> >> +                    "lsm6dsx", hw);
> >> +    if (err) {
> >> +        dev_err(hw->dev, "failed to request trigger irq %d\n",
> >> +            hw->irq);
> >> +        return err;
> >> +    }
> >> +
> >> +    return err;
> >> +}
> >> +
> >> int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const cha=
r *name,
> >>             struct regmap *regmap)
> >> {
> >> @@ -842,6 +926,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, =
int hw_id, const char *name,
> >>        return err;
> >>=20
> >>    if (hw->irq > 0) {
> >> +        err =3D st_lsm6dsx_irq_setup(hw);
> >> +        if (err < 0)
> >> +            return err;
> >>        err =3D st_lsm6dsx_fifo_setup(hw);
> >>        if (err < 0)
> >>            return err;
> >> --=20
> >> 2.22.0
> >>=20

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQnPGgAKCRA6cBh0uS2t
rI5QAQC8/J1qK3osDumBnZjRtcCtHJJ2QG22s3WeLBWcxVPiOQD8CLrxbGxEt3fm
g7nX+yf/KT2oL3vjd193/sZMTZHYwAs=
=mn9Y
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
