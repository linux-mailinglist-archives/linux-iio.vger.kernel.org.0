Return-Path: <linux-iio+bounces-5717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636258D8ADF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 22:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BDC1C23A39
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A020ED;
	Mon,  3 Jun 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCt8qbHk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4613B2B2;
	Mon,  3 Jun 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446610; cv=none; b=dkIQASVkHRCiVQI9LAJrTTz7t93Fbaov9YzkASgVXPrXq+GbkXsRbbFCHAe7Av3FQjDhfBuqT5fYPcP7J/o8tMRbC7okguW0yn76yGgyfTvuZTjoZlqn5Ce3IBPxsairSGvZxVt+xbf1ZdHRAIrw9CEuYHXDO7L5xH90SFtBGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446610; c=relaxed/simple;
	bh=rBEJ6aFn3WtiDOqUov72VDi2kBi3Son3uHAq6f5O7nA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHrgLGTfBe65uAPXDOnmt/Prqhq/RT20APe4rvBkK5fl+QcKRciylyheWhiM4RlqkW1a2j1dcHj/klKsKvPqAqorbSeyAHW+ga+H79fJB6n8ifB5NhgeNEVSyH7oz41B9dcqjxhKLy/jpkMsUAQ/YAJ+UnWuCB2+V7LyDuZkY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCt8qbHk; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so27125591fa.0;
        Mon, 03 Jun 2024 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717446607; x=1718051407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MNCejFefIj3mRDZiJBBUKRSrQvuyurQnNmolrCC+7o=;
        b=hCt8qbHk42ix6ZUl5YgZ86FSch/0c6nOOWUeaJ3e2dBlGHKVQsb6xiNfrToYQXxFhZ
         Osr6vtM576A0ghX2ZxHQaamr7yK0hoIHrCNQNJO39BNYp4Hj7v6qTSA+zDGUfA0rpAsE
         AENg0/KM7Zp9mJFh/1WcJsvAwWe6fq+IBWMsR13jJTE9LZBWN2aQPp5hpQCP/fxwVzcg
         hglzotMjpM0q3bU3ySBJLfjj8HCJd+f2bJNzhPPoHBVAwXRzgvZHKlz2Fm9wWdbQGbTr
         hgJC1eXtXTKCWkwh9EI7xXkR+mqozo0rykGJwN5+ftjfhp8JqmEVubV9nTCadv3nW82Z
         e50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446607; x=1718051407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MNCejFefIj3mRDZiJBBUKRSrQvuyurQnNmolrCC+7o=;
        b=Vcp15EJ0Z7JwUh/Wmrjx1fN8/auS6nqBpk7zNBzMPwoLHD6xNFAPp1PVxVV19rk7lB
         pQV/6OQGw1qUfWchIUTGzO/tkxx3NJPXSg0a8k5VL7JWur3k4TXeWW7U2hDwxkw6qS47
         n74YD4yaV7yZkWvmF9tiuGybc/SCG8BuNx7EnQeZ76ciJpjD6nN72eLPHfATRZ+WsH22
         pTa4xiccecWL5IW7EZ4GhosEmNGKzlASFYQ7fy3Ik+l75rxuwLyv83LqOLDZz/vUat42
         IFbvcErlKrCa5jb/+ZqbcjJCdmkYgJOmP3WMcMAqeFpjiij9aiMdOpXAmy/h1RUgMDIz
         BGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1hQtSzhkH8B4I9wtNJ4azKmFwbyKV+9UNsvdPEx0bYt6xylwz1BkxdxaBjBWujhRy4ZHhkHd2CzmA5JVyrfG1Mlv0nHmc94mxIF+LQbIg5ab2KGkAQJyLe70JXIAqUVHKp/6BQI/
X-Gm-Message-State: AOJu0YzU422tOx9nBPx+zjal9Tuymb/zIR65N/FAzv8QtK8de3xsjJ4z
	VkcKynWeeMTugyXewKXmGuy9QjROIEsViMJ0e2pOWgyDtC5yofLG/2ZK6RpV
X-Google-Smtp-Source: AGHT+IFpaXP6PxTOCLpSrH/20lsvkLCeVFoQroSSDQVeTmfOzuSTDrJLxdG0ElkYM1tWfLwXl/PCfw==
X-Received: by 2002:a2e:9d88:0:b0:2e1:9c57:195a with SMTP id 38308e7fff4ca-2ea951de27fmr84988791fa.32.1717446606120;
        Mon, 03 Jun 2024 13:30:06 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:c014:12e2:7350:b51b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f39b9294sm284771466b.180.2024.06.03.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 13:30:05 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 3 Jun 2024 22:30:03 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] iio: chemical: bme680: Use bulk reads for
 calibration data
Message-ID: <20240603203003.GA444780@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-12-vassilisamir@gmail.com>
 <20240602135726.2f10fd2b@jic23-huawei>
 <20240602193023.GD387181@vamoiridPC>
 <20240603202537.4b40c80a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603202537.4b40c80a@jic23-huawei>

On Mon, Jun 03, 2024 at 08:25:37PM +0100, Jonathan Cameron wrote:
> On Sun, 2 Jun 2024 21:30:23 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Sun, Jun 02, 2024 at 01:57:26PM +0100, Jonathan Cameron wrote:
> > > On Mon, 27 May 2024 20:37:59 +0200
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > >   
> > > > Calibration data are located in contiguous-ish registers
> > > > inside the chip. For that reason we can use bulk reads as is
> > > > done as well in the BME68x Sensor API [1].
> > > > 
> > > > The arrays that are used for reading the data out of the sensor
> > > > are located inside DMA safe buffer.  
> > > 
> > > See below. I think in this case that isn't necessary.
> > > However it's a quirk of how the custom regmap works. Whilst
> > > we can't rely on regmap core spi implementations continuing to
> > > bounce buffer, we can rely on one local to our particular driver.
> > >   
> > 
> > What about the I2C implementation though? I watched recently a video
> > from Wolfram Sang [1] and as far as I understood, the buffers are not
> > provided by the I2C API, but you have to provide them. In any case, I
> > should maybe check both SPI and I2C reads to understand the internals.
> > 
> > [1]: https://www.youtube.com/watch?v=JDwaMClvV-s
> > 
> 
> I'm not sure Wolfram got far with his desire for generally avoiding the
> bounce buffers for i2c.  I think it's strictly opt in only so don't opt in
> unless your code is safe for it and regmap never will by default as too
> many drivers will be subtly broken.
> 

The things that I found about DMA "safety" in I2C are [1] and [2] so I think
that the IIO_DMA_MINALIGN should remain because in the future, in case it's
needed for triggered buffers to do buffer reads from the volatile registers
of the device, then it might be a problem for I2C. 

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L2627
[2]: https://elixir.bootlin.com/linux/latest/source/include/linux/i2c.h#L92

> 
> > > > 
> > > > [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1769
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > > 
> > >   
> > > > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > > > index 681f271f9b06..ed4cdb4d64af 100644
> > > > --- a/drivers/iio/chemical/bme680_core.c
> > > > +++ b/drivers/iio/chemical/bme680_core.c  
> > >   
> > > > +
> > > >  struct bme680_calib {
> > > >  	u16 par_t1;
> > > >  	s16 par_t2;
> > > > @@ -64,6 +109,16 @@ struct bme680_data {
> > > >  	 * and humidity compensation calculations.
> > > >  	 */
> > > >  	s32 t_fine;
> > > > +
> > > > +	/*
> > > > +	 * DMA (thus cache coherency maintenance) may require the
> > > > +	 * transfer buffers to live in their own cache lines.
> > > > +	 */
> > > > +	union {
> > > > +		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
> > > > +		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
> > > > +		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
> > > > +	} __aligned(IIO_DMA_MINALIGN);  
> > > Ah! I should have read ahead.  I don't think you need this alignment forcing
> > > because bme680_regmap_spi_read uses spi_write_then_read() which always
> > > bounces the data.
> > >   
> > 
> > Same comment. What about I2C?
> > 
> > > >  };
> > > >  
> > > >  static const struct regmap_range bme680_volatile_ranges[] = {
> > > > @@ -112,217 +167,73 @@ static int bme680_read_calib(struct bme680_data *data,
> > > >  			     struct bme680_calib *calib)
> > > >  {  
> > > 
> > >   
> > > > +	calib->par_h3 = data->bme680_cal_buf_2[H3];
> > > > +	calib->par_h4 = data->bme680_cal_buf_2[H4];
> > > > +	calib->par_h5 = data->bme680_cal_buf_2[H5];
> > > > +	calib->par_h6 = data->bme680_cal_buf_2[H6];
> > > > +	calib->par_h7 = data->bme680_cal_buf_2[H7];
> > > > +	calib->par_t1 = get_unaligned_le16(&data->bme680_cal_buf_2[T1_LSB]);
> > > > +	calib->par_gh2 = get_unaligned_le16(&data->bme680_cal_buf_2[GH2_LSB]);
> > > > +	calib->par_gh1 = data->bme680_cal_buf_2[GH1];
> > > > +	calib->par_gh3 = data->bme680_cal_buf_2[GH3];
> > > >  
> > > > -	ret = regmap_read(data->regmap, BME680_H7_REG, &tmp);
> > > > +	ret = regmap_bulk_read(data->regmap, BME680_REG_RES_HEAT_VAL,
> > > > +			       &data->bme680_cal_buf_3[0],  
> > > This one is always debated, but personally I'd prefer
> > > 				data->bme680_cal_buf_3,
> > >   
> > 
> > For me it's the same, I could change it to what you proposed, no problem!
> > 
> > Cheers,
> > Vasilis
> > 
> > > for cases like this. Up to you though.  
> > > > +			       sizeof(data->bme680_cal_buf_3));
> > > >  	if (ret < 0) {
> > > > -		dev_err(dev, "failed to read BME680_H7_REG\n");
> > > > +		dev_err(dev, "failed to read 3rd set of calib data;\n");
> > > >  		return ret;
> > > >  	}  
> > >   
> 

