Return-Path: <linux-iio+bounces-7712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD9937A46
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978C61C2156C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB614534D;
	Fri, 19 Jul 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0PlEMtb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E9443D;
	Fri, 19 Jul 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404979; cv=none; b=DhQSEyaTLUOlNCPz8i6ygnuvWG8BF39pyZx2HrrG7lfkcLhwwlbwVUTlaiNG4DPEWYoRCadqn7FrE0Eq/ZcYkDxqJwhIujHDjdz62Da/SUn+sB8hKg+iMgkXIVA0/7NeNllO760qRid0Hg4snNEmwYl7DX9wTfDzM6gG/e4aHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404979; c=relaxed/simple;
	bh=xyf5t5DYMcXFWBOn8t+457VrYylNBONEjjhrzva6Rb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frlUdBbeBvwD//PqWvwQBu67/7SHUCSeG6NsdBkEUAbuidcOF2dSXhoRwXv7e524rRc+MhBv01nuxXcSiJ4vlwiEAgDGsYHcJDKRN6NU9ClS/U5DHzDePSs4FL8Bb6uDm8wsOEZfHDG9Q0ObktH+EBDhKd1vt/3h0vJU/F5af7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0PlEMtb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eee083c044so24584781fa.3;
        Fri, 19 Jul 2024 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721404976; x=1722009776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaB0iGzq6RUpv6NX934es+Rd+TyRUjeRwJAupwsTKns=;
        b=I0PlEMtbW8kh6gYkt7hbKE9RB2Jrx9RNlxgwl48KvaGEsmHruKdaI2G2v8O4qdZVIZ
         KPrn/tqXamNmh6TTxgRJ/NWWdBnO+LUdJq0GdkvriONo9y/YRB/FFGb+HEsHzaoXFqaI
         3wVCd+enWhp8Yn2BM3Y+WFcLkIgo07/IUyXRT2vHN89koY1OXdMYAgF++XmtvJjcBYHF
         zSKWpSCM7v1HHJ1M1Ng5WhIPcrPBRSMMbYrGa7SoqhEoDmBFIJv7vSp1RVhTSE2uBwSa
         l7qUF47TXrAxPwdYfUp6evc0xnHXcYvFRzv3WulUmjuTM7LSuRSWKRmlO0D7HXiLPrIE
         H1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721404976; x=1722009776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaB0iGzq6RUpv6NX934es+Rd+TyRUjeRwJAupwsTKns=;
        b=DMGTQX57A3P+EdX6Mn8C1zecJMjhkxlMCb1YrTJLR+ghTwCVoSM8LoyrMaeNqUMPfB
         wLfR7gaABTwUN+eztNeBW4BO/ZA16s5CcK6Eup335S8Eis0P9h3gIas0gLcjOjSG7swT
         oI9xLPK7zVEN2miuT6GWYrpbwJ5P4fDmkSkui+hr93StE3SA8H1NLN6j9MiIF4+LYWM3
         vmo25e+x2vjzDs8PlGLzabv2LL/qf16L7trq1s2CmC6iAI6Astsic+b6eyp9jmDlCxm6
         GS5ixoHcV7j8w5zMqGp0CtI/JJdIWT9sRs8DXdLbsNOZCujwTMIGdhFs8x9l0OLOn8gX
         jpYg==
X-Forwarded-Encrypted: i=1; AJvYcCWDYbB+pEaeyOy3/JGflVs/Rgr74yzvft0y4a/dx21hRSk+QMTkNxMKf451aHfwVcYnX/FC2tvz3bdgL6yiVPRM8dqRF7Mz6i2TqCi54Nj/ZjHtmsv0BpbAkWUKL9uVW9IAgcUytQ==
X-Gm-Message-State: AOJu0Yx11h5T/vJ20zFjp9DZDLndOT0fD7c0QXjOCgZ3dXpZ5YA86doN
	cje4o9Z1xkQlz4CssaOAP8eYekoQXMEsDbcc50mGfm5yOU95Lyyt
X-Google-Smtp-Source: AGHT+IEjOeTjmTYH881C/sqCw+ii4oMQtQBcTy78cOCGWHk7TqsLcCJMcfqRjXfK1zPz9WCx/FymAg==
X-Received: by 2002:a2e:9f48:0:b0:2ee:bcf3:2686 with SMTP id 38308e7fff4ca-2ef167a2c59mr1424531fa.21.1721404957558;
        Fri, 19 Jul 2024 09:02:37 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:a592:c0b4:f0d9:922c? (2a02-8389-41cf-e200-a592-c0b4-f0d9-922c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a592:c0b4:f0d9:922c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e47csm56284435e9.29.2024.07.19.09.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 09:02:37 -0700 (PDT)
Message-ID: <2505dee2-c503-4566-a4ef-73103da9479d@gmail.com>
Date: Fri, 19 Jul 2024 18:02:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Ivan Orlov <ivan.orlov0322@gmail.com>
References: <20240718220208.331942-1-muditsharma.info@gmail.com>
 <20240718220208.331942-2-muditsharma.info@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240718220208.331942-2-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/07/2024 00:02, Mudit Sharma wrote:
> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> Interrupt source for the device can be configured by enabling the
> corresponding event. Interrupt latch is always enabled when setting
> up interrupt.
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Mudit,

a couple of nitpicks inline.

...


> +static int bh1745_set_int_time(struct bh1745_data *data, int val, int val2)
> +{
> +	struct device *dev = data->dev;
> +	int ret;
> +	int value;
> +	int current_int_time, current_hwgain_sel, current_hwgain;
> +	int new_hwgain, new_hwgain_sel, new_int_time_sel;
> +	int req_int_time = (1000000 * val) + val2;
> +
> +	if (!iio_gts_valid_time(&data->gts, req_int_time)) {
> +		dev_dbg(dev, "Unsupported integration time requested: %d\n",
> +			req_int_time);
> +		return -EINVAL;
> +	}
> +
> +	ret = bh1745_get_int_time(data, &current_int_time);
> +	if (ret)
> +		return ret;
> +
> +	if (current_int_time == req_int_time)
> +		return 0;
> +
> +	ret = regmap_read(data->regmap, BH1745_MODE_CTRL2, &value);
> +	if (ret)
> +		return ret;
> +
> +	current_hwgain_sel = FIELD_GET(BH1745_CTRL2_ADC_GAIN_MASK, value);
> +	current_hwgain = iio_gts_find_gain_by_sel(&data->gts, current_hwgain_sel);
> +	ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, current_hwgain,
> +						     current_int_time, req_int_time,
> +						     &new_hwgain);
> +	if (new_hwgain < 0) {

Typo in debug message: corresponding. I would recommend you to pass
codespell to checkpatch. It will often catch such things.

> +		dev_dbg(dev, "No corrosponding gain for requested integration time\n");
> +		return ret;
> +	}
> +

...

> +static int bh1745_write_raw_get_fmt(struct iio_dev *indio_dev,

Nit: the alignment seems to be a bit off here.

> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...


> +static int bh1745_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, int state)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int value;
> +
> +	if (state == 0)
> +		return regmap_clear_bits(data->regmap, BH1745_INTR, BH1745_INTR_ENABLE);
> +
> +	if (state == 1) {

Nit: empty line at the beginning of the scope.

> +
> +		/* Latch is always enabled when enabling interrupt */
> +		value = BH1745_INTR_ENABLE;
> +
> +		switch (chan->channel2) {
> +		case IIO_MOD_LIGHT_RED:
> +			return regmap_write(data->regmap, BH1745_INTR,
> +					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +							       BH1745_INTR_SOURCE_RED));
> +
> +		case IIO_MOD_LIGHT_GREEN:
> +			return regmap_write(data->regmap, BH1745_INTR,
> +					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +							       BH1745_INTR_SOURCE_GREEN));
> +
> +		case IIO_MOD_LIGHT_BLUE:
> +			return regmap_write(data->regmap, BH1745_INTR,
> +					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +							       BH1745_INTR_SOURCE_BLUE));
> +
> +		case IIO_MOD_LIGHT_CLEAR:
> +			return regmap_write(data->regmap, BH1745_INTR,
> +					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +							       BH1745_INTR_SOURCE_CLEAR));
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> 

Best regards,
Javier Carrasco

