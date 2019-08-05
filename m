Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E891181DF1
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfHENuo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 09:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbfHENun (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453C82086D;
        Mon,  5 Aug 2019 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565013041;
        bh=cY16iu3KhNJAJ/bWT3UlvI0g6rGjeP3b0SDb82ZifGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w1oIyytiSAAVeRglYjhkbYpLENnGU4W+Go4SY2B8JxWEA3Zioq0n+5vry5KeiXNse
         XkW1pTZV6N34GPqEmucqrqX8SJdQZ4xuNdmg0nMYI7f7gfTKt1BzF+7znbV1P/kxJE
         G7C6ADuYvbqjKHI3xUMsZReX8YuQ/7ACvwvma/kc=
Date:   Mon, 5 Aug 2019 14:50:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: sc27xx: Change to polling mode to read data
Message-ID: <20190805145037.0a03f21e@archlinux>
In-Reply-To: <CAMz4kuLLSYw0JRLRVN-JegxZcK1bdv4K2m4mVu7oep6xfb+xxg@mail.gmail.com>
References: <1870ea18729f93fb36694affaf7e9443733dd988.1564035575.git.baolin.wang@linaro.org>
        <20190727182709.037fc595@archlinux>
        <CAMz4kuLLSYw0JRLRVN-JegxZcK1bdv4K2m4mVu7oep6xfb+xxg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jul 2019 10:19:48 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> Hi Jonathan,
> 
> On Sun, 28 Jul 2019 at 01:27, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 25 Jul 2019 14:33:50 +0800
> > Baolin Wang <baolin.wang@linaro.org> wrote:
> >  
> > > From: Freeman Liu <freeman.liu@unisoc.com>
> > >
> > > On Spreadtrum platform, the headphone will read one ADC channel multiple
> > > times to identify the headphone type, and the headphone identification is
> > > sensitive of the ADC reading time. And we found it will take longer time
> > > to reading ADC data by using interrupt mode comparing with the polling
> > > mode, thus we should change to polling mode to improve the efficiency
> > > of reading data, which can identify the headphone type successfully.
> > >
> > > Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>  
> >
> > Hi,
> >
> > My concerns with this sort of approach is that we may be sacrificing power
> > efficiency for some usecases to support one demanding one.
> >
> > The maximum sleep time is 1 second (I think) which is probably too long
> > to poll a register for in general.  
> 
> 1 second is the timeout time, that means something wrong when reading
> the data taking 1 second, and we will poll the register status every
> 500 us.
> From the testing, polling mode takes less time than interrupt mode
> when reading ADC data multiple times, so polling mode did not
> sacrifice power
> efficiency.

Hmm.  I'll go with a probably on that, depends on interrupt response
latency etc so isn't entirely obvious.  Faster response doesn't necessarily
mean lower power.

> 
> > Is there some way we can bound that time and perhaps switch between
> > interrupt and polling modes depending on how long we expect to wait?  
> 
> I do not think the interrupt mode is needed any more, since the ADC
> reading is so fast enough usually. Thanks.
The reason for interrupts in such devices is usually precisely the opposite.

You do it because things are slow enough that you can go to sleep
for a long time before the interrupt occurs.

So question becomes whether there are circumstances in which we are
running with long timescales and would benefit from using interrupts.

Thanks,

Jonathan


> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/adc/sc27xx_adc.c |   81 ++++++++++++++----------------------------
> > >  1 file changed, 27 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> > > index f7f7a189..ea864290 100644
> > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > @@ -3,7 +3,6 @@
> > >
> > >  #include <linux/hwspinlock.h>
> > >  #include <linux/iio/iio.h>
> > > -#include <linux/interrupt.h>
> > >  #include <linux/module.h>
> > >  #include <linux/nvmem-consumer.h>
> > >  #include <linux/of.h>
> > > @@ -46,14 +45,18 @@
> > >  /* Bits definitions for SC27XX_ADC_INT_CLR registers */
> > >  #define SC27XX_ADC_IRQ_CLR           BIT(0)
> > >
> > > +/* Bits definitions for SC27XX_ADC_INT_RAW registers */
> > > +#define SC27XX_ADC_IRQ_RAW           BIT(0)
> > > +
> > >  /* Mask definition for SC27XX_ADC_DATA register */
> > >  #define SC27XX_ADC_DATA_MASK         GENMASK(11, 0)
> > >
> > >  /* Timeout (ms) for the trylock of hardware spinlocks */
> > >  #define SC27XX_ADC_HWLOCK_TIMEOUT    5000
> > >
> > > -/* Timeout (ms) for ADC data conversion according to ADC datasheet */
> > > -#define SC27XX_ADC_RDY_TIMEOUT               100
> > > +/* Timeout (us) for ADC data conversion according to ADC datasheet */
> > > +#define SC27XX_ADC_RDY_TIMEOUT               1000000  
> >
> > This is 10 x the value I think...
> >  
> > > +#define SC27XX_ADC_POLL_RAW_STATUS   500
> > >
> > >  /* Maximum ADC channel number */
> > >  #define SC27XX_ADC_CHANNEL_MAX               32
> > > @@ -72,10 +75,8 @@ struct sc27xx_adc_data {
> > >        * subsystems which will access the unique ADC controller.
> > >        */
> > >       struct hwspinlock *hwlock;
> > > -     struct completion completion;
> > >       int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> > >       u32 base;
> > > -     int value;
> > >       int irq;
> > >  };
> > >
> > > @@ -188,9 +189,7 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> > >                          int scale, int *val)
> > >  {
> > >       int ret;
> > > -     u32 tmp;
> > > -
> > > -     reinit_completion(&data->completion);
> > > +     u32 tmp, value, status;
> > >
> > >       ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
> > >       if (ret) {
> > > @@ -203,6 +202,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> > >       if (ret)
> > >               goto unlock_adc;
> > >
> > > +     ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
> > > +                              SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
> > > +     if (ret)
> > > +             goto disable_adc;
> > > +
> > >       /* Configure the channel id and scale */
> > >       tmp = (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MASK;
> > >       tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
> > > @@ -226,15 +230,22 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> > >       if (ret)
> > >               goto disable_adc;
> > >
> > > -     ret = wait_for_completion_timeout(&data->completion,
> > > -                             msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
> > > -     if (!ret) {
> > > -             dev_err(data->dev, "read ADC data timeout\n");
> > > -             ret = -ETIMEDOUT;
> > > -     } else {
> > > -             ret = 0;
> > > +     ret = regmap_read_poll_timeout(data->regmap,
> > > +                                    data->base + SC27XX_ADC_INT_RAW,
> > > +                                    status, (status & SC27XX_ADC_IRQ_RAW),
> > > +                                    SC27XX_ADC_POLL_RAW_STATUS,
> > > +                                    SC27XX_ADC_RDY_TIMEOUT);
> > > +     if (ret) {
> > > +             dev_err(data->dev, "read adc timeout, status = 0x%x\n", status);
> > > +             goto disable_adc;
> > >       }
> > >
> > > +     ret = regmap_read(data->regmap, data->base + SC27XX_ADC_DATA, &value);
> > > +     if (ret)
> > > +             goto disable_adc;
> > > +
> > > +     value &= SC27XX_ADC_DATA_MASK;
> > > +
> > >  disable_adc:
> > >       regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> > >                          SC27XX_ADC_EN, 0);
> > > @@ -242,32 +253,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> > >       hwspin_unlock_raw(data->hwlock);
> > >
> > >       if (!ret)
> > > -             *val = data->value;
> > > +             *val = value;
> > >
> > >       return ret;
> > >  }
> > >
> > > -static irqreturn_t sc27xx_adc_isr(int irq, void *dev_id)
> > > -{
> > > -     struct sc27xx_adc_data *data = dev_id;
> > > -     int ret;
> > > -
> > > -     ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
> > > -                              SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
> > > -     if (ret)
> > > -             return IRQ_RETVAL(ret);
> > > -
> > > -     ret = regmap_read(data->regmap, data->base + SC27XX_ADC_DATA,
> > > -                       &data->value);
> > > -     if (ret)
> > > -             return IRQ_RETVAL(ret);
> > > -
> > > -     data->value &= SC27XX_ADC_DATA_MASK;
> > > -     complete(&data->completion);
> > > -
> > > -     return IRQ_HANDLED;
> > > -}
> > > -
> > >  static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
> > >                                 int channel, int scale,
> > >                                 u32 *div_numerator, u32 *div_denominator)
> > > @@ -454,11 +444,6 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
> > >       if (ret)
> > >               goto disable_adc;
> > >
> > > -     ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_EN,
> > > -                              SC27XX_ADC_IRQ_EN, SC27XX_ADC_IRQ_EN);
> > > -     if (ret)
> > > -             goto disable_clk;
> > > -
> > >       /* ADC channel scales' calibration from nvmem device */
> > >       ret = sc27xx_adc_scale_calibration(data, true);
> > >       if (ret)
> > > @@ -484,9 +469,6 @@ static void sc27xx_adc_disable(void *_data)
> > >  {
> > >       struct sc27xx_adc_data *data = _data;
> > >
> > > -     regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_EN,
> > > -                        SC27XX_ADC_IRQ_EN, 0);
> > > -
> > >       /* Disable ADC work clock and controller clock */
> > >       regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> > >                          SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
> > > @@ -553,7 +535,6 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
> > >               return ret;
> > >       }
> > >
> > > -     init_completion(&sc27xx_data->completion);
> > >       sc27xx_data->dev = &pdev->dev;
> > >
> > >       ret = sc27xx_adc_enable(sc27xx_data);
> > > @@ -569,14 +550,6 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
> > >               return ret;
> > >       }
> > >
> > > -     ret = devm_request_threaded_irq(&pdev->dev, sc27xx_data->irq, NULL,
> > > -                                     sc27xx_adc_isr, IRQF_ONESHOT,
> > > -                                     pdev->name, sc27xx_data);
> > > -     if (ret) {
> > > -             dev_err(&pdev->dev, "failed to request ADC irq\n");
> > > -             return ret;
> > > -     }
> > > -
> > >       indio_dev->dev.parent = &pdev->dev;
> > >       indio_dev->name = dev_name(&pdev->dev);
> > >       indio_dev->modes = INDIO_DIRECT_MODE;  
> >  
> 
> 

