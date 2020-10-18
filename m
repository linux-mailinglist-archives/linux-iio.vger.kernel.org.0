Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140BF291808
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgJRPXt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 11:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgJRPXs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 11:23:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F90C061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 08:23:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k25so10032487ioh.7
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pq2cCgFfAlIaF+/VLMFX1e8QfeRpmNnZdqE+CnQe2SU=;
        b=tAvpFy7jIz1zxAY+hqkFJfB9toH6vNuqj5d/iV4hRsqTj/0uFUS2gnCy3kDMjep0ds
         BTmvjlrELM6fnN+AN8oFVbxrQ1hyyfx80GfW2s4JkPEB+pgufvh08EljOHAzikUaNztR
         xWvwM/9RBa/tDEbsSk0LXJwlu3nMUXDFV5zz/kk74FRYX9HzVB1abIm/U1PxYmvPZ7sZ
         RNBvhoIWxSU1Z6i0Qdcu5xqgm70dusZWNq+UhiIlA3aX0t6BO0Xhh+th6za2ClJVJDHa
         1ljYJl3lO5NbhVlmm5sRkxPX9LAX6wyv8qi0sVFePSccloH63lxy8EOJSFzMOkgIpD9M
         312w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pq2cCgFfAlIaF+/VLMFX1e8QfeRpmNnZdqE+CnQe2SU=;
        b=FqJRSG/ZLa3dWJNQM1WJ4kkOSd2PCQynQls0/cmheXytF21pzZBOqsT+0XZ0K/W0Ey
         Mv+QXOxPJvGFPQWxCl30ZNp9qBT3Rs6vMAGcxKvKJ4P1J6H1zUxCwNAzouspFK5hvilH
         vftV3rbRyajP1M9eatKNJvTM807hb2s9+FADKLV8gQv8xkZSkGgiK+suHs3q29GmrLo2
         fov14exXQ9ev/v6NoTg4OFN9sKWnAAhCO5VcxZjzFY4Yg/oUT1BKHOaNxuaiPYLnxbzY
         fhoOuc0KrsXbIOmtKOT6x+wjhW+/uzwEOoFUpzRO6UDGZThdjlIFak+TZE4UkjIAZR79
         h5og==
X-Gm-Message-State: AOAM530BRe31u+rY29tTnGwyl/jRD5DNzIQgt2XAhWnZm71ZlM04iiPU
        y7u3C0fL33mvwThx6IBQTSis0uHihCAgX9T9dHSi
X-Google-Smtp-Source: ABdhPJzDh2HYF2MkopPq0IP02CbEU1LreS/yV9unO6dAXxEl63mPEr/hOTpksUJUZANJitN9TUp/dh/RfdD4Ppuh2rA=
X-Received: by 2002:a6b:9108:: with SMTP id t8mr846700iod.206.1603034627798;
 Sun, 18 Oct 2020 08:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201018033142.GA27793@ubuntu> <20201018123334.5a8bb5ac@archlinux>
In-Reply-To: <20201018123334.5a8bb5ac@archlinux>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Sun, 18 Oct 2020 20:53:36 +0530
Message-ID: <CALudOK5KOgPy6wfi7nsXSgEtNsjaFy6faf_wqL_2TxJJZKugmw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: vl53l0x-i2c add i2c_device_id
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     songqiang1304521@gmail.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 5:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 18 Oct 2020 09:01:42 +0530
> Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> > add i2c_device_id for the vl53l0x-i2c driver so
> > that the device can be instantiated using i2c_new_client_device
> > or from userspace, useful in cases where device tree based description
> > is not possible now(Eg. a device on a gbphy i2c
> > adapter created by greybus).
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
>
> Please fix the description as mentioned in other patches.
>
Thank you Jonathan for your review, I have sent a v3 patch with fixed
description : https://lore.kernel.org/patchwork/patch/1322196/
understand your concern about the redundant device_id(s), it will be nice to see
of_match_table reused in such cases as you suggested.

> The code change is fine, but it does raise the question of whether we want to think
> about providing a means to register such devices using the of_match_table.
> It's somewhat irritating to need to provide both (I'd rather not
> just provide the non-dt version rely on the old hack that drops the
> vendor ID for matching).
>
> +CC Wolfram.
>
> > ---
> >  v2:
> >       - fix commit message
> >  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> > index 5fbda9475ba9..7c29d4cae24a 100644
> > --- a/drivers/iio/proximity/vl53l0x-i2c.c
> > +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> > @@ -143,6 +143,12 @@ static int vl53l0x_probe(struct i2c_client *client)
> >       return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> >
> > +static const struct i2c_device_id vl53l0x_id[] = {
> > +     { "vl53l0x", 0},
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
> > +
> >  static const struct of_device_id st_vl53l0x_dt_match[] = {
> >       { .compatible = "st,vl53l0x", },
> >       { }
> > @@ -155,6 +161,7 @@ static struct i2c_driver vl53l0x_driver = {
> >               .of_match_table = st_vl53l0x_dt_match,
> >       },
> >       .probe_new = vl53l0x_probe,
> > +     .id_table = vl53l0x_id,
> >  };
> >  module_i2c_driver(vl53l0x_driver);
> >
>
