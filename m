Return-Path: <linux-iio+bounces-24498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34BBA61B7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32624A57FF
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5512A277CB6;
	Sat, 27 Sep 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSSImyfS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2122129F;
	Sat, 27 Sep 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758991898; cv=none; b=S984DDfTr9YxvYl/InG3SCzK/ZeBmDitfTJYKYwUWDPiW574ml1/L64IiwVxd4+gF3riJofHn+7uqDZJzQiJIHX9EKWxMqEUhYYlezr1p3hK5vlEoUGLfOgZYPaCCCuEzO+nly46KsAT8C4AQgGblMhdCbQokvaxKeSVvpottZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758991898; c=relaxed/simple;
	bh=PpSORxY19co1443nKkkXHQrjCPk19lCUZzg7a2SihSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYHNb2Pum6Md1ARUCuqoH8/JIO04ciuoBp43IrZUSeVXVyYB7k72FWScUYAwGXwSl+t9OwSUMc7FxpCiot2r1EdbWDiTS5+d5eR22kEReifUqUO64xeBTCJOF5LTb0WePG3jOnHyalo63FYqfKt1iTnZjd3SOMvNqYJZ3Jx1VZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSSImyfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C6C4CEE7;
	Sat, 27 Sep 2025 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758991897;
	bh=PpSORxY19co1443nKkkXHQrjCPk19lCUZzg7a2SihSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dSSImyfS/+eTt/lx+Unq00OvrTSwnNWwfb3CWN01HMjQ+iNKSewSdd3WGFzYkenAZ
	 n0A4Xmzg/jWarYJ14jtpiTxkODLRP9CHP7l0PWOOC2Tv/BSHEB/mxZc176frI8Vskf
	 P6rRcLlpDUA3/0eGkLdBM6czlwUvn9m3tHZRig560pqrUL8dW5NuSKIdS/yOWgmHLS
	 Ql6+BWvwFyHLEs3G2BzQR78Q3HWfBl6cQro1rlpUVxa1vct/WhTn//zPm9OumzW/d+
	 DBQrl5++tAFS/8cHQPxewC80b8xOrIZHa9+pcN+odYRe86gtKKRBJ8U0P/1v4xD3/t
	 glZ08l52jSoBg==
Date: Sat, 27 Sep 2025 17:51:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
 naresh.solanki@9elements.com, michal.simek@amd.com,
 grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 3/4] iio: mpl3115: add support for DRDY interrupt
Message-ID: <20250927175125.66bcc18c@jic23-huawei>
In-Reply-To: <20250926220150.22560-4-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
	<20250926220150.22560-4-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Sep 2025 00:01:49 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> MPL3115 sensor features a "data ready" interrupt which indicates the
> presence of new measurements.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
Various comments inline.  Main ones are more on the guard() usage combined
with gotos and split out he renames as a precursor patch so only the main
change occurs in this one.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/mpl3115.c | 197 ++++++++++++++++++++++++++++++---
>  1 file changed, 184 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 80af672f65c6..13c8b338a15e 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c

>  
>  #define MPL3115_DEVICE_ID 0xc4
>  
>  #define MPL3115_STATUS_PRESS_RDY BIT(2)
>  #define MPL3115_STATUS_TEMP_RDY BIT(1)
>  
> -#define MPL3115_CTRL_RESET BIT(2) /* software reset */
> -#define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
> -#define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
> -#define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
> +#define MPL3115_INT_SRC_DRDY BIT(7)
> +
> +#define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
> +
> +#define MPL3115_CTRL1_RESET BIT(2) /* software reset */
> +#define MPL3115_CTRL1_OST BIT(1) /* initiate measurement */
> +#define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */

Precursor patch should make the renames to CTRL1
That will reduce the noise in this patch.

> +#define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
> +
> +#define MPL3115_CTRL3_IPOL1 BIT(5)
> +#define MPL3115_CTRL3_IPOL2 BIT(1)
> +
> +#define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
> +
> +#define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
> +
> +#define MPL3115_INT2 BIT(2) /* flag that indicates INT2 in use */
>  
>  struct mpl3115_data {
>  	struct i2c_client *client;
> +	struct iio_trigger *drdy_trig;
>  	struct mutex lock;
>  	u8 ctrl_reg1;
>  };
>  
> +enum mpl3115_irq_type {
> +	INT2_ACTIVE_LOW  = MPL3115_INT2 | IRQF_TRIGGER_FALLING,
> +	INT2_ACTIVE_HIGH = MPL3115_INT2 | IRQF_TRIGGER_RISING,
> +	INT1_ACTIVE_LOW  = (!MPL3115_INT2) | IRQF_TRIGGER_FALLING,
> +	INT1_ACTIVE_HIGH = (!MPL3115_INT2) | IRQF_TRIGGER_RISING,
This mixing and matching of IRQF_ definitions with locally defined
additional flags is fragile because it is more than possible
a future kernel wide change will change the IRQF_ values.

So keep them separate.

> +};
> +
>  static int mpl3115_request(struct mpl3115_data *data)
>  {
>  	int ret, tries = 15;
>  
>  	/* trigger measurement */
>  	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -		data->ctrl_reg1 | MPL3115_CTRL_OST);
> +		data->ctrl_reg1 | MPL3115_CTRL1_OST);
More renames that shouldn't be in this patch.

>  	if (ret < 0)
>  		return ret;
>  
> @@ -58,7 +86,7 @@ static int mpl3115_request(struct mpl3115_data *data)
>  		if (ret < 0)
>  			return ret;
>  		/* wait for data ready, i.e. OST cleared */
> -		if (!(ret & MPL3115_CTRL_OST))
> +		if (!(ret & MPL3115_CTRL1_OST))
More renames for the precursor patch.

>  			break;
>  		msleep(20);
>  	}
> @@ -166,9 +194,11 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
>  	int ret, pos = 0;
>  
>  	scoped_guard(mutex, &data->lock) {
> -		ret = mpl3115_request(data);
> -		if (ret < 0)
> -			goto done;
> +		if (!(data->ctrl_reg1 & MPL3115_CTRL1_ACTIVE)) {
> +			ret = mpl3115_request(data);
> +			if (ret < 0)
> +				goto done;
This follows on from comment in earlier patch.

> +		}
>
> +
> +static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u8 ctrl_reg1 = data->ctrl_reg1;
> +
> +	if (state)
> +		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> +	else
> +		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> +
> +	guard(mutex)(&data->lock);
As in earlier patch, don't mix guard() or anything from cleanup.h with
code doing gotos as scope can be very weirdly defined when you do.

This is actually bug free (I think), but doesn't match the guidance notes in cleanup.h

Various options.
1. Don't use guard here
2. Factor out the stuff under the lock.  The helper function has clearly defined
   separate scope so that can contain the goto reg1_cleanup.h bit.

> +
> +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +					ctrl_reg1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
> +					state ? MPL3115_CTRL4_INT_EN_DRDY : 0);
> +	if (ret < 0)
> +		goto reg1_cleanup;
> +
> +	data->ctrl_reg1 = ctrl_reg1;
> +
> +	return 0;
> +
> +reg1_cleanup:
> +	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +				  data->ctrl_reg1);
> +	return ret;
> +}

>  
> +static int mpl3115_trigger_probe(struct mpl3115_data *data,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(&data->client->dev);
> +	int ret, irq, irq_type, irq_cfg_flags = 0;
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0) {
> +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> +		if (irq < 0)
> +			return 0;
> +
> +		irq_cfg_flags |= MPL3115_INT2;
> +	}
> +
> +	irq_type = irq_get_trigger_type(irq);
> +	if (irq_type != IRQF_TRIGGER_RISING && irq_type != IRQF_TRIGGER_FALLING)
> +		return -EINVAL;
> +
> +	irq_cfg_flags |= irq_type;
Commented on this before, but mixing flags that are local to this driver
with those that are global provides not guarantees against future changes
of the global ones to overlap with your local values.

So just track these as two separate values rather than combining them.

> +
> +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
> +					MPL3115_PT_DATA_EVENT_ALL);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (irq_cfg_flags) {
> +	case INT2_ACTIVE_HIGH:
> +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
> +						MPL3115_CTRL3_IPOL2);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case INT2_ACTIVE_LOW:
> +		break;
> +	case INT1_ACTIVE_HIGH:
> +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
> +						MPL3115_CTRL5_INT_CFG_DRDY);
> +		if (ret)
> +			return ret;
> +
> +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
> +						MPL3115_CTRL3_IPOL1);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case INT1_ACTIVE_LOW:
> +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
> +						MPL3115_CTRL5_INT_CFG_DRDY);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	data->drdy_trig = devm_iio_trigger_alloc(&data->client->dev,
> +						 "%s-dev%d",
> +						 indio_dev->name,
> +						 iio_device_id(indio_dev));
> +	if (!data->drdy_trig)
> +		return -ENOMEM;
> +
> +	data->drdy_trig->ops = &mpl3115_trigger_ops;
> +	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> +	ret = devm_iio_trigger_register(&data->client->dev, data->drdy_trig);

Whilst unlikely the race matters. It is this call that creates the infrastructure
that might allow the interrupt generation to be triggered via userspace controls.
So the handler should probably be in place firsts.  I.e. do the devm_request_threaded_irq
before this.

> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(data->drdy_trig);
> +
> +	return devm_request_threaded_irq(&data->client->dev, irq,
> +					 NULL,
> +					 mpl3115_interrupt_handler,
> +					 IRQF_ONESHOT,
> +					 "mpl3115_irq",
> +					 indio_dev);

wrap closer to 80 chars by combining some of those lines.

> +}
> +
>  static int mpl3115_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -258,15 +425,19 @@ static int mpl3115_probe(struct i2c_client *client)
>  
>  	/* software reset, I2C transfer is aborted (fails) */
>  	i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
> -		MPL3115_CTRL_RESET);
> +		MPL3115_CTRL1_RESET);
>  	msleep(50);
>  
> -	data->ctrl_reg1 = MPL3115_CTRL_OS_258MS;
> +	data->ctrl_reg1 = MPL3115_CTRL1_OS_258MS;
As elsewhere.  Do the rename as a precursor patch so that we reduce
the noise around the real changes in here and make that bit easier to review.

>  	ret = i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
>  		data->ctrl_reg1);
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = mpl3115_trigger_probe(data, indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  		mpl3115_trigger_handler, NULL);
>  	if (ret < 0)
> @@ -285,7 +456,7 @@ static int mpl3115_probe(struct i2c_client *client)
>  static int mpl3115_standby(struct mpl3115_data *data)
>  {
>  	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -		data->ctrl_reg1 & ~MPL3115_CTRL_ACTIVE);
> +		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
As above. This isn't part of the main change here so should have been in a separate
precursor patch

>  }
>  
>  static void mpl3115_remove(struct i2c_client *client)


