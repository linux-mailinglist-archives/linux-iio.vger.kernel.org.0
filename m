Return-Path: <linux-iio+bounces-19990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE8AC691C
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 14:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D51BC6DC7
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9E28469D;
	Wed, 28 May 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kLTei5vg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02FD284B36
	for <linux-iio@vger.kernel.org>; Wed, 28 May 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434773; cv=none; b=nMLHhNlB++ykosks5tIF94IqURFnGKoy3lG5ug/a/8vQ5G+wheEJri0IeVovCA1ApxNdZ31rOeSxElicM+lm0WHGkoSnLqn7c0M3dUb4KD7VLJygkgKovRZq8vTRsWetW2bhYxO9PNp2aABR3IK2I2Xm4FdBC4fGOiug6KVHk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434773; c=relaxed/simple;
	bh=UTy+PEU7tr0mOQr1WcfZgDzuuEmIiCfQAFSll5QPB9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw0XrxgSyIu5v/mMJHbmmrxDiC7Cl74aLcPRuiga50shjBcWTDLHt4cuX5hZVHJWpf9baYumUTPnsH7GHNd1BOPpWd0qOrmGVzIUcHu066mlpqcRk+SZWtF84/ZkUNZcZAGGmsSnz1Oeqc02DV3A9OtdwiqL2L7DqtV9/MAtYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kLTei5vg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so5578476a12.2
        for <linux-iio@vger.kernel.org>; Wed, 28 May 2025 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748434770; x=1749039570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUs1WGbpbtSdkN7Nj6CphSlTzl8HeW1Wjos25VNHfcc=;
        b=kLTei5vgu21+KKSJf3ODIz96GYG117NrrT6qfl9k2/mzeS9baqjonSD53BfyJ/8ENl
         oyN1ajvts6hopw7+BxxOXmV4KriXwyGJTyIUCePFDSkiC+8Jds3OGWKcpodX4TtG8ib+
         tX4qEdqbKD3ljMD6zmGAlhVb7sWBX0GCN5bwHzeVYVbF7mKn2CJ18hg14pPIFayaAz4c
         X1JbZ2AGhZUDXtYFxRtLwC6aXrJWw1WCuXH8jgWWdYdRj+xVujQ9d0PcdWkAJCuclCk1
         kndcUMQudzKC1hiPkesJR5wTy9Tfz8fniYn2zn17YKbMGjEo0kdn1dMCwiRSYjnnZf9m
         Chew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748434770; x=1749039570;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUs1WGbpbtSdkN7Nj6CphSlTzl8HeW1Wjos25VNHfcc=;
        b=TtcRPxYpgvMkEClFarpgx7FglVSKs5yqbsVmB1EtzrA+F5b+9rFmqyVE6+/STWpd3K
         LAvKC9BhTAZrbgRNecmLtn6/hzfTD1j8QCOYGf4AQyB4A0oNWhE7TNWjMi4pYb2cmQkr
         ZeQhHmZsfhFskhZJZRj5SiyQqKpnIqU0hvk4Q//Rg+FX9NaC/VoMWVFXCjqumUNCPr8i
         sK75QJzulFPgfMKEK6aZpu+9yMf0kASOsjicfAtolHjRxSFRQtVTVRr9snZpGp7k87SM
         n0/LXFSu2rgFUmT65kvXtrLsOpw+OmZSCoP1a/PoF/kBvZnUpNnOvzuS9j9V22VMkxGx
         MWIA==
X-Forwarded-Encrypted: i=1; AJvYcCUjhSSznbwFKf2IqbRiVqyRD4v28ZRWk8nmuYnLDoDcFS31RSvKgEU3XzmYE3aG5OmjxMrU3K8CFQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJO37wJ0ZawHmivrxULapgj4SqjI8SJ4zzO8VPaXlp7JGhj76T
	25TBJDNV9/BddNjwoq4O5wAkIcCuVqOz6XMe47cKEdUExfnZQHQefPtHIMIrEWmxd3Q=
X-Gm-Gg: ASbGnctO1we2WLW/7M2Opx7bIQjggbMSzTXx/2yu1i1AWSXZX2+M4oQWl86MTXyhtiK
	BJ5me9iRm3Lmt2cXNqFm8MpRLL33TsZ0guJzICp+TvEmapRT4VENDO8HTkle21DizZ785c345OZ
	bUEBFcbSDixAQn1UYXb8gKKfhm57f+gw1fpbKprcizDQ7UBmuEvHIGyeWW9ZP5tWjlchv7qa0X6
	3KTHL3kAt7TxYRpuZXuuSaEA1KVCPAF6QJyxroGsOqExnjsQwcQS8VcsgzZ8aLCHnsfaP7qyMQf
	Sf+8HZhYOaG28wWgqW0VCEZeHjCxtSe60AVWMVTFjfHjAo15FhDx3ZhRUOh7
X-Google-Smtp-Source: AGHT+IGGhc5A2T3ca464ACVEsiUUFLDwI1rD81PEkeAvBkW4x1BJfuPs5Bg5vFJS51y64CfcmLZiFQ==
X-Received: by 2002:a05:6402:5113:b0:605:878:3560 with SMTP id 4fb4d7f45d1cf-605087843demr4023398a12.26.1748434769848;
        Wed, 28 May 2025 05:19:29 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d5d9936sm706164a12.7.2025.05.28.05.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 05:19:29 -0700 (PDT)
Message-ID: <8bcbf37b-b70d-48e3-b435-a097d351f786@tuxon.dev>
Date: Wed, 28 May 2025 15:19:27 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 len.brown@intel.com, pavel@kernel.org, jic23@kernel.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, bhelgaas@google.com,
 geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
 <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com>
 <hojdkntm3q5a5ywya7n5i4zy24auko4u6zdqm25infhd44nyfx@x2evb6sc2d45>
 <CAPDyKFptNg5t6RehRNNfnnuCqpfiaQLaHBEdh4aRXfn7X6rYQQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFptNg5t6RehRNNfnnuCqpfiaQLaHBEdh4aRXfn7X6rYQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 28.05.2025 12:31, Ulf Hansson wrote:
>>> +
>>> +/**
>>> + * devm_pm_domain_attach - devres-enabled version of dev_pm_domain_attach()
>>> + * @dev: Device to attach.
>>> + * @attach_power_on: Use to indicate whether we should power on the device
>>> + *                   when attaching (true indicates the device is powered on
>>> + *                   when attaching).
>>> + * @detach_power_off: Used to indicate whether we should power off the device
>>> + *                    when detaching (true indicates the device is powered off
>>> + *                    when detaching).
>>> + *
>>> + * NOTE: this will also handle calling dev_pm_domain_detach() for
>>> + * you during remove phase.
>>> + *
>>> + * Returns 0 on successfully attached PM domain, or a negative error code in
>>> + * case of a failure.
>>> + */
>>> +int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
>>> +                       bool detach_power_off)
>> Do we have examples where we power on a device and leave it powered on
>> (or do not power on device on attach but power off it on detach)? I
>> believe devm release should strictly mirror the acquisition, so separate
>> flag is not needed.
> This sounds reasonable for me too.

Then I'll drop the detach_power_off in the next version.

Thank you for your review,
Claudiu

> 
> Note that, in most of the *special* cases for where
> dev_pm_domain_attach|detach() is used today, the corresponding PM
> domain is managed by genpd through a DT based configuration. And genpd
> via genpd_dev_pm_attach|detach() doesn't even take this as an
> in-parameter.
> 
> So this is solely for the behaviour for the acpi PM domain, just to
> make sure that's clear.
> 
> [...]
> 
> Kind regards
> Uffe


