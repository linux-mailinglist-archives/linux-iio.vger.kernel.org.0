Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998D11DFF69
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgEXOjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 10:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgEXOjS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 10:39:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0861720776;
        Sun, 24 May 2020 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590331157;
        bh=pd3rOvJvBIMIvJKahwvHGb3XfUX0McQ+jlVRx9ZfDiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xWS7gs8NauPTejH4Q9B5U1IlYLrgjpOF/wc2CmUEsHOgLatvzIBeTrp8YTnvG9L6p
         +DMIzJ3HiOB58nuZQglRVEggvYhv3oBeQsRUxKqOfN3j7HiZzXBvLewXfp7/awKH+P
         t3UP1DEJmONk21SqkhAYERtu2L+AtDpUlxo7UJaQ=
Date:   Sun, 24 May 2020 15:39:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: remove usage of
 iio_priv_to_dev()
Message-ID: <20200524153913.3f3dfc00@archlinux>
In-Reply-To: <20200522065616.10901-1-alexandru.ardelean@analog.com>
References: <20200522065616.10901-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 09:56:16 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> We may want to get rid of the iio_priv_to_dev() helper. That's a bit
> uncertain at this point. The reason is that we will hide some of the
> members of the iio_dev structure (to prevent drivers from accessing them
> directly), and that will also mean hiding the implementation of the
> iio_priv_to_dev() helper inside the IIO core.
> 
> Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> may not be fast anymore, so a general idea is to try to get rid of the
> iio_priv_to_dev() altogether.
> 
> For this driver, removing the iio_priv_to_dev() helper means passing the
> iio_dev object on hts221_allocate_buffers() & hts221_allocate_trigger().
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

The hts221_hw structure is in iio_priv() so perhaps we could
drop passing that into these two calls and get it from iio_priv
within the functions?

I tidied that up whilst applying.  Shout if you disagree and I'll
back it out :)

Applied to the the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hts221.h        | 4 ++--
>  drivers/iio/humidity/hts221_buffer.c | 7 +++----
>  drivers/iio/humidity/hts221_core.c   | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 7d6771f7cf47..569146910885 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -46,7 +46,7 @@ extern const struct dev_pm_ops hts221_pm_ops;
>  int hts221_probe(struct device *dev, int irq, const char *name,
>  		 struct regmap *regmap);
>  int hts221_set_enable(struct hts221_hw *hw, bool enable);
> -int hts221_allocate_buffers(struct hts221_hw *hw);
> -int hts221_allocate_trigger(struct hts221_hw *hw);
> +int hts221_allocate_buffers(struct hts221_hw *hw, struct iio_dev *iio_dev);
> +int hts221_allocate_trigger(struct hts221_hw *hw, struct iio_dev *iio_dev);
>  
>  #endif /* HTS221_H */
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 9fb3f33614d4..48d469eeb0e6 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -72,10 +72,9 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -int hts221_allocate_trigger(struct hts221_hw *hw)
> +int hts221_allocate_trigger(struct hts221_hw *hw, struct iio_dev *iio_dev)
>  {
>  	struct st_sensors_platform_data *pdata = dev_get_platdata(hw->dev);
> -	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
>  	bool irq_active_low = false, open_drain = false;
>  	unsigned long irq_type;
>  	int err;
> @@ -190,9 +189,9 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -int hts221_allocate_buffers(struct hts221_hw *hw)
> +int hts221_allocate_buffers(struct hts221_hw *hw, struct iio_dev *iio_dev)
>  {
> -	return devm_iio_triggered_buffer_setup(hw->dev, iio_priv_to_dev(hw),
> +	return devm_iio_triggered_buffer_setup(hw->dev, iio_dev,
>  					NULL, hts221_buffer_handler_thread,
>  					&hts221_buffer_ops);
>  }
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 9003671f14fb..77dfa65df841 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -621,11 +621,11 @@ int hts221_probe(struct device *dev, int irq, const char *name,
>  	}
>  
>  	if (hw->irq > 0) {
> -		err = hts221_allocate_buffers(hw);
> +		err = hts221_allocate_buffers(hw, iio_dev);
>  		if (err < 0)
>  			return err;
>  
> -		err = hts221_allocate_trigger(hw);
> +		err = hts221_allocate_trigger(hw, iio_dev);
>  		if (err)
>  			return err;
>  	}

