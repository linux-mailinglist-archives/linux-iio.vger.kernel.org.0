Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB73BC1A9
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 08:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440516AbfIXGSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 02:18:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39737 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbfIXGSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 02:18:13 -0400
Received: by mail-yw1-f67.google.com with SMTP id n11so238813ywn.6
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2019 23:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3G5X7xVQ9z26a9D0p2+J0HqtOzGnuzMJPu51RAv6up0=;
        b=iiRVMU9JjH7vBpMIN8KVNLbiMGlX0pkZg1y9/Tz6a3oOEwmUVSfXtaQCKKO5/CdLQe
         zNHhcrYVabeQA8vdXsP7cLh8NPvXjM3nIcwXavXeuLATwZIYqB2Nt+xqxYfS8nqe/0KB
         kdT9EpjLT3bIYQlxQYBuD1Qp51lLkrRztglqLdNhisXmwbOWES+9tjNqVIEDp2ZoEP7l
         wSrcAZWEy2x3I4v7HR7D2/3HTG4NzyqGXC+RYuCRzg5AX6QllZ06cg8VzgCnr8ay1nn5
         N/qW40dk6nwa2kaVCziO+pbVussxQgefuQ0hqhGdieZus/Si3WsGsLJaRhbQiVrImx2U
         1HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3G5X7xVQ9z26a9D0p2+J0HqtOzGnuzMJPu51RAv6up0=;
        b=AP+m33usqv66QPT1bJuO9J6StuTTpsbnJiHPikoI+BKJY8aIF0b7X5dGhVZRWaWCqM
         OBUR2plQMcOnk8kpBWcY1C18R/iLpijvE0PFGGU4yHpPioKiEZX0A3ucUWu52ehjlmA6
         Mo3ha03UqVAMKzC6JmGid3L3RTNO/uW/hnHGvgieyercbThyu77/tjUYJlz2B/puOHa4
         ZXykK5I8U8GswZG/FVxA7nQlkUSJoa5PAQOTSPmul7404LiAKS8N5WhNC1t/Bz5E8SiG
         icQ9qPx3dLpQDJPAnjpjajhm3dxLwTopeioBqkkaApisVCu6zEYb20xxm8yeOTX3ImjW
         hrmQ==
X-Gm-Message-State: APjAAAWCk/pi4mfSOCjzpwpc8SlrvHSEWb7piDIWbEHjvd67073iNHrX
        dpmEbdyuWT8aaEvdGAHsXjnw+YTJB7JFM1vnEE7ui57p
X-Google-Smtp-Source: APXvYqy9Z3YeU2jFG6tVCYwhtDb2tjueILprRTR0FfOWGhACEvSUlRr+vKCs1MNCOrLYu9T6waSvlGJo+bX6PLA7W6U=
X-Received: by 2002:a81:a405:: with SMTP id b5mr758142ywh.2.1569305892745;
 Mon, 23 Sep 2019 23:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
 <20190920064214.GA31900@lore-desk-wlan.lan> <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
 <20190920215542.GA16493@localhost.localdomain> <CALAE=UBH8ESTkXzrzK2_Tvt-vzVeOiewJFi_g4g2NsoUqwge1w@mail.gmail.com>
 <20190921080651.GA15821@localhost.localdomain> <CALAE=UBjNKZy=kuGDCuwEQ_-jSY==Bc7_1R9w_gaNmuW_23UqQ@mail.gmail.com>
In-Reply-To: <CALAE=UBjNKZy=kuGDCuwEQ_-jSY==Bc7_1R9w_gaNmuW_23UqQ@mail.gmail.com>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Tue, 24 Sep 2019 08:18:01 +0200
Message-ID: <CAA2SeNK1qcdxqrK0S4EE0JUmAQYLmFE5JbdeiJHRAhGjJ-qzxg@mail.gmail.com>
Subject: Re: LSM9DS1 testing with st_lsm6dsx driver
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> > > > > > LSM9DS1 does not support hw FIFO for the moment. Are you trying to enable
> > > > > > buffered reading?
> > > > >
> > > > > I am not manually interacting with the device at all when this
> > > > > exception occurs. This happens during the driver probe.
> > > > >
> > > > > > Could you please try if the following patch helps? (just compiled)
> > > > >
> > > > > I no longer receive the exception with this patch and it makes sense, thanks.
> > > >
> > > > Hi Bobby,
> > > >
> > > > thx a lot for testing. Could you please try to drop the previous patch and
> > > > apply the following one? Does it fix the issue as well?
> > >
> > > No problem, happy to help. I just tested, and unfortunately the issue
> > > is still present with this patch.
> >
> > re-looking at the code this patch will actually does not anything since in the
> > current implementation st_lsm6dsx_handler_irq will return IRQ_NONE and the
> > thread handler will not be run. Anyway since st_lsm6dsx_handler_irq will be
> > removed soon I will respin this patch ontop of Sean series.
> >
> > > I gave the datasheet and the hardware reference manual of the
> > > connected CPU a closer look and suspected a problem with my pin
> > > config. However even after various combinations of pull ups/downs and
> > > IRQ_TYPE_LEVEL_LOW/IRQ_TYPE_LEVEL_HIGH the same exception occurs, so I
> > > don't think that there's an issue with pin config stopping the
> > > interrupt line from being deasserted.
> >
> > are you able to monitor the line activity through an oscilloscope?
> > The issue is the irq line is never asserted and the kernel complains about
> > lot of interrupts not managed
> >
> > Looking at the datasheet, LSM9DS1 does not support IRQ_TYPE_LEVEL_LOW.
> > ST_LSM6DSX_REG_HLACTIVE_ADDR and ST_LSM6DSX_REG_PP_OD_ADDR registers are
> > actually not defined for LSM9DS1 and I will move them in hw_settings map.
>
> The datasheet I have for the LSM9DS1 shows a HLACTIVE bit in the
> CTRL_REG8 (0x22) register, I thought that indicated support for both
> high and low IRQ types.

Yes, right. I will update the series. Looking at the datasheet even
the BDU register definition seems wrong. I will fix it as well.

> Either way, after applying your recent (Sep 22nd) patches to this
> driver and changing my device tree node I have no kernel exception and
> the iio device enumerates as normal. For anyone curious my device tree
> node is now:
>

What happen if you set the irq line active high? Does the issue occur?

Regards,
Lorenzo

> lsm9ds1_ag@6a {
>   compatible = "st,lsm9ds1-imu";
>   reg = <0x6a>;
>   st,drdy-int-pin = <1>;
>   pinctrl-names = "default";
>   pinctrl-0 = <&pinctrl_acc_gyro>;
>   interrupt-parent = <&gpio7>;
>   interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> };
>
> >
> > @Jonathan: do you prefer this patch to be ontop of Sean's series?
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > >
> > > > iio: imu: st_lsm6dsx: check read_fifo pointer in st_lsm6dsx_handler_thread
> > > >
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > index b0f3da1976e4..f4fd4842bd79 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > @@ -666,6 +666,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> > > >         struct st_lsm6dsx_hw *hw = private;
> > > >         int count;
> > > >
> > > > +       if (!hw->settings->fifo_ops.read_fifo)
> > > > +               return IRQ_NONE;
> > > > +
> > > >         mutex_lock(&hw->fifo_lock);
> > > >         count = hw->settings->fifo_ops.read_fifo(hw);
> > > >         mutex_unlock(&hw->fifo_lock);
> > > > --
> > > > 2.21.0
> > > >
> > > > >
> > > > > For context I'm working with a board that has every data ready and
> > > > > interrupt signal connected to the LSM9DS1. Could you clarify what the
> > > > > proper usage of the "st,drdy-int-pin" would be in this case and
> > > > > whether or not I need more than one interrupt called out in my device
> > > > > tree node?
> > > > > I'm not really understanding how they're currently being utilized for
> > > > > this device in the driver.
> > > >
> > > > For the moment irq line in lsm9ds1 (acc/gyro) is not used at all,
> > > > so you can omit the "st,drdy-int-pin" property
> > > >
> > > > >
> > > > > Also, I know support for this device was added recently and the combo
> > > > > device hardware FIFO is complex, but is support for this something
> > > > > that's currently being worked on?
> > > >
> > > > It is actually in my ToDo list but I have no this device at the moment, so
> > > > patches are welcome :)
> > > >
> > > > Regards,
> > > > Lorenzo
> > > >
> > > > >
> > > > > Thanks,
> > > > > Bobby Jones
> > > > >
> > > > > > Regards,
> > > > > > Lorenzo
> > > > > >
> > > > > > iio: imu: st_lsm6dsx: do not configure the fifo if not supported
> > > > > >
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > index b65a6ca775e0..90a0e5ce44e5 100644
> > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > @@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> > > > > >                         return err;
> > > > > >         }
> > > > > >
> > > > > > -       if (hw->irq > 0) {
> > > > > > +       if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
> > > > > >                 err = st_lsm6dsx_fifo_setup(hw);
> > > > > >                 if (err < 0)
> > > > > >                         return err;
> > > > > > --
> > > > > > 2.21.0
> > > > > >
> > > > > >
