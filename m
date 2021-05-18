Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAA6387F3F
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbhERSJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 14:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346758AbhERSJc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 14:09:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D558E6023B;
        Tue, 18 May 2021 18:08:11 +0000 (UTC)
Date:   Tue, 18 May 2021 19:09:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH 4/5 v2] iio: magnetometer: st_magn: Support mount matrix
Message-ID: <20210518190929.2a6c29a9@jic23-huawei>
In-Reply-To: <YKOCcQNfJ1t7YmGB@gerhold.net>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
        <20210517233322.383043-4-linus.walleij@linaro.org>
        <YKOCcQNfJ1t7YmGB@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 May 2021 11:01:37 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> Hi,
> 
> On Tue, May 18, 2021 at 01:33:21AM +0200, Linus Walleij wrote:
> > Add support to read and present the mounting matrix on ST magnetometers.
> > 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > Cc: Daniel Drake <drake@endlessm.com>
> > Cc: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - New patch because why not.  
> 
> Thanks for patching the other ST drivers as well!
> That reminds me about something I was thinking about when I was making
> the changes a week ago. :)
> 
> > ---
> >  drivers/iio/magnetometer/st_magn_core.c | 64 ++++++++++++++++++-------
> >  1 file changed, 46 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> > index 71faebd07feb..fa587975cb85 100644
> > --- a/drivers/iio/magnetometer/st_magn_core.c
> > +++ b/drivers/iio/magnetometer/st_magn_core.c
> > @@ -53,51 +53,74 @@
> >  #define ST_MAGN_3_OUT_Y_L_ADDR			0x6a
> >  #define ST_MAGN_3_OUT_Z_L_ADDR			0x6c
> >  
> > +static const struct iio_mount_matrix *
> > +st_magn_get_mount_matrix(const struct iio_dev *indio_dev,
> > +			 const struct iio_chan_spec *chan)
> > +{
> > +	struct st_sensor_data *mdata = iio_priv(indio_dev);
> > +
> > +	return &mdata->mount_matrix;
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info st_magn_mount_matrix_ext_info[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_magn_get_mount_matrix),
> > +	{ },
> > +};
> > +  
> 
> I'm not sure if this is worth it (or even a particularly good idea),
> but we could share this function and struct in st_sensors_core.c
> since it's exactly the same for st_accel/magn/gyro AFAICT.
> (It just operates on the common struct st_sensor_data).
> 
> This could be done with a macro like ST_SENSORS_LSM_CHANNELS_MOUNT_MATRIX(...)
> (maybe a bit long and clumsy) instead of _EXT(...) and pointing to
> a struct iio_chan_spec_ext_info somewhere in st_sensors_core.c.
> 
> The disadvantage however is that st_accel/magn/gyro couldn't add other
> (sensor-specific) ext_info later. Not sure if that is realistic though.

My gut feeling is it's not worth the effort for such a small bit of
repetition, but I don't feel that strongly about it so will take
whatever comes in v3 ;)

Jonathan


> 
> I wasn't entirely sure myself that's why I went with the _EXT(...)
> instead (especially since I only wanted to patch st_accel).
> Just wanted to mention it :)
> 
> Stephan

