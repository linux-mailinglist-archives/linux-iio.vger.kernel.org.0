Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABAA37FC8F
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEMRdg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhEMRda (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:33:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958F46142C;
        Thu, 13 May 2021 17:32:18 +0000 (UTC)
Date:   Thu, 13 May 2021 18:33:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 04/19] iio: accel: kxcjk-1013: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210513183326.0f39cb74@jic23-huawei>
In-Reply-To: <CAHp75Vc9hOe66LaC7AzbmbZ5+EMCSdgCnxCLY0NQdurmWtyFVQ@mail.gmail.com>
References: <20210501170121.512209-1-jic23@kernel.org>
        <20210501170121.512209-5-jic23@kernel.org>
        <CAHp75Vc9hOe66LaC7AzbmbZ5+EMCSdgCnxCLY0NQdurmWtyFVQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 22:10:48 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 1, 2021 at 8:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > To make code more readable, use a structure to express the channel
> > layout and ensure the timestamp is 8 byte aligned.
> >
> > Found during an audit of all calls of this function.
> >
> > Fixes: 1a4fbf6a9286 ("iio: accel: kxcjk1013 3-axis accelerometer driver")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/iio/accel/kxcjk-1013.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index ff724bc17a45..96ab247f17b3 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -133,6 +133,13 @@ enum kx_acpi_type {
> >         ACPI_KIOX010A,
> >  };
> >
> > +enum kxcjk1013_axis {
> > +       AXIS_X,
> > +       AXIS_Y,
> > +       AXIS_Z,  
> 
> > +       AXIS_MAX,  
> 
> I see that this is from original code, though I think you have a
> chance to remove unneeded comma here. Let's make the terminator line
> terminate.

Good idea.  Did that whilst applying.  This one had a lot of fuzz
due to support of new parts added to the driver in the meantime, but
the patch seems to have applied cleanly.

+CC various people involved in that series so they know this change
is going in as well (and can perhaps give it a spin!:)

Thanks,

Jonathan

> 
> > +};
> > +
> >  struct kxcjk1013_data {
> >         struct regulator_bulk_data regulators[2];
> >         struct i2c_client *client;
> > @@ -140,7 +147,11 @@ struct kxcjk1013_data {
> >         struct iio_trigger *motion_trig;
> >         struct iio_mount_matrix orientation;
> >         struct mutex mutex;
> > -       s16 buffer[8];
> > +       /* Ensure timestamp naturally aligned */
> > +       struct {
> > +               s16 chans[AXIS_MAX];
> > +               s64 timestamp __aligned(8);
> > +       } scan;
> >         u8 odr_bits;
> >         u8 range;
> >         int wake_thres;
> > @@ -154,13 +165,6 @@ struct kxcjk1013_data {
> >         enum kx_acpi_type acpi_type;
> >  };
> >
> > -enum kxcjk1013_axis {
> > -       AXIS_X,
> > -       AXIS_Y,
> > -       AXIS_Z,
> > -       AXIS_MAX,
> > -};
> > -
> >  enum kxcjk1013_mode {
> >         STANDBY,
> >         OPERATION,
> > @@ -1094,12 +1098,12 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
> >         ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
> >                                                         KXCJK1013_REG_XOUT_L,
> >                                                         AXIS_MAX * 2,
> > -                                                       (u8 *)data->buffer);
> > +                                                       (u8 *)data->scan.chans);
> >         mutex_unlock(&data->mutex);
> >         if (ret < 0)
> >                 goto err;
> >
> > -       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> >                                            data->timestamp);
> >  err:
> >         iio_trigger_notify_done(indio_dev->trig);
> > --
> > 2.31.1
> >  
> 
> 

