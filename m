Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5599A17D0B4
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 00:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgCGXzG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 18:55:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgCGXzF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 18:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583625304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dc043RWFY4xmq/cwqNSbTR5LvIqJywxBG2BrU2I0yEE=;
        b=XA5SPWPdFYpkVtrLnkrKUGarkksjAJaTFBUEUB8qJwMkXmOZ/w2qZj2f+L39lKI+gi7SgX
        LHtekS1d3uXus7Kf1zuGxtbu0hHjgEqByC6lNj1hY8T8SQKF6D+fVlUfblOj3x39yy6AGk
        Lqz0X3m/zOV9lulf0V88z698Vbwac60=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-6YyVK1MxNpCK8TrC8VVn3w-1; Sat, 07 Mar 2020 18:55:03 -0500
X-MC-Unique: 6YyVK1MxNpCK8TrC8VVn3w-1
Received: by mail-vk1-f197.google.com with SMTP id y5so2760385vkg.19
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2020 15:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dc043RWFY4xmq/cwqNSbTR5LvIqJywxBG2BrU2I0yEE=;
        b=cSSxq9Mt0C0x1KR+VreF301zAYyYRxdxtlLNkUuPtpBj1s2tAGf4MF4Q7jk3Rztauk
         H7w/Z7STT8Y50AbFL+aDlol0ClnrhOy3HBuliwZyCp15Ox1KbaJHUDCLqANk03IU23MS
         /EcLqbSvH+cGcomlcWLjHAeuywu3j0/XzbnxBLY+hUFrxfFK6KJ/e2KfiVQA848+CnZj
         1wgMvOP+EP6S+BbodLiXTd3DOl/oULxaKFSIgo9J0uTw2lls2ktNCV1ARdjcjpmsmuwZ
         +V4JNjlV93WnUQ8y5pWknFG1A2Afn0NENpnVrZOZFG2vQRXh+lNyj+pdrIGvC+zPCVv/
         F5bQ==
X-Gm-Message-State: ANhLgQ0Yqmm68kkmpAN9vaGadBFZV94J4i3cMy0XhoGm2WD23m/LPM3s
        nQZnR1HQVy8Bpdxc2sdJgoYRUr2yl/IJ+jrIAP9pZBQGXaMwxKQjErK9tIdlaH0LZks24KBzap9
        I8MfkEoEPMAln865xWDkXW3aySR6eQeTisDQD
X-Received: by 2002:a05:6102:a01:: with SMTP id t1mr5825630vsa.102.1583625302503;
        Sat, 07 Mar 2020 15:55:02 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvEi74Y3YsrPTgxOmsTb60HulZ1ZT4VZL2vT6i8gd+sP9pext4IeApU9/kNe5z/uae6Z8/IU6eWWL1BhGfST3Q=
X-Received: by 2002:a05:6102:a01:: with SMTP id t1mr5825622vsa.102.1583625302019;
 Sat, 07 Mar 2020 15:55:02 -0800 (PST)
MIME-Version: 1.0
References: <7444ee821dd9b1210ce126c317edc3b0c36f9f84.1583090369.git.lorenzo@kernel.org>
 <20200307130232.3baf4c89@archlinux> <CAJ0CqmWayoApMahU63UcqO-bEygYiTwzyAyOeaRi_0CRordKig@mail.gmail.com>
 <CH2PR12MB4216186A9417754287B06AAFAEE00@CH2PR12MB4216.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4216186A9417754287B06AAFAEE00@CH2PR12MB4216.namprd12.prod.outlook.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 8 Mar 2020 00:54:51 +0100
Message-ID: <CAJ0CqmVA5srd9yfoAfVmOKKfJj4FwL2Ue2dp0XUL0=bn_A_WWQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: disable I3C support during device reset
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mario.tesi@st.com" <mario.tesi@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> Hi,
>
> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> Date: Sat, Mar 07, 2020 at 13:33:43
>
> > >
> > > On Sun,  1 Mar 2020 20:28:03 +0100
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >
> > > > Disable MIPI I3C during device reset in order to avoid
> > > > possible races on interrupt line 1. If the first interrupt
> > > > line is asserted during hw reset the device will work in
> > > > I3C-only mode
> > > >
> > > > Reported-by: Mario Tesi <mario.tesi@st.com>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >
> > > Fixes tag?
> >
> > Hi Jonathan,
> >
> > I am not sure since Mario just reported me this issue can occur.
> > Maybe this one:
> >
> > 2660b0080bb2 ("iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO
> > and LSM6DSR")
> >
> > >
> > > One trivial thing inline.
> > >
> >
> > ack, I will fix it (I am use to network comment syntax now :))
> >
> > > Is this something we should be looking to have applied to stable?
> > >
> >
> > Not sure.
> > @Vitor: have you ever faced the issue?
>
> I use only with I3C mode active (INT1 pin connected to VDD_IO), I think
> this only apply when INT1 is not connected and I2C interface still
> active, right?
>

I think the issue occurs when the int1 is connected and it is high
during device reset.
If it occurs the sensor will work in I3C active mode even if it is
connected in I2C.

Regards,
Lorenzo

> >
> > Regards,
> > Lorenzo
> >
> > > Jonathan
> > >
> > > > ---
> > > > I have not been able to test this patch on a I3C device, just SPI/I2C
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 ++++++++++++++++++++
> > > >  2 files changed, 32 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > index f2113a63721a..dfcbe7c42493 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > @@ -266,6 +266,7 @@ struct st_lsm6dsx_ext_dev_settings {
> > > >   * @wai: Sensor WhoAmI default value.
> > > >   * @reset: register address for reset.
> > > >   * @boot: register address for boot.
> > > > + * @i3c_disable:  register address for enabling/disabling I3C (addr + mask).
> > > >   * @bdu: register address for Block Data Update.
> > > >   * @max_fifo_size: Sensor max fifo length in FIFO words.
> > > >   * @id: List of hw id/device name supported by the driver configuration.
> > > > @@ -284,6 +285,7 @@ struct st_lsm6dsx_settings {
> > > >       u8 wai;
> > > >       struct st_lsm6dsx_reg reset;
> > > >       struct st_lsm6dsx_reg boot;
> > > > +     struct st_lsm6dsx_reg i3c_disable;
> > > >       struct st_lsm6dsx_reg bdu;
> > > >       u16 max_fifo_size;
> > > >       struct {
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 84d219ae6aee..b1435c5d2d6d 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -751,6 +751,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> > > >                       .addr = 0x12,
> > > >                       .mask = BIT(7),
> > > >               },
> > > > +             .i3c_disable = {
> > > > +                     .addr = 0x18,
> > > > +                     .mask = BIT(1),
> > > > +             },
> > > >               .bdu = {
> > > >                       .addr = 0x12,
> > > >                       .mask = BIT(6),
> > > > @@ -1128,6 +1132,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> > > >                       .addr = 0x12,
> > > >                       .mask = BIT(7),
> > > >               },
> > > > +             .i3c_disable = {
> > > > +                     .addr = 0x18,
> > > > +                     .mask = BIT(1),
> > > > +             },
> > > >               .bdu = {
> > > >                       .addr = 0x12,
> > > >                       .mask = BIT(6),
> > > > @@ -2041,6 +2049,19 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > > >       const struct st_lsm6dsx_reg *reg;
> > > >       int err;
> > > >
> > > > +     /* disable MIPI I3C during device reset in order to avoid
> > >
> > > comment syntax
> > > /*
> > >  * disable...
> > >
> > > > +      * possible races on interrupt line 1. If the first interrupt
> > > > +      * line is asserted during hw reset the device will work in
> > > > +      * I3C-only mode
> > > > +      */
> > > > +     if (hw->settings->i3c_disable.addr) {
> > > > +             reg = &hw->settings->i3c_disable;
> > > > +             err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > +                                      ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
> > > > +             if (err < 0)
> > > > +                     return err;
> > > > +     }
> > > > +
> > > >       /* device sw reset */
> > > >       reg = &hw->settings->reset;
> > > >       err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > @@ -2059,6 +2080,15 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > > >
> > > >       msleep(50);
> > > >
> > > > +     /* enable MIPI I3C */
> > > > +     if (hw->settings->i3c_disable.addr) {
> > > > +             reg = &hw->settings->i3c_disable;
> > > > +             err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > +                                      ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > > +             if (err < 0)
> > > > +                     return err;
> > > > +     }
> > > > +
> > > >       /* enable Block Data Update */
> > > >       reg = &hw->settings->bdu;
> > > >       err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > >
>
>

