Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FF1B87DA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDYQ7M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgDYQ7M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:59:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C85A20700;
        Sat, 25 Apr 2020 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833951;
        bh=qlNoYAKX9aHaBZB9tCiALBMJeQLVoISvxp+jPFTOxWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qwcw+4/i8Sni/heKGcbkf+bznI07iSHdwoLTDwCV+mT/iQWZ60pGuzM5kYSVOgkW9
         YXexoRwsJX/W1s7lNKUR0vjivAgGqS3s7+XhI7NfYNU2gRbq38sT2sb7BjO1ZpYVlN
         TYkmw63c5WAWDnhK58OQDvuraUMuR9sllkGqbcsg=
Date:   Sat, 25 Apr 2020 17:59:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: extend short-hand use for
 'indio_dev->buffer'
Message-ID: <20200425175907.6e0c875c@archlinux>
In-Reply-To: <20200424152243.39410-1-alexandru.ardelean@analog.com>
References: <20200424152243.39410-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020 18:22:43 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change is both cosmetic and a prequel to adding support for attaching
> multiple buffers per IIO device.
> 
> The IIO buffer sysfs attrs are mostly designed to support only one attached
> buffer, and in order to support more, we need to centralize [in each attr
> function] the buffer which is being accessed.
> 
> This also makes it a bit more uniform, as in some functions there is a
> short-hand 'buffer' variable and at the same time the 'indio_dev->buffer'
> is still access directly.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Seems like a harmless bit of tidying up in of itself, so fair enough
even without seeing what you are going to do next :)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if I missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 61 +++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 221157136af6..eae39eaf49af 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -189,10 +189,12 @@ __poll_t iio_buffer_poll(struct file *filp,
>   */
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
>  {
> -	if (!indio_dev->buffer)
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +
> +	if (!buffer)
>  		return;
>  
> -	wake_up(&indio_dev->buffer->pollq);
> +	wake_up(&buffer->pollq);
>  }
>  
>  void iio_buffer_init(struct iio_buffer *buffer)
> @@ -262,10 +264,11 @@ static ssize_t iio_scan_el_show(struct device *dev,
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
>  
>  	/* Ensure ret is 0 or 1. */
>  	ret = !!test_bit(to_iio_dev_attr(attr)->address,
> -		       indio_dev->buffer->scan_mask);
> +		       buffer->scan_mask);
>  
>  	return sprintf(buf, "%d\n", ret);
>  }
> @@ -381,7 +384,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  	mutex_lock(&indio_dev->mlock);
> -	if (iio_buffer_is_active(indio_dev->buffer)) {
> +	if (iio_buffer_is_active(buffer)) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> @@ -410,7 +413,9 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
>  				   char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	return sprintf(buf, "%d\n", indio_dev->buffer->scan_timestamp);
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +
> +	return sprintf(buf, "%d\n", buffer->scan_timestamp);
>  }
>  
>  static ssize_t iio_scan_el_ts_store(struct device *dev,
> @@ -420,6 +425,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
>  	bool state;
>  
>  	ret = strtobool(buf, &state);
> @@ -427,11 +433,11 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>  		return ret;
>  
>  	mutex_lock(&indio_dev->mlock);
> -	if (iio_buffer_is_active(indio_dev->buffer)) {
> +	if (iio_buffer_is_active(buffer)) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> -	indio_dev->buffer->scan_timestamp = state;
> +	buffer->scan_timestamp = state;
>  error_ret:
>  	mutex_unlock(&indio_dev->mlock);
>  
> @@ -439,10 +445,10 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>  }
>  
>  static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> +					struct iio_buffer *buffer,
>  					const struct iio_chan_spec *chan)
>  {
>  	int ret, attrcount = 0;
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  
>  	ret = __iio_add_chan_devattr("index",
>  				     chan,
> @@ -518,7 +524,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>  		return len;
>  
>  	mutex_lock(&indio_dev->mlock);
> -	if (iio_buffer_is_active(indio_dev->buffer)) {
> +	if (iio_buffer_is_active(buffer)) {
>  		ret = -EBUSY;
>  	} else {
>  		buffer->access->set_length(buffer, val);
> @@ -539,7 +545,9 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
>  				      char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +
> +	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
>  }
>  
>  static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
> @@ -1129,6 +1137,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>  	int ret;
>  	bool requested_state;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
>  	bool inlist;
>  
>  	ret = strtobool(buf, &requested_state);
> @@ -1138,17 +1147,15 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>  	mutex_lock(&indio_dev->mlock);
>  
>  	/* Find out if it is in the list */
> -	inlist = iio_buffer_is_active(indio_dev->buffer);
> +	inlist = iio_buffer_is_active(buffer);
>  	/* Already in desired state */
>  	if (inlist == requested_state)
>  		goto done;
>  
>  	if (requested_state)
> -		ret = __iio_update_buffers(indio_dev,
> -					 indio_dev->buffer, NULL);
> +		ret = __iio_update_buffers(indio_dev, buffer, NULL);
>  	else
> -		ret = __iio_update_buffers(indio_dev,
> -					 NULL, indio_dev->buffer);
> +		ret = __iio_update_buffers(indio_dev, NULL, buffer);
>  
>  done:
>  	mutex_unlock(&indio_dev->mlock);
> @@ -1190,7 +1197,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>  		goto out;
>  	}
>  
> -	if (iio_buffer_is_active(indio_dev->buffer)) {
> +	if (iio_buffer_is_active(buffer)) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -1207,11 +1214,9 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
>  						char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	size_t bytes;
> -
> -	bytes = iio_buffer_data_available(indio_dev->buffer);
> +	struct iio_buffer *buffer = indio_dev->buffer;
>  
> -	return sprintf(buf, "%zu\n", bytes);
> +	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
>  }
>  
>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> @@ -1292,7 +1297,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  			if (channels[i].scan_index < 0)
>  				continue;
>  
> -			ret = iio_buffer_add_channel_sysfs(indio_dev,
> +			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
>  							 &channels[i]);
>  			if (ret < 0)
>  				goto error_cleanup_dynamic;
> @@ -1332,20 +1337,22 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	bitmap_free(buffer->scan_mask);
>  error_cleanup_dynamic:
>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> -	kfree(indio_dev->buffer->buffer_group.attrs);
> +	kfree(buffer->buffer_group.attrs);
>  
>  	return ret;
>  }
>  
>  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> -	if (!indio_dev->buffer)
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +
> +	if (!buffer)
>  		return;
>  
> -	bitmap_free(indio_dev->buffer->scan_mask);
> -	kfree(indio_dev->buffer->buffer_group.attrs);
> -	kfree(indio_dev->buffer->scan_el_group.attrs);
> -	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
> +	bitmap_free(buffer->scan_mask);
> +	kfree(buffer->buffer_group.attrs);
> +	kfree(buffer->scan_el_group.attrs);
> +	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
>  }
>  
>  /**

