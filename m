Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7FD4FA8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfJLM0Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJLMYZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:24:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E513E2089F;
        Sat, 12 Oct 2019 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570883064;
        bh=uspcJp/9ZTCFP6fvZqeb3kO3KEbm78deFaTbj9CV2M8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SuXTaEaxGKHE/TOESvGr8I0aL13F2KpYsYO75jg/ZG73rV7+iZV0sgkkHoF05aqv3
         9gjneAZ0vFfTRjFZO0OaFs+Q+hbfbKqOk7S3RVghLOEco2pQV0vVAFRdrNbo/kfqcy
         BAuWfr2PvlD1ekI1q5oIeCNWS76c3bVAgnN9684c=
Date:   Sat, 12 Oct 2019 13:24:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 09/13] iio: imu: st_lsm6dsx: fix checkpatch warning
Message-ID: <20191012132419.136fadcd@archlinux>
In-Reply-To: <7c8a7e5f17befae7ac541cfb155ec7fefa78b10e.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <7c8a7e5f17befae7ac541cfb155ec7fefa78b10e.1570367532.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:22:03 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix following checkpatch warnings:
> 
> CHECK: Alignment should match open parenthesis
> +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> +				   const struct iio_chan_spec *chan,
> 
> CHECK: Alignment should match open parenthesis
> +static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> +				    const struct iio_chan_spec *chan,
> 
> CHECK: Alignment should match open parenthesis
> +static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> +					  const struct iio_chan_spec *chan,
> 
> CHECK: Alignment should match open parenthesis
> +static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> +					   const struct iio_chan_spec *chan,
> 
> WARNING: line over 80 characters
> +	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 35 +++++++++++---------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 04231710ab9c..b0623b837abd 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1523,12 +1523,13 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
>  	return IIO_VAL_INT;
>  }
>  
> -static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> -				    const struct iio_chan_spec *chan,
> -				    enum iio_event_type type,
> -				    enum iio_event_direction dir,
> -				    enum iio_event_info info,
> -				    int val, int val2)
> +static int
> +st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> +		       const struct iio_chan_spec *chan,
> +		       enum iio_event_type type,
> +		       enum iio_event_direction dir,
> +		       enum iio_event_info info,
> +		       int val, int val2)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> @@ -1554,10 +1555,11 @@ static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>  	return 0;
>  }
>  
> -static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> -					  const struct iio_chan_spec *chan,
> -					  enum iio_event_type type,
> -					  enum iio_event_direction dir)
> +static int
> +st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     enum iio_event_type type,
> +			     enum iio_event_direction dir)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> @@ -1568,11 +1570,11 @@ static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
>  	return !!(hw->enable_event & BIT(chan->channel2));
>  }
>  
> -static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> -					   const struct iio_chan_spec *chan,
> -					   enum iio_event_type type,
> -					   enum iio_event_direction dir,
> -					   int state)
> +static int
> +st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir, int state)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> @@ -2150,7 +2152,8 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  			return err;
>  	}
>  
> -	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> +	if (dev->of_node &&
> +	    of_property_read_bool(dev->of_node, "wakeup-source"))
>  		device_init_wakeup(dev, true);
>  
>  	return 0;

