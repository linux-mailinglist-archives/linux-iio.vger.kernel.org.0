Return-Path: <linux-iio+bounces-5648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF68D7784
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 21:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCF4B20DE6
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDD60BBE;
	Sun,  2 Jun 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXFFAl4w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6643AA3;
	Sun,  2 Jun 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717354821; cv=none; b=q6trxD5do609iNaAiUNvbHakxIZKP2cMncL8GAW6cplc4pcHwMQcjdv64ySDpKhJ4SgG1KG2hrWWSlhCg+rpUkH3Aov9o8kxHZLQPzWLaEo9u02sDak04y4E8HoOVZuGMJ4pizWBIYVLNbHEGy3TtyD8apvhINWadui99q7YIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717354821; c=relaxed/simple;
	bh=E/4zZapoV6foefeIWNXJWyHGCBmAxKMwlGS1G1vrOP8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws6iI84/jva2K4LPziEkKJSeWjo8jGVQ7GmMohZ9e6ARYoJetkrBoNPLvqlleDBn3FdNaCK81rkVjUSsU7Bt2EjPZEvZAujuUm157l/u84qUc8G0hTCYAXcLbpfqgVuJgdHsTdEX3gyd3N3yVBia+pXhI2uQMNO388dj6pZWQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXFFAl4w; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-351da5838fcso3595442f8f.1;
        Sun, 02 Jun 2024 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717354818; x=1717959618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7fcvF9J3/LhiJwXdo96DYyouVCuAcSb7h4UIGcMjfA=;
        b=BXFFAl4we/k1LPUjdXxvUyTJH0bYEZuc8/knWSrD+N1sfgMs/TVs/5s1AMhTMHU0BL
         GdHgvl8e4CICyi8WywHtQk5kRi0L8VewoSOGcda51MmBakOB1CddRLRurOzZSPhKnWDh
         ipmi7CygKBFUbuVdu2YSL9s/rXSduuFVFeis9dAFCbNt6ZlmlH34cnFqrECzGYr7SC+R
         6tm6It5p4wTn/lEP0io6qQd20TG1IYt65dn4W9lZ+daUEQqPTCieUkvxgo0nj6iSKSW7
         YjI6pKP8vxWTz9ID3LI2/8XBuxMZhAogCs2BrZvf+U/bU4LpoQ5V/Dc9MDRjsQIg6GwB
         K2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717354818; x=1717959618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7fcvF9J3/LhiJwXdo96DYyouVCuAcSb7h4UIGcMjfA=;
        b=eViiJX82nOiIUfY/D5OQV4OJaS0T0q0m/AF1RWrnvty0iUELrho9tWTViCalrk8Dlh
         aAX1t6iv1XpgHAoj0/X+lIThtHPm6NUXkCd160YCmXmZcIlJT4g3WPK+ih7TYlMZGoRW
         QAHFtFUHJymRqNy6NOXFNW66kkVUpkiDQ+ZX6UNnvyhsvbMVDauejvoVNyBedUG97dhg
         SziOOpcO96iOR5x9holVxRn8cHOxxH2J8AbTuUND0XgLrtB2MPnI5m4pIiJtMpFFrmrT
         0AXFaPZLeMn7SV/49z6P6E6Y2dM/pmOps0XQGTIYQoY4ig+CVeX+/dhZFcXGWtLGAKH/
         7DZg==
X-Forwarded-Encrypted: i=1; AJvYcCVjWSqueMEmcGjbSxfDD7k7CRW2o0kNN/EBLvlCYNoAv9nQz85qcBA8FL+3YDML2eBN0iJwoVoqtFOrQCyrRK9DVwnutcv7z8C4k9+iy70J/WRHbk433s1Ba8Y/Qw8DBy/Pm/7OUIL5
X-Gm-Message-State: AOJu0YyxfzEtbxhQ3DrIfdZ7vHDJeoUJoWjsIP6w8HxeLf+sBHOKfptE
	HlHQ0wDog7xQVbe9AZXo9Odb+6kTgziB8vyL9E0QnGJQ6tsoqAVt
X-Google-Smtp-Source: AGHT+IGr1BVN/vU2JVA1pZH4e6nErdoihoUKV2xFUtKyymnhinmxXlsZIFJf0zlWMyXZDzc27hKwDw==
X-Received: by 2002:adf:e946:0:b0:355:45e:11b4 with SMTP id ffacd0b85a97d-35e0f30a068mr5233283f8f.44.1717354818108;
        Sun, 02 Jun 2024 12:00:18 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:add1:b1ad:7182:3e90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f57sm6828699f8f.12.2024.06.02.12.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:00:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 2 Jun 2024 21:00:15 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/17] iio: chemical: bme680: Fix sensor data read
 operation
Message-ID: <20240602190015.GA387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-5-vassilisamir@gmail.com>
 <20240602134106.2538471a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602134106.2538471a@jic23-huawei>

On Sun, Jun 02, 2024 at 01:41:06PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 20:37:52 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > A read operation is happening as follows:
> > 
> > a) Set sensor to forced mode
> > b) Sensor measures values and update data registers and sleeps again
> > c) Read data registers
> > 
> > In the current implementation the read operation happens immediately
> > after the sensor is set to forced mode so the sensor does not have
> > the time to update properly the registers. This leads to the following
> > 2 problems:
> > 
> > 1) The first ever value which is read by the register is always wrong
> > 2) Every read operation, puts the register into forced mode and reads
> > the data that were calculated in the previous conversion.
> > 
> > This behaviour was tested in 2 ways:
> > 
> > 1) The internal meas_status_0 register was read before and after every
> > read operation in order to verify that the data were ready even before
> > the register was set to forced mode and also to check that after the
> > forced mode was set the new data were not yet ready.
> > 
> > 2) Physically changing the temperature and measuring the temperature
> > 
> > This commit adds the waiting time in between the set of the forced mode
> > and the read of the data. The function is taken from the Bosch BME68x
> > Sensor API [1].
> > 
> > [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
> > Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/chemical/bme680_core.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index 5db48f6d646c..dd2cd11b6dd3 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -10,6 +10,7 @@
> >   */
> >  #include <linux/acpi.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/log2.h>
> > @@ -532,6 +533,26 @@ static u8 bme680_oversampling_to_reg(u8 val)
> >  	return ilog2(val) + 1;
> >  }
> >  
> > +/*
> > + * Taken from Bosch BME680 API:
> > + * https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
> > + */
> > +static int bme680_conversion_time_us(u8 meas, u8 dur)
> > +{
> > +	/* Oversampling + TPH meas + Gas meas + Forced mode + heater duration */
> I'd break oversampling up
> 
> 	/* (Oversampling ratio * time per reading) ...
> or something along those lines because it's related to oversampling but isn't
> of itself oversampling.
> 

Ok I see , makes sense.

> > +	return (meas * 1936) + (477 * 4) + (477 * 5) + 1000 + (dur * 1000);
> 
> Trivial but I think we can rely on precedence both for correctness and readability
> and hence don't need the brackets
> 

The reason I used the parentheses was because in my eyes it's easier to read what's
happening exactly. But I can also remove them, there is no problem.

> > +}
> > +
> > +static void bme680_wait_for_eoc(struct bme680_data *data)
> Don't call it wait as that implies something is being checked.
> 
> bme680_conversion_sleep() or something like that.
> 

This sesnor has a sleep mode, so I think calling a function like that might
make it a bit confusing, since we are not putting the sensor into sleeping
mode but rather actually wait for the eoc.

> > +{
> > +	int wait_eoc = bme680_conversion_time_us(data->oversampling_temp +
> > +						 data->oversampling_press +
> > +						 data->oversampling_press,
> > +						 data->heater_dur);
> 
> I'd pull the calculation inline in here unless you are going to use it elsewhere
> in later patches.
> 

Ok, I could merge them into one, I don't think there is a problem.

> > +
> > +	usleep_range(wait_eoc, wait_eoc + 100);
> > +}
> > +
> >  static int bme680_chip_config(struct bme680_data *data)
> >  {
> >  	struct device *dev = regmap_get_device(data->regmap);
> > @@ -622,6 +643,8 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	bme680_wait_for_eoc(data);
> > +
> >  	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
> >  			       &tmp, 3);
> >  	if (ret < 0) {
> > @@ -738,6 +761,8 @@ static int bme680_read_gas(struct bme680_data *data,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	bme680_wait_for_eoc(data);
> > +
> >  	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
> >  	if (check & BME680_GAS_MEAS_BIT) {
> >  		dev_err(dev, "gas measurement incomplete\n");
> 

