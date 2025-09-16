Return-Path: <linux-iio+bounces-24125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF6B58D8B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 06:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 759324E2A13
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 04:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7A23C4ED;
	Tue, 16 Sep 2025 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzKeQ/k2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF12356D2
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998333; cv=none; b=B7hrWhuL2let4zAIxmQJCV2t+OLam5F8TPM5hUlpgEHFUe6yq7rMMQeyLEHfArwZKZ+S+Xz1iD+3CFQBN7oksFGoDm2VACUWV2AR3pmQRXMNi31WaJcRqPAzhgMX6M5P6OfLq/+rYzW/RES9n5zvBJGu8VVbDS5wD602GO0qmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998333; c=relaxed/simple;
	bh=Bw+sVaY8CU+7cwV8moDBL+RfHtg4QBDwi2G8Pe/+Mq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCtMyxerSxCKK2+WLuSTcqm/0KFUilZ/7koZvrYYmbHo3qLrf7i9gYrjGbQRKLyXONrO1FB+r7B5lUesmLEhmKkz7DvS5YGj0PuYikcs4XIG5tmubixHpO5ilUIozM7RA3P0i6oapJltjadCNycG2hUJcxhmx1ftU47XPqcy86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzKeQ/k2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f98e7782bso6136998e87.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998330; x=1758603130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qV2j4il5ZuIOQndYht3+Fbfog1BTCL9gr5IXcnrc4fE=;
        b=IzKeQ/k2r5BHYZ0OSV41tsDv/xA32nXuK5adQlQWVPDVvIIeCFIKGfXUHRO0psPDQP
         BRO6zcgjInmtyEv2iICubrx3hHivufsB+Y4ufdVBUeDa6Co13472zElGfI4F9V6Ru73z
         X+44FRdFsUo5cUKTX5sVOMmaK5XzIGsQbiL3CDd/vFoLOQqbo+oUHeirdfhVTKa6qD+n
         sqhMLaq008C2tFnUERmB2+qiBSE4vYVQfYsx0kYzaCYK2maRCotqYywG+geRjYXd8kwe
         fK1Lcl73eZm85T2j+fmQp/d6ZY7M0A4LsYcvxlv0YMCy+ac7MCtvjSkD/zJEL3hS66Ka
         pasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998330; x=1758603130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qV2j4il5ZuIOQndYht3+Fbfog1BTCL9gr5IXcnrc4fE=;
        b=ueeXA1USHFbe50nBEwMvAuXi1oXzGSh/eUspmrdxpKkm9qQai1R+vbj556Gl+NRVVJ
         eCLwJh33IotWnUGobffrzk4VbGY0tDPNtYi1dvjqgfNPAZ48p7pw0/2fb/EJyVHb7IhM
         DlWEh3Mk4bxXIwrcd1t6RYHgcMi6RlRM01VUPc6MlxC3jo7xq9xpvG8+vLDxhEKqNJm6
         k8fAkQX0GfqtrFuQUy8v/a/6PfwTCWnsuTuCNDKdZdrLuF0oO58PxSAYkJ9ey/LqJYF9
         TKlfvhn9S3QmcXLTTi0E7sfzxKoKFSLeCAFFqFPd1acF0jHfJ7hTFDOgNL7tvgTuNLkK
         tj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMj8FuGEVj7yYkTIR4I9rxFDsM089rqM5fT+IsIxHU2NwmGLIiRZ+88eWT9dl+AMxPatCHYfVYq3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3q3Wd5sCfGXF6gia7YvXVSK5OvTSUTfZwmOHl2Ynk8KxD9aV
	fTvteDp+iGYisRju2kgEhbfM+yfDlpGlAmwq2+oc+LnC4CmtwMGWSG9A
X-Gm-Gg: ASbGncs8Q8biEQ3QTxVtb7OEsKX5PBEX9UeY/r/YEfqMKinKYdHeorXHsrnICsCs/7x
	gLtjprCMu/5arSlbrFN/7hiPlmkvZwLrHFtILpZhN/nmXfvl1vqqVvm+XAu1u/H0VbhtVfuQksM
	sjfGEntFFBN1lAoLzGXDF1GPmJdRFixTmfl6JQKxjvOQ3F4SEXnM1lqUBuUpHABWyJmtKKrOBdr
	HZWufr8aMQNOhuDWGQCoI9TNRHeOQYHpfeI+2HvoSFWNQgxIJuWpn368gxFGIR8LjVCfqkiPORN
	87WX9+Fp/A+o7mzZqeLxH2sghSCku43AXpSTNtEpoKRPTgu06t04aOahzUmceXqKUj1xnEaT+QN
	liVbmkdvzqxswgbhg0lHa4tGckrJ/YB9dCp/DpiMYrJ0YEQ5tYJu+KaFee2rWkW6tAwL6xFNFgA
	6+5zYJ
X-Google-Smtp-Source: AGHT+IHDfoXUWHL+1d3NPjZRBAKkpSzJMJ4TN4AtBJ3uD/xkbljqRSjaJ2aPZxMrn4mjvSIHt7VAQw==
X-Received: by 2002:a05:6512:acd:b0:55f:400b:1144 with SMTP id 2adb3069b0e04-5763ff929ffmr308937e87.27.1757998329275;
        Mon, 15 Sep 2025 21:52:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6188sm4168144e87.3.2025.09.15.21.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 21:52:08 -0700 (PDT)
Message-ID: <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
Date: Tue, 16 Sep 2025 07:52:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250915211321.47865d3d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 23:13, Jonathan Cameron wrote:
> On Mon, 15 Sep 2025 17:12:34 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:
>>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>>
>>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>>
>>> The IC does also support CRC but it is not implemented in the driver.
>>
>> ...
>>
>>> +static int bd79112_probe(struct spi_device *spi)
>>> +{
>>> +	struct bd79112_data *data;
>>> +	struct iio_dev *iio_dev;
>>> +	struct iio_chan_spec *cs;
>>> +	struct device *dev = &spi->dev;
>>> +	unsigned long gpio_pins, pin;
>>> +	unsigned int i;
>>> +	int ret;
>>> +
>>> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>>> +	if (!iio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	data = iio_priv(iio_dev);
>>> +	data->spi = spi;
>>> +	data->dev = dev;
>>> +	data->map = devm_regmap_init(dev, NULL, data, &bd79112_regmap);
>>> +	if (IS_ERR(data->map))
>>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>>> +				     "Failed to initialize Regmap\n");
>>> +
>>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
>>> +	if (ret < 0)
>>> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
>>
>>> +	data->vref_mv = ret / 1000;
>>
>> I still think moving to _mV is the right thing to do.
>> There is no 'mv' in the physics for Volts.
> 
> I'm not disagreeing with this review but I'm also not going to hold a
> driver back for that given timing is pretty much such that I merge it
> today or it sits a cycle and this one is very near...
> I'll get fussier on this once we have written up some guidance and may
> well send a patch to modify existing recent cases like this one!

As I replied to Andy, I am disagreeing with this. I hope we won't start 
renaming variables with capital letters :(

>>
>>> +	ret = devm_regulator_get_enable(dev, "iovdd");
>>> +	if (ret < 0)
>>> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
>>> +
>>> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
>>> +	data->read_xfer[0].len = sizeof(data->read_tx);
>>> +	data->read_xfer[0].cs_change = 1;
>>> +	data->read_xfer[1].rx_buf = &data->read_rx;
>>> +	data->read_xfer[1].len = sizeof(data->read_rx);
>>> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
>>
>>> +	devm_spi_optimize_message(dev, spi, &data->read_msg);
>>
>> And if it fails?..
> I've added the following and applied the series.

Thanks!

> Note I'm cutting this fine so if we get any build issues or similar
> it might well get pushed back to next cycle yet!
> 
> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
> index b406d4ee5411..d15e06c8b94d 100644
> --- a/drivers/iio/adc/rohm-bd79112.c
> +++ b/drivers/iio/adc/rohm-bd79112.c
> @@ -454,12 +454,18 @@ static int bd79112_probe(struct spi_device *spi)
>          data->read_xfer[1].rx_buf = &data->read_rx;
>          data->read_xfer[1].len = sizeof(data->read_rx);
>          spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
> -       devm_spi_optimize_message(dev, spi, &data->read_msg);
> +       ret = devm_spi_optimize_message(dev, spi, &data->read_msg);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to optimize SPI read message\n");
>   

I am not really sure under what conditions the 
devm_spi_optimize_message() could fail. It might be enough to print a 
warning and proceed, but I don't think returning is a problem either.

Thanks a lot for going an extra mile and taking care of this!

Yours,
	-- Matti

