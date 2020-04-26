Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336D71B90D9
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 16:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgDZO27 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 10:28:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26404 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725876AbgDZO27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 10:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587911337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRiLLiVpt45LVhCy+iYS4a+tiusG4DsphxrcvLgLYVA=;
        b=RRfW79Eax1v6sy3y4DDPIZ2NH5WNn7eVMw8/hv1GqOFuuwP56B0X0m8TY6C8FYV23f8fwn
        5zzZPT601K6fgc7IeVSeakDPnZbmjv2z1/sjQQnecyHLTFEAD9CfmvG4s6T/PGuNdO/ZjG
        memfIf5xloQdEBMEovOR9rcEWzG5e+M=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-r78pUYAvP3GLeqj1icxPPQ-1; Sun, 26 Apr 2020 10:28:55 -0400
X-MC-Unique: r78pUYAvP3GLeqj1icxPPQ-1
Received: by mail-vk1-f198.google.com with SMTP id v191so5124506vkv.5
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2020 07:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRiLLiVpt45LVhCy+iYS4a+tiusG4DsphxrcvLgLYVA=;
        b=f3T9eM94nAQs/TzLa7h55m80S4fttHKFPMqWa1sQA873r5Xm66I4T988OfuA+R9zd9
         po7ovV5fNNCC9+0R2+G6IgudMEKc53Ew3iQOZsNY3ZgvaMOwFoHoXPwyjhqocmf2WoF3
         T5/sqlbEipJiOo7WBBefvtPIMP5vLxPyY4j7KfPWHjrMwnVqVL+JjSXKKQWcT0V8MIC0
         8Bwn3NI2FFlrKlWpBfUVjMTErITLCrjjhbncOJdb4J/9CJUV2J1jlgod0mzvvlG1pFu0
         fSa4Mkm4jN5SB7MYTVEhHW0gRmcX7brs6Jl7f+xruvY47VBNLbnKvP5QmduAcy4CAEI7
         XNMg==
X-Gm-Message-State: AGi0PuaAkptKA7OjsrqUlfc5TyZoa+L2M4ZGx8jiMxsdW/5yjcelYIGG
        HslFAcBskCdA1AEeQotHh5ya+MyFCcFZjztQ+hqjWvUBdL/CN9jpfTrkVgmHE6QW4BTf5QJ9HZu
        WdGXeWSxwOh2qFo2CWAqZgkVIDGXnXjMb9v+v
X-Received: by 2002:a67:e3a9:: with SMTP id j9mr12536662vsm.64.1587911335240;
        Sun, 26 Apr 2020 07:28:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypKrvH8AC1KKQ1Cwtkqiq+TxZ0KmTsqJ7FDLsbBFGPldyGNzhAIJlf2ffrRi2UBBJYaIzoKJWlb4ivs/AtXSb88=
X-Received: by 2002:a67:e3a9:: with SMTP id j9mr12536652vsm.64.1587911334943;
 Sun, 26 Apr 2020 07:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <81e5660e7b7755346efefdd90f721a4b0cd63726.1587724988.git.lorenzo@kernel.org>
 <20200425180528.75c420bb@archlinux>
In-Reply-To: <20200425180528.75c420bb@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 26 Apr 2020 16:28:43 +0200
Message-ID: <CAJ0CqmXum=jUeafjYZw+CnRSgf+n8Fm3GkFPNxza2egmqr3Gyw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: enable 833Hz sample frequency for
 tagged sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Fri, 24 Apr 2020 12:44:38 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Enable 833Hz ODR for sensors that supports tagged hw FIFO:
> > - LSM6DSO/LSM6DSOX
> > - LSM6DSR/LSM6DSRX
> > - ASM330LHH
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Would ideally have liked a little more info on the 'why'.  Was this previously
> capped by practicality - i.e. not possible to read faster or is there
> something else going on here?

Hi Jonathan,

you are right sorry, the commit log can be improved :)
Actually AFAIK aosp CTS requires 800Hz as sampling frequency for accel
and gyro (but I am out of it for a while now so I can be wrong).
Anyway I tested it and it works fine, so why not? :)

Regards,
Lorenzo

>
> Don't really need to know for the applied patch though so
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 21 +++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 84d219ae6aee..e6339bbb4469 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -27,7 +27,8 @@
> >   *   - FIFO size: 4KB
> >   *
> >   * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
> > - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
> > + *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
> > + *     833
> >   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> >   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
> >   *   - FIFO size: 3KB
> > @@ -791,7 +792,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                               .odr_avl[3] = { 104000, 0x04 },
> >                               .odr_avl[4] = { 208000, 0x05 },
> >                               .odr_avl[5] = { 416000, 0x06 },
> > -                             .odr_len = 6,
> > +                             .odr_avl[6] = { 833000, 0x07 },
> > +                             .odr_len = 7,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] = {
> >                               .reg = {
> > @@ -804,7 +806,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                               .odr_avl[3] = { 104000, 0x04 },
> >                               .odr_avl[4] = { 208000, 0x05 },
> >                               .odr_avl[5] = { 416000, 0x06 },
> > -                             .odr_len = 6,
> > +                             .odr_avl[6] = { 833000, 0x07 },
> > +                             .odr_len = 7,
> >                       },
> >               },
> >               .fs_table = {
> > @@ -994,7 +997,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                               .odr_avl[3] = { 104000, 0x04 },
> >                               .odr_avl[4] = { 208000, 0x05 },
> >                               .odr_avl[5] = { 416000, 0x06 },
> > -                             .odr_len = 6,
> > +                             .odr_avl[6] = { 833000, 0x07 },
> > +                             .odr_len = 7,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] = {
> >                               .reg = {
> > @@ -1007,7 +1011,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                               .odr_avl[3] = { 104000, 0x04 },
> >                               .odr_avl[4] = { 208000, 0x05 },
> >                               .odr_avl[5] = { 416000, 0x06 },
> > -                             .odr_len = 6,
> > +                             .odr_avl[6] = { 833000, 0x07 },
> > +                             .odr_len = 7,
> >                       },
> >               },
> >               .fs_table = {
> > @@ -1171,7 +1176,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                               .odr_avl[3] = { 104000, 0x04 },
> >                               .odr_avl[4] = { 208000, 0x05 },
> >                               .odr_avl[5] = { 416000, 0x06 },
> > -                             .odr_len = 6,
> > +                             .odr_avl[6] = { 833000, 0x07 },
> > +                             .odr_len = 7,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] = {
> >                               .reg = {
> > @@ -1184,7 +1190,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                               .odr_avl[3] = { 104000, 0x04 },
> >                               .odr_avl[4] = { 208000, 0x05 },
> >                               .odr_avl[5] = { 416000, 0x06 },
> > -                             .odr_len = 6,
> > +                             .odr_avl[6] = { 833000, 0x07 },
> > +                             .odr_len = 7,
> >                       },
> >               },
> >               .fs_table = {
>

