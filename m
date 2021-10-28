Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4965E43E396
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhJ1O1F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1O1F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:27:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC3F61108;
        Thu, 28 Oct 2021 14:24:36 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:29:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: st-sensors: Use dev_to_iio_dev() in sysfs
 callbacks
Message-ID: <20211028152902.1ddb69b3@jic23-huawei>
In-Reply-To: <20211020085349.16178-1-lars@metafoo.de>
References: <20211020085349.16178-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Oct 2021 10:53:49 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Using `dev_get_drvdata()` in IIO sysfs callbacks to get a pointer to the
> IIO device is a relic from the very early days of IIO. The IIO core as well
> as most other drivers have switched over to using `dev_to_iio_dev()`
> instead.
> 
> This driver is one of the last few drivers remaining that uses the outdated
> idiom, update it. This will allow to eventually update the IIO core to no
> longer set the drvdata for the IIO device and free it up for driver usage.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git and pushed out as testing to keep 0-day
burning cycles.   Plenty of time for any additional reviews as I won't be pushing
this out properly until the merge window closes and I rebase the tree.

Thanks,

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 1de395bda03e..eb452d0c423c 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -638,7 +638,7 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	int i, len = 0;
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	mutex_lock(&indio_dev->mlock);
> @@ -660,7 +660,7 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	int i, len = 0, q, r;
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	mutex_lock(&indio_dev->mlock);

