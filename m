Return-Path: <linux-iio+bounces-24124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3FFB58D0B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 06:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F26A5247C9
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 04:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C67242D60;
	Tue, 16 Sep 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOkH/q82"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DF2248AE
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998089; cv=none; b=FGnaYcRplc5lZZmsZS1zJp/KC0btCudRUYr6pL/YnEAaAYZTf3/wRGYNGvvtX5+lZNJK+rKi/otWWfJpnVDKab2qK+xBZrAh4eXgtERUPwW6TReTCQA9WDubaVM1fst+4Cv8ZnEhZG8T0YAMavJYM1hFmT84kwLMpwPLd7wiBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998089; c=relaxed/simple;
	bh=4lljxmCPotEpCOZhE7upKppTMYl9dHu/d2b81w17SEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/GXTtLfuJ/Ye5nYMiB8gyStdvS+3LtzP6C78oviLB+ma0pD/OzTbMEtzIM1bOpMYkE/caEWY4EfhT8Ovby3SM9R0S/PPOoNXmUoyzx0Uw+EWY7661wD1KIUhMo2SLHSonzaHLJb5U8/eUEYjalqJj86NcwsqXK5HVy80mM0vr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOkH/q82; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso4898200e87.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 21:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998085; x=1758602885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nva31CQb9RnyQWaIyMrnWR4lvFSnR44SZz1OrBIg3bw=;
        b=mOkH/q82NRjqy6+0jm7e27z0/deUYJZHoFFGa6b7ewSKl1beyBCmJEPj3besC2vufb
         IPV0XQuV+XyRnjatgOwReU0Xu4dTvRJiiXRgw/LlIoSlFmbt+TMTksTbzMlWGcGtJB/Y
         tktH2rSyfAKIcVVDxTL4mwCOHXV7WvNtGTFahChQa4R11qiMego+ljmD6d7IiDTnpBnV
         05Ae+x8goyOyQvdFjIJjhjVQc6dF2F8bmEHEDn3nMhwMvidhB04oF1w40OiZehJwrLcj
         ew+M1slSleRkpF0tUOk12llcpm0s7sjzdY0gnpFg4uM4ndmfQ1iU8vQCI1MLHvo78RrH
         7nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998085; x=1758602885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nva31CQb9RnyQWaIyMrnWR4lvFSnR44SZz1OrBIg3bw=;
        b=mKZHJ2XOTwXEHYHPsAxxYf2WsLV+kRAhgfpN3jpuiR1rsZ5U7Pkui0l2JiDpDi4u6s
         eIJnpabFnuJso3hIxrRnIcnvJcEs6T5Rg4/jLCCfpENXtby6qf/Eq4tMTXvwNssVCIGB
         K5YGVrQKIC6ItO7pgYDg6Q3p1crb8SretjFFXQ1qKSpwW/hRLCt+XV2JMjfVQ77LFymT
         nrHEvxFFcw+w7OXI1QbfFPvaC1cAqYuUD0oX5ZvtdZTIyT8AfuLyD+mQz7HnU7snSh9u
         DT2YiRHci7bJZd/5dc1csIvg1crZgBu4dQj6UJiRND9FnW+noaapChqM0vbsJKCVbOm2
         QLlw==
X-Forwarded-Encrypted: i=1; AJvYcCWlpKpp20np5tERO4C0cSolFFv4Se8c+gXafMce8gMVdlQb0V9WSemsv/ZnwGn05xk99KGtkaTKnUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVAXAe0FLrD7TGUzHjbLeXnOenJvrqbNjS2QpP0RYnBArqSJ4
	CBxFP3TSuYknKP5flkQKWrnJVoIWKqDr8cpfp8ykKT8UU23OhxGHpMyd
X-Gm-Gg: ASbGncsTa/QtMD1i8T43pC9UUh+Je4RG9J+/zClmBiL//WzfmaDU/G8r5L1ROWrSiNR
	8N5EogEZSd8ZAe612d6JUXr2baZZ6tzIdU2GTkk1ylcA9FJFPFBONNOu93lTC8TkpOX8vTGwUuC
	YzZ7zFFIfmzx7SYwPY28yphuylanOE6DeHuMTlbi+itGTB0O+UvJB+IBsYl98Ok4fXZBjuhif6e
	6a9DqhDkGBXZ7mvWvasNDrvrHzS83EKV28NG5joruDB2AjdY4t9jaYGqBxC9xpliDNoYZ9pK2mh
	ZAuYSQLhmrTpBYZnq+8Y4DA/aD5Eexz6dd7GpgELLdHwPsATDVnE/7FQ9aZr1bTJsuSIoZ4tIq1
	Xx4/0Zv1c35GdkvAog+gNMRzkTqlOcvHK0wc/njip7WtSJ0xyEgYHnoC2TPSCqBvsd3ooNYaoCy
	JCtQG3
X-Google-Smtp-Source: AGHT+IHo4ALErq+Xx1bjNqpiiFLemDYjjyezLrlBYACjFEDZuKcuTSOA/KJFI2YP161fK5ZvVyw5EA==
X-Received: by 2002:a19:6a13:0:b0:56a:4f7:6756 with SMTP id 2adb3069b0e04-5704a3e6c5cmr3236714e87.9.1757998085119;
        Mon, 15 Sep 2025 21:48:05 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460d4b5sm4179446e87.97.2025.09.15.21.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 21:48:04 -0700 (PDT)
Message-ID: <0b97adc3-4d77-480f-ace9-a53403c62216@gmail.com>
Date: Tue, 16 Sep 2025 07:48:03 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aMge0jYwYCiY72Yb@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 17:12, Andy Shevchenko wrote:
> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:
>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>
>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>
>> The IC does also support CRC but it is not implemented in the driver.
> 
> ...
> 
>> +static int bd79112_probe(struct spi_device *spi)
>> +{
>> +	struct bd79112_data *data;
>> +	struct iio_dev *iio_dev;
>> +	struct iio_chan_spec *cs;
>> +	struct device *dev = &spi->dev;
>> +	unsigned long gpio_pins, pin;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!iio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(iio_dev);
>> +	data->spi = spi;
>> +	data->dev = dev;
>> +	data->map = devm_regmap_init(dev, NULL, data, &bd79112_regmap);
>> +	if (IS_ERR(data->map))
>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>> +				     "Failed to initialize Regmap\n");
>> +
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
> 
>> +	data->vref_mv = ret / 1000;
> 
> I still think moving to _mV is the right thing to do.
> There is no 'mv' in the physics for Volts.

I can see you think so :) For me it doesn't look good. This is in-kernel 
C-code not physics textbook. For the kernel C it has been convention to 
_not_ use capital letters (or CamelCase) for variables. This convention 
is strong enough reason for me to avoid mV in a variable name because 
the capital letter instantly requires my attention and makes me need to 
consider if this is "just a variable". What comes to the vref_mv, there 
really are no true downside. It is clear what the _mv suffix denotes and 
"there is no 'mv' in physics" is really an artificial problem.

>> +	ret = devm_regulator_get_enable(dev, "iovdd");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
>> +
>> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
>> +	data->read_xfer[0].len = sizeof(data->read_tx);
>> +	data->read_xfer[0].cs_change = 1;
>> +	data->read_xfer[1].rx_buf = &data->read_rx;
>> +	data->read_xfer[1].len = sizeof(data->read_rx);
>> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
> 
>> +	devm_spi_optimize_message(dev, spi, &data->read_msg);
> 
> And if it fails?..

I am not really sure under what conditions this would fail. Without 
taking a further look at that - then we just use unoptimized SPI 
transfers(?). Could warrant a warning print though.

Thanks for taking a look at this again :)

Yours,
	-- Matti




