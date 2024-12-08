Return-Path: <linux-iio+bounces-13246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3B9E873A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEBC164212
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E855158D96;
	Sun,  8 Dec 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS5bHq1k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E81EA65;
	Sun,  8 Dec 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681739; cv=none; b=OZdnZp0QXiE0lIAZAm7rTY39J44udn7jsVDEM1CSULHdcrgO13/y5GxUt2R2lTGY95md8LYShKTOT1fJDZ95pJwk1JnyuVlB9QZr706Mb7EAWzML3dVvz+eDwzIXK8Ux2QXaG2vhUAoGVggL9JFwKC3ikIp3YidPR5RWMoGBiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681739; c=relaxed/simple;
	bh=iD0RWwS5DdYUkCd5ss4s0ut3URr2GPqXxKSjtRwe0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bx48HAXq12BFPSYLL6206ib6frFJ5kqcPA704GYIKGKaacWoaE40Fzl7cu5cZdGZTv+lCfG1LyTlfWimBhVnNLC0tqBuzFF9mHun6s8YHuRIX2+nJ4ea4R6uU2avGkuKlMNDGiwL/Q8os9DVvW3OZqNKUqevaTKWbYdMNbj+P7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS5bHq1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AEEC4CED2;
	Sun,  8 Dec 2024 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733681738;
	bh=iD0RWwS5DdYUkCd5ss4s0ut3URr2GPqXxKSjtRwe0vM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OS5bHq1kLCPXFTTadlHcmikvIE1HBRuuHSp3nU1zC5dSG+ETdk999EKFZn0Zq5IdY
	 DFkPjKs9SCh+Q7rXYbpg4JNqi48sbdaoxdx0Jx2/lJ8GLkD5ANJEhSoYceeFuISySu
	 NSqzSqbMb/ZJ0YgAlyqrVCo/CGXVGGrEv0HLBoco8A7C1iYlv/msbz1+DYawxacpGD
	 mhZE182vcjwkLAqwTYESZV7q3aOcWKEKMvLR/oPXAJI7l7q0Luu7HIByXYd/GY7lQG
	 Mw/TJ9yJF79U4RbZlK3pcjF5UnYHLwrIBnBVeZ1zrYMSB+NSpfQOOm89xOcUI0YXrc
	 A7agbhHIwYY4g==
Date: Sun, 8 Dec 2024 18:15:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
Message-ID: <20241208181531.47997ab4@jic23-huawei>
In-Reply-To: <20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
	<20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Dec 2024 16:11:08 +0100
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> During channel configuration, the iio-mux driver allocates a page with
> devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
> buffer points to an offset of the page due to the devres header sitting
> at the beginning of the allocated area. This leads to failure in the
> provider driver when sysfs_emit* helpers are used to format the ext_info
> attributes.
> 
> Switch to plain kzalloc version. The devres version is not strictly
> necessary as the buffer is only accessed during the channel
> configuration phase. Rely on __free cleanup to deallocate the buffer.
> Also, move the ext_info handling into a new function to have the page
> buffer definition and assignment in one statement as suggested by
> cleanup documentation.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
This seems fine to me, but the diff ended up a bit complex, so I'd like
Peter to take a look as well before I apply it.

Do you have a board that is hitting this?  If so, a fixes tag is definitely
appropriate. I think it is probably appropriate even it not.

Jonathan

> ---
>  drivers/iio/multiplexer/iio-mux.c | 84 +++++++++++++++++++++------------------
>  1 file changed, 46 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..c309d991490c63ba4299f1cda7102f10dcf54982 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -7,6 +7,7 @@
>   * Author: Peter Rosin <peda@axentia.se>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/iio.h>
> @@ -237,49 +238,18 @@ static ssize_t mux_write_ext_info(struct iio_dev *indio_dev, uintptr_t private,
>  	return ret;
>  }
>  
> -static int mux_configure_channel(struct device *dev, struct mux *mux,
> -				 u32 state, const char *label, int idx)
> +static int mux_configure_chan_ext_info(struct device *dev, struct mux *mux,
> +				       int idx, int num_ext_info)
>  {
>  	struct mux_child *child = &mux->child[idx];
> -	struct iio_chan_spec *chan = &mux->chan[idx];
>  	struct iio_chan_spec const *pchan = mux->parent->channel;
> -	char *page = NULL;
> -	int num_ext_info;
>  	int i;
>  	int ret;
>  
> -	chan->indexed = 1;
> -	chan->output = pchan->output;
> -	chan->datasheet_name = label;
> -	chan->ext_info = mux->ext_info;
> -
> -	ret = iio_get_channel_type(mux->parent, &chan->type);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to get parent channel type\n");
> -		return ret;
> -	}
> -
> -	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> -		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> -	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> -		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> -
> -	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> -		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> -
> -	if (state >= mux_control_states(mux->control)) {
> -		dev_err(dev, "too many channels\n");
> -		return -EINVAL;
> -	}
> -
> -	chan->channel = state;
> +	char *page __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
>  
> -	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
> -	if (num_ext_info) {
> -		page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> -		if (!page)
> -			return -ENOMEM;
> -	}
>  	child->ext_info_cache = devm_kcalloc(dev,
>  					     num_ext_info,
>  					     sizeof(*child->ext_info_cache),
> @@ -318,8 +288,46 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
>  		child->ext_info_cache[i].size = ret;
>  	}
>  
> -	if (page)
> -		devm_kfree(dev, page);
> +	return 0;
> +}
> +
> +static int mux_configure_channel(struct device *dev, struct mux *mux, u32 state,
> +				 const char *label, int idx)
> +{
> +	struct iio_chan_spec *chan = &mux->chan[idx];
> +	struct iio_chan_spec const *pchan = mux->parent->channel;
> +	int num_ext_info;
> +	int ret;
> +
> +	chan->indexed = 1;
> +	chan->output = pchan->output;
> +	chan->datasheet_name = label;
> +	chan->ext_info = mux->ext_info;
> +
> +	ret = iio_get_channel_type(mux->parent, &chan->type);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get parent channel type\n");
> +		return ret;
> +	}
> +
> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> +
> +	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> +
> +	if (state >= mux_control_states(mux->control)) {
> +		dev_err(dev, "too many channels\n");
> +		return -EINVAL;
> +	}
> +
> +	chan->channel = state;
> +
> +	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
> +	if (num_ext_info)
> +		return mux_configure_chan_ext_info(dev, mux, idx, num_ext_info);
>  
>  	return 0;
>  }
> 


