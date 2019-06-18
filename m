Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E089B4A7B3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfFRQ4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 12:56:22 -0400
Received: from first.geanix.com ([116.203.34.67]:39496 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbfFRQ4V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 12:56:21 -0400
Received: from [10.10.213.22] (80-62-116-22-mobile.dk.customer.tdc.net [80.62.116.22])
        by first.geanix.com (Postfix) with ESMTPSA id 5CDF9340;
        Tue, 18 Jun 2019 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560876970; bh=oFpXD1oOnn5OXY0PntwWak4/y9/IjXgWXGgz3+cBQQY=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=AN0pifdQ48I+S/WtSiIN5JWWPWX/Jll0pNHmkfvhGCXpsIjZhQT3H5j75Wq7KeRSD
         SsCkx5RWD64qBRPrYIHPo8WpqFUMNUkL5v2/sb41YjF7EQ+31qG+PpTtYnlWc76BpD
         VjlYINGzCHz8CWpJvQhr1IRbAkXdaTzF0KB+xBhsa7vBClrk+Ukxn38ED9ixbFPKo8
         x12KoG1ciZrKSdXlonxX29neyuJv1eHRWLQSo8Io0DWFED+t+A6pkIkwmK1H0gy5XF
         bC/CZoFpAh/7bR+GYX9yiQHb/vAnREYl7Cl0P3IkpCqUUUebOgRj8Et3kBNbq6tMMV
         OeatpOoMIO6tA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/5] iio: imu: st_lsm6dsx: move interrupt thread to core
From:   =?utf-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190618155705.GA22268@localhost.localdomain>
Date:   Tue, 18 Jun 2019 18:56:15 +0200
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE6D853C-BA54-45B5-9912-A1C89F78CC32@geanix.com>
References: <20190618125939.105903-1-sean@geanix.com> <20190618125939.105903-2-sean@geanix.com> <20190618155705.GA22268@localhost.localdomain>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 18 Jun 2019, at 17.57, Lorenzo Bianconi <lorenzo@kernel.org> wrote:

>> This prepares the interrupt to be used for other stuff than
>> fifo reading -> event readings.
>>=20
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  1 +
>> .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 80 +----------------
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 87 +++++++++++++++++++
>> 3 files changed, 90 insertions(+), 78 deletions(-)
>>=20
>=20
> I can't see why we need this patch
>=20
> Regards,
> Lorenzo

The interrupt handling isn=E2=80=99t only for fifo reading, so I think it=E2=
=80=99s correct to move it out of the buffer handling file.

/Sean
>=20
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
>> index edcd838037cd..a5e373680e9c 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> @@ -175,5 +175,6 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sen=
sor *sensor,
>> int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
>> int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>>                 enum st_lsm6dsx_fifo_mode fifo_mode);
>> +int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
>>=20
>> #endif /* ST_LSM6DSX_H */
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> index 631360b14ca7..a1ed61a64a64 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> @@ -25,8 +25,6 @@
>>  * Licensed under the GPL-2.
>>  */
>> #include <linux/module.h>
>> -#include <linux/interrupt.h>
>> -#include <linux/irq.h>
>> #include <linux/iio/kfifo_buf.h>
>> #include <linux/iio/iio.h>
>> #include <linux/iio/buffer.h>
>> @@ -37,10 +35,6 @@
>>=20
>> #include "st_lsm6dsx.h"
>>=20
>> -#define ST_LSM6DSX_REG_HLACTIVE_ADDR        0x12
>> -#define ST_LSM6DSX_REG_HLACTIVE_MASK        BIT(5)
>> -#define ST_LSM6DSX_REG_PP_OD_ADDR        0x12
>> -#define ST_LSM6DSX_REG_PP_OD_MASK        BIT(4)
>> #define ST_LSM6DSX_REG_FIFO_MODE_ADDR        0x0a
>> #define ST_LSM6DSX_FIFO_MODE_MASK        GENMASK(2, 0)
>> #define ST_LSM6DSX_FIFO_ODR_MASK        GENMASK(6, 3)
>> @@ -282,7 +276,7 @@ static inline int st_lsm6dsx_read_block(struct st_lsm=
6dsx_hw *hw, u8 *data,
>>  *
>>  * Return: Number of bytes read from the FIFO
>>  */
>> -static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>> +int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>> {
>>    u16 fifo_len, pattern_len =3D hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
>>    u16 fifo_diff_mask =3D hw->settings->fifo_ops.fifo_diff.mask;
>> @@ -465,25 +459,6 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *ii=
o_dev, bool enable)
>>    return err;
>> }
>>=20
>> -static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>> -{
>> -    struct st_lsm6dsx_hw *hw =3D private;
>> -
>> -    return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
>> -}
>> -
>> -static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>> -{
>> -    struct st_lsm6dsx_hw *hw =3D private;
>> -    int count;
>> -
>> -    mutex_lock(&hw->fifo_lock);
>> -    count =3D st_lsm6dsx_read_fifo(hw);
>> -    mutex_unlock(&hw->fifo_lock);
>> -
>> -    return !count ? IRQ_NONE : IRQ_HANDLED;
>> -}
>> -
>> static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
>> {
>>    return st_lsm6dsx_update_fifo(iio_dev, true);
>> @@ -501,59 +476,8 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_=
buffer_ops =3D {
>>=20
>> int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>> {
>> -    struct device_node *np =3D hw->dev->of_node;
>> -    struct st_sensors_platform_data *pdata;
>>    struct iio_buffer *buffer;
>> -    unsigned long irq_type;
>> -    bool irq_active_low;
>> -    int i, err;
>> -
>> -    irq_type =3D irqd_get_trigger_type(irq_get_irq_data(hw->irq));
>> -
>> -    switch (irq_type) {
>> -    case IRQF_TRIGGER_HIGH:
>> -    case IRQF_TRIGGER_RISING:
>> -        irq_active_low =3D false;
>> -        break;
>> -    case IRQF_TRIGGER_LOW:
>> -    case IRQF_TRIGGER_FALLING:
>> -        irq_active_low =3D true;
>> -        break;
>> -    default:
>> -        dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
>> -        return -EINVAL;
>> -    }
>> -
>> -    err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,=

>> -                 ST_LSM6DSX_REG_HLACTIVE_MASK,
>> -                 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
>> -                        irq_active_low));
>> -    if (err < 0)
>> -        return err;
>> -
>> -    pdata =3D (struct st_sensors_platform_data *)hw->dev->platform_data;=

>> -    if ((np && of_property_read_bool(np, "drive-open-drain")) ||
>> -        (pdata && pdata->open_drain)) {
>> -        err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR=
,
>> -                     ST_LSM6DSX_REG_PP_OD_MASK,
>> -                     FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
>> -                            1));
>> -        if (err < 0)
>> -            return err;
>> -
>> -        irq_type |=3D IRQF_SHARED;
>> -    }
>> -
>> -    err =3D devm_request_threaded_irq(hw->dev, hw->irq,
>> -                    st_lsm6dsx_handler_irq,
>> -                    st_lsm6dsx_handler_thread,
>> -                    irq_type | IRQF_ONESHOT,
>> -                    "lsm6dsx", hw);
>> -    if (err) {
>> -        dev_err(hw->dev, "failed to request trigger irq %d\n",
>> -            hw->irq);
>> -        return err;
>> -    }
>> +    int i;
>>=20
>>    for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>        buffer =3D devm_iio_kfifo_allocate(hw->dev);
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
>> index aebbe0ddd8d8..b5d3fa354de7 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -36,6 +36,8 @@
>> #include <linux/delay.h>
>> #include <linux/iio/iio.h>
>> #include <linux/iio/sysfs.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> #include <linux/pm.h>
>> #include <linux/regmap.h>
>> #include <linux/bitfield.h>
>> @@ -55,6 +57,11 @@
>> #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR    0x13
>> #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK    BIT(5)
>>=20
>> +#define ST_LSM6DSX_REG_HLACTIVE_ADDR        0x12
>> +#define ST_LSM6DSX_REG_HLACTIVE_MASK        BIT(5)
>> +#define ST_LSM6DSX_REG_PP_OD_ADDR        0x12
>> +#define ST_LSM6DSX_REG_PP_OD_MASK        BIT(4)
>> +
>> #define ST_LSM6DSX_REG_ACC_ODR_ADDR        0x10
>> #define ST_LSM6DSX_REG_ACC_ODR_MASK        GENMASK(7, 4)
>> #define ST_LSM6DSX_REG_ACC_FS_ADDR        0x10
>> @@ -804,6 +811,83 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struc=
t st_lsm6dsx_hw *hw,
>>    return iio_dev;
>> }
>>=20
>> +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>> +{
>> +    struct st_lsm6dsx_hw *hw =3D private;
>> +
>> +    return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
>> +}
>> +
>> +static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>> +{
>> +    struct st_lsm6dsx_hw *hw =3D private;
>> +    int count;
>> +
>> +    mutex_lock(&hw->fifo_lock);
>> +    count =3D st_lsm6dsx_read_fifo(hw);
>> +    mutex_unlock(&hw->fifo_lock);
>> +
>> +    return !count ? IRQ_NONE : IRQ_HANDLED;
>> +}
>> +
>> +int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>> +{
>> +    struct st_sensors_platform_data *pdata;
>> +    struct device_node *np =3D hw->dev->of_node;
>> +    unsigned long irq_type;
>> +    bool irq_active_low;
>> +    int err;
>> +
>> +    irq_type =3D irqd_get_trigger_type(irq_get_irq_data(hw->irq));
>> +
>> +    switch (irq_type) {
>> +    case IRQF_TRIGGER_HIGH:
>> +    case IRQF_TRIGGER_RISING:
>> +        irq_active_low =3D false;
>> +        break;
>> +    case IRQF_TRIGGER_LOW:
>> +    case IRQF_TRIGGER_FALLING:
>> +        irq_active_low =3D true;
>> +        break;
>> +    default:
>> +        dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,=

>> +                 ST_LSM6DSX_REG_HLACTIVE_MASK,
>> +                 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
>> +                        irq_active_low));
>> +    if (err < 0)
>> +        return err;
>> +
>> +    pdata =3D (struct st_sensors_platform_data *)hw->dev->platform_data;=

>> +    if ((np && of_property_read_bool(np, "drive-open-drain")) ||
>> +        (pdata && pdata->open_drain)) {
>> +        err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR=
,
>> +                     ST_LSM6DSX_REG_PP_OD_MASK,
>> +                     FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
>> +                            1));
>> +        if (err < 0)
>> +            return err;
>> +
>> +        irq_type |=3D IRQF_SHARED;
>> +    }
>> +
>> +    err =3D devm_request_threaded_irq(hw->dev, hw->irq,
>> +                    st_lsm6dsx_handler_irq,
>> +                    st_lsm6dsx_handler_thread,
>> +                    irq_type | IRQF_ONESHOT,
>> +                    "lsm6dsx", hw);
>> +    if (err) {
>> +        dev_err(hw->dev, "failed to request trigger irq %d\n",
>> +            hw->irq);
>> +        return err;
>> +    }
>> +
>> +    return err;
>> +}
>> +
>> int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *=
name,
>>             struct regmap *regmap)
>> {
>> @@ -842,6 +926,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int=
 hw_id, const char *name,
>>        return err;
>>=20
>>    if (hw->irq > 0) {
>> +        err =3D st_lsm6dsx_irq_setup(hw);
>> +        if (err < 0)
>> +            return err;
>>        err =3D st_lsm6dsx_fifo_setup(hw);
>>        if (err < 0)
>>            return err;
>> --=20
>> 2.22.0
>>=20
