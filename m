Return-Path: <linux-iio+bounces-5621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28E8D7579
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544B01F22390
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9A38DF9;
	Sun,  2 Jun 2024 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmQl8MDb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722817C7C;
	Sun,  2 Jun 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333059; cv=none; b=ez28/qgBqMiK7iBcb6J+u3NGAyvGqTDRGEl0GZ9pOyI1vyes2xs8a7bMELmB0ZNmFnxHwig6ZndsFPInDt14GubPUb7B7iC5exumefTx3r2B2E1smY5AgiQk+TwUfHINyFZA2mMv6r6G6B9iBi7iNOT6FR6Tx3nOT86SObYqyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333059; c=relaxed/simple;
	bh=qJJp4ZLrJLL+e+iZKLTAp+ceTie0/gjPAkK9OxlXJ00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx+SOF0/FUqVmYax9ZO0QGsg8Rm3Dz79UZOx67pfU8j56UklQYn5qDwBmver0noCU6GhyJ1voyy7NSH4C7EJf6t0x+cRbhTEkP/YceTkuUHh9MyaPe1yd8earVUokOob70iwkP7tn/EATe7SPmNsntsaNtMUhZuvyJC2HobikVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmQl8MDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D73C2BBFC;
	Sun,  2 Jun 2024 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717333058;
	bh=qJJp4ZLrJLL+e+iZKLTAp+ceTie0/gjPAkK9OxlXJ00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmQl8MDbNOiMHLN+ofyoYtfWf42a1YTDqVJaypqa7T/IbiyasGyIneewrKQh5vXGC
	 5pjyTyp32B42TkNZDwCzI1mOmD2lRcc9NhU5RnTTMM+G85TwUwm8xHZPcc1hts2WMw
	 l//RUBKUGLs95RfUzmYvo2YbTRS/UJ/cPE5l807NxSealGuESH17u/xhpow/DtKkn0
	 as0NPEFZd2q6GANvQzqJXWRpidrmtGrXfYa8hcxvweVOzjJdgr+1Wgf4jkVdDIIJUA
	 fBmiX2pdE9d3NmGQXvSZJZLfDe22QxkwYBm1OORfDn+LY7noDPT0tZRNg43OVYFzeS
	 xnCn5Qd58YsOw==
Date: Sun, 2 Jun 2024 13:57:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] iio: chemical: bme680: Use bulk reads for
 calibration data
Message-ID: <20240602135726.2f10fd2b@jic23-huawei>
In-Reply-To: <20240527183805.311501-12-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-12-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:37:59 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Calibration data are located in contiguous-ish registers
> inside the chip. For that reason we can use bulk reads as is
> done as well in the BME68x Sensor API [1].
> 
> The arrays that are used for reading the data out of the sensor
> are located inside DMA safe buffer.

See below. I think in this case that isn't necessary.
However it's a quirk of how the custom regmap works. Whilst
we can't rely on regmap core spi implementations continuing to
bounce buffer, we can rely on one local to our particular driver.

> 
> [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1769
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>


> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 681f271f9b06..ed4cdb4d64af 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c

> +
>  struct bme680_calib {
>  	u16 par_t1;
>  	s16 par_t2;
> @@ -64,6 +109,16 @@ struct bme680_data {
>  	 * and humidity compensation calculations.
>  	 */
>  	s32 t_fine;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) may require the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	union {
> +		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
> +		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
> +		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
> +	} __aligned(IIO_DMA_MINALIGN);
Ah! I should have read ahead.  I don't think you need this alignment forcing
because bme680_regmap_spi_read uses spi_write_then_read() which always
bounces the data.

>  };
>  
>  static const struct regmap_range bme680_volatile_ranges[] = {
> @@ -112,217 +167,73 @@ static int bme680_read_calib(struct bme680_data *data,
>  			     struct bme680_calib *calib)
>  {


> +	calib->par_h3 = data->bme680_cal_buf_2[H3];
> +	calib->par_h4 = data->bme680_cal_buf_2[H4];
> +	calib->par_h5 = data->bme680_cal_buf_2[H5];
> +	calib->par_h6 = data->bme680_cal_buf_2[H6];
> +	calib->par_h7 = data->bme680_cal_buf_2[H7];
> +	calib->par_t1 = get_unaligned_le16(&data->bme680_cal_buf_2[T1_LSB]);
> +	calib->par_gh2 = get_unaligned_le16(&data->bme680_cal_buf_2[GH2_LSB]);
> +	calib->par_gh1 = data->bme680_cal_buf_2[GH1];
> +	calib->par_gh3 = data->bme680_cal_buf_2[GH3];
>  
> -	ret = regmap_read(data->regmap, BME680_H7_REG, &tmp);
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_RES_HEAT_VAL,
> +			       &data->bme680_cal_buf_3[0],
This one is always debated, but personally I'd prefer
				data->bme680_cal_buf_3,

for cases like this. Up to you though.
> +			       sizeof(data->bme680_cal_buf_3));
>  	if (ret < 0) {
> -		dev_err(dev, "failed to read BME680_H7_REG\n");
> +		dev_err(dev, "failed to read 3rd set of calib data;\n");
>  		return ret;
>  	}


