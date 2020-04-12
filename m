Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6A1A60D2
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgDLWMi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 18:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgDLWMi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 18:12:38 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87969C0A88B5
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586729557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cGjiTEH9gWCWuYOZfVsqMBDJb/PeBA4Q6mzgJop06QU=;
        b=C7EkkxojxFiuyk2sc46ADPQ9fhqJIer7H7GGQoTYnt9pu2G9T/qBWF+w9SfdxT9BIzOc+V
        ah5QkeXJHO9d7FM9md0AHd/bAqkyZWPzYeVinJ1oMAqeHGRNXf0/tXMqnareurMS/o7PHD
        PVZbZjjzWrThBOzt1/FSmSYnq2S3MBs=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-pIgBW5ADNMCwFLLpk6nl9w-1; Sun, 12 Apr 2020 18:12:35 -0400
X-MC-Unique: pIgBW5ADNMCwFLLpk6nl9w-1
Received: by mail-vk1-f200.google.com with SMTP id x132so3556838vke.17
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 15:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGjiTEH9gWCWuYOZfVsqMBDJb/PeBA4Q6mzgJop06QU=;
        b=YXHPvXuefkzOlWmSUX93Q1QFs6NliPwN0kOrl3A5uA3Rgswd+vaY6cS4HZzK+CDIpy
         TKSbQ062fTCkgJaObpFuCnu0owr8lgFg/0GUL7KjSl0f848JYcfHGqgmnuV1/cpL2vES
         WwzlLyCPZERXW4c5C0luY6WPJ12jKVcEpgmv0nT40Hu3DwBIzx7qlo12bom5F7x93kwD
         OcFR0rIETgfQL8dxAtA3HJq4LibOwm+uFaNMlE9EMFypIw2R5KIvcANVE8JRH7bDkj6M
         QhFkXyTQvJ820xOxbPJGwDGpiE79JuO+4yVDjOrTv3KgZD8+jOG4PHzQJP/wqZG6VPuu
         4ifw==
X-Gm-Message-State: AGi0Puaqb+/IaZckt5JElPcJx4iwoaUlciCXQ2pmcW4Ex2I/s0J28Lpz
        I6TLSl7Urh3OM8xq342wvezEgxP1flHMi+KlVPb0czoTOE9Qig7RIKfNJJNPgGSCgudoxSEd6Xj
        /2aKNrLjp2N7y3gr63a57AhTFM7Miy7l67eIz
X-Received: by 2002:ab0:4505:: with SMTP id r5mr9462302uar.64.1586729554799;
        Sun, 12 Apr 2020 15:12:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypLjTXIYkki/rWp91Qqizb80avO8beO2xI1BdDZTL2YTtVdPztrNPrKaVl8vvIGeyM1p416zRfnPTUlAaZO+6T4=
X-Received: by 2002:ab0:4505:: with SMTP id r5mr9462291uar.64.1586729554390;
 Sun, 12 Apr 2020 15:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <d7464094f82945ae7978a18e0117570b2c71c963.1586247885.git.lorenzo@kernel.org>
 <20200412142515.0b30b2b5@archlinux>
In-Reply-To: <20200412142515.0b30b2b5@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 13 Apr 2020 00:12:23 +0200
Message-ID: <CAJ0CqmXuwE56eyi7p5-LydcAAnst4UjWgJnmPDTGZ__U8SSyjg@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: limit variales scope reading hw FIFO
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Tue,  7 Apr 2020 10:26:44 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Fix following cppcheck warnings reported by kbuild test robot
> >
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:313:15:
> > warning: The scope of the variable 'word_len' can be reduced. [variableScope]
> >                  ^
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:314:6:
> > warning: The scope of the variable 'err' can be reduced. [variableScope]
> >         ^
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:11:
> > warning: The scope of the variable 'sip' can be reduced. [variableScope]
> >              ^
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:16:
> > warning: The scope of the variable 'acc_sip' can be reduced. [variableScope]
> >                   ^
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:25:
> > warning: The scope of the variable 'gyro_sip' can be reduced. [variableScope]
> >                            ^
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:35:
> > warning: The scope of the variable 'ts_sip' can be reduced. [variableScope]
> >                                      ^
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:43:
> > warning: The scope of the variable 'ext_sip' can be reduced. [variableScope]
> >                                              ^
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:62:
> > warning: The scope of the variable 'offset' can be reduced. [variableScope]
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> I find it hard to care about these to be honest.  I got the original report
> at chose not to fix them :)  Anyhow, if you want to tidy them up that's fine
> of course.
>
> More interestingly this doesn't actually apply any more due to your sensor
> hub patches.  If you want to respin on top of the testing branch of iio.git
> then feel free.
>

I agree with you, there are probably other 'errors' like that one so I
guess we can just drop it.

Regards,
Lorenzo

> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index afd00daeefb2..849f01fbe76c 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -310,10 +310,12 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
> >                                       u8 *data, unsigned int data_len,
> >                                       unsigned int max_word_len)
> >  {
> > -     unsigned int word_len, read_len = 0;
> > -     int err;
> > +     unsigned int read_len = 0;
> >
> >       while (read_len < data_len) {
> > +             unsigned int word_len;
> > +             int err;
> > +
> >               word_len = min_t(unsigned int, data_len - read_len,
> >                                max_word_len);
> >               err = st_lsm6dsx_read_locked(hw, addr, data + read_len,
> > @@ -338,7 +340,6 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
> >  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  {
> >       struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor, *ext_sensor = NULL;
> > -     int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
> >       u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
> >       u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
> >       u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> > @@ -346,6 +347,7 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >       u8 ext_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> >       bool reset_ts = false;
> >       __le16 fifo_status;
> > +     int err, read_len;
> >       s64 ts = 0;
> >
> >       err = st_lsm6dsx_read_locked(hw,
> > @@ -370,6 +372,8 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >               ext_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0]);
> >
> >       for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
> > +             int acc_sip, gyro_sip, ts_sip, ext_sip, offset = 0, sip = 0;
> > +
> >               err = st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
> >                                           hw->buff, pattern_len,
> >                                           ST_LSM6DSX_MAX_WORD_LEN);
> > @@ -399,8 +403,6 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >               gyro_sip = gyro_sensor->sip;
> >               acc_sip = acc_sensor->sip;
> >               ts_sip = hw->ts_sip;
> > -             offset = 0;
> > -             sip = 0;
> >
> >               while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
> >                       if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
>

