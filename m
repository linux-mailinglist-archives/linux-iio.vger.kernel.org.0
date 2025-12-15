Return-Path: <linux-iio+bounces-27101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6FCBF5C8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 19:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CFF9301AE30
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3D338901;
	Mon, 15 Dec 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iZ/4CjFk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EF337B87
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822176; cv=none; b=soGUufE6WkV7P3O7Mrj76ZH822rejhMJEfsJ3cZrZEfUl1BCaNMKMtbq/Zw+X+faajxEnRDl2C6e+4Kp3QvAwiC7RdElw3dMERmOtjo/Tj/TzPk56DQi68/pdUcuL6HzQs8PItAov8HaIDsyplYi1PzXHBNPDukvXcLT3cc8uGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822176; c=relaxed/simple;
	bh=jJoPLn1fkI9wPRU/0HMgfFAMd/C9HMYFq8hNraw6c8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpwEAquRYvezqmB/hC2XW+HO15QOk88CvK/Y3JMGOFpo+YgPB/lfzavq0Jo1IlG1l+2SzZ5HXaKOR7aVA+pVr337P+51YL87EnDyADL0X+Na7Dss1ibjOzmlF4176t13T+GevRQ9SW4bDDHu8KkdY5vNLYJI9C3vv+sNVc761rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iZ/4CjFk; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6e815310aso2812950a34.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765822173; x=1766426973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8D3gbs8j8tMtsoO/hc4EokJzJyu5XdrUi05ido4tmo=;
        b=iZ/4CjFk2LA4hX415hTiI2scaCuQDIqgruse8zSwUhG67SY1JKd9+WLPc+XsAufsDE
         Zn+vlHK63b2G1BZdmfBuGnl9cmlGegXdismUZIIe1FhuTYOiIAaIeECCGmSpF7m5fPHX
         GyjULtfMSKpcOWeO78IQjTA3uAEbvN7Hmpnt/0kBSEbILMPJbZlXOaz3xd1DTbcP2yPd
         eEJB18HgDVEkzVjgRKKrEInjuxsMKFI14p2yYK4/i4P9ABLSfCVvb9ePoBidaBIrXKve
         /e7+8utLQ3hYWNtTqano7HKlzYs/wu/NrXV/A+nLtASlh8/7TP4YVV3OdSmX71DB2WCB
         Yr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765822173; x=1766426973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8D3gbs8j8tMtsoO/hc4EokJzJyu5XdrUi05ido4tmo=;
        b=X2SpQlL+tyDSPiJCgcYp2iOqJy3hghmxQ1u+nQkm5y9KRA32ZCVuSdFvhE+9FhQq8K
         sW+X+LQZpWV1IpSPCnubzstI4TF8acX+jUKoAMAXUc/dxueoD6XQwBfjj19YlpDa9YqL
         eo4iCl/zR9+W8CFFQ6ZbfUVlE4q7SnQ8i5taorpSyehlOJ6KMc2d7SbPnFrG3ZyHFBd1
         n24ua7VxQuIKnbB9z9SY6MuSjrgAnDcwAr8njiDigL2OuhKto8cxxEFZMay1Ob/Fz633
         ycWDecq0acQP/EYPQosBSQouczRodv5wAAPuNKeN4fDPb9l9SnUQNCLsGP1z3JJKy7Iq
         VC7A==
X-Forwarded-Encrypted: i=1; AJvYcCUzVrB/i+DD72XLHGWpupk19hcJmaF7msjVbWmOwqcb1SJW4Wij1h1n4dcjsxVIqg+JcQpa4rpnmmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuujDNyVn/vIr3EWlbHCA78f2peFSoq65W6TdoQ7Db1cqomAMb
	tFvlawUKcrGTL3yn+LE47InvONywtkaXxnv3aIEPR/APi8IAjM2aLAHIEWNdQwuWPhc=
X-Gm-Gg: AY/fxX4SwBQFcr5S8GN8cFM1Sm87Na/OF+UHqE5kZTj+idA2OslPAFgFMNUw6qb2n7O
	9GYJTtiAmfsH3hrCbLqQ80CyNisTRT1jz7FNu0UC4sgfVQdUeQ13I1PVU5aJNAJHVbHapWA64B9
	bbJssDomLYVD0xBIEYQh0VwYmLMeK9BpoGNlc01NehMpTQFb7Lq6V5YwLtoj9yH5sBsnwMmbDCP
	uSFLZWZDndTJ/ILDWUrl645mjiIscCFbbJWxxc9f8wI3745ohDdPIeeQo/ZwNNV8kJosphMzHw+
	VJvlaC3EKtV4KHJCXrYCYHPc7OvmKjM7eRvTR2V7968ilfk/WMcA9EKqirKzHCZ3nxS0Twe3QiE
	Luu/hDbwVNGNzMh0zDKY2hObb3WfGzFIq4udNRF+yb/huO16+1+w/is3RjQAzmBWSeSdP5fihj0
	DcJDArcXUJcvJr5vbFCmT7gtdqukwamq0OsJaLAyUa5RDFyysumZ+iBDn47B8u
X-Google-Smtp-Source: AGHT+IHHsNWWpcFL7pxsMf0NT+Ch5aoGLcrbIOKR0HmNu8rxcH3yGMLa5YDaJGBvj/3gZjcMR41VGg==
X-Received: by 2002:a05:6830:4c08:b0:7c7:54e1:a3ad with SMTP id 46e09a7af769-7cae8366e93mr8570713a34.17.1765822172981;
        Mon, 15 Dec 2025 10:09:32 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb2fcc39sm9838677a34.19.2025.12.15.10.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 10:09:32 -0800 (PST)
Message-ID: <bef2e71c-fd76-4e73-9e53-422f9fa96757@baylibre.com>
Date: Mon, 15 Dec 2025 12:09:31 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
 <20251211-ads1x18-v8-2-5cd12ac556da@gmail.com>
 <064e059b-5c86-4c41-8de8-b6a728361fd3@baylibre.com>
 <DEYY46ZUJQ35.YBNYWLGZMRYA@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DEYY46ZUJQ35.YBNYWLGZMRYA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 10:54 AM, Kurt Borja wrote:
> On Mon Dec 15, 2025 at 10:55 AM -05, David Lechner wrote:
>> On 12/11/25 10:25 PM, Kurt Borja wrote:
>>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
>>> analog-to-digital converters.
>>>

...

>>> +static irqreturn_t ads1018_trigger_handler(int irq, void *p)
>>> +{
>>> +	struct iio_poll_func *pf = p;
>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
>>> +	struct {
>>> +		__be16 conv;
>>> +		aligned_s64 ts;
>>> +	} scan = {};
>>> +	int ret;
>>> +
>>
>>
>>> +	if (iio_device_claim_buffer_mode(indio_dev))
>>> +		goto out_notify_done;
>>
>> This should not be needed. It should not be possible to
>> exit buffer mode without triggers being stopped first.
>> (No other driver is doing this.)
> 
> Previously I had my own lock here because ads1018_spi_read_exclusive()
> needs locking.

What exactly are we protecting against here? I.e. give side-by-side
lists of possible concurrent function calls where there could be a
problem.

Any call to iio_device_claim_direct() will already fail without
calling iio_device_claim_buffer_mode() here. And since this is
an interrupt handler, we don't have to worry about reentrancy (it
can't be called again until the previous call returns). And nowhere
else in the driver is calling iio_device_claim_buffer_mode(). So
calling it here doesn't actually add any protection AFAICT.

> I dropped it per your suggestion in v1 I believe, but
> given the discussion in the cleanup.h series I was thinking in bringing
> it back.
> 
> But yes, the scope can be adjusted too.
> 


