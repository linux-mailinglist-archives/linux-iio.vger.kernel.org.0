Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7658B69B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiHFPwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFPwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 11:52:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A7EE0C0;
        Sat,  6 Aug 2022 08:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBAB0B801B8;
        Sat,  6 Aug 2022 15:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F536C433C1;
        Sat,  6 Aug 2022 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659801139;
        bh=rjJcGRiMxO3Dgy+zA6oxTwRdcgUNPc4FVsnQFLWLgeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LBTWpY511sVEhVDjOMAAzpeMha3rxlEAHt0vvtPX9N6Y6WAld1gCALguhZ2fHggNl
         eJcowERwrCQCi+SHr0tltZ5vwVMfg1J/+1RhOjEkXGsuMcsIaEbD+w9JqX2auqzuA7
         xmVXxYuVMcAt4iRLewP8Qgqv9vVu6ZiKrmuwQEE+FCijzrcbmxWZn20h6lPZS4/XYW
         gw0TVdQtMLXGX7AlhjHFmO8hPe0r7GA5rPnTV0/bsrZAsS5ZOCFN6LTL1pFiKJgqUn
         NRRnDR/nK3Q/+q3oof4AMeESicWDvxxC7L3wQJRnwuB+69pCmIHdG2vztdWP1CG1pT
         9KPwLlhihuTXA==
Date:   Sat, 6 Aug 2022 17:02:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: add imx93 adc support
Message-ID: <20220806170237.1c664675@jic23-huawei>
In-Reply-To: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
References: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 Aug 2022 17:12:25 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The ADC in i.mx93 is a total new ADC IP, add a driver to support
> this ADC.
> 
> Currently, only support one shot normal conversion triggered by
> software. For other mode, will add in future.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Nice.

A few comments inline.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> new file mode 100644
> index 000000000000..6e3cf6d3e629
> --- /dev/null
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -0,0 +1,448 @@

...

> +
> +/* ADC status */
> +#define IDLE			0

Very generic names that are likely to clash with some define in a header
introduced in the future.  Prefix them all with IMX93_ADC_ to scope
them to this driver.

> +#define POWER_DOWN		1
> +#define WAIT_STATE		2
> +#define BUSY_IN_CALIBRATION	3
> +#define SAMPLE			4
> +#define CONVERSION		6
> +
> +#define IMX93_ADC_TIMEOUT		msecs_to_jiffies(100)
> +
> +struct imx93_adc {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *ipg_clk;
> +	struct regulator *vref;
> +	struct mutex lock;

All locks should have documentation to explain what data they are protecting
(that can be in memory, or in the registers etc, or on a bus, but it's normally
some sort of data).

> +	struct completion completion;
> +};
> +
> +#define IMX93_ADC_CHAN(_idx) {					\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = (_idx),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static const struct iio_chan_spec imx93_adc_iio_channels[] = {
> +	IMX93_ADC_CHAN(0),
> +	IMX93_ADC_CHAN(1),
> +	IMX93_ADC_CHAN(2),
> +	IMX93_ADC_CHAN(3),
> +};
> +
> +static void imx93_adc_power_down(struct imx93_adc *adc)
> +{
> +	u32 mcr, msr;
> +	int ret;
> +
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr |= FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	ret = readl_poll_timeout(adc->regs + IMX93_ADC_MSR, msr,
> +		((msr & IMX93_ADC_MSR_ADCSTATUS_MASK) == POWER_DOWN), 1, 50);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(adc->dev,
> +			 "ADC do not in power down mode, current MSR is %x\n",
> +			 msr);
> +}
> +
> +static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
> +{
> +	u32 mcr;
> +
> +	/* put adc in power down mode */
> +	imx93_adc_power_down(adc);
> +
> +	/* config the AD_CLK equal to bus clock */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr |= FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	/* bring ADC out of power down state, in idle state */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +}
> +
> +static int imx93_adc_calibration(struct imx93_adc *adc)
> +{
> +	u32 mcr, msr, adc_status;
> +	int ret;
> +
> +	/* make sure ADC in power down mode */

Is the (noop) write that would otherwise occur worth the code complexity here.
Putting it another way, why not just call imx93_adc_powerdown() unconditionally
and simplify this code?

> +	msr = readl(adc->regs + IMX93_ADC_MSR);
> +	adc_status = FIELD_GET(IMX93_ADC_MSR_ADCSTATUS_MASK, msr);
> +	if (adc_status != POWER_DOWN)
> +		imx93_adc_power_down(adc);
> +
> +	/* config SAR controller operating clock */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	/* bring ADC out of power down state */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	/*
> +	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
> +	 * can add the setting of these bit if need in future.
> +	 */
> +
> +	/* run calibration */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr |= FIELD_PREP(IMX93_ADC_MCR_CALSTART_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	/* wait calibration to be finished */
> +	ret = readl_poll_timeout(adc->regs + IMX93_ADC_MSR, msr,
> +		!(msr & IMX93_ADC_MSR_CALBUSY_MASK), 1000, 2000000);
> +	if (ret == -ETIMEDOUT) {
> +		dev_warn(adc->dev, "ADC do not finish calibration in 1 min!\n");
> +		return ret;
> +	}
> +
> +	/* check whether calbration is success or not */
> +	msr = readl(adc->regs + IMX93_ADC_MSR);
> +	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
> +		dev_warn(adc->dev, "ADC calibration failed!\n");
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx93_adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct imx93_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +	u32 channel;
> +	u32 imr, mcr, pcda;
> +	long ret;
> +	u32 vref_uv;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

This is a big block.  For readability I'd suggest factoring the channel read part out as
a separate function that you then call from here.  Perhaps leaving hte runtime pm code and
locking external to that call.

> +		pm_runtime_get_sync(dev);
> +		mutex_lock(&adc->lock);
> +
> +		reinit_completion(&adc->completion);
> +
> +		/* config channel mask register */
> +		channel = 1 << chan->channel;
> +		writel(channel, adc->regs + IMX93_ADC_NCMR0);
> +
> +		/* TODO: can config desired sample time in CTRn if need */
> +
> +		/* config interrupt mask */
> +		imr = FIELD_PREP(IMX93_ADC_IMR_EOC_MASK, 1);
> +		writel(imr, adc->regs + IMX93_ADC_IMR);
> +		writel(channel, adc->regs + IMX93_ADC_CIMR0);
> +
> +		/* config one-shot mode */
> +		mcr = readl(adc->regs + IMX93_ADC_MCR);
> +		mcr &= ~FIELD_PREP(IMX93_ADC_MCR_MODE_MASK, 1);
> +		writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +		/* start normal conversion */
> +		mcr = readl(adc->regs + IMX93_ADC_MCR);
> +		mcr |= FIELD_PREP(IMX93_ADC_MCR_NSTART_MASK, 1);
> +		writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +		ret = wait_for_completion_interruptible_timeout(&adc->completion,
> +								IMX93_ADC_TIMEOUT);
> +		if (ret == 0) {
> +			mutex_unlock(&adc->lock);
> +			return -ETIMEDOUT;
> +		}
> +		if (ret < 0) {
> +			mutex_unlock(&adc->lock);
> +			return ret;
> +		}
> +
> +		pcda = readl(adc->regs + IMX93_ADC_PCDR0 + chan->channel * 4);
> +
> +		*val = FIELD_GET(IMX93_ADC_PCDR_CDATA_MASK, pcda);
> +
> +		mutex_unlock(&adc->lock);
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_sync_autosuspend(dev);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		vref_uv = regulator_get_voltage(adc->vref);

IIRC Can return an error.  You should check and pass that error on if there
is one.

> +		*val = vref_uv / 1000;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = clk_get_rate(adc->ipg_clk);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t imx93_adc_isr(int irq, void *dev_id)
> +{
> +	struct imx93_adc *adc = dev_id;
> +	u32 isr;
> +
> +	isr = readl(adc->regs + IMX93_ADC_ISR);
> +	writel(isr, adc->regs + IMX93_ADC_ISR);

I'm 'guessing' that ISR had multiple bits reflecting different
causes of the interrupt.  Normally we'd only want to clear
those bits that correspond to things we are expecting +
return IRQ_NONE if none of the bits we expect to see set are
(spurious interrupt).

> +
> +	if (FIELD_GET(IMX93_ADC_ISR_EOC_MASK, isr))
> +		complete(&adc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info imx93_adc_iio_info = {
> +	.read_raw = &imx93_adc_read_raw,
> +};
> +
> +static int imx93_adc_probe(struct platform_device *pdev)
> +{
> +	struct imx93_adc *adc;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	int irq, ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		dev_err(dev, "Failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev = dev;
> +
> +	mutex_init(&adc->lock);
> +	adc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->regs))
> +		return PTR_ERR(adc->regs);
> +
> +	/* The third irq is for ADC conversion usage */
> +	irq = platform_get_irq(pdev, 2);
> +	if (irq < 0)
> +		return irq;
> +
> +	adc->ipg_clk = devm_clk_get(dev, "ipg");
> +	if (IS_ERR(adc->ipg_clk))
> +		return dev_err_probe(dev, PTR_ERR(adc->ipg_clk),
> +				     "Failed getting clock\n");
> +
> +	adc->vref = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(adc->vref))
> +		return dev_err_probe(dev, PTR_ERR(adc->vref),
> +				     "Failed getting reference voltage\n");
> +
> +	ret = regulator_enable(adc->vref);
> +	if (ret) {
> +		dev_err(dev, "Can't enable adc reference top voltage\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&adc->completion);
> +
> +	indio_dev->name = IMX93_ADC_DRIVER_NAME;
> +	indio_dev->info = &imx93_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = imx93_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(imx93_adc_iio_channels);
> +
> +	ret = clk_prepare_enable(adc->ipg_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not prepare or enable the clock.\n");
> +		return ret;

Regulator left powered up.  You need another label in the error handling below
and appropriate goto.


> +	}
> +
> +	ret = devm_request_irq(dev, irq, imx93_adc_isr, 0, IMX93_ADC_DRIVER_NAME, adc);

Do not mix devm managed and non devm managed code.  That just needs to difficult
to reason about ordering in remove.  Two options to make this easy.

1) After the first non devm_ managed call (here the regulator_enable() above,
  stop using devm_ calls at all.
2) Use devm_add_action_or_reset() to register custom cleanup callbacks so that
   you can get rid of the remove() function and still guarantee the ordering
   is what is expected (almost always should be reverse of what is in probe())

I prefer option 2 personally but either is fine.  It can get a little fiddly to
get runtime pm tear down right when using devm to do it.


> +	if (ret < 0) {
> +		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
> +		goto error_ipg_clk_disable;
> +	}
> +
> +	ret = imx93_adc_calibration(adc);
> +	if (ret < 0)
> +		goto error_ipg_clk_disable;
> +
> +	imx93_adc_config_ad_clk(adc);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register the device.\n");
> +		goto error_ipg_clk_disable;
> +	}
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +
> +error_ipg_clk_disable:
> +	clk_disable_unprepare(adc->ipg_clk);
> +	regulator_disable(adc->vref);
> +
> +	return ret;
> +}
> +
> +static int imx93_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct imx93_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +
> +	pm_runtime_get_sync(dev);

I would prefer to see  the runtime pm tear down all up here
as it corresponds to the setup at the end of probe()
I don't it will make any functional difference and it makes
the code easier to reason about in terms of ordering of calls.

> +
> +	iio_device_unregister(indio_dev);
> +	imx93_adc_power_down(adc);
> +	clk_disable_unprepare(adc->ipg_clk);
> +	regulator_disable(adc->vref);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +
> +	return 0;
> +}
> +
> +static int imx93_adc_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct imx93_adc *adc = iio_priv(indio_dev);
> +
> +	imx93_adc_power_down(adc);
> +	clk_disable_unprepare(adc->ipg_clk);
> +	regulator_disable(adc->vref);
> +
> +	return 0;
> +}
> +
> +static int imx93_adc_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct imx93_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +	u32 mcr;
> +
> +	ret = regulator_enable(adc->vref);
> +	if (ret) {
> +		dev_err(dev,
> +			"Can't enable adc reference top voltage, err = %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(adc->ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "Could not prepare or enable clock.\n");
> +		goto err_disable_reg;
> +	}
> +
> +	/* bring ADC out of power down state, in idle state */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);

This 'power_up' code block occurs quite a few times. Probably
worth factoring out as a separate call alongside imx93_adc_power_down()

> +
> +	return 0;
> +
> +err_disable_reg:
> +	regulator_disable(adc->vref);
> +
> +	return ret;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(imx93_adc_pm_ops,
> +				 imx93_adc_runtime_suspend,
> +				 imx93_adc_runtime_resume, NULL);
> +
> +static const struct of_device_id imx93_adc_match[] = {
> +	{ .compatible = "nxp,imx93-adc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx93_adc_match);
> +
> +static struct platform_driver imx93_adc_driver = {
> +	.probe		= imx93_adc_probe,
> +	.remove		= imx93_adc_remove,
> +	.driver		= {
> +		.name	= IMX93_ADC_DRIVER_NAME,
> +		.of_match_table = imx93_adc_match,
> +		.pm	= pm_ptr(&imx93_adc_pm_ops),
> +	},
> +};
> +
> +module_platform_driver(imx93_adc_driver);
> +
> +MODULE_DESCRIPTION("NXP i.MX93 ADC driver");
> +MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
> +MODULE_LICENSE("GPL");

