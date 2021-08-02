Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0883DD41F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 12:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhHBKnC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 06:43:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3549 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhHBKnC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 06:43:02 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdZMl5dgYz6F87n;
        Mon,  2 Aug 2021 18:42:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 12:42:51 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 11:42:50 +0100
Date:   Mon, 2 Aug 2021 11:42:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Simon Xue <xxm@rock-chips.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, David Wu <david.wu@rock-chips.com>
Subject: Re: [PATCH] iio: adc: rockchip_saradc: just get referenced voltage
 once at probe
Message-ID: <20210802114222.00004f3d@Huawei.com>
In-Reply-To: <20210802090929.37970-1-xxm@rock-chips.com>
References: <20210802090929.37970-1-xxm@rock-chips.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Aug 2021 17:09:29 +0800
Simon Xue <xxm@rock-chips.com> wrote:

> From: David Wu <david.wu@rock-chips.com>
> 
> The referenced voltage is not changed after initiation, so just only
> get referenced voltage once.
Hi David,

Isn't this an external reference voltage?  If so how do you know
it is not changed at runtime?  It might be unlikely and not happen
on particular platforms, but that's not he same as saying it can never
happen.  Clearly it's racey anyway if that does happen, but we definitely
don't expect frequent voltage changes.

Jonathan

> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/iio/adc/rockchip_saradc.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index f3eb8d2e50dc..cd33c0b9d3eb 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -49,6 +49,7 @@ struct rockchip_saradc {
>  	struct clk		*clk;
>  	struct completion	completion;
>  	struct regulator	*vref;
> +	int			uv_vref;
>  	struct reset_control	*reset;
>  	const struct rockchip_saradc_data *data;
>  	u16			last_val;
> @@ -105,13 +106,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
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
> @@ -410,6 +405,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	info->uv_vref = regulator_get_voltage(info->vref);
> +	if (info->uv_vref < 0) {
> +		dev_err(&pdev->dev, "failed to get voltage\n");
> +		ret = info->uv_vref;
> +		return ret;
> +	}
> +
>  	ret = clk_prepare_enable(info->pclk);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to enable pclk\n");

