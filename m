Return-Path: <linux-iio+bounces-5651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB688D7797
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 21:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFD01C21300
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D96E2BE;
	Sun,  2 Jun 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEkEBNeL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214E6EB74;
	Sun,  2 Jun 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717356629; cv=none; b=F3PmBjr1ywwqPAY1bnYzoVXSIc/dnl03jVw4LOEbQUTnrzkXEO1GBrdrzEm0ABSNGIphXrYBBRp2fmVVOPO2GbjPWRlN2VyMk7yo/hrym4uO9aMlhq95l+Lo9RHVxOT30oBuGxTdaNRJMgGEcl5Eg2wMEcM7+pRbu6P8kd+olcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717356629; c=relaxed/simple;
	bh=h4e1yFRxze32vjvIQH8lSS1KLqgKO7WXwOan/pJBcyw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i95ljMSmhYo+slrTunJgNQS6JGmvmUWJ4RyovaqkiJcnNcuwUIVBmVSC3MUpnvcFmLgmIAdUCM5AfCTWMQuoDmkqcLGnwtWO9rswnpw5+Ik8ABQGcOhaaVm/co+JxOLLD4n8HUebFjapbvokBbSPVqrHObfO/gfExk+OL1eobqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEkEBNeL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so139902466b.3;
        Sun, 02 Jun 2024 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717356626; x=1717961426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=km/E7iZqx5tUueSO8Wlt0CC3lvvijfTVl/NMwogX0wg=;
        b=IEkEBNeLab7jsWseL3U4738Hgnx/iB2SoOhgTlPfGYx7A1HA8nXOzJHqaUPnTbnq87
         gBuVtSNatvL/7vBiWA6tqBQDnxYrFXx6+9BEgM4/egAr6h7YHSbnQyMXoB6uYkhi5yq8
         ZoAdQFfIsTCWtkMvQ07g80mcXpV0np9Cx1z69lc0kuZs+Wv6sTZREysVc6Y0efrnhvFH
         yR4eyRtfhJHXQCHtcSe4xOThU5iW6mhD5oosEH9N2DX8VRGdZijR2BtZch8rFhbjI3G5
         PasvP2UVaXqbbtnylPXv35lUcKF/qPa4BTorJAQTYXOLfZxmS15+0AyCoMRstZ+CRo4S
         4Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717356626; x=1717961426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km/E7iZqx5tUueSO8Wlt0CC3lvvijfTVl/NMwogX0wg=;
        b=GIj0gh3vn8ZxA4Lbm4n6BDh5ogC3DJW95y2+9h7YT2zlwoFX72e3nf/uOuOlw/1OkM
         espChoNUoc9ZTTLC1jpjRM/lSTQ2pgDHYOh/h7Gd8JJhgWjrprn/uGoyqjuhp8+akCqW
         CobUt9XSRGXXNe7a0rz+0irZrJwa7Qb8aclpdN4d5FRkhWzYY4CDYp8Yvu0xGtw8+Z9A
         tzEFPm++hbW30cR+zova4Hgb3KhQWp1rE4Ikpc4cp8L4BWe4H0Z1LwX3BRIlLrY+tEdL
         n8Psq9oZaz4ge889EbJOHuawP2odhLbiSXcHFOPjP8ecYU8HyLR8nEUeQZ3fJFVll/Iq
         0huQ==
X-Forwarded-Encrypted: i=1; AJvYcCULSKVnZ8tt1/o/nDBL3kiEk+OUThv+us9yEkbdQZAc24IniXM1iipoSTlsKWyjVvPmbPaXo1D/xenzU40GaWkst+vYHoYyBpeMtljaCHX2jVlfbFNgq0OxrgepFxZxPZbPW/Y+OjHm
X-Gm-Message-State: AOJu0YzTqliS0SJo/8DA5bkDvjDadGs6E+nTiEkE7UDaDPrM4OmQrKfg
	8zeMs6RbjF4kofPOY3V2gUvrY0sFoJWfTeqbtCnXxcCkDqhsAdmn
X-Google-Smtp-Source: AGHT+IGLdXqtxMPsxOScGJ4wlBbhtTTK1Ub+y80W/RetrW9BuR6+fXs9/SCsjupC8M0NRh1rhga6Uw==
X-Received: by 2002:a17:906:a046:b0:a59:d2ac:3856 with SMTP id a640c23a62f3a-a682022f87cmr525405466b.22.1717356625589;
        Sun, 02 Jun 2024 12:30:25 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:add1:b1ad:7182:3e90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a690a32cba4sm53358366b.158.2024.06.02.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:30:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 2 Jun 2024 21:30:23 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] iio: chemical: bme680: Use bulk reads for
 calibration data
Message-ID: <20240602193023.GD387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-12-vassilisamir@gmail.com>
 <20240602135726.2f10fd2b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602135726.2f10fd2b@jic23-huawei>

On Sun, Jun 02, 2024 at 01:57:26PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 20:37:59 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Calibration data are located in contiguous-ish registers
> > inside the chip. For that reason we can use bulk reads as is
> > done as well in the BME68x Sensor API [1].
> > 
> > The arrays that are used for reading the data out of the sensor
> > are located inside DMA safe buffer.
> 
> See below. I think in this case that isn't necessary.
> However it's a quirk of how the custom regmap works. Whilst
> we can't rely on regmap core spi implementations continuing to
> bounce buffer, we can rely on one local to our particular driver.
> 

What about the I2C implementation though? I watched recently a video
from Wolfram Sang [1] and as far as I understood, the buffers are not
provided by the I2C API, but you have to provide them. In any case, I
should maybe check both SPI and I2C reads to understand the internals.

[1]: https://www.youtube.com/watch?v=JDwaMClvV-s

> > 
> > [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1769
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index 681f271f9b06..ed4cdb4d64af 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> 
> > +
> >  struct bme680_calib {
> >  	u16 par_t1;
> >  	s16 par_t2;
> > @@ -64,6 +109,16 @@ struct bme680_data {
> >  	 * and humidity compensation calculations.
> >  	 */
> >  	s32 t_fine;
> > +
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) may require the
> > +	 * transfer buffers to live in their own cache lines.
> > +	 */
> > +	union {
> > +		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
> > +		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
> > +		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
> > +	} __aligned(IIO_DMA_MINALIGN);
> Ah! I should have read ahead.  I don't think you need this alignment forcing
> because bme680_regmap_spi_read uses spi_write_then_read() which always
> bounces the data.
> 

Same comment. What about I2C?

> >  };
> >  
> >  static const struct regmap_range bme680_volatile_ranges[] = {
> > @@ -112,217 +167,73 @@ static int bme680_read_calib(struct bme680_data *data,
> >  			     struct bme680_calib *calib)
> >  {
> 
> 
> > +	calib->par_h3 = data->bme680_cal_buf_2[H3];
> > +	calib->par_h4 = data->bme680_cal_buf_2[H4];
> > +	calib->par_h5 = data->bme680_cal_buf_2[H5];
> > +	calib->par_h6 = data->bme680_cal_buf_2[H6];
> > +	calib->par_h7 = data->bme680_cal_buf_2[H7];
> > +	calib->par_t1 = get_unaligned_le16(&data->bme680_cal_buf_2[T1_LSB]);
> > +	calib->par_gh2 = get_unaligned_le16(&data->bme680_cal_buf_2[GH2_LSB]);
> > +	calib->par_gh1 = data->bme680_cal_buf_2[GH1];
> > +	calib->par_gh3 = data->bme680_cal_buf_2[GH3];
> >  
> > -	ret = regmap_read(data->regmap, BME680_H7_REG, &tmp);
> > +	ret = regmap_bulk_read(data->regmap, BME680_REG_RES_HEAT_VAL,
> > +			       &data->bme680_cal_buf_3[0],
> This one is always debated, but personally I'd prefer
> 				data->bme680_cal_buf_3,
> 

For me it's the same, I could change it to what you proposed, no problem!

Cheers,
Vasilis

> for cases like this. Up to you though.
> > +			       sizeof(data->bme680_cal_buf_3));
> >  	if (ret < 0) {
> > -		dev_err(dev, "failed to read BME680_H7_REG\n");
> > +		dev_err(dev, "failed to read 3rd set of calib data;\n");
> >  		return ret;
> >  	}
> 

