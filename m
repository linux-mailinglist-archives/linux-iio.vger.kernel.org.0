Return-Path: <linux-iio+bounces-12562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382AD9D6B8B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 22:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A526B21B4E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 21:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C81A3047;
	Sat, 23 Nov 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw22ZbTb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EE1494CC;
	Sat, 23 Nov 2024 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732396524; cv=none; b=WiR4/L+Huz9GBuMAiWzXG+dNs9MWnhDq1oMt3VhovCD9jvAXzK/c78zoTQXlw8zBxA9cw63lcVKSTu6KivWLsY6Qly/XgOxEP+Qv7CftyPbxDS8HXC/5krL64JaqKO3tpgDo0GYN1tQ4m7fH0zyPQtpvxxfem0z9Mm65ZFhdHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732396524; c=relaxed/simple;
	bh=ZiZ5QC7LM3xk1NI/6UUKdrVPEJ7thc91R0QDslL4haI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbvY9g0Itfp56odXOrQT7jzW/wcYHuExEhIC1hv8+Vbl1T6T3I73eBW5Kq3eueRZoiPVF1Ah6EZj85kEm/k6WZ/NEBsUHyFtNJNk02aDO/mPCHZQYuisMFAH0KAElt94YbGruo0jxI66ne2OgB5OSjHa/IC14J40+CyY/mOqR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw22ZbTb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3825c05cc90so2031022f8f.1;
        Sat, 23 Nov 2024 13:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732396519; x=1733001319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CXVJLyOxJhLtqu1XjgB0j6s1+0c14IZn1U3KJhAAHY=;
        b=Kw22ZbTb7Xd/RIz2SXgYmLYv5u7IEJMUzZEr+1bzM//4BsRM6TNcu2cpygx2+HU6us
         0s63fg2lzasbIGMJ0kEdUZGrFeAkLQcI9LGhwSjWlejzwKPZIKxUdfc4v66Cns8JtZLr
         Ayz6NYb609qgIBhY3/Iq+ONA2uFnb+bKI6sKxoft4CHqhlRdj9DJ1AiwibX66mWWXZ+K
         KTqR+A1RW3itC0kkBWbFiVhkk0PYzLYjKS5rlxEaze0+62bjpC0tDczYMsuFC7l/FxAD
         MicH/zZ4SzCllErABbGyBeSxH5oezLLcPuhE5UmENAyAAxnmhPuJGhJs6dFXdUQ5XuaS
         3g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732396519; x=1733001319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CXVJLyOxJhLtqu1XjgB0j6s1+0c14IZn1U3KJhAAHY=;
        b=myBs7EkcKi5/E52TXN4wZe1BXNiO+NePOgjeX8vq7nGdBcFj2Px1iDeak11F5924ug
         jVk6gjXjnoqyf0QdRk0tSVhDvxDA0p1Xphtth1P8o82OBvzGAtVGrm1oQMPFhL4wqSYE
         YPdyuMNjNXiNLZiUA7zJcJVV4VCcsMJDtBwbAS/gJUyaYGZp88ph8nIqNA24DwFdQW5O
         dMePQo0bp0fAwa0gU6+3oHEVRloijX5qCiHmJ8+Kr7HoJ1gegOce1g+CtdV9DhhOyJGo
         5Sd225df3fVWwEavKVwXgsMqKmcfOO72mekGtEsL0Hp89ABBerRC10e/boeQKuaAeIoQ
         G+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1d7U+V78/Iu/jZJuKCtefT0z7pvDZ+9C72En9UPNCMTySYDR4IZ/YkJdeIdX3Iky7dRmS8x+DsJs=@vger.kernel.org, AJvYcCXoy7wUxv86c/yUsw/sDvUnkQjRTYIUoAtQmBXTLh8y/nOHhrWmT0k8M4Ie1ri7eCVsKeaYIB9TQgRfKLU5@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXNIX5radjwuCWn8d0FjqwWjm9rH1ZpzAqRUiGuj4Ty79EpIV
	Mmwt6yNhZoszQy/RMlslINIuVAvR/aE9unScUz3qH8S2nEr7kk/C
X-Gm-Gg: ASbGncsOP1ls4xQ2MWiAcSPTOyzftwxLiWe2t5oVXmTNe4nfWnXjlGHmQgk6UJbfJUR
	rpzN6AMQ5gpkzJVZil32xTutXsHOSvCVlKkd3i+8zcPbWtEURp2rm6lNMT+i70hvO6PLqQ2lVXg
	/mKx50PDavx18sIt5d1EaS2niq/V0Zf5/iXycfVhlLP3uUuFDf696d5LBRWmpg+9tdjetE69WGq
	NgJ2Pr96WXuEZwJw8PPfzNBRiBuyCKdhr/bUXQyBDeiioNYOXKWZq4IR3OGvSlCTRaengT1cVfu
	UysV4bozS3BYQ6BjtD6eFr0iTArW7WKl3/DQ1OylWZyOJ7RJGPzZIX/RUoqJBoQbG8gfIo5J/px
	xyblaYC3Fq6AmaDoerR98H3sx4VpBrhnXXuWjFaFpP2U=
X-Google-Smtp-Source: AGHT+IGi/Aoi8pQi3uPAzc2gRdaQ0dkdhgpFdz5ZM28/5PH0rfDIYyv6oyBUKzTdrQUugJgYzacPyg==
X-Received: by 2002:a05:6000:2802:b0:382:51ae:754f with SMTP id ffacd0b85a97d-38260b486c1mr4080524f8f.8.1732396519004;
        Sat, 23 Nov 2024 13:15:19 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:81b7:86b5:dd8f:cb89? (2a02-8389-41cf-e200-81b7-86b5-dd8f-cb89.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:81b7:86b5:dd8f:cb89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbed99dsm6093822f8f.94.2024.11.23.13.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 13:15:18 -0800 (PST)
Message-ID: <1f5d62d0-42af-4eda-846d-cd0d57b5c6d5@gmail.com>
Date: Sat, 23 Nov 2024 22:15:11 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: veml6030: add support for triggered buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241110-veml6030_triggered_buffer-v2-1-ecda3b6ed77f@gmail.com>
 <20241123151634.303aa860@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241123151634.303aa860@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2024 16:16, Jonathan Cameron wrote:
> On Sun, 10 Nov 2024 18:49:05 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> All devices supported by this driver (currently veml6030, veml6035
>> and veml7700) have two 16-bit channels, and can profit for the same
>> configuration to support data access via triggered buffers.
>>
>> The measurements are stored in two 16-bit consecutive registers
>> (addresses 0x04 and 0x05) as little endian, unsigned data.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Hi Javier,
> 
> We have to be a little careful with pushing data from the stack.
> Need to makes sure holes are zero filled.
> 
> Jonathan
> 
>> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
>> index ccb43dfd5cf7..ce9af9a0e933 100644
>> --- a/drivers/iio/light/veml6030.c
>> +++ b/drivers/iio/light/veml6030.c
> 
>>  
>>  static const struct regmap_config veml6030_regmap_config = {
>> @@ -889,6 +928,35 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static irqreturn_t veml6030_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *iio = pf->indio_dev;
>> +	struct veml6030_data *data = iio_priv(iio);
>> +	unsigned int reg;
>> +	int ch, ret, i = 0;
>> +	struct {
>> +		u16 chans[2];
> There is a hole here... 
>> +		aligned_s64 timestamp;
>> +	} scan;
>> +
>> +	iio_for_each_active_channel(iio, ch) {
>> +		ret = regmap_read(data->regmap, VEML6030_REG_DATA(ch),
>> +				  &reg);
>> +		if (ret)
>> +			goto done;
>> +
>> +		scan.chans[i++] = reg;
> This fills in at least 1 channel, but maybe not the second.
>> +	}
>> +
> So this leaks random stack data I think.
> 
> Upshot, when holes are involved or not all the channels are set, need
> memset(&scan, 0, sizeof(scan));
> for the structure on the stack which will zero the holes as well as
> both channels.
> 
> Ancient article on this: https://lwn.net/Articles/417989/
> 
> We get away with it when they are in the iio_priv space because they are
> kzalloc + if we do leak data due to changes in configured channels it's
> just old sensor data which is (I think) never a security problem!
> 
>> +	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
>> +
>> +done:
>> +	iio_trigger_notify_done(iio->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int veml6030_set_info(struct iio_dev *indio_dev)
>>  {
>>  	struct veml6030_data *data = iio_priv(indio_dev);
>> @@ -1077,6 +1145,12 @@ static int veml6030_probe(struct i2c_client *client)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
>> +					      veml6030_trigger_handler, NULL);
>> +	if (ret)
>> +		return dev_err_probe(&client->dev, ret,
>> +				     "Failed to register triggered buffer");
>> +
>>  	return devm_iio_device_register(&client->dev, indio_dev);
>>  }
>>  
>>
>> ---
>> base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
>> change-id: 20241106-veml6030_triggered_buffer-a38886ca4cce
>>
>> Best regards,
> 


Hi Jonathan,

thanks a lot for your explanation and the link, it makes perfect sense.
By the way, when I moved this struct from the iio_priv to the function,
I took a look at some existing code, and a couple of them might have the
same issue:

- temperature/tmp006.c: it also has a hole between the two 16-bit
channels and the timestamp (aligned(8)), but it is not set to zero.

- adc/ti-ads1119.c: the scan consists of an unsigned int and the
timestamp (aligned(8)). I believe there is a hole there as well.

I did not go over all drivers (most of them store the scan struct in the
iio_priv space anyway), but at least those two look suspicious.

Should I fix (e.g. memset) those two I mentioned?

Best regards,
Javier Carrasco


