Return-Path: <linux-iio+bounces-8660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEB95A689
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8B1B24CE3
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CFE175D42;
	Wed, 21 Aug 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu4xnQib"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B715B116;
	Wed, 21 Aug 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275463; cv=none; b=DxY8vkt5KPDf8gLhlvlzBkI0Fre+SCUlBHok5UwBVaNnfLTzm2/dlK/T6C+1Qp/4KN+08AW7417WEYK+wzZpw4JcCbOpzS81qkAV4m4O21oiClhAbZb6USo2e/cTcxBsIHiowifhcmU42pOip6Q3e4OiTvWzlLR1wqlJE1nyD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275463; c=relaxed/simple;
	bh=U+eAa+8CVBmDvqe7l0B4VXGd7cMBJCocehRhD16kk8o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMRDzmNtysVkhjZCjr2KJOvqZspdwF/uMfB/3hduVMjTEs5nyG5SuSWJObn8QPONeUe6vhldlACTkSIAkGEcbqro16w5JFSuas5d6PQ9yZc7prxQk37ChtXErG39K4d3RdO7UB+CN3XsDYl/YdVqx1/+a4RMlTBvuzdN+UQW0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu4xnQib; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso997625e9.2;
        Wed, 21 Aug 2024 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275460; x=1724880260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X46DGmrnd/zTDd1iaWkAHCBxYZlDcmDEG4Mch03itX4=;
        b=bu4xnQibmpZDjuKtq5D4uK7CAzDj3i+bI32tcQy661kfBywFTuphbQiLNcql6rsXJ9
         EFDepiRLRqOYo6315vVXeeZ0NSP/r01Ff1Id71D/xYcJ98K+iwsDkG8pI8AHP4PfiKVb
         Qd6fuAgszHHjXxhwcKJzNrrqpQBSirohSORnb+eMzh8+XLeVFS/LBnmqUJzIygs6d+o4
         tmOtP3NZh+9gbSsM31T84WnhtznqtS7R0G902Ng/hZ66oK66IPRx9SBD4jNwLFgpM1D2
         gMkrfwmnJFGprIEzhm7+foMtQtU5l7DsILcSsuj2jGUX9cQ/9GZkpREmoTpnAdxzzNw3
         lU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275460; x=1724880260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X46DGmrnd/zTDd1iaWkAHCBxYZlDcmDEG4Mch03itX4=;
        b=O+zpPQcxYnyJMwKbEUjoXVeYyO3KDBcf8JIaaGLzGE5itCejkfRpvjIib1Nspb4/jG
         IUAm/GtbIqidYGUhANgNBpptE/f998bAfmOJzCbXRwWYoKfycoImBi1kflPlxV9QvC0Y
         wAhFucE0ULlnenSUcwlhbMnzFvbDQ50i3ZtVH86bqR0uM+CXXGd2UtCuTTHWDazsDSTv
         QWvWOl0YqEpgc0EV3DkIJTGTrrY1K9PPNgBLBeMXJGkyXlMLDV6M/vaSJVGTm6cV31xe
         ZGT/OGvuTAqLvwDGS5DQbX8K4t1KcieKeT8usU4NbvYKdOdeN4bhbcCnXUm1GRId7IoR
         KeXA==
X-Forwarded-Encrypted: i=1; AJvYcCVrS+Y3VJJr7dUf0vofEGFf8l1XQL+kGmlf+sbKldIC2B9m/D+xQyLTsRTxuz+1Sszkl467Ro63opv4dmKU@vger.kernel.org, AJvYcCWlREoY81czWUGJygBcS6AYZ5rzTgL+/HaD4TpuMXl1LZyflhc7hHR5Mx/VCoINTc0jJzTXt1rKDfSp@vger.kernel.org, AJvYcCXOJt2+Pa7InrnRJTDfIo41pPMOKEvkYZllhrPflKHcEb9hnmBUHTfdUBDGHAfdQoS94BiPLqquAPQo@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0F3Il+W+CiV1hHL0kZl0X7mdR2/O0bqJYtufnJy+wbCoTI4p
	pO4hxsPE4eAq9RJ+sTch0jtMKK27nORZEb/0Jht61kisYIo0bBVT
X-Google-Smtp-Source: AGHT+IGRNpxYanZmZIRg+3BerEwzugOhGzxhBCkjB1yveRLvTc2w/r8G/DccrMH8ynKpV57Aridqkg==
X-Received: by 2002:a05:600c:4506:b0:426:63f1:9a1b with SMTP id 5b1f17b1804b1-42abd255d5emr28877505e9.33.1724275459164;
        Wed, 21 Aug 2024 14:24:19 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:1594:887e:30dd:c59e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e1dbsm2327945e9.3.2024.08.21.14.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:24:18 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 21 Aug 2024 23:24:16 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: pressure: bmp280: Use bulk read for humidity
 calibration data
Message-ID: <20240821212416.GA473841@vamoiridPC>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
 <20240725231039.614536-2-vassilisamir@gmail.com>
 <20240728164621.16615ce6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728164621.16615ce6@jic23-huawei>

On Sun, Jul 28, 2024 at 04:46:21PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Jul 2024 01:10:33 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Convert individual reads to a bulk read for the humidity calibration data.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> One comment inline.  Short version is move that complicated field start enum
> next to the code so we don't need to say so much for it to make sense.
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 62 ++++++++++--------------------
> >  drivers/iio/pressure/bmp280.h      |  6 +++
> >  2 files changed, 27 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 3deaa57bb3f5..d5e5eb22667a 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -118,6 +118,12 @@ enum bmp580_odr {
> >   */
> >  enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
> >  
> > +/*
> > + * These enums are used for indexing into the array of humidity parameters
> > + * for BME280.
> 
> I was thinking of a comment that also mentioned the overlap. Perhaps something like
> ...
> 
> 
> Index of the byte containing the start of each humidity parameter. Some
> parameters stretch across multiple bytes including into the start of the byte
> where another humidity parameter begins. Unaligned be/le accesses are used
> to allow fields to be extracted with FIELD_GET(). 
> 
> Or, just refer to the field layout being complex and to see
> bme280_read_calib function.
> 
> Actually come to think of it, just move this enum down there so it
> is local to the code and the usage is more obvious / comment less important.
> 

Hi Jonathan,

Thanks for the feedback once again. Sorry for the late reply, I was taking
some time off for vacation :)

Indeed your comment makes sense, I can do that.

Cheers,
Vasilis
> > + */
> > +enum { H2 = 0, H3 = 2, H4 = 3, H5 = 4, H6 = 6 };
> > +
> >  enum {
> >  	/* Temperature calib indexes */
> >  	BMP380_T1 = 0,
> > @@ -344,6 +350,7 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	struct device *dev = data->dev;
> > +	s16 h4_upper, h4_lower;
> >  	unsigned int tmp;
> >  	int ret;
> >  
> > @@ -352,14 +359,6 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  	if (ret)
> >  		return ret;
> >  
> > -	/*
> > -	 * Read humidity calibration values.
> > -	 * Due to some odd register addressing we cannot just
> > -	 * do a big bulk read. Instead, we have to read each Hx
> > -	 * value separately and sometimes do some bit shifting...
> > -	 * Humidity data is only available on BME280.
> > -	 */
> > -
> >  	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
> >  	if (ret) {
> >  		dev_err(dev, "failed to read H1 comp value\n");
> > @@ -368,43 +367,24 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  	calib->H1 = tmp;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
> > -			       &data->le16, sizeof(data->le16));
> > -	if (ret) {
> > -		dev_err(dev, "failed to read H2 comp value\n");
> > -		return ret;
> > -	}
> > -	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
> > -
> > -	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
> > -	if (ret) {
> > -		dev_err(dev, "failed to read H3 comp value\n");
> > -		return ret;
> > -	}
> > -	calib->H3 = tmp;
> > -
> > -	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
> > -			       &data->be16, sizeof(data->be16));
> > +			       data->bme280_humid_cal_buf,
> > +			       sizeof(data->bme280_humid_cal_buf));
> >  	if (ret) {
> > -		dev_err(dev, "failed to read H4 comp value\n");
> > +		dev_err(dev, "failed to read humidity calibration values\n");
> >  		return ret;
> >  	}
> > -	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
> > -				  (be16_to_cpu(data->be16) & 0xf), 11);
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
> > -			       &data->le16, sizeof(data->le16));
> > -	if (ret) {
> > -		dev_err(dev, "failed to read H5 comp value\n");
> > -		return ret;
> > -	}
> > -	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
> > -
> > -	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
> > -	if (ret) {
> > -		dev_err(dev, "failed to read H6 comp value\n");
> > -		return ret;
> > -	}
> > -	calib->H6 = sign_extend32(tmp, 7);
> > +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> > +	calib->H3 = data->bme280_humid_cal_buf[H3];
> > +	h4_upper = FIELD_GET(BME280_COMP_H4_GET_MASK_UP,
> > +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> > +	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, h4_upper);
> > +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
> > +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> > +	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
> > +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> > +			get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> > +	calib->H6 = data->bme280_humid_cal_buf[H6];
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index ccacc67c1473..9bea0b84d2f4 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -257,8 +257,13 @@
> >  #define BME280_REG_COMP_H5		0xE5
> >  #define BME280_REG_COMP_H6		0xE7
> >  
> > +#define BME280_COMP_H4_GET_MASK_UP	GENMASK(15, 8)
> > +#define BME280_COMP_H4_PREP_MASK_UP	GENMASK(11, 4)
> > +#define BME280_COMP_H4_MASK_LOW		GENMASK(3, 0)
> >  #define BME280_COMP_H5_MASK		GENMASK(15, 4)
> >  
> > +#define BME280_CONTIGUOUS_CALIB_REGS	7
> > +
> >  #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
> >  #define BME280_OSRS_HUMIDITY_SKIP	0
> >  #define BME280_OSRS_HUMIDITY_1X		1
> > @@ -423,6 +428,7 @@ struct bmp280_data {
> >  		/* Calibration data buffers */
> >  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> >  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> > +		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
> >  		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
> >  		/* Miscellaneous, endianness-aware data buffers */
> >  		__le16 le16;
> 

