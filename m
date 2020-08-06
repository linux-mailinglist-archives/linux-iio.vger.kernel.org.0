Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80423E01B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 20:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgHFSCP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 14:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgHFSCM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:02:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12F4206A2;
        Thu,  6 Aug 2020 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596736932;
        bh=9sUjY/EQ0U39oYMlQPvEvGW/9HCx2e58IMNn3pm5wdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e91T2UBSmufrS+L3aMM6kobPSgaPYhhSo5y3MAMj03UBN7dpEAXH5UQtYSIU01FZ+
         JhCDjj6MTMVULCix/AicmBkscE3jV/iEFhezcyFIaoegCptSvwz2S/S396IjT9nGY/
         Ke/Fea9xrxiIUPJ9gpqlUIIroRM2faIdcXBwIRXg=
Date:   Thu, 6 Aug 2020 19:02:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH 2/2] iio: imu: adis16480: Add the option to
 enable/disable burst mode
Message-ID: <20200806190208.7d4899e2@archlinux>
In-Reply-To: <20200804100414.39002-2-alexandru.ardelean@analog.com>
References: <20200804100414.39002-1-alexandru.ardelean@analog.com>
        <20200804100414.39002-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Aug 2020 13:04:14 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> Although the burst read function does not require a stall time between
> each 16-bit segment, it however requires more processing since the
> software needs to look for the BURST_ID and take into account the offset
> to the first data channel. Some users might find it useful to be able to
> switch between the two modes.

Ah, when you say future patch, you meant extremely near future. :)

> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

First rule of new ABI, document it.

As mentioned in previous patch, this sort of user interface is very hard to
use. You are much better off estimating whether it is a good idea or
not for a given set of channels.   If it isn't don't use it, if
it is turn it on.
There is compelling reason to let users choose that I can think of...


Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 9b100c8fb744..7d7712c33435 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -330,6 +330,45 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
>  
>  #endif
>  
> +static ssize_t adis16495_burst_mode_enable_get(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct adis16480 *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", st->adis.burst->en);
> +}
> +
> +static ssize_t adis16495_burst_mode_enable_set(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t len)
> +{
> +	struct adis16480 *st = iio_priv(dev_to_iio_dev(dev));
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	st->adis.burst->en = val;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(burst_mode_enable, 0644,
> +		       adis16495_burst_mode_enable_get,
> +		       adis16495_burst_mode_enable_set, 0);
> +
> +static struct attribute *adis16495_attributes[] = {
> +	&iio_dev_attr_burst_mode_enable.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adis16495_attribute_group = {
> +	.attrs = adis16495_attributes,
> +};
> +
>  static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  {
>  	struct adis16480 *st = iio_priv(indio_dev);
> @@ -1131,6 +1170,14 @@ static const struct iio_info adis16480_info = {
>  	.debugfs_reg_access = adis_debugfs_reg_access,
>  };
>  
> +static const struct iio_info adis16495_info = {
> +	.attrs = &adis16495_attribute_group,
> +	.read_raw = &adis16480_read_raw,
> +	.write_raw = &adis16480_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +	.debugfs_reg_access = adis_debugfs_reg_access,
> +};
> +
>  static int adis16480_stop_device(struct iio_dev *indio_dev)
>  {
>  	struct adis16480 *st = iio_priv(indio_dev);
> @@ -1365,6 +1412,7 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (st->chip_info->burst) {
>  		st->adis.burst = st->chip_info->burst;
>  		st->adis.burst_extra_len = st->chip_info->burst->extra_len;
> +		indio_dev->info = &adis16495_info;
>  	}
>  
>  	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev,

