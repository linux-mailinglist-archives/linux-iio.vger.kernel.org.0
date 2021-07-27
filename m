Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0244F3D7018
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhG0HNv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 27 Jul 2021 03:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhG0HNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 03:13:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0568C061757
        for <linux-iio@vger.kernel.org>; Tue, 27 Jul 2021 00:13:51 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8HHe-0000Ja-EO; Tue, 27 Jul 2021 09:13:46 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8HHc-0004RL-LK; Tue, 27 Jul 2021 09:13:44 +0200
Message-ID: <f23358e3e040cc8522b259669ec61a22c5439394.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Renesas RZ/G2L A/D
 converter
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Date:   Tue, 27 Jul 2021 09:13:44 +0200
In-Reply-To: <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Prabhakar,

On Mon, 2021-07-26 at 19:28 +0100, Lad Prabhakar wrote:
> Add ADC driver support for Renesas RZ/G2L A/D converter in SW
> trigger mode.
> 
> A/D Converter block is a successive approximation analog-to-digital
> converter with a 12-bit accuracy and supports a maximum of 8 input
> channels.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  MAINTAINERS                 |   8 +
>  drivers/iio/adc/Kconfig     |  10 +
>  drivers/iio/adc/Makefile    |   1 +
>  drivers/iio/adc/rzg2l_adc.c | 595 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 614 insertions(+)
>  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> 
[...]
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> new file mode 100644
> index 000000000000..d05a3208ff9d
> --- /dev/null
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -0,0 +1,595 @@
[...]
> +static void rzg2l_adc_pm_runtime_disable(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +
> +	pm_runtime_disable(indio_dev->dev.parent);
> +}
> +
> +static void rzg2l_adc_reset_assert(void *data)
> +{
> +	struct reset_control *reset = data;
> +
> +	reset_control_assert(reset);
> +}
> +
> +static int rzg2l_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct rzg2l_adc *adc;
> +	int ret;
> +	int irq;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +
> +	ret = rzg2l_adc_parse_properties(pdev, adc);
> +	if (ret)
> +		return ret;
> +
> +	adc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->base))
> +		return PTR_ERR(adc->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no irq resource\n");
> +		return irq;
> +	}
> +
> +	adc->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(adc->pclk)) {
> +		dev_err(dev, "Failed to get pclk");
> +		return PTR_ERR(adc->pclk);
> +	}
> +
> +	adc->adclk = devm_clk_get(dev, "adclk");
> +	if (IS_ERR(adc->adclk)) {
> +		dev_err(dev, "Failed to get adclk");
> +		return PTR_ERR(adc->adclk);
> +	}
> +
> +	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
> +	if (IS_ERR(adc->adrstn)) {
> +		dev_err(dev, "failed to get adrstn\n");
> +		return PTR_ERR(adc->adrstn);
> +	}

I'd request the "presetn" control up here, so if that fails we don't
touch the "adrst-n" reset line.

> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_adc_reset_assert, adc->adrstn);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
> +			ret);
> +		return ret;
> +	}

This is the wrong way around. Installing devres actions should be done
after the thing they are supposed to revert in case of error. You should
move this down below the reset_control_deassert(adc->adrstn).

> +
> +	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
> +	if (IS_ERR(adc->presetn)) {
> +		dev_err(dev, "failed to get presetn\n");
> +		return PTR_ERR(adc->presetn);
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_adc_reset_assert, adc->presetn);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register presetn assert devm action, %d\n",
> +			ret);
> +		return ret;
> +	}

Same as above, this belongs after the presetn deassert below.

> +
> +	ret = reset_control_deassert(adc->adrstn);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
> +		return ret;
> +	}

Here is the place to install the adrstn assert action.

> +	ret = reset_control_deassert(adc->presetn);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n", ret);
> +		return ret;
> +	}

And here is the place to install the presetn assert action.

regards
Philipp
