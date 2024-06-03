Return-Path: <linux-iio+bounces-5708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F958D8A16
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 21:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033791C20918
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD738137923;
	Mon,  3 Jun 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/akP1vO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1723A0;
	Mon,  3 Jun 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442749; cv=none; b=sfI4ap2dZIndCBr9CAv1TrFd/JFErlZBguG86bLreJ9C45rf6Vk1j96GnBFRR3noL/xktXh/hO4KGaBC0OvZ08PexlpPUyLF+Ryp6Pxzjt/55vN0nT8hDcXJF99MMeemzf0/gad1vboM6OuzQnhnkFY5K07uYRvNdWLkjrfy9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442749; c=relaxed/simple;
	bh=93vibPm/pqhSswaWzN5lU8ohUUXoe+TYWErjrRk6dg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqQmZLrPnYCMxur6/RmyvIzp1oz121QEPm8B45q6bOEPwqiWcRy6Mi5c0Uxz6MlnimD4tXn0DmZv2/8EbHz2FW05KfH5w3QH7+vXcbge4KK4FuLDreYDeNhMyUomg9HEk/5Rsgn+vFc98mYlruULNv/VzZ3uGMIFbjrVgMi6KtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/akP1vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48E9C2BD10;
	Mon,  3 Jun 2024 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717442749;
	bh=93vibPm/pqhSswaWzN5lU8ohUUXoe+TYWErjrRk6dg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/akP1vO4DOtnsO7GnJVIkS6aL+LD78ULrfHNvX0Iu0qns9yzjiYA+nnhBsUzTfcn
	 LPRnhiqopIE/9zpUW3te4ChhtOdAGwwBiK0QsPH8C6S3pI95HqYhdb4BjMlw569Bv6
	 vFVisHNOPXSn03QshkcTFSzFK4Cv8fafyhPdlz6toOccxGbptfliJ9g/NiAkWn4sy0
	 NzhQTFzJ4r94DLSFw2jQg/lEcxGH1fD3HGPAn6rV+OZgtxC3l93mjZUYeAk7t241Qk
	 Cm5U8qK3EDjdG5NvSEiQ5OHS2JuZbR8LwJWxgYkVWKKjwtxnzqhXecHH3O0Fp2ebA3
	 U6hVKWoGWB1Bw==
Date: Mon, 3 Jun 2024 20:25:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] iio: chemical: bme680: Use bulk reads for
 calibration data
Message-ID: <20240603202537.4b40c80a@jic23-huawei>
In-Reply-To: <20240602193023.GD387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-12-vassilisamir@gmail.com>
	<20240602135726.2f10fd2b@jic23-huawei>
	<20240602193023.GD387181@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 21:30:23 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, Jun 02, 2024 at 01:57:26PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 May 2024 20:37:59 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > Calibration data are located in contiguous-ish registers
> > > inside the chip. For that reason we can use bulk reads as is
> > > done as well in the BME68x Sensor API [1].
> > > 
> > > The arrays that are used for reading the data out of the sensor
> > > are located inside DMA safe buffer.  
> > 
> > See below. I think in this case that isn't necessary.
> > However it's a quirk of how the custom regmap works. Whilst
> > we can't rely on regmap core spi implementations continuing to
> > bounce buffer, we can rely on one local to our particular driver.
> >   
> 
> What about the I2C implementation though? I watched recently a video
> from Wolfram Sang [1] and as far as I understood, the buffers are not
> provided by the I2C API, but you have to provide them. In any case, I
> should maybe check both SPI and I2C reads to understand the internals.
> 
> [1]: https://www.youtube.com/watch?v=JDwaMClvV-s
> 

I'm not sure Wolfram got far with his desire for generally avoiding the
bounce buffers for i2c.  I think it's strictly opt in only so don't opt in
unless your code is safe for it and regmap never will by default as too
many drivers will be subtly broken.


> > > 
> > > [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1769
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > 
> >   
> > > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > > index 681f271f9b06..ed4cdb4d64af 100644
> > > --- a/drivers/iio/chemical/bme680_core.c
> > > +++ b/drivers/iio/chemical/bme680_core.c  
> >   
> > > +
> > >  struct bme680_calib {
> > >  	u16 par_t1;
> > >  	s16 par_t2;
> > > @@ -64,6 +109,16 @@ struct bme680_data {
> > >  	 * and humidity compensation calculations.
> > >  	 */
> > >  	s32 t_fine;
> > > +
> > > +	/*
> > > +	 * DMA (thus cache coherency maintenance) may require the
> > > +	 * transfer buffers to live in their own cache lines.
> > > +	 */
> > > +	union {
> > > +		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
> > > +		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
> > > +		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
> > > +	} __aligned(IIO_DMA_MINALIGN);  
> > Ah! I should have read ahead.  I don't think you need this alignment forcing
> > because bme680_regmap_spi_read uses spi_write_then_read() which always
> > bounces the data.
> >   
> 
> Same comment. What about I2C?
> 
> > >  };
> > >  
> > >  static const struct regmap_range bme680_volatile_ranges[] = {
> > > @@ -112,217 +167,73 @@ static int bme680_read_calib(struct bme680_data *data,
> > >  			     struct bme680_calib *calib)
> > >  {  
> > 
> >   
> > > +	calib->par_h3 = data->bme680_cal_buf_2[H3];
> > > +	calib->par_h4 = data->bme680_cal_buf_2[H4];
> > > +	calib->par_h5 = data->bme680_cal_buf_2[H5];
> > > +	calib->par_h6 = data->bme680_cal_buf_2[H6];
> > > +	calib->par_h7 = data->bme680_cal_buf_2[H7];
> > > +	calib->par_t1 = get_unaligned_le16(&data->bme680_cal_buf_2[T1_LSB]);
> > > +	calib->par_gh2 = get_unaligned_le16(&data->bme680_cal_buf_2[GH2_LSB]);
> > > +	calib->par_gh1 = data->bme680_cal_buf_2[GH1];
> > > +	calib->par_gh3 = data->bme680_cal_buf_2[GH3];
> > >  
> > > -	ret = regmap_read(data->regmap, BME680_H7_REG, &tmp);
> > > +	ret = regmap_bulk_read(data->regmap, BME680_REG_RES_HEAT_VAL,
> > > +			       &data->bme680_cal_buf_3[0],  
> > This one is always debated, but personally I'd prefer
> > 				data->bme680_cal_buf_3,
> >   
> 
> For me it's the same, I could change it to what you proposed, no problem!
> 
> Cheers,
> Vasilis
> 
> > for cases like this. Up to you though.  
> > > +			       sizeof(data->bme680_cal_buf_3));
> > >  	if (ret < 0) {
> > > -		dev_err(dev, "failed to read BME680_H7_REG\n");
> > > +		dev_err(dev, "failed to read 3rd set of calib data;\n");
> > >  		return ret;
> > >  	}  
> >   


