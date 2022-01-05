Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F84485174
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jan 2022 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiAEKwB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jan 2022 05:52:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4346 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiAEKwA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jan 2022 05:52:00 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTR7Z5X1zz67bMk;
        Wed,  5 Jan 2022 18:49:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:51:59 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:51:58 +0000
Date:   Wed, 5 Jan 2022 10:52:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Gwendal Grignou" <gwendal@chromium.org>
Subject: Re: [PATCH v2 48/51] iio:dac:m62332: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
Message-ID: <20220105105204.00000775@Huawei.com>
In-Reply-To: <20220102125617.1259804-49-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
        <20220102125617.1259804-49-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.118]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  2 Jan 2022 12:56:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I missed that there were some CONFIG_PM guards around iio_priv()->save
that also need dropping.  Will do that in v3.

Jonathan

> ---
>  drivers/iio/dac/m62332.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index 225b1a374dc1..4a413936fabb 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -124,7 +124,6 @@ static int m62332_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int m62332_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -156,11 +155,7 @@ static int m62332_resume(struct device *dev)
>  	return m62332_set_value(indio_dev, data->save[1], 1);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
> -#define M62332_PM_OPS (&m62332_pm_ops)
> -#else
> -#define M62332_PM_OPS NULL
> -#endif
> +DEFINE_SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
>  
>  static const struct iio_info m62332_info = {
>  	.read_raw = m62332_read_raw,
> @@ -246,7 +241,7 @@ MODULE_DEVICE_TABLE(i2c, m62332_id);
>  static struct i2c_driver m62332_driver = {
>  	.driver = {
>  		.name	= "m62332",
> -		.pm	= M62332_PM_OPS,
> +		.pm	= pm_sleep_ptr(&m62332_pm_ops),
>  	},
>  	.probe		= m62332_probe,
>  	.remove		= m62332_remove,

