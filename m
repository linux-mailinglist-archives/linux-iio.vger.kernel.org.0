Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB238D6F2
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhEVS3Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhEVS3Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 14:29:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EFE610C8;
        Sat, 22 May 2021 18:27:59 +0000 (UTC)
Date:   Sat, 22 May 2021 19:29:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/8] iio: adc: ti-adc108s102: Use devm managed functions
 for all of probe()
Message-ID: <20210522192921.10361b8b@jic23-huawei>
In-Reply-To: <CAASAkoZxvz05Q3ep4uQH=Zh7xehZPPSRmC=y+xP18MAdsymjSw@mail.gmail.com>
References: <20210516172520.1398835-1-jic23@kernel.org>
        <20210516172520.1398835-8-jic23@kernel.org>
        <CAASAkoYqGqwQcHZpSJHBZp+t_9bAZ04DSqAzM9=yHB4aaj_VWw@mail.gmail.com>
        <CAASAkoZxvz05Q3ep4uQH=Zh7xehZPPSRmC=y+xP18MAdsymjSw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 May 2021 10:37:31 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> On Mon, 17 May 2021 at 10:31, Alexandru Ardelean <aardelean@deviqon.com> wrote:
> >
> > On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Simplifies error handling and lets us drop remove() entirely.
> > >  
> >  
> 
> // Removed Bogdan's email; it's not working;
> Apologies to return on this.
> This note can be disregarded, but this patch could do a direct return
> for devm_iio_device_register().
> It doesn't make much sense to print a failure there as that can be
> also viewed via some broader kernel logging.
> But it's also fine to leave it.

Whilst I agree in the sense I would never have put it there in the first place
myself, I wanted this series to be one with no visible changes so
I'd rather leave it in place.

Thanks,

Jonathan
> 
> > Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
> >
> >  
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Bogdan Pricop <bogdan.pricop@emutex.com>
> > > ---
> > >  drivers/iio/adc/ti-adc108s102.c | 45 +++++++++++----------------------
> > >  1 file changed, 15 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> > > index 183b2245e89b..db902aef2abe 100644
> > > --- a/drivers/iio/adc/ti-adc108s102.c
> > > +++ b/drivers/iio/adc/ti-adc108s102.c
> > > @@ -215,6 +215,11 @@ static const struct iio_info adc108s102_info = {
> > >         .update_scan_mode       = &adc108s102_update_scan_mode,
> > >  };
> > >
> > > +static void adc108s102_reg_disable(void *reg)
> > > +{
> > > +       regulator_disable(reg);
> > > +}
> > > +
> > >  static int adc108s102_probe(struct spi_device *spi)
> > >  {
> > >         struct adc108s102_state *st;
> > > @@ -239,6 +244,10 @@ static int adc108s102_probe(struct spi_device *spi)
> > >                         dev_err(&spi->dev, "Cannot enable vref regulator\n");
> > >                         return ret;
> > >                 }
> > > +               ret = devm_add_action_or_reset(&spi->dev, adc108s102_reg_disable,
> > > +                                              st->reg);
> > > +               if (ret)
> > > +                       return ret;
> > >
> > >                 ret = regulator_get_voltage(st->reg);
> > >                 if (ret < 0) {
> > > @@ -249,7 +258,6 @@ static int adc108s102_probe(struct spi_device *spi)
> > >                 st->va_millivolt = ret / 1000;
> > >         }
> > >
> > > -       spi_set_drvdata(spi, indio_dev);
> > >         st->spi = spi;
> > >
> > >         indio_dev->name = spi->modalias;
> > > @@ -266,40 +274,18 @@ static int adc108s102_probe(struct spi_device *spi)
> > >         spi_message_init_with_transfers(&st->scan_single_msg,
> > >                                         &st->scan_single_xfer, 1);
> > >
> > > -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > > -                                        &adc108s102_trigger_handler, NULL);
> > > +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> > > +                                             &adc108s102_trigger_handler,
> > > +                                             NULL);
> > >         if (ret)
> > > -               goto error_disable_reg;
> > > +               return ret;
> > >
> > > -       ret = iio_device_register(indio_dev);
> > > -       if (ret) {
> > > +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> > > +       if (ret)
> > >                 dev_err(&spi->dev, "Failed to register IIO device\n");
> > > -               goto error_cleanup_triggered_buffer;
> > > -       }
> > > -       return 0;
> > > -
> > > -error_cleanup_triggered_buffer:
> > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > -
> > > -error_disable_reg:
> > > -       regulator_disable(st->reg);
> > > -
> > >         return ret;
> > >  }
> > >
> > > -static int adc108s102_remove(struct spi_device *spi)
> > > -{
> > > -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > > -       struct adc108s102_state *st = iio_priv(indio_dev);
> > > -
> > > -       iio_device_unregister(indio_dev);
> > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > -
> > > -       regulator_disable(st->reg);
> > > -
> > > -       return 0;
> > > -}
> > > -
> > >  static const struct of_device_id adc108s102_of_match[] = {
> > >         { .compatible = "ti,adc108s102" },
> > >         { }
> > > @@ -327,7 +313,6 @@ static struct spi_driver adc108s102_driver = {
> > >                 .acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
> > >         },
> > >         .probe          = adc108s102_probe,
> > > -       .remove         = adc108s102_remove,
> > >         .id_table       = adc108s102_id,
> > >  };
> > >  module_spi_driver(adc108s102_driver);
> > > --
> > > 2.31.1
> > >  

