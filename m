Return-Path: <linux-iio+bounces-19505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3F1AB6262
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 07:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF6C3A9218
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 05:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C31EB5D6;
	Wed, 14 May 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flgEh6S2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B31CAB3;
	Wed, 14 May 2025 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200991; cv=none; b=hdQ4fHod1EpGl+Ig2uor0YaaAtSfHzgzMDJixZjxVfCjfriIcq6gjTSXElk7xo3JAhYQK6zx7UN3N02zEyeM04ik54rURD58lRpukAqPODNFKaHrJU9ySkMF257E6VmuGiOVSWtdvNkzHEwcllupa/qXzSSMtx4spKr23BrCFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200991; c=relaxed/simple;
	bh=ZponMKVpRFfMbJo1OaQLnse8DH75GdOXWOOlWBFNOno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGJi5E6j4OO1HDjVSZCpozZeC3SA1lmIQsfX5N1nnvAKP/CygPHUItutuZvST5x4f0+kkUYSFP6HfC/4Q3Ik5TEpk+9/msd+tnxWbcAF+2s8JT9fdrlWJmyyfbqGX3A/Ie70CsPUIsxPWVxCDLj6RuDQUgc7MnYol8si/y78f8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flgEh6S2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54d3ee30af1so6910415e87.0;
        Tue, 13 May 2025 22:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747200988; x=1747805788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfL31sOw562+nQg+P3RDSJt42WsF9mazyY2OKejllKI=;
        b=flgEh6S2HIM+Bv2VWdguu8TCew70BjbLbkThfkKWlJ1gjMaM+Ene4B6Ej6Zuxy86/B
         uoCW7l9OS5YEGrXsf6WX/lOOX4muGWN4xir1p7qZpML9EnguMzBNighmYtzE1zKqtb7g
         MIzpzP8r/WoZq1fp132XsLNc9yDBAvaFvzNPXdqfYbtSJxGDn8NnXoxkoXG7h8T0L4lu
         YxCZ9lkaG3+U1Az35G7b/QKzKRbmduNg5dmy/5iRJVUPQqwKMZlReMAgkuRdvAIlhN8t
         acF8EhgOIyp5mFKyBy9PTy+mf1/wYrY6brg33pkUThtxim9e06jGqcVzFYABG30p0LOQ
         9Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747200988; x=1747805788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfL31sOw562+nQg+P3RDSJt42WsF9mazyY2OKejllKI=;
        b=caIq4K0fv5FLLRrOfqZLYs3nrM70uy0/0asDhzPRvOLMuX9WJKoxp92LDCezaVkabb
         pJ1Vhtb2ofRIFkbCEl/mF93VZXYBJtSYEOpH5Vl3Zm/ozO1zNlrhbA9sr415tEdFI09V
         Mf2EIuSeCtJDWi7b6N0+UYH/NgsgW2J4Jz4HLSR9yxGqmuQ+7z+VB9bFop9k8CxrnJZF
         0nAEG3A5Yc/XqL+q6wO8gkEZUY9dJk/BBdcOuUjw8C4WgzEiE5nJZyCF9VS+xikVSCCG
         YUtEkDTLClCzegnoFMO4LXV0gYTB97CySaSGPfXODYoUQfsImYGKViDBSAqYcyHyXAxh
         +RBw==
X-Forwarded-Encrypted: i=1; AJvYcCVWg71pv3KQ8e72tOJK79QPY8KuJjoPIAWaVuyimq+A0WbIqIWgsf+yrda+x6te8GYJLewi+U0/Jy4cFnAA@vger.kernel.org, AJvYcCX3sE6onOCkZN8It7QvyhgjIDCjZ0Fk2waZbl+BgsDGWYKdEWOB5Z3/UaDI1keEZbDHkyODw74yeBxm@vger.kernel.org, AJvYcCXiomIUyLeE1ON5OZ7qFN4GoLLt7hPXBAQYe50WKq0TohJjfCoBi9pvCh3Z+qaEqKsgRoaLDZbmRfIo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7Pw6whVbxLVJpbK1lp45Q7ho2odSu7tWgPUVPPoo8P0tsTUe
	BFEEn9D4nIAtKg2FfRWuQif/ZHwXt94gn1+E8aABUcOjYawtbGLb
X-Gm-Gg: ASbGncvL8Ew9Gc/nWDVjUWanb4/g/cFf1rhxtqsohRksp7/ZGZyXEnyABleiK31zb1p
	PnIobIRhStdznPK1dqJTmazXH85BGAATZ801OAA1g7P3jtcJZnEmv7TcaZm33eLqA4DejOjn3UG
	mtGmxOwE1eBY2LUwpEIuw1ZRS4JDn50Px9K3a4I53wxZNd1amh7cjQJS2UR/I6QpuPzNNQokG/b
	NzRegj81odyIXKz9++PB50sWCxHmbt6N0N2F6jPAmsEh/N2/gYQNdAlLy8+YnxVgJUxLdDJyBYf
	B7PUBu6GsnPFNkZnoqltGMkG//dDOBidOpE+/dQUdGDtJx7HddGTJeO8T12Mg1uJJSYjJxN+0Qs
	RtIUp7SI0GG1mv7uKos3UDWHbqnEB76L3UKj6lgDStv4=
X-Google-Smtp-Source: AGHT+IHWFaPhwpN6UZq67Jw89ACDQGwRczY9DtvjLQwLGCkuhoPJE1p/GPCeOicYb7Mv8PsDy++VPw==
X-Received: by 2002:a05:6512:4386:b0:54f:c402:c55b with SMTP id 2adb3069b0e04-550d5f7c51dmr689956e87.10.1747200987507;
        Tue, 13 May 2025 22:36:27 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550d84676ccsm62749e87.60.2025.05.13.22.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 22:36:27 -0700 (PDT)
Message-ID: <5c721d80-70e1-4cdc-974d-2007bbddfeb3@gmail.com>
Date: Wed, 14 May 2025 08:36:25 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add ROHM BD79100G
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1747123883.git.mazziesaccount@gmail.com>
 <7deb4b69795c298ba51c9b198bc87000ad35cc9b.1747123883.git.mazziesaccount@gmail.com>
 <20250513-coconut-reconfirm-b90590efeb45@spud>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250513-coconut-reconfirm-b90590efeb45@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 17:39, Conor Dooley wrote:
> On Tue, May 13, 2025 at 11:26:27AM +0300, Matti Vaittinen wrote:
>> The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
>> no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
>> The 4 leading bits will be zero, last 12 containig the data.
> 
> I think it is probably worth mentioning why a rohm device is going into
> this binding (clone?) and that the 12-bit thing is a differentiator that
> is why you're not using a fallback.

Thanks for mentioning the fallback option Conor! You're a hero :)

Now that you mentioned using a fallback, I believe I can ditch the 
driver changes and make BU79100G to use adc101s as a fallback!

I didn't even consider if some of the existing devices were (from SW 
perspective) identical. I was just happy when I found there was a driver 
supporting these simple SPI ADCs. Then I picked the right macro for 
doing register data conversion and correct shift, dumped in the bit 
width and extended the longish list of devices. I never checked if 
another device in the driver had similar set of "IC specific values".

Yours,
	-- Matti

