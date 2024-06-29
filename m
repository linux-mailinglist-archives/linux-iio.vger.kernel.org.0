Return-Path: <linux-iio+bounces-7035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BB91CBD5
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7967928328C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AA3A1BF;
	Sat, 29 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRKm4VBm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2181CF9B;
	Sat, 29 Jun 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719652230; cv=none; b=mk8X63USEThcjyzhzvoS4NJ8bn3j/FbeUz4OVYORZhS++iB6iFi6NrJTn7zh600f1S3AQjWzvGF+84XliY6Xxh3CtE/QWJxnqs/p5WW6NlUUcuvUVJqKfkIZge8NkneiyQ1ZMFGDby4TPFCgJVAZow9NEf4yWXcwr5yVqKuPz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719652230; c=relaxed/simple;
	bh=0qtBIVRF4tQXI/cSqAlbbskNESKysYkhxdb0PY/8yDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQjdH869TgL9fToTeB7ZEQT4fLDdlX0PGxmwqnbGG8faGVfwcx4Aa6F8oMGxVdMKtUmju1lytGUd6SXknYiUa2HZ0dEd/8+o/laIuqMr8xM/TLpiusXdHO9HM/YmlPDifsWS6zRHFjk+nqDLeW8rPJ+1F2i0UFye7WHAjB/TQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRKm4VBm; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec10324791so14546401fa.1;
        Sat, 29 Jun 2024 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719652227; x=1720257027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDwuIDgfSKVVddL+mBAVoNcFHRGflV4dK2Y+ujjCIXA=;
        b=lRKm4VBmALZ1lwmWd9kl8s7BhpQ1bDq6VmvPazHGFUyGy7wpjG8Ujr7lFiuDMxHKdJ
         vH6W6IAkAu4XGiFzm+oUefou3FN0Y/8EJUFoix9Z6BNjF9Uz0+x8j6bDrSiHGB3sl5Zf
         l9oS36SAiMS3UtppSQWDCFK5zOvIj73BuvlYaeeCIvyq7vVKsca9mh9IWz6i193Z+op6
         /gE55GCmSyCL1acnM1SVka3W5MM/QEzNb7z5g+Re9gfCFbSn3jXPDq+kKD2gO+/5edEh
         rUT+7IQSesmPhuRk/VFMrzjdwJA+xLtciYr6Nu9rVGS8+8PRWQCU9nBv4waluvV6Kenu
         pqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719652227; x=1720257027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDwuIDgfSKVVddL+mBAVoNcFHRGflV4dK2Y+ujjCIXA=;
        b=cHUGZN3xL75Wmubc8q1LKtPj38clIDXjxTUuYdvNvLqPkONr/Xve+XfW/f1SYsTavA
         hRjexSklBJifjkfmQKX43T7Qu7MIBVMTlpsidcMst5f8TuWvLUfUemTEZ+zK9pZ+8sZg
         W0+FdLfx9dehTorf9a/2WJXyVw/u9TkxVFIwgeFq+TKCKp4fjcW91QkbGkhgBHkklvhN
         JWvEjONu/0aOFe2r70M8tHz6s/aa2BJCmd5UU/XuICSSLbhyP6d/C1cNCnDcze2MY7Iw
         BrMY0geoij2UMVaVObRisLUhWkkXs7R6Nc6Jiyo42XaBzr5xbZeF/dUm9NSARQBm26OI
         gv9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOXJ6m/hTwGaO2xN8zPuit7xixLc4KQMJTpy09GlXZIpu5EFJaifnGKCOP5XghE7dr34t/Q5IXUsE5jIjjwbeHxURkdZBh/vn4yH6eGZiFZK5Qa3pio5aCv17i6cbQLWZAP6pmVat7RLIiTohDZhpFLSkGdXvBEsVPIJ5vpDZeFer8+w==
X-Gm-Message-State: AOJu0Ywep5Ykz8ylqhtq6MwnaFgYOeGaRrqFbYZO4TNFYlq5zRGKBDiT
	J1m7W+wZM89puix63boqslsbtf00y7/qFpm+dDhQkOk2ARXk7tsIQqpWT+pFY/Y=
X-Google-Smtp-Source: AGHT+IHgFn5RNN+RjMV45lrt6DSLu8SQlEH3qlHL2mcett7FAmuELRstt4JWRiyH9fv8eU/uft1ACQ==
X-Received: by 2002:a2e:7004:0:b0:2ec:556f:3474 with SMTP id 38308e7fff4ca-2ee5e6d76e9mr4611561fa.52.1719652226200;
        Sat, 29 Jun 2024 02:10:26 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:ad19:5100:878e:1e97:29e2:65e0? ([2a01:4b00:ad19:5100:878e:1e97:29e2:65e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf85sm67068815e9.4.2024.06.29.02.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 02:10:25 -0700 (PDT)
Message-ID: <66122c40-9c69-471c-8f59-cfb1c9b0b6ec@gmail.com>
Date: Sat, 29 Jun 2024 10:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: ROHM BH1745 colour sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240625220328.558809-1-muditsharma.info@gmail.com>
 <20240625220328.558809-2-muditsharma.info@gmail.com>
 <20240628203701.507c477c@jic23-huawei>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <20240628203701.507c477c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/06/2024 20:37, Jonathan Cameron wrote:
> Hi Mudit,
> 
> I'd failed on previous reviews to notice the odd trigger in here.
> What is it, because it doesn't seem to be a dataready trigger as the device
> doesn't seem to provide such an interrupt?

Hi Jonathan,

Thank you for your review on this.

I've incorrect called it as a dataready trigger, I missed this as part 
of my initial cleanup - apologies for the confusion caused by this. I 
should potentially call it 'threshold' or 'dev'. Please suggest what you 
think would be appropriate here.

The sensor has an active low interrupt pin which is connected to a GPIO 
(input, pullup). When the sensor reading crosses value set in threshold 
high or threshold low resisters, interrupt signal is generated and the 
interrupt gets handled in 'bh1745_interrupt_handler()' (interrupt also 
depends on number of consecutive judgements set in BH1745_PERSISTENCE 
register)

> 
> Various other comments inline.

Will address all for v7
>
...
>> +static irqreturn_t bh1745_interrupt_handler(int interrupt, void *p)
>> +{
>> +	struct iio_dev *indio_dev = p;
>> +	struct bh1745_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +	int value;
>> +
>> +	ret = regmap_read(data->regmap, BH1745_INTR, &value);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	if (value & BH1745_INTR_STATUS) {
>> +		guard(mutex)(&data->lock);
>> +		iio_push_event(indio_dev,
>> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, data->int_src,
>> +						    IIO_EV_TYPE_THRESH,
>> +						    IIO_EV_DIR_EITHER),
>> +			       iio_get_time_ns(indio_dev));
> 
> What is happening here.  You always push out the event and use that as
> a trigger?  This is an unusual trigger if it's appropriate to use it for
> one at all.  You've called it a dataready trigger but it is not obvious
> that this device provides any such signal.

When an interrupt occurs, BH1745_INTR_STATUS bit is set in the 
BH1745_INTR register. Event is only pushed out when the 
BH1745_INTR_STATUS bit is set.
>> +
>> +		iio_trigger_poll_nested(data->trig);
>> +
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	return IRQ_NONE;
>> +}

Best regards,
Mudit Sharma

