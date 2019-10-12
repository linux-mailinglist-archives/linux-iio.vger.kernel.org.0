Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA39D4EC3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfJLJuc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 05:50:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48797 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727115AbfJLJuc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 05:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570873829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6Rqoo951oxUIQTEPrvn9exhWGJiDWrFIpO90OSw7vE=;
        b=I79jNi3yA17HZaib9mc7atxOLrJRgbTZighY5FbudY3eQr+SL+CCCZjtfnqwtszCLrRJMk
        fWaMY2vRAbWUlg1GJesqA83fyqovdv2fshg7jlOio3l8Od9i32e/9+IjuNZ0iKhvIZPxHT
        mQjslqYcsLs8slabGgZ5jcw1bOToAo0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-v9FDOzceOi2hwhK3RPghWA-1; Sat, 12 Oct 2019 05:50:27 -0400
Received: by mail-io1-f72.google.com with SMTP id i2so18190070ioo.10
        for <linux-iio@vger.kernel.org>; Sat, 12 Oct 2019 02:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jVjA2Zt6hRGpE3up5Uzdsxfyc/PWCHTLRSQ3fXkzzA=;
        b=dAdDSt3pv2v4q+oKoNtRWe5FtQq01g/KyP6uaijBGMd9W9wXwo15RlsIMaA6UH+6da
         TFxlHtgs6e7VlPKAfV6+9L8FHImoXGnJ604Bjh/PpOwx/IDu8fOCEQ3awA0wbrmjW/ht
         xqQa+C0spupVU3KqCsQsWGQg9efJ4F90KjZUMRJWPS7QKHedt4a/YzOZFu940vSoG+Ds
         oXKbryTaLKRXJE0iNx5cUJ1DgeQ0ZSn06rf2W6j5hEKtotdd1CbZMk/Jvh/mpcd+hBJL
         HtKIsm8x2F7rGqV9PKoJm1Mmd5HF/HydSsSlfysH/XK+UT68LvyYVz4GZ9eS8evcJ7b9
         6V2Q==
X-Gm-Message-State: APjAAAW9cDpzNOupWTPIvx2t+VYzx6sZ/6SCuJnJmX/SEIr8B2ck7q4t
        lzAzIh6U+dW4G0497lmklgQqlqzgGjtcaXW9Topwxicn4WDzVV6fPj/JbUPBduieO3225AY84LO
        5Eev/aC2FksFRsWoLPvRQ4NX3Htgetoi0fw+e
X-Received: by 2002:a05:6602:240d:: with SMTP id s13mr23614654ioa.228.1570873826904;
        Sat, 12 Oct 2019 02:50:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMcHPl+uFre5VDFCaHL4Y8V0VD+KklZNkkbTbeM5jn9pJaLb4pPodMoFMEjJXSJP5x7vuE+OBaI2uqDVBD4SQ=
X-Received: by 2002:a05:6602:240d:: with SMTP id s13mr23614616ioa.228.1570873826512;
 Sat, 12 Oct 2019 02:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <c85fd7c8101bd56e6f589e5fb2e023f14768f2dd.1570480230.git.lorenzo@kernel.org>
 <20191012104709.7bfc4386@archlinux>
In-Reply-To: <20191012104709.7bfc4386@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 12 Oct 2019 11:50:15 +0200
Message-ID: <CAJ0CqmVo99-N_sW7xi2PmF9YwydDop_NWwpiQRMOY8XU59K6KQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: explicitly define odr table size
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        mario.tesi@st.com
X-MC-Unique: v9FDOzceOi2hwhK3RPghWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Mon,  7 Oct 2019 22:31:49 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Introduce odr_len in st_lsm6dsx_odr_table_entry data structure in order
> > to explicitly define odr table size and support devices with different
> > odr table map
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Hi Lorenzo,
>
> Patch is fine, but please put it as a precursor in whatever series you ha=
ve
> coming that needs to support a different size.
>
> Thanks,
>
> Jonathan

Hi Jonathan,

ack, will do :)

Regards,
Lorenzo

>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 26 +++++++++++++++-----
> >  2 files changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 30fd274ea8ae..ff7519475478 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -111,7 +111,9 @@ struct st_lsm6dsx_odr {
> >  #define ST_LSM6DSX_ODR_LIST_SIZE     6
> >  struct st_lsm6dsx_odr_table_entry {
> >       struct st_lsm6dsx_reg reg;
> > +
> >       struct st_lsm6dsx_odr odr_avl[ST_LSM6DSX_ODR_LIST_SIZE];
> > +     int odr_len;
> >  };
> >
> >  struct st_lsm6dsx_fs {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 740912bbf941..98a1fa8d1454 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -131,6 +131,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 238, 0x04 },
> >                               .odr_avl[4] =3D { 476, 0x05 },
> >                               .odr_avl[5] =3D { 952, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] =3D {
> >                               .reg =3D {
> > @@ -143,6 +144,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 238, 0x04 },
> >                               .odr_avl[4] =3D { 476, 0x05 },
> >                               .odr_avl[5] =3D { 952, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >               },
> >               .fs_table =3D {
> > @@ -230,6 +232,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] =3D {
> >                               .reg =3D {
> > @@ -242,6 +245,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >               },
> >               .fs_table =3D {
> > @@ -394,6 +398,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] =3D {
> >                               .reg =3D {
> > @@ -406,6 +411,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >               },
> >               .fs_table =3D {
> > @@ -567,6 +573,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] =3D {
> >                               .reg =3D {
> > @@ -579,6 +586,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >               },
> >               .fs_table =3D {
> > @@ -738,6 +746,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] =3D {
> >                               .reg =3D {
> > @@ -750,6 +759,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >               },
> >               .fs_table =3D {
> > @@ -928,6 +938,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] =3D {
> >                               .reg =3D {
> > @@ -940,6 +951,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >               },
> >               .fs_table =3D {
> > @@ -1095,6 +1107,7 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >                       [ST_LSM6DSX_ID_GYRO] =3D {
> >                               .reg =3D {
> > @@ -1107,6 +1120,7 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >                               .odr_avl[3] =3D { 104, 0x04 },
> >                               .odr_avl[4] =3D { 208, 0x05 },
> >                               .odr_avl[5] =3D { 416, 0x06 },
> > +                             .odr_len =3D 6,
> >                       },
> >               },
> >               .fs_table =3D {
> > @@ -1329,7 +1343,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor=
 *sensor, u16 odr, u8 *val)
> >       int i;
> >
> >       odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> > -     for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> > +     for (i =3D 0; i < odr_table->odr_len; i++)
> >               /*
> >                * ext devices can run at different odr respect to
> >                * accel sensor
> > @@ -1337,7 +1351,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor=
 *sensor, u16 odr, u8 *val)
> >               if (odr_table->odr_avl[i].hz >=3D odr)
> >                       break;
> >
> > -     if (i =3D=3D ST_LSM6DSX_ODR_LIST_SIZE)
> > +     if (i =3D=3D odr_table->odr_len)
> >               return -EINVAL;
> >
> >       *val =3D odr_table->odr_avl[i].val;
> > @@ -1688,13 +1702,13 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struc=
t device *dev,
> >                                         char *buf)
> >  {
> >       struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_get_drvdata(dev=
));
> > -     enum st_lsm6dsx_sensor_id id =3D sensor->id;
> > -     struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +     const struct st_lsm6dsx_odr_table_entry *odr_table;
> >       int i, len =3D 0;
> >
> > -     for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> > +     odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> > +     for (i =3D 0; i < odr_table->odr_len; i++)
> >               len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> > -                              hw->settings->odr_table[id].odr_avl[i].h=
z);
> > +                              odr_table->odr_avl[i].hz);
> >       buf[len - 1] =3D '\n';
> >
> >       return len;
>

