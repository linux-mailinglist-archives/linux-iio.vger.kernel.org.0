Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DE19EA3B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDEJ4z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 05:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgDEJ4y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 05:56:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8CA220675;
        Sun,  5 Apr 2020 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586080614;
        bh=TUT+s4L0VjiihNh6Gz90XgS9rlIzZWfrtwcYpk1Epg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lS70/u8QAdYhKlUjoXHEh4K63pI7VPu9vARSFs7rU9qUIRsumk+M/dz2jAroghK1V
         0qe3KmNafHHfcMCzzk1+kpV1Na6uVaKWnnfcNe32Gfq5W4LFjHof/KXz6i79VM+cvK
         NT7NQMiMJ7ry36/VLuLj5puYPiyOyg51jC0+3U7E=
Date:   Sun, 5 Apr 2020 10:56:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com, lars@metafoo.de, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [RFC PATCH 1/3] iio: core: rename 'indio_dev->buffer_list' ->
 'indio_dev->active_buffers'
Message-ID: <20200405105650.77ae4cb8@archlinux>
In-Reply-To: <20200330145705.29447-2-alexandru.ardelean@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
        <20200330145705.29447-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 17:57:03 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> Since we want to add support for attaching multiple buffers, and we want to
> add a new list to 'struct iio_dev', it's a good idea to rename the current
> 'indio->buffer_list' to 'indio_dev->active_buffers'.
> 
> Fortunately, this is a private field, which is used in
> 'drivers/iio/industrial-buffer.c', so this is simple to rename.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
This highlights that we are going to need to come up with a clearly concept than
'buffers' for both the stream of data coming in or out + the interfaces
within the kernel (consumer buffer etc).

I'm not sure what naming will work though..  For input buffers we could
use "buffers" for the incoming streams and "consumers" for where that is demuxed
to (including the kfifos etc).

For output I 'think' we are unlikely to have to deal with interleaving
inputs from multiple devices all wanting to drive their own channels?
(I hope so as that sounds horrible to deal with give frequency missmatch
etc)  So in output case it'll kind of be one block.

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 28 ++++++++++++++--------------
>  drivers/iio/industrialio-core.c   |  2 +-
>  include/linux/iio/iio.h           |  4 ++--
>  3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e6fa1a4e135d..a585c304cad4 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -591,7 +591,7 @@ static void iio_buffer_activate(struct iio_dev *indio_dev,
>  	struct iio_buffer *buffer)
>  {
>  	iio_buffer_get(buffer);
> -	list_add(&buffer->buffer_list, &indio_dev->buffer_list);
> +	list_add(&buffer->buffer_list, &indio_dev->active_buffers);
>  }
>  
>  static void iio_buffer_deactivate(struct iio_buffer *buffer)
> @@ -606,7 +606,7 @@ static void iio_buffer_deactivate_all(struct iio_dev *indio_dev)
>  	struct iio_buffer *buffer, *_buffer;
>  
>  	list_for_each_entry_safe(buffer, _buffer,
> -			&indio_dev->buffer_list, buffer_list)
> +			&indio_dev->active_buffers, buffer_list)
>  		iio_buffer_deactivate(buffer);
>  }
>  
> @@ -701,12 +701,12 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	 * to verify.
>  	 */
>  	if (remove_buffer && !insert_buffer &&
> -		list_is_singular(&indio_dev->buffer_list))
> +		list_is_singular(&indio_dev->active_buffers))
>  			return 0;
>  
>  	modes = indio_dev->modes;
>  
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
>  		if (buffer == remove_buffer)
>  			continue;
>  		modes &= buffer->access->modes;
> @@ -727,7 +727,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  		 * Keep things simple for now and only allow a single buffer to
>  		 * be connected in hardware mode.
>  		 */
> -		if (insert_buffer && !list_empty(&indio_dev->buffer_list))
> +		if (insert_buffer && !list_empty(&indio_dev->active_buffers))
>  			return -EINVAL;
>  		config->mode = INDIO_BUFFER_HARDWARE;
>  		strict_scanmask = true;
> @@ -747,7 +747,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  
>  	scan_timestamp = false;
>  
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
>  		if (buffer == remove_buffer)
>  			continue;
>  		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
> @@ -896,7 +896,7 @@ static int iio_update_demux(struct iio_dev *indio_dev)
>  	struct iio_buffer *buffer;
>  	int ret;
>  
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
>  		ret = iio_buffer_update_demux(indio_dev, buffer);
>  		if (ret < 0)
>  			goto error_clear_mux_table;
> @@ -904,7 +904,7 @@ static int iio_update_demux(struct iio_dev *indio_dev)
>  	return 0;
>  
>  error_clear_mux_table:
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
> +	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list)
>  		iio_buffer_demux_free(buffer);
>  
>  	return ret;
> @@ -948,7 +948,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  		indio_dev->info->hwfifo_set_watermark(indio_dev,
>  			config->watermark);
>  
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
>  		ret = iio_buffer_enable(buffer, indio_dev);
>  		if (ret)
>  			goto err_disable_buffers;
> @@ -968,7 +968,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	return 0;
>  
>  err_disable_buffers:
> -	list_for_each_entry_continue_reverse(buffer, &indio_dev->buffer_list,
> +	list_for_each_entry_continue_reverse(buffer, &indio_dev->active_buffers,
>  					     buffer_list)
>  		iio_buffer_disable(buffer, indio_dev);
>  err_run_postdisable:
> @@ -988,7 +988,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  	int ret2;
>  
>  	/* Wind down existing buffers - iff there are any */
> -	if (list_empty(&indio_dev->buffer_list))
> +	if (list_empty(&indio_dev->active_buffers))
>  		return 0;
>  
>  	/*
> @@ -1004,7 +1004,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  			ret = ret2;
>  	}
>  
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
>  		ret2 = iio_buffer_disable(buffer, indio_dev);
>  		if (ret2 && !ret)
>  			ret = ret2;
> @@ -1052,7 +1052,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  		iio_buffer_activate(indio_dev, insert_buffer);
>  
>  	/* If no buffers in list, we are done */
> -	if (list_empty(&indio_dev->buffer_list))
> +	if (list_empty(&indio_dev->active_buffers))
>  		return 0;
>  
>  	ret = iio_enable_buffers(indio_dev, &new_config);
> @@ -1413,7 +1413,7 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
>  	int ret;
>  	struct iio_buffer *buf;
>  
> -	list_for_each_entry(buf, &indio_dev->buffer_list, buffer_list) {
> +	list_for_each_entry(buf, &indio_dev->active_buffers, buffer_list) {
>  		ret = iio_push_to_buffer(buf, data);
>  		if (ret < 0)
>  			return ret;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 157d95a24faa..a13957644c1d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1523,7 +1523,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  			return NULL;
>  		}
>  		dev_set_name(&dev->dev, "iio:device%d", dev->id);
> -		INIT_LIST_HEAD(&dev->buffer_list);
> +		INIT_LIST_HEAD(&dev->active_buffers);
>  	}
>  
>  	return dev;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index e975020abaa6..a123f8acb192 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -490,7 +490,7 @@ struct iio_buffer_setup_ops {
>   *			and owner
>   * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
>   * @buffer:		[DRIVER] any buffer present
> - * @buffer_list:	[INTERN] list of all buffers currently attached
> + * @active_buffers:	[INTERN] list of all buffers currently enabled/active
>   * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
>   * @mlock:		[INTERN] lock used to prevent simultaneous device state
>   *			changes
> @@ -534,7 +534,7 @@ struct iio_dev {
>  	struct iio_event_interface	*event_interface;
>  
>  	struct iio_buffer		*buffer;
> -	struct list_head		buffer_list;
> +	struct list_head		active_buffers;
>  	int				scan_bytes;
>  	struct mutex			mlock;
>  

