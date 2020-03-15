Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636EC185C5E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgCOMeK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgCOMeK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:34:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFF620663;
        Sun, 15 Mar 2020 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584275650;
        bh=1NqHaRIMXvpi4V8rudkO6m54YpDdCyMVZM8L+xqIJQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vfEbdiJ0T909XJjQmrw52j2wnzTJX/+Yn5ID8VPUuVEkLGjIWY67e5NBhDdxn1xc9
         jPPYXI1WoYkU7E4nmq/cpVawPHsu2owhMbVYPc3UP23OejVbArusYweXqQMZGoGUB1
         ZdHhqzIeNL3EeBG0G6DfZltoe1JzqYNYvhZMgBkU=
Date:   Sun, 15 Mar 2020 12:34:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 2/8] iio: st_sensors: Use dev_get_platdata() to get
 platform_data
Message-ID: <20200315123406.68f85455@archlinux>
In-Reply-To: <20200313104955.30423-2-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200313104955.30423-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 12:49:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use dev_get_platdata() to get the platform_data instead of
> referencing it directly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.  Thanks,

Jonathan

> ---
> v2: no change
>  drivers/iio/accel/st_accel_core.c              | 3 +--
>  drivers/iio/common/st_sensors/st_sensors_spi.c | 2 +-
>  drivers/iio/pressure/st_pressure_core.c        | 3 +--
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 7320275c7e56..5f7bdb1f55d1 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1170,8 +1170,7 @@ EXPORT_SYMBOL(st_accel_get_settings);
>  int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
> -	struct st_sensors_platform_data *pdata =
> -		(struct st_sensors_platform_data *)adata->dev->platform_data;
> +	struct st_sensors_platform_data *pdata = dev_get_platdata(adata->dev);
>  	struct iio_chan_spec *channels;
>  	size_t channels_size;
>  	int err;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index 1275fb0eda31..dcbdef4a77f8 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -44,7 +44,7 @@ static bool st_sensors_is_spi_3_wire(struct spi_device *spi)
>  	if (device_property_read_bool(dev, "spi-3wire"))
>  		return true;
>  
> -	pdata = (struct st_sensors_platform_data *)dev->platform_data;
> +	pdata = dev_get_platdata(dev);
>  	if (pdata && pdata->spi_3wire)
>  		return true;
>  
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index bd972cec4830..8bb47c3b4d6b 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -683,8 +683,7 @@ EXPORT_SYMBOL(st_press_get_settings);
>  int st_press_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *press_data = iio_priv(indio_dev);
> -	struct st_sensors_platform_data *pdata =
> -		(struct st_sensors_platform_data *)press_data->dev->platform_data;
> +	struct st_sensors_platform_data *pdata = dev_get_platdata(press_data->dev);
>  	int err;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;

