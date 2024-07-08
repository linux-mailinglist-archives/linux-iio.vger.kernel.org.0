Return-Path: <linux-iio+bounces-7426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F564929E7D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A770282489
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ED4481B9;
	Mon,  8 Jul 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6bqRiAy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB632C1A2;
	Mon,  8 Jul 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428506; cv=none; b=tYc1wMyNHUPiogyJQVfNrT7tzphCyJbkC7/28YnHclufiZw4Yoas4UIuNrQRvz82WvcjlNiDffqWHSkxXNOpCqesbSU/eVjo57n5y6qvfUUWlspWsBaz2LPvFMZVn0rPtJmoFEWmb055jNxYs5V8gxLJ51XSUsadt89P8pUn8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428506; c=relaxed/simple;
	bh=j89VLD2hEjqXGoi9d7zQQszH14rezQoo328mHi9zwrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heMdR/k3q7pOYiW/Dwb/SCyETO+2SaCwPEwQn95mewMVcVds6fThCRXuqyhzkY0RRQPdR2xBTpHkv/DUNcRrRwgazF/rK6YDHotVM12+HU/zh+JbJ7qr/L1FqEuzLJ1Pf62C8dCMFSNicmId7Z2HjxseWm+SeJQuzehle0kjvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6bqRiAy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso18841135ad.3;
        Mon, 08 Jul 2024 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720428504; x=1721033304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4B2Wsl5vKiFV1mOj/I9BhI6pNgvqPrG+Go8BgTc19s=;
        b=C6bqRiAyWQ/sGsh/l1j7VsI16+gvSTeWfsoh6//+wEGoDwgtNQlc8AsfhTtSSjFTOa
         D+eC8GC3IyPqWgAEGsxyxWjCVQwfs/uoqfErwxJGlwCBQ+g/g6KD1cpBnk/bq7PriY6j
         BMnw7LYL7msF6CfMWTTzw7nrqY/uRHjfO6B5CANoWvrYMxpAkK1ZuH9yBa+yzTn5khPb
         sCscCi48v4zxYteLgquqRSobZBgOIELFba9pJ9Y5+kPxOqcl7DWiE2cZhAqVogZmLZr4
         Le08CYyVTldNy52Qz4Zrcwswd+u34V/ECpwKASSSh3pijwcXzybEKppqDWyRBq9Cinxc
         xY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720428504; x=1721033304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4B2Wsl5vKiFV1mOj/I9BhI6pNgvqPrG+Go8BgTc19s=;
        b=PssdpUj4+MbpG9NmutGdHHjcgNU7UpGS11Wg3hlTZoOoCj70mXtyQ4weg3XR5rbD7T
         us/YhqRThu18LRGjKcZHfK4sJjVAxw2eTzrf/FnoTfP+qM7GePzEivgdkcsNe6yqhYCR
         OUzPvvHptCFtVf4zOyXzTKbCPfeHfyQLZYkhY3s/MCKU0XiKEwetIM1fQHGfXGwLce4s
         BYVv1AbF/7d0uWOZ79IwRd0kv5O5RAP+Q4dVPGx/dtlk7/zL6Mx1aEMgDYR5UUpKyUoW
         nGboNkO1LcWnA2IHFGVteAi99yLi+9jzfS0i1pqAyGcvUQrVY1qGGL837At4et6uEv3B
         6cyw==
X-Forwarded-Encrypted: i=1; AJvYcCX4ar71QT/yJ7GtAWO49vwGdUOOxhcIQeZO/BbQwgw/VyJDPAjYn5ewB/RUQ0z1iUS1ilyOKS/qUuK4JLM2SKfMRoTkYZXbycMHxETJK74v/TsRq0bOs+fmIOkTSgMespNtpEBgi9rzSHPC3/eU9U+XfNmq4gImHsUb8AmLEdSDv071TA==
X-Gm-Message-State: AOJu0Yyweowa3IZFwxWBSBaPVQPf2AmOFORQCwbu6wKOKiZPCxf9d9r8
	xQwul6CiVfkoPj54OE2zzRNn6BBjTBapAePVEz9B0KUCmBr7bx3E
X-Google-Smtp-Source: AGHT+IHVuPElm9h1pFTxkxcCC9SYJrc/IzXLM9jlb0B49aytEJLLI4xDMjBCklJ1AJaVl2iFslfMPQ==
X-Received: by 2002:a05:6a20:6a0a:b0:1c2:8f50:b451 with SMTP id adf61e73a8af0-1c28f50c1aemr493803637.20.1720428503863;
        Mon, 08 Jul 2024 01:48:23 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b17f5a2b0sm4406620b3a.9.2024.07.08.01.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 01:48:23 -0700 (PDT)
Message-ID: <21d9a745-da73-48b8-bc20-5522ccbf8896@gmail.com>
Date: Mon, 8 Jul 2024 16:48:15 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 yasin.lee.x@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
 <20240702-add-tyhx-hx9023s-sensor-driver-v9-3-c030f1801d9b@gmail.com>
 <20240707165700.76896f6b@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20240707165700.76896f6b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/7/7 23:57, Jonathan Cameron wrote:
> On Tue, 02 Jul 2024 22:12:34 +0800
> Yasin Lee <yasin.lee.x@gmail.com> wrote:
>
>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> Hi Yasin, A few comments inline, but rather than waste time getting you to do
> a v10, I've made the following modes. Please check them (it wouldn't be the first
> time if I've messed something up with 'trivial' tidy up!)
>
> With this change set applied to the testing branch of iio.git.
> I'll be rebasing on 6.11-rc1 once available at which point this will be in the togreg
> branch and picked up by linux-next.
>
> Thanks,
>
> Jonathan


Hi Jonathan,

I hope this email finds you well.

I wanted to take a moment to express my sincere gratitude for all the 
guidance and feedback you

have provided over the past month. Your suggestions have been 
instrumental in refining and

improving the driver, and I deeply appreciate the time and effort you 
have dedicated to this project.

I have reviewed the recent changes you made, and I am happy to report 
that I agree with all the

modifications. I have verified these changes and confirmed that they are 
correct and effective.

Thank you once again for your invaluable assistance and support 
throughout this process. Your

expertise and willingness to help have been greatly appreciated, and I 
am grateful for the

opportunity to work with you.

Best regards,

Yasin Lee


>
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index e3f3fee2c94a..63e3b56d4f4c 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -312,16 +312,19 @@ static int hx9023s_interrupt_disable(struct hx9023s_data *data)
>   static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
>   {
>   	if (locked)
> -		return regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
> -					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
> +		return regmap_update_bits(data->regmap,
> +					  HX9023S_DSP_CONFIG_CTRL1,
> +					  HX9023S_DATA_LOCK_MASK,
> +					  HX9023S_DATA_LOCK_MASK);
>   	else
> -		return regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
> -					HX9023S_DATA_LOCK_MASK, 0);
> +		return regmap_update_bits(data->regmap,
> +					  HX9023S_DSP_CONFIG_CTRL1,
> +					  HX9023S_DATA_LOCK_MASK, 0);
>   }
>   
>   static int hx9023s_ch_cfg(struct hx9023s_data *data)
>   {
> -	u8 reg_list[HX9023S_CH_NUM * 2];
> +	__le16 reg_list[HX9023S_CH_NUM];
>   	u8 ch_pos[HX9023S_CH_NUM];
>   	u8 ch_neg[HX9023S_CH_NUM];
>   	/* Bit positions corresponding to input pin connections */
> @@ -336,10 +339,11 @@ static int hx9023s_ch_cfg(struct hx9023s_data *data)
>   			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_negative];
>   
>   		reg = (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_neg[i]);
> -		put_unaligned_le16(reg, &reg_list[i * 2]);
> +		reg_list[i] = cpu_to_le16(reg);
>   	}
>   
> -	return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
> +	return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list,
> +				 sizeof(reg_list));
>   }
>   
>   static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)
> @@ -387,17 +391,17 @@ static int hx9023s_read_near_debounce(struct hx9023s_data *data, int *val)
>   static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int *val)
>   {
>   	int ret;
> -	u8 buf[2];
> +	__le16 buf;
>   	unsigned int reg, tmp;
>   
>   	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
>   		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * 2);
>   
> -	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
> +	ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
>   	if (ret)
>   		return ret;
>   
> -	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
> +	tmp = (le16_to_cpu(buf) & GENMASK(9, 0)) * 32;
>   	data->ch_data[ch].thres.near = tmp;
>   	*val = tmp;
>   
> @@ -407,17 +411,17 @@ static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int *val)
>   static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
>   {
>   	int ret;
> -	u8 buf[2];
> +	__le16 buf;
>   	unsigned int reg, tmp;
>   
>   	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
>   		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * 2);
>   
> -	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
> +	ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
>   	if (ret)
>   		return ret;
>   
> -	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
> +	tmp = (le16_to_cpu(buf) & GENMASK(9, 0)) * 32;
>   	data->ch_data[ch].thres.far = tmp;
>   	*val = tmp;
>   
> @@ -608,7 +612,9 @@ static int hx9023s_property_get(struct hx9023s_data *data)
>   				data->ch_data[reg].channel_positive = array[0];
>   				data->ch_data[reg].channel_negative = array[1];
>   			} else {
> -				return dev_err_probe(dev, ret, "Property read failed: %d\n", reg);
> +				return dev_err_probe(dev, ret,
> +						     "Property read failed: %d\n",
> +						     reg);
>   			}
>   		}
>   	}
> @@ -670,7 +676,8 @@ static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
>   	return IIO_VAL_INT_PLUS_MICRO;
>   }
>   
> -static int hx9023s_read_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +static int hx9023s_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
>   			    int *val, int *val2, long mask)
>   {
>   	struct hx9023s_data *data = iio_priv(indio_dev);
> @@ -714,7 +721,8 @@ static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
>   	return regmap_write(data->regmap, HX9023S_PRF_CFG, i);
>   }
>   
> -static int hx9023s_write_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +static int hx9023s_write_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
>   			     int val, int val2, long mask)
>   {
>   	struct hx9023s_data *data = iio_priv(indio_dev);
> @@ -759,10 +767,12 @@ static void hx9023s_push_events(struct iio_dev *indio_dev)
>   	for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
>   		unsigned int dir;
>   
> -		dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +		dir = (data->prox_state_reg & BIT(chan)) ?
> +			IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
>   
>   		iio_push_event(indio_dev,
> -			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir),
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
> +						    IIO_EV_TYPE_THRESH, dir),
>   			       timestamp);
>   	}
>   	data->chan_prox_stat = data->prox_state_reg;
> @@ -869,7 +879,8 @@ static int hx9023s_write_event_config(struct iio_dev *indio_dev,
>   
>   	if (test_bit(chan->channel, &data->chan_in_use)) {
>   		hx9023s_ch_en(data, chan->channel, !!state);
> -		__assign_bit(chan->channel, &data->chan_event, data->ch_data[chan->channel].enable);
> +		__assign_bit(chan->channel, &data->chan_event,
> +			     data->ch_data[chan->channel].enable);
>   	}
>   
>   	return 0;
> @@ -930,7 +941,8 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>   		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
>   	}
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +					   pf->timestamp);
>   
>   out:
>   	iio_trigger_notify_done(indio_dev->trig);
> @@ -992,7 +1004,7 @@ static int hx9023s_probe(struct i2c_client *client)
>   	struct hx9023s_data *data;
>   	int ret;
>   
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>   	if (!indio_dev)
>   		return -ENOMEM;
>   
> @@ -1001,7 +1013,8 @@ static int hx9023s_probe(struct i2c_client *client)
>   
>   	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
>   	if (IS_ERR(data->regmap))
> -		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "regmap init failed\n");
>   
>   	ret = hx9023s_property_get(data);
>   	if (ret)
> @@ -1036,17 +1049,20 @@ static int hx9023s_probe(struct i2c_client *client)
>   		return dev_err_probe(dev, ret, "regcache sync failed\n");
>   
>   	if (client->irq) {
> -		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
> -						hx9023s_irq_thread_handler, IRQF_ONESHOT,
> +		ret = devm_request_threaded_irq(dev, client->irq,
> +						hx9023s_irq_handler,
> +						hx9023s_irq_thread_handler,
> +						IRQF_ONESHOT,
>   						"hx9023s_event", indio_dev);
>   		if (ret)
>   			return dev_err_probe(dev, ret, "irq request failed\n");
>   
> -		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
>   						    iio_device_id(indio_dev));
>   		if (!data->trig)
>   			return dev_err_probe(dev, -ENOMEM,
> -					"iio trigger alloc failed\n");
> +					     "iio trigger alloc failed\n");
>   
>   		data->trig->ops = &hx9023s_trigger_ops;
>   		iio_trigger_set_drvdata(data->trig, indio_dev);
> @@ -1054,11 +1070,13 @@ static int hx9023s_probe(struct i2c_client *client)
>   		ret = devm_iio_trigger_register(dev, data->trig);
>   		if (ret)
>   			return dev_err_probe(dev, ret,
> -					"iio trigger register failed\n");
> +					     "iio trigger register failed\n");
>   	}
>   
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
> -					      hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      hx9023s_trigger_handler,
> +					      &hx9023s_buffer_setup_ops);
>   	if (ret)
>   		return dev_err_probe(dev, ret,
>   				"iio triggered buffer setup failed\n");
> @@ -1087,7 +1105,8 @@ static int hx9023s_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend,
> +				hx9023s_resume);
>   
>   static const struct of_device_id hx9023s_of_match[] = {
>   	{ .compatible = "tyhx,hx9023s" },
>
>
>> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
>> new file mode 100644
>> index 000000000000..e3f3fee2c94a
>> --- /dev/null
>> +++ b/drivers/iio/proximity/hx9023s.c
>> @@ -0,0 +1,1124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
>> + * http://www.tianyihexin.com
>> + *
>> + * Driver for NanjingTianyihexin HX9023S Cap Sensor.
>> + * Datasheet available at:
>> + * http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
>> + */
>
>> +
>> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
>> +{
>> +	u8 reg_list[HX9023S_CH_NUM * 2];
> Array of __le16 seems more appropriate.
>
>> +	u8 ch_pos[HX9023S_CH_NUM];
>> +	u8 ch_neg[HX9023S_CH_NUM];
>> +	/* Bit positions corresponding to input pin connections */
>> +	u8 conn_cs[HX9023S_CH_NUM] = { 0, 2, 4, 6, 8 };
>> +	unsigned int i;
>> +	u16 reg;
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		ch_pos[i] = data->ch_data[i].channel_positive == HX9023S_NOT_CONNECTED ?
>> +			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_positive];
>> +		ch_neg[i] = data->ch_data[i].channel_negative == HX9023S_NOT_CONNECTED ?
>> +			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_negative];
>> +
>> +		reg = (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_neg[i]);
>> +		put_unaligned_le16(reg, &reg_list[i * 2]);
>> +	}
>> +
>> +	return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
>> +}
>> +
>> +static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int *val)
>> +{
>> +	int ret;
>> +	u8 buf[2];
>> +	unsigned int reg, tmp;
>> +
>> +	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
>> +		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * 2);
>> +
>> +	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
>> +	if (ret)
>> +		return ret;
>> +
>> +	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
> Same as below.
>
>> +	data->ch_data[ch].thres.near = tmp;
>> +	*val = tmp;
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
>> +{
>> +	int ret;
>> +	u8 buf[2];
> Why not use an __le16 here?
>
>> +	unsigned int reg, tmp;
>> +
>> +	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
>> +		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * 2);
>> +
>> +	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
>> +	if (ret)
>> +		return ret;
>> +
>> +	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
> then le16_to_cpu() here
>
>> +	data->ch_data[ch].thres.far = tmp;
>> +	*val = tmp;
>> +
>> +	return IIO_VAL_INT;
>> +}
>
>
>> +static int hx9023s_write_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir,
>> +				      int state)
>> +{
>> +	struct hx9023s_data *data = iio_priv(indio_dev);
>> +
>> +	if (test_bit(chan->channel, &data->chan_in_use)) {
>> +		hx9023s_ch_en(data, chan->channel, !!state);
>> +		__assign_bit(chan->channel, &data->chan_event, data->ch_data[chan->channel].enable);
> very long line.
>
>> +	}
>> +
>> +	return 0;
>> +}
>
> ...
>
>> +static int hx9023s_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct hx9023s_data *data;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
> sizeof(*data)
>
> preferred as then I don't need to figure out if there is a match with
>
> data = iio_priv(indio_dev)
>
> below.
>
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	mutex_init(&data->mutex);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
>> +
>> +	ret = hx9023s_property_get(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "dts phase failed\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "regulator get failed\n");
>> +
>> +	ret = hx9023s_id_check(indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "id check failed\n");
>> +
>> +	indio_dev->name = "hx9023s";
>> +	indio_dev->channels = hx9023s_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
>> +	indio_dev->info = &hx9023s_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
>> +				     ARRAY_SIZE(hx9023s_reg_init_list));
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "device init failed\n");
>> +
>> +	ret = hx9023s_ch_cfg(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "channel config failed\n");
>> +
>> +	ret = regcache_sync(data->regmap);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "regcache sync failed\n");
>> +
>> +	if (client->irq) {
>> +		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
>> +						hx9023s_irq_thread_handler, IRQF_ONESHOT,
>> +						"hx9023s_event", indio_dev);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "irq request failed\n");
>> +
>> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
>> +						    iio_device_id(indio_dev));
>> +		if (!data->trig)
>> +			return dev_err_probe(dev, -ENOMEM,
>> +					"iio trigger alloc failed\n");
>> +
>> +		data->trig->ops = &hx9023s_trigger_ops;
>> +		iio_trigger_set_drvdata(data->trig, indio_dev);
>> +
>> +		ret = devm_iio_trigger_register(dev, data->trig);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					"iio trigger register failed\n");
>> +	}
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
>> +					      hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
> Trivial but preferred wrap remains 80 chars unless there is a good reason
> to go longer.
>
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				"iio triggered buffer setup failed\n");
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}

