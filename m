Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA536A0FB
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhDXLxJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 07:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhDXLxI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 07:53:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53D661467;
        Sat, 24 Apr 2021 11:52:29 +0000 (UTC)
Date:   Sat, 24 Apr 2021 12:53:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
Message-ID: <20210424125309.426d675c@jic23-huawei>
In-Reply-To: <CAHp75Ve2AEA8yPw5qN+R=K=ovaO8vX53hYU9=knjY_Z+EHDdww@mail.gmail.com>
References: <20210420132333.99886-1-tomas.melin@vaisala.com>
        <20210420132333.99886-3-tomas.melin@vaisala.com>
        <CAHp75Ve2AEA8yPw5qN+R=K=ovaO8vX53hYU9=knjY_Z+EHDdww@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 19:06:30 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 20, 2021 at 4:24 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> >
> > Add initial support for Murata SCA3300 3-axis industrial
> > accelerometer with digital SPI interface. This device also
> > provides a temperature measurement.  
> 
> Thanks for an update, my comments below.
> 
> They can be addressed as followups, but I think regmap API can be
> considered right now.

It's not a totally clear cut case of regmap making sense for this particular
device. I think you'd have do a custom regmap to support
the cs_change = 1, needed for transfers and once you are going down that
route the advantages of regmap have to be balanced against needing
custom callbacks anyway.

Without actually implementing it I'm not certain whether it would be
a good thing here or not. It should be fairly easy to try though if
Tomas wants to.

Jonathan

> 
> ...
> 
> > +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&sca_data->lock);
> > +       sca_data->txbuf[0] = reg << 2;
> > +       ret = sca3300_transfer(sca_data, val);
> > +       mutex_unlock(&sca_data->lock);
> > +       if (ret != -EINVAL)
> > +               return ret;
> > +
> > +       return sca3300_error_handler(sca_data);
> > +}
> > +
> > +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
> > +{
> > +       int reg_val = 0;
> > +       int ret;
> > +
> > +       mutex_lock(&sca_data->lock);
> > +       /* BIT(7) for write operation */
> > +       sca_data->txbuf[0] = BIT(7) | (reg << 2);
> > +       put_unaligned_be16(val, &sca_data->txbuf[1]);
> > +       ret = sca3300_transfer(sca_data, &reg_val);
> > +       mutex_unlock(&sca_data->lock);
> > +       if (ret != -EINVAL)
> > +               return ret;
> > +
> > +       return sca3300_error_handler(sca_data);
> > +}  
> 
> Okay, BIT(7) for write/read is pretty much standard stuff for such
> sensors. If you transform your driver to use REGMAP_SPI, you will get
> it thru regmap configuration. Also, you will get a locking there, in
> case you don't need to have several I/O in a row atomically.
> 
> ..
> 
> > +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> > +                        indio_dev->masklength) {  
> 
> One line?
> 
> > +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
> > +                                      &val);
> > +               if (ret) {
> > +                       dev_err_ratelimited(&data->spi->dev,
> > +                               "failed to read register, error: %d\n", ret);
> > +                       /* handled, but bailing out due to errors */
> > +                       goto out;
> > +               }
> > +               data->scan.channels[i++] = val;
> > +       }  
> 
> ...
> 
> > +       int ret;
> > +       int value = 0;  
> 
> Reversed xmas tree ordering?
> 
> ...
> 
> > +       /*
> > +        * Wait 1ms after SW-reset command.
> > +        * Wait 15ms for settling of signal paths.
> > +        */
> > +       usleep_range(16e3, 50e3);  
> 
> Hmm... Perhaps re-use msleep_range()
> https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx274.c#L601?
> 
> ...
> 
> > +       .debugfs_reg_access = &sca3300_debugfs_reg_access,  
> 
> Reading of the registers you will get as a bonus when switching over
> to regmap SPI API.
> 

