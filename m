Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70978267F02
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgIMJqe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 05:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMJqe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 05:46:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96871207EA;
        Sun, 13 Sep 2020 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599990393;
        bh=nS7tdwelFh1tMDsGOhcEjwoqLslSJaYJdCD723Z0GVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hbXYJuHPbYKFDX4NZRTPDoxACdWSUEtWP/vt3NwBum9tw+bafmeSqofldmcelpLHW
         Z4LqTJdXCsOkxhNZeI1G8h3yu2dwxq/RCLNapzCQbPjBE3uamFKv8swpuTI2/2oKej
         gBq0Egid5h4tglLY8BLD4ZJG0X3ZrPZjeiv9VVe0=
Date:   Sun, 13 Sep 2020 10:46:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nishant Malpani <nish.malpani25@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: adxrs290: use hook for devm resource
 unwinding
Message-ID: <20200913104629.1b5db509@archlinux>
In-Reply-To: <CAHp75VeMJruyOCskBGZtyeR-p3sh7hLk2QH32LULAo7wSX3KUA@mail.gmail.com>
References: <20200910122711.16670-1-nish.malpani25@gmail.com>
        <CAHp75VeMJruyOCskBGZtyeR-p3sh7hLk2QH32LULAo7wSX3KUA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 16:51:26 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Sep 10, 2020 at 3:27 PM Nishant Malpani
> <nish.malpani25@gmail.com> wrote:
> >
> > Make use of devm_add_action_or_reset() hook to switch device into STANDBY
> > mode during standard resource unwinding. The patch includes a helper
> > function, in the form of adxrs290_set_mode(), to realise driving the
> > device into STANDBY mode.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Great thanks.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

> 
> > Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> > ---
> >  drivers/iio/gyro/adxrs290.c | 61 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> > index ff989536d2fb..2864eb443957 100644
> > --- a/drivers/iio/gyro/adxrs290.c
> > +++ b/drivers/iio/gyro/adxrs290.c
> > @@ -192,15 +192,70 @@ static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
> >         return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
> >  }
> >
> > +static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
> > +{
> > +       struct adxrs290_state *st = iio_priv(indio_dev);
> > +       int val, ret;
> > +
> > +       if (st->mode == mode)
> > +               return 0;
> > +
> > +       mutex_lock(&st->lock);
> > +
> > +       ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
> > +       if (ret < 0)
> > +               goto out_unlock;
> > +
> > +       val = ret;
> > +
> > +       switch (mode) {
> > +       case ADXRS290_MODE_STANDBY:
> > +               val &= ~ADXRS290_MEASUREMENT;
> > +               break;
> > +       case ADXRS290_MODE_MEASUREMENT:
> > +               val |= ADXRS290_MEASUREMENT;
> > +               break;
> > +       default:
> > +               ret = -EINVAL;
> > +               goto out_unlock;
> > +       }
> > +
> > +       ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_POWER_CTL, val);
> > +       if (ret < 0) {
> > +               dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
> > +               goto out_unlock;
> > +       }
> > +
> > +       /* update cached mode */
> > +       st->mode = mode;
> > +
> > +out_unlock:
> > +       mutex_unlock(&st->lock);
> > +       return ret;
> > +}
> > +
> > +static void adxrs290_chip_off_action(void *data)
> > +{
> > +       struct iio_dev *indio_dev = data;
> > +
> > +       adxrs290_set_mode(indio_dev, ADXRS290_MODE_STANDBY);
> > +}
> > +
> >  static int adxrs290_initial_setup(struct iio_dev *indio_dev)
> >  {
> >         struct adxrs290_state *st = iio_priv(indio_dev);
> > +       struct spi_device *spi = st->spi;
> > +       int ret;
> > +
> > +       ret = adxrs290_spi_write_reg(spi, ADXRS290_REG_POWER_CTL,
> > +                                    ADXRS290_MEASUREMENT | ADXRS290_TSM);
> > +       if (ret < 0)
> > +               return ret;
> >
> >         st->mode = ADXRS290_MODE_MEASUREMENT;
> >
> > -       return adxrs290_spi_write_reg(st->spi,
> > -                                     ADXRS290_REG_POWER_CTL,
> > -                                     ADXRS290_MEASUREMENT | ADXRS290_TSM);
> > +       return devm_add_action_or_reset(&spi->dev, adxrs290_chip_off_action,
> > +                                       indio_dev);
> >  }
> >
> >  static int adxrs290_read_raw(struct iio_dev *indio_dev,
> > --
> > 2.20.1
> >  
> 
> 

