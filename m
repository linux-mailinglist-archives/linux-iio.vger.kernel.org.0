Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4599FBBEF1
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 01:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfIWXXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 19:23:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36377 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIWXXc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 19:23:32 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so37808772iof.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2019 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miQgdg+Cic7f3QbqYHOcqqBSqzEBqukYJOkBJwkZFh8=;
        b=bD81h+xgpGtgySboQdhw1i0Qqe7VzzKOhwijd6y4IMUWAYA7TM2W3BiU5W0Hg1SLAq
         yBF8KaA7P28k98Flm1HsvTo1hZLlRJlzjoF0w/HhfnVmSQ4tk6y293cP7vFI1CYW7G+c
         sDiqb+jzcXfHyFzfzs3SxcnVmO+155u8dwqxIE5/WgjpstpUJlgcrAsqyrr/PATYqJsc
         oGG9JT/nGV0rwgpeMVd739H74Q2SazWltXzkPUEhZJq5kKqVvaxMca0Ubjm16VqrpZsX
         TVP26QJRGDPGeF8+ZNqOEYHYx21L1e8Al9By3YUuKwLpHH+0MOo/iF6Mz6cg6v/myKJo
         pxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miQgdg+Cic7f3QbqYHOcqqBSqzEBqukYJOkBJwkZFh8=;
        b=CMy3AyWTPkOwWLQs4a2Vydy5Q+Q6a6DhX7lIYA9O3DTbLJrpIMC2huO6cXQxPVjeXC
         E9JHwyBGn94zUQFv+bdHLMGWmKTDANoLgr31OYOZHb70XDd59q08mRsFxinmHJEVL7BT
         5+jaIvZ2AymnRi3mxXz9jeo5p9Y2Luc7C/zW8roJr5/r0GWUkPMXGRAEMdhcNqrXwJOA
         YCiUCH61j7UqkKdMQ49PLy0F1+UygikWXUIpe/2j3t3kdTX7MFUEoMGZVxSL5O38WjZj
         GnYk+ps/ZT3jlc7jRwguIB4h3RNhkONT6m7gmy8LzSt33fHxERd39iPBHdOhjCcBtoJr
         Z46Q==
X-Gm-Message-State: APjAAAWW7I2cqLhGU2N3Jvsw8kn6xhAZtG91XBV9PguvNmSaSQ7BsV+V
        Okob+GY8oai+RsW5ql0B3ppUx1j+ARCBuVkQHoye6A==
X-Google-Smtp-Source: APXvYqxNpKPGaaMBTDDFW9HcGZJ9t68YgIN54d8W2LvGxJ0VX5vOJNKxKo766lDSyJm8WJH4EQdUYSmstM0/a6Q/8g4=
X-Received: by 2002:a5e:960a:: with SMTP id a10mr1408388ioq.211.1569281010705;
 Mon, 23 Sep 2019 16:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
 <20190920064214.GA31900@lore-desk-wlan.lan> <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
 <20190920215542.GA16493@localhost.localdomain> <CALAE=UBH8ESTkXzrzK2_Tvt-vzVeOiewJFi_g4g2NsoUqwge1w@mail.gmail.com>
 <20190921080651.GA15821@localhost.localdomain>
In-Reply-To: <20190921080651.GA15821@localhost.localdomain>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 23 Sep 2019 16:23:19 -0700
Message-ID: <CALAE=UBjNKZy=kuGDCuwEQ_-jSY==Bc7_1R9w_gaNmuW_23UqQ@mail.gmail.com>
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

> > > > > LSM9DS1 does not support hw FIFO for the moment. Are you trying to enable
> > > > > buffered reading?
> > > >
> > > > I am not manually interacting with the device at all when this
> > > > exception occurs. This happens during the driver probe.
> > > >
> > > > > Could you please try if the following patch helps? (just compiled)
> > > >
> > > > I no longer receive the exception with this patch and it makes sense, thanks.
> > >
> > > Hi Bobby,
> > >
> > > thx a lot for testing. Could you please try to drop the previous patch and
> > > apply the following one? Does it fix the issue as well?
> >
> > No problem, happy to help. I just tested, and unfortunately the issue
> > is still present with this patch.
>
> re-looking at the code this patch will actually does not anything since in the
> current implementation st_lsm6dsx_handler_irq will return IRQ_NONE and the
> thread handler will not be run. Anyway since st_lsm6dsx_handler_irq will be
> removed soon I will respin this patch ontop of Sean series.
>
> > I gave the datasheet and the hardware reference manual of the
> > connected CPU a closer look and suspected a problem with my pin
> > config. However even after various combinations of pull ups/downs and
> > IRQ_TYPE_LEVEL_LOW/IRQ_TYPE_LEVEL_HIGH the same exception occurs, so I
> > don't think that there's an issue with pin config stopping the
> > interrupt line from being deasserted.
>
> are you able to monitor the line activity through an oscilloscope?
> The issue is the irq line is never asserted and the kernel complains about
> lot of interrupts not managed
>
> Looking at the datasheet, LSM9DS1 does not support IRQ_TYPE_LEVEL_LOW.
> ST_LSM6DSX_REG_HLACTIVE_ADDR and ST_LSM6DSX_REG_PP_OD_ADDR registers are
> actually not defined for LSM9DS1 and I will move them in hw_settings map.

The datasheet I have for the LSM9DS1 shows a HLACTIVE bit in the
CTRL_REG8 (0x22) register, I thought that indicated support for both
high and low IRQ types.
Either way, after applying your recent (Sep 22nd) patches to this
driver and changing my device tree node I have no kernel exception and
the iio device enumerates as normal. For anyone curious my device tree
node is now:

lsm9ds1_ag@6a {
  compatible = "st,lsm9ds1-imu";
  reg = <0x6a>;
  st,drdy-int-pin = <1>;
  pinctrl-names = "default";
  pinctrl-0 = <&pinctrl_acc_gyro>;
  interrupt-parent = <&gpio7>;
  interrupts = <13 IRQ_TYPE_EDGE_RISING>;
};

>
> @Jonathan: do you prefer this patch to be ontop of Sean's series?
>
> Regards,
> Lorenzo
>
> >
> > >
> > > iio: imu: st_lsm6dsx: check read_fifo pointer in st_lsm6dsx_handler_thread
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index b0f3da1976e4..f4fd4842bd79 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -666,6 +666,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> > >         struct st_lsm6dsx_hw *hw = private;
> > >         int count;
> > >
> > > +       if (!hw->settings->fifo_ops.read_fifo)
> > > +               return IRQ_NONE;
> > > +
> > >         mutex_lock(&hw->fifo_lock);
> > >         count = hw->settings->fifo_ops.read_fifo(hw);
> > >         mutex_unlock(&hw->fifo_lock);
> > > --
> > > 2.21.0
> > >
> > > >
> > > > For context I'm working with a board that has every data ready and
> > > > interrupt signal connected to the LSM9DS1. Could you clarify what the
> > > > proper usage of the "st,drdy-int-pin" would be in this case and
> > > > whether or not I need more than one interrupt called out in my device
> > > > tree node?
> > > > I'm not really understanding how they're currently being utilized for
> > > > this device in the driver.
> > >
> > > For the moment irq line in lsm9ds1 (acc/gyro) is not used at all,
> > > so you can omit the "st,drdy-int-pin" property
> > >
> > > >
> > > > Also, I know support for this device was added recently and the combo
> > > > device hardware FIFO is complex, but is support for this something
> > > > that's currently being worked on?
> > >
> > > It is actually in my ToDo list but I have no this device at the moment, so
> > > patches are welcome :)
> > >
> > > Regards,
> > > Lorenzo
> > >
> > > >
> > > > Thanks,
> > > > Bobby Jones
> > > >
> > > > > Regards,
> > > > > Lorenzo
> > > > >
> > > > > iio: imu: st_lsm6dsx: do not configure the fifo if not supported
> > > > >
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > index b65a6ca775e0..90a0e5ce44e5 100644
> > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > @@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> > > > >                         return err;
> > > > >         }
> > > > >
> > > > > -       if (hw->irq > 0) {
> > > > > +       if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
> > > > >                 err = st_lsm6dsx_fifo_setup(hw);
> > > > >                 if (err < 0)
> > > > >                         return err;
> > > > > --
> > > > > 2.21.0
> > > > >
> > > > >
