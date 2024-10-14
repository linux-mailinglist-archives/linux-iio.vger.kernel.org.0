Return-Path: <linux-iio+bounces-10585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC6E99D7ED
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D5CB2120C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA861CF5EE;
	Mon, 14 Oct 2024 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyZ5aW3c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC414A4E7;
	Mon, 14 Oct 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936613; cv=none; b=HFubmVbCwc5Z1R0BBDwrRhyu3jAyslFrE2/IoahZbiJVH8a3xHoY0KtvNC4ZI6RBWfTxHHVEOudH3Bt9nt9VuKLEZIN01GLcF9iZrAik68edJniMor1HdMNWzAYlqN59Zc/OTixaHcf2E+mhK6Y85PGW3a8YZ9pW2m9oXkEmtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936613; c=relaxed/simple;
	bh=JWwjLGsivcHbDJSVTESmyypg413KtSy8zhP8Dkd0JHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5rcdbooNDg4EBRpt1HAfk3xStoUH3r342RBDkgq3RsODGUJqJFaOWo+KW8wkAMM3o2h+9gS7SRDv14KPRerdBw1tVZY5UnT6KNl5XCpiJ5tleZH9/iECqYYOyAZHVF6M1ZB2DzunHqUEHV5DbJHrA/WIQ9cjKbOsG0yx5wp57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyZ5aW3c; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3049728f8f.0;
        Mon, 14 Oct 2024 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728936610; x=1729541410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ruqxh2OmQ8pm/G50A6yLuJGADr1mXkVH3KFfmfCICcc=;
        b=jyZ5aW3cQdo4h/PY5CZH1wcS751rSSvBrQS2ZvgexXKZzfwm/6w8ybNC4zLDtQ3t4L
         j3Hh3gYohY3HpBZTyseSEhKXIcMsP/l2xn/GhIl2ByjpVmf5VedAYzkNphT1M9/CoC4B
         XG7fX6/mJN2a+gW16S/71bObLZab2PSvMpjYyKE13Is7O8EI2GPZu7XMBg2r/9E7zFC/
         NxcukKboML8ZaY9PBuJfQYLDKJhWkmnJ26tdKl/buG0ww5a24PVJSTGrm0JHl7XYjYPZ
         wb38SIW+jmelFyU7ZS1WDKmMzGgD/MW0z0pLi2Kg3bbe8/+Q2c7UQrHu59Iqic/d0dZn
         Tnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936610; x=1729541410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruqxh2OmQ8pm/G50A6yLuJGADr1mXkVH3KFfmfCICcc=;
        b=APUb+vZRlrTs+sd0Ga1MgXQED0L4BNQhm2OJvXiy7kgrxItQkSrEGj9uiCfXmZy+8y
         ukXnjxIRVTiUSH+HLsbA1tXJ3yWEc8A5OpbRXbWMttuEQdmaZ2PtUum4cMLefKXOJ/wn
         UwN5WowFwi9qK0OYuvVfww2sPj2iZiS3lBJbhVEUnuHCLc6R0N4FUBhTR0UuLPa0qdIW
         DEovt9DyvWVkb2+gKd6fbiWi/+GlaLc7+T5FpNtFTOXNVMid1heszr+HGx5nCzTuOHcu
         xw/y9Fz5QSJRqC2EFkqs7LZRqYHJx1X6v4v/1jzf+sQT2W3XJ8ywYisMrchW6iu0ps8I
         wTGw==
X-Forwarded-Encrypted: i=1; AJvYcCUgnq+X/6P4D7hb8MopcXfRXktV35bFSGI+RGD6wiSl67u+nAvYZw4JvPVMPNpVsQIVZJ/wwMyfHzx7@vger.kernel.org, AJvYcCUk6SiEUtyoEcLVpOowGbk3kJOYLFA19fEsS+YblZPh9KpcYQp08AYeSptpUMjrnGLY87ZXP0yooNYL@vger.kernel.org, AJvYcCVTrt87nT5uOlxJ4O8Jh4S8Y47GYuuQ5eWRln8/HgySzcIgBpBv5Bp5ENFMKt8b4+0RKswUhau1yq/kOFiJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzD2yHzzw67xK/aDFzUrE8n47LXqF5moL2t+xvHzOus/UCUXp
	y74MMCRERqy+P76Nt/WXNC2jHgFVd607Dgrl4LOXTsMvlASc14vv
X-Google-Smtp-Source: AGHT+IGy18aObntGlmvrsyKW+uMezeeQS6cVzldVLAza69aC/YANkWKoeP/82OVyHuY5fRR0VU65rA==
X-Received: by 2002:adf:e608:0:b0:37d:4fe9:b6ae with SMTP id ffacd0b85a97d-37d5519881bmr7900376f8f.7.1728936609594;
        Mon, 14 Oct 2024 13:10:09 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:e435:fb96:76da:7162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfb43sm12186431f8f.56.2024.10.14.13.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:10:09 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:10:06 +0200
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v8 3/4] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <Zw16nvYqbYFD8rpY@vamoirid-laptop>
References: <20241007194945.66192-1-vassilisamir@gmail.com>
 <20241007194945.66192-4-vassilisamir@gmail.com>
 <20241012170823.3c6d3df9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012170823.3c6d3df9@jic23-huawei>

On Sat, Oct 12, 2024 at 05:08:23PM +0100, Jonathan Cameron wrote:
> On Mon,  7 Oct 2024 21:49:44 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> > a trigger for when there are data ready in the sensor for pick up.
> > 
> > This use case is used along with NORMAL_MODE in the sensor, which allows
> > the sensor to do consecutive measurements depending on the ODR rate value.
> > 
> > The trigger pin can be configured to be open-drain or push-pull and either
> > rising or falling edge.
> > 
> > No support is added yet for interrupts for FIFO, WATERMARK and out of range
> > values.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Hi Vasileios,
> 
> One questing about locking below.  What you have is probably correct
> but might be tighter than it needs to be, or need a comment to say why
> for future readers.
> 
> I hate register reads with side effects btw.  It's an 'optimization'
> hardware designers thing is nice, but makes for really ugly software
> interfaces.
> 

Hi Jonathan,

> > @@ -2429,6 +2564,88 @@ static int bmp580_chip_config(struct bmp280_data *data)
> >  	return 0;
> >  }
> >  
> > +static void bmp580_trigger_reenable(struct iio_trigger *trig)
> > +{
> > +	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
> > +	unsigned int tmp;
> > +	int ret;
> > +
> > +	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &tmp);
> As below. Seems this read has side effects (horrible!)
> I'm not sure if this is related to the locking though.

Yes indeed, this read is needed in order to clear the interrupt. In that
way the interrupt is kind of resetted so it can get triggered again. It
is actually the 1st line in page 28 of [1].

[1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp585-ds003.pdf
> > +	if (ret)
> > +		dev_err(data->dev, "Failed to reset interrupt.\n");
> > +}
> 
> > +static int bmp580_int_pin_config(struct bmp280_data *data)
> > +{
> > +	int pin_drive_cfg = FIELD_PREP(BMP580_INT_CONFIG_OPEN_DRAIN,
> > +				       data->trig_open_drain);
> > +	int pin_level_cfg = FIELD_PREP(BMP580_INT_CONFIG_LEVEL,
> > +				       data->trig_active_high);
> > +	int ret, int_pin_cfg = pin_drive_cfg | pin_level_cfg;
> 	int int_pin_cfg = pin...
> 	int ret;
> 
> Is easier to follow.
> 

ACK.

> > +
> > +	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
> > +				 BMP580_INT_CONFIG_MASK, int_pin_cfg);
> > +	if (ret) {
> > +		dev_err(data->dev, "Could not set interrupt settings.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = regmap_set_bits(data->regmap, BMP580_REG_INT_SOURCE,
> > +			      BMP580_INT_SOURCE_DRDY);
> > +	if (ret)
> > +		dev_err(data->dev, "Could not set interrupt source.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t bmp580_irq_thread_handler(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev = p;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	unsigned int int_ctrl;
> > +	int ret;
> > +
> > +	scoped_guard(mutex, &data->lock) {
> > +		ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &int_ctrl);
> What are you locking against here?  Seems this read may have side effects?
> If not the regmap internal locking should be enough for a register read.

I had a 2nd look and the lock is redundant indeed. This came from the
fact that I use the lock in the oneshot captures becasue when we do
reads of pressure or humidity (BME280) measurements, the temp regs are
read first, they are processed and later the pressure/humidity regs are
read so this operation should be kept serialized. But here there is no
problem.

Cheers,
Vasilis

> > +		if (ret)
> > +			return IRQ_NONE;
> > +	}
> 
> 

