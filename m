Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1292A400F44
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhIELSE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhIELSD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:18:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21362608FB;
        Sun,  5 Sep 2021 11:16:54 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:20:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hui Liu <hui.liu@mediatek.com>
Cc:     <robh+dt@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <seiya.wang@mediatek.com>, <ben.tseng@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 1/1] iio: mtk-auxadc: update case
 IIO_CHAN_INFO_PROCESSED
Message-ID: <20210905122017.645dd9b3@jic23-huawei>
In-Reply-To: <20210831054207.13236-2-hui.liu@mediatek.com>
References: <20210831054207.13236-1-hui.liu@mediatek.com>
        <20210831054207.13236-2-hui.liu@mediatek.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 13:42:07 +0800
Hui Liu <hui.liu@mediatek.com> wrote:

> Convert raw data to processed data, the processed data is input voltage.
> 
> Signed-off-by: Hui Liu <hui.liu@mediatek.com>

Looks very much to be a fix. Please track down appropriate patch and let
me know what the Fixes: tag should be.  If you reply to this thread
I'll add it plus a not saying it is an ABI change, but a necessary one
as the driver was previously buggy.

Whilst we are here, what is the cali_data() function actually there for?
Seems to only set *val = *val which is rather pointless.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mt6577_auxadc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 79c1dd68b909..d4fccd52ef08 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -82,6 +82,10 @@ static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
>  	MT6577_AUXADC_CHANNEL(15),
>  };
>  
> +/* For Voltage calculation */
> +#define VOLTAGE_FULL_RANGE  1500	/* VA voltage */
> +#define AUXADC_PRECISE      4096	/* 12 bits */
> +
>  static int mt_auxadc_get_cali_data(int rawdata, bool enable_cali)
>  {
>  	return rawdata;
> @@ -191,6 +195,10 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
>  		}
>  		if (adc_dev->dev_comp->sample_data_cali)
>  			*val = mt_auxadc_get_cali_data(*val, true);
> +
> +		/* Convert adc raw data to voltage: 0 - 1500 mV */
> +		*val = *val * VOLTAGE_FULL_RANGE / AUXADC_PRECISE;
> +
>  		return IIO_VAL_INT;
>  
>  	default:

