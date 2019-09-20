Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04662B9751
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391785AbfITSjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 14:39:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34693 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbfITSjS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 14:39:18 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so18488259ion.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2019 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6tM6ZI/VrTh/MuBHV4W6Wb2qasNp6ASiozyxqkoV3M=;
        b=r5FnC65NuWii03YKxyrTM/1nERXunl3RMMjEXJmWzyDcXgq9EreaxUkt6yCK5FT3CE
         PGq9PixxgTi8RLJGyzeN1AaZ2dR/MBGPkmtxKgvJUrC0O5b2WowBQQp4VipVZmhTxJLJ
         iu2Yeoefaun6dblwBfiORqSQHQoMMUdSoIW32qtfE0hTvZT/loL8EAQbFux243TYj7V9
         bGUXNO2GpKixbvANYYsKCnaGV4CJD1577tH29NQ0plz7RfkE/pHLggLG5BmMUsugrybL
         Cg6AkCEEf3KVGVZq+zGZ7vcrr5ae21NIsrlc4Fn9LqpFDx1LKYefBlw+bnMRW5PuUioK
         mIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6tM6ZI/VrTh/MuBHV4W6Wb2qasNp6ASiozyxqkoV3M=;
        b=P/vnHZsfsaIcoMOo2utnPAvKPwYeugCepzvbq4Q9I+YzAdKYc6QbpELScaWt6T4xN2
         76EKFOYm05lxVsMyHhjMXumsMnVI8XoLrRtvYlgnHIUQoph5x7SDsuRjy8Whrw+WAOvg
         u+pjFeEZpmL83/m+0GzJNb27j/wmN70k8vTLl2o0pBMR3eYlJtsiJFs/uv0V5RLjsc2o
         u8QNZL9WjwHn1aIvzkIZOhM75Yfzsnblwmvl3ImWUZMSkwz7EAN4EyMAvCSgMIuI39aW
         WVkua9NvN3ojOJZua/w5LAVVOBD7hNs+wDx9q2z0SlGg17TDsFA4wOCy2ERHLzXCHGxA
         7OgA==
X-Gm-Message-State: APjAAAXE6UfUc740Ud72y+CHeS2gT2PUeMUnPcZIo8sNjFOSrp/IUM6l
        gGRzCMf2YzXfdCO38sCKRTi1Wm6jaJ8OzLMBvdOZyg==
X-Google-Smtp-Source: APXvYqywMjwz6vFHuGA26Q3QdHSMqPH/ULUnsa4Ywz79CBYBgf3BBKzUAdac9tmIKM/u9AwOb+Px/jWbsE8/3cdwGDg=
X-Received: by 2002:a02:7405:: with SMTP id o5mr21055127jac.44.1569004756616;
 Fri, 20 Sep 2019 11:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
 <20190920064214.GA31900@lore-desk-wlan.lan>
In-Reply-To: <20190920064214.GA31900@lore-desk-wlan.lan>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Fri, 20 Sep 2019 11:39:05 -0700
Message-ID: <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
Subject: Re: LSM9DS1 testing with st_lsm6dsx driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> LSM9DS1 does not support hw FIFO for the moment. Are you trying to enable
> buffered reading?

I am not manually interacting with the device at all when this
exception occurs. This happens during the driver probe.

> Could you please try if the following patch helps? (just compiled)

I no longer receive the exception with this patch and it makes sense, thanks.

For context I'm working with a board that has every data ready and
interrupt signal connected to the LSM9DS1. Could you clarify what the
proper usage of the "st,drdy-int-pin" would be in this case and
whether or not I need more than one interrupt called out in my device
tree node?
I'm not really understanding how they're currently being utilized for
this device in the driver.

Also, I know support for this device was added recently and the combo
device hardware FIFO is complex, but is support for this something
that's currently being worked on?

Thanks,
Bobby Jones

> Regards,
> Lorenzo
>
> iio: imu: st_lsm6dsx: do not configure the fifo if not supported
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index b65a6ca775e0..90a0e5ce44e5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>                         return err;
>         }
>
> -       if (hw->irq > 0) {
> +       if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
>                 err = st_lsm6dsx_fifo_setup(hw);
>                 if (err < 0)
>                         return err;
> --
> 2.21.0
>
>
