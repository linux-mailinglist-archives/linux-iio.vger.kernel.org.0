Return-Path: <linux-iio+bounces-515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1A7FFAB8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F49D1F20FE0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5463CE;
	Thu, 30 Nov 2023 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leOgRIqP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EDD48;
	Thu, 30 Nov 2023 11:04:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b27726369so12003815e9.0;
        Thu, 30 Nov 2023 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371067; x=1701975867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFS2mMw973pSI8BG0Q2Fj2fFOzp0k4cYQrI7sefIoXk=;
        b=leOgRIqPesVgzzmJOpPgKGY/BirvC6shbqC5BaCgnZCIjdParTKHDyuDfYbu5qbM7w
         awIM9b4rwpcs7gZjw4RTOKvQwl6ZeB0Tr3yfA9pahvKdrLy3eoxX0JjYESRisSL+XZbL
         ApuUCYu3uIQxglsD8GuOEQCyZ5PbyNxTkE4B5qMJIiV98RH/eIoiQr01Mw1ubOB5jTuI
         htOHez7DH1sZob5JLhRI7McRErM2c7356/To69FrvrNWMw4+D0MN2FiFqrqZejKjltEp
         bmDGTbdg8aswJ3MjuYwpRK97KTTUXsQDszLsSaIAWcHu5qUBnezO2hVKGqIks3wUz076
         LYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371067; x=1701975867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFS2mMw973pSI8BG0Q2Fj2fFOzp0k4cYQrI7sefIoXk=;
        b=BHvTZJLQz4gYB3str1bX76KH2O83ObFyLQKpYBpbN10sjCB5rxtnMw8pySbOWLPQbQ
         l/WzyBlQchLsX+PkI3dsP9u/861H9Hv+PSpUsyoqD46zuXVJgAzTeORTfZq4bAT8+FZQ
         N3HzGX+WrC1rD3w2ffemK9IucB4ISocOemB74GOU08UMzijY0r5NHbsBH9Zk4sITM9U/
         Bi12uSQ1Q2p5XNBJXLt2YZQcN0BhQgxy5C32fhbMn4E5sPBStci7XtAsLnB2Z6zVvEde
         OXrPgkYuVJh3rJ77MZd6NSp3v+fZ9zT+lFyu4D+FmQLKV7fTfVOzJR6HhK712WWO8c/v
         LPQg==
X-Gm-Message-State: AOJu0YwNA66LWdwPhM0IZJXef0Fuf3c2Vxek5QiprxYr2Ssp9oqK0WGl
	9y714Oy/PAuGno/JkJ8FbQQbFybCa5pKPA==
X-Google-Smtp-Source: AGHT+IHsB5HM+Z8dYqYemNcQHZF/+wl58n+9mBj6UY1neJYvfCN+EXCWLGlqNNMxSdk+h2bkmtn/Dw==
X-Received: by 2002:adf:e88c:0:b0:333:2fd2:68ee with SMTP id d12-20020adfe88c000000b003332fd268eemr29371wrm.129.1701370746322;
        Thu, 30 Nov 2023 10:59:06 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:eb78:8143:ae31:3a3f? (2a02-8389-41cf-e200-eb78-8143-ae31-3a3f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eb78:8143:ae31:3a3f])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b0032f7fab0712sm2217925wro.52.2023.11.30.10.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 10:59:05 -0800 (PST)
Message-ID: <570ea978-4ffc-48fa-92df-463f84610a5f@gmail.com>
Date: Thu, 30 Nov 2023 19:59:03 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: humidity: Add driver for ti HDC302x humidity
 sensors
To: Jonathan Cameron <jic23@kernel.org>, 579lpy@gmail.com
Cc: lars@metafoo.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20231125102221.2795-1-579lpy@gmail.com>
 <20231125145208.01194d91@jic23-huawei>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20231125145208.01194d91@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25.11.23 15:52, Jonathan Cameron wrote:
>> +
>> +static const struct iio_chan_spec hdc3020_channels[] = {
>> +	{
>> +		.type = IIO_TEMP,
> 
> There is only one temp channel so I'd like to see the peaks added to this
> one as well.  Can be done if we add a new bit of ABI for the min value
> seen.
> 
> Whilst naming .index = 0, .channel = 0 is different from this case
> the ABI and all userspace software should treat them the same hence this
> is an ambiguous channel specification.
> 
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +		BIT(IIO_CHAN_INFO_SCALE),
>> +	},
>> +	{
>> +		/* For minimum value during measurement */
> 
> Please add some docs for this - preferably in patch description
> or cover letter if it is too long for there. You are using the ABI in a fashion
> not previously considered.
> 
> I don't think it is a good solution.  Perhaps keeping IIO_CHAN_INFO_PEAK
> as assumed to be maximum, we could add a new IIO_CHAN_INFO_TROUGH
> perhaps?  Hopefully the scale applies to both peak and trough so we
> don't need separate attributes.
> 
If only IIO_CHAN_INFO_TROUGH is added without an additional _SCALE, in
this particular case you end up having the following sysfs entries:

in_humidityrelative_peak_raw
in_humidityrelative_peak_scale
in_temp_peak_raw
in_temp_peak_scale
in_humidityrelative_trough_raw
in_temp_trough_raw

I just would like to know if documenting the trough attribute in a way
that it is clear that the peak_scale applies for it as well is better
than adding a TROUGH_SCALE. We would save the additional attribute, but
at first sight it is not that obvious (it makes sense that the scale is
the same for both peaks, but the names are not so consistent anymore).

I suppose that often the raw and peak scales are also the same, but
there are indeed two separate attributes. On the other hand I don't know
if the additional attribute would imply bigger issues (maintenance,
documentation, etc) than just adding the line, so I leave the question open.

Thank you and best regards,
Javier Carrasco

