Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B497B3A2895
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFJJnj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 05:43:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3193 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJJni (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 05:43:38 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0zDy6VvHz6M4Xm;
        Thu, 10 Jun 2021 17:28:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 11:41:40 +0200
Received: from localhost (10.52.126.112) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 10:41:39 +0100
Date:   Thu, 10 Jun 2021 10:41:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Lesiak <chris.lesiak@licor.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: humidity: hdc100x: Add margin to the conversion
 time
Message-ID: <20210610104136.00002e4e@Huawei.com>
In-Reply-To: <20210609193748.1709308-1-chris.lesiak@licor.com>
References: <20210609193748.1709308-1-chris.lesiak@licor.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.112]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 14:37:48 -0500
Chris Lesiak <chris.lesiak@licor.com> wrote:

> The datasheets have the following note for the conversion time
> specification: "This parameter is specified by design and/or
> characterization and it is not tested in production."
> 
> Parts have been seen that require more time to do 14-bit conversions for
> the relative humidity channel.  The result is ENXIO due to the address
> phase of a transfer not getting an ACK.
> 
> Delay an additional 1 ms per conversion to allow for additional margin.
> 
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>

Hi Chris

Could you figure out a fixes tag for this one so we can get it backported
into stable?

If not I can probably guess when I catch up with applying patches.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hdc100x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 2a957f19048e..91790aa8beeb 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -166,7 +166,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
>  				   struct iio_chan_spec const *chan)
>  {
>  	struct i2c_client *client = data->client;
> -	int delay = data->adc_int_us[chan->address];
> +	int delay = data->adc_int_us[chan->address] + 1000;
>  	int ret;
>  	__be16 val;
>  
> @@ -316,7 +316,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct hdc100x_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
> -	int delay = data->adc_int_us[0] + data->adc_int_us[1];
> +	int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2000;
>  	int ret;
>  
>  	/* dual read starts at temp register */

