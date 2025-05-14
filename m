Return-Path: <linux-iio+bounces-19506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B4AB62AA
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 08:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EBB3BEEED
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 06:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C61F428C;
	Wed, 14 May 2025 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN1XdzFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0D7483;
	Wed, 14 May 2025 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202429; cv=none; b=lWgwHBzx+udta3PRAVGU/WSU+8ACOrzh6vfTQIEbM0RH0VqashlhNj/xa0z5dB+sjqBkwKXYq0yi0hyEET4BfYsfeRf8vsHFIocCmjlS8y8+nXkU0rL3eBWNRWuFYHj3qrXoANP+GvGi0MIoayu/h1kgjv1Gah7lxpR2ExYIckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202429; c=relaxed/simple;
	bh=LTvjPdSM/7Mv8CGzfpe8AVTP7p3kG1fD/++sDIxZ0CM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D4TlqgTih5OZLXWifmiC8VnHEuV04SVDgQYIAgBUlBShhgy3zCrt0vISZQvbkNYNvTJJzwN4Sr9pD2PfR0Z8EPm02Ew2odEkm0NgZY40yJw8vMsLU4EtUpHV1UOWkiQu88zEUoP9JP2ub0A7kl8beFWi/G70LamErVin0DOB7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN1XdzFK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54fd1650b83so4409415e87.2;
        Tue, 13 May 2025 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747202425; x=1747807225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y/kcGJ7CLXMTcnNn4N0O+1wowJptCExoAqGctHLNqIc=;
        b=UN1XdzFKhFzvmd0eBxk2Kn74ZWS7H7RhEvYe9oXAYspJPKki14GHNUX/Su1z51Nfrr
         StKnFCzW3GSfePMdMaxrTNCWeF4UnxTTBBJIRIlUNE+YbL8DlZdK6dDbWI68bwjTlSzT
         hZmG6nR/Nw+bIOQFgZdVNsJCb83aA4Tr/ZO5j2etBI+e7JcFJAcwUcos4xn6T0DM9P+/
         C9exppFiJ6h4F4LD1nXaaqd5fEkXywm+4u/lh3zqlmBEtFCe+QiahbpD8lv0umChFMdW
         EX6cJN9sXdpyeZDGTl9dT+xCZSR1fjd3uoggL/6/p+gD73JX5kE21Q+sfmyGI0Efi06x
         TIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202425; x=1747807225;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/kcGJ7CLXMTcnNn4N0O+1wowJptCExoAqGctHLNqIc=;
        b=tcPPq8hBC3O2BMyhYvZVZEO04LU+CuHYr2Wwwc/Vo8RonvNGB5VG0K70pVlD3WAVQq
         b0pYSwbZ+alqlAIwU4M5U8BoobXmwiMDP2Wuc3WZ6sG4U2DUDSmkgbeOiPRUQHz6zAKr
         cW0dTyS70VqxwQu0j/RzPu9qM1Tk83o2NGqD8Br+MrMVXclS/WHvq8T7dpiakdbbd9QP
         kULs1BtZ+PLD6Nna2hrsH+zZ6qv/tKfDntdryXsBJg+dHT93/oLVpm8Oa80JzXtk2eeT
         h6OUhw4siJ0Lca1amN2WxS+xpNo8H+M0k7ZteZZfmnBOwSCBKRfb5qafiG1sZkMkjtsv
         v12A==
X-Forwarded-Encrypted: i=1; AJvYcCU8zuztlVF/nf62Yyio8UJ0e7CeiT+6MaHAGM8rAUlRHN0PGYdD/My1siM6ALckKF3NWpQ5Hx7e/sW3@vger.kernel.org, AJvYcCUPiuv8DklpAoqqf8tn74hyrn8eMFBMqVTMs3eK2Kj5mn5tsO/EHLVmb2VrDcrS1Mt7BlxRlCBc0WtR@vger.kernel.org, AJvYcCViGkJXHv0iP5Oa6tlOXE6++Blbtb7r6l5xEEOmHyH5QJHArS7So6njsQYFr2OGDtQk6S3gZxxLpntRw6fW@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJmUcA9f3lF1ALds4/PfEJfioqv4kdPzrCC1koC57Ngwp/czf
	QCZ3nRUHYKA9YjVn+z4xUYU8rNicSDb3cRzB7oSQSJM4/fPcFuxgrgvqSw==
X-Gm-Gg: ASbGncsPGQBlW9ORoaVQau1AdEuwBSfb4MagKjQWEKB7RUEs5WVMMZUO9i+hcMtCjro
	lW1LSu2xIt2TGz+QQj1L/XVnt90lmgtGadpC4lJiiZN0eQFRM4AjggRFlBZJfLWiwccPquzLzED
	BhADlfDGlx6ey39rg/1BD0URi0BBxwWbiRtAiL2YKwYIaX3XJC6W9uXsiITnPuwb2EpB+w6rmWC
	HsFcg7LMh8VXv88N/vVKZpYcAMnVrrJAABSP6PfH/F76jm9WaTvwI1mvMhzd+p4ntw6IVuBdn/D
	rIlU1x60BIOUY2hkoTuothlnjsanPm1raHxgoh8TnvrbYd8oWk/vK3kz4+7a3jsGrbtQmyax/yp
	ZlrEBEAglKbHL5f8kjAA2IConq5xAL4PE
X-Google-Smtp-Source: AGHT+IGrKBiwzwMfRKuUQU7+APaLBY8NUIx6Vl24P5FvBWJQZN/RBiUSK29XlLe0bSZjg3O1/2dyNA==
X-Received: by 2002:a05:6512:670b:b0:54b:1039:fe61 with SMTP id 2adb3069b0e04-550d5fbcc69mr596543e87.33.1747202425195;
        Tue, 13 May 2025 23:00:25 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64b6ee3sm2110577e87.126.2025.05.13.23.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 23:00:23 -0700 (PDT)
Message-ID: <876dc584-00a0-4810-b31e-daaa9f6b6597@gmail.com>
Date: Wed, 14 May 2025 09:00:22 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add ROHM BD79100G
From: Matti Vaittinen <mazziesaccount@gmail.com>
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
 <5c721d80-70e1-4cdc-974d-2007bbddfeb3@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <5c721d80-70e1-4cdc-974d-2007bbddfeb3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/05/2025 08:36, Matti Vaittinen wrote:
> On 13/05/2025 17:39, Conor Dooley wrote:
>> On Tue, May 13, 2025 at 11:26:27AM +0300, Matti Vaittinen wrote:
>>> The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
>>> no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
>>> The 4 leading bits will be zero, last 12 containig the data.
>>
>> I think it is probably worth mentioning why a rohm device is going into
>> this binding (clone?) and that the 12-bit thing is a differentiator that
>> is why you're not using a fallback.
> 
> Thanks for mentioning the fallback option Conor! You're a hero :)
> 
> Now that you mentioned using a fallback, I believe I can ditch the 
> driver changes and make BU79100G to use adc101s as a fallback!

I mean, ads7866 as a fallback. Sorry.

> 
> I didn't even consider if some of the existing devices were (from SW 
> perspective) identical. I was just happy when I found there was a driver 
> supporting these simple SPI ADCs. Then I picked the right macro for 
> doing register data conversion and correct shift, dumped in the bit 
> width and extended the longish list of devices. I never checked if 
> another device in the driver had similar set of "IC specific values".
> 
> Yours,
>      -- Matti


