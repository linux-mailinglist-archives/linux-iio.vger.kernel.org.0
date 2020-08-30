Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3142D256D6D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgH3LYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 07:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgH3LYc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 07:24:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCAAA2068F;
        Sun, 30 Aug 2020 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598786671;
        bh=AXgZqkiNKdqMz0DhD4cmdUyH6rTmmy1aRlxJUhshraI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KdabngcQxahpORg7MDTXEJ4ITSMi4t7bfYIDfAfgVPMNmA8FCBCF4nzEmqMWEfAOu
         2SnzGjs0mKYmPEJGkQP5B1LL/hGqy05B0mdTr6kI0RisseJ3iI/D5EKnNtEVrSDBCv
         PfrxMv6KAEXQmnkiTbuj63JuEbIjArjXur0Vf9eA=
Date:   Sun, 30 Aug 2020 12:24:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] iio: core: Add optional symbolic label to a
 device channel
Message-ID: <20200830122425.3e00332b@archlinux>
In-Reply-To: <20200824083646.84886-1-cristian.pop@analog.com>
References: <20200824083646.84886-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Aug 2020 11:36:46 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> If a label is defined in the device tree for this channel add that
> to the channel specific attributes. This is useful for userspace to
> be able to identify an individual channel.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  Changes in v2:
> 	- Move label check before "read_raw" callback.
> 	- Move the responsability to of parsing channel labels, to the
> 	  driver.
> 
>  drivers/iio/industrialio-core.c | 10 ++++++++--
>  include/linux/iio/iio.h         |  2 ++
>  include/linux/iio/types.h       |  1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 1527f01a44f1..32277e94f02d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -135,6 +135,7 @@ static const char * const iio_modifier_names[] = {
>  /* relies on pairs of these shared then separate */
>  static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_RAW] = "raw",
> +	[IIO_CHAN_INFO_LABEL] = "label",
>  	[IIO_CHAN_INFO_PROCESSED] = "input",
>  	[IIO_CHAN_INFO_SCALE] = "scale",
>  	[IIO_CHAN_INFO_OFFSET] = "offset",
> @@ -653,14 +654,18 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  	int ret;
>  	int val_len = 2;
>  
> -	if (indio_dev->info->read_raw_multi)
> +	if (indio_dev->info->read_raw_multi) {
>  		ret = indio_dev->info->read_raw_multi(indio_dev, this_attr->c,
>  							INDIO_MAX_RAW_ELEMENTS,
>  							vals, &val_len,
>  							this_attr->address);
> -	else
> +	} else {
>  		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
>  				    &vals[0], &vals[1], this_attr->address);
> +		if (ret < 0 && this_attr->address == IIO_CHAN_INFO_LABEL &&
> +			this_attr->c->label_name)

I'm not keen on this. We shouldn't be calling read_raw at all in this path.
There is no way it can return a valid label.

> +			return sprintf(buf, "%s\n", this_attr->c->label_name);
> +	}
>  
>  	if (ret < 0)
>  		return ret;
> @@ -1399,6 +1404,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  			attrcount_orig++;
>  	}
>  	attrcount = attrcount_orig;
> +

Please avoid unrelated white space changes.

>  	/*
>  	 * New channel registration method - relies on the fact a group does
>  	 * not need to be initialized if its name is NULL.
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a1be82e74c93..39209f3b62be 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -223,6 +223,7 @@ struct iio_event_spec {
>   *			correspond to the first name that the channel is referred
>   *			to by in the datasheet (e.g. IND), or the nearest
>   *			possible compound name (e.g. IND-INC).
> + * @label_name:		Unique name to identify which channel this is.
>   * @modified:		Does a modifier apply to this channel. What these are
>   *			depends on the channel type.  Modifier is set in
>   *			channel2. Examples are IIO_MOD_X for axial sensors about
> @@ -260,6 +261,7 @@ struct iio_chan_spec {
>  	const struct iio_chan_spec_ext_info *ext_info;
>  	const char		*extend_name;
>  	const char		*datasheet_name;
> +	const char		*label_name;

This can't be part of chan_spec as that is constant in many drivers.
We need a separate way of doing this.  Don't use info_mask,
but register it separately for each channel in a similar way
to we do the name and label attributes for the whole device.

I would add a new callback to iio_info that is passed the
iio_chan_spec and returns a const char * for the label name.

The driver would be responsible for doing a lookup based
on what it has cached from the dt parse, probably indexed
off address or scan_index (that can be driver specific)

To create the attribute you need to add this to
iio_device_register_sysfs and use the various core
functions to build the attribute name in a similar fashion to
that done for info mask elements.

It will be more complex than your approach, but make it more
'separable' as a feature in drivers.

Jonathan


>  	unsigned		modified:1;
>  	unsigned		indexed:1;
>  	unsigned		output:1;
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index e6fd3645963c..c8f65f476eb2 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -34,6 +34,7 @@ enum iio_available_type {
>  
>  enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_RAW = 0,
> +	IIO_CHAN_INFO_LABEL,
>  	IIO_CHAN_INFO_PROCESSED,
>  	IIO_CHAN_INFO_SCALE,
>  	IIO_CHAN_INFO_OFFSET,

