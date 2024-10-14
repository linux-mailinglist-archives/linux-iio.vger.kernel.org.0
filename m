Return-Path: <linux-iio+bounces-10588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECE99D8CE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 23:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73801C212E7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842481D0F61;
	Mon, 14 Oct 2024 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wV8lYQSL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348E1C729B
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940450; cv=none; b=MAeJOJ87eh+5GnbJWu/P6rYYxdMel2fG4Decd8pIlNcO1cVsziowYrVzR620Vi317PweEbi8yZwUBk4HsOvHuOXzKhnaoJNoZ8j3uNJ+7tuAUPj1IBBw5ihED9N2qbLWTxKottBl1ZPZMkBX0APQeFlPl3baU6Smr+fOPnsplsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940450; c=relaxed/simple;
	bh=NNULu7V4/uFQOOw1zu9eVvMWDZPrUoD1MFk/IRT5hLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlNfcrxNpxu8I+Tu5Hxah6kDbcvoSoT3proFYUGLWxA+q1YbCnpFIFD+NwW8d5aIkLJWohZDgrgTYIHGWH40yEcQyy480dday7i54uRC0DutmxP+1uqxaALVn/P4nKB5LnCllZ2HMLzkyH0YK9hQbQtg3ZeQbwFQnIqt6gsA4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wV8lYQSL; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-716ab0c7873so1318565a34.2
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728940448; x=1729545248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zq14q1R1F8s50ju9k71p1ZwPAO4Av1bykZb7U4Dj1cE=;
        b=wV8lYQSLveiIsyBaD9d01kQXbU3B+KqPSMv2Odc571NxUsY/JunsWZSs749976PW/t
         ll3pCd6M+BJRSp8XBJZohIxKdXD1akV3h3Ynml8mMwvMfL1TB8X+ZNb1oAX47tCAh5k0
         tDyWg2FgUjq7eltPyg/xnBBvJE1txW71D5x54ZQBQ1iw3PMpJteqwz9BQ/lDrFyv5Mfj
         yE6BwqUmWAkvvCZ/B64/duZqTOdfEQH8F0XxGDbvv6wl9rX26XtQpjpKm71N9vkBO2kz
         O5lUypYrNgO731RkwzgeQRnAeP7ExVznivds6vxg7KmI5LmYShktBpVF32EEuRywK7WU
         WOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940448; x=1729545248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zq14q1R1F8s50ju9k71p1ZwPAO4Av1bykZb7U4Dj1cE=;
        b=LBt5HYfPUtgeeyBAEdzjzYrTQQ3JB2jQttuEeByxDdyCDWpR3i91A5DCT/fvEPu5/3
         uiW8d5m9pXxKiPvrn7eIpWiJBr1XkRgKvXlBW7iIwK1/5mQd5W0pK1dOSx4CsRoZYK2T
         NH8iQbwWolNnOni3ysIwR70/glvhoT+v71dLgFDeqStx3BaCap/qmqd6S0RmcTYqCReA
         balJqSj2fo0tw+PdWNp2lBwZRe7ND5WZrcqENSfbVsa9baxSqpEW9rJT+bG7IU+lWlBy
         +ddUT/cg9NW3vxRu7e80cR5p9s5ReITP968YE2Gmj5Y1+pe/QEFwzGfM6AbKKzVMRoeC
         jYiw==
X-Gm-Message-State: AOJu0Yz7n/XC4vrnbUGhfUlRxP8E2VRPOvJ7+rhgSQ4XlSPzxfz+44Zg
	1wZD0jhWBhbAfrYADK3Uugmw2yhrE/swHcf3IZaJvpVaHI0cI2e58Xh8lOTuODk=
X-Google-Smtp-Source: AGHT+IFBQpcdVQJpDxZ/TlLOQl91w5TGGNDrZiZmWC5MClEg9c6QlPh8jb8yUjuS+qoWYS4wRLVRcg==
X-Received: by 2002:a05:6870:3749:b0:27d:10f5:347 with SMTP id 586e51a60fabf-28887343aa1mr4749601fac.15.1728940447653;
        Mon, 14 Oct 2024 14:14:07 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-288581dcebbsm2957223fac.27.2024.10.14.14.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 14:14:06 -0700 (PDT)
Message-ID: <ab559026-7e95-4adc-9978-6db30982b2a6@baylibre.com>
Date: Mon, 14 Oct 2024 16:14:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] iio: dac: adi-axi-dac: extend features
To: Angelo Dureghello <adureghello@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-4-eeef0c1e0e56@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-4-eeef0c1e0e56@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extend AXI-DAC backend with new features required to interface
> to the ad3552r DAC. Mainly, a new compatible string is added to
> support the ad3552r-axi DAC IP, very similar to the generic DAC
> IP but with some customizations to work with the ad3552r.
> 
> Then, a serie of generic functions has been added to match with

spelling: series

> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

...

> +static int axi_dac_read_raw(struct iio_backend *back,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +	int err, reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +
> +		if (!st->info->has_dac_clk)
> +			return -EOPNOTSUPP;
> +
> +		/*
> +		 * As from ad3552r AXI IP documentation,
> +		 * returning the SCLK depending on the stream mode.
> +		 */
> +		err = regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
> +		if (err)
> +			return err;
> +
> +		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
> +			*val = st->dac_clk_rate / 2;
> +		else
> +			*val = st->dac_clk_rate / 8;

To get the DAC sample rate, we only care about the streaming mode
rate, so this should just always be / 2 and not / 8. Otherwise
the sampling_frequency attribute in the DAC driver will return
the wrong value when the buffer is not enabled. We never do buffered
writes without enabling streaming mode.

> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, u32 val,
> +				 size_t data_size)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +	int ret;
> +	u32 ival;
> +
> +	if (data_size == sizeof(u16))
> +		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> +	else
> +		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> +
> +	ret = regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know

I'm guessing these got renamed. REG_CNTRL_2 = AXI_DAC_CNTRL_2_REG
and AXI_DAC_CNTRL_DATA_WR = AXI_DAC_CUSTOM_WR_REG?

> +	 * the data size. So keeping data size control here only,
> +	 * since data size is mandatory for the current transfer.
> +	 * DDR state handled separately by specific backend calls,
> +	 * generally all raw register writes are SDR.
> +	 */
> +	if (data_size == sizeof(u8))
> +		ret = regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +				      AXI_DAC_CNTRL_2_SYMB_8B);
> +	else
> +		ret = regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +					AXI_DAC_CNTRL_2_SYMB_8B);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS, reg));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(st->regmap,
> +				       AXI_DAC_CUSTOM_CTRL_REG, ival,
> +				       ival & AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> +				       10, 100 * KILO);
> +	if (ret)
> +		return ret;

Should we also clear AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA on timeout
so that we don't leave things in a bad state?

> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> +}
> +

...

>  static int axi_dac_probe(struct platform_device *pdev)
>  {
> -	const unsigned int *expected_ver;
>  	struct axi_dac_state *st;
>  	void __iomem *base;
>  	unsigned int ver;
> @@ -566,15 +793,26 @@ static int axi_dac_probe(struct platform_device *pdev)
>  	if (!st)
>  		return -ENOMEM;
>  
> -	expected_ver = device_get_match_data(&pdev->dev);
> -	if (!expected_ver)
> +	st->info = device_get_match_data(&pdev->dev);
> +	if (!st->info)
>  		return -ENODEV;
>  
> -	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");

This will break existing users that don't have clock-names
in the DT. It should be fine to leave it as NULL in which
case it will get the clock at index 0 in the clocks array
even if there is more than one clock.

>  	if (IS_ERR(clk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
>  				     "failed to get clock\n");
>  
> +	if (st->info->has_dac_clk) {
> +		struct clk *dac_clk;
> +
> +		dac_clk = devm_clk_get_enabled(&pdev->dev, "dac_clk");
> +		if (IS_ERR(dac_clk))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
> +					     "failed to get dac_clk clock\n");
> +
> +		st->dac_clk_rate = clk_get_rate(dac_clk);
> +	}
> +
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);

