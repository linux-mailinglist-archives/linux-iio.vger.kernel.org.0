Return-Path: <linux-iio+bounces-22466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54886B1EA58
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86287A5384
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16A27FB06;
	Fri,  8 Aug 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLIok0h1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489DA27EFFD;
	Fri,  8 Aug 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663052; cv=none; b=ZNXc9k3OU/DBDgQW8SKcDQ7U2bia1UnG4uaKB9EH1kpBMcGM+pgoQhM0oFHTIZfEmvvOPYNNGa6swS7Gsjx9rpVwkIdK7l58EvZ/sW1wqJHVAgC1e4wwGbYgdSeFqqVdmx8jEsRgEuviv/3nwk2E4JxPJxxjg59bic7n92pZQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663052; c=relaxed/simple;
	bh=pfQQcE3Y8KemriUIXNfJa3XZAwpA11JRr4IrT+L1Nk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPcwrazeXdhP6Xu45IZT4K9wgaHYuHMe7JspefNWYdOa//bTuHMqqhImbkkLoJG2F7tDtPjKtr2T47G7Se/ai9II7ho09P6/5ye9srbzN9TuLbSt8s+IDNBPCBJYtFtHHp/2wC/mh4Nj+A3njfeVVPgbmIGDNP6KkddF/5YM/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLIok0h1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e2c1dc6567so145674085a.1;
        Fri, 08 Aug 2025 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754663049; x=1755267849; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZsXkAMgHymmvMIubekbGQYlBJ3nce+Z0zRhxcFYaJfc=;
        b=VLIok0h1xK7IUcx/2A3RZ2bVsMfJBuXwMAtvxl2T+sZkdyyAMAiBOH9rafW9t7yVKQ
         NYfFG/C5rzymz2ZiDdhekAETgHX4uK9/dFh1MD0fDS5NWhC4iC6AcMBSSgbpMIlD3cZK
         Od7fleCUm03ZorVRWyuOqcY+Y4dHaoAmP5/gueN4tJyF0eEr3hihx5PBU6033M7o7M/5
         oyftb+MoWfic6N0hKPLUpPoTdHk3HkhHVSRK7nfaQIkZ70dRNX3tyKdvnQHDsxMiUrYI
         +wJvqPvaMxuKfekHRiDFyy+XkbF30KEg2Y7ZfthJ1KQItlbT27fCkDkNOO/sGhyn8tMS
         b7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663049; x=1755267849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsXkAMgHymmvMIubekbGQYlBJ3nce+Z0zRhxcFYaJfc=;
        b=NfhYlhlk2cagg0Wz8lUsdz7U7V9CWhsPLinHT0RQk5wfDDzpzpRPJnfLR2f00ZeNLM
         9fyiCe5Dt/woM/AuU12aQqxqWn5LTvXoA9C0mvfYGJBXi8DvNYu9flVLxIWIR4J8FBOP
         50TAwbY7GRtOjjLycSiWGfQD1sTc3o1GHFwx7DLVp9jK4c5z6OO2bgkgNfHfmNN8XaR0
         XkLp2Vv+245CGotHTLDoWbkKz9WfsxP/NVTypAs6QcocwFDnDVjKRqXXEWiCRsMM8kRh
         l8HHIEoqw7lIPkLKI6oirJ84wEHk3eY2yw/Vh2q0v0KA/8fOVeEoa87CzL7+ri6CQKEb
         SgHw==
X-Forwarded-Encrypted: i=1; AJvYcCVL7EMTi576h9ls71T7dyLpU6RQ5ZqKfPzhfjEAeNj9Bc/tRrit1csV0UQa6Qght/HeFShOKxFI+dtKQYAc@vger.kernel.org, AJvYcCWOMj0ymhLRQd69UulptEyUrjJBCm0IYWIHLt0x0aryPyzyoAq/C9tODs8R4eCk27wE9wc0mSGlpa1c@vger.kernel.org, AJvYcCWcfVIvON3xRC2vwY0IRxrfnJKs+gag1F2uz9/zwQ7NGRGTphngen7Y3Pz/olLz0+lIeTAvh5Fy6wCn@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCS0pJr8G0f6rdFXo/KZcvYm/hGg3NU6KS3bVSdpeU/EgWsR6
	fvtj1gF0RsC8QL2HCxaH6M+oBBXe71G3BbjG3vtLwURROHT9eKkJ4v+y
X-Gm-Gg: ASbGnctRP4hSZGTGpPk+XV/0JGnU4cVnWHwsebVY/0DjI0hPutL5UiYSTgfdbZfffnq
	4+scu3TCOaBwUMfna/dPzVsSRDEeyIVAqhJl24qDFzJ5EGnzNaJhssB1lSQU+afwyAGaS6xs6gf
	HebAWBCKJkMNjGcJilNylvL9JTEQM+0AmuZ+DXhFcdd5pUKzX7o/Opv7opXacrZoXBPXlAdY7Wz
	g5xQEYCzqLiHC0EFW/wTVGBOiXE2BGWLNIY1h/3eBB0OLrrcAxj3l/KgCRZvoLcdgswCLDKhCi2
	9jy+6YxQ3tNMD8SPrWqh2dC+ckej4mqSe86JUSZ0JNytjRsiIMyUoChiFxabXRHoFoOB0ZvUCv0
	Gmbc2pJi4JbETNw==
X-Google-Smtp-Source: AGHT+IGvkw4HPawinRb/86pARqRxdHAtVuO2FkgOUuG2RgbSWZy1rks3Jucb3Uce6I+9vrVuJ4f+TQ==
X-Received: by 2002:a05:620a:269b:b0:7e3:4416:fd6 with SMTP id af79cd13be357-7e82c7d1cfbmr506928985a.61.1754663048858;
        Fri, 08 Aug 2025 07:24:08 -0700 (PDT)
Received: from nsa ([87.249.138.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e695e69ed5sm907789885a.46.2025.08.08.07.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:24:08 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:24:23 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <qbje6xsyydkbxj4wrkmvleu2ejrikvz5cgmvza3iyowwkxbb2f@uz4rjzqqnmfz>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
 <2a8c8107475f2e394c1a0a51c9a9ddc941132b5d.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a8c8107475f2e394c1a0a51c9a9ddc941132b5d.1754641960.git.mazziesaccount@gmail.com>

On Fri, Aug 08, 2025 at 11:55:48AM +0300, Matti Vaittinen wrote:
> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
> 
> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
> conversion. Unlike with the ad7091 and ad7091r which also have a
> CONVSTART pin, the BD79105 requires that the pin must remain high also
> for the duration of the SPI access.
> 
> (*) Couple of words about the SPI. The BD79105 has pins named as
> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
> MISO.
> 
> DIN is a signal which can be used as a chip-select. When DIN is pulled
> low, the ADC will output the completed measurement via DOUT as SCLK is
> clocked. According to the data-sheet, the DIN can also be used for
> daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
> 'data-ready' -IRQ. These modes aren't supported by this driver.
> 
> Support reading ADC scale and data from the BD79105 using SPI, when DIN
> is used as a chip-select.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Revision history:
>  v2 => v3:
>  - Check for missing convstart GPIO at probe.
>  - Use indirect call to convstart (via function pointer) also from the
>    ad7476_scan_direct().
> 
>  v1 => v2:
>  - Fix the conversion delay for the BD79105
>  - Drop unnecessary GPIO check from the convstart disable
>  - Drop unintended whitespace change
>  - Fix spelling
> ---
>  drivers/iio/adc/ad7476.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 6cb2cbeafbd3..1bec6657394c 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -32,8 +32,10 @@ struct ad7476_chip_info {
>  	struct iio_chan_spec		channel[2];
>  	void (*reset)(struct ad7476_state *);
>  	void (*conversion_pre_op)(struct ad7476_state *st);
> +	void (*conversion_post_op)(struct ad7476_state *st);
>  	bool				has_vref;
>  	bool				has_vdrive;
> +	bool				convstart_required;
>  };
>  
>  struct ad7476_state {
> @@ -64,6 +66,18 @@ static void ad7091_convst(struct ad7476_state *st)
>  	udelay(1); /* Conversion time: 650 ns max */
>  }
>  
> +static void bd79105_convst_disable(struct ad7476_state *st)
> +{
> +	gpiod_set_value_cansleep(st->convst_gpio, 0);
> +}
> +
> +static void bd79105_convst_enable(struct ad7476_state *st)
> +{
> +	gpiod_set_value_cansleep(st->convst_gpio, 1);
> +	/* Worst case, 2790 ns required for conversion */
> +	ndelay(2790);
> +}
> +
>  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -81,6 +95,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
>  				    iio_get_time_ns(indio_dev));
>  done:
> +	if (st->chip_info->conversion_post_op)
> +		st->chip_info->conversion_post_op(st);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -103,6 +119,9 @@ static int ad7476_scan_direct(struct ad7476_state *st)
>  	if (ret)
>  		return ret;
>  
> +	if (st->chip_info->conversion_post_op)
> +		st->chip_info->conversion_post_op(st);
> +
>  	return be16_to_cpup((__be16 *)st->data);
>  }
>  
> @@ -273,6 +292,22 @@ static const struct ad7476_chip_info ltc2314_14_chip_info = {
>  	.has_vref = true,
>  };
>  
> +static const struct ad7476_chip_info bd79105_chip_info = {
> +	.channel[0] = AD7091R_CHAN(16),
> +	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	/*
> +	 * The BD79105 starts ADC data conversion when the CONVSTART line is
> +	 * set HIGH. The CONVSTART must be kept HIGH until the data has been
> +	 * read from the ADC.
> +	 */
> +	.conversion_pre_op = bd79105_convst_enable,
> +	.conversion_post_op = bd79105_convst_disable,
> +	/* BD79105 won't do conversion without convstart */
> +	.convstart_required = true,
> +	.has_vref = true,
> +	.has_vdrive = true,
> +};
> +
>  static const struct iio_info ad7476_info = {
>  	.read_raw = &ad7476_read_raw,
>  };
> @@ -332,6 +367,9 @@ static int ad7476_probe(struct spi_device *spi)
>  	if (IS_ERR(st->convst_gpio))
>  		return PTR_ERR(st->convst_gpio);
>  
> +	if (st->chip_info->convstart_required && !st->convst_gpio)
> +		return dev_err_probe(&spi->dev, -EINVAL, "No convstart GPIO\n");
> +
>  	/*
>  	 * This will never happen. Unless someone changes the channel specs
>  	 * in this driver. And if someone does, without changing the loop
> @@ -401,6 +439,7 @@ static const struct spi_device_id ad7476_id[] = {
>  	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
>  	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
>  	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
> +	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
>  	/*
>  	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
>  	 * point of view. The binding document mandates the ADS7866 to be
> -- 
> 2.50.1
> 



