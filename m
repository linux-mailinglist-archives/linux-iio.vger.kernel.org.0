Return-Path: <linux-iio+bounces-5195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F157B8CC9CE
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 01:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1B81F228E7
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562DC14D28B;
	Wed, 22 May 2024 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlWlpB+p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA64824B1;
	Wed, 22 May 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421290; cv=none; b=asJLt0Ufx3JCycG657EqOKO+6HACYyIwAXX30QixVwSe2H9cFAr/kBDkTO+g/f42JaCb1ZOqJLKUz53wfTt6ecLvslYWUrm3db8+sWH/Nq6wE0KHbpQgVTPqFfuRZgliZYiyHu8zqWa7MR69VSKuMlv+Q2/xnANafgp57gtkxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421290; c=relaxed/simple;
	bh=vggnmkJygBRK8GAMVq19lWbRS7b34eyKsZmnwfwYnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7JgoeifKDPUOug/CvCkgNw1McVDM3qUcdymdOV1XNtL4JS3BiFEiAUFFlcMKVzCkVm7h6b22HRx0JTwGIKDCeLDbE1jWNZ3/tjxvR1kIJNTGhheMbEZtRj89VbWyczM3+1rW7a865uk6iAY6k7GjxH0+PQDwctI6hQN0/vP2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlWlpB+p; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b2e942171cso3063939eaf.3;
        Wed, 22 May 2024 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716421287; x=1717026087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWukj2snaUQpvheqYxoT6sRpwOl1cI9Ig/I6rHkd/ts=;
        b=MlWlpB+p6RRWNi/MHnA5zBR9yjDFtIjjtCRedY+W/ZC0AF9MDYk+CFHXnJixfZUohE
         3Q8G92zyVa0HBmciHhtyjq6VjERNGVSOTqz+j6HfGrMcZzWitPV7fsrTreXgZZwwExLD
         mGaRETcGmBTIHtMdOrQ8S+OtYh2IJNFPUiLhrM/35/MnX4VNwx9HIkLxRvFK9otRKkne
         Mle+4Vi3MwIVxYb1JQ3hPXT6EmLotKlkn29vDZ6vZ9KreKvMMEe39S0IJrseiDijgIa9
         KUBwV1Gwu1gucHqLuG6r1TZ03uVeEXdkHZqoc7kYPDT24pRF3MUvyM7MiI/3CdeOtNWo
         LTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716421287; x=1717026087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWukj2snaUQpvheqYxoT6sRpwOl1cI9Ig/I6rHkd/ts=;
        b=FAyywbQUsGIr1C99E1ID5gyo/F8MutVsAiBK6huU8Ycla2HuSIVoVCOIXddIhKlzZx
         qzrAwSZu+CE8m0HwVwzSFX87MMwBJxxYGCuDP/FZJOV7TH8DOr77KPna/MJsY12qaRfp
         VJNpQp91yUnVRXEZkb4qCDldBzSr5Pi04fXffIYFnEJKvHRhU03Gh8sL6niXj0/aFAlS
         /ZGu77tYCK33ksrL2ArX4jJ98DsRQuvR9Xwh6GxOUN+pc/E3Hrsg0VxPJrcIUd+PMcvP
         q94M7i3JGownSPWA+AsKEpBqlg+T3HSg07Ddtvl5p8JmUN0xWAYHtoi8ZaMKY1LwjBCh
         zs7w==
X-Forwarded-Encrypted: i=1; AJvYcCVLHW7E8hipS3XCaI7Izx7uv7XlGWmJ/dyrSqIAMNM5Z6e0XgcQTLXJmJj4Z4tcknIpVy+5cIdU4DIFQumQs/IIfuKk5hQKMNASFP3g2ZDAyw2rhaNhmChPhZY1mE2Sk4mnGoLY5FxfKoTGJYD6BlRg6fUf9OQ1O0dbO17SQfPTBUS45Q==
X-Gm-Message-State: AOJu0Yw5hGsgnEoJj8QyJdvPCHYpcn/6XwCQrtK9EcbTMKQMdHXpAINK
	CQfRg3CpKfYk58Va9sX+iDqQ0uwRekW5MdC/Ci0I0x0SuJakJkJz
X-Google-Smtp-Source: AGHT+IE0d+EY6qLVEYas/aDbAVhly2G2iZsay05JQ07b3GGXxqmurnPP45B+PYUcYsUehPTJYrupIA==
X-Received: by 2002:a05:6358:8003:b0:186:f45:391a with SMTP id e5c5f4694b2df-1979214497fmr519300455d.28.1716421287435;
        Wed, 22 May 2024 16:41:27 -0700 (PDT)
Received: from archlinux ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a9107f3sm23359241a12.9.2024.05.22.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:41:26 -0700 (PDT)
Date: Wed, 22 May 2024 20:41:18 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lars@metafoo.de, gerald.loacker@wolfvision.net, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: chemical: add driver for ENS160 sensor
Message-ID: <i6heylzrq3kez23oq3brbbhpw4ktt6umzh2vcsawch52upv4oa@muxsuackv6er>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
 <20240512210444.30824-4-gustavograzs@gmail.com>
 <205163e0-e2bd-4ed9-9f51-e20468f77655@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <205163e0-e2bd-4ed9-9f51-e20468f77655@wanadoo.fr>

On Mon, May 13, 2024 at 09:12:55PM GMT, Christophe JAILLET wrote:
> Le 12/05/2024 à 23:04, Gustavo Silva a écrit :
> > ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> > for indoor air quality monitoring. The driver supports readings of
> > CO2 and VOC, and can be accessed via both SPI and I2C.
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> 
> Hi,
> a few comments below, for what it worth.
> 
> BTW, why I'm in copy of the mail?
> I'm not a maintainer, and not active on drivers/iio/chemical/
> Slightly proud, but curious as well.
> 
Hi Christophe,

Your name was listed by the `get_maintainer.pl` script, so I may have
added you to CC accidentally, my bad. I appreciate your review
nonetheless.

> ...
> 
> > +#define ENS160_REG_TEMP_IN		0x13
> > +#define ENS160_REG_RH_IN		0x15
> > +#define ENS160_REG_DEVICE_STATUS	0x20
> 
> If defining everything, maybe:
> #define ENS160_REG_DATA_AQI	0x21
> 
Ack.

> > +#define ENS160_REG_DATA_TVOC		0x22
> > +#define ENS160_REG_DATA_ECO2		0x24
> > +#define ENS160_REG_DATA_T		0x30
> > +#define ENS160_REG_DATA_RH		0x32
> > +#define ENS160_REG_GPR_READ4		0x4C
> 
> ...
> 
> > +static int ens160_chip_init(struct ens160_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	u8 fw_version[3];
> > +	__le16 part_id;
> > +	unsigned int status;
> > +	int ret;
> > +
> > +	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &part_id,
> > +			       sizeof(part_id));
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (le16_to_cpu(part_id) != ENS160_PART_ID)
> > +		return -ENODEV;
> > +
> > +	ret = ens160_set_mode(data, ENS160_REG_MODE_IDLE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> > +			   ENS160_REG_COMMAND_CLRGPR);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> > +			   ENS160_REG_COMMAND_GET_APPVER);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msleep(ENS160_BOOTING_TIME_MS);
> > +
> > +	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
> > +			       fw_version, sizeof(fw_version));
> > +	if (ret)
> > +		return ret;
> > +
> > +	msleep(ENS160_BOOTING_TIME_MS);
> > +
> > +	dev_info(dev, "firmware version: %u.%u.%u\n", fw_version[2],
> > +		 fw_version[1], fw_version[0]);
> > +
> > +	ret = ens160_set_mode(data, ENS160_REG_MODE_STANDARD);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read(data->regmap, ENS160_REG_DEVICE_STATUS, &status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (FIELD_GET(ENS160_STATUS_VALIDITY_FLAG, status)
> > +	    != ENS160_STATUS_NORMAL)
> > +		return -EINVAL;
> 
> Just wondering how it works with the Warm-up and initial Start-up times.
> If the probe is executed and the corresponding duration has not elpased,
> then the probe fails.
> 
> Is it what is expected?
>
According to the datasheet, the warm-up time corresponds to the first 3
minutes after power-on. However, the chip I'm working with always seems
to go straight to standard operating mode (validity flag = 0x00)
immediately after power-on.

Also, checking other drivers for the same sensor, including ScioSense's
official arduino driver, none of them seem to consider this initial
warm-up time.

Maybe it is more reasonable not to fail the probe based on this
condition but instead only log the status. If the status reads 1
(warm-up) or 2 (initial start-up) the readings may be unreliable for
some time, but the user will be warned. What do you think?

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_info ens160_info = {
> > +	.read_raw = ens160_read_raw,
> > +};
> > +
> > +int ens160_core_probe(struct device *dev, struct regmap *regmap,
> > +		      const char *name)
> > +{
> > +	struct ens160_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	dev_set_drvdata(dev, indio_dev);
> > +	data->regmap = regmap;
> > +
> > +	indio_dev->name = name;
> > +	indio_dev->info = &ens160_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = ens160_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
> > +
> > +	ret = ens160_chip_init(data);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "chip initialization failed\n");
> 
> Nitpick: return dev_err_probe()
Ack.

> 
> > +		return ret;
> > +	}
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> 
> ...
> 
> > +static int ens160_i2c_probe(struct i2c_client *client)
> > +{
> > +	struct regmap *regmap;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &ens160_regmap_i2c_conf);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> > +			PTR_ERR(regmap));
> 
> Nitpick: dev_err_probe()
Ack.

> 
> > +		return PTR_ERR(regmap);
> > +	}
> 
> ...
> 
> > +static int ens160_spi_probe(struct spi_device *spi)
> > +{
> > +	struct regmap *regmap;
> > +	const struct spi_device_id *id = spi_get_device_id(spi);
> > +
> > +	regmap = devm_regmap_init_spi(spi, &ens160_regmap_spi_conf);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
> > +			regmap);
> 
> Nitpick: dev_err_probe()
Ack.

> 
> CJ
> 
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	return ens160_core_probe(&spi->dev, regmap, id->name);
> > +}
> 
> 

