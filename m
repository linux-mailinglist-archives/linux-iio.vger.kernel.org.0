Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CE120C329
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgF0RFP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 13:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgF0RFO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 13:05:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A8120760;
        Sat, 27 Jun 2020 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593277512;
        bh=IICWfEXWY/u7oTx8asfzklBhrwnhQUGVc141zpJDLL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=joLeWMw/REb03SQKMmGkCzh4f/aDRyDv2QZAnMAjZe9wx2F9s1XnJVqj5tSQWNIHU
         goEKJE917yKgP3rXxkUFGMetTVEt5n37nKMkvRHH2575CcjFEO7x84QF5HhXObrEyT
         ybR92SXEDJG8gS5KTxHtmO8VygFPZlLLtrvQ+T+k=
Date:   Sat, 27 Jun 2020 18:05:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <knaack.h@gmx.de>
Subject: Re: [PATCH v3 7/7] iio: core: move event interface on the opaque
 struct
Message-ID: <20200627180508.14e4ceab@archlinux>
In-Reply-To: <20200621123345.2469-8-alexandru.ardelean@analog.com>
References: <20200621123345.2469-1-alexandru.ardelean@analog.com>
        <20200621123345.2469-8-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jun 2020 15:33:45 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Same as with other private fields, this moves the event interface reference
> to the opaque IIO device object, to be invisible to drivers.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Whole series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it and see what we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c  |  5 ++-
>  drivers/iio/industrialio-event.c | 68 +++++++++++++++++++-------------
>  include/linux/iio/iio-opaque.h   |  2 +
>  include/linux/iio/iio.h          |  3 --
>  4 files changed, 45 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 051cb05a8da7..12550f59caa4 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -205,7 +205,8 @@ EXPORT_SYMBOL(iio_read_const_attr);
>  int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>  {
>  	int ret;
> -	const struct iio_event_interface *ev_int = indio_dev->event_interface;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	const struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>  
>  	ret = mutex_lock_interruptible(&indio_dev->mlock);
>  	if (ret)
> @@ -1436,7 +1437,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  			attrcount += ret;
>  		}
>  
> -	if (indio_dev->event_interface)
> +	if (iio_dev_opaque->event_interface)
>  		clk = &dev_attr_current_timestamp_clock.attr;
>  
>  	if (indio_dev->name)
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 5b17c92d3b50..2ab4d4c44427 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -18,6 +18,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/wait.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/iio-opaque.h>
>  #include "iio_core.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> @@ -62,7 +63,8 @@ bool iio_event_enabled(const struct iio_event_interface *ev_int)
>   **/
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>  {
> -	struct iio_event_interface *ev_int = indio_dev->event_interface;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>  	struct iio_event_data ev;
>  	int copied;
>  
> @@ -96,7 +98,8 @@ static __poll_t iio_event_poll(struct file *filep,
>  			     struct poll_table_struct *wait)
>  {
>  	struct iio_dev *indio_dev = filep->private_data;
> -	struct iio_event_interface *ev_int = indio_dev->event_interface;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>  	__poll_t events = 0;
>  
>  	if (!indio_dev->info)
> @@ -116,7 +119,8 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>  				     loff_t *f_ps)
>  {
>  	struct iio_dev *indio_dev = filep->private_data;
> -	struct iio_event_interface *ev_int = indio_dev->event_interface;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>  	unsigned int copied;
>  	int ret;
>  
> @@ -165,7 +169,8 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>  static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>  {
>  	struct iio_dev *indio_dev = filep->private_data;
> -	struct iio_event_interface *ev_int = indio_dev->event_interface;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>  
>  	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>  
> @@ -184,7 +189,8 @@ static const struct file_operations iio_event_chrdev_fileops = {
>  
>  int iio_event_getfd(struct iio_dev *indio_dev)
>  {
> -	struct iio_event_interface *ev_int = indio_dev->event_interface;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>  	int fd;
>  
>  	if (ev_int == NULL)
> @@ -343,6 +349,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>  	enum iio_event_type type, enum iio_event_direction dir,
>  	enum iio_shared_by shared_by, const unsigned long *mask)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	ssize_t (*show)(struct device *, struct device_attribute *, char *);
>  	ssize_t (*store)(struct device *, struct device_attribute *,
>  		const char *, size_t);
> @@ -376,7 +383,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>  
>  		ret = __iio_add_chan_devattr(postfix, chan, show, store,
>  			 (i << 16) | spec_index, shared_by, &indio_dev->dev,
> -			&indio_dev->event_interface->dev_attr_list);
> +			&iio_dev_opaque->event_interface->dev_attr_list);
>  		kfree(postfix);
>  
>  		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
> @@ -469,6 +476,7 @@ static void iio_setup_ev_int(struct iio_event_interface *ev_int)
>  static const char *iio_event_group_name = "events";
>  int iio_device_register_eventset(struct iio_dev *indio_dev)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_dev_attr *p;
>  	int ret = 0, attrcount_orig = 0, attrcount, attrn;
>  	struct attribute **attr;
> @@ -477,14 +485,14 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  	      iio_check_for_dynamic_events(indio_dev)))
>  		return 0;
>  
> -	indio_dev->event_interface =
> +	iio_dev_opaque->event_interface =
>  		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> -	if (indio_dev->event_interface == NULL)
> +	if (iio_dev_opaque->event_interface == NULL)
>  		return -ENOMEM;
>  
> -	INIT_LIST_HEAD(&indio_dev->event_interface->dev_attr_list);
> +	INIT_LIST_HEAD(&iio_dev_opaque->event_interface->dev_attr_list);
>  
> -	iio_setup_ev_int(indio_dev->event_interface);
> +	iio_setup_ev_int(iio_dev_opaque->event_interface);
>  	if (indio_dev->info->event_attrs != NULL) {
>  		attr = indio_dev->info->event_attrs->attrs;
>  		while (*attr++ != NULL)
> @@ -498,35 +506,35 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  		attrcount += ret;
>  	}
>  
> -	indio_dev->event_interface->group.name = iio_event_group_name;
> -	indio_dev->event_interface->group.attrs = kcalloc(attrcount + 1,
> -							  sizeof(indio_dev->event_interface->group.attrs[0]),
> +	iio_dev_opaque->event_interface->group.name = iio_event_group_name;
> +	iio_dev_opaque->event_interface->group.attrs = kcalloc(attrcount + 1,
> +							  sizeof(iio_dev_opaque->event_interface->group.attrs[0]),
>  							  GFP_KERNEL);
> -	if (indio_dev->event_interface->group.attrs == NULL) {
> +	if (iio_dev_opaque->event_interface->group.attrs == NULL) {
>  		ret = -ENOMEM;
>  		goto error_free_setup_event_lines;
>  	}
>  	if (indio_dev->info->event_attrs)
> -		memcpy(indio_dev->event_interface->group.attrs,
> +		memcpy(iio_dev_opaque->event_interface->group.attrs,
>  		       indio_dev->info->event_attrs->attrs,
> -		       sizeof(indio_dev->event_interface->group.attrs[0])
> +		       sizeof(iio_dev_opaque->event_interface->group.attrs[0])
>  		       *attrcount_orig);
>  	attrn = attrcount_orig;
>  	/* Add all elements from the list. */
>  	list_for_each_entry(p,
> -			    &indio_dev->event_interface->dev_attr_list,
> +			    &iio_dev_opaque->event_interface->dev_attr_list,
>  			    l)
> -		indio_dev->event_interface->group.attrs[attrn++] =
> +		iio_dev_opaque->event_interface->group.attrs[attrn++] =
>  			&p->dev_attr.attr;
>  	indio_dev->groups[indio_dev->groupcounter++] =
> -		&indio_dev->event_interface->group;
> +		&iio_dev_opaque->event_interface->group;
>  
>  	return 0;
>  
>  error_free_setup_event_lines:
> -	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
> -	kfree(indio_dev->event_interface);
> -	indio_dev->event_interface = NULL;
> +	iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> +	kfree(iio_dev_opaque->event_interface);
> +	iio_dev_opaque->event_interface = NULL;
>  	return ret;
>  }
>  
> @@ -539,16 +547,20 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>   */
>  void iio_device_wakeup_eventset(struct iio_dev *indio_dev)
>  {
> -	if (indio_dev->event_interface == NULL)
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	if (iio_dev_opaque->event_interface == NULL)
>  		return;
> -	wake_up(&indio_dev->event_interface->wait);
> +	wake_up(&iio_dev_opaque->event_interface->wait);
>  }
>  
>  void iio_device_unregister_eventset(struct iio_dev *indio_dev)
>  {
> -	if (indio_dev->event_interface == NULL)
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	if (iio_dev_opaque->event_interface == NULL)
>  		return;
> -	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
> -	kfree(indio_dev->event_interface->group.attrs);
> -	kfree(indio_dev->event_interface);
> +	iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> +	kfree(iio_dev_opaque->event_interface->group.attrs);
> +	kfree(iio_dev_opaque->event_interface);
>  }
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index af6c69a40169..f2e94196d31f 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -6,6 +6,7 @@
>  /**
>   * struct iio_dev_opaque - industrial I/O device opaque information
>   * @indio_dev:			public industrial I/O device information
> + * @event_interface:		event chrdevs associated with interrupt lines
>   * @buffer_list:		list of all buffers currently attached
>   * @channel_attr_list:		keep track of automatically created channel
>   *				attributes
> @@ -17,6 +18,7 @@
>   */
>  struct iio_dev_opaque {
>  	struct iio_dev			indio_dev;
> +	struct iio_event_interface	*event_interface;
>  	struct list_head		buffer_list;
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 219847f6f5c6..e2df67a3b9ab 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -488,7 +488,6 @@ struct iio_buffer_setup_ops {
>   * @currentmode:	[DRIVER] current operating mode
>   * @dev:		[DRIVER] device structure, should be assigned a parent
>   *			and owner
> - * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
>   * @buffer:		[DRIVER] any buffer present
>   * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
>   * @mlock:		[INTERN] lock used to prevent simultaneous device state
> @@ -527,8 +526,6 @@ struct iio_dev {
>  	int				currentmode;
>  	struct device			dev;
>  
> -	struct iio_event_interface	*event_interface;
> -
>  	struct iio_buffer		*buffer;
>  	int				scan_bytes;
>  	struct mutex			mlock;

