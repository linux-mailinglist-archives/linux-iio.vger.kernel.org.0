Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214CC19F639
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 14:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgDFM6a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 08:58:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52164 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgDFM6a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 08:58:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id fr8so1302564pjb.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2020 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKXJdflQY9JNUXXfN4nUV8l17pl4e2lUC4+pC0EJojw=;
        b=RdQ3MqSxxe0Jk2+fEjSe5w5OkXvT273878MLixZJdq9VeSJNpLbafhrOMR24QzQhGE
         LrC+XrnLoKxmWhTOHVb2sbJfTy+Evcpca2UrMZo2U2Z2oRuVU0APNbz0zsxacWkXXQKb
         7U211v9QF1dIaAeWqoCK0RXZnZD4QfErhtIOsw7RhCvlYBkFhcwdHRTQUBFFFLoTXshn
         k/e5AkLPqiezfrPefsYzOFzg+VgtgI2tSTVdOO1MZEj3WDikouf6dBV03Sr3MssWr6et
         51ho65eaiTfI7wm+ocps8cbtYRgZzlbgYU3dLmDsB0e7m+GTVF1bFzNP1RlTOX9RJiKx
         QiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKXJdflQY9JNUXXfN4nUV8l17pl4e2lUC4+pC0EJojw=;
        b=m6iRu7mF+nSNAH6O0ln4jQjp8NbCKHbY58zWmINiIPnwtRww8v0EpBwYQYKL9c6Yit
         E6Nh0Lzd1i/EfKuUz21aQc0KjakL6VzmoaHDQ75C4ShfVYzzlAdpqqabUYMM+SYTxI07
         JnKvz1LdesByguFZ0BAodo9VecONVUuzvoSkbvqM87pbZ/79k23ffzTCJN5g10HuTbwO
         EVgs47DGlWokMi+HKlTPUaaH74eQ5lY8fbG/Uza7VnRNL4Mbcnq3prnkrK6M9ZmjMQCs
         3/aERcReTP94LJNm1ouMutv4XTRkaCqyz2R5cFRelhVgb6U0A6xg5ezjhs2W7FX05awP
         gwPw==
X-Gm-Message-State: AGi0PuavZQHNcA7S+u3yr+SUb4LP0NUSnGiseXgZRh2N6Uqe8bVWUD7i
        huXJkOs5fRF81CVRTji/lNHgPoqjss87InNkwaA=
X-Google-Smtp-Source: APiQypJeByCQgdf9R5/wMD+nqcsNXz+JCuoArFbFLfIeHEnnqw318jeAaB+MCCRChdUaAVdeltxMjfKDJJnzkqZgSA0=
X-Received: by 2002:a17:90a:8546:: with SMTP id a6mr4404219pjw.8.1586177908717;
 Mon, 06 Apr 2020 05:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <8593125b207045797adb9406aa2d3d2f43c30153.1586170271.git.lorenzo@kernel.org>
 <CAHp75VcqZ_VDD69wToo6LQqsawkEA_oPFQanSoFOT1gSgOrXZQ@mail.gmail.com> <20200406112006.GA5890@lore-desk-wlan>
In-Reply-To: <20200406112006.GA5890@lore-desk-wlan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Apr 2020 15:58:21 +0300
Message-ID: <CAHp75VeCfhNC4ky2UjAyyGcqMq2GF_crHUavVCrRbos-74_Pew@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: drop huge include in sensor-hub driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        lorenzo.bianconi@redhat.com,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 6, 2020 at 2:20 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > On Mon, Apr 6, 2020 at 1:52 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >
> > > st_sensors.h contains common stm sensor definitions but in
> >
> > > st_lsm6dsx_shub driver it is used just to introduce the default
> >
> > Still doesn't fully clear why only this part of the st_lsm6dsx is not
> > okay with the header.
> > You need to explain that common/st_sensors is for separate ST sensor
> > drivers, while LSM6DSx is a driver for certain IMU which *does not*
> > use ST common infrastructure.
>
> I guess it is pretty simple and evident: we did not use it at all before
> the LISM3DL commit and at moment we need it just for ST_SENSORS_DEFAULT_WAI_ADDRESS
> definition. It is better to hard code the value directly.

Yes, my point is that for a reader (*) of this commit message is not
fully clear why on a sudden we did that.

(*) the reader may not know full history.

> > > wai address for LIS3MDL sensor.
> > > Drop this largely unconnected include and introduce the default wai
> > > address in st_lsm6dsx_ext_dev_settings register map

-- 
With Best Regards,
Andy Shevchenko
