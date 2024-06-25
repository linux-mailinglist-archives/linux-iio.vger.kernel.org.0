Return-Path: <linux-iio+bounces-6933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE4C9174DE
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 01:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780B41F22D59
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B117F500;
	Tue, 25 Jun 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBSS0FNp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAED5EE97;
	Tue, 25 Jun 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359084; cv=none; b=O/pcX+xEmYr85KTx4c4DHUPh9GraFe/vV5/UubE+JEhHX3rW7vQAy4CNB+1tp87oJGjpF3OHgaknY1K33+c3jQ4dypFTPSS1vhUzrnWluU7AgVSi0RCvZuA7fMKBH/nM0o1Xzo/pdv5vuonPuimElP3eGjiTsxN3PpZLW5JtwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359084; c=relaxed/simple;
	bh=Crwb+GvyBVxDLVRJzq0nCLHv/N/UWSdrxFjpKYqJVw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUn2gaKFS4XFsTopkreN+G9qrxSfaF3vGqEtS0Rp2EAVGxV2EYyZGHN+LlDSNEYFIV8PzS6C7ZyljvtTj2cQiJPyYm5EOBBvVbKbPfCaWi6vYDmgT86HQCpmTf95NdSHdBf66tRNHf6GlDxXaU4ogBYhN+S0yB1f/FLbKam0sM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBSS0FNp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424ad991cbbso2332965e9.0;
        Tue, 25 Jun 2024 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719359081; x=1719963881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9VWLirYOhbpeFMQ5jHlJWADb5cQPWDXmGNOir6Z4wo=;
        b=WBSS0FNpKiZRmLH9ihLUdqOnLOAF/MqljoJLHaMix5CNMMmzdQ50qQ+lyC9QcKgObC
         4F3PC0GZd9GbNxSRhTfdo1LZNCGflG69NCZLj0riGG15upOfbX+Ddbc9E8FDyb4m6f/+
         j3OuInCeJfKqy3216YETP+LYbxETWjWXG4Xupf2juxCVmvPxzsFtl/n19KE05CouK1n/
         ezdYHgkYX6f5F92O0c2T2gZKTaDxneR/y0LPkRYWEk/lXYIbVTT+RffI2H0LHwGFkITk
         E3gT65ga4Ex1ySTt5yDhErHTadTgoP2cvIfKojgZFoNeXtmuP4wuCRwRCqndgwGQ6dJX
         iEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719359081; x=1719963881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9VWLirYOhbpeFMQ5jHlJWADb5cQPWDXmGNOir6Z4wo=;
        b=noJYpFAD9/D/s7tB5VKlhe+PAtR3Za9bdCKuPTpno16hpFPoLQG/WetBbqqXS82wH1
         Q7jmf8tGrzHO7HQiuqE4k5UpDGCWMQqnTMm3nqxXTIcv7Xm6gb8pypIDFO+4fHZLp05y
         HtE9MlPjcfVMTTTh4Lv+5ghvzXq9cGWg47jqW5Cdd23+IabNADK3xJz7CwEzuebbrZiT
         yWAEiGE4end11WPdjxp4QzwJysbJI7AZsGVKPftGlzAgpwmTaZJXNM6nZ+QpuATHht3N
         uM9hQOJF8yLEzZjdMryd0TR+vnI4/R1ZEue4TQIW4+KU29kLYPzejDkKWtzmxVYafbw5
         8ChQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFfW8y8gfQeyKVPwzk6BpQ2NanYUGoCECQsyKnN6d/h8GfmCs5FOSZiwfzY/+8g3MtaSZCH+6WpNhe9wsb0NwQYQLevlQ4KugZ8duXtN59sVswzFGLR2NLgX0ZMt5yGCNdB614hL8dnxyEXcIoJGdJEA5JT54kakZxLI/AdMyOxTpAHQ==
X-Gm-Message-State: AOJu0YxB8DE5vpDNNJeQ2HqSX5tzxAmD3qBHigmO5SWHYRP+t9j9VsSs
	RSv3l2l9/LWMW0KBBPkIyuIUeshiTNDkdrVNRMd/nlvMtd2refS+
X-Google-Smtp-Source: AGHT+IGPEuIYm/1DJVnedxk83scHBUEK6n4xKPyoEAFtXx7wkYP6IiAmz39Vx64oDmFtYC1iSMgneg==
X-Received: by 2002:a05:600c:4a99:b0:421:29e1:998 with SMTP id 5b1f17b1804b1-4248cc67376mr54279345e9.39.1719359080586;
        Tue, 25 Jun 2024 16:44:40 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8424554sm4249745e9.37.2024.06.25.16.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 16:44:40 -0700 (PDT)
Message-ID: <a2c140d1-13db-4074-9ffd-e37d806e2136@gmail.com>
Date: Wed, 26 Jun 2024 01:44:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: ivan.orlov0322@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20240624215543.459797-1-muditsharma.info@gmail.com>
 <20240624215543.459797-2-muditsharma.info@gmail.com>
 <cf06ea77-c8b0-4476-94d1-32171c96f22f@gmail.com>
 <7fde0674-c20a-4455-bb78-3a6521ae99ed@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <7fde0674-c20a-4455-bb78-3a6521ae99ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2024 21:25, Mudit Sharma wrote:
> On 24/06/2024 23:27, Javier Carrasco wrote:
>>
>>> +static int bh1745_set_trigger_state(struct iio_trigger *trig, bool
>>> state)
>>> +{
>>> +    int ret;
>>
>> Why is value initialized here? If regmap returns an error, you will not
>> use value anyway. I caught my eye because it is initialized here, and
>> not in the other functions where you use the same pattern.
> 
> Hi Javier,
> 
> Thank you for the review on this.
> 
> 'value' is initialized here for case when we un-set the trigger. In that
> case, 'state' will be false and 'value' of 0 (default value for
> BH1745_INTR register) will be written.
> 

I missed that case. Thanks for clarifying.

By the way, it might be beneficial to wait a bit longer before sending a
new version to give more reviewers a chance to look at your series.

24 hours might be a bit too short, and your version count could easily
skyrocket if more reviewers get involved.

Best regards,
Javier Carrasco

