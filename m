Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BAF22338
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfERKd4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERKd4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 06:33:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8317C2087E;
        Sat, 18 May 2019 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558175635;
        bh=lyxZ2oAa3nSh2jH4FzM6/fqpfbA1xb/Q3QFlyxQaA7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JG5SW2dvsxct3gLLqXmySEq60SKoEsCtIPeqqqM81XYl23VEimz4AzbQIRAW7qU62
         YPFIYlKSbHtCVVzsjk/BG7dOnd2M67zd8URJa4E7zu3Px5gtQH0PbikZAcV+EGGqFF
         X9LRSDcR5gN0m0F1gvPSweUB1ftGMynLqonM9UQM=
Date:   Sat, 18 May 2019 11:33:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>
Subject: Re: [PATCH 2/4] iio: adc: mediatek: mt6765 upstream driver
Message-ID: <20190518113349.2858f5ac@archlinux>
In-Reply-To: <1557994247-16739-3-git-send-email-chun-hung.wu@mediatek.com>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
        <1557994247-16739-3-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 May 2019 16:10:45 +0800
Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:

Hi, 

I changed the title to just say we were adding support to
the existing driver.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan



> 1. Add calibrated sample data support
> 2. Use of_match_table to decide each platform's
>    feature set
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  drivers/iio/adc/mt6577_auxadc.c | 54 +++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 95d76ab..e1bdcc0 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -42,10 +42,26 @@
>  #define MT6577_AUXADC_POWER_READY_MS          1
>  #define MT6577_AUXADC_SAMPLE_READY_US         25
>  
> +struct mtk_auxadc_compatible {
> +	bool sample_data_cali;
> +	bool check_global_idle;
> +};
> +
>  struct mt6577_auxadc_device {
>  	void __iomem *reg_base;
>  	struct clk *adc_clk;
>  	struct mutex lock;
> +	const struct mtk_auxadc_compatible *dev_comp;
> +};
> +
> +static const struct mtk_auxadc_compatible mt8173_compat = {
> +	.sample_data_cali = false,
> +	.check_global_idle = true,
> +};
> +
> +static const struct mtk_auxadc_compatible mt6765_compat = {
> +	.sample_data_cali = true,
> +	.check_global_idle = false,
>  };
>  
>  #define MT6577_AUXADC_CHANNEL(idx) {				    \
> @@ -74,6 +90,11 @@ struct mt6577_auxadc_device {
>  	MT6577_AUXADC_CHANNEL(15),
>  };
>  
> +static int mt_auxadc_get_cali_data(int rawdata, bool enable_cali)
> +{
> +	return rawdata;
> +}
> +
>  static inline void mt6577_auxadc_mod_reg(void __iomem *reg,
>  					 u32 or_mask, u32 and_mask)
>  {
> @@ -120,15 +141,17 @@ static int mt6577_auxadc_read(struct iio_dev *indio_dev,
>  	/* we must delay here for hardware sample channel data */
>  	udelay(MT6577_AUXADC_SAMPLE_READY_US);
>  
> -	/* check MTK_AUXADC_CON2 if auxadc is idle */
> -	ret = readl_poll_timeout(adc_dev->reg_base + MT6577_AUXADC_CON2, val,
> -				 ((val & MT6577_AUXADC_STA) == 0),
> -				 MT6577_AUXADC_SLEEP_US,
> -				 MT6577_AUXADC_TIMEOUT_US);
> -	if (ret < 0) {
> -		dev_err(indio_dev->dev.parent,
> -			"wait for auxadc idle time out\n");
> -		goto err_timeout;
> +	if (adc_dev->dev_comp->check_global_idle) {
> +		/* check MTK_AUXADC_CON2 if auxadc is idle */
> +		ret = readl_poll_timeout(adc_dev->reg_base + MT6577_AUXADC_CON2,
> +					 val, ((val & MT6577_AUXADC_STA) == 0),
> +					 MT6577_AUXADC_SLEEP_US,
> +					 MT6577_AUXADC_TIMEOUT_US);
> +		if (ret < 0) {
> +			dev_err(indio_dev->dev.parent,
> +				"wait for auxadc idle time out\n");
> +			goto err_timeout;
> +		}
>  	}
>  
>  	/* read channel and make sure ready bit == 1 */
> @@ -163,6 +186,8 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
>  				  int *val2,
>  				  long info)
>  {
> +	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
> +
>  	switch (info) {
>  	case IIO_CHAN_INFO_PROCESSED:
>  		*val = mt6577_auxadc_read(indio_dev, chan);
> @@ -172,6 +197,8 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
>  				chan->channel);
>  			return *val;
>  		}
> +		if (adc_dev->dev_comp->sample_data_cali)
> +			*val = mt_auxadc_get_cali_data(*val, true);
>  		return IIO_VAL_INT;
>  
>  	default:
> @@ -304,10 +331,11 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
>  			 mt6577_auxadc_resume);
>  
>  static const struct of_device_id mt6577_auxadc_of_match[] = {
> -	{ .compatible = "mediatek,mt2701-auxadc", },
> -	{ .compatible = "mediatek,mt2712-auxadc", },
> -	{ .compatible = "mediatek,mt7622-auxadc", },
> -	{ .compatible = "mediatek,mt8173-auxadc", },
> +	{ .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);

