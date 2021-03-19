Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1934216E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCSQCT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCSQCQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 12:02:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB91AC06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:02:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g15so6210607pfq.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbAMmyEsc23iFeVSvddZut9XHbMsBO/S4Z/UuZcu+U4=;
        b=HXwjEzvFn0xoZ+H0asFJYV5F3IrVB7jQKOPDz1NYIGpWee8iKxwmkeuftAek8+5pYy
         PeHVmBjddgtkMnAJ8BdwLPowBXXYkd5TGAZ8+Uw5RALX2s7cL5ZUokwilfqLIHMjK814
         RzL1J07Gap9jR+rdoSLeVVbQkL0ix6yF0wA7+nPA5so2HbfQJuFXoWK0wC6I2+Fr7fXZ
         rSxn5JkVnEjN8jFGBkkGd4Nc7WOyKLTlQVjXXzUCvtnsnc0MXIBim+9iTn3KXGFkcCoi
         OWYvh5mPDmbLd/ZxlMqeRRcl+dSc/Rox8vdCYhijFOn1smIp2s3MJbcbePde0MoGlTju
         gNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbAMmyEsc23iFeVSvddZut9XHbMsBO/S4Z/UuZcu+U4=;
        b=W8ZwF8UjFPotlektHxrZALM7eMnapUYcKHJSClfFHmu9KIT8ouFET6gsgYJ56gz885
         p0BblX0vmSLq6TvRnGtkdKanvAywEN4gLz9LynGcLrXAn+PfzCQGeNDFFRtXkz7/Kgx0
         XSTeeRxD2StsOXSFeXW2CCMk3QSDODc2GGv7AoG1m+lknX5RwzPpK/SrjgH0vd+P/Zu7
         26pQDpslh6XFKFPIXucIq5G7fyYYAV+B33FFW4UIfIQa98FXcgn6++mNIhWJuAXRbU1i
         6B9mjQzXA4cX1zz94mIGTUKFh09a23PGHNgJXeQgD7KeOX6+TWf4mP7YEkG+7E/TL3xV
         lDhQ==
X-Gm-Message-State: AOAM532htWbOlVlseewEWhikLLnptUDF8GV1+RiyuVyfiWxkfpa5oQvW
        R3B5woyDmn1DoWP+oQa9bzF6L42rPvOaGyyukt+a9xNnS8a9Dw==
X-Google-Smtp-Source: ABdhPJzNuKBizD4+1GD/q7S/7yzrCCet8oYtKqthRzjDNWFAqIXPmWkwZorLLModaa8t9va67ATwZdXsI0/J4syLWg0=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr206123pff.73.1616169735336; Fri, 19 Mar
 2021 09:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210319133357.541183-1-linus.walleij@linaro.org>
In-Reply-To: <20210319133357.541183-1-linus.walleij@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 18:01:59 +0200
Message-ID: <CAHp75VfeGJEBhcjdpGwbeeEvLA=k9qc0g9v5MyqoHCXyuxsPog@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Use as standalone trigger
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 3:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It may happen that the MPU6050 is the only hardware
> trigger available on your system such as this:
>
> > lsiio
> Device 003: hscdtd008a
> Device 001: mpu6050
> Device 002: gp2ap002
> Device 000: ab8500-gpadc
> Trigger 000: mpu6050-dev1
>
> And when you want to use it to read periodically from
> your magnetometer like this:
>
> > iio_generic_buffer -a -c 100 -n hscdtd008a -t mpu6050-dev1
>
> Then the following happens:
>
> [  209.951334] Internal error: Oops: 5 [#1] SMP ARM
> (...)
> [  209.981969] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
> [  209.988925] PC is at inv_scan_query_mpu6050+0x8/0xb8
> [  209.993914] LR is at inv_mpu6050_set_enable+0x40/0x194
>
> This is because since we are not using any channels from the
> same device, the indio_dev->active_scan_mask is NULL.
>
> Just checking for that and bailing out is however not enough:
> we have to enable some kind of FIFO for the readout to work.
> So enable the temperature as a dummy FIFO and all works
> fine.

Fixes tag?

> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index f7b5a70be30f..6946d50b874a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -11,6 +11,17 @@ static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
>         struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>         unsigned int mask;
>
> +       /*
> +        * If the MPU6050 is just used as a trigger, then the scan mask
> +        * is not allocated so we simply enable the temperature channel
> +        * as a dummy and bail out.
> +        */
> +       if (!indio_dev->active_scan_mask) {
> +               st->chip_config.temp_fifo_enable = true;

> +               mask = INV_MPU6050_SENSOR_TEMP;
> +               return mask;

A nit-pick:
return INV...;

> +       }
> +
>         st->chip_config.gyro_fifo_enable =
>                 test_bit(INV_MPU6050_SCAN_GYRO_X,
>                          indio_dev->active_scan_mask) ||
> --
> 2.29.2
>


-- 
With Best Regards,
Andy Shevchenko
