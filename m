Return-Path: <linux-iio+bounces-18953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E9AA678C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 01:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5CB461C6F
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3612609D3;
	Thu,  1 May 2025 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="REeP7MMl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B921324E
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746143535; cv=none; b=rvS7Fz49MBycllz9QVTxIAP2Dx/Qwlb85N4qWQpkZoz8UEPsG53u64fomfZWb+Oyos4lat+VbJBoACUIAZky1FMhmWH0BzXXvE4k3EnBeTZ/pVH3gg59OlpMzMy4EuD4QgegWQqVx9s3or84kDlZZHE0mdPlU9u/0TkOJHJ2mnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746143535; c=relaxed/simple;
	bh=OQUWGEVgZ+PDwRlv2+NEZXwr26U7U2Avy7r6dUmpfsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m27la/xaJEbG8Zu1vdkoRSvO6VazmTmvlSrXG1+3Dd7bUTUsLREaVnMJio2lmuHCMdt/yNd4CXyyVIHvwp8Q/CUSomTWa1/eRezrCwlpleHQiMzQeh+zZgM+M7dvbrWftA1RsvH8nPQ9wyaR0fn8WtC/mkkuCCqSRS4dGKOG9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=REeP7MMl; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-601ad30bc0cso1707926eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746143532; x=1746748332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyKraObEURHCA1O3iED2hm26WFNl7Mw0i9SjHNz0w2M=;
        b=REeP7MMlFo7US1ZJSgBq7bHwmHkgBvv4kJWSJEEGdjsPFn1Cl/PMzgSONIoZFzcyui
         XuclwF7FWsPFrE/u9HJpD/o2rBv2tdnN9M09RYJB6f/MkOWAKvBht4fmAnNo/HbXyRcs
         BN0i5u4ppYom9ENaokt90KouYOHNKjFedy3/Pwo0oevVJTyWGswvwud/d221GRmi5eYF
         UFiWt09anE6iX5YT1aeFCM4WhAT1rKmGQrcAgtDetKp1lJyN09/jp3+aktQWNUnexjy+
         7+TmKSkmlRpd/HarVtF57kMnKiNRB/427S3QCoEAo6Q/Qsy2kptUkw4iVSLSScPw9qnT
         HyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746143532; x=1746748332;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyKraObEURHCA1O3iED2hm26WFNl7Mw0i9SjHNz0w2M=;
        b=PT5k2ezZ8pSwlMKzNrPsbcP7czU33d0+UDa+8Q/hG0GAVY34o421JeDODJjV6l6JVK
         jucmFWyJh9fX5ZrBu/KwcOy6llp/QDgTp9DqWkC1wUGaBrAxFaDum0bO2vroYFbvV8ly
         eGg1k8qJK5BmB3Yf+3lQDEAHbGi4IwLamgoLCUgHNXk2/QgDo4swBznzAWbc95gUrx9C
         kDcQxGEUNlcGm6frUwIcZH5DNQ8rESlnCtcO/w3SyPMklORsXjjpSt5gRNIVnitZUTOb
         4Rc/7ogoZwX7MxfiXTRyhBzLWbnjf7cdPDA9kKYH2oby7d4iHUz6B+bBYRe5l29JznxC
         7EtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYgcchLyBuLS25mZMwyqULp9eFabZc6iILoR5tSCHStIC0u/qcO2tF4Fa9/LQCLfi525UZOEWhZek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoG2yH9z2mda0AkG02hIv12VICGAUMAjtjzMd6aYKMYcXQ3WIK
	7XqswZE4r+GFprnRec8zKqtEqBmoHjMk38YdkP7GLnRT8KAa9UcBGrt5VjbLxWw=
X-Gm-Gg: ASbGncvuc+LlU7sYEtz+qY5EegfXCdDsY9RXoo4SzomeewGxKPkrF3+gz7O7kuEGbey
	FeV6ZsLPHjENr7Mr7D2I121LhHHBCnI8v+4NjnD2Ilm65XtBRXIblTXevN/79XaChxNiZ5tfEzo
	/ku/2N60bELl7EYb+Z0dqhLIEkqsu2eQOpmHoPO5kUtcbJMXge9dAJ4m/l94CMNaQ9gP/U4cb8g
	hVo7jx6q+AhXIPeZ9M0/UW2a2jqTBmNsSD1HambL0OrAYPwkye5A/Ys9fpZxKkiqMi9fTHz9tEE
	Q7HByWHpL9fa1oTLYjW0LdEvsywI5ji0y1aQpuFTAAYRdWqsK0s6ayUa6N5es8BLg27XShnMDnc
	8jk0ouosAVLVJ1QfUSQ==
X-Google-Smtp-Source: AGHT+IG9i0SjqJNmrxwyVXWssfn4FV7bVAFVBFFYBmbJlnOnDNrSJ9/S9igAW+PRB5scHigMaDiLuA==
X-Received: by 2002:a05:6820:17c:b0:604:ac85:abe2 with SMTP id 006d021491bc7-607e1fde107mr2462578eaf.3.1746143532034;
        Thu, 01 May 2025 16:52:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7d11e1bsm324509eaf.10.2025.05.01.16.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 16:52:10 -0700 (PDT)
Message-ID: <741acf06-72b8-41e6-88ef-048273c3da26@baylibre.com>
Date: Thu, 1 May 2025 18:52:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: sensor-hub: Fix typo and improve documentation for
 sensor_hub_remove_callback()
To: chelsy ratnawat <chelsyratnawat2001@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
 <1f8de7bd-7049-4933-82e3-8ce71685998e@baylibre.com>
 <CAOeBcHOw6CHbY6W+wAWvYsm_CGRMCgt_BLSV65X=rnhuU1r1hw@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAOeBcHOw6CHbY6W+wAWvYsm_CGRMCgt_BLSV65X=rnhuU1r1hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/1/25 6:33 PM, chelsy ratnawat wrote:
> Hi, 

Watch out for HTML mail! The mailing list and other automated tools will reject
it, so some people won't see the whole conversation.

> Thanks for the feedback. Regarding your comments:
> 
> On Thu, May 1, 2025 at 12:47 AM David Lechner <dlechner@baylibre.com <mailto:dlechner@baylibre.com>> wrote:
> 
>     On 4/30/25 1:23 PM, Chelsy Ratnawat wrote:
>     > Fixed a typo in "registered" and improved grammar for better readability
>     > and consistency with kernel-doc standards. No functional changes.
>     >
>     > Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com <mailto:chelsyratnawat2001@gmail.com>>
>     > ---
>     >  include/linux/hid-sensor-hub.h | 7 ++++---
>     >  1 file changed, 4 insertions(+), 3 deletions(-)
>     >
>     > diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
>     > index c27329e2a5ad..5d2ac79429d4 100644
>     > --- a/include/linux/hid-sensor-hub.h
>     > +++ b/include/linux/hid-sensor-hub.h
>     > @@ -130,10 +130,11 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
>     >  /**
>     >  * sensor_hub_remove_callback() - Remove client callbacks
> 
>     This says "callbacks", so is it possible to have more than one registered at a
>     time?
> 
>    
>    Regarding the use of "callback" instead of "callbacks", what I understand is- 
>    - The function `sensor_hub_register_callback()` ensures that only one callback is registered for each `(hsdev, usage_id)` pair. If another callback is registered for the same `(hsdev, usage_id)`, it returns `-EINVAL`.
>    - Therefore, `sensor_hub_remove_callback()` is designed to remove that single registered callback for a given `(hsdev, usage_id)` pair. The function does not need to handle multiple callbacks for the same pair, as only one
>      callback is registered at a time. 
>     
>    Please let me know if my understanding is correct, or if you have any additional feedback or suggestions.

Based on the reply from Srinivas, it sounds like you understand correctly.



