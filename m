Return-Path: <linux-iio+bounces-7730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB479938106
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615EC2812DE
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A2E86AE3;
	Sat, 20 Jul 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsFkeznT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620C82D89;
	Sat, 20 Jul 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721475458; cv=none; b=rfikNM1IKw5xCx64aJeJFKxaAvg+0MmO4JQ8fVAK9GxOpYOap3AxrU0pRNfcnhqloQc5Pb58sQqhyIZOgbgR7WfSgtcQDHJ90vcFpMuBbJFjUoUiU6qQkItokI2+ycMQPs81dgKmMpaZXU/JgS+xWJtWGRRYjbCKwakCwKhPJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721475458; c=relaxed/simple;
	bh=0tC5v58C4pUQOeduwxqmWIjSHqqmAsJVFVb5d1LTaOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBFZ28ebr31UkTMrkjwIZ4dYMHLiHYsGbvCYV9zw3UXnWvSaH/YDKp2XOR/hn2xc3Twi2WZTxNNSDIc47KJ5yEG2kjynkOA6lSs6Hdp6avLLS2aIuGBMChH6XR8Ygq9QYqdBu4juJ07ydyN1l3EU3m4drU66TxMNt8kurRmi3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsFkeznT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC96C2BD10;
	Sat, 20 Jul 2024 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721475457;
	bh=0tC5v58C4pUQOeduwxqmWIjSHqqmAsJVFVb5d1LTaOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AsFkeznT9yPN/juIlb1shY+q3LREk8EiZwqYTe/ldTcB40LHjz9eDDGOLAQ6G+9Zd
	 4FElSVPGeiP7RkM3HiiEQjvXHdxBXhQfxUWm3OV6U8ldiYvPrYfDiAI2Vg2T4C7b05
	 8Gf1aqDmOBh6xzZDOa7ENsXgiaDEX/kR2h2Hs4kn0PAKm7U34WhGew5LD3c3EbJ/6n
	 1fT+OTlK7BzIZmkZb7pUM5L8YOfy/jJm0OlddVNQ+vicRJu6D903NLSdjP2f2ro79h
	 nvK+fFUm8C4FwQL73hwxgroasp9KbAAk71TT4yzDqrSEZvWXz1YNdJn/K765K+fl3O
	 GeuzpiTJpe3DQ==
Date: Sat, 20 Jul 2024 12:37:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/10] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240720123727.7598111b@jic23-huawei>
In-Reply-To: <20240711211558.106327-10-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-10-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 23:15:57 +0200
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

A few minor things inline.

It might be worth thinking a bit about future fifo support as that can
get a little messy in a driver that already supports a dataready trigger.
We end up with no trigger being set meaning use the fifo.  Sometimes
it makes more sense to not support triggers at all.

What you have here is fine though as we have a bunch of drivers
that grew dataready trigger support before adding fifos later
particularly as often it's a 'new chip' that brings the fifo
support but maintains backwards compatibility if you don't use it.

> +
> +static int bmp380_trigger_probe(struct iio_dev *indio_dev)
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
> +	irq = fwnode_irq_get_byname(fwnode, "DRDY");
> +	if (!irq) {
> +		dev_err(data->dev, "No DRDY interrupt found\n");
> +		return -ENODEV;
As below. return dev_err_probe() for anything that is only
called from probe()

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
> +	ret = devm_request_irq(data->dev, irq,
> +			       &iio_trigger_generic_data_rdy_poll,
> +			       IRQF_ONESHOT, indio_dev->name, data->trig);
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
One blank line only.

>  static irqreturn_t bmp380_trigger_handler(int irq, void *p)


> +
> +static int bmp580_trigger_probe(struct iio_dev *indio_dev)
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
> +	irq = fwnode_irq_get_byname(fwnode, "DRDY");
> +	if (!irq) {
> +		dev_err(data->dev, "No DRDY interrupt found\n");

As this only gets called from probe(), use return dev_err_probe() throughout.

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
> +	ret = bmp580_int_config(data);
> +	if (ret)
> +		return ret;
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
> +	ret = devm_request_irq(data->dev, irq,
> +			       &iio_trigger_generic_data_rdy_poll,
> +			       IRQF_ONESHOT, indio_dev->name, data->trig);
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
>
>  


