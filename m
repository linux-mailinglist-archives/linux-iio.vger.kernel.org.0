Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEE5474CD
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFPNak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 09:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfFPNak (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 09:30:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1254D20870;
        Sun, 16 Jun 2019 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560691840;
        bh=ZX8QJuB9p2s+FPxV8m18vkOWsq3tuCq3TYMjFMBV1GA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vPt48HNghtZFWhBVt9PcVrDXKo4CL/VCVwdrBbph4/uk1iQacs8UX5YyoOvRh0ceA
         itElbgzfgVNotUp9jjGynD8wm9sif+AQMxyZ+OpZFhWiso/U/vWZ7OsrSVSMBRcFmY
         mqYcSuAaOib+3EzYof4gNegYTK2iF0sTkPVdDwdQ=
Date:   Sun, 16 Jun 2019 14:30:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
Subject: Re: [RFC PATCH 2/3] iio: imu: st_lsm6dsx: add wake on accelerometer
 enable hook in sysfs
Message-ID: <20190616143035.0e845c8a@archlinux>
In-Reply-To: <20190614122604.52935-3-sean@geanix.com>
References: <20190614122604.52935-1-sean@geanix.com>
        <20190614122604.52935-3-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 14:26:03 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This adds a wakeup_enabled hook in sysfs.
> If wakeup-source is enabled, wake on accelerometer event is default active.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

This seems to replicate the stuff that should be there under ../power
to allow the wake up source to turned on and off..

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 092c4d02bd4e..2c8ad7d65d2f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -630,15 +630,46 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t st_lsm6dsx_sysfs_get_wakeup_enabled(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (device_may_wakeup(hw->dev))
> +		return sprintf(buf, "%d\n", 1);
> +	return sprintf(buf, "%d\n", 0);
> +}
> +
> +static ssize_t st_lsm6dsx_sysfs_set_wakeup_enabled(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (strncmp(buf, "1", 1) == 0)

Can't use the kstrtobool function?  It's rather less strict
but should be unambiguous here.

> +		device_set_wakeup_enable(hw->dev, true);
> +	else
> +		device_set_wakeup_enable(hw->dev, false);
> +
> +	return len;
> +}
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_avail);
>  static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(wakeup_enabled, 0644,
> +		       st_lsm6dsx_sysfs_get_wakeup_enabled,
> +		       st_lsm6dsx_sysfs_set_wakeup_enabled, 0);
>  static IIO_DEVICE_ATTR(in_anglvel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
>  
>  static struct attribute *st_lsm6dsx_acc_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_dev_attr_wakeup_enabled.dev_attr.attr,
>  	NULL,
>  };
>  

