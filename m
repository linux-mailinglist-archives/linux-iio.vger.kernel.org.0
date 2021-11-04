Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39CA44593C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 19:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhKDSE7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 14:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233980AbhKDSE7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Nov 2021 14:04:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4287611C0;
        Thu,  4 Nov 2021 18:02:19 +0000 (UTC)
Date:   Thu, 4 Nov 2021 18:06:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: at91-sama5d2: Fix incorrect cast to
 platform_device
Message-ID: <20211104180655.0a4e71d4@jic23-huawei>
In-Reply-To: <33f810ad-a12a-af2e-256e-ab63915b0f37@microchip.com>
References: <20211019082929.30503-1-lars@metafoo.de>
        <20211028153449.487fdaac@jic23-huawei>
        <67c888ec-3f24-e92f-5840-24583138fa6d@microchip.com>
        <33f810ad-a12a-af2e-256e-ab63915b0f37@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Nov 2021 12:30:57 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 10/28/21 5:39 PM, Eugen Hristev - M18282 wrote:
> > On 10/28/21 5:34 PM, Jonathan Cameron wrote:  
> >> On Tue, 19 Oct 2021 10:29:28 +0200
> >> Lars-Peter Clausen <lars@metafoo.de> wrote:
> >>  
> >>> The at91-sama5d2 driver calls `to_platform_device()` on a struct device
> >>> that is part of a IIO device. This is incorrect since
> >>> `to_platform_device()` must only be called on a struct device that is part
> >>> of a platform device.
> >>>
> >>> The code still works by accident because non of the struct platform_device
> >>> specific fields are accessed.
> >>>
> >>> Refactor the code a bit so that it behaves identically, but does not use
> >>> the incorrect cast. This avoids accidentally adding undefined behavior in
> >>> the future by assuming the `struct platform_device` is actually valid.
> >>>
> >>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> >>
> >> This makes me nervous for the reason you give below.
> >> Looking for a response from Eugen or someone else with access to the device
> >> before I apply this one.  
> > 
> > Hi,
> > 
> > I will take some time to test this on my setup. Thanks for the patch,
> > and sorry for the delays !
> > 
> > Eugen  
> 
> Hello Jonathan and Lars,
> 
> Sorry for the delay,
> 
> I have applied the patches in my tree and tested basic DMA transfers 
> (sanity checks) on my board.
> It looks to be fine. Have not found any weird or non functioning behavior.
> 
> You can add my
> Tested-by: Eugen Hristev <eugen.hristev@microchip.com>
I've queued this up now, but hope Lars can address the questions below.

Thanks,

Jonathan

> 
> About the query below,
> >   
> >>
> >> Thanks,
> >>
> >> Jonathan
> >>  
> >>> ---
> >>> The code is equivalent to before, but I'm a bit confused how this works.
> >>> We call dma_request_chan() on the IIO device's struct device. Which should
> >>> not yield any results.
> >>>
> >>> Eugen can you check if/why this works and see if a follow up patch using
> >>> the right struct device (the platform_device's) to request the DMA channel
> >>> makes sense?  
> 
> I do not fully understand the problem yet. Why should dma_request_chan 
> on the iio dev should not yield any results? the dma channel is 
> allocated and it worked so far.
> 
> I tried to following: save the pdev pointer in the state struct, and 
> then use dma_request_chan on the pdev->dev . It still works and I could 
> not find any difference in functionality in basic sanity checks.
> 
> I believe that the dma_request_chan wants a valid struct device. If it's 
> iio's dev or platform device's dev, it doesn't seem to matter at the 
> first glance.
> 
> Could you please detail a bit how it should be used ?
> 
> Thanks,
> Eugen
> 
> >>> ---
> >>>    drivers/iio/adc/at91-sama5d2_adc.c | 34 ++++++++++++++----------------
> >>>    1 file changed, 16 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >>> index 4c922ef634f8..3841e7b6c81d 100644
> >>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >>> @@ -1661,10 +1661,9 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
> >>>         }
> >>>    }
> >>>
> >>> -static void at91_adc_dma_init(struct platform_device *pdev)
> >>> +static void at91_adc_dma_init(struct at91_adc_state *st)
> >>>    {
> >>> -     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >>> -     struct at91_adc_state *st = iio_priv(indio_dev);
> >>> +     struct device *dev = &st->indio_dev->dev;
> >>>         struct dma_slave_config config = {0};
> >>>         /* we have 2 bytes for each channel */
> >>>         unsigned int sample_size = st->soc_info.platform->nr_channels * 2;
> >>> @@ -1679,9 +1678,9 @@ static void at91_adc_dma_init(struct platform_device *pdev)
> >>>         if (st->dma_st.dma_chan)
> >>>                 return;
> >>>
> >>> -     st->dma_st.dma_chan = dma_request_chan(&pdev->dev, "rx");
> >>> +     st->dma_st.dma_chan = dma_request_chan(dev, "rx");
> >>>         if (IS_ERR(st->dma_st.dma_chan))  {
> >>> -             dev_info(&pdev->dev, "can't get DMA channel\n");
> >>> +             dev_info(dev, "can't get DMA channel\n");
> >>>                 st->dma_st.dma_chan = NULL;
> >>>                 goto dma_exit;
> >>>         }
> >>> @@ -1691,7 +1690,7 @@ static void at91_adc_dma_init(struct platform_device *pdev)
> >>>                                                &st->dma_st.rx_dma_buf,
> >>>                                                GFP_KERNEL);
> >>>         if (!st->dma_st.rx_buf) {
> >>> -             dev_info(&pdev->dev, "can't allocate coherent DMA area\n");
> >>> +             dev_info(dev, "can't allocate coherent DMA area\n");
> >>>                 goto dma_chan_disable;
> >>>         }
> >>>
> >>> @@ -1704,11 +1703,11 @@ static void at91_adc_dma_init(struct platform_device *pdev)
> >>>         config.dst_maxburst = 1;
> >>>
> >>>         if (dmaengine_slave_config(st->dma_st.dma_chan, &config)) {
> >>> -             dev_info(&pdev->dev, "can't configure DMA slave\n");
> >>> +             dev_info(dev, "can't configure DMA slave\n");
> >>>                 goto dma_free_area;
> >>>         }
> >>>
> >>> -     dev_info(&pdev->dev, "using %s for rx DMA transfers\n",
> >>> +     dev_info(dev, "using %s for rx DMA transfers\n",
> >>>                  dma_chan_name(st->dma_st.dma_chan));
> >>>
> >>>         return;
> >>> @@ -1720,13 +1719,12 @@ static void at91_adc_dma_init(struct platform_device *pdev)
> >>>         dma_release_channel(st->dma_st.dma_chan);
> >>>         st->dma_st.dma_chan = NULL;
> >>>    dma_exit:
> >>> -     dev_info(&pdev->dev, "continuing without DMA support\n");
> >>> +     dev_info(dev, "continuing without DMA support\n");
> >>>    }
> >>>
> >>> -static void at91_adc_dma_disable(struct platform_device *pdev)
> >>> +static void at91_adc_dma_disable(struct at91_adc_state *st)
> >>>    {
> >>> -     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >>> -     struct at91_adc_state *st = iio_priv(indio_dev);
> >>> +     struct device *dev = &st->indio_dev->dev;
> >>>         /* we have 2 bytes for each channel */
> >>>         unsigned int sample_size = st->soc_info.platform->nr_channels * 2;
> >>>         unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
> >>> @@ -1744,7 +1742,7 @@ static void at91_adc_dma_disable(struct platform_device *pdev)
> >>>         dma_release_channel(st->dma_st.dma_chan);
> >>>         st->dma_st.dma_chan = NULL;
> >>>
> >>> -     dev_info(&pdev->dev, "continuing without DMA support\n");
> >>> +     dev_info(dev, "continuing without DMA support\n");
> >>>    }
> >>>
> >>>    static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> >>> @@ -1770,9 +1768,9 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> >>>          */
> >>>
> >>>         if (val == 1)
> >>> -             at91_adc_dma_disable(to_platform_device(&indio_dev->dev));
> >>> +             at91_adc_dma_disable(st);
> >>>         else if (val > 1)
> >>> -             at91_adc_dma_init(to_platform_device(&indio_dev->dev));
> >>> +             at91_adc_dma_init(st);
> >>>
> >>>         /*
> >>>          * We can start the DMA only after setting the watermark and
> >>> @@ -1780,7 +1778,7 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> >>>          */
> >>>         ret = at91_adc_buffer_prepare(indio_dev);
> >>>         if (ret)
> >>> -             at91_adc_dma_disable(to_platform_device(&indio_dev->dev));
> >>> +             at91_adc_dma_disable(st);
> >>>
> >>>         return ret;
> >>>    }
> >>> @@ -2077,7 +2075,7 @@ static int at91_adc_probe(struct platform_device *pdev)
> >>>         return 0;
> >>>
> >>>    dma_disable:
> >>> -     at91_adc_dma_disable(pdev);
> >>> +     at91_adc_dma_disable(st);
> >>>    per_clk_disable_unprepare:
> >>>         clk_disable_unprepare(st->per_clk);
> >>>    vref_disable:
> >>> @@ -2094,7 +2092,7 @@ static int at91_adc_remove(struct platform_device *pdev)
> >>>
> >>>         iio_device_unregister(indio_dev);
> >>>
> >>> -     at91_adc_dma_disable(pdev);
> >>> +     at91_adc_dma_disable(st);
> >>>
> >>>         clk_disable_unprepare(st->per_clk);
> >>>  
> >>  
> >   
> 

