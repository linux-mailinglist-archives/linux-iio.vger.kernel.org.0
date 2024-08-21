Return-Path: <linux-iio+bounces-8661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0195A6B0
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0C8B22975
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044F17994F;
	Wed, 21 Aug 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhYEc+1Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6B178CEA;
	Wed, 21 Aug 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275958; cv=none; b=Yef0HnoQ0hfUoz+pe2X4Hacn+osXWKnKwfGs7zL1ZbbPLseX+FbEB7L03EXlc/0keh7DMpLLGHDBKQ2+xEd9kNvsDZA27cTma22Hqk/s/7m2oL9QhSWRIwnAuBYqOAXYJLcutgRrUYRmD+/4b+7ZUFV0wbfQUwwc9DGGUUMAgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275958; c=relaxed/simple;
	bh=eQsXqUqvv/AS9vwZ0wx6LmssWGxBpB0S6sLmMTGijeQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2AADcGHV/n2xAP1q3OT4U8H9xOPie4lIhyeJ5iwMjzlBwWTV6kA7I9KvHymtoOUt4L4oEmwKEWOw1F5ubIUCrlwOIIXLGlvnxRkp1Gn9k+7/56A7/4uy9vVjbXX1bSUE/uCQenA9g0b+ojiPZZft1LJ6eAmMR756R6AuYxc38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhYEc+1Y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso193731a12.0;
        Wed, 21 Aug 2024 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275955; x=1724880755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XF8MsCEZsep1OInRuAdGSnWQxPI5SfGO64Kx5cKxYFA=;
        b=RhYEc+1YSzAYAX9LOG5BfPxsqZfOCNWKGTaGxTSF5bs4HtOsoY5Q+Q6kTiXFPGoEjr
         aQ2O1ZGZ5uDXboObdSm+8fk9iS382DRbPpFEDwBWVVT2TK6wcdFluRAwvq1+WMXWzBCF
         eo+PnpBuOdsJTXGG4aA8DrnXRoH1uAzJEXgOtsSJ6HPQWmB8AVYKCqa5xB4c5zC1XvoX
         PoykdJ6teyoCemxuAJqCeDBxCmQQFLWVR2wdJMIP8lXMKjEK1QJxhNLtaCAYiWg77pea
         hjCZJWn0qp0d7R+JdB7pKTwGh0TMzZTlWPcgGtswFr81C/MJQvcnbDZaNcV/loh4y34f
         M/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275955; x=1724880755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF8MsCEZsep1OInRuAdGSnWQxPI5SfGO64Kx5cKxYFA=;
        b=LraKs/y3f434bWygcnn1qp4g4/LjlpStKQzIJL665aGrVgnH8SBsT+EgCwU61tvzsV
         7Y7EHC1tjf4WKK+FSGK70IXXieiukAffqUyLJNtrIbpa/BZ+OPz9wLhqzE94NvkpNhTO
         890tufWzJr7PSuLW7PBh+t6lysnckCA227lKmiBR3YnfiWkgFyCJZitinmICFmx8k0LR
         3irVaZOylapBaKhXGglPeLBSqvEbpwCIWiY2Mz6m8nbBdWn0Is9+gfwOO8lNbICn9mLX
         uiDYg3+9K5VS+bn/XvbxP81QcwAUzRcoP4I3N4gd0fbRsdc5MtkulpMOjlxMLICxH0I9
         sScg==
X-Forwarded-Encrypted: i=1; AJvYcCUA8fTwxoR+QUDFkbd81QDfVoleKX2cZi6C+UGHhpgR4F1rMM7iJfjh9GOCVG8W70oEc0FcpENfr5YBOoOD@vger.kernel.org, AJvYcCXa78Si866Q49qj49cYDcavscu+ezE2E0MGiqlMw3zJQp4ok6Tt2o9h61WNmve/tZ6UGUDrloGp5lyj@vger.kernel.org, AJvYcCXsXihabhnPrcYP0yX1W92XIXr+UmghTAji3/kgw5Sz7iIhKXJLOrFnM9vdmLov287iF9CLuSTIS631@vger.kernel.org
X-Gm-Message-State: AOJu0YwPwwevxzzGMs4t9EuIP9Wh4oTVRgb3bvF2UjOlIFRaATnIgozY
	O/6XWw7RzXU9K01ccWjdYchWTR1CMg0gStxUF5Ck4h4D0b55zm9J
X-Google-Smtp-Source: AGHT+IFQi1OMPl9AjNGyhXxGrFQpzHMY35H1Mc8XeSczOSR1KfuK4UqqEBc4AZoEi5V0sbGP4F4/gw==
X-Received: by 2002:a05:6402:518d:b0:5bb:9ae0:4a49 with SMTP id 4fb4d7f45d1cf-5bf1f275c15mr3248024a12.30.1724275953935;
        Wed, 21 Aug 2024 14:32:33 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:1594:887e:30dd:c59e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c9064sm56295a12.73.2024.08.21.14.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:32:32 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 21 Aug 2024 23:32:30 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <20240821213230.GB473841@vamoiridPC>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
 <20240725231039.614536-3-vassilisamir@gmail.com>
 <20240728164901.1f325aa2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728164901.1f325aa2@jic23-huawei>

On Sun, Jul 28, 2024 at 04:49:01PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Jul 2024 01:10:34 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The BM(P/E)28x devices have an option for soft reset which is also
> > recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> > initial configuration of the device.
> > 
> > Link: https://github.com/boschsensortec/BME280_SensorAPI/blob/bme280_v3.5.1/bme280.c#L429
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Trivial passing comment seeing as you are going do be doing a v3 anyway.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 28 ++++++++++++++++++++++++++++
> >  drivers/iio/pressure/bmp280.h      |  3 +++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index d5e5eb22667a..acbc33aacc09 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -963,6 +963,32 @@ static const unsigned long bme280_avail_scan_masks[] = {
> >  	0
> >  };
> >  
> > +static int bmp280_preinit(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> > +	if (ret) {
> > +		dev_err(data->dev, "Failed to reset device.\n");
> > +		return ret;
> Is this only ever called from probe?
> 
> If so, return dev_err_probe() which will save a few lines of code.
> 

Hi Jonathan,

Indeed, this is being called only from probe so I could change that as you
proposed!

Cheers,
Vasilis

> > +	}
> > +
> > +	usleep_range(data->start_up_time, data->start_up_time + 500);
> > +
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "Failed to read status register.\n");
> > +		return ret;
> > +	}
> > +	if (reg & BMP280_REG_STATUS_IM_UPDATE) {
> > +		dev_err(data->dev, "Failed to copy NVM contents.\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int bmp280_chip_config(struct bmp280_data *data)
> >  {
> >  	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> > @@ -1079,6 +1105,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
> >  	.read_temp = bmp280_read_temp,
> >  	.read_press = bmp280_read_press,
> >  	.read_calib = bmp280_read_calib,
> > +	.preinit = bmp280_preinit,
> >  
> >  	.trigger_handler = bmp280_trigger_handler,
> >  };
> > @@ -1196,6 +1223,7 @@ const struct bmp280_chip_info bme280_chip_info = {
> >  	.read_press = bmp280_read_press,
> >  	.read_humid = bme280_read_humid,
> >  	.read_calib = bme280_read_calib,
> > +	.preinit = bmp280_preinit,
> >  
> >  	.trigger_handler = bme280_trigger_handler,
> >  };
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index 9bea0b84d2f4..a9f220c1f77a 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -205,6 +205,9 @@
> >  #define BMP280_REG_CONFIG		0xF5
> >  #define BMP280_REG_CTRL_MEAS		0xF4
> >  #define BMP280_REG_STATUS		0xF3
> > +#define BMP280_REG_STATUS_IM_UPDATE	BIT(0)
> > +#define BMP280_REG_RESET		0xE0
> > +#define BMP280_RST_SOFT_CMD		0xB6
> >  
> >  #define BMP280_REG_COMP_TEMP_START	0x88
> >  #define BMP280_COMP_TEMP_REG_COUNT	6
> 

