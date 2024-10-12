Return-Path: <linux-iio+bounces-10522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E599B605
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9A2822B2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5312E38DE0;
	Sat, 12 Oct 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuB7VaMY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A81805A;
	Sat, 12 Oct 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749025; cv=none; b=ZabmHm7Tr1aIw4suJvIHVhsHl5XJggL5TwfeeMYBayRVmq/M/m6tJVw86tTmxGUDhDm0jef2Vg04wB0DSq8k8S9WUT8miyjBR2RvncMIz0L6lR0UGFlwQujhYcLAb81iPMsPRgOhRu/QZtkaGKiQXUnQH4F8y0nDez9U5uXK7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749025; c=relaxed/simple;
	bh=v2IKt7mYsCub94TNOYsOk6LmiqE6keE1I+35vzuQSBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGQRYEHAKaf7oUE51iCutAWqKUecK6VEHEe3DkPVwWrngqg8frvtbGcuJvEvk8c0sVDwsB1ShghsjRh/EJKIrJohYO4FCB77zWbdPJypAiIqOXKYZs4VuWj/Mw3PCdQSIWSZhaQmk2GTD+2TLeTgIaNtCOTfBplhJaI9hLGL3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuB7VaMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC92C4CEC6;
	Sat, 12 Oct 2024 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728749024;
	bh=v2IKt7mYsCub94TNOYsOk6LmiqE6keE1I+35vzuQSBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TuB7VaMYTxbVc1FeVj8nLN2RLhBd3sxwk3oMKL1pqYTHgDbJCmUF84vOIN5ZgIhDi
	 XDJ2gaPIENSgVDnsvIWZk/xRkQCIdgQwI0Now3o/juQm6FEdqFUVtU9yktbBaO/b6J
	 Ng9EMA4yC5SkbQ5sdg6uPeHKhmbzffyXq8G0CksBG1D+QCQdExBZXnVRJuF+PNaiaB
	 ZcVtS2l7TPWCZa368QhspKylW0QAHywJB0ySzzCsjYzomFefcw2srznc98/H1UvF1n
	 AFiS/ZOaZbMa6qbH81OzAjmb3zSh84c0SH+oGzlLE6yXrr+E8jh/MFf4HrdAUFqH5v
	 6QYBBqRWTIb9w==
Date: Sat, 12 Oct 2024 17:03:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <20241012170333.37059686@jic23-huawei>
In-Reply-To: <20241007194945.66192-2-vassilisamir@gmail.com>
References: <20241007194945.66192-1-vassilisamir@gmail.com>
	<20241007194945.66192-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 21:49:42 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add forced mode support in sensors BMP28x, BME28x, BMP3xx and BMP58x.
> Sensors BMP18x and BMP085 are old and do not support this feature so
> their operation is not affected at all.
> 
> Essentially, up to now, the rest of the sensors were used in normal mode
> all the time. This means that they are continuously doing measurements
> even though these measurements are not used. Even though the sensor does
> provide PM support, to cover all the possible use cases, the sensor needs
> to go into sleep mode and wake up whenever necessary.
> 
> The idea is that the sensor is by default in sleep mode, wakes up in
> forced mode when a oneshot capture is requested, or in normal mode
> when the buffer is enabled. The difference lays in the fact that in
> forced mode, the sensor does only one conversion and goes back to sleep
> while in normal mode, the sensor does continuous measurements with the
> frequency that was set in the ODR registers.
> 
> The bmpX_chip_config() functions which are responsible for applying
> the requested configuration to the sensor, are modified accordingly
> in order to set the sensor by default in sleep mode.
> 
> DEEP STANDBY, Low Power NORMAL and CONTINUOUS modes, supported only by
> the BMP58x version, are not added.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi Vasilieos

Given it looks like you'll be doing a v9 anyway, a few comments inline
on some minor simplifications and potential readability improvements.

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/bmp280-core.c | 296 +++++++++++++++++++++++++++--
>  drivers/iio/pressure/bmp280.h      |  21 ++
>  2 files changed, 296 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6811619c6f11..9ad29cf4c2ac 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -16,6 +16,11 @@


> @@ -1522,6 +1610,71 @@ static int bmp380_preinit(struct bmp280_data *data)
>  	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
>  }
>  
> +static const u8 bmp380_operation_mode[] = {
> +	BMP380_MODE_SLEEP, BMP380_MODE_FORCED, BMP380_MODE_NORMAL,
> +};

As below - I'd assign these to specific entries to make the fairly obvious association
even more obvious!

> +
> +static int bmp380_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case BMP280_SLEEP:
> +	case BMP280_FORCED:
> +	case BMP280_NORMAL:
> +		break;
> +	default:
> +		return -EINVAL;

Currently there aren't others. So the compiler should shout if you try to pass
something else. Hence this check shouldn't be needed.

> +	}
> +
> +	ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> +				BMP380_MODE_MASK,
> +				FIELD_PREP(BMP380_MODE_MASK,
> +					   bmp380_operation_mode[mode]));
> +	if (ret) {
> +		dev_err(data->dev, "failed to  write power control register.\n");
> +		return ret;
> +	}
> +
> +	data->op_mode = mode;
> +
> +	return 0;
> +}
>

>  	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
>  }
>  
> +static const u8 bmp580_operation_mode[] = {
> +	BMP580_MODE_SLEEP, BMP580_MODE_FORCED, BMP580_MODE_NORMAL,

For these, explicit setting will make it more obvious.
	[BMP280_SLEEP] = BMP580_MODE_SLEEP,
etc

> +};
> +
> +static int bmp580_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
> +{
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	switch (mode) {
> +	case BMP280_SLEEP:
> +	case BMP280_NORMAL:
> +		break;
> +	case BMP280_FORCED:
> +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> +				      BMP580_DSP_IIR_FORCED_FLUSH);
> +		if (ret) {
> +			dev_err(dev, "Could not flush IIR filter constants.\n");
> +			return ret;
> +		}
> +		break;
> +	default:
There are only the values above, and we should hopefully be able to rely
on compiler warnings to shout at us if a future modification adds more.

So should be able to drop the default here.

> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> +				BMP580_MODE_MASK,
> +				FIELD_PREP(BMP580_MODE_MASK,
> +					   bmp580_operation_mode[mode]));
> +	if (ret) {
> +		dev_err(dev, "failed to  write power control register.\n");
> +		return ret;
> +	}
> +
> +	data->op_mode = mode;
> +
> +	return 0;
> +}


