Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770DA36A0DE
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 13:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhDXL0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 07:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhDXL0f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 07:26:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAEA61581;
        Sat, 24 Apr 2021 11:25:55 +0000 (UTC)
Date:   Sat, 24 Apr 2021 12:26:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Nuno Sa <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 7/9] iio: adis: add burst_max_speed_hz variable
Message-ID: <20210424122636.08b212ce@jic23-huawei>
In-Reply-To: <CA+U=DsqOFY1JbffqOjhcqFQzjeC3sEQc=gHF-AgZwuyfxsandA@mail.gmail.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-8-nuno.sa@analog.com>
        <CA+U=DsqOFY1JbffqOjhcqFQzjeC3sEQc=gHF-AgZwuyfxsandA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 10:34:24 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
> >
> > Typically, in burst mode, the device cannot operate at it's full spi
> > speed. Hence, the spi transfers for burst mode have to take this into
> > account. With this change we avoid a potential race with the spi core as
> > drivers were 'hacking' the device 'max_speed_hz' directly in the
> > trigger handler.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Rest of series looks good to me.  Nice cleanup / fixes ;)

I'll probably take this the slow way though rather than through fixes.
Race has been there a while after all with no reports so it can wait
a cycle.  I'll think about whether to mark them for stable when applying.
On this particular occasion we may want to do an explicit stable email
as the need to pick up the whole series (minus the first 2 I think)
even though some parts of it are not fixes as such but precursor rework.

Thanks,

Jonathan

> 
> 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  drivers/iio/imu/adis_buffer.c | 4 ++++
> >  include/linux/iio/imu/adis.h  | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> > index dda367071980..82239da2f441 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -51,9 +51,13 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
> >         adis->xfer[0].tx_buf = tx;
> >         adis->xfer[0].bits_per_word = 8;
> >         adis->xfer[0].len = 2;
> > +       if (adis->data->burst_max_speed_hz)
> > +               adis->xfer[0].speed_hz = adis->data->burst_max_speed_hz;
> >         adis->xfer[1].rx_buf = adis->buffer;
> >         adis->xfer[1].bits_per_word = 8;
> >         adis->xfer[1].len = burst_length;
> > +       if (adis->data->burst_max_speed_hz)
> > +               adis->xfer[1].speed_hz = adis->data->burst_max_speed_hz;
> >
> >         spi_message_init(&adis->msg);
> >         spi_message_add_tail(&adis->xfer[0], &adis->msg);
> > diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> > index f9b728d490b1..cf49997d5903 100644
> > --- a/include/linux/iio/imu/adis.h
> > +++ b/include/linux/iio/imu/adis.h
> > @@ -55,6 +55,7 @@ struct adis_timeout {
> >   *                     this should be the minimum size supported by the device.
> >   * @burst_max_len:     Holds the maximum burst size when the device supports
> >   *                     more than one burst mode with different sizes
> > + * @burst_max_speed_hz:        Maximum spi speed that can be used in burst mode
> >   */
> >  struct adis_data {
> >         unsigned int read_delay;
> > @@ -83,6 +84,7 @@ struct adis_data {
> >         unsigned int burst_reg_cmd;
> >         unsigned int burst_len;
> >         unsigned int burst_max_len;
> > +       unsigned int burst_max_speed_hz;
> >  };
> >
> >  /**
> > --
> > 2.31.1
> >  

