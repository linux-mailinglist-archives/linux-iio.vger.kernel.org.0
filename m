Return-Path: <linux-iio+bounces-5436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D8A8D35F8
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6509EB2455B
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB9180A7C;
	Wed, 29 May 2024 12:05:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94115819;
	Wed, 29 May 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984311; cv=none; b=EuvzwAa4mjTKJ812SITZERDNhke3K3tRd61Ln8ehLiVA6iP9iqwKc98090Wq4SB+FXKHWCabTTkf7Ct2XdkDWTrNFvjKoF7jecG//YYtoiAy55o7EZ/XcyN4dJKKC2fm/SazAndxrtkjKDuTNAPMYKUye1BHaVVCYjQ1hh/K9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984311; c=relaxed/simple;
	bh=tCvk79juIz9wzKGNptMN3HtzZn7h814QPCNAXxRLxw8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8ZmCJEaF+sxvsM/XtJw3WKNsSBjGRZae689FD0C3zKemgh/5IT+/jZRjmtb3Ea2bjgGsFVuwZrFjFdx+9a+nRA/b2GfPjXHkklUopW8sOw2dZmWallFUgvetZU13QpunzG/xSO46aOsIKbBcLV3uOzl7Sf3gJTrF1R/zxTMGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq7Hy3LVSz6K7B1;
	Wed, 29 May 2024 20:00:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F401F1400E7;
	Wed, 29 May 2024 20:04:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 29 May
 2024 13:04:59 +0100
Date: Wed, 29 May 2024 13:04:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Julien Stephan <jstephan@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nuno Sa
	<nuno.sa@analog.com>
Subject: Re: [PATCH v2] driver: iio: add missing checks on iio_info's
 callback access
Message-ID: <20240529130458.000049e6@Huawei.com>
In-Reply-To: <20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com>
References: <20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 29 May 2024 13:55:52 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Some callbacks from iio_info structure are accessed without any check, so
> if a driver doesn't implement them trying to access the corresponding
> sysfs entries produce a kernel oops such as:
> 
> [ 2203.527791] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when execute
> [...]
> [ 2203.783416] Call trace:
> [ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18/0x48
> [ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
> [ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
> [ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
> [ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
> [ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
> [ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
> [ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b6eab000 00020000 00000000
> [ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 00000000 00020000 00000000
> [ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
> [ 2203.830363] Code: bad PC value
> [ 2203.832695] ---[ end trace 0000000000000000 ]---
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

How bad would a registration time check look?
I'd rather catch this early than have drivers with missing hooks
that we don't notice because no one pokes the file.

The inkern ones are good though.

Jonathan

> ---
> Changes in v2:
> - crop dmesg log to show only pertinent info and reduce commit message
> - Link to v1: https://lore.kernel.org/r/20240529-iio-core-fix-segfault-v1-1-7ff1ba881d38@baylibre.com
> ---
>  drivers/iio/industrialio-core.c  |  7 ++++++-
>  drivers/iio/industrialio-event.c |  9 +++++++++
>  drivers/iio/inkern.c             | 16 +++++++++++-----
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index fa7cc051b4c4..2f185b386949 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -758,9 +758,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  							INDIO_MAX_RAW_ELEMENTS,
>  							vals, &val_len,
>  							this_attr->address);
> -	else
> +	else if (indio_dev->info->read_raw)
>  		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
>  				    &vals[0], &vals[1], this_attr->address);
> +	else
> +		return -EINVAL;
>  
>  	if (ret < 0)
>  		return ret;
> @@ -842,6 +844,9 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
>  	int length;
>  	int type;
>  
> +	if (!indio_dev->info->read_avail)
> +		return -EINVAL;
> +
>  	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
>  					  &vals, &type, &length,
>  					  this_attr->address);
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 910c1f14abd5..a64f8fbac597 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -285,6 +285,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!indio_dev->info->write_event_config)
> +		return -EINVAL;
> +
>  	ret = indio_dev->info->write_event_config(indio_dev,
>  		this_attr->c, iio_ev_attr_type(this_attr),
>  		iio_ev_attr_dir(this_attr), val);
> @@ -300,6 +303,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int val;
>  
> +	if (!indio_dev->info->read_event_config)
> +		return -EINVAL;
> +
>  	val = indio_dev->info->read_event_config(indio_dev,
>  		this_attr->c, iio_ev_attr_type(this_attr),
>  		iio_ev_attr_dir(this_attr));
> @@ -318,6 +324,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
>  	int val, val2, val_arr[2];
>  	int ret;
>  
> +	if (!indio_dev->info->read_event_value)
> +		return -EINVAL;
> +
>  	ret = indio_dev->info->read_event_value(indio_dev,
>  		this_attr->c, iio_ev_attr_type(this_attr),
>  		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 52d773261828..74f87f6ac390 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -560,9 +560,11 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>  					vals, &val_len, info);
>  		*val = vals[0];
>  		*val2 = vals[1];
> -	} else {
> +	} else if (chan->indio_dev->info->read_raw) {
>  		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
>  					chan->channel, val, val2, info);
> +	} else {
> +		return -EINVAL;
>  	}
>  
>  	return ret;
> @@ -753,8 +755,10 @@ static int iio_channel_read_avail(struct iio_channel *chan,
>  	if (!iio_channel_has_available(chan->channel, info))
>  		return -EINVAL;
>  
> -	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
> -						 vals, type, length, info);
> +	if (chan->indio_dev->info->read_avail)
> +		return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
> +							 vals, type, length, info);
> +	return -EINVAL;
>  }
>  
>  int iio_read_avail_channel_attribute(struct iio_channel *chan,
> @@ -917,8 +921,10 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
>  static int iio_channel_write(struct iio_channel *chan, int val, int val2,
>  			     enum iio_chan_info_enum info)
>  {
> -	return chan->indio_dev->info->write_raw(chan->indio_dev,
> -						chan->channel, val, val2, info);
> +	if (chan->indio_dev->info->write_raw)
> +		return chan->indio_dev->info->write_raw(chan->indio_dev,
> +							chan->channel, val, val2, info);
> +	return -EINVAL;
>  }
>  
>  int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
> 
> ---
> base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
> change-id: 20240528-iio-core-fix-segfault-aa74be7eee4a
> 
> Best regards,


