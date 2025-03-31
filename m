Return-Path: <linux-iio+bounces-17429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A7A76566
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1703416A25D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAC21E3769;
	Mon, 31 Mar 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l72e3j8T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5911DF755;
	Mon, 31 Mar 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743422869; cv=none; b=TkoiA4QwjEvOIpX7eYToTW9qwVKWcx47iIFNnXMiEPTne61aAqBX85KxUuRINl/B5Du0WGNbdtu5u5t0AKimLkepxJNv/Js+/d5ai7p93GgWxR+MBbCqNtl86wOyBec70hjmFb70EOW2mMIKfmcKjhVZv2V3JyX3iqL+so09cHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743422869; c=relaxed/simple;
	bh=3exQ9/6ggKwU/NkBxZMzxeThcK58sDIudztgsIwZLkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HszcFIWNQdGi4a7eCnze+6o0toBH7jbnwIrUuNsCe7Tg7KQyQugVU0GasvfB2jBfayfy1Sc6s0ZIYaRgQIarZeAIO6Tbg/gtaKW0vAOzLr95N+A7Ho8l/pGeUYVWr+3Q+FnaXcXmUEqO6gScgbIS+0Hwdi+26GaTxw5nQRBjRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l72e3j8T; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso42455541fa.3;
        Mon, 31 Mar 2025 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743422865; x=1744027665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5kjq5zrFz8CVB5pT2WH//d/o13BOBbZYV51NDz9WZQ=;
        b=l72e3j8TSA1Rzl5j6lO/Tsj0yrh9aUfk61XJ7n4XS1VuNHYoMck5ZdCxYlnmd6HfqL
         HiLeIRobK4+be3hYcsawA+IvtneXs+CJyheofpCAtnrqblz+xfj3HF9m9V5micd4Na+A
         +UHJgYOBQT1uZ7UcnJ53uHP4XmABIKCT6eHko2CkZL1dg8J9KNI6bihC+KnzQe2VgSfB
         rHNEqmXPbxiGNgCdTTJQLvFDST7xiM5dY2UMWYMJJUv3Fdfp+e2reg+sl1QXcg4cwadu
         Hs9Zf116vnV1rwTAN2sX7QH8vzSHrRLGpDka9H/8Oh8PellPL9mCBG8MWA62E0La1dkx
         tJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743422865; x=1744027665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5kjq5zrFz8CVB5pT2WH//d/o13BOBbZYV51NDz9WZQ=;
        b=lNFeYVBfHhJa71VEVRcaQw/8+ykH70w77qbMGZwD0U9pB4SajwZAChojub79jsbcem
         J2/zqelhBNKruCZkvdrvYL47z8HQ7qN4cQmcJW/u9ZhR5frOcO0hO07QY3BQDQCgxfdk
         KvGDhlExMe8sGtC0Ra78cIy6bh1fF6fI9RYKm7+v+27YgX8Pmnbj/YAq4mrA+rtq/IGY
         l/314xqoeIzDlDMYoZjqFEk6PGkRAtUCXJER2ibEtIfYkHDhjXBlRNngFg5ULk0njJIG
         IX9od7Bt34bmljS5YsTgQ6Bmh6IhTXLDDk1/TBKc4zhnsSBXAuU0mwE+JV08da7r8U9W
         cvng==
X-Forwarded-Encrypted: i=1; AJvYcCUC+kNjQqdovdZsSSRfrHf6HvgG2A4K+cMiSuq4pBbnLdl2re41uu7T3d6xSufBtxHLO18D003vuw0k@vger.kernel.org, AJvYcCUKI8HHeagcwS3gnrgqHubN/P/n1dGB9GnfpOX3Jxq5/woPQI3nOe+kSH3l4yC+FdGiPsDySu+YD1ek@vger.kernel.org, AJvYcCVaiSkP/M8tSZGoW8jCjc4RFZBgClQP4H+XD5GMmtjCNCl/7N5zf59pbdB4uO5wcF0/JTrs2X3EM3aNBZX2@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrvbTSET9zka4w7VWzSl6Ewwelai1jEZB1smOSq7IOi22v4U+
	UoIYC+2742XwkuU3N7VtGmDKzhctB9nLOzRYTq+aDy3tM5wQE9Y6O/uCBA==
X-Gm-Gg: ASbGnctxiL460n8JrR03E6M4QDw6G1MzyH7Bg9zuzvbyRxYoiN/hwOzZYoO4xC5fUUM
	Q/wBdXmIu2m91IpXe5mKX0Eu91XC6fZzMKs8jt6UO3qo9YO2JWVhjhTzp+TNOLJeTg76MPEwpUx
	9qE+x1IFLoytPRAzTEc9hci5b4xQru4pNHu6YR89vlTJ+/kBYFCTxTVi3fttlzt3mA4Vh5L8x1U
	HZdRkeytKrGdA+L817TWKjX15h6Sr53Ws0a1jszp600+DhKaqk1+ImEGPQ8EBPuWYBk0SOhPQGc
	By2wU4LObV+XV0fqDsVkoaiKiKs5S9CPW/XY7kUfnGywlyfs1/aF6Di3Hpuk0OPYRiPKGB7aYzC
	NoSlqyMqlCOoXbDvN340NbIwRHA==
X-Google-Smtp-Source: AGHT+IE3331El1knlH/omYZdMA2rZGtSzPZCFYb5QwIwuGeGaKBWYPPbgDndpBvlw7lX3KA4+u7MWw==
X-Received: by 2002:a2e:bd0a:0:b0:306:501:4772 with SMTP id 38308e7fff4ca-30de034b2c1mr25584491fa.37.1743422865244;
        Mon, 31 Mar 2025 05:07:45 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b8f92dsm13781341fa.114.2025.03.31.05.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 05:07:44 -0700 (PDT)
Message-ID: <7d871d2d-bb42-43d5-96b0-88f24987d522@gmail.com>
Date: Mon, 31 Mar 2025 15:07:43 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: adc: ti-adc128s052: Fix ADC value on BE systems
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1742474322.git.mazziesaccount@gmail.com>
 <babe1eac3de30aa22e09266de1f5521fa9e0decd.1742474322.git.mazziesaccount@gmail.com>
 <20250331121124.4fed1d44@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250331121124.4fed1d44@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 14:11, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 11:02:55 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> ADCs supported by the ti-adc128s052 driver do return the ADC data in 16
>> bits using big-endian format. The driver does unconditionally swap the
>> bytes. This leads to wrong values being reported to users on big endian
>> systems.
>>
>> Fix this by using the be16_to_cpu() instead of doing unconditional byte
>> swapping.

Appears this was one of the patches I should've never written. Nothing 
went right :) Sorry for the noise. I'll try improving for the v2

> It's not doing unconditional byte swap that I can see. The
> adc->buffer[0] << 8 | adc->buffer[1]
> will work on big or little endian systems as we are explicitly saying
> which byte represents higher bit values in a 16 bit output so on little
> endian it's a byte swap, but on big endian it's a noop (the compiler might
> noticed that and replace this code sequence with an assignment)
> 
> Good cleanup, but not a fix as such unless I'm missing something.

No, you're not missing anything. I am the one who just got confused. I 
am not exactly sure what I was thinking. :rolleyes: This definitely 
isn't a fix. And, as a not a fix needing porting, I may squash this with 
some other patch. I need to take another look at this :)

>> Fixes: 913b86468674 ("iio: adc: Add TI ADC128S052")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> I have no big endian machines on my hands to test this. Problem was
>> spotted by reading the code, which leaves some room for errors.
>> Careful reviewing is appreciated!
>> ---
>>   drivers/iio/adc/ti-adc128s052.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>> index a456ea78462f..d1e31122ea0d 100644
>> --- a/drivers/iio/adc/ti-adc128s052.c
>> +++ b/drivers/iio/adc/ti-adc128s052.c
>> @@ -28,19 +28,20 @@ struct adc128 {
>>   	struct regulator *reg;
>>   	struct mutex lock;
>>   
>> -	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
>> +	__be16 buffer __aligned(IIO_DMA_MINALIGN);
>>   };
>>   
>>   static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>>   {
>>   	int ret;
>> +	char *msg = (char *)&adc->buffer;
>>   
>> -	mutex_lock(&adc->lock);
>> +	msg[0] = channel << 3;
>> +	msg[1] = 0;
> 
> Given you are writing shared state why move this out of the lock?

Very Valid Point. I'm not 100% sure what I thought of, probably assumed 
IIO core would serialize the calls. That would've been nasty bug! I 
appreciate your sharp eyes :)

Thanks!

Yours,
	-- Matti


