Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D466126359D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIISKB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIISKA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:10:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858072065E;
        Wed,  9 Sep 2020 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674999;
        bh=WcN7o0WoCWMarIj18Tvm9gWbjTAzLh3VHAQ7PUzuDtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i57prO7jEhE/uEz8luWjOvChuHKX8A/3Ni0WqqD/DLVnDJDcY6w5VqGDlamCY7tYw
         oAh67V+0T6C4T7Evran2bIVgRPeNGvnqWdTXudHkF5Gp0YDSlPn+yGRUKgBSa5UM0T
         QSWbMOwD1BmtpUQPr6rilsfUwkalVQeB72EKvjis=
Date:   Wed, 9 Sep 2020 19:09:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 07/10] iio: provide of_iio_channel_get_by_name() and
 devm_ version it
Message-ID: <20200909190953.6cee7020@archlinux>
In-Reply-To: <20200909144248.54327-8-dmitry.baryshkov@linaro.org>
References: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
        <20200909144248.54327-8-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Sep 2020 17:42:45 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> There might be cases when the IIO channel is attached to the device
> subnode instead of being attached to the main device node. Allow drivers
> to query IIO channels by using device tree nodes.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/iio/inkern.c         | 33 +++++++++++++++++++++++++--------
>  include/linux/iio/consumer.h | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ede99e0d5371..3083f886d3da 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -180,8 +180,8 @@ static struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
>  	return ERR_PTR(err);
>  }
>  
> -static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
> -						      const char *name)
> +struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
> +					       const char *name)

Doesn't this need and EXPORT_SYMBOL_GPL?

Otherwise I'm fine with the patch.

Jonathan

>  {
>  	struct iio_channel *chan = NULL;
>  
> @@ -261,12 +261,6 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
>  
>  #else /* CONFIG_OF */
>  
> -static inline struct iio_channel *
> -of_iio_channel_get_by_name(struct device_node *np, const char *name)
> -{
> -	return NULL;
> -}
> -
>  static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
>  {
>  	return NULL;
> @@ -382,6 +376,29 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_channel_get);
>  
> +struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
> +						    struct device_node *np,
> +						    const char *channel_name)
> +{
> +	struct iio_channel **ptr, *channel;
> +
> +	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	channel = of_iio_channel_get_by_name(np, channel_name);
> +	if (IS_ERR(channel)) {
> +		devres_free(ptr);
> +		return channel;
> +	}
> +
> +	*ptr = channel;
> +	devres_add(dev, ptr);
> +
> +	return channel;
> +}
> +EXPORT_SYMBOL_GPL(devm_of_iio_channel_get_by_name);
> +
>  struct iio_channel *iio_channel_get_all(struct device *dev)
>  {
>  	const char *name;
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index c4118dcb8e05..0a90ba8fa1bb 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -13,6 +13,7 @@
>  struct iio_dev;
>  struct iio_chan_spec;
>  struct device;
> +struct device_node;
>  
>  /**
>   * struct iio_channel - everything needed for a consumer to use a channel
> @@ -97,6 +98,41 @@ void iio_channel_release_all(struct iio_channel *chan);
>   */
>  struct iio_channel *devm_iio_channel_get_all(struct device *dev);
>  
> +/**
> + * of_iio_channel_get_by_name() - get description of all that is needed to access channel.
> + * @np:			Pointer to consumer device tree node
> + * @consumer_channel:	Unique name to identify the channel on the consumer
> + *			side. This typically describes the channels use within
> + *			the consumer. E.g. 'battery_voltage'
> + */
> +#ifdef CONFIG_OF
> +struct iio_channel *of_iio_channel_get_by_name(struct device_node *np, const char *name);
> +#else
> +static inline struct iio_channel *
> +of_iio_channel_get_by_name(struct device_node *np, const char *name)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +/**
> + * devm_of_iio_channel_get_by_name() - Resource managed version of of_iio_channel_get_by_name().
> + * @dev:		Pointer to consumer device.
> + * @np:			Pointer to consumer device tree node
> + * @consumer_channel:	Unique name to identify the channel on the consumer
> + *			side. This typically describes the channels use within
> + *			the consumer. E.g. 'battery_voltage'
> + *
> + * Returns a pointer to negative errno if it is not able to get the iio channel
> + * otherwise returns valid pointer for iio channel.
> + *
> + * The allocated iio channel is automatically released when the device is
> + * unbound.
> + */
> +struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
> +						    struct device_node *np,
> +						    const char *consumer_channel);
> +
>  struct iio_cb_buffer;
>  /**
>   * iio_channel_get_all_cb() - register callback for triggered capture

