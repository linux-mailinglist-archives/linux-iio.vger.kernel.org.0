Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79240105D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 16:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhIEOsP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 10:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEOsO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 10:48:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EBD4600CC;
        Sun,  5 Sep 2021 14:47:06 +0000 (UTC)
Date:   Sun, 5 Sep 2021 15:50:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v5 04/15] iio: adc: aspeed: Keep model data to driver data.
Message-ID: <20210905155029.3faa2c04@jic23-huawei>
In-Reply-To: <20210905153339.751732cc@jic23-huawei>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
        <20210831071458.2334-5-billy_tsai@aspeedtech.com>
        <20210905153339.751732cc@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Sep 2021 15:33:39 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 31 Aug 2021 15:14:47 +0800
> Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> 
> > Keep the model data pointer to driver data for reducing the usage of
> > of_device_get_match_data().
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> This one starts to be impacted by the fix (as its in the context).
> Rather than making a mess of things for linux-next etc I'll hold
> off on these until that fix is upstream in a few weeks.
> 
> If I seem to have lost it (it's been known to happen :( ) then
> feel free to poke me!

Having taken another look at the rest of the series (and Philipp's review)
please do a v6 starting from this patch.

Thanks,
Jonathan

> 
> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/adc/aspeed_adc.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> > index f055fe7b2c40..76ae1c3f584b 100644
> > --- a/drivers/iio/adc/aspeed_adc.c
> > +++ b/drivers/iio/adc/aspeed_adc.c
> > @@ -77,6 +77,7 @@ struct aspeed_adc_model_data {
> >  
> >  struct aspeed_adc_data {
> >  	struct device		*dev;
> > +	const struct aspeed_adc_model_data *model_data;
> >  	void __iomem		*base;
> >  	spinlock_t		clk_lock;
> >  	struct clk_hw		*clk_prescaler;
> > @@ -118,8 +119,6 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
> >  			       int *val, int *val2, long mask)
> >  {
> >  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> > -	const struct aspeed_adc_model_data *model_data =
> > -			of_device_get_match_data(data->dev);
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > @@ -127,7 +126,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
> >  		return IIO_VAL_INT;
> >  
> >  	case IIO_CHAN_INFO_SCALE:
> > -		*val = model_data->vref_voltage;
> > +		*val = data->model_data->vref_voltage;
> >  		*val2 = ASPEED_RESOLUTION_BITS;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  
> > @@ -146,13 +145,11 @@ static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
> >  				int val, int val2, long mask)
> >  {
> >  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> > -	const struct aspeed_adc_model_data *model_data =
> > -			of_device_get_match_data(data->dev);
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		if (val < model_data->min_sampling_rate ||
> > -			val > model_data->max_sampling_rate)
> > +		if (val < data->model_data->min_sampling_rate ||
> > +			val > data->model_data->max_sampling_rate)
> >  			return -EINVAL;
> >  
> >  		clk_set_rate(data->clk_scaler->clk,
> > @@ -198,7 +195,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
> >  {
> >  	struct iio_dev *indio_dev;
> >  	struct aspeed_adc_data *data;
> > -	const struct aspeed_adc_model_data *model_data;
> >  	const char *clk_parent_name;
> >  	int ret;
> >  	u32 adc_engine_control_reg_val;
> > @@ -209,6 +205,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
> >  
> >  	data = iio_priv(indio_dev);
> >  	data->dev = &pdev->dev;
> > +	data->model_data = of_device_get_match_data(&pdev->dev);
> >  	platform_set_drvdata(pdev, indio_dev);
> >  
> >  	data->base = devm_platform_ioremap_resource(pdev, 0);
> > @@ -249,9 +246,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
> >  	}
> >  	reset_control_deassert(data->rst);
> >  
> > -	model_data = of_device_get_match_data(&pdev->dev);
> > -
> > -	if (model_data->wait_init_sequence) {
> > +	if (data->model_data->wait_init_sequence) {
> >  		/* Enable engine in normal mode. */
> >  		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
> >  				  ASPEED_ADC_OP_MODE_NORMAL) |
> > @@ -281,8 +276,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
> >  	writel(adc_engine_control_reg_val,
> >  	       data->base + ASPEED_REG_ENGINE_CONTROL);
> >  
> > -	model_data = of_device_get_match_data(&pdev->dev);
> > -	indio_dev->name = model_data->model_name;
> > +	indio_dev->name = data->model_data->model_name;
> >  	indio_dev->info = &aspeed_adc_iio_info;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->channels = aspeed_adc_iio_channels;  
> 

