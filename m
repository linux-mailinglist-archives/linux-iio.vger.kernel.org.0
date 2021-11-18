Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC6455BFD
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 13:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbhKRM7M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 07:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbhKRM5S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 07:57:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC61C079791
        for <linux-iio@vger.kernel.org>; Thu, 18 Nov 2021 04:51:51 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mngtJ-0000oU-Qc; Thu, 18 Nov 2021 13:51:49 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] iio: adc: stm32: fix null pointer on defer_probe error
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20211118123952.15383-1-olivier.moysan@foss.st.com>
Message-ID: <45a5129a-c0b1-4a07-aef8-d6e0845c7b1a@pengutronix.de>
Date:   Thu, 18 Nov 2021 13:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118123952.15383-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Olivier,

On 18.11.21 13:39, Olivier Moysan wrote:
> dev_err_probe() calls __device_set_deferred_probe_reason()
> on -EPROBE_DEFER error.
> If device pointer to driver core private structure is not initialized,
> a null pointer error occurs.
> This pointer is set too late on iio_device_register() call, for iio device.

Even if it were set earlier, you should call dev_err_probe with the dev of
the probe that's currently running. Not any other devices you created since
then.

> So use parent device instead for dev_err_probe() call.
> 
> Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 7f1fb36c747c..14c7c9d390e8 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -217,6 +217,7 @@ struct stm32_adc_cfg {
>  
>  /**
>   * struct stm32_adc - private data of each ADC IIO instance
> + * dev:			parent device
>   * @common:		reference to ADC block common data
>   * @offset:		ADC instance register offset in ADC block
>   * @cfg:		compatible configuration data
> @@ -243,6 +244,7 @@ struct stm32_adc_cfg {
>   * @int_ch:		internal channel indexes array
>   */
>  struct stm32_adc {
> +	struct device		*dev;

Can't you use the parent pointer of the indio_dev?

>  	struct stm32_adc_common	*common;
>  	u32			offset;
>  	const struct stm32_adc_cfg	*cfg;
> @@ -1986,8 +1988,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>  			/* Get calibration data for vrefint channel */
>  			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
>  			if (ret && ret != -ENOENT) {
> -				return dev_err_probe(&indio_dev->dev, ret,
> -						     "nvmem access error\n");
> +				return dev_err_probe(adc->dev, ret, "nvmem access error\n");
>  			}
>  			if (ret == -ENOENT)
>  				dev_dbg(&indio_dev->dev, "vrefint calibration not found\n");
> @@ -2221,6 +2222,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	init_completion(&adc->completion);
>  	adc->cfg = (const struct stm32_adc_cfg *)
>  		of_match_device(dev->driver->of_match_table, dev)->data;
> +	adc->dev = &pdev->dev;

There's struct device *dev = &pdev->dev; defined earlier, so you can use dev instead.

>  
>  	indio_dev->name = dev_name(&pdev->dev);
>  	indio_dev->dev.of_node = pdev->dev.of_node;
> 

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
