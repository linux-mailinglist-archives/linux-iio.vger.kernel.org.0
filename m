Return-Path: <linux-iio+bounces-20203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD3ACDEEA
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F65177048
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BA28FA89;
	Wed,  4 Jun 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1KcnaBqG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50A28FAA0
	for <linux-iio@vger.kernel.org>; Wed,  4 Jun 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043318; cv=none; b=Vqa4xxCRsLFzZ2gNfbbyVFT6ebUY7FIDbIX6D8sPHH0fwpYBLrZpjmJRzsF2fx4rnBM3bOl6eS9O0EL2TAtOOSVXegVjmp8V1Gwb4xJX0fqOKxI0oKtje53tKuXeh2nzOXWYmbkLvMWAz4YtriJlaiwXuEFnSt4ittx9nWrPV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043318; c=relaxed/simple;
	bh=dbA7qnY0vkNuQHcmJgwJbq1/AuyJ0mzf0CTGLPRhOVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbHynFKXTumm7ckp5EJ4sv0nqliNvLecQgp+Khfw5n4tNG0tRX+lRkcByAjoVLQ2GUGZPp4SE41nsTYaJxW2Fx4qKzJH5hs/GWobSThXcmWP4XuPdIzrr5enhCKofKkkYidpPuDXNsmoikg4VAp36mz1OdLBwZlQTbKsU0gsXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1KcnaBqG; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2cca475546fso5332269fac.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Jun 2025 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749043315; x=1749648115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42EU1sJyYdG5F1cgKizvK41dUy6Q1Og1sjraWSNVWMs=;
        b=1KcnaBqGQcNTorNWLkXd9T95VZ8JkAq0oRO1gVhebAS9n0Q9yAPa7SbZeYaqYP62PP
         o1aXsVQaXv4WIZt+CWtm8sR/c/uFLUPhCOySGlaxyFZ0SBjN4jDQOtsNzA2Wy319qUqj
         yx6TVh6ugoMnQjekJMeXvHFyZ8gL3PDmOFSxbVBDjCEYLph7JYYXqLMQkUDT8IVT82LN
         +lYJetb7Lc/zj4G/H6eMtyNqVxFRcotm/WuAmgg6SA56XgHCyMkwgDTEJ143MT9FV3IG
         ss22J07ovcC9w66eTkNv0ne+K3MOgqvY/1asj/4jBkgX5T/UyyYsnGFqP62ctrWZ+p//
         kuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043315; x=1749648115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42EU1sJyYdG5F1cgKizvK41dUy6Q1Og1sjraWSNVWMs=;
        b=X0tC7zBNhshmwDvTWeVN2bIkjOj4TqZVJ4hmxJ0heiw+3KpDIgj9Sx95CbjNXsgHeg
         UjEBgPAb89GIMZseIF50gjy9jRzmEu8QrosIpMk806yrsnZBPKoWoWSJNpRxe6Vyn6C6
         TxoHz+P1qB0T0r9Ku34SAGGD4BTaoyHw41JUf4fkVeFV/3TBazKLK4HW4f4wJN+v805f
         NabYoyHKBptwMF2BfhWg0bNmKkHCrPjCTNg+qyPvORlHd6j/bAZk7cYjXRp38vTZhXgk
         xA6uIiaGTTe+46F6/wzWAMd7xf/1NPKO4/pFyBEAFxf80gE/6or4HmYh/cllCgjpYxyp
         CkYw==
X-Forwarded-Encrypted: i=1; AJvYcCXaKB+qXq9Mk/zYXizgFc92ich3R0b7BQGPr1r+VLsO4fAPRYIoJ34QkKzKqqJ75V1r9bUPuQDXPgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeA7pNLekeTVtTdYeYnP8BK8xCtLu41/LTHtRdy4reoGCuZ0az
	urIXgMwykQJxrLZ07rohrjOEAjCJCOasAUNWCLx5yez5FP9N6ITZrSC5SOD+KeSOCx4=
X-Gm-Gg: ASbGncvyBel64V9buoGy5FkHYsuohC6aa+hVk26l5HkccFCioC4wp+i6bcFiBn8PO2h
	/GdCpT5uS3kPzXOU24kwz1JPplB982hrJ0Qz6mbS1RZ7SCR8y/Nth8QMKddIQ46LjE1BTKUGiDs
	UIRL1eFkpscHQO42T9QsOk9DQTlDk34YlBYPtVubFctI4DFKji5sLeI6fugO2fvmKqh1tY6vjCV
	F6eXoD6TCeaC1wBKQFxb48RZAUE8R4kmKXPUnpYzRcvhqm7l1qogQLvyEfiLToV3l3sekoRZug3
	ruU+ZQgr/I79EZKVp5Nfo4U8jTX+U29p2nBNnIgJzcUhJpz0FwXYM2+0ZDylaAq9XArNIN849IN
	M7y/cpb9epPnzx+rO1/mlR9r6D2IpSTIvmhXZlR0=
X-Google-Smtp-Source: AGHT+IEeJlq8acVoI6eGj1GQFdyqUT4Gx77dcBUJqg3CfYkU0wTl237zJBQxk+ufigaGhCyRnVkMlA==
X-Received: by 2002:a05:6871:42c4:b0:2d4:d9d6:c8bf with SMTP id 586e51a60fabf-2e9bfc6c923mr1651646fac.32.1749043315015;
        Wed, 04 Jun 2025 06:21:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:56f4:67ce:c6e3:8f76? ([2600:8803:e7e4:1d00:56f4:67ce:c6e3:8f76])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e906816c51sm2622910fac.28.2025.06.04.06.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 06:21:53 -0700 (PDT)
Message-ID: <3ff77f5c-b13b-49f5-98b0-a799453768d0@baylibre.com>
Date: Wed, 4 Jun 2025 08:21:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] counter: microchip-tcb-capture: Add DMA support for
 TC_RAB register reads
To: Dharma.B@microchip.com, kamel.bouhara@bootlin.com, wbg@kernel.org,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
 <20250528-mchp-tcb-dma-v1-2-083a41fb7b51@microchip.com>
 <b45ea46b-3e17-4cb9-8e69-9eea0a3f8241@baylibre.com>
 <27407669-a580-482c-8c60-226b56562ce6@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <27407669-a580-482c-8c60-226b56562ce6@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/25 1:15 AM, Dharma.B@microchip.com wrote:
> On 29/05/25 9:03 pm, David Lechner wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 5/28/25 1:13 AM, Dharma Balasubiramani wrote:
>>> Add optional DMA-based data transfer support to read the TC_RAB register,
>>> which provides the next unread captured value from either RA or RB. This
>>> improves performance and offloads CPU when mchp,use-dma-cap is enabled in
>>> the device tree.
>>
>> It looks like this is using DMA to read a single register in the implementation
>> of a sysfs read. Do you have measurements to show the performance difference?
>> I find it hard to believe that this would actually make a significant difference
>> compared to the overhead of the read syscall to read the sysfs attribute.
>>
> Hi David,
> 
> Thanks for the feedback.
> 
> You're right — in our current testing setup, I didn't observe any 
> significant performance benefit from using DMA to read the TC_RAB 
> register via sysfs. I benchmarked both DMA-based and direct MMIO 
> register access using a userspace program generating high-frequency 
> capture events, and the overhead of the sysfs read path seems to 
> dominate in both cases.
> 
> Our initial motivation for using DMA was that the TCB IP in Microchip 
> SoCs includes optional DMA support specifically for capture value 
> transfers. I wanted to evaluate the potential benefit of offloading CPU 
> load when frequent capture events are occurring. However, in practice, 
> the complexity added (especially due to blocking behavior in atomic 
> contexts like watch) does not appear to be justified, at least via sysfs 
> or simple polling.
> 
> I also tried routing the DMA-based read through the 
> COUNTER_COMPONENT_EXTENSION watch path, but as you may expect, that 
> ended up hanging due to blocking behavior in non-sleepable contexts. So 
> that route seems unsuitable without a more complex asynchronous 
> buffering model.
> 
> Would you suggest exploring a different approach or a more appropriate 
> interface for DMA-based capture (e.g., via a dedicated ioctl or char 
> device with async support)? I’m happy to rework it if there's a suitable 
> context where DMA adds measurable value.
> 
> Thanks again for your review and time.
> 

Adding a feature just to make use of something a chip can do doesn't
seem like the wisest approach. Without know how people will actually
want to use it, we would only be guessing during the design of the
userspace interface. It would be better to wait until there is an
actual real-world use case and design something around that need.


