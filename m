Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604823ECA0C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhHOPr7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 11:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOPr6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 11:47:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 730466120F;
        Sun, 15 Aug 2021 15:47:25 +0000 (UTC)
Date:   Sun, 15 Aug 2021 16:50:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, David Wu <david.wu@rock-chips.com>
Subject: Re: [PATCH v4] iio: adc: rockchip_saradc: add voltage notifier so
 get referenced voltage once at probe
Message-ID: <20210815165023.132de2d1@jic23-huawei>
In-Reply-To: <20210810011007.54066-1-xxm@rock-chips.com>
References: <20210810011007.54066-1-xxm@rock-chips.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Aug 2021 09:10:07 +0800
Simon Xue <xxm@rock-chips.com> wrote:

> From: David Wu <david.wu@rock-chips.com>
> 
> Add voltage notifier, no need to query regulator voltage for
> every saradc read, just get regulator voltage once at probe.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

For future reference, there should be a changelog here under the ---
Sometimes it saves reviewers going back to check what they asked about
on earlier versions.
Otherwise looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find any problems before I go breaking linux-next.

Thanks,

Jonathan

>  drivers/iio/adc/rockchip_saradc.c | 47 ++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index f3eb8d2e50dc..a237fe469a30 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -49,10 +49,12 @@ struct rockchip_saradc {
>  	struct clk		*clk;
>  	struct completion	completion;
>  	struct regulator	*vref;
> +	int			uv_vref;
>  	struct reset_control	*reset;
>  	const struct rockchip_saradc_data *data;
>  	u16			last_val;
>  	const struct iio_chan_spec *last_chan;
> +	struct notifier_block nb;
>  };
>  
>  static void rockchip_saradc_power_down(struct rockchip_saradc *info)
> @@ -105,13 +107,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(info->vref);
> -		if (ret < 0) {
> -			dev_err(&indio_dev->dev, "failed to get voltage\n");
> -			return ret;
> -		}
> -
> -		*val = ret / 1000;
> +		*val = info->uv_vref / 1000;
>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
> @@ -298,6 +294,26 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static int rockchip_saradc_volt_notify(struct notifier_block *nb,
> +						   unsigned long event,
> +						   void *data)
> +{
> +	struct rockchip_saradc *info =
> +			container_of(nb, struct rockchip_saradc, nb);
> +
> +	if (event & REGULATOR_EVENT_VOLTAGE_CHANGE)
> +		info->uv_vref = (unsigned long)data;
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void rockchip_saradc_regulator_unreg_notifier(void *data)
> +{
> +	struct rockchip_saradc *info = data;
> +
> +	regulator_unregister_notifier(info->vref, &info->nb);
> +}
> +
>  static int rockchip_saradc_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_saradc *info = NULL;
> @@ -410,6 +426,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = regulator_get_voltage(info->vref);
> +	if (ret < 0)
> +		return ret;
> +
> +	info->uv_vref = ret;
> +
>  	ret = clk_prepare_enable(info->pclk);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to enable pclk\n");
> @@ -450,6 +472,17 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	info->nb.notifier_call = rockchip_saradc_volt_notify;
> +	ret = regulator_register_notifier(info->vref, &info->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rockchip_saradc_regulator_unreg_notifier,
> +				       info);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  

