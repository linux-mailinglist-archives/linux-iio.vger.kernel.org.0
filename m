Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF3B9A9C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 01:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436969AbfITXVo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 19:21:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45423 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437290AbfITXVn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 19:21:43 -0400
Received: by mail-io1-f66.google.com with SMTP id f12so19776619iog.12
        for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2019 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJ3/SBTiCzTKJbTWtct2A7DOVajFBGKVeDCzFW91zvw=;
        b=xUOrcsbSQBxG7CzqVCL66FdtwF3eBsuGpE4a7h7OC9m6BBkxT62nSCD6aHuIxZvwpd
         +Xtb7MiMOkCnn7JxQbwMVgHbOuLtnEKb1MSziYmiL4h8lVtl+qQ15TTgxgM47ScNauCc
         Dabgwf+KiVuj/zsnwOYSozLp76PuobF2NLF5P71+4PFD0GPaKXhXaNCLpDoJ36OTvYC9
         T9MSePEwQcDiiAMKkRnnspYl+FfyQTTCLaZ1GP8FPbzVkZETLkn+mIVSvf8A9hDsufkW
         GmZtFWfxc9oZODLwZ9jE1uQmwPxrN9vF9wA8f2p1mw6zsXCpPSVp6OH2ddaPefJtib6b
         60YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJ3/SBTiCzTKJbTWtct2A7DOVajFBGKVeDCzFW91zvw=;
        b=Avl4W2iv5bmID4hgpYsJdnt2iQsdNrlWDiQ+64J3346ft6wniSJUk+nYpjqPVqJxhk
         49Fd8DF89WexKitFVGTjG6dnLCZUXNTeGrSqDFldF7oomdTksxj/wD9lMmTkFoJzMc4x
         NwZSG3G7f1pnMVeV51qkiTURayzS6oErRJBJmxVsS9dFYOIGelc9KwwesiolZQjDeY4f
         GLsc85zeMVPuCs7NSZHqmxXyQrI5cl9/080y/0JSNoRuj8h6M/RedZkjK+7Ds6fXvgyO
         vEfJuwQhK808+/M6tfZlRMvogkIoP4+KdFEPLJNXSD9JNPyyzhw4dj9vmY9qjiKJlHHh
         qmgQ==
X-Gm-Message-State: APjAAAUWQPDrIw+RMNoTGnoTlTRUQg1Kmu4Z5Wood1QM4yo8AVWoEJID
        jErvknUTZpuxbldXTjF2QbcyvVBjh9SYOG/qvDSEcQ==
X-Google-Smtp-Source: APXvYqyvLJ4mJae6mx/cWIn03FKiMLnqs1yZuR7E32skFjwosAcy8dx3j75GMzANZgiVo3ic+zpog8PVlsTazBqjyes=
X-Received: by 2002:a5d:88c9:: with SMTP id i9mr14876758iol.269.1569021702455;
 Fri, 20 Sep 2019 16:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
 <20190920064214.GA31900@lore-desk-wlan.lan> <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
 <20190920215542.GA16493@localhost.localdomain>
In-Reply-To: <20190920215542.GA16493@localhost.localdomain>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Fri, 20 Sep 2019 16:21:31 -0700
Message-ID: <CALAE=UBH8ESTkXzrzK2_Tvt-vzVeOiewJFi_g4g2NsoUqwge1w@mail.gmail.com>
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

> > > LSM9DS1 does not support hw FIFO for the moment. Are you trying to enable
> > > buffered reading?
> >
> > I am not manually interacting with the device at all when this
> > exception occurs. This happens during the driver probe.
> >
> > > Could you please try if the following patch helps? (just compiled)
> >
> > I no longer receive the exception with this patch and it makes sense, thanks.
>
> Hi Bobby,
>
> thx a lot for testing. Could you please try to drop the previous patch and
> apply the following one? Does it fix the issue as well?

No problem, happy to help. I just tested, and unfortunately the issue
is still present with this patch.
I gave the datasheet and the hardware reference manual of the
connected CPU a closer look and suspected a problem with my pin
config. However even after various combinations of pull ups/downs and
IRQ_TYPE_LEVEL_LOW/IRQ_TYPE_LEVEL_HIGH the same exception occurs, so I
don't think that there's an issue with pin config stopping the
interrupt line from being deasserted.

>
> iio: imu: st_lsm6dsx: check read_fifo pointer in st_lsm6dsx_handler_thread
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index b0f3da1976e4..f4fd4842bd79 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -666,6 +666,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>         struct st_lsm6dsx_hw *hw = private;
>         int count;
>
> +       if (!hw->settings->fifo_ops.read_fifo)
> +               return IRQ_NONE;
> +
>         mutex_lock(&hw->fifo_lock);
>         count = hw->settings->fifo_ops.read_fifo(hw);
>         mutex_unlock(&hw->fifo_lock);
> --
> 2.21.0
>
> >
> > For context I'm working with a board that has every data ready and
> > interrupt signal connected to the LSM9DS1. Could you clarify what the
> > proper usage of the "st,drdy-int-pin" would be in this case and
> > whether or not I need more than one interrupt called out in my device
> > tree node?
> > I'm not really understanding how they're currently being utilized for
> > this device in the driver.
>
> For the moment irq line in lsm9ds1 (acc/gyro) is not used at all,
> so you can omit the "st,drdy-int-pin" property
>
> >
> > Also, I know support for this device was added recently and the combo
> > device hardware FIFO is complex, but is support for this something
> > that's currently being worked on?
>
> It is actually in my ToDo list but I have no this device at the moment, so
> patches are welcome :)
>
> Regards,
> Lorenzo
>
> >
> > Thanks,
> > Bobby Jones
> >
> > > Regards,
> > > Lorenzo
> > >
> > > iio: imu: st_lsm6dsx: do not configure the fifo if not supported
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index b65a6ca775e0..90a0e5ce44e5 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> > >                         return err;
> > >         }
> > >
> > > -       if (hw->irq > 0) {
> > > +       if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
> > >                 err = st_lsm6dsx_fifo_setup(hw);
> > >                 if (err < 0)
> > >                         return err;
> > > --
> > > 2.21.0
> > >
> > >
