Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987E5C0FFF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2019 08:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfI1G5I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Sep 2019 02:57:08 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:33763 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfI1G5I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Sep 2019 02:57:08 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Sep 2019 02:57:07 EDT
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 98F565C0864; Sat, 28 Sep 2019 08:47:20 +0200 (CEST)
Date:   Sat, 28 Sep 2019 08:47:20 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized
 if regmap_read() fails
Message-ID: <20190928064720.GA24515@osadl.at>
References: <20190928004642.28932-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928004642.28932-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 27, 2019 at 05:46:41PM -0700, Yizhuo wrote:
> Several functions in this file are trying to use regmap_read() to
> initialize the specific variable, however, if regmap_read() fails,
> the variable could be uninitialized but used directly, which is
> potentially unsafe. The return value of regmap_read() should be
> checked and handled.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>

Just a few minor style issues - contentwise it look correct to me.
Reviewed-by: Nicholas Mc Guire <hofrat@osadl.org>

> ---
>  drivers/iio/adc/meson_saradc.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 7b28d045d271..c032a64108b4 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -323,6 +323,7 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  	int regval, timeout = 10000;
> +	int ret;
>  
>  	/*
>  	 * NOTE: we need a small delay before reading the status, otherwise
> @@ -331,7 +332,9 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
>  	 */
>  	do {
>  		udelay(1);
> -		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> +		ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> +		if (ret)
> +			return ret;
>  	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
>  
>  	if (timeout < 0)
> @@ -358,7 +361,11 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,

any reason not to declear ret in the declaration block ?
so just for consistency with coding style within meson_saradc.c
this might be:

	int regval, fifo_chan, fifo_val, count;
+	int ret;

>  		return -EINVAL;
>  	}
>  
> -	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
> +	int ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);

+	ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);

> +
> +	if (ret)
> +		return ret;
> +
>  	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
>  	if (fifo_chan != chan->address) {
>  		dev_err(&indio_dev->dev,
> @@ -491,6 +498,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  	int val, timeout = 10000;
> +	int ret;
>  
>  	mutex_lock(&indio_dev->mlock);
>  
> @@ -506,7 +514,10 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
>  		 */
>  		do {
>  			udelay(1);
> -			regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
> +			ret = regmap_read(priv->regmap,
> +					MESON_SAR_ADC_DELAY, &val);

checkpatch does not fuss here but the continuation should be alligned
witht the ( here

> +			if (ret)
> +				return ret;
>  		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
>  
>  		if (timeout < 0) {
> @@ -784,7 +795,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  		 * BL30 to make sure BL30 gets the values it expects when
>  		 * reading the temperature sensor.
>  		 */
> -		regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> +		ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> +		if (ret)
> +			return ret;
> +
>  		if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
>  			return 0;
>  	}
> @@ -1014,7 +1028,11 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
>  	unsigned int cnt, threshold;
>  	u32 regval;

same as above

+       int ret;

>  
> -	regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> +	int ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);

+	ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);

> +
> +	if (ret)
> +		return ret;
> +
>  	cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
>  	threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
>  
> -- 
> 2.17.1
> 
