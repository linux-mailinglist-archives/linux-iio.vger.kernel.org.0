Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23339DD87
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFGNWX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGNWW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 09:22:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D3C061766
        for <linux-iio@vger.kernel.org>; Mon,  7 Jun 2021 06:20:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q25so13056461pfh.7
        for <linux-iio@vger.kernel.org>; Mon, 07 Jun 2021 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5ZEyQ8ThpDmRM+zURO073dIK7oCXFBUzgzNNoaEAdc=;
        b=Oj90/73sEgEWZL/VNC9DiW9h3PCXiCwPjC7+A2sKEvn5CWvqsSIi94NK2BfiQhT4GW
         bxBoZW0h4zg0RKw/YxWE052YKDMnrVJ63dUV8I9Nuli6lgftfPqXXm4sdIZmIG6bB+CS
         tWTkAeDeoscBo+IMgXp3NhL1i/lTKyAKmmbK66hK1B2MCv0Cyq5ieBpl3izmlurupCxo
         pm9K15NKks8WcqQL82zHo6aJX/3Q/qEemVwn3H2R/usGntrhbAKmQSKfEAN8RyDi3nQV
         BuzDx6Zm1xTorfzaQIke73O+xyeLz5ZQ+T1vDEu441mGgLLcEbny3fhtxO8jPp45+Vjd
         ZCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5ZEyQ8ThpDmRM+zURO073dIK7oCXFBUzgzNNoaEAdc=;
        b=crj3BIkfHupJL/cyGlIeSsZuAMd1ScfV5Q3N7SPU2r5KM6VqVhO1VtKfHjK0PPP0EQ
         KoVvHvcTwu9444uoz4uF9HElD5KMOXb7I7kJJA0lY/ZD3jisc5uZwv0OjVf1YlLpdRcX
         nwkglPWEBaMz6Gi5KEG91M2G2sjZP3va/Uf+rg9oCKTAXGWl24YUDd7U3fFwUClvNHGL
         TXdErXdy4wpD0DjbYfh0vfmBIqsprS1iSYoglIlzO/GAKNsu03O8ON/Wa2UXTjNw/qXs
         5YBpYSG/QbtWxvOK7CrEwRtcsCxKQ13gn6cumHDjX5SFb+ClF2b8hbloTg8Dp/LdbMsT
         7ZFg==
X-Gm-Message-State: AOAM53267ev/tK3a3gjwb8mcMeOfL3+gMxxI1dusYhGOKmALptAxv6iy
        g8h7yWik2SKYhqxlTytMZeRHpvTV5kGOM5Coq6fyKZc7NCWfm4Xa
X-Google-Smtp-Source: ABdhPJzZVsjMxolW8kZvLmyZMhOtYDq6QJLJL948G51e8Fd8DGR14EuNyQT/Zv2AgiHAiJ6PIZhbmC0mt1ERFkG8J1c=
X-Received: by 2002:a63:5616:: with SMTP id k22mr14638981pgb.41.1623072017809;
 Mon, 07 Jun 2021 06:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210607113715.110292-1-chi962464zy@163.com>
In-Reply-To: <20210607113715.110292-1-chi962464zy@163.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 7 Jun 2021 16:20:06 +0300
Message-ID: <CA+U=DsrvoL_piCZ0n+CFtCu6BegePpBqKRNRArTzni4CuqE1bg@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 2:39 PM Guoqing Chi <chi962464zy@163.com> wrote:
>
> From: Guoqing Chi <chiguoqing@yulong.com>
>
> ff40: 00000000 95fffa74 00000000 e07b2198 00000000 00000007 81391000 e07b2198
> ff60: 00000007 81391000 81267834 81391000 0000015a 81200f00 00000006 00000006
> ff80: 00000000 81200514 00000000 80bfbd88 00000000 00000000 00000000 00000000
> ffa0: 00000000 80bfbd90 00000000 801010e8 00000000 00000000 00000000 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [<808f3228>] (inv_mpu_i2c_aux_setup) from [<808f1c18>] (inv_mpu_core_probe+0x638/0x878)
> [<808f1c18>] (inv_mpu_core_probe) from [<808f3100>] (inv_mpu_probe+0xe4/0x1f0)
> [<808f3100>] (inv_mpu_probe) from [<80801c88>] (i2c_device_probe+0x238/0x26c)
> [<80801c88>] (i2c_device_probe) from [<8063520c>] (really_probe+0x218/0x348)
> [<8063520c>] (really_probe) from [<806354b4>] (driver_probe_device+0x60/0x164)
> [<806354b4>] (driver_probe_device) from [<80635760>] (device_driver_attach+0x58/0x60)
> [<80635760>] (device_driver_attach) from [<806357e8>] (__driver_attach+0x80/0xbc)
> [<806357e8>] (__driver_attach) from [<80633560>] (bus_for_each_dev+0x74/0xb4)
> [<80633560>] (bus_for_each_dev) from [<80634548>] (bus_add_driver+0x160/0x1e4)
> [<80634548>] (bus_add_driver) from [<80636018>] (driver_register+0x7c/0x114)
> [<80636018>] (driver_register) from [<80801644>] (i2c_register_driver+0x3c/0x80)
> [<80801644>] (i2c_register_driver) from [<8010277c>] (do_one_initcall+0x54/0x1b8)
> [<8010277c>] (do_one_initcall) from [<81200f00>] (kernel_init_freeable+0x144/0x1e0)
> [<81200f00>] (kernel_init_freeable) from [<80bfbd90>] (kernel_init+0x8/0x10c)
> [<80bfbd90>] (kernel_init) from [<801010e8>] (ret_from_fork+0x14/0x2c)
>
> If we do not use aux or forget config child node at dts,it will be in dump.
>
> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 95f16951c8f4..b0f45042a25f 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -77,11 +77,14 @@ static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
>         }
>
>         /* enable i2c bypass when using i2c auxiliary bus */
> -       if (inv_mpu_i2c_aux_bus(dev)) {
> +       if (dev != NULL && inv_mpu_i2c_aux_bus(dev)) {

One point is that this solves the issue for the I2C variant, but
doesn't seem to handle the SPI variant of the driver/device.
So, maybe this should be checked for NULL in inv_mpu_core_probe().

But, the 'dev' reference comes from this assignment 'struct device
*dev = indio_dev->dev.parent;', which looks impossible given that the
IIO device-object was created with devm_iio_device_alloc().
So, 'indio_dev->dev.parent' can't be NULL, as far as I can tell.

On what version of the kernel has this been seen?

>                 ret = regmap_write(st->map, st->reg->int_pin_cfg,
>                                    st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
>                 if (ret)
>                         return ret;
> +       } else {
> +               dev_err(&indio_dev->dev, "Failed to enable i2c bypass.\n");
> +               return -EFAULT;
>         }
>
>         return 0;
> --
> 2.17.1
>
