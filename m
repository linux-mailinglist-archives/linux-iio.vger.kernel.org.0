Return-Path: <linux-iio+bounces-19503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1FCAB5AA5
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AB546392B
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7802BEC56;
	Tue, 13 May 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sYdnMAgN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85A2BEC41
	for <linux-iio@vger.kernel.org>; Tue, 13 May 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155592; cv=none; b=p10pSthWcu5q1D9AkiWMYDhea+hp84sYik62eNUx7dBYWQyQ27tr7wI8mDECSRb3HWSHvK3SDXIfvsG+jMFx0Xr1kBpmQw7q50Hk0uiM+CYeN3N4bT7Ly9j4wxDtJb3/duqLXqZ7vfx752ThfWk9FyNAtxmqVMBSS4CNWV6M1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155592; c=relaxed/simple;
	bh=uTuyj40J4EzBIPZVOkVurxssgICHBMw5W/uQLUIwyzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKS9XWyS6r8XXg2I9BobJ46rn7dO+4s+EF516zpkYyXuDLBqOY9HNW51DysqJIk795WWsy7RJnBJIz51JYLflQuBZrAoK0Ef3vm1WnvP+wTpVYMP3wyMfYb+gVMzSd5pk6rQvnGlafSd9SIVKS1p3+4srMUbdY8hMESUMfsD5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sYdnMAgN; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72b82c8230aso1685136a34.2
        for <linux-iio@vger.kernel.org>; Tue, 13 May 2025 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747155589; x=1747760389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DfNtscBhbXFs2gyDNumFo8Rit0vQ0+JYgK+dk4/zzQ=;
        b=sYdnMAgNrtbrpYcoRQcOzRxyRs1BOd1E7jx60EcFbdcWdCf6mMDRQQsQa3Mj84zsIY
         O1opPIfR7vcWOdOvWFaS1CHu+7xpB7iww0+b4RdELTTJ+7jD0ZtXcQSVOO4lyPz2OyTo
         EUobJk/dn0MCaVaLVxqU9xjkIXIku+FF4K3ATPb5er/wxAyghxOWM5U8/UBp4phSZ8p2
         W3vcqFqMcAyDuxUYUQJGJ5gtYN0EeTcSnNYgza5uOwbBn0iOesIemHTKTAdLOwkSirrL
         d8h+J8Xh1cet3RnfYCZfu4SzfnE2oDk3yLI/h2GoVXUepGSxzwBwkhWAMNftT1Bm2fwI
         MU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747155589; x=1747760389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DfNtscBhbXFs2gyDNumFo8Rit0vQ0+JYgK+dk4/zzQ=;
        b=Px2C+/R4vabfshjpb+6jsAnkB/9rriCc7aJT1Q17YcdBQ2/2zZ0Wrq1YsPvDK3VMlP
         cAsMOn266F2yj8uGX78T0ne4VT9sYOpI7DSyVfADTQUvgz4zhSTdamYlk5b02UdE0vMj
         fVDmqOeXr35VxLe/DL9paEUsx4yHrPD1E7zZYTdYFsj62P7yK8ioiZksGixC829ay+qG
         +kuetvx2s7JuqJDUbdZgMTATAVZAvpuaRmrcsZ8IWgmql3hmvhfJwa/VKJobWhwhKFh3
         3R3OayastNSgDgPxCS6dS3QXhvAFJtUBKaxil7p3JVe9zMiTwzYhTVYCyXg4WqeoJLzQ
         Se4A==
X-Forwarded-Encrypted: i=1; AJvYcCVn1/P1NaA1rPZTU3HPKlas1wPYGs+JHNXkMgh6WQs2PmZfPtVV065oj7C5wKQSbD4T3cf8unpMHrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKLvSzMqWyV4H9Yo2WdLdxCKbdjdscH1eC+3+vWy3WbbV2bDr
	xrfYJEY8HT/ug70VJjVv18PaaMUkSCS6hBfpA0xm5C2egBR7fKd93jl3+OoE2lo=
X-Gm-Gg: ASbGnct4AV9YPOuT/6LnXOQbXVWQiH5vr1V0DWIi0+FY3S4KK65PjZh9ZIcVh32+vyN
	ypCSEn6xbdK7gWLuD+71xGDzlLxkqFzjPcloRIvJ7HyOQNK4Y7HLiAyDHe/5B2gYfDy+8d3e35l
	HTOy4lITBAyPUot0EbpamJ0zOU9QJP0O/bEa10PtywMnBmXiF9dpOL6ok8kfliTwx7xtay2GEl8
	lkK+CCpbgVC/4K/H31Qz90P9NxkK2takScv3zmBH//H1dIzwF0cuUnTjgIwAsCpaIJt6ZJPC67b
	r8wh1lMxiVcJDiRqswln2Gkkfvk2SDN6XuzimNX9GuSNEyocRM5EnCMjDTyxp4AicSUdaPyw8ti
	kdzAqjkQhgbYv/LY5I2KKwy+KyeKFESpM7g==
X-Google-Smtp-Source: AGHT+IFVNY2JHdN9LlKpbP4xRxpGp6jZeIWIg0v3ADYENavUt0i8wtRI/xezBkTrCrcnHm9IYiGWNw==
X-Received: by 2002:a05:6830:6181:b0:72b:98d9:6b2d with SMTP id 46e09a7af769-734e13f2dc9mr10575a34.8.1747155588946;
        Tue, 13 May 2025 09:59:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d74:845a:15c:3fdc? ([2600:8803:e7e4:1d00:d74:845a:15c:3fdc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d59e1sm1987311a34.34.2025.05.13.09.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 09:59:48 -0700 (PDT)
Message-ID: <af53ae18-d997-4afa-a3e5-7ff5f624bdc3@baylibre.com>
Date: Tue, 13 May 2025 11:59:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] iio: adc: ad4170: Add clock provider support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 marcelo.schmitt1@gmail.com
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <a0d049e5fbab5cdeff266da886fd765b2b0d1af1.1747083143.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a0d049e5fbab5cdeff266da886fd765b2b0d1af1.1747083143.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/13/25 7:35 AM, Marcelo Schmitt wrote:
> The AD4170 chip can use an externally supplied clock at the XTAL2 pin, or
> an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
> the AD4170 can provide its 16 MHz internal clock at the XTAL2 pin. Extend
> the AD4170 driver so it effectively uses the provided external clock, if
> any, or supplies its own clock as a clock provider.

Is support for CLKDIV intentionally omitted? Might be worth mentioning
if that is the case.

> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

...

> @@ -329,6 +348,9 @@ struct ad4170_state {
>  	struct completion completion;
>  	int pins_fn[AD4170_NUM_ANALOG_PINS];
>  	u32 int_pin_sel;
> +	struct clk_hw int_clk_hw;
> +	struct clk *ext_clk;

This isn't used outside of ad4170_clock_select() so can be made a local variable there.

> +	unsigned int clock_ctrl;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
>  	 * to live in their own cache lines.
> @@ -1656,6 +1678,120 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static struct ad4170_state *clk_hw_to_ad4170(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ad4170_state, int_clk_hw);
> +}
> +
> +static unsigned long ad4170_sel_clk(struct ad4170_state *st,
> +				    unsigned int clk_sel)
> +{
> +	st->clock_ctrl &= ~AD4170_CLOCK_CTRL_CLOCKSEL_MSK;
> +	st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, clk_sel);

Do we need to claim direct mode here to avoid poking registers during
a buffered read?

> +	return regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
> +}
> +
> +static unsigned long ad4170_clk_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	return AD4170_INT_CLOCK_16MHZ;
> +}
> +
> +static int ad4170_clk_output_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad4170_state *st = clk_hw_to_ad4170(hw);
> +	u32 clk_sel;
> +
> +	clk_sel = FIELD_GET(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, st->clock_ctrl);
> +	return clk_sel == AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT;
> +}
> +
> +static int ad4170_clk_output_prepare(struct clk_hw *hw)
> +{
> +	struct ad4170_state *st = clk_hw_to_ad4170(hw);
> +
> +	return ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);
> +}
> +
> +static void ad4170_clk_output_unprepare(struct clk_hw *hw)
> +{
> +	struct ad4170_state *st = clk_hw_to_ad4170(hw);
> +
> +	ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT);
> +}
> +
> +static const struct clk_ops ad4170_int_clk_ops = {
> +	.recalc_rate = ad4170_clk_recalc_rate,
> +	.is_enabled = ad4170_clk_output_is_enabled,
> +	.prepare = ad4170_clk_output_prepare,
> +	.unprepare = ad4170_clk_output_unprepare,
> +};
> +
> +static int ad4170_register_clk_provider(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct clk_init_data init = {};
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))

Driver depends on COMMON_CLK so isn't this dead code?

> +		return 0;
> +
> +	if (device_property_read_string(dev, "clock-output-names", &init.name)) {
> +		init.name = devm_kasprintf(dev, GFP_KERNEL, "%pfw",
> +					   dev_fwnode(dev));
> +		if (!init.name)
> +			return -ENOMEM;
> +	}
> +
> +	init.ops = &ad4170_int_clk_ops;
> +
> +	st->int_clk_hw.init = &init;
> +	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					   &st->int_clk_hw);
> +}
> +
> +static int ad4170_clock_select(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;

Would make more sense to move this inside of the if (ret < 0) instead of
writing over it later.

> +	ret = device_property_match_property_string(dev, "clock-names",
> +						    ad4170_clk_sel,
> +						    ARRAY_SIZE(ad4170_clk_sel));
> +	if (ret < 0) {
> +		/* Use internal clock reference */
> +		st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
> +					     AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);

Seems like we would want to start in the AD4170_CLOCK_CTRL_CLOCKSEL_INT state.

Also, could skip registering clock provider if #clock-cells is not present.

> +		return ad4170_register_clk_provider(indio_dev);
> +	}
> +
> +	/* Use external clock reference */
> +	st->ext_clk = devm_clk_get_enabled(dev, ad4170_clk_sel[ret]);
> +	if (IS_ERR(st->ext_clk))
> +		return dev_err_probe(dev, PTR_ERR(st->ext_clk),
> +				     "Failed to get external clock\n");
> +
> +	st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
> +				     AD4170_CLOCK_CTRL_CLOCKSEL_EXT + ret);
> +
> +	st->mclk_hz = clk_get_rate(st->ext_clk);
> +	if (st->mclk_hz < AD4170_EXT_CLOCK_MHZ_MIN ||
> +	    st->mclk_hz > AD4170_EXT_CLOCK_MHZ_MAX) {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid external clock frequency %u\n",
> +				     st->mclk_hz);
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad4170_parse_firmware(struct iio_dev *indio_dev)
>  {
>  	struct ad4170_state *st = iio_priv(indio_dev);
> @@ -1663,7 +1799,13 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
>  	int reg_data, ret;
>  	unsigned int i;
>  
> -	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
> +	ret = ad4170_clock_select(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup device clock\n");
> +
> +	ret = regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
> +	if (ret)
> +		return ret;

Why not just do the regmap_write() in ad4170_clock_select() to keep it all
together?

>  
>  	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
>  		st->pins_fn[i] = AD4170_PIN_UNASIGNED;


