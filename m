Return-Path: <linux-iio+bounces-12613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F09D77B0
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E08161FBB
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D2713D539;
	Sun, 24 Nov 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsKkIAGR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA92500D8;
	Sun, 24 Nov 2024 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475319; cv=none; b=MN1qFfnseY21JYEVCyp2Gkdn0wBA9CDEU9HSRhT6OWNvyNcbjZCpqRhooSVjF8+3eoHzaWahVXsWX5iq/+PXYo1RNCYbHzcIzJfi5mRtdDTju3eQUUKUWDhOe2WvYf3jzgxFVasFNIAWCbtabb0YP2157XPsAkrzc6uZyto6VxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475319; c=relaxed/simple;
	bh=IpqIC9BrjS82qzwS8IJ+zOoNIOZYoa+HlKmZTsqXfUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH+VWeIsw9ajKNBDWbXBQh+xbg8wHuohHkh21sEHJGXX9QTmQdMN79jjWFxFsYyPW44HeS0l66/U843Cm8z+Owbv8i5kZHTj9+vENWrNUe5vvjjU44ms1e8r0R8KRvaiWp0MWJ4uqE/nU4tzVAtpvxFnqC1QFinvSx5ES5zdc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsKkIAGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33361C4CECC;
	Sun, 24 Nov 2024 19:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732475318;
	bh=IpqIC9BrjS82qzwS8IJ+zOoNIOZYoa+HlKmZTsqXfUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IsKkIAGRJoIJx0qAdPJR3fQlDDf+FlyeWyT99NC62qnLsuPDExAfBUVNsA4EVA+fW
	 EScaxMJTQLlOdkF7WaPUEinf8ZWt6KXferQEzZ4o6ATSs9hFQENQAjdh5QYKGkFt+n
	 MPRgRGbNr4azqW38G41Sy6qw5EMOnCgMXTXLmb4IYLC3bFZbBW7/cmkOqKHttVn9Fg
	 XlKXK9Rmc4u3WjvsLaeq7M2QPGg7vsJ78U971r/lPIh874YgFg1mq0Flsa0myZnoV4
	 0+RzRTSFMN0TMAXz9L0Vs80Ts3ANsTp3E/vc/uCJjSHJDcX83X4IXNwO9vbo/qd79c
	 19L8pWZS4fm6A==
Date: Sun, 24 Nov 2024 19:08:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 20/22] iio: accel: adxl345: use FIFO with watermark
 IRQ
Message-ID: <20241124190830.1766bb71@jic23-huawei>
In-Reply-To: <20241117182651.115056-21-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-21-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:49 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Enable the watermark feature of the adxl345 sensor. The feature uses a
> FIFO to be configured by the IIO fifo sysfs handles. The sensor
> configures the FIFO to streaming mode for measurements, or bypass for
> configuration. The sensor issues an interrupt on the configured line to
> signal several signals (data available, overrun or watermark reached).
> The setup allows for extension of further features based on the
> interrupt handler and the FIFO setup.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 39 ++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index f7b937fb16..07c336211f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -870,6 +870,45 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		if (ret)
>  			return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
>  
> +		dev_dbg(dev, "IRQ: allocating data ready trigger\n");
> +		st->trig_dready = devm_iio_trigger_alloc(dev,
> +							 "%s-dev%d-dready",
> +							 indio_dev->name,
> +							 iio_device_id(indio_dev));
> +		if (!st->trig_dready)
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "Failed to setup triggered buffer\n");
> +		dev_dbg(dev, "IRQ: allocating data ready trigger ok\n");
Drop these debug prints from code you want to go upstream. Mostly it is easy
to find out what they provide via other means and they hurt code redability.
> +
> +		st->trig_dready->ops = &adxl34x_trig_dready_ops;
> +		dev_dbg(dev, "IRQ: Setting data ready trigger ops ok\n");
> +
> +		iio_trigger_set_drvdata(st->trig_dready, indio_dev);
> +		dev_dbg(dev, "IRQ: Setting up data ready trigger as driver data ok\n");
> +
> +		ret = devm_iio_trigger_register(dev, st->trig_dready);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to register dready trigger\n");
> +		dev_dbg(dev, "Registering data ready trigger ok\n");
> +
> +		indio_dev->trig = iio_trigger_get(st->trig_dready);
you want to set it as immutable as this code doesn't currently work with other
triggers or with this removed.  This is subject to just getting rid of the trigger
in general a suggested earlier.
> +
> +		dev_dbg(dev, "Requesting threaded IRQ, indio_dev->name '%s'\n",
> +			indio_dev->name);
> +
> +		ret = devm_request_threaded_irq(dev, st->irq,
> +						iio_trigger_generic_data_rdy_poll,
It's not. It's on a watermark interrupt. That's what strongly implies treating this
as a trigger is a bad idea.
> +						NULL,
> +						IRQF_TRIGGER_RISING | IRQF_ONESHOT,

Direction should be coming from firmware so not set here.

Note there are some older drivers where we do set it in the driver, and we can't
'fix' those because there may be hardware with broken firmware relying on that.
However no new cases of this.

> +						indio_dev->name, st->trig_dready);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to request IRQ handler\n");
> +		dev_dbg(dev, "Requesting threaded IRQ handler ok\n");
> +
> +		/* Cleanup */
> +		adxl345_empty_fifo(st);
> +
>  	} else { /* Initialization to prepare for FIFO_BYPASS mode (fallback) */
>  
>  		/* The following defaults to 0x00, anyway */


