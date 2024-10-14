Return-Path: <linux-iio+bounces-10584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F799D7BF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 21:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58981B20CCB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D473E1CC8B1;
	Mon, 14 Oct 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKHOW7mr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B801487DF;
	Mon, 14 Oct 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935407; cv=none; b=sa6l3yubWPXMTc9QGM+IdRudJZEV19VZdx8YQ6pjNuVQ/+Z1nVXiIS066LJtYAL/8pfOLHhzAKmk2n9nH80k9rERT07YjBpMM0nN8SpO/fhPPd8IP71vGeoRi36pVvB4F7sBuy7/Wxr9pp6B09kDRIE0zLHrnAbtTPvIi7ODV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935407; c=relaxed/simple;
	bh=JQdVav4g/f8FSyzu2263+6QYRv4zspMrf7aDYmCgngk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxhF1I6ZPwq5oLE0+wleopzwi6CgXRSsO4Dc6ixRak3fuwgHBt9vKvfK9jKssA/qCJuFacNImsfWSFkq8b+YWg/VybUbsiNFSREmny+v2tZZJavI1tfd7X0s9JTRn7tRIajiuXCHcWmkVWOpRijyGmmULjiqj2Vkmvuc1/qHXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKHOW7mr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1487554e87.0;
        Mon, 14 Oct 2024 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728935404; x=1729540204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb7G3h2Xy7lt8voZGAC1N6xxQ4OoXhNwcK/4eUCoKvc=;
        b=SKHOW7mrHhDVo0gcM2skmO+aFXX65r6B4qwDXS0abVJOmmY8qcmT+cq7EMspihoXCK
         PfdtRIKUkeETsi/XrW70NFZdH8LVCTp1LAzD23c6y9G0rVNTy037nTG2G/32uZZ4NS4/
         kJyGy7yWMjSlLGGQV5UOC6b9fkcbkF+JAVS9Ft49NuJ7tXX+Q4xr18hPJwij4MXI53mH
         hCw6ERVQbuCKLsU6n2Vf5wfGGLtBOx1RQzftWhOxJCriyEFHTwUjs60ymX4WJLN+Pwq+
         rSxknCQpzXSJPn10rygBk20fb/v94pZkQf9o9QwklKS3X/A+SLMVlAk7Igs+libP0I06
         x0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728935404; x=1729540204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb7G3h2Xy7lt8voZGAC1N6xxQ4OoXhNwcK/4eUCoKvc=;
        b=vNdDGb3wMr5aWg5aHtA9ObN+PthWk4KlZFhkQqdxumBTxOQd/P/yUeYT09MrmdtXhY
         uZcGIUQuI+FFeERZ4W43uQootSfqukEufPfkr6b07ggmxlia6UWP7KASLewzHBTG9s1u
         s0/7O/ajM8IsZEAwz0+YRfD3Cty/Z0NNHyfXnbOrwUkzdb4plIK8VECALHJID4l6PJ84
         ckKRZrVZirgF5taQqyFhEyloZP2HTtER9uA2zlfndbuhw5J3l40FazXWBzCiIGKFp6WN
         2AELjVJrabmsBmTxvbS9QRptpGpNdbi+DnGQyEzuBXrBwaPyStGjTp9iMTWo5tVObGIM
         dDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPoEMKbxXFBPG4AU9oB/PUukDv/117ZQhY8PIieS3i4hz+9/LkxZeO96eZ0id/mE3QYBa3aQkmpfTJ@vger.kernel.org, AJvYcCWm6dy94Kj/FsxeUH6Fgor5SA1JXd1LGUqugkec4665kMRUooUEUb1NJTPWyJlFxGmbyFdQMbW/Kr/u@vger.kernel.org, AJvYcCWwm/YLUhqBE1KKbp92xZshtNv0h7LUtPiB8n2x9XuuajhIaVbIMGktEwnYlK+KeHLwJqnAUzVezDS1DdK0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2TdX9V/Zqd5LAJNAoJxBO4NbMfZN/MG6yBLPWWqknyYCUn78
	0lYnJyob2R9yj11vq29dQDwuG3J7MeONVpk4qVrDR06fpkygXP4b
X-Google-Smtp-Source: AGHT+IGLmgkthupiwQYt9dDWj+G0ZaP8nvb1BjVvBp5bD+nergMGW0L2XdA+lpNV4AcStb+xZpcbyQ==
X-Received: by 2002:a05:6512:6ca:b0:539:f995:5b00 with SMTP id 2adb3069b0e04-539f9957713mr2071923e87.7.1728935403471;
        Mon, 14 Oct 2024 12:50:03 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:e435:fb96:76da:7162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm129646255e9.12.2024.10.14.12.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:50:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:50:00 +0200
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <Zw116IDMKFZ-MKIi@vamoirid-laptop>
References: <20241007194945.66192-1-vassilisamir@gmail.com>
 <20241007194945.66192-2-vassilisamir@gmail.com>
 <20241012170333.37059686@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012170333.37059686@jic23-huawei>

On Sat, Oct 12, 2024 at 05:03:33PM +0100, Jonathan Cameron wrote:
> On Mon,  7 Oct 2024 21:49:42 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add forced mode support in sensors BMP28x, BME28x, BMP3xx and BMP58x.
> > Sensors BMP18x and BMP085 are old and do not support this feature so
> > their operation is not affected at all.
> > 
> > Essentially, up to now, the rest of the sensors were used in normal mode
> > all the time. This means that they are continuously doing measurements
> > even though these measurements are not used. Even though the sensor does
> > provide PM support, to cover all the possible use cases, the sensor needs
> > to go into sleep mode and wake up whenever necessary.
> > 
> > The idea is that the sensor is by default in sleep mode, wakes up in
> > forced mode when a oneshot capture is requested, or in normal mode
> > when the buffer is enabled. The difference lays in the fact that in
> > forced mode, the sensor does only one conversion and goes back to sleep
> > while in normal mode, the sensor does continuous measurements with the
> > frequency that was set in the ODR registers.
> > 
> > The bmpX_chip_config() functions which are responsible for applying
> > the requested configuration to the sensor, are modified accordingly
> > in order to set the sensor by default in sleep mode.
> > 
> > DEEP STANDBY, Low Power NORMAL and CONTINUOUS modes, supported only by
> > the BMP58x version, are not added.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Hi Vasilieos
> 
> Given it looks like you'll be doing a v9 anyway, a few comments inline
> on some minor simplifications and potential readability improvements.
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 296 +++++++++++++++++++++++++++--
> >  drivers/iio/pressure/bmp280.h      |  21 ++
> >  2 files changed, 296 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 6811619c6f11..9ad29cf4c2ac 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -16,6 +16,11 @@
> 
> 
> > @@ -1522,6 +1610,71 @@ static int bmp380_preinit(struct bmp280_data *data)
> >  	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
> >  }
> >  
> > +static const u8 bmp380_operation_mode[] = {
> > +	BMP380_MODE_SLEEP, BMP380_MODE_FORCED, BMP380_MODE_NORMAL,
> > +};
> 
> As below - I'd assign these to specific entries to make the fairly obvious association
> even more obvious!
> 

ACK! Makes total sense. Thanks for your time!

Cheers,
Vasilis

> > +
> > +static int bmp380_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
> > +{
> > +	int ret;
> > +
> > +	switch (mode) {
> > +	case BMP280_SLEEP:
> > +	case BMP280_FORCED:
> > +	case BMP280_NORMAL:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> 
> Currently there aren't others. So the compiler should shout if you try to pass
> something else. Hence this check shouldn't be needed.
> 
> > +	}
> > +
> > +	ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> > +				BMP380_MODE_MASK,
> > +				FIELD_PREP(BMP380_MODE_MASK,
> > +					   bmp380_operation_mode[mode]));
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to  write power control register.\n");
> > +		return ret;
> > +	}
> > +
> > +	data->op_mode = mode;
> > +
> > +	return 0;
> > +}
> >
> 
> >  	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
> >  }
> >  
> > +static const u8 bmp580_operation_mode[] = {
> > +	BMP580_MODE_SLEEP, BMP580_MODE_FORCED, BMP580_MODE_NORMAL,
> 
> For these, explicit setting will make it more obvious.
> 	[BMP280_SLEEP] = BMP580_MODE_SLEEP,
> etc
> 
> > +};
> > +
> > +static int bmp580_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
> > +{
> > +	struct device *dev = data->dev;
> > +	int ret;
> > +
> > +	switch (mode) {
> > +	case BMP280_SLEEP:
> > +	case BMP280_NORMAL:
> > +		break;
> > +	case BMP280_FORCED:
> > +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> > +				      BMP580_DSP_IIR_FORCED_FLUSH);
> > +		if (ret) {
> > +			dev_err(dev, "Could not flush IIR filter constants.\n");
> > +			return ret;
> > +		}
> > +		break;
> > +	default:
> There are only the values above, and we should hopefully be able to rely
> on compiler warnings to shout at us if a future modification adds more.
> 
> So should be able to drop the default here.
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> > +				BMP580_MODE_MASK,
> > +				FIELD_PREP(BMP580_MODE_MASK,
> > +					   bmp580_operation_mode[mode]));
> > +	if (ret) {
> > +		dev_err(dev, "failed to  write power control register.\n");
> > +		return ret;
> > +	}
> > +
> > +	data->op_mode = mode;
> > +
> > +	return 0;
> > +}
> 

