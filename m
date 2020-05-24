Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBD1E0115
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 19:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbgEXR2r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 13:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbgEXR2q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 13:28:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9224206C3;
        Sun, 24 May 2020 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590341325;
        bh=FGj9/38iwUsRe2yIGvr6Y3htRapDdO/jeBaCh1UH1T4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hK9SsygqT37pPehIMAUO3botKRPJJRw3S8kEY67SQpNzO8XUqfcYbcIsS9V5MTXPg
         uJCJg3noVqr6RzRYLmtSkXY2cANvi5qqJZKMpfm20mDOru4QGszklk6mCmjUJZqeUI
         G9zQ1DkoObDNe1tOE26Q7lt58Ct+Jv+WkePhtCzo=
Date:   Sun, 24 May 2020 18:28:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 13/14] iio: unpack all iio buffer attributes
 correctly
Message-ID: <20200524182841.1c9d794d@archlinux>
In-Reply-To: <20200508135348.15229-14-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
        <20200508135348.15229-14-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 May 2020 16:53:47 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> WIP
> 
> This change fixes how IIO buffer attributes get unpacked.
> There could be a saner way to unpack these without needed to change the
> drivers that attach buffer attributes incorrectly via
> iio_buffer_set_attrs()
> 
> It seems that the design idea was that there is a single buffer per IIO
> device, so all drivers attached buffer attributes for FIFO to the IIO
> buffer.

Agreed - though I think what you have here is about the best we can
do and actually seems a sensible change in general.

There is a bit a mess in the abstraction, but I'm not totally sure
how to tidy that up.

These attrs are properties of the pre-demux buffer, whereas we
present them in the same directory as the post-demux buffer
(there of course can be other post-demux buffers such as in kernel
consumers).  The scan_elements are a characteristic of this particular
post-demux buffer as it's length etc. 

Feels like we should tidy that up, but we still potentially need
one set of these for each pre-demux buffer.  Maybe we need
to explicitly call out hw fifos?  It'll be a mess as sometimes
we have a single hw fifo, feeding multiple IIO devices (hopefully
just multiple buffers in the future).

Jonathan


> 
> Now with the change to add a device object to the IIO buffer, and shifting
> around the device-attributes, a 'device' object unpacks to an IIO buffer
> object, which needs some special handling.'
> 
> One idea to fix this, is to get rid of iio_buffer_set_attrs() somehow.
> Or, to maybe allocate some wrapper device-attributes.
> 
> With this change, IIO still needs (to work with the older ABI):
> - symlink the chardev of the first IIO buffer device to the IIO device
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/accel/adxl372.c                   |  6 ++-
>  drivers/iio/accel/bmc150-accel-core.c         |  6 ++-
>  .../buffer/industrialio-buffer-dmaengine.c    |  4 +-
>  drivers/iio/industrialio-buffer.c             | 51 +++++++++++--------
>  include/linux/iio/buffer.h                    |  3 ++
>  5 files changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 60daf04ce188..528bce008671 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -745,7 +745,8 @@ static ssize_t adxl372_get_fifo_enabled(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
>  	struct adxl372_state *st = iio_priv(indio_dev);
>  
>  	return sprintf(buf, "%d\n", st->fifo_mode);
> @@ -755,7 +756,8 @@ static ssize_t adxl372_get_fifo_watermark(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
>  	struct adxl372_state *st = iio_priv(indio_dev);
>  
>  	return sprintf(buf, "%d\n", st->watermark);
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 121b4e89f038..c02287165980 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -763,7 +763,8 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
>  					       struct device_attribute *attr,
>  					       char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int wm;
>  
> @@ -778,7 +779,8 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	bool state;
>  
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 6dedf12b69a4..7728fdadcc3e 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -130,9 +130,9 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
>  static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
>  	struct device_attribute *attr, char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
>  	struct dmaengine_buffer *dmaengine_buffer =
> -		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
> +		iio_buffer_to_dmaengine_buffer(buffer);
>  
>  	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
>  }
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b14281442387..aa2f46c0949f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -29,6 +29,19 @@ static const char * const iio_endian_prefix[] = {
>  	[IIO_LE] = "le",
>  };
>  
> +struct iio_buffer *dev_to_iio_buffer(struct device *dev)
> +{
> +	return container_of(dev, struct iio_buffer, dev);
> +}
> +EXPORT_SYMBOL_GPL(dev_to_iio_buffer);
> +
> +struct iio_dev *iio_buffer_get_attached_iio_dev(struct iio_buffer *buffer)
> +{
> +	return buffer ? NULL : buffer->indio_dev;
> +}
> +EXPORT_SYMBOL_GPL(iio_buffer_get_attached_iio_dev);
> +
> +
>  static bool iio_buffer_is_active(struct iio_buffer *buf)
>  {
>  	return !list_empty(&buf->buffer_list);
> @@ -324,9 +337,8 @@ static ssize_t iio_scan_el_show(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
>  {
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
>  	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  
>  	/* Ensure ret is 0 or 1. */
>  	ret = !!test_bit(to_iio_dev_attr(attr)->address,
> @@ -436,10 +448,10 @@ static ssize_t iio_scan_el_store(struct device *dev,
>  				 const char *buf,
>  				 size_t len)
>  {
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	int ret;
>  	bool state;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = strtobool(buf, &state);
> @@ -474,8 +486,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
>  				   struct device_attribute *attr,
>  				   char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
>  
>  	return sprintf(buf, "%d\n", buffer->scan_timestamp);
>  }
> @@ -485,9 +496,9 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>  				    const char *buf,
>  				    size_t len)
>  {
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  	bool state;
>  
>  	ret = strtobool(buf, &state);
> @@ -563,8 +574,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
>  				      struct device_attribute *attr,
>  				      char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
>  
>  	return sprintf(buf, "%d\n", buffer->length);
>  }
> @@ -573,8 +583,8 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>  				       struct device_attribute *attr,
>  				       const char *buf, size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	unsigned int val;
>  	int ret;
>  
> @@ -606,8 +616,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
>  				      struct device_attribute *attr,
>  				      char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
>  
>  	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
>  }
> @@ -1207,10 +1216,10 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>  				       const char *buf,
>  				       size_t len)
>  {
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	int ret;
>  	bool requested_state;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  	bool inlist;
>  
>  	ret = strtobool(buf, &requested_state);
> @@ -1239,8 +1248,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
>  
>  	return sprintf(buf, "%u\n", buffer->watermark);
>  }
> @@ -1250,8 +1258,8 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>  					  const char *buf,
>  					  size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	unsigned int val;
>  	int ret;
>  
> @@ -1284,8 +1292,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
>  						struct device_attribute *attr,
>  						char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
>  
>  	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
>  }
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index fbba4093f06c..a688e98c694c 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -11,6 +11,9 @@
>  
>  struct iio_buffer;
>  
> +struct iio_buffer *dev_to_iio_buffer(struct device *dev);
> +struct iio_dev *iio_buffer_get_attached_iio_dev(struct iio_buffer *buffer);
> +
>  void iio_buffer_set_attrs(struct iio_buffer *buffer,
>  			 const struct attribute **attrs);
>  

