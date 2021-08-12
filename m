Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777F33EA9F0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhHLSIZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 14:08:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3644 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhHLSIZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 14:08:25 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Glvm64WYlz6CBbF;
        Fri, 13 Aug 2021 02:07:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 12 Aug 2021 20:07:58 +0200
Received: from localhost (10.52.121.184) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 12 Aug
 2021 19:07:56 +0100
Date:   Thu, 12 Aug 2021 19:07:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Hui Liu <hui.liu@mediatek.com>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 1/2] iio: mtk-auxadc: add support IIO_CHAN_INFO_RAW
 case
Message-ID: <20210812190725.00007449@Huawei.com>
In-Reply-To: <20210812054844.30575-2-hui.liu@mediatek.com>
References: <20210812054844.30575-1-hui.liu@mediatek.com>
        <20210812054844.30575-2-hui.liu@mediatek.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.184]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Aug 2021 13:48:43 +0800
Hui Liu <hui.liu@mediatek.com> wrote:

> Add support IIO_CHAN_INFO_RAW case.
Why?

We almost never support both RAW and PROCESSED as userspace should be
fine to use either.  There are a few reasons we've let drivers do
this but I would like know why it matters to you and it definitely
needs to be in the patch description.

> 
> Signed-off-by: Hui Liu <hui.liu@mediatek.com>
> ---
>  drivers/iio/adc/mt6577_auxadc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 79c1dd68b909..e995d43287b2 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -60,7 +60,8 @@ static const struct mtk_auxadc_compatible mt6765_compat = {
>  		.type = IIO_VOLTAGE,				    \
>  		.indexed = 1,					    \
>  		.channel = (idx),				    \
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	    \
> +				      BIT(IIO_CHAN_INFO_PROCESSED), \
>  }
>  
>  static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
> @@ -181,6 +182,19 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
>  	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
>  
>  	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = mt6577_auxadc_read(indio_dev, chan);
> +		if (*val < 0) {
> +			dev_notice(indio_dev->dev.parent,
> +				"failed to sample data on channel[%d]\n",
> +				chan->channel);
> +			return *val;
> +		}
> +		if (adc_dev->dev_comp->sample_data_cali)
> +			*val = mt_auxadc_get_cali_data(*val, true);
> +
> +		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_PROCESSED:
>  		*val = mt6577_auxadc_read(indio_dev, chan);
>  		if (*val < 0) {

