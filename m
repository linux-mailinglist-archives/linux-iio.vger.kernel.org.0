Return-Path: <linux-iio+bounces-8004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F693E7C8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990962863F6
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45408143740;
	Sun, 28 Jul 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuvU4MO0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD46EB7D;
	Sun, 28 Jul 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182822; cv=none; b=FqzdbSVTO5/+QS7sFLFH/QDrL5DnK0wpH0oQFStdM5c1iZA9uN/SP80TRuVMuTIevaRMaRWTXUcD7cebNLXnH2zPoNO4IuiPsJFVdOJ1lrwdXoetvfU82MMuFTMMfGkCfA1BkAyAFbbr0Drc6qFTy4JpqlPXshwYJ4Sxp9nldNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182822; c=relaxed/simple;
	bh=BMwezFOuUeXzj9V/f3Nbnw4+zQyy48Ewrt//fCqB2LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOgI6diS6C0BWHrqR5Mn7OSXOl0t16Q49NaHGRLuHOfmklPZq4BFopPv7BO6FsGmnrAKocHxxFoEotC51WchcLz+ryGuir4JXinZg1pHhT0oRbmHQvDM9V32Djq643wgYpuWqYYFUCz+omw5eSaAMKw0hX78R6+iSD22QZUMdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuvU4MO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552A0C32782;
	Sun, 28 Jul 2024 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182821;
	bh=BMwezFOuUeXzj9V/f3Nbnw4+zQyy48Ewrt//fCqB2LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SuvU4MO0/ctD32n6vV7YOcJm9jjqv2WhXA+rblXJofyk7rctqoPDinQqQ6I6uGs7W
	 WQdQCj4OE1EVquaC28Q6yiK8yCPcRYxi7QonoFVl/dDAR4ekw8VKTXQWB44+pxPFzJ
	 MF80zYYymscf2FxRYv1Z7EWqEhbdcm3ng8hM3lQtm+TDwi7T6O1GrXG2kp6j8G3xgj
	 DW07kzDvQENryD9tKjk6wYJ8MCwpLIkvQUeBGHZPpEzQSSk4tFk8RU0KxBPbc67zCC
	 I6oB7caa1g/4kwpRgaY/sWA6HQgL5IiwvshpaDWVNJK5tyaJTNyOgy/wRv5Y9kCaHM
	 uJ2TlQkibrlRQ==
Date: Sun, 28 Jul 2024 17:06:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240728170650.649839e7@jic23-huawei>
In-Reply-To: <20240725231039.614536-7-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
	<20240725231039.614536-7-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 01:10:38 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> a trigger for when there are data ready in the sensor for pick up.
> 
> This use case is used along with NORMAL_MODE in the sensor, which allows
> the sensor to do consecutive measurements depending on the ODR rate value.
> 
> The trigger pin can be configured to be open-drain or push-pull and either
> rising or falling edge.
> 
> No support is added yet for interrupts for FIFO, WATERMARK and out of range
> values.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi Vasileios,

A few minor things inline, including a suggestion that perhaps the trigger_probe()
functions can be combined to reduce duplication. That would use a
__bmp280_trigger_probe(struct iio_dev *, struct iio_trigger_ops *,
                       + some function pointers).

Perhaps it's not worth it - I didn't try writing the actual code!

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c   | 309 ++++++++++++++++++++++++++-
>  drivers/iio/pressure/bmp280-regmap.c |   2 +-
>  drivers/iio/pressure/bmp280.h        |  23 +-
>  3 files changed, 328 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 4a8d2ed4a9c4..4238f37b7805 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -37,12 +37,14 @@



> +static irqreturn_t bmp380_irq_thread_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	unsigned int int_ctrl;
> +	int ret;
> +
> +	scoped_guard(mutex, &data->lock) {
> +		ret = regmap_read(data->regmap, BMP380_REG_INT_STATUS, &int_ctrl);
> +		if (ret)
> +			return IRQ_NONE;
> +	}
> +
> +	if (FIELD_GET(BMP380_INT_STATUS_DRDY, int_ctrl))
> +		iio_trigger_poll_nested(data->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bmp380_trigger_probe(struct iio_dev *indio_dev)

Two of these functions are very similar.  Perhaps define a common
function that takes a function call for int config, the ops, and
interrupt handler as arguments then add device specific
calls that use that.



> +{
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	struct fwnode_handle *fwnode;
> +	int ret, irq, irq_type;
> +	struct irq_data *desc;
> +
> +	fwnode = dev_fwnode(data->dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	irq = fwnode_irq_get(fwnode, 0);
> +	if (!irq) {
> +		dev_err(data->dev, "No interrupt found\n");
> +		return -ENODEV;
> +	}
> +
> +	desc = irq_get_irq_data(irq);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	irq_type = irqd_get_trigger_type(desc);
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +		data->trig_active_high = true;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		data->trig_active_high = false;
> +		break;
> +	default:
> +		dev_err(data->dev, "Invalid interrupt type specified\n");
> +		return -EINVAL;
> +	}
> +
> +	data->trig_open_drain = fwnode_property_read_bool(fwnode,
> +							  "int-open-drain");
> +
> +	ret = bmp380_int_config(data);
> +	if (ret)
> +		return ret;
> +
> +	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> +					    indio_dev->name,
> +					    iio_device_id(indio_dev));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &bmp380_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, data);
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, NULL,
> +					bmp380_irq_thread_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret) {
> +		dev_err(data->dev, "request irq failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_trigger_register(data->dev, data->trig);
> +	if (ret) {
> +		dev_err(data->dev, "iio trigger register failed\n");
> +		return ret;
> +	}
> +
> +	indio_dev->trig = iio_trigger_get(data->trig);
> +
> +	return 0;
> +}
> +
> +

one blank line only.

>  static irqreturn_t bmp380_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -1854,6 +1998,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
>  	.wait_conv = bmp380_wait_conv,
>  	.preinit = bmp380_preinit,
>  
> +	.trigger_probe = bmp380_trigger_probe,
>  	.trigger_handler = bmp380_trigger_handler,
>  };
>  EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
> @@ -2390,6 +2535,154 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  	return 0;
>  }
>

...

> +static irqreturn_t bmp580_irq_thread_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	unsigned int int_ctrl;
> +	int ret;
> +
> +	scoped_guard(mutex, &data->lock) {

Indent wrong.

> +	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &int_ctrl);
> +	if (ret)
> +		return IRQ_NONE;
> +	}
> +
> +	if (FIELD_GET(BMP580_INT_STATUS_DRDY_MASK, int_ctrl))
> +		iio_trigger_poll_nested(data->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bmp580_trigger_probe(struct iio_dev *indio_dev)
> +{
...

> +
> +	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> +					    indio_dev->name,
> +					    iio_device_id(indio_dev));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &bmp580_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, data);
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, NULL,
> +					bmp580_irq_thread_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret) {
> +		dev_err(data->dev, "request irq failed\n");

Only in probe paths I think, so return dev_err_probe() thoughout these
trigger setup callbacks.



> +}

> diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
> index d27d68edd906..cccdf8fc6c09 100644
> --- a/drivers/iio/pressure/bmp280-regmap.c
> +++ b/drivers/iio/pressure/bmp280-regmap.c
> @@ -109,7 +109,7 @@ static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
>  	case BMP380_REG_FIFO_WATERMARK_LSB:
>  	case BMP380_REG_FIFO_WATERMARK_MSB:
>  	case BMP380_REG_POWER_CONTROL:
> -	case BMP380_REG_INT_CONTROL:
> +	case BMP380_REG_INT_CTRL:

Unrelated change.  I'm also not sure it's worth making.

>  	case BMP380_REG_IF_CONFIG:
>  	case BMP380_REG_ODR:
>  	case BMP380_REG_OSR:
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index f5d192509d61..754eda367941 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -55,8 +55,17 @@
>  #define BMP580_CMD_NVM_WRITE_SEQ_1	0xA0
>  #define BMP580_CMD_SOFT_RESET		0xB6
>  
> +#define BMP580_INT_STATUS_DRDY_MASK	BIT(0)
>  #define BMP580_INT_STATUS_POR_MASK	BIT(4)
>  
> +#define BMP580_INT_SOURCE_DRDY		BIT(0)
> +
> +#define BMP580_INT_CONFIG_MASK		GENMASK(3, 0)
> +#define BMP580_INT_CONFIG_LATCH		BIT(0)
> +#define BMP580_INT_CONFIG_LEVEL		BIT(1)
> +#define BMP580_INT_CONFIG_OPEN_DRAIN	BIT(2)
> +#define BMP580_INT_CONFIG_INT_EN	BIT(3)
> +
>  #define BMP580_STATUS_CORE_RDY_MASK	BIT(0)
>  #define BMP580_STATUS_NVM_RDY_MASK	BIT(1)
>  #define BMP580_STATUS_NVM_ERR_MASK	BIT(2)
> @@ -117,7 +126,7 @@
>  #define BMP380_REG_OSR			0x1C
>  #define BMP380_REG_POWER_CONTROL	0x1B
>  #define BMP380_REG_IF_CONFIG		0x1A
> -#define BMP380_REG_INT_CONTROL		0x19
> +#define BMP380_REG_INT_CTRL		0x19
As above.

Jonathan


