Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94352917FD
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgJRPGm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRPGm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 11:06:42 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEABC061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 08:06:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 67so9965566iob.8
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czqkN2JOMIdx3mElJVahK+RV1sW2EcADLO8fEOnd2gY=;
        b=mOxpLHHYKQ/9MAts3WpueP7YGC5Tun1HFH3VKXZgKDwJK1H36gxsO4ubHorxcqk1oc
         pbE0aAnvFYngbcN/jByjxx71P5QnOjcvW22dCVU6o6w29DPkIDCqXu9LnrnfVI0CfHzo
         ThxPLd4aZ1zjFG/yqPXPDnWfAaG/Ulrt1Gy6syHznLnTjHI/13M+JDsaKOvSD8bg5qXL
         /OhfNQjW1bDxLB5n4MS74dYPqSeKtcRTqoMi2WF2wTTv63C2mMk4OwZP9h1G96rfxq77
         lxQCWZLyPrUzkz11xv1d5gQNJTW/CFhZr8IDTxmVyC15fdjWpAx2qHmouOgHLoyDY18L
         Qm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czqkN2JOMIdx3mElJVahK+RV1sW2EcADLO8fEOnd2gY=;
        b=JMa2KC30KnPO4mNAyFNbQ/kKxpOd7tNyppa6rGxhknKb4lF+qVae08Y5882MkWNbrJ
         pYaSV8K1lFczB2EQSiTUfqBG9TtYkEM3IFBwfHFQSsiXpfKwRDM8r2Baq9Ol2BNZ/Mwn
         U4eRUas0kJHai3vQjl6/3Ce/vYNzLJkqGjN3CHXjXGhqLehzmmfAqFcKbK/U5KbvGYqM
         /XeXrfSmWvTAC+JTERD+v2Hec22dWdKLx/oJQrtPvUUjUJMuybl5FKuEXE3MinGzCNxM
         491PuWPPG9f8Bvu9z7jtn+R46CTr53PZVbaWi+M6FB9WIJu7BY/WMC5sT+hGQ1q4VuB4
         Rg+Q==
X-Gm-Message-State: AOAM532k2Wb2CV+nAf7ISCZNYUpMVBe1XmJNQzK2vsExWDTS+09cllLB
        KRwbIUfTlVVSOwqkS5AWX9oLo7AP2CCVheaHQ+ru
X-Google-Smtp-Source: ABdhPJxTmtCnVTbI2p+LMLIuIbMjWoDpTYT8mP5zpcvmq/R2e4Cp3/i29Cz0eVW2BcFfRfCP2mOKgFfx3h9Yw2dcZO4=
X-Received: by 2002:a6b:b208:: with SMTP id b8mr8121415iof.36.1603033601269;
 Sun, 18 Oct 2020 08:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201018033602.GA27912@ubuntu> <20201018123651.635e2ec3@archlinux>
In-Reply-To: <20201018123651.635e2ec3@archlinux>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Sun, 18 Oct 2020 20:36:30 +0530
Message-ID: <CALudOK425LJXphTA1RH7A45=5=m5S-7r-5xpeanjpwzFBUMXTg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: vcnl4035 add i2c_device_id
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 5:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 18 Oct 2020 09:06:02 +0530
> Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> > add i2c_device_id for the vcnl4035 driver so that
> > the device can be instantiated using i2c_new_client_device
> > or from userspace, useful in cases where device tree based
> > description is not possible now(Eg. a device on a gbphy i2c
> > adapter created by greybus)
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Rewrite the description and this should be fine.
>
> Thanks,
>
> Jonathan
>
Thank you Jonathan for the Review, I have submitted v3 patch
with the modified description: https://lore.kernel.org/patchwork/patch/1322195/

Thanks,
Vaishnav
> > ---
> >  v2:
> >       - fix commit message
> >  drivers/iio/light/vcnl4035.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> > index 765c44adac57..73a28e30dddc 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -652,6 +652,12 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
> >                          vcnl4035_runtime_resume, NULL)
> >  };
> >
> > +static const struct i2c_device_id vcnl4035_id[] = {
> > +     { "vcnl4035", 0},
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
> > +
> >  static const struct of_device_id vcnl4035_of_match[] = {
> >       { .compatible = "vishay,vcnl4035", },
> >       { }
> > @@ -666,6 +672,7 @@ static struct i2c_driver vcnl4035_driver = {
> >       },
> >       .probe  = vcnl4035_probe,
> >       .remove = vcnl4035_remove,
> > +     .id_table = vcnl4035_id,
> >  };
> >
> >  module_i2c_driver(vcnl4035_driver);
>
