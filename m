Return-Path: <linux-iio+bounces-8836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E99621BF
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295C2286FC7
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B6C15B561;
	Wed, 28 Aug 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv5gcnZX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0615B0EC;
	Wed, 28 Aug 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831352; cv=none; b=q5cdcN+V90t1YdtwsgNifsFyJ511g+EjdAR9SnnvrzrXEmVsi92rFMgzRJqOLajXXGlf+e9nClyvcTRAkJyH8DwxMcOkoPBO44Sz8/iuDHyjw8MOCDpHStkZYYClPDsp/p5CM8u7GmwC1/IEivVoHg5AbdjBXD5kXdDYPErZ/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831352; c=relaxed/simple;
	bh=j98JU6msUA9RiXyy+HLEVipZYjwEgjFBaDFTabRQW0M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQRTihrLJ6Rr4ITWlN2xDXncRr/tlT7xUWG4a9TIrVf1qmih87lAnUv22HS+2rKcBhnZUScxoj0ed6LHVBtwfsJYa8EkobHI7Zl/mQQkV9hNQcvpn7ozsy6F8Rle7S4zzle0ZCPvUwPmmzEHpzvU7pDBXkXkCzeF5bXhvyfcbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv5gcnZX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86a37208b2so591285866b.0;
        Wed, 28 Aug 2024 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724831349; x=1725436149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kyk+TyrQH1DKA5w0zkkLevHO981a94JN35a6IcZF/5Y=;
        b=Gv5gcnZXjebwpKyLNR73Fu4D3BjOHbmnEHBmfj1wSGsC6OtWV2sDKsXAIeDrA0X0H6
         o3B/lA9h8ARWp3kNM/5JlfhyiUzJEbCEvlUWB0AE+2Ca3RPA9JGiJfNT+6SpxOx4KpN8
         XA+8Nvl/QAv+rlUTjgoQjBIUEO6pjJtIl+vfnnmx4GxoKsFnbaXt5R457lW/IG3n2zDZ
         ecunnSuk6rZx8siIHL/Bx9xdluFAR9uQTSYG0H6uLYDl/qu5d8vh+U1VKf/ViX8uZc0S
         F+Xw/rbD/3Q9dlUoLy0QS1PD7TlsreB0RzeBUAo5cSiU4FFLTIPhTzBSIGikTPLokK9H
         mvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831349; x=1725436149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyk+TyrQH1DKA5w0zkkLevHO981a94JN35a6IcZF/5Y=;
        b=M+60aOOevqLMVQ+SOTrLcLdKl0hKlKsMem9N8j+y7j+NzGFbESkjmU6XKsYH3MSPrm
         fGNKZjlBle/r00veM423fySOHN70mx8/aZh/9hIskA4PruuuZrblEo9D2rU75Hzx84EJ
         s/+Xl8f2xQ1E2is8WjdvGLkzh+j9zGejQgBhEdksq+qUMbVwh22/Dd2Ypr/+j7iZFwLp
         tnRvZfGfrcJjCNudXZ/gvhoFZelsUAe9DL3h/uoP/5qLpVaVMUIR+UL8sujG5jpCDz85
         9AeiQQq14tKTMGhcYw2DegT0N0nSXRc4bhpS99B3ZnctALPFlTEnQP+l3SSpn/9BFlDj
         y5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ojtBugpkXew7IO/xVD/XVg2RZtFDLF7UoLcID9VHwweTWAKkY2ZKjr96jz6B/aD/Rd5wjfKOzbDW@vger.kernel.org, AJvYcCUOQTBk3XHxe74xhOxDWD4RkDg9EdWQkr0ERaVXH5CZh9O9fIiLpZeiUG8GWKVGrABv0WyaiegB3VJGrcXD@vger.kernel.org, AJvYcCX8PAtS6p75Acp3jW2cGPMQ62xHZXZfTgRku8XrClpHijNC7x2Jw9u6hvYWXCqtRu8NGhZ3pN1kYVXq@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbhQR7tQsUPKqBCR67ClU0MXjaPM7DlbF91dZFqJbcy3j/Yl0
	jQKQdNgBQSohuwfH9rklJk3CS4ep1iRz3i1VtUsGpDCuSGXU11/o
X-Google-Smtp-Source: AGHT+IEOsF+zuGVCsYi/lsU6w2stf2bHD6c2D71wpigWLrjiJac4VZ5CtpTo7Ha3dlzRP271Kro77g==
X-Received: by 2002:a17:907:f199:b0:a7d:3de1:4abd with SMTP id a640c23a62f3a-a86a52de6a1mr1105344766b.39.1724831348139;
        Wed, 28 Aug 2024 00:49:08 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cd80sm206576266b.71.2024.08.28.00.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:49:07 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 28 Aug 2024 09:49:05 +0200
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: vassilisamir@gmail.com, 579lpy@gmail.com, ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	biju.das.jz@bp.renesas.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	jic23@kernel.org, krzk+dt@kernel.org, lars@metafoo.de,
	linus.walleij@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	semen.protsenko@linaro.org
Subject: Re: [PATCH v3 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <20240828074905.GA4934@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-3-vassilisamir@gmail.com>
 <b898ad42-1559-4f43-8994-d9692e54f930@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b898ad42-1559-4f43-8994-d9692e54f930@wanadoo.fr>

On Sun, Aug 25, 2024 at 09:04:16AM +0200, Christophe JAILLET wrote:
> Le 23/08/2024 à 20:17, Vasileios Amoiridis a écrit :
> > The BM(P/E)28x devices have an option for soft reset which is also
> > recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> > initial configuration of the device.
> > 
> > Link: https://github.com/boschsensortec/BME280_SensorAPI/blob/bme280_v3.5.1/bme280.c#L429
> > Signed-off-by: Vasileios Amoiridis <vassilisamir-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >   drivers/iio/pressure/bmp280-core.c | 26 ++++++++++++++++++++++++++
> >   drivers/iio/pressure/bmp280.h      |  3 +++
> >   2 files changed, 29 insertions(+)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index c23515048081..e01c9369bd67 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -965,6 +965,30 @@ static const unsigned long bme280_avail_scan_masks[] = {
> >   	0
> >   };
> > +static int bmp280_preinit(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to reset device.\n");
> > +
> > +	usleep_range(data->start_up_time, data->start_up_time + 500);
> > +
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to read status register.\n");
> > +
> > +	if (reg & BMP280_REG_STATUS_IM_UPDATE)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to copy NVM contents.\n");
> 
> ret is 0 at this point.
> Should a -E<something> be used instead?
> 
> CJ
> 

Hi Cristophe,

Yes, actually this could be an I/O error since we were not able to
copy the values back from the NVM device to the sensor.

Cheers,
Vasilis

> > +
> > +	return 0;
> > +}
> > +
> >   static int bmp280_chip_config(struct bmp280_data *data)
> >   {
> >   	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> > @@ -1082,6 +1106,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
> >   	.read_temp = bmp280_read_temp,
> >   	.read_press = bmp280_read_press,
> >   	.read_calib = bmp280_read_calib,
> > +	.preinit = bmp280_preinit,
> >   	.trigger_handler = bmp280_trigger_handler,
> >   };
> > @@ -1202,6 +1227,7 @@ const struct bmp280_chip_info bme280_chip_info = {
> >   	.read_press = bmp280_read_press,
> >   	.read_humid = bme280_read_humid,
> >   	.read_calib = bme280_read_calib,
> > +	.preinit = bmp280_preinit,
> >   	.trigger_handler = bme280_trigger_handler,
> >   };
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index 4e675401d61b..73516878d020 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -205,6 +205,9 @@
> >   #define BMP280_REG_CONFIG		0xF5
> >   #define BMP280_REG_CTRL_MEAS		0xF4
> >   #define BMP280_REG_STATUS		0xF3
> > +#define BMP280_REG_STATUS_IM_UPDATE	BIT(0)
> > +#define BMP280_REG_RESET		0xE0
> > +#define BMP280_RST_SOFT_CMD		0xB6
> >   #define BMP280_REG_COMP_TEMP_START	0x88
> >   #define BMP280_COMP_TEMP_REG_COUNT	6
> 

