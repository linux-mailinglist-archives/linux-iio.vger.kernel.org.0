Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8158739F0F5
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHIcN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 04:32:13 -0400
Received: from m12-15.163.com ([220.181.12.15]:34697 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhFHIcN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Jun 2021 04:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=L0wib
        NZ1SIUH43hswGVR94kgi7FeRjyopxiJFDnJg4c=; b=hzHUzWfp+VZYu7swI8TDH
        pQFRXkpCKzc/808gcxH8oooeQOnHjMgO1z29VWavCYnHRRw8AAq7unu/661qTGBS
        lyL42A0tWgDs3rR/CHro7Rg0pa114yJ7ochbjhzABwD06D7kyn5GZjQ7MdMRV8ZI
        dRCy63/LFozgMtSE8CHB20=
Received: from localhost (unknown [218.94.48.178])
        by smtp11 (Coremail) with SMTP id D8CowAC3n76LKr9grHoJAA--.110S2;
        Tue, 08 Jun 2021 16:30:07 +0800 (CST)
Date:   Tue, 8 Jun 2021 16:30:13 +0800
From:   Guoqing Chi <chi962464zy@163.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, chiguoqing@yulong.com,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050:Adding judgment dev which is
 maybe a void pointer
Message-ID: <20210608163013.00001283@163.com>
In-Reply-To: <20210608092337.00006b11@163.com>
References: <20210607113715.110292-1-chi962464zy@163.com>
        <CA+U=DsrvoL_piCZ0n+CFtCu6BegePpBqKRNRArTzni4CuqE1bg@mail.gmail.com>
        <20210608092337.00006b11@163.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: D8CowAC3n76LKr9grHoJAA--.110S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWruF18ArWkCF4xuFyrXrb_yoWrAw1UpF
        W7XFyYkrs5XrWUXay7tF18CFy5tw1UAF1UXryxJFnxur4qkw1UZry8GrW29345Xr4Fkan7
        tw1DA34UtF18JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyHqcUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbB+AirRF2MZLUy8AAAsd
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Jun 2021 09:23:37 +0800
Guoqing Chi <chi962464zy@163.com> wrote:

> On Mon, 7 Jun 2021 16:20:06 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> 
> > On Mon, Jun 7, 2021 at 2:39 PM Guoqing Chi <chi962464zy@163.com>
> > wrote:
> > >
> > > From: Guoqing Chi <chiguoqing@yulong.com>
> > >
> > > ff40: 00000000 95fffa74 00000000 e07b2198 00000000 00000007
> > > 81391000 e07b2198 ff60: 00000007 81391000 81267834 81391000
> > > 0000015a 81200f00 00000006 00000006 ff80: 00000000 81200514
> > > 00000000 80bfbd88 00000000 00000000 00000000 00000000 ffa0:
> > > 00000000 80bfbd90 00000000 801010e8 00000000 00000000 00000000
> > > 00000000 ffc0: 00000000 00000000 00000000 00000000 00000000
> > > 00000000 00000000 00000000 ffe0: 00000000 00000000 00000000
> > > 00000000 00000013 00000000 00000000 00000000 [<808f3228>]
> > > (inv_mpu_i2c_aux_setup) from [<808f1c18>]
> > > (inv_mpu_core_probe+0x638/0x878) [<808f1c18>] (inv_mpu_core_probe)
> > > from [<808f3100>] (inv_mpu_probe+0xe4/0x1f0) [<808f3100>]
> > > (inv_mpu_probe) from [<80801c88>] (i2c_device_probe+0x238/0x26c)
> > > [<80801c88>] (i2c_device_probe) from [<8063520c>]
> > > (really_probe+0x218/0x348) [<8063520c>] (really_probe) from
> > > [<806354b4>] (driver_probe_device+0x60/0x164) [<806354b4>]
> > > (driver_probe_device) from [<80635760>]
> > > (device_driver_attach+0x58/0x60) [<80635760>]
> > > (device_driver_attach) from [<806357e8>]
> > > (__driver_attach+0x80/0xbc) [<806357e8>] (__driver_attach) from
> > > [<80633560>] (bus_for_each_dev+0x74/0xb4) [<80633560>]
> > > (bus_for_each_dev) from [<80634548>] (bus_add_driver+0x160/0x1e4)
> > > [<80634548>] (bus_add_driver) from [<80636018>]
> > > (driver_register+0x7c/0x114) [<80636018>] (driver_register) from
> > > [<80801644>] (i2c_register_driver+0x3c/0x80) [<80801644>]
> > > (i2c_register_driver) from [<8010277c>]
> > > (do_one_initcall+0x54/0x1b8) [<8010277c>] (do_one_initcall) from
> > > [<81200f00>] (kernel_init_freeable+0x144/0x1e0) [<81200f00>]
> > > (kernel_init_freeable) from [<80bfbd90>] (kernel_init+0x8/0x10c)
> > > [<80bfbd90>] (kernel_init) from [<801010e8>]
> > > (ret_from_fork+0x14/0x2c)
> > >
> > > If we do not use aux or forget config child node at dts,it will be
> > > in dump.
> > >
> > > Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
> > > ---
> > >  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> > > b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c index
> > > 95f16951c8f4..b0f45042a25f 100644 ---
> > > a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c +++
> > > b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c @@ -77,11 +77,14 @@
> > > static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev) }
> > >
> > >         /* enable i2c bypass when using i2c auxiliary bus */
> > > -       if (inv_mpu_i2c_aux_bus(dev)) {
> > > +       if (dev != NULL && inv_mpu_i2c_aux_bus(dev)) {  
> > 
> > One point is that this solves the issue for the I2C variant, but
> > doesn't seem to handle the SPI variant of the driver/device.
> > So, maybe this should be checked for NULL in inv_mpu_core_probe().
> > 
> > But, the 'dev' reference comes from this assignment 'struct device
> > *dev = indio_dev->dev.parent;', which looks impossible given that
> > the IIO device-object was created with devm_iio_device_alloc().
> > So, 'indio_dev->dev.parent' can't be NULL, as far as I can tell.
> > 
> > On what version of the kernel has this been seen?
> 
> Hi Alexandru:
> In kernel 5.4.70_2.3.0,and find the devm_iio_device_alloc() differ
> from new version,The problem occurs apply the newest mpu6050 driver to
> kernel 5.4.70,i will check it.
> 
> Thanks.

Hi all:

  It is no problems running in kernel-5.12.
  This patch will be abandoned.

Thanks.

> 
> > 
> > >                 ret = regmap_write(st->map, st->reg->int_pin_cfg,
> > >                                    st->irq_mask |
> > > INV_MPU6050_BIT_BYPASS_EN); if (ret)
> > >                         return ret;
> > > +       } else {
> > > +               dev_err(&indio_dev->dev, "Failed to enable i2c
> > > bypass.\n");
> > > +               return -EFAULT;
> > >         }
> > >
> > >         return 0;
> > > --
> > > 2.17.1
> > >  
> 

