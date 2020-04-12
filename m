Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD271A5E9E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgDLM6T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 08:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLM6S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 08:58:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E3120656;
        Sun, 12 Apr 2020 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586696298;
        bh=sv62MUnmE2e4KaYyhwT8NiyrnD7xpYLG4WJZJATIqr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJOweBRUeRhsDiNVrhGpYYAcjGNRelG94ybucRUQTpoq/sraE1V7UE4AvoIeClp8c
         sglFXtgxO78WBdUtK2N/Am7WserwUPN9E4TXjmkXIBSxdak03ZZqWd7YOp05lZz+lB
         Hz9UAi4SQnJsh7GyWfDpNzZouvc0y246F7U8Y+ZY=
Date:   Sun, 12 Apr 2020 13:58:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] iio: inkern: drop devm_iio_channel_release{_all}
 API calls
Message-ID: <20200412135814.29957010@archlinux>
In-Reply-To: <20200227135227.12433-6-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <20200227135227.12433-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:25 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  .../driver-api/driver-model/devres.rst        |  2 --
>  drivers/iio/inkern.c                          | 27 -------------------
>  include/linux/iio/consumer.h                  | 18 -------------
>  3 files changed, 47 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 6c401c74e480..10ccebe9f7c1 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -291,9 +291,7 @@ IIO
>    devm_iio_trigger_alloc()
>    devm_iio_trigger_register()
>    devm_iio_channel_get()
> -  devm_iio_channel_release()
>    devm_iio_channel_get_all()
> -  devm_iio_channel_release_all()
>  
>  INPUT
>    devm_input_allocate_device()
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 5a8351c9a426..ede99e0d5371 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -360,18 +360,6 @@ static void devm_iio_channel_free(struct device *dev, void *res)
>  	iio_channel_release(channel);
>  }
>  
> -static int devm_iio_channel_match(struct device *dev, void *res, void *data)
> -{
> -	struct iio_channel **r = res;
> -
> -	if (!r || !*r) {
> -		WARN_ON(!r || !*r);
> -		return 0;
> -	}
> -
> -	return *r == data;
> -}
> -
>  struct iio_channel *devm_iio_channel_get(struct device *dev,
>  					 const char *channel_name)
>  {
> @@ -394,13 +382,6 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_channel_get);
>  
> -void devm_iio_channel_release(struct device *dev, struct iio_channel *channel)
> -{
> -	WARN_ON(devres_release(dev, devm_iio_channel_free,
> -			       devm_iio_channel_match, channel));
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_channel_release);
> -
>  struct iio_channel *iio_channel_get_all(struct device *dev)
>  {
>  	const char *name;
> @@ -514,14 +495,6 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
>  
> -void devm_iio_channel_release_all(struct device *dev,
> -				  struct iio_channel *channels)
> -{
> -	WARN_ON(devres_release(dev, devm_iio_channel_free_all,
> -			       devm_iio_channel_match, channels));
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_channel_release_all);
> -
>  static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>  	enum iio_chan_info_enum info)
>  {
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 2bde8c912d4d..c4118dcb8e05 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -63,15 +63,6 @@ void iio_channel_release(struct iio_channel *chan);
>   */
>  struct iio_channel *devm_iio_channel_get(struct device *dev,
>  					 const char *consumer_channel);
> -/**
> - * devm_iio_channel_release() - Resource managed version of
> - *				iio_channel_release().
> - * @dev:		Pointer to consumer device for which resource
> - *			is allocared.
> - * @chan:		The channel to be released.
> - */
> -void devm_iio_channel_release(struct device *dev, struct iio_channel *chan);
> -
>  /**
>   * iio_channel_get_all() - get all channels associated with a client
>   * @dev:		Pointer to consumer device.
> @@ -106,15 +97,6 @@ void iio_channel_release_all(struct iio_channel *chan);
>   */
>  struct iio_channel *devm_iio_channel_get_all(struct device *dev);
>  
> -/**
> - * devm_iio_channel_release_all() - Resource managed version of
> - *				    iio_channel_release_all().
> - * @dev:		Pointer to consumer device for which resource
> - *			is allocared.
> - * @chan:		Array channel to be released.
> - */
> -void devm_iio_channel_release_all(struct device *dev, struct iio_channel *chan);
> -
>  struct iio_cb_buffer;
>  /**
>   * iio_channel_get_all_cb() - register callback for triggered capture

