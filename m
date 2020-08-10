Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADFE24031D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgHJIDC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJIDC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 04:03:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC83C061756;
        Mon, 10 Aug 2020 01:03:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f10so4356801plj.8;
        Mon, 10 Aug 2020 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIVYbfl60/LCAXTYgKZTMLflQoCrjmA+x5UQf4DHC8U=;
        b=BLFDPlRaEIp2bEVswqI1V3rY6FhRvyvhrKzRCgp8XtqofWcIO+R2xg8xsxH+g2ewCL
         rKZodlVz6vEJ7jlUQlvTofVSMkNZbEA2ofzmZ3Ll51KfOTeZiFe05PYW7MLdHw6hegtL
         rxNbcrLM8whucUuOnBpyL91evVA3dVoD9m2ZX2Up7xDYXIxhnUaip/iP3x8LFfm9+he/
         LSEPg3VY2l/QFnbByOpMMZoPEPResMdy6KsbmIVNE2HHBDDMBLllUuZnvn4c5AQjGgY4
         9Om+TeqtZnUgAeaRCIX3vxbJR8Jbq45fYYcREg5j3DGJ0cSHEUJGr+YdBHyMl5AIBY5E
         nEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIVYbfl60/LCAXTYgKZTMLflQoCrjmA+x5UQf4DHC8U=;
        b=tvES0O1BfZT5pDr/3/k2ynTMYbwwnl9k02PRazNFak+OMGxpHzwB7z7P8N5TLGIpZ1
         Rm5TDDo6swmd2XpCJohFFLTGXX/c6V5K+aBZhh3oZ3w1y7iWdozyhrI84/StGwBkwojq
         VNeFhCbdKy8Fw6aOJaJzWFbFUybLvD71oJjNtudMZVII3czkHBoUuGcPEnHpSlYAWGCa
         fwyvVd9NxpnBWDbzgMSk9ELANqVdZdONnBwBioPvVhor9FZBdm9JahFRFSfZxJTih/4P
         OD/1dIbDRe9984Klv9x2gEN2wLk4aKjQvy+O21ywm2Hw8LoxH1JCW+5NFPZF3+Ge6zto
         0qow==
X-Gm-Message-State: AOAM531yfB1xKFn013vqTQZWY+K3YJHqepLSHgdz283097+CVJgmsJp5
        7Ry1sP66KxRap74jI6mwcQdF6WfEz+be2viIcWTi97f4kdLi5A==
X-Google-Smtp-Source: ABdhPJwHVCVP7tW6XE3VLpw262gbkqCVMj2TlQmrMSM9cSxkzFlBa9Yn9IC/QE5FWG2bR7VFa1pw8Jie3rkVmrEHBQo=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr22749650plo.262.1597046581567;
 Mon, 10 Aug 2020 01:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200809155936.16898-1-trix@redhat.com>
In-Reply-To: <20200809155936.16898-1-trix@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Aug 2020 11:02:45 +0300
Message-ID: <CAHp75VdEBjxYS_4g2j=ofjFWuGyTK5Me=9mMNcy5ienUUs67Ag@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable
To:     trix@redhat.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Lee Jones <lee.jones@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 9, 2020 at 7:00 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this problem
>
> inv_mpu_ring.c:181:18: warning: Division by zero
>         nb = fifo_count / bytes_per_datum;
>              ~~~~~~~~~~~^~~~~~~~~~~~~~~~~
>
> This is a false positive.
> Dividing by 0 is protected by this check
>
>         if (!(st->chip_config.accl_fifo_enable |
>                 st->chip_config.gyro_fifo_enable |
>                 st->chip_config.magn_fifo_enable))
>                 goto end_session;
>         bytes_per_datum = 0;
>
> But there is another fifo, temp_fifo
>
>         if (st->chip_config.temp_fifo_enable)
>                 bytes_per_datum += INV_MPU6050_BYTES_PER_TEMP_SENSOR;
>
> Which would be skipped if it was the only enabled fifo.
> So add to the check.
>

> Fixes: 2e4c0a5e2576 ("iio: imu: inv_mpu6050: add fifo temperature data support")
>
> Signed-off-by: Tom Rix <trix@redhat.com>

There shouldn't be a blank line in between.

Other than that,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>



> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index b533fa2dad0a..5240a400dcb4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -141,6 +141,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>
>         if (!(st->chip_config.accl_fifo_enable |
>                 st->chip_config.gyro_fifo_enable |
> +               st->chip_config.temp_fifo_enable |
>                 st->chip_config.magn_fifo_enable))
>                 goto end_session;
>         bytes_per_datum = 0;
> --
> 2.18.1
>


--
With Best Regards,
Andy Shevchenko
