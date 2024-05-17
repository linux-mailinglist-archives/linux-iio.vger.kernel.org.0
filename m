Return-Path: <linux-iio+bounces-5085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432248C81FE
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6703C1C2176F
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C392BD00;
	Fri, 17 May 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw4BhSBa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F122301;
	Fri, 17 May 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932841; cv=none; b=e8Q94Ndx0eeXd4vCY/9Eibguf+1N6zuMrWtg6VBjh+/3IR7xodywPG5fTdY9kaShAD2+81SNpfGqeRKYdmaA7UwlT9O9WubL6RWF+zooztgnu3wmpt+nkeQDrDXoqi7+ixP4Rze7TLaVYvttYJaIHgHcA+bQJvcLhnaLkUMRKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932841; c=relaxed/simple;
	bh=4VHpapHi+PH+rYnOezaLaPm5bmjATK2euB+emCV6fpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbYV0wqmi1n2E2KRTg/h33ZmrqY0J6JD6ytodQI7A1EPufxF/zTcHo6MWwpdWMk3AKn6YLD6ilTHjm3Ru1lY31apkRr0b87FJSdqe1hrxmGOt0tX0IN2Vjzt1849R4N5pt3+dLk5xZVAAm59AtMz9LlTShvEuTW4YCn79egf4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw4BhSBa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a5f81af4so404253466b.3;
        Fri, 17 May 2024 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932838; x=1716537638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WHUQbwGFE5vWk241LLGD7IkNMzFlEX8C8V5LVuH5QU=;
        b=lw4BhSBaqkccRsMm/Z6Sp63Lf/Jl5dQDF663VyJH1AgNpImHd/Q3ZKISpiwpLq7XNj
         KrYpQQywnIZ54eWa6NL8/U+FaNUc905gHk4pvhCqsECarNw9EE5Yb3fjXC/veMLh5g3Y
         9HdoGvjTHc8ocPlXk216AlNXCea0WL4GrgZ6Fmtl1XHBySFBzjm1hpIaK1NQNaIIJs50
         X0jDWus8JbErCfdmyWItd4uuKt41ODdNPSpFuGALQeFMkaQYJaSd8SLs1e2HJcBiyL7E
         mzat7bfVBsEnbvR+IMMcV6cFEaa3W/tjNNTZVb774LOfMd97NbSiTBc45orJS5KiWPCB
         hI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932838; x=1716537638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WHUQbwGFE5vWk241LLGD7IkNMzFlEX8C8V5LVuH5QU=;
        b=G38KC5AIkaJl9qUMyZ7WrKwmlO//Ek/a/vpN8IYQJCHEjfczAnyrsC8ZXv1+dg9BiN
         o6MdHxcPd5cnQdGyRfd2mA2NHsiDERkAKiAl4F1Z6f29lpaSY4u7v4zUtRYr7RC9q0Oo
         11V+Duyh+TKhYHBgNOFPXa9nbmdQfwYSnaehPaLxOM6/LNNCj9lpOt8JM/73q6ox4MC3
         jVsaijlsgRGrurm9yNJOCZF5XzTK9TgCih/r9ltSUt85ZeXJh23kKGytVk/WEerpZtBM
         j9itf7Vzr/XPHXxKGUPYb6MtOrV+Fqv+x2sAAUGKhNjMJNIMOJPPT9853aJ8SG3vuVLd
         ABjw==
X-Forwarded-Encrypted: i=1; AJvYcCX46xloLTwNtSAdxQlOcc+2cwcii4JKPWkh64GcO8tjLiHFCcXY7+a+auU9n91cPCJ6TcSLlQdy1MvUT0QZIo+r+z3QYVEYmnlP8jDs9Y1VxkfUN2j/YHDm84uey8GgKpStzRBRcQ==
X-Gm-Message-State: AOJu0YxK4vf7W4bo/40EJieIbL21wPko7ePJdzHVsTDPuxZS5IEiMjEP
	ox0pNes6bgAnB3UdNf/zDj06XW2X5IVbIU6KRQe9/Zbz5Ko92kR1
X-Google-Smtp-Source: AGHT+IFgPZxrOpJ1GJjTjTxZW6yzslVDP6OCOT/2BnUK6zwhcsGRHrerb5dBzWocqZOIQ3nVNtUchg==
X-Received: by 2002:a17:907:d25:b0:a5a:2aed:ca2b with SMTP id a640c23a62f3a-a5a2d5c9fdcmr1831518366b.28.1715932837421;
        Fri, 17 May 2024 01:00:37 -0700 (PDT)
Received: from ?IPV6:2a02:2f0e:350b:4500:569e:359d:dfe4:922e? ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d10sm1082684266b.198.2024.05.17.01.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 01:00:37 -0700 (PDT)
Message-ID: <ec8174c5-723d-43ad-beaf-0930d1b2c19e@gmail.com>
Date: Fri, 17 May 2024 11:00:36 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] drivers: iio: imu: Add support for adis1657x
 family
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
 <20240508131310.880479-9-ramona.bolboaca13@gmail.com>
 <20240511145447.68de0f59@jic23-huawei>
Content-Language: en-US
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
In-Reply-To: <20240511145447.68de0f59@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> + * device will send the data popped with the (n-1)th consecutive burst request.
>> + * In order to read the data which was popped previously, without popping the FIFO,
>> + * the 0x00 0x00 burst request has to be sent.
>> + * If after a 0x68 0x00 FIFO pop burst request, there is any other device access
>> + * different from a 0x68 0x00 or a 0x00 0x00 burst request, the FIFO data popped
>> + * previously will be lost.
>> + */
>> +static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
>>  {
>>  	struct iio_poll_func *pf = p;
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct adis16475 *st = iio_priv(indio_dev);
>> +	struct adis *adis = &st->adis;
>> +	int ret;
>> +	u16 fifo_cnt, i;
>>
>> -	adis16475_push_single_sample(pf);
>> +	adis_dev_lock(&st->adis);
>> +
>> +	ret = __adis_read_reg_16(adis, ADIS16575_REG_FIFO_CNT, &fifo_cnt);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	/*
>> +	 * If no sample is available, nothing can be read. This can happen if
>> +	 * a the used trigger has a higher frequency than the selected sample rate.
>> +	 */
>> +	if (!fifo_cnt)
>> +		goto unlock;
>> +
>> +	/*
>> +	 * First burst request - FIFO pop: popped data will be returned in the
>> +	 * next burst request.
>> +	 */
>> +	ret = adis16575_custom_burst_read(pf, adis->data->burst_reg_cmd);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	for (i = 0; i < fifo_cnt - 1; i++) {
>> +		ret = adis16475_push_single_sample(pf);
>> +		if (ret)
>> +			goto unlock;
>> +	}
>> +
> My paranoid instincts for potential race conditions kick in.
> Is this one of those annoying devices where the fifo interrupt will only occur
> again if we successfully read enough data to get below the threshold?
> Snag with no public datasheet is I can't just look it up!
> If it's a level interrupt this won't be a problem.
>
> If so the race is the following.
> 1. Interrupt happens, we read the number of entries in fifo.
> 2. We read out the fifo, but for some reason our read is slow... (contention on
>    bus, CPU overheating, who knows).  The data fills up at roughly the
>    same rate as we are reading.
> 3. We try to carry on but in reality the fifo contents never dropped below
>    the watermark, so not more interrupts ever occur.
>
> Solution normally is to put this read sequence in a while (fifo_cnt)
> and reread that after you've done the burst read.  If there is more data
> go around again.  That way we drive for definitely having gotten to zero
> at some stage - and hence whatever the threshold is set to a new interrupt
> will occur.

Hello Jonathan,

Indeed the watermark interrupt is a level interrupt. However adis lib does not 
allow for level interrupts, so I had to create a new patch in v3 to handle it.
Until now I tested the watermark interrupt as and edge interrupt and I did not
see any issues, but indeed if the FIFO is not read fast enough the watermark pin 
will stay high (or low depending on the configured polarity), so the correct 
implementation is to use level interrupts for FIFO watermark interrupts.

Ramona G.


