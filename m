Return-Path: <linux-iio+bounces-14308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF1A0C2D6
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622EE1888FDA
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42241D4601;
	Mon, 13 Jan 2025 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zvn5v2HT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FC1D5173
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801789; cv=none; b=JYSysRZ8tVLj+f0CzGnE2qxauPyp0yb6da12qB0LfyzbFyXIaW6WmcI0B4bibJ+Aneid9EXz/pBT9y7JB1uGxFS1Hc6NnGweGM1wt6M3pmsBnV47FPgWVFYDBHEUPhbA+U3S9shgD3ipmgxRYKJUW7s2dVZ9C9MOe/Z4FZhlm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801789; c=relaxed/simple;
	bh=Ua7tqBmzyshoulaB7VZ0deiyOPNpRSquephKdWNciNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmf2LNmDUM0vT34Nyu9dMU3KU3YyB7vIFsE+VMeUBHQ5xkSJudhYLRD6N9Gzpzm32eDjHCovt/oShhGfPeQyH+FE1YdhjQ6mHv+e9xwuKYScuUl27sM5xxNC6Ega7VmFfWqwtX1+6z+t23ZQ47raabqS56ol4keoMQvmkd8kbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zvn5v2HT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283d48so34407785e9.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736801784; x=1737406584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTCDAAmyzMk9WAizg1mC0yuEdu4+GkStJfMTKRDWoeI=;
        b=Zvn5v2HTvyjl3x4cs4OJI6RV/Vylg7UrTFYxMY/HyoIeK7FHgUMbFqLhw37H4pSGwi
         NVHmZmEpek3OaEaCwa6Eqq+A75Z9VbcVYEa/BtYIfbqv7GHSnvHTePjhnQxdCraTp504
         z1p9Pxee6+BQpAvJkFMN279OYMe10KZxBYHzATHRV/5g8FSZtRsvLQvtLYH7GW2u+VAZ
         Yp7QcfluMemji5Cyb0+KAQ2lKwMpEGffRtKLWQ5VkzFthFTk4j4bnV6ygayK36BYe/Vv
         CfGDrYBw4lr39GGIJhXs3lpdrD9CUz5feNCX/mxxBe+iS6st7m8F0wzvHqP64PNGZXMU
         VrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736801784; x=1737406584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTCDAAmyzMk9WAizg1mC0yuEdu4+GkStJfMTKRDWoeI=;
        b=rmGukBrc+t9BKiUIbTlQdAi7CjPC6/fw0lyAtE9HfERvF4UUTxiY9G8ZANv17dbaUl
         oWHKCPAKfWiIn3mbvJ2xQg92qKpsXmEO8bI0IB1vTBQrxxFgeoe+vNPOOAjasxMcc8/N
         FkvHng/IRjNlkEtomTkVRekD6spQph5tonPsR5L8pD3hsg5oDvF1vSqYkQrPxMwQYcqL
         fEQ6bUNiJzvt0dKiYMJgcIpKgFMfUtjc1+Yll0nn/VuHTy/v1WtE9HpITAPt/2bcmOqT
         LrxeIFsp1GIJWJnZZQXR2NAidYfzhL53Doe6bHjIDmQ3QPppR2Ogomn1ii6SDwyrItaM
         65cg==
X-Forwarded-Encrypted: i=1; AJvYcCUC86HrhUezFVnMTdTaBG67u866r09VJpmGY24k2+mzgvncqBTLavjtN9kp20Yb8Ey23lNKeW/JVIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFeHjo17EoiVlmqpgxMKRo2lzwdAnbV3VdMxxu7PHkIgTHJ2g
	ebTQCP0w07XOAVHHnjDp4Mza55jO4c0tfbaSml4gvnhkbQncyxJZudjB4Ir32oU=
X-Gm-Gg: ASbGncuPsMBJ83bxrSI4zTOu0cubB+f7WT7S91lpGb+j0t2CJYaHrnIRP5KOG8OxniL
	qE/8MtdwnpgNtbchfR/b8sRaldw9RLNh9SsjM+Jh8nVhm7XtqUhM4CjEK0oPYmtUdHmLsI68eAa
	+Txnr8C42k0OFxhhQehxHTMx9OTjh47wPkN2HrgketzAkv7BGy+rfPg+SCTKdQ+GQR7MaHO7nt7
	3ZNXBTdsNfysybemF+E2WBn1V+zwCfWFaETjugiiALs/4zx
X-Google-Smtp-Source: AGHT+IFFvWoYSNjAjdD+ttOr5njDiwTJWmamc3tiDZe/rtc1b8d4aGfVQK7HbEGyvuksmw2dXhIguw==
X-Received: by 2002:a5d:5f52:0:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38a8733a284mr20251338f8f.43.1736801784453;
        Mon, 13 Jan 2025 12:56:24 -0800 (PST)
Received: from dfj ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38f0eesm13289102f8f.61.2025.01.13.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 12:56:23 -0800 (PST)
Date: Mon, 13 Jan 2025 21:55:01 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] iio: dac: ad3552r-hs: update function name (non
 functional)
Message-ID: <khdjndqgevuorjbjdqwi3geqdindsyllegud34ya4iwkcgib77@64lswbelidak>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-9-ab42aef0d840@baylibre.com>
 <4436a3be542569959a640c78397db67d3152c895.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4436a3be542569959a640c78397db67d3152c895.camel@gmail.com>

On 13.01.2025 16:11, Nuno Sá wrote:
> On Fri, 2025-01-10 at 11:24 +0100, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Update ad3552r_qspi_update_reg_bits function name to a more
> > generic name, since used mode can be SIMPLE/DUAL/QUAD SPI.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>

I think i have to use driver prefix "ad3552r_hs", so ad3552r_hs_update_reg_bits
not ad3552r_update_reg_bits.

Going to adjust it.

> >  drivers/iio/dac/ad3552r-hs.c | 64 ++++++++++++++++++++-----------------------
> > -
> >  1 file changed, 29 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index 4600a9e84dfc..7f3a70cfbef8 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -56,9 +56,9 @@ struct ad3552r_hs_state {
> >  	u32 config_d;
> >  };
> >  
> > -static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> > -					u32 reg, u32 mask, u32 val,
> > -					size_t xfer_size)
> > +static int ad3552r_update_reg_bits(struct ad3552r_hs_state *st,
> > +				   u32 reg, u32 mask, u32 val,
> > +				   size_t xfer_size)
> >  {
> >  	u32 rval;
> >  	int ret;
> > @@ -206,9 +206,8 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev
> > *indio_dev)
> >  	 */
> >  
> >  	/* Primary region access, set streaming mode (now in SPI + SDR). */
> > -	ret = ad3552r_qspi_update_reg_bits(st,
> > -					  
> > AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> > -					   AD3552R_MASK_SINGLE_INST, 0, 1);
> > +	ret = ad3552r_update_reg_bits(st,
> > AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> > +				      AD3552R_MASK_SINGLE_INST, 0, 1);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -217,10 +216,9 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev
> > *indio_dev)
> >  	 * len value so it's not cleared hereafter when enabling streaming
> > mode
> >  	 * (cleared by CS_ up).
> >  	 */
> > -	ret = ad3552r_qspi_update_reg_bits(st,
> > -		AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > -		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
> > -		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> > +	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > +				      AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
> > +				      AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
> > 1);
> >  	if (ret)
> >  		goto exit_err_streaming;
> >  
> > @@ -250,7 +248,7 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev
> > *indio_dev)
> >  
> >  	/*
> >  	 * From here onward mode is DDR, so reading any register is not
> > possible
> > -	 * anymore, including calling "ad3552r_qspi_update_reg_bits"
> > function.
> > +	 * anymore, including calling "ad3552r_update_reg_bits" function.
> >  	 */
> >  
> >  	/* Set target to best high speed mode (D or QSPI). */
> > @@ -351,18 +349,16 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev
> > *indio_dev)
> >  	 * Back to simple SPI for secondary region too now, so to be able to
> >  	 * dump/read registers there too if needed.
> >  	 */
> > -	ret = ad3552r_qspi_update_reg_bits(st,
> > -					  
> > AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > -					   AD3552R_MASK_MULTI_IO_MODE,
> > -					   AD3552R_SPI, 1);
> > +	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > +				      AD3552R_MASK_MULTI_IO_MODE,
> > +				      AD3552R_SPI, 1);
> >  	if (ret)
> >  		return ret;
> >  
> >  	/* Back to single instruction mode, disabling loop. */
> > -	ret = ad3552r_qspi_update_reg_bits(st,
> > -					  
> > AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> > -					   AD3552R_MASK_SINGLE_INST,
> > -					   AD3552R_MASK_SINGLE_INST, 1);
> > +	ret = ad3552r_update_reg_bits(st,
> > AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> > +				      AD3552R_MASK_SINGLE_INST,
> > +				      AD3552R_MASK_SINGLE_INST, 1);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -379,10 +375,10 @@ static inline int ad3552r_hs_set_output_range(struct
> > ad3552r_hs_state *st,
> >  	else
> >  		val = FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode);
> >  
> > -	return ad3552r_qspi_update_reg_bits(st,
> > -
> > 					AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> > -					AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
> > -					val, 1);
> > +	return ad3552r_update_reg_bits(st,
> > +				       AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> > +				       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
> > +				       val, 1);
> >  }
> >  
> >  static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> > @@ -398,10 +394,10 @@ static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> >  		fsleep(10);
> >  		gpiod_set_value_cansleep(st->reset_gpio, 0);
> >  	} else {
> > -		ret = ad3552r_qspi_update_reg_bits(st,
> > -					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > -					AD3552R_MASK_SOFTWARE_RESET,
> > -					AD3552R_MASK_SOFTWARE_RESET, 1);
> > +		ret = ad3552r_update_reg_bits(st,
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > +			AD3552R_MASK_SOFTWARE_RESET,
> > +			AD3552R_MASK_SOFTWARE_RESET, 1);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -534,19 +530,17 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> >  
> >  	val = ret;
> >  
> > -	ret = ad3552r_qspi_update_reg_bits(st,
> > -				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > -				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> > -				val, 1);
> > +	ret = ad3552r_update_reg_bits(st,
> > AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > +				      AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> > +				      val, 1);
> >  	if (ret)
> >  		return ret;
> >  
> >  	ret = ad3552r_get_drive_strength(st->dev, &val);
> >  	if (!ret) {
> > -		ret = ad3552r_qspi_update_reg_bits(st,
> > -					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > -					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> > -					val, 1);
> > +		ret = ad3552r_update_reg_bits(st,
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +			AD3552R_MASK_SDO_DRIVE_STRENGTH, val, 1);
> >  		if (ret)
> >  			return ret;
> >  	}
> > 
> 

