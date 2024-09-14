Return-Path: <linux-iio+bounces-9554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C71979128
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3BD1C216CF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B61CEEAB;
	Sat, 14 Sep 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG9jW3gU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA01805E;
	Sat, 14 Sep 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322002; cv=none; b=orUbLTeNcn67b3ClAagT9fCFYnj6bsqk1VFIZm+vxIDfC2na908ryZPGAE2kbjaquzdNDxQoaTjIBQr4wk90jxxuoddFXG0ZGyPhpR8WrBIfCeFm9xNxMzBlrFEO8nDAZ6lYl2Hvc5C+nkO/qe6AE4+LtlfcLOiVlfjNHNREFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322002; c=relaxed/simple;
	bh=I1goio9CgAST7ziInKKK1WisxibGk2VKmozQ1oSwq0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXk9icS+1+DiHaPJ0/sAYESVADeFZGGh78r8euDurY8vFz9bsLVx30OOBlUoqtghvHdHQqe6CPC882tAGFuKQstJOL6WJrRieIm5yKZS2NQpZrKv08KkzD88BrzjvVsHMP1zo1hDatRI5hnNM5dr10P4aNZtCE7u/u39HHYlspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG9jW3gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB43C4CEC0;
	Sat, 14 Sep 2024 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726322002;
	bh=I1goio9CgAST7ziInKKK1WisxibGk2VKmozQ1oSwq0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RG9jW3gUayXi+GnUfyuVfAPkhADFgYqbie7yq3ueyoojDIzzfoHlox9j+EzNfNjvb
	 KuRKmCM74VLqu/QeaZP/sqg27Z6qMaWJayMEe0LBaciKgjYJPnKfXEH0bIZsnQozy4
	 srbmmVXVXZlOahFtZbfPO0Ga5SjlUl4RKneBTu8rQWiqAZoGX/DYEKMENz57yc/i/p
	 1jBK/zDsmCqvSuXrgEbbSL8j4RpLfKf5nX+wsol1EQbvGaP2CJL8oz2hyEMr1djHvK
	 s/IHh85H20QYilCFTNmpsx1PcQM6BFaR/LJnyAKSlyappv+fV3jGmkEf8nL/N8GvbI
	 lzhuLJcDH5jBg==
Date: Sat, 14 Sep 2024 14:53:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: light: ltr390: Interrupts and threshold
 event support
Message-ID: <20240914145315.2d45d2bd@jic23-huawei>
In-Reply-To: <20240910045030.266946-4-abhashkumarjha123@gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
	<20240910045030.266946-4-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 10:20:28 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Added support for threshold events for both the ALS and UVI channels.
> The events are reported when the threshold interrupt is triggered. Both
> rising and falling threshold types are supported.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash,

A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/light/ltr390.c | 222 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 220 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index c4ff26d68..8a8a118ca 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -24,8 +24,11 @@

>  
> @@ -370,12 +398,186 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
>  	}
>  }
>  
> +static int ltr390_read_threshold(const struct iio_dev *indio_dev,
> +				enum iio_event_direction dir,

Alignment doesn't look quite right.  Is it off one space?
That is, e should be below c.  Hard to tell this in a diff so I
maybe wrong about it being off.


> +				int *val, int *val2)
> +{
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = ltr390_register_read(data, LTR390_THRESH_UP);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_EV_DIR_FALLING:
> +		ret = ltr390_register_read(data, LTR390_THRESH_LOW);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltr390_write_threshold(struct iio_dev *indio_dev,
> +				enum iio_event_direction dir,
> +				int val, int val2)
> +{
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_bulk_write(data->regmap,
> +					LTR390_THRESH_UP,
Wrap this bit less to get nearer 80 chars.
> +					&val, 3);
> +		return ret;
> +	case IIO_EV_DIR_FALLING:
> +		ret = regmap_bulk_write(data->regmap,
> +					LTR390_THRESH_LOW,
> +					&val, 3);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ltr390_read_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir)
> +{
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +	int ret, status;
> +
> +	ret = regmap_read(data->regmap, LTR390_INT_CFG, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	return status & LTR390_LS_INT_EN;

Slight preference for FIELD_GET() here which will make this 0 or 1
rather than 0 or 4 (I think?)


> +}
> +


> +static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +	int ret, status;
> +
> +	/* Reading the status register to clear the interrupt flag, Datasheet pg: 17*/
> +	ret = regmap_read(data->regmap, LTR390_MAIN_STATUS, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (data->mode) {
> +	case LTR390_SET_ALS_MODE:
> +		iio_push_event(indio_dev,
> +			IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +			IIO_EV_TYPE_THRESH,
Align after (

> +			IIO_EV_DIR_EITHER),
> +			iio_get_time_ns(indio_dev));
> +		break;
> +
> +	case LTR390_SET_UVS_MODE:
> +		iio_push_event(indio_dev,
> +			IIO_UNMOD_EVENT_CODE(IIO_UVINDEX, 0,

Same on alignment as this is hard to read.

> +			IIO_EV_TYPE_THRESH,
> +			IIO_EV_DIR_EITHER),
> +			iio_get_time_ns(indio_dev));
> +		break;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int ltr390_probe(struct i2c_client *client)
>  {
>  	struct ltr390_data *data;
> @@ -429,6 +631,22 @@ static int ltr390_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
>  
> +	if (client->irq) {
> +		int irq_flags = irq_get_trigger_type(client->irq);
> +
> +		if (!irq_flags)
> +			irq_flags = IRQF_TRIGGER_FALLING;
Don't override the firmware description. It should be correct for new drives
as probably no legacy out there. The only time we play this sort of
game is when we have to carry on supporting a wrong configuration that
'works' because the driver was setting more than it should in the past.

> +
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, ltr390_interrupt_handler,
> +						irq_flags | IRQF_ONESHOT,

Drop irq_flags use here.

> +						"ltr390_thresh_event", indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
> +			return ret;
> +		}
> +	}
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  


