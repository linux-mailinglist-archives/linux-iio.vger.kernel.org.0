Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6751B39F103
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHIfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhFHIfM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 04:35:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848DBC061574
        for <linux-iio@vger.kernel.org>; Tue,  8 Jun 2021 01:33:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 11so10228381plk.12
        for <linux-iio@vger.kernel.org>; Tue, 08 Jun 2021 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHzlhV0Yxj6WUPZw2k/60+gIXMZg6++itYA8ktT0Kn4=;
        b=UkrWpq0jz+hPK9BcLasMIXoJc4pEX4fmVCsP3w4Zu7hlsfzqcLSzWcd6gQrNSTVoAh
         oKZeVGzvQV19WPd5q64AOvtSJVvYxySez1D6qUsAuOOrCQ/3MNAM0y6GfqARjsnWnxL+
         swdj6aSlp5t1x3UyLaUlB6loH75sCqgD6wuNlVRvmxmAfbr12cTAVIu1hTrB23W4DMXp
         +vVmguLQyOfWxC7ofvDgv9QtIVlOPrK2Pr/O5sQLvAdUMfeKnHO7w15Uv5BjMIDrJzo2
         zV9IbpUajhyHIU+YIBFedu7dM+ol1hSni2cdpvCOeGvz4ZV87jgDYzQoo0p16gF+smFq
         u0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHzlhV0Yxj6WUPZw2k/60+gIXMZg6++itYA8ktT0Kn4=;
        b=rRunNt5KKSy/A0O+HsKtYx94+JYyuY4NP2fr5I29MvAypNL9I+MK3H+KsrLFJl9TpG
         UnDRg5eEuf52tHoM9E1d9O7nTCyCafREOsrcXWGXRlHwgXNrBXtBb9AasETcOegJYMa0
         oVQIsYruIK56HhZnYal4IzDpGLXubpdvWrhq9EG6Hd5mbOAAZ2kI2Pqn/J9jzSMqFf8R
         fFw0q4HuKSB7mIe6tUOP8UQJGXR17u8xPzxTFeFu6vlpNDLD6sVANrR/0leRJoOknHTK
         4cUvq5OROPmwrkrOPjT4XlYNx3EsmLMfn1XW+/WTN/pUGcLZ58T4+5DyIw2sH5vKycPx
         xNtA==
X-Gm-Message-State: AOAM532bvqpY90dO+gNT3QiwmiWbnUxT7yyDQASpjrubtzjxSUPlAZWV
        UnXYYjK+3upM7jwQeW5uZUZO+G2NxuxOoZspl48=
X-Google-Smtp-Source: ABdhPJzWdOa/xWuu7O3Ro6MUSWD6EmK/LsoQxUscq2mPnYeCAHakF5ueX+2C2JW+iJY92iJY1GxL2s1gowdfCaHJWWg=
X-Received: by 2002:a17:902:ceca:b029:112:b67b:fe4f with SMTP id
 d10-20020a170902cecab0290112b67bfe4fmr8398508plg.32.1623141198940; Tue, 08
 Jun 2021 01:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210607113715.110292-1-chi962464zy@163.com> <CA+U=DsrvoL_piCZ0n+CFtCu6BegePpBqKRNRArTzni4CuqE1bg@mail.gmail.com>
 <20210608092337.00006b11@163.com>
In-Reply-To: <20210608092337.00006b11@163.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 8 Jun 2021 11:33:07 +0300
Message-ID: <CA+U=DsrvuXgXG+NQgJPp+VOzPko5ZmRGMsenw5aUx4+qhhr4CA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050:Adding judgment dev which is maybe
 a void pointer
To:     Guoqing Chi <chi962464zy@163.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, chiguoqing@yulong.com,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 8, 2021 at 4:23 AM Guoqing Chi <chi962464zy@163.com> wrote:
>
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
> > *dev = indio_dev->dev.parent;', which looks impossible given that the
> > IIO device-object was created with devm_iio_device_alloc().
> > So, 'indio_dev->dev.parent' can't be NULL, as far as I can tell.
> >
> > On what version of the kernel has this been seen?
>
> Hi Alexandru:
> In kernel 5.4.70_2.3.0,and find the devm_iio_device_alloc() differ from
> new version,The problem occurs apply the newest mpu6050 driver to
> kernel 5.4.70,i will check it.

Sometime in kernel 5.8, this commit was added:
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=78289b4a58b58e9a8a76ef43ffbaf04a097e33c6
Then a lot of drivers got their manual parent assignment cleaned up.

If you backport a driver from the latest kernel, without patch [1],
you risk getting crashes/invalid behavior.

>
> Thanks.
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
