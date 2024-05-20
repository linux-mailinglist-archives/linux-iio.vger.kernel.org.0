Return-Path: <linux-iio+bounces-5145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED308C9E7C
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BE01F21C77
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759C13665B;
	Mon, 20 May 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XsZf+AyQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C67136648
	for <linux-iio@vger.kernel.org>; Mon, 20 May 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213555; cv=none; b=Cv88IdNKnaWghfD3Ki2U/iLsN779ruXaXjVXEqzSLJqiJppqpEKYPCmQAqVixqHaxRWpMutwlkjDv8eOzxmiAYLAht3ZlpNvETtD/3q/RQwzLz3FiIMz6UKd3DmZx81Pa46Z9Ei2rVOPNv+a7wXvOAeQrZjsiCu155Mafpd03qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213555; c=relaxed/simple;
	bh=auN7ajgDFQ+TscwjsNo+1lNRLK44QGFJmvB3kaABhgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ck7INiOQ2zuo110qU0X1XbA2jNB9ElzJU4FG4srleVOqqN2Qmp+vu7QrGFsuP5v8XM/hj9ovdcDIX7RV7Pup2Mhi+27eUgYAJg3Mwh7ZCLDuCyTd3/RnsOaCRnVDzaZywCnrHJQBRldsawgoGrVKcnu+ob+nq/k3lWQExAXKhY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XsZf+AyQ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c997f50805so1192010b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2024 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716213552; x=1716818352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRk7efIpjrHKK8mZq8D2p4bRXd76dFjkrEncDkyuqMM=;
        b=XsZf+AyQy+jq35+HnBi5T8BmMfYerbYYbXwKKYAxvwf9K77c6nN46D13X6cWOZm06R
         HWfZ19mngtZhWI5PMOzjOUEXmss60BGvQZGuKTPOclR0SWULEZ4e4eLi5kXBXtefBuQa
         iSWeG9nGV1/9cws1Q/JS00qDqZUQZSOByXbE+BnKZqjInbaRMZyjI5GNFC1lwZKIFRG1
         Bv8Ab0vrWxE/YNYB8hLpUdVmv3kPAJFq9YZAXQ0D7NdU728fKMdxRGeb8sbHr05qUAZm
         nwsonJy1esv+QxTdTWgdbSD0TlCFG6mF/s30uDht3kEdCyrDWHDAkOitXRBrYhxA5QbP
         NFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716213552; x=1716818352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRk7efIpjrHKK8mZq8D2p4bRXd76dFjkrEncDkyuqMM=;
        b=EhcE7kCNvtP7GVklmA4HVohvmTGS4RhR4gSrPywoNEy0mIm0QgxLv+aVDcavXR6l0h
         u0X/SQKffTiqzjd8SK9fS3deQa89XSpjHDlMcC9Qn9pHpWokhpn+8koBDdgWsFpOewkD
         1Nl+usb0i0vOcfwkyhp6tGUUNadOAju2pVNZBo6c4buc7Z85bzuZmJ23mhDPom5FPDG2
         RIfnOqYru6h2AvqBW+UqO1rE8NQLFsppCYAKWYaqr81AOt2xQRsP9eVd/ASWN6q0I66s
         1YA6eBekXcXDICPOw7/v+v8irTHC1ctYEHKMa0R1lBSPv+eP2eOL7ASGgfxGSAK8HUcz
         K52g==
X-Forwarded-Encrypted: i=1; AJvYcCXJiGXj6BfmLerZbblbt9+pTS+0xZLtTfZ100oV30W/8MqA3UPm+ZYMNr9ql5PXe8JHV1vt+iiv+SOTUTPbM/C4SjsWOojRv7HJ
X-Gm-Message-State: AOJu0YyGV2a15W/AOC9s+2fZTgRhl8BR2UwF2f5V8QwQTJi/6dIMLJtV
	C1rwhLQlgdaeBJZaSFCB5hL2YAlrypRPqlzRkhWEbMtGdJhNFXqng8EHRX7dOOo=
X-Google-Smtp-Source: AGHT+IGAJafPJAzkp9+IXA/K8JKbMbU7yk4n7qr30M6RhtuunPKyLY2TXFyvUia3bR42SD19HYBcrw==
X-Received: by 2002:a05:6808:2391:b0:3c9:c30f:801c with SMTP id 5614622812f47-3c9d3bced71mr2401887b6e.10.1716213552634;
        Mon, 20 May 2024 06:59:12 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c99e8cf09csm3199848b6e.39.2024.05.20.06.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 06:59:12 -0700 (PDT)
Message-ID: <11c97f46-3881-4274-8c36-ec88218d3e60@baylibre.com>
Date: Mon, 20 May 2024 08:59:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] iio: adc: ad7380: add support for multiple scan
 type
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
 <20240508124049.00001661@Huawei.com>
 <CAMknhBFob4Wd8Gm8W8NKSuL9UbBCY8+fAN_voGPhb4Fy1tAT-w@mail.gmail.com>
 <20240519202039.5a70157d@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240519202039.5a70157d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/24 2:20 PM, Jonathan Cameron wrote:
> On Wed, 8 May 2024 12:21:09 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On Wed, May 8, 2024 at 6:40 AM Jonathan Cameron
>> <Jonathan.Cameron@huawei.com> wrote:
>>>
>>> On Tue,  7 May 2024 14:02:08 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>  
>>>> The AD783x chips have a resolution boost feature that allows for 2
>>>> extra bits of resolution. Previously, we had to choose a scan type to
>>>> fit the largest resolution and manipulate the raw data to fit when the
>>>> resolution was lower. This patch adds support for multiple scan types
>>>> for the voltage input channels so that we can support both resolutions
>>>> without having to manipulate the raw data.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>  
>>>
>>> I'm wondering about the control mechanism.  I was thinking we'd poke
>>> the scan type directly but this may well make more sense.
>>>
>>> This is relying on _scale change to trigger the change in the scan type.
>>> That may well be sufficient and I've been over thinking this for far too many
>>> years :)
>>>
>>> It will get messy though in some cases as the device might have a PGA on the
>>> front end so we will have a trade off between actual scaling control and
>>> resolution related scale changes. We've had a few device where the scale
>>> calculation is already complex and involves various different hardware
>>> controls, but none have affected the storage format like this.
>>>
>>> I'll think some more.
>>>  
>>
>> Here is some more food for thought. The AD4630 family of chips we are
>> working on is similar to this one in that it also has oversampling
>> with increased resolution. Except in that case, they are strictly tied
>> together. With oversampling disabled, we must only read 24-bits (or 16
>> depending on the exact model) and when oversampling is enabled, we
>> must read 32-bits (30 real bits with 2-bit shift). So in that case,
>> the scan_type would depend only on oversampling ratio > 0. (Writing
>> the oversampling ratio attribute would affect scale, but scale
>> wouldn't be writable like on ad7380.)
>>
>> It seems more intuitive to me that to enable oversampling, we would
>> just write to the oversampling ratio attribute rather than having to
>> write to a buffer _type attribute to enable oversampling in the first
>> place. And other than requiring reading the documentation it would be
>> pretty hard to guess that writing le:s30/32>>2 is what you need to do
>> to enable oversampling.
>>
> 
> Ok. Few weeks thinking and I've no better ideas.  Generally I'm fine
> with how you did this but I wouldn't have a 'special / default'
> scan_type.  Just put them all in the array and pick between them.
> That avoids fun of people trying to work out on what basis to
> prefer one over another. 
> 
> So tidy the loose ends up and I'd be delighted to see a non RFC version.
> It 'might' be worth waiting until we have a couple of suitable drivers
> though and then show the feature works well for them all.
> Whilst I think I'd take it with just one though as can see how it fits
> together, but more than one driver would boost my confidence level.
> 
> Jonathan

Great! I'll do a v2 with only the core code. Julian, Esteban and I
are all working on drivers that should make use of this. So if all goes
well, we should have 3 drivers for you this release cycle.


