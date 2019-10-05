Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2064ACC9F4
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfJEMbU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 08:31:20 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33913 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfJEMbU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2019 08:31:20 -0400
Received: by mail-yb1-f194.google.com with SMTP id m1so3068648ybm.1
        for <linux-iio@vger.kernel.org>; Sat, 05 Oct 2019 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcxqBFqVIz03do1en2ICaHVgonRCRzwg/Cdjw6qbtSU=;
        b=Hv+BZPcNX5N9zf/BtCP6s3EWzlw8XZwxU5Hab2Zc7V5VMdER/m12nEewY5wDLF6eCN
         NLBKdf5lNCxccL6dskH59njf2utz+oeQ+ZCfxIl3QgJFOzzyUuz1++jLFuqpNhJbdUxl
         Eye9pIhZgHkCDNMfhxTQpQBqg6TFJos8s1Ku9f8Pqz6g2zMmC+qyYfMfNKswa4cvveOC
         GbR7dVSm1A1k5f03Lveqaqjq/TlTYp/PeGTZMZwQ3+r0lGJ4oGMIjx6qYkNyrJVcqufS
         hdr+ZhO0xiR7RH7Jbe4oHGw89dNoCclR0WF/hUDuOeOsGfpXpgdhHffWpD9TvWA5fEJO
         hjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcxqBFqVIz03do1en2ICaHVgonRCRzwg/Cdjw6qbtSU=;
        b=tm+PYhwlwlwTu0UhuFJJN0JPemU11VSYQ0jYhfJQD4z5L6Gj5YF84hyLt+2amLb/KR
         /PiMdutjsF9MJ87f7ZimhyJ2GvHi80b+HXXpzvfRSnJAVznpLJErUKjlArDddkt3pBs5
         rV+zyD41CYx2sAC4O09Zoyg5PO78s0tcpwt76Estm2NxEIcAlqv1AQZrT2CVscNYgVKo
         KBGWTgh0VC+4Y7dQ7O8DaZnU/QrWlivrjaR7HCg9vjm9xofThhIDPNPwQvtg6D4L9VKf
         4cP+3QFn3Y0QtAaOKhS+8iqIEJX3QNcHakVZx8cHH8MLlCa99nSBPVTd1P9F8GoKVTyH
         IXEg==
X-Gm-Message-State: APjAAAUb8/An1tux1bpzIw3qp7Zs325Z/e+NORZe1fjMQrPXQEeqoz49
        Ki8TGXU1g/LCE4i4wsY3wDns1oU8Dhvxj/wpRmE=
X-Google-Smtp-Source: APXvYqwGTg/mNTigVoLo4b/mC2v5xvkm3dygbeDWqJLiPcyTepQvIe0oEfwG7jHQR2zBdLjnpvAjDZVOuU3EXXpnEu4=
X-Received: by 2002:a25:d92:: with SMTP id 140mr5362791ybn.322.1570278678738;
 Sat, 05 Oct 2019 05:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
 <20190920064214.GA31900@lore-desk-wlan.lan> <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
 <20190920215542.GA16493@localhost.localdomain> <CALAE=UBH8ESTkXzrzK2_Tvt-vzVeOiewJFi_g4g2NsoUqwge1w@mail.gmail.com>
 <20190921080651.GA15821@localhost.localdomain> <CALAE=UBjNKZy=kuGDCuwEQ_-jSY==Bc7_1R9w_gaNmuW_23UqQ@mail.gmail.com>
 <CAA2SeNK1qcdxqrK0S4EE0JUmAQYLmFE5JbdeiJHRAhGjJ-qzxg@mail.gmail.com>
 <CALAE=UCEODBsUJB8Fb0z=jw2c-XqkR6D9wrX00KHn3GSu8Li-g@mail.gmail.com>
 <CAA2SeNKO0rH07bYnd_CqsKjArJ+ZqUQ3WCf-07rAOD7N4JBjUA@mail.gmail.com>
 <CALAE=UCOXgNJQa1+KwLGO01v+JvdtrM=GGMDgV14EZTBh0ox=Q@mail.gmail.com>
 <CAA2SeN+QR5sd_WrjOxiPx0JY7fK3W0wenP_RzxfrP9isk9wCXQ@mail.gmail.com> <20191005122207.5979efd2@archlinux>
In-Reply-To: <20191005122207.5979efd2@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Sat, 5 Oct 2019 14:31:07 +0200
Message-ID: <CAA2SeNLb+smChOMQkqNZVUMPQLio74aGtHpp+4k=0oguf7YdjA@mail.gmail.com>
Subject: Re: LSM9DS1 testing with st_lsm6dsx driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bobby Jones <rjones@gateworks.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> > @Jonathan: how do you prefer to proceed? Push just this patch to
> > 'togreg' branch and rebase the other fixes ontop of Sean's series or
> > merge all the fixes now? (they will conflict with Sean's series)
> Assuming I don't find any issues in Sean's latest, I'll apply that
> first.  Then we put this on top but also look at a backport fix
> to get this into stable after the next merge window.

Ack, please hold on with this series since I want to post a new one
fixing missing bits for lsm9ds1.
I will rebase it ontop of Sean's series

Regards,
Lorenzo

>
> It's always tricky to deal with these cases when a driver is
> in a state of fairly rapid change.
>
> I'll take a proper look at patch 3 if that is the only one
> 'necessary'.  It looks small so we might just push the fix
> along side Sean's patch and let everyone concerned know that
> a merge conflict is expected by trivial.

Yes, patch 3/3 is the only one necessary to fix the issue.

>
> Thanks,
>
> Jonathan
>
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > Thanks,
> > > Bobby Jones
> > >
> > > >
> > > > Regards,
> > > > Lorenzo
> > > >
> > > > >
> > > > > Thanks,
> > > > > Bobby Jones
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Lorenzo
> > > > > >
> > > > > > > lsm9ds1_ag@6a {
> > > > > > >   compatible = "st,lsm9ds1-imu";
> > > > > > >   reg = <0x6a>;
> > > > > > >   st,drdy-int-pin = <1>;
> > > > > > >   pinctrl-names = "default";
> > > > > > >   pinctrl-0 = <&pinctrl_acc_gyro>;
> > > > > > >   interrupt-parent = <&gpio7>;
> > > > > > >   interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> > > > > > > };
> > > > > > >
> > > > > > > >
> > > > > > > > @Jonathan: do you prefer this patch to be ontop of Sean's series?
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Lorenzo
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > iio: imu: st_lsm6dsx: check read_fifo pointer in st_lsm6dsx_handler_thread
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
> > > > > > > > > >  1 file changed, 3 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > > > > > > > index b0f3da1976e4..f4fd4842bd79 100644
> > > > > > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > > > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > > > > > > > @@ -666,6 +666,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> > > > > > > > > >         struct st_lsm6dsx_hw *hw = private;
> > > > > > > > > >         int count;
> > > > > > > > > >
> > > > > > > > > > +       if (!hw->settings->fifo_ops.read_fifo)
> > > > > > > > > > +               return IRQ_NONE;
> > > > > > > > > > +
> > > > > > > > > >         mutex_lock(&hw->fifo_lock);
> > > > > > > > > >         count = hw->settings->fifo_ops.read_fifo(hw);
> > > > > > > > > >         mutex_unlock(&hw->fifo_lock);
> > > > > > > > > > --
> > > > > > > > > > 2.21.0
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > For context I'm working with a board that has every data ready and
> > > > > > > > > > > interrupt signal connected to the LSM9DS1. Could you clarify what the
> > > > > > > > > > > proper usage of the "st,drdy-int-pin" would be in this case and
> > > > > > > > > > > whether or not I need more than one interrupt called out in my device
> > > > > > > > > > > tree node?
> > > > > > > > > > > I'm not really understanding how they're currently being utilized for
> > > > > > > > > > > this device in the driver.
> > > > > > > > > >
> > > > > > > > > > For the moment irq line in lsm9ds1 (acc/gyro) is not used at all,
> > > > > > > > > > so you can omit the "st,drdy-int-pin" property
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Also, I know support for this device was added recently and the combo
> > > > > > > > > > > device hardware FIFO is complex, but is support for this something
> > > > > > > > > > > that's currently being worked on?
> > > > > > > > > >
> > > > > > > > > > It is actually in my ToDo list but I have no this device at the moment, so
> > > > > > > > > > patches are welcome :)
> > > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Lorenzo
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Bobby Jones
> > > > > > > > > > >
> > > > > > > > > > > > Regards,
> > > > > > > > > > > > Lorenzo
> > > > > > > > > > > >
> > > > > > > > > > > > iio: imu: st_lsm6dsx: do not configure the fifo if not supported
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> > > > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > > > > index b65a6ca775e0..90a0e5ce44e5 100644
> > > > > > > > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > > > > @@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> > > > > > > > > > > >                         return err;
> > > > > > > > > > > >         }
> > > > > > > > > > > >
> > > > > > > > > > > > -       if (hw->irq > 0) {
> > > > > > > > > > > > +       if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
> > > > > > > > > > > >                 err = st_lsm6dsx_fifo_setup(hw);
> > > > > > > > > > > >                 if (err < 0)
> > > > > > > > > > > >                         return err;
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.21.0
> > > > > > > > > > > >
> > > > > > > > > > > >
> >
> >
> >
>


-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
