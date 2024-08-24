Return-Path: <linux-iio+bounces-8756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B206795DD78
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5892E1F221C3
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A79156972;
	Sat, 24 Aug 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMUz6guj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B79154434;
	Sat, 24 Aug 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498181; cv=none; b=inlgZTQIfkfGmyZq0OlGGj38OVHxUyQV8PjXoylZpKz0kNbBayBThD6gBW8r1DGcBa5DToRSVj4EBfLc6qyQjMa26Xf1MXsfZBcj4UwP+LLpwFCajeyW3YaFI7seFVV/DEBy2cTxwU8Ron/INpfgu+x/NDYXrpCz3H9eOLJdLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498181; c=relaxed/simple;
	bh=KBFRXPbXkTrq/8WmUZwd7zt1D7cBp9yVg6JBXqujTok=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVuUFArq4qwjOm4KwjdTYZUDzbE0SAyPNZAkrV6YixAJYJojN9GnsnsA22rWUUM/nc1A5dkxgDWK3ZoHN3SWj75+pBcvhH/9ftd0zQizuLrw+Xi+Dtkflg2nzlPsJqk5HrzKnSoUxt8gI6hB1edmZFkvUgt/wPHtOGL2mrKAz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMUz6guj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f502086419so6388421fa.3;
        Sat, 24 Aug 2024 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724498178; x=1725102978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hanjFtXRBi0/vMyxLJH9A6nYVJ4pu8HrLca9l4EsSws=;
        b=GMUz6gujIPOLek8mUv9BE/Xa3z09XZ4mjuqLoT6uSLZXqJwauJE7gOvb8XPK83/X6o
         LuVIHogIgBrYwzY/1Jt6KyQp1XE4/USJSQ3P+Ac/cA4AENxWXUqvZRFSeT5hTOC1YOix
         hMcsv4cg+/UhmEDHH8JftwSceipvMqtSKBvYj6y2AX2fRmt3LfcnxcUDGCDSNYn5paAv
         c/pLzZAsQFvdL7Q7pLF7Cs3MAmpLhwxg8H+tiABWT3NbIGJeTS1AE5/M8uynyHElR+Xe
         jQ7pJWFdHW6Uef7eZTaDWR7vbmt2Q5Hz3trc0KUpgtb/sZbW8jEi4bYDxVybra93g817
         sPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724498178; x=1725102978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hanjFtXRBi0/vMyxLJH9A6nYVJ4pu8HrLca9l4EsSws=;
        b=CfBjHfAUCbmUGQndRdonFi3C83fNNnAWdbfY2z6R2DgmYLwizh0U8i4Dv2iH6AyHHv
         zxeqtiPVqV3VRgbViAL1NTvQgKzws/pDkvpUw4m1CqCJAaI06cQ53DuKRSUnGsjnVGQh
         cBufc4a+d/FjLilPE4zfVdQOhQLei8x6r43bXvL2whmI9cXRDXWojytguyDcUmIFZsdG
         b45Uv9GeH/jYJ459bOroM6fNoPtDd6tfp4moDYJAYuFk9ZJ49rciu9iLgtGz7MM7YYxg
         1BbyT7r9VZIjKzbXpoULghE0C/Q3N+Sk8rV+G0mhCreutnEX6mg3kc4Tz2a2Dik760AF
         w+yA==
X-Forwarded-Encrypted: i=1; AJvYcCVbAJjTtzrKPMKP+dVdqcP1ZoFv9hSz5k1T47U2SnQSKJ4Ek7DZ2B7meK/lMEhVm6G4LpjpwIfbFLj/@vger.kernel.org, AJvYcCVxzQWq40Ch5uLS3JFKl+wv412CBWa29/g2/bZoxDRx8Old03QpWFnktWG7scHXeNQX+iYHyoJ+DGHuN+cX@vger.kernel.org, AJvYcCWZ0gWNyzkvR45OurA5fVjfhMZzJ0D0a8lNgB47csvOPQoSfT8nSOeYmw4zgy3sQDMMc4Zv8zjMwTjO@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoKNH/KiTuO+DzLruZHj8+iJ8n/kXHLHru9gM9c8Wt7+Jou+2
	Df40GqkzrglcxxLNaGW4HO0AR0Y6YhvxNJyfgBUFC1LANGLZKuuP
X-Google-Smtp-Source: AGHT+IFoXAAGPMG+N503qXTOp+wsSujdNArfEt8LV4hYhoRA3Kz9DHrub1buc39YCbO/ya86KPM6dw==
X-Received: by 2002:a2e:6e17:0:b0:2ef:2525:be90 with SMTP id 38308e7fff4ca-2f4f493f375mr33743151fa.31.1724498177238;
        Sat, 24 Aug 2024 04:16:17 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbbabsm3141735a12.3.2024.08.24.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:16:16 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 13:16:14 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <20240824111614.GB9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-3-vassilisamir@gmail.com>
 <ZsjfdRWRl4fMJP0Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsjfdRWRl4fMJP0Y@smile.fi.intel.com>

On Fri, Aug 23, 2024 at 10:13:57PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 08:17:09PM +0200, Vasileios Amoiridis wrote:
> > The BM(P/E)28x devices have an option for soft reset which is also
> > recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> > initial configuration of the device.
> 
> ...
> 
> > +static int bmp280_preinit(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to reset device.\n");
> 
> > +	usleep_range(data->start_up_time, data->start_up_time + 500);
> 
> Seems long enough to warrant the comment. Also, why not fsleep()?

Hi Andy,

The datasheet of the sensor, and the published API from Bosch [1] 
require the startup_time for this procedure, it's not something that
came up from my mind. That's why I didn't add any comment.

I was not aware of fsleep(), I think that it could be fine to use it.

Cheers,
Vasilis

[1]: https://github.com/boschsensortec/BME280_SensorAPI/blob/master/bme280.c#L677

> 
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to read status register.\n");
> > +
> > +	if (reg & BMP280_REG_STATUS_IM_UPDATE)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to copy NVM contents.\n");
> > +
> > +	return 0;
> > +}
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

