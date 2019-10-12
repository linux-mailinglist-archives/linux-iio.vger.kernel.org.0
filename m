Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F040D4FAE
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfJLM2g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:28:36 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46304 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJLM0g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 08:26:36 -0400
Received: by mail-yb1-f195.google.com with SMTP id h202so3963062ybg.13;
        Sat, 12 Oct 2019 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wodRE/YtF7iSQoHJk6KK34t4IYEOMzQmZdFvHyQkiI=;
        b=f59egIQ23z8pXc8c6JaN4wv/TZ1dRdkwR3HYlf0yi+GMhf6ktqwTvFtzgCxt8APoGT
         MKnKTPHPNbuz9V92jMYFeW3X/JVRFWbG+jO4xU4aYQzoEhN16vTHHYFF086H+R2f7I3j
         IMhYwcRt7QnQHf2XzjJcSrQ1FY1gdXTwJrOZc8aU0tp8kjDYNU5o0YPGEl9uXvcIBVOu
         b1YDdM9hw0HmNqpdx6W2THwbwXEwkyIJ1MeVl4FPw1rJ98kqryVuv4RYKRBj+UowJxGY
         b+xIQtaaDbdKKz9p7yIH91cQfDi5Y/8e8Onkjsl+h0GC4NbTgElLKligis/13ZPbe9Va
         XtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wodRE/YtF7iSQoHJk6KK34t4IYEOMzQmZdFvHyQkiI=;
        b=hVPlG0ghgouGA04dDEH1qQ22pDXdH4aTtXwvhGElghr3vN3+nEDWsSqNGBMcM++Ozo
         7p7PRHmS+OgyrnYjUjftNYHLvtRq9iHW71Vn2TPoArCxtCWWSjIqjJDT2CaBr1XESXSU
         pOetmKwy04C9ABJJN4eXPOfGoeAFixcdG3WtTIuZwaneVy4qFm+Ulay9pOm4M9e4ZGGC
         0VEUOtCq0YrDdc7U9VF+bV0dQ6gh0ffazAurHR34B6xFK/eUBmBIrvvyJSaKTRPHvGNJ
         x0q0pBO2nOX0UZFzOj82HX10Ku2Z87U7ceWnbSAqBOVTh7jNMtW9KXulKt6CSehj71j9
         MJfg==
X-Gm-Message-State: APjAAAUvk/xf+OtY2AhX8sREz6jjW4EcSptZphHRGnI0cBYf/D3Sjts0
        L9X/bO72LiXaNGkXPOssHfqHnmNnqZ8S49Gd+Q8=
X-Google-Smtp-Source: APXvYqy5YyuE5uVRMFavxhLGXGMvYs3LDJWXaMZJaBnFjkr8+diY/4XStJw/FpvNq/u6M52E5bW5oc2h/mppPIfm/oA=
X-Received: by 2002:a25:8308:: with SMTP id s8mr13700664ybk.130.1570883195447;
 Sat, 12 Oct 2019 05:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570367532.git.lorenzo@kernel.org> <20191012132020.412e9595@archlinux>
In-Reply-To: <20191012132020.412e9595@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Sat, 12 Oct 2019 14:26:24 +0200
Message-ID: <CAA2SeNLEG9kMxW_XrGeyaORXdY5xjdxqqU9BPsdiWcr9J_ruYA@mail.gmail.com>
Subject: Re: [PATCH 00/13] various st_lsm6dsx fixes and missing bits
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        Sean Nyekjaer <sean@geanix.com>, martin@geanix.com,
        Bobby Jones <rjones@gateworks.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Sun,  6 Oct 2019 15:21:54 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > This series fixes some corner cases introduced with LSM9DS1 support and with
> > the one that has added wake-up event support. In particular it fixes a crash
> > due to missing HW FIFO support for LSM9DS1.
> > Moreover I introduced the missing wake-up event support for LSM6DSO/LSM6DSOX
> > sensor
> > Add missing dts documentation for wake-up event and the capability to enable it
> > through platformdata.
> > Code cleanup.
>
> Hmm. This is going to be very messy.  In theory quite a few of these apply
> to stuff in 5.4 but I assume won't cleanly apply given other changes.  You
> may want to think about doing backports of the important parts to 5.4.
>
> I'll apply the lot for 5.5.

AFAIU just LSM9DS1 support will go in 5.4 (correct? Sean's series will
go in 5.5) so I will backport just LSM9DS1 fixes to 5.4 (I guess 3-4
patches).

Regards,
Lorenzo

>
> Thanks,
>
> Jonathan
>
> >
> > Lorenzo Bianconi (13):
> >   iio: imu: st_lsm6dsx: use st_lsm6dsx_read_locked in
> >     st_lsm6dsx_report_motion_event
> >   iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer
> >   iio: imu: st_lsm6dsx: move irq related definitions in irq_config
> >   iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not
> >     supported
> >   iio: imu: st_lsm6dsx: move bdu/boot and reset register info in
> >     hw_settings
> >   iio: imu: st_lsm6dsx: always check enable_reg in
> >     st_lsm6dsx_event_setup
> >   iio: imu: st_lsm6dsx: rely on st_lsm6dsx_update_bits_locked
> >     configuring events
> >   iio: imu: st_lsm6dsx: grab conf mutex in st_lsm6dsx_write_event_config
> >   iio: imu: st_lsm6dsx: fix checkpatch warning
> >   iio: imu: st_lsm6dsx: add wakeup_source in st_sensors_platform_data
> >   iio: imu: st_lsm6dsx: add missing kernel documenation
> >   dt-bindings: iio: imu: st_lsm6dsx: document missing wakeup-source
> >     property
> >   iio: imu: st_lsm6dsx: enable wake-up event for LSM6DSO
> >
> >  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  35 +-
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   3 +
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 588 ++++++++++++------
> >  .../linux/platform_data/st_sensors_pdata.h    |   2 +
> >  5 files changed, 440 insertions(+), 189 deletions(-)
> >
>


-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
