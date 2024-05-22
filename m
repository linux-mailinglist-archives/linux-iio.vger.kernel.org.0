Return-Path: <linux-iio+bounces-5167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7280A8CBE92
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF171F21E09
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E748172D;
	Wed, 22 May 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hexJVvVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9058121F;
	Wed, 22 May 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371505; cv=none; b=FMc+M8alBuJsIep+5ui0XSysukwaebzfia45AIMXHV1Mo60atomGJIDfhWhRfRx+uw3QYx5ZJcfcMZ3Oi5ZEo04BiRLki3FdiK0+0EBgWQIUy6aPy5jhTfcnHrIg8Tgp74DuZRIH7PRUAWvE5bG/UbQw3VH9lHeH+CXAap23Q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371505; c=relaxed/simple;
	bh=efNqqDa7NZ8m7RAc8xwvsx9prNkW3gANyPqaf/nrS2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8i9CL77E/+QT8bj6RYqPcVWganQTPBrTb+c+pgmq6qIm+GB1N4ZeBdAeGjuQzZvXy+wcSEsAeGqSwalU+PtjJZ7XvpfjOSOQ2KzS463OAlQZcDlxUFVu4jY0Szcvf0/b4294rsag49i4vajV7MQVKmDzR7cpQ9swyhU+LipG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hexJVvVO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-574bf7ab218so10565017a12.1;
        Wed, 22 May 2024 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716371502; x=1716976302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9o9gXgKT281qg8K+yuHMuTpVl4xRQoU0ZSVOrvuvWQ=;
        b=hexJVvVOVtvULl81YfF2B3jJ/4TMqO4Jyc6WByHWeRK1Ont5rGOEFDe34ARwGkHv+j
         f5nktN7WzGNFTm7oQz1eGHRi8FOSs0KGykDHng7wn9N5Y5l3yb5d9mBSbnL5ON/NvXNZ
         V+bq3jQMu5nKt8UJZDSYsi+YesoCIWILcibbwyEQHqTLqFwGzbxC80zyr3ftJV2tHVeS
         cbRfNKELRAgF8EG6v9IT2gYzT8buaL3d5i1x/kHenaZRdguycq0FdI8ck/ujgUk9KeiS
         uvmrTg8erqSk5O1SnqCr1tpxLCFuf4/sBI0lwx2rRDvtvdYiDr98nUlXiq5e0Y47/K+z
         3E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716371502; x=1716976302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9o9gXgKT281qg8K+yuHMuTpVl4xRQoU0ZSVOrvuvWQ=;
        b=RxxzSLb+0c9L8v1g7ruZD6MOetJfgpjOIDqif4ibgtMmJ+k7yA8kM3Mb8rI7BTii+E
         73X6OSPT3rRV8GmbAXPSrJwlR92yxY51tgpMMHsuSkANOHFTOs33ipEJoVto5v/b5AH5
         mFb/yzPzQ/oenh/06KSa+I8PKby0fDzqBGcAr7q16fh0Oko4puFP3/gBQRhU9FB6TFCK
         5yH8qRdJG2JjI3LKsVQBIv5ICLdXwMLQg9Hsdf4oYd3sSOeWGfB1MyJC3NMSfK1ZEsB+
         mxeZgHQZGp3abpTUeUe5/qTp9aB7vR2oHJbncKJj2ekwzvrq5dbhFlxFlL1n84/I83dn
         RkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6eYJyonT/NVt0m0qtt2i4MSZ2nD4f9OKqa28Bp19wZ3seJkGiA+j3vXu7kbzJbw1zjMREcusixguGDN6t2B1XAT4NkBW9og72lJfVuNv9+wZwKpF3ItFUZ0bYWPG3EBxw1EDy+g==
X-Gm-Message-State: AOJu0Yy/m4AWGGQmAqn1EdNSkRbiaOkKJd+zW8rTB9yC8KcDWT6fdq49
	nFSggFprXiPAHMHh2Q9T+p/VNAc6zbVtUT5QJ9lVMKg4KwwBQjMhSOJxrFblUlU=
X-Google-Smtp-Source: AGHT+IHShOX24cKW5GMmG6RbKG8XE1qX7Wvkb9hOFAkvtE6epSaGVFgJy95iOUQvJvOkKZJ/2kf1Jw==
X-Received: by 2002:a17:906:2b53:b0:a59:a977:a154 with SMTP id a640c23a62f3a-a622818fa42mr88408166b.64.1716371501599;
        Wed, 22 May 2024 02:51:41 -0700 (PDT)
Received: from ?IPV6:2a02:2f0e:350b:4500:33e5:18b9:7464:29a3? ([2a02:2f0e:350b:4500:33e5:18b9:7464:29a3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01647sm1748805366b.160.2024.05.22.02.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 02:51:41 -0700 (PDT)
Message-ID: <c7996393-a2d0-425e-a37a-0f6bf1ac01b9@gmail.com>
Date: Wed, 22 May 2024 12:51:39 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x
 family
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
 <20240517074750.87376-10-ramona.bolboaca13@gmail.com>
 <20240519195707.71163f84@jic23-huawei>
Content-Language: en-US
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
In-Reply-To: <20240519195707.71163f84@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/24 21:57, Jonathan Cameron wrote:

> On Fri, 17 May 2024 10:47:50 +0300
> Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
>
>> Add support for ADIS1657X family devices in already exiting ADIS16475
>> driver.
>>
>> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> Whilst it's not necessarily vital to support, it I'm curious about
> what happens to the hardware timestamp? I thought we had one driver
> still doing hardware timestamps directly to the buffer, but I can't
> find it so I guess we now deal with alignment in the few devices with
> this support.  The st_lsm6dsx has this sort of combining of local
> and fifo timestamps for example.
>
> As it stands I think you push the same timestamp for all scans read
> from the fifo on a particular watermark interrupt?  That isn't
> ideal given we should definitely be able to do better than that.

Currently the timestamp is added when the FIFO is read, which does not 
equal the sample time.

ADI IMU devices do not actually offer a hardware timestamp. The 
functionality is as follows:
- for internal sync / output sync / direct external sync the burst 
data returns a data counter (which increments with each sample);

- for scaled external sync the burst data returns the 'timestamp',
which contains the time associated with the last sample in each data
update relative to the most recent edge of the external clock signal.
For example, when the value in the UP_SCALE register represents a scale
factor of 20, DEC_RATE = 0, and the external SYNC rate = 100 Hz, the
following time stamp sequence results: 0LSB, 10LSB, 21LSB, 31LSB, 
41LSB, 51LSB, 61LSB, 72LSB, …, 194LSB for the 20th sample, which 
translates to 0us, 490us, …, 9510 us which is the time from the 
previous sync edge.

We can make assumptions, and try to better estimate the timestamp,
based on the sampling frequency. 
We can assume that the last sample in the FIFO was sampled when the
watermark interrupt took place, and then, based on the sample frequency
we could decrease the timestamp with the according period for each
sample.
However, I am not sure this assumption is always valid, it depends
on when the IRQ is actually handled.

I can remove the timestamp for devices which use FIFO seeing how it
does not represent the actual sample time.

>> +static const struct iio_buffer_setup_ops adis16475_buffer_ops = {
>> +	.postenable = adis16475_buffer_postenable,
>> +	.postdisable = adis16475_buffer_postdisable,
>> +};
>> +
>> +static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>> +{
>> +	struct adis16475 *st  = iio_priv(indio_dev);
>> +	int ret;
>> +	u16 wm_lvl;
>> +
>> +	adis_dev_lock(&st->adis);
> As a follow up perhaps consider defining magic to use guard() for these as there are
> enough users that will be simplified to make it worth the effort.	

I will do this in another patch series if that is alright.

>
>> +
>> +	val = min_t(unsigned int, val, ADIS16575_MAX_FIFO_WM);
>> +
>> +	wm_lvl = ADIS16575_WM_LVL(val - 1);
>> +	ret = __adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16575_WM_LVL_MASK, wm_lvl);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	st->fifo_watermark = val;
>> +
>> +unlock:
>> +	adis_dev_unlock(&st->adis);
>> +	return ret;
>> +}
>> +

