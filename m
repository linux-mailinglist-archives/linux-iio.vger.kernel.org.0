Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D614182FA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbhIYO7a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 25 Sep 2021 10:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234173AbhIYO7a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 10:59:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5529060F6D;
        Sat, 25 Sep 2021 14:57:54 +0000 (UTC)
Date:   Sat, 25 Sep 2021 16:01:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: adis16475: fix deadlock on frequency set
Message-ID: <20210925160133.17801b47@jic23-huawei>
In-Reply-To: <CA+U=DsoVS74-eQ_aj96QU1ayTd4WKg7FgZGDnt=W81sDjXk7XA@mail.gmail.com>
References: <20210920090047.74903-1-nuno.sa@analog.com>
        <CA+U=DsoVS74-eQ_aj96QU1ayTd4WKg7FgZGDnt=W81sDjXk7XA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Sep 2021 14:42:25 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Sep 20, 2021 at 12:59 PM Nuno Sá <nuno.sa@analog.com> wrote:
> >
> > With commit 39c024b51b560
> > ("iio: adis16475: improve sync scale mode handling"), two deadlocks were
> > introduced:
> >  1) The call to 'adis_write_reg_16()' was not changed to it's unlocked
> >     version.
> >  2) The lock was not being released on the success path of the function.
> >
> > This change fixes both these issues.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> > Fixes: 39c024b51b560 ("iio: adis16475: improve sync scale mode handling")
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/iio/imu/adis16475.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index eb48102f9424..287fff39a927 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -353,10 +353,11 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
> >         if (dec > st->info->max_dec)
> >                 dec = st->info->max_dec;
> >
> > -       ret = adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
> > +       ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
> >         if (ret)
> >                 goto error;
> >
> > +       adis_dev_unlock(&st->adis);
> >         /*
> >          * If decimation is used, then gyro and accel data will have meaningful
> >          * bits on the LSB registers. This info is used on the trigger handler.
> > --
> > 2.33.0
> >  

