Return-Path: <linux-iio+bounces-5612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0548D7546
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE4B1C21045
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEFB383A0;
	Sun,  2 Jun 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFnTgWkM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F7D51A;
	Sun,  2 Jun 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717330670; cv=none; b=YekazV2PITBujLo0w96VtyU/o4ZkiJS63YDYgenL61uHNKZNErdAJv3TThLs+Iw8HmbHtoFwodD+zAE+VCgQWub82dg3stVX1mLgrmODxWPhbtNPdlrXPYdol7c1ri1+133Zv705sQ8lwS8vkCWu8tlZp2NeHspiU5tpiUZH95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717330670; c=relaxed/simple;
	bh=HY0My0DLUIeHYUqQsufaZdJw8FEAp9y6Gwj+krEY0Co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMox2a7Pi4K0800dAdSAJbjQvOIwCBUhIzm07613s50Xch5Ke1jkQoDlEQl9gd+57t5IJMyINwdMEB2LR5uzldv4gUKzuOBtyo4useUCPp0P0Fw6PRzH3VmNpZr3YbnKGxqXLDjH6N9ZsSaMqNtHQZrAaSSMwdM+aOIdSBSxgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFnTgWkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9C3C2BBFC;
	Sun,  2 Jun 2024 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717330670;
	bh=HY0My0DLUIeHYUqQsufaZdJw8FEAp9y6Gwj+krEY0Co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fFnTgWkMZ8Rki5dLxLA7o+VNqqYip4VhSaL74olZ/yJ85/OAS+nT+4FTqXllcS+Iw
	 GnXrm2SiVEZAU3R82qUhz0+AMUXfNIhxAQpknfwvGe7pQ1/UXgyDuBk/TymQDLqbWJ
	 +5nB0CI05neBbc/5zb685UpvR4J1ndBIeSD2OSp1ANeltA/tZQRf8okVXkjPgr7PYs
	 IdVjbe9jskEz1W64vZDryV2hd26C0KbmxA+YwokUJsqwv2c6A7qToeaF+ubBFYNhzE
	 yDT5oEq9VXpS0aAqUoo/yrlPWlpG2p5AXqJ0Bgr55yeTnHdXpKBdFzqEldSuRK+1cx
	 GRADcY5QSBonA==
Date: Sun, 2 Jun 2024 13:17:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3] driver: iio: add missing checks on iio_info's
 callback access
Message-ID: <20240602131738.4ad85e85@jic23-huawei>
In-Reply-To: <20240530-iio-core-fix-segfault-v3-1-8b7cd2a03773@baylibre.com>
References: <20240530-iio-core-fix-segfault-v3-1-8b7cd2a03773@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 11:22:46 +0200
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
Dropped v2 and picked this one up.  Oops.

Jonathan

> ---
> Changes in v3:
> - Use local variable in inkern.c to reduce long lines
> - Pick up Nuno reviewed-by tag
> - Link to v2: https://lore.kernel.org/r/20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com
> 
> Changes in v2:
> - crop dmesg log to show only pertinent info and reduce commit message
> - Link to v1: https://lore.kernel.org/r/20240529-iio-core-fix-segfault-v1-1-7ff1ba881d38@baylibre.com
> ---
>  drivers/iio/industrialio-core.c  |  7 ++++++-
>  drivers/iio/industrialio-event.c |  9 +++++++++
>  drivers/iio/inkern.c             | 32 ++++++++++++++++++++++----------
>  3 files changed, 37 insertions(+), 11 deletions(-)
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
> index 52d773261828..77cf1f22df31 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -543,6 +543,7 @@ EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
>  static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>  			    enum iio_chan_info_enum info)
>  {
> +	const struct iio_info *iio_info = chan->indio_dev->info;
>  	int unused;
>  	int vals[INDIO_MAX_RAW_ELEMENTS];
>  	int ret;
> @@ -554,15 +555,18 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>  	if (!iio_channel_has_info(chan->channel, info))
>  		return -EINVAL;
>  
> -	if (chan->indio_dev->info->read_raw_multi) {
> -		ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
> -					chan->channel, INDIO_MAX_RAW_ELEMENTS,
> -					vals, &val_len, info);
> +	if (iio_info->read_raw_multi) {
> +		ret = iio_info->read_raw_multi(chan->indio_dev,
> +					       chan->channel,
> +					       INDIO_MAX_RAW_ELEMENTS,
> +					       vals, &val_len, info);
>  		*val = vals[0];
>  		*val2 = vals[1];
> +	} else if (iio_info->read_raw) {
> +		ret = iio_info->read_raw(chan->indio_dev,
> +					 chan->channel, val, val2, info);
>  	} else {
> -		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
> -					chan->channel, val, val2, info);
> +		return -EINVAL;
>  	}
>  
>  	return ret;
> @@ -750,11 +754,15 @@ static int iio_channel_read_avail(struct iio_channel *chan,
>  				  const int **vals, int *type, int *length,
>  				  enum iio_chan_info_enum info)
>  {
> +	const struct iio_info *iio_info = chan->indio_dev->info;
> +
>  	if (!iio_channel_has_available(chan->channel, info))
>  		return -EINVAL;
>  
> -	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
> -						 vals, type, length, info);
> +	if (iio_info->read_avail)
> +		return iio_info->read_avail(chan->indio_dev, chan->channel,
> +					    vals, type, length, info);
> +	return -EINVAL;
>  }
>  
>  int iio_read_avail_channel_attribute(struct iio_channel *chan,
> @@ -917,8 +925,12 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
>  static int iio_channel_write(struct iio_channel *chan, int val, int val2,
>  			     enum iio_chan_info_enum info)
>  {
> -	return chan->indio_dev->info->write_raw(chan->indio_dev,
> -						chan->channel, val, val2, info);
> +	const struct iio_info *iio_info = chan->indio_dev->info;
> +
> +	if (iio_info->write_raw)
> +		return iio_info->write_raw(chan->indio_dev,
> +					   chan->channel, val, val2, info);
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


