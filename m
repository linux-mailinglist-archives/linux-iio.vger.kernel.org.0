Return-Path: <linux-iio+bounces-7773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB33C93862D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 23:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4264E1F211CE
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404416B38F;
	Sun, 21 Jul 2024 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8zhRIQn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426942C95;
	Sun, 21 Jul 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721596977; cv=none; b=AiHBD/I/vRuFDGTmuZ/SRjZdeIBMN9qqIArsDkL3s983ADPnkYqeOBPU91wy9N7hab2lnbMiCYEnx7acxg/jPbPSmYhOmKIeYJx+zA/P2v8dxvXbgZfZHtBwvu23PDRM9M06sIj/gvnxFsvFEhhfUgkms407NQUQSvGd3PufzOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721596977; c=relaxed/simple;
	bh=ZJdaTsT2YLbx7Zc/pZgBhaMzwBYx2r9x4H4pWpIHzW0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHpcBt9bZugcoW8Z4B1EqCE9qEwYjm071iLNEfj8bmp/5FZUsWXzbirmB9VrvxXtfQ8if5j3OB9dEBxxX5HL+jWi9xnXk/1XaFUgop6cwgWRkAbppHCIkTCHl7QVEOsvm8IGl7vnlNpgMoutuSTBSyHMF3IESS1pfm02VmC5kVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8zhRIQn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso2693784a12.1;
        Sun, 21 Jul 2024 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721596973; x=1722201773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9plNulGMzncD5nE7PuX4rG7MzQFhG+CKrlLxYTsJxk=;
        b=F8zhRIQnH6UlxKrZeS4Ye9d2kGAsPbtSF35UWb8X37PceKkNZRt3R7ZzoI2f8yJFv9
         gRwjqTxg8MRtCRNxgpRsMkffSidDJzQn7J2HTplZGazu1m89zjm2z7r/LNYdg2FFuRiq
         uUU3SZd24IbN1kWSF6i8ozaen8Ksvbp5pQG8vSLTqoLHEJUnwNC3oXXghdZRRTFWpwxq
         YODM+VJ8JDjtmC9hfcI/iTTf9bpbnepVm+8RP6uUncjm2KE7x1k5ElzLF02U8TFMP+Xs
         aUA00RCj8/n6r1RGGWsm/91jjiJvAX3vaVB3HWgUinfhnVD+hOAf7IVnNZLsHWemcLIO
         h+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721596973; x=1722201773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9plNulGMzncD5nE7PuX4rG7MzQFhG+CKrlLxYTsJxk=;
        b=FVqCF0it52HTnt3pHGX2M1osSFykCOZpjEaJrK65hnU0wVX/XhwsY4FP/3iRi4oMK/
         QRmftRff5tX/wv1dUe1fuaKzWwlb5hezcYjjqkQysHKPEfVy/Xu4TTvYFsJm13/5X4BU
         gA/1qhLn4U2Z4reY8+E6T8jRTR4VDcev8JdABHtjHrpkWQ5+p9VwkfV9Vc/Ky8QWTs60
         6+kKhCeh4PK+Qr0fVr5N019IK1Zq1jcUHujR/Afeej8rtyQfqOyCPtsxql7IYh4O5C9O
         MSZnXbjA0L7OmQ2ITrFKkMyASd2dYK6jB9FkVRuZQlWbmgjkejOdihwG2o4wY++BU5t5
         TVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6jtShlF3aCA5mDa3SYkC6PNU9GOrs5TpEDCOhJ1U1VdGtVUG0kKBqTXHN93gKxF5doJCh11oYr+AaIBo1dXZKUFciCeeUd8RYQ4i1Kd/eHZ7zIf3OLRlGLGixOF9iCHVVq+xpIypzRw2XxXqK0ftS4ykFWfs05vO+cPVgIGvl5Tcn4g==
X-Gm-Message-State: AOJu0YwzKVK2VMUH75k5xM3BTGDLcpJQjlwqJZtavH8yPkhh646ynrpw
	9C57wzgq8Bm3glouQR2dQRBgxVsQtVeHCg4gkj5ZcJf1Rmc2R0d4
X-Google-Smtp-Source: AGHT+IGGh2yzdwHyPWJtTKXGyDO5/5MHafJXwtxaO2UAylGnrzUPJA/bIGjobygL7itJC8e40GyJnA==
X-Received: by 2002:a05:6402:5215:b0:5a1:7570:8914 with SMTP id 4fb4d7f45d1cf-5a3eee8241cmr4490298a12.11.1721596973191;
        Sun, 21 Jul 2024 14:22:53 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:bc21:fb27:f4e6:6867])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a5ef56e2c4sm1508676a12.39.2024.07.21.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 14:22:52 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 21 Jul 2024 23:22:50 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/10] iio: pressure: bmp280: Use bulk read for
 humidity calibration data
Message-ID: <20240721212250.GC325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-5-vassilisamir@gmail.com>
 <20240720121604.560d24e0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720121604.560d24e0@jic23-huawei>

On Sat, Jul 20, 2024 at 12:16:04PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jul 2024 23:15:52 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Convert individual reads to a bulk read for the humidity calibration data.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 57 +++++++++---------------------
> >  drivers/iio/pressure/bmp280.h      |  5 +++
> >  2 files changed, 21 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 3deaa57bb3f5..9c32266403bd 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -118,6 +118,8 @@ enum bmp580_odr {
> >   */
> >  enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
> >  
> > +enum { H2 = 0, H3 = 2, H4 = 3, H5 = 4, H6 = 6 };
> Maybe add a comment to this that these are the locations where
> the field 'starts' and that some overlap such as H5 and H6.
> 

True, thanks!

> > +
> >  enum {
> >  	/* Temperature calib indexes */
> >  	BMP380_T1 = 0,
> > @@ -344,6 +346,7 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	struct device *dev = data->dev;
> > +	s16 h4_upper, h4_lower;
> >  	unsigned int tmp;
> >  	int ret;
> >  
> > @@ -352,14 +355,6 @@ static int bme280_read_calib(struct bmp280_data *data)
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
> > @@ -368,43 +363,23 @@ static int bme280_read_calib(struct bmp280_data *data)
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
> > -	if (ret) {
> > -		dev_err(dev, "failed to read H4 comp value\n");
> > -		return ret;
> > -	}
> > -	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
> > -				  (be16_to_cpu(data->be16) & 0xf), 11);
> > -
> > -	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
> > -			       &data->le16, sizeof(data->le16));
> > +			       data->bme280_humid_cal_buf,
> > +			       sizeof(data->bme280_humid_cal_buf));
> >  	if (ret) {
> > -		dev_err(dev, "failed to read H5 comp value\n");
> > +		dev_err(dev, "failed to read humidity calibration values\n");
> >  		return ret;
> >  	}
> > -	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
> >  
> > -	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
> > -	if (ret) {
> > -		dev_err(dev, "failed to read H6 comp value\n");
> > -		return ret;
> > -	}
> > -	calib->H6 = sign_extend32(tmp, 7);
> > +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> > +	calib->H3 = data->bme280_humid_cal_buf[H3];
> > +	h4_upper = FIELD_GET(BME280_COMP_H4_MASK_UP,
> > +			     get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> > +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
> > +			     get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> > +	calib->H4 = sign_extend32((h4_upper & ~BME280_COMP_H4_MASK_LOW) | h4_lower, 11);
> 
> This looks unusual.  Why mask with MASK_LOW?  The field_get above already drops the bottom
> 4 bits an this is dropping more.  Should that H4_MASK_UP actually be GENMASK(15, 8)
> and then you shift it left 4 to make space for the lower part?
> 
> Original code was messing with values inline so there is less need for it
> to be explicit in how it does the masks.  Here you imply a 12 bit field but only use
> 8 bits of it which isn't good.
> 
> 

You are right it is a bit confusing. This endianness "fun" made me probably
write much more complex code. Indeed, it doesn't look good what I do even
though it works.

As you said, that H4_MASK_UP should be GENMASK(15,8) and then I should find
a better way.

Cheers,
Vasilis

> > +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> > +				  get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> > +	calib->H6 = data->bme280_humid_cal_buf[H6];
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index ccacc67c1473..56c01f224728 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -257,8 +257,12 @@
> >  #define BME280_REG_COMP_H5		0xE5
> >  #define BME280_REG_COMP_H6		0xE7
> >  
> > +#define BME280_COMP_H4_MASK_UP		GENMASK(15, 4)
> > +#define BME280_COMP_H4_MASK_LOW		GENMASK(3, 0)
> >  #define BME280_COMP_H5_MASK		GENMASK(15, 4)
> >  
> > +#define BME280_CONTIGUOUS_CALIB_REGS	7
> > +
> >  #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
> >  #define BME280_OSRS_HUMIDITY_SKIP	0
> >  #define BME280_OSRS_HUMIDITY_1X		1
> > @@ -423,6 +427,7 @@ struct bmp280_data {
> >  		/* Calibration data buffers */
> >  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> >  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> > +		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
> >  		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
> >  		/* Miscellaneous, endianness-aware data buffers */
> >  		__le16 le16;
> 

