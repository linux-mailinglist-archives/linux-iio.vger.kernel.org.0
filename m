Return-Path: <linux-iio+bounces-5986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEAE8FFFB2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF551F2286E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FF915B569;
	Fri,  7 Jun 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBPpwS5k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A115B141;
	Fri,  7 Jun 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753074; cv=none; b=uvatmYqx11kCMNbQEDR2OBl5B0m3NMd3GQtZlQtDH7zS3Y1MCX9SsZqL3MOq6YaguAd17o8ahaW5//KteIz9KSPK527ajh5/rQnjJt+oL8xiy5F2WGAu68e5FhMqdGYS71WOg/SCLbjg4upTRwk/uSpQP0b80dtSc0zisUDcR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753074; c=relaxed/simple;
	bh=K6gZoOQtUsHQrzfBeJp4rAsL4kI+EenvXrZYu3JA9uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qddxfuq398wj3TRvPqEjYE03Uq/QFtW8xmSOACkgqkpelOePdOtJ6NoryZsBSbogE8yX6wZAieBbKF6zXJXGIYYeIb2+SQIPkM3SSZsUIR6V7uqL03u91alFroqoV86ljutSEeULakZ3uCrXCOJKUjYhoxIhBWPg0U43T3YXQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBPpwS5k; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso2386197a12.1;
        Fri, 07 Jun 2024 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717753071; x=1718357871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPkjmu28lH6Uj5/7lKqJK9Iajt8blRgiQOuvXtrYh2A=;
        b=KBPpwS5k1LxCepuLLXotu75Lrp0/GVuufNGyaA92OtTT4C+DSvn0lORzlLzC+U09pe
         xIX5Zjxe/mUzFYsLHbSjPNzhI688G3JgixQg3rqU9yesUIQVwAXt9aa6cWIr1jZO5TfS
         +lM1b0+CHN+bxEebGBQZGYTE1SfzOK1b9ILrRMEHXcffYKP20l7Anpn24ylzbuPqwPnH
         u0BIA3w9lS2hwp8thRLh4aBk4upKKtONVdifMQyMoZLTepXMDYP+nrFWQtXOzej0T46+
         M4YFx/QCHM7tbeRsn4zYy0wpJIg1XFPD+xC158yjdEwJ3v2+sf6rmiLpULUieiGGYK93
         /08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753071; x=1718357871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPkjmu28lH6Uj5/7lKqJK9Iajt8blRgiQOuvXtrYh2A=;
        b=NmGXLHP2n4SMmX5uPcDISRbPbsGQ76cB9Uv95+62iQxmS0lbZy7QUr944YE2yyrxqE
         f0mDMDY1MBiS0hwWwch3AMGhtDQbYRkK5gWaBT4qHBFRCjvsqBLfadUYTdUg7ZmGGTrF
         CLBsq/uNjnkVwHmEAh445XEJ4X5VkLzfbKsYwv/bjepsjayr2o4XlhPj5crCrLGJN61t
         Hhh2P7XqlNzlcaLYdMikuIz3+pG6C5oY78zE66FBfuFSOB5B43IVOY1XUmqLnE5PqEEz
         enKvL7ntAfF7GjVvC0+TFIjE9UPwuJfiwkMDhqa7mwx1CnhMQ6hhJ8eJdnwTa2INpJiP
         n8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVb/aAG7EiU/VmqHhdDRyJ+60vd3KAf5vSDsLuUxAKDbo6ddbdSMIFAZH4DUSRjp4sCajf5dcxmpPueopFEjS0I3sf3tLzawtiMEruwgycxeUlYNjrj0NthS5Q9KyOHcSNgOjuGijxwjLKSI9UInThMX0uC4IJP1aQDGiV9cTL4cxq4vQ==
X-Gm-Message-State: AOJu0Ywrd70Ksk0/AU8yft5VG35DbKr3zk6Llm2m9JTOmOjbdUY8/QS4
	yKnUfhka37096WQ29XErA8LNK5f+0vCCDlTxTXTd8MWxM3Gztadg
X-Google-Smtp-Source: AGHT+IEAe5LCO3ZI2yvyOYYPO9oiA36X0Lk35OBt7QDekissxJ8NoDnTU2gFAcHjJFXYeFLZLnTTkg==
X-Received: by 2002:a50:d59d:0:b0:579:c4f6:dee9 with SMTP id 4fb4d7f45d1cf-57c5095cea9mr998753a12.34.1717753070572;
        Fri, 07 Jun 2024 02:37:50 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9ea35sm2448843a12.15.2024.06.07.02.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:37:50 -0700 (PDT)
Message-ID: <0f230e9a-31bb-45e1-ab86-b80b30ad8502@gmail.com>
Date: Fri, 7 Jun 2024 12:37:48 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] iio: adc: ad7173: refactor ain and vref selection
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
 <20240606-ad4111-v6-5-573981fb3e2e@analog.com>
 <8f74bb906951f56c753081af1462560fe98bc822.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <8f74bb906951f56c753081af1462560fe98bc822.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 12:04, Nuno Sá wrote:
> On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Move validation of analog inputs and reference voltage selection to
>> separate functions to reduce the size of the channel config parsing
>> function and improve readability.
>> Add defines for the number of analog inputs in a channel.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  drivers/iio/adc/ad7173.c | 68 +++++++++++++++++++++++++++++++++--------------
>> -
>>  1 file changed, 47 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index 8631f218b69e..4040edbd1c32 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -60,6 +60,7 @@
>>  #define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
>>  #define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
>>  
>> +#define AD7173_NO_AINS_PER_CHANNEL	2
>>  #define AD7173_CH_ADDRESS(pos, neg) \
>>  	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
>>  	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
>> @@ -629,6 +630,7 @@ static int ad7173_setup(struct iio_dev *indio_dev)
>>  static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
>>  						 u8 reference_select)
>>  {
>> +	struct device *dev = &st->sd.spi->dev;
>>  	int vref;
>>  
>>  	switch (reference_select) {
>> @@ -652,9 +654,11 @@ static unsigned int ad7173_get_ref_voltage_milli(struct
>> ad7173_state *st,
>>  		return -EINVAL;
>>  	}
>>  
>> -	if (vref < 0)
>> +	if (vref < 0) {
>> +		dev_err(dev, "Cannot use reference %u. Error:%d\n",
>> +			reference_select, vref);
>>  		return vref;
>> -
>> +	}
>>  	return vref / (MICRO / MILLI);
>>  }
> 
> unrelated?
> 
> - Nuno Sá
> 

Hmm, maybe I misunderstood "Any error log needed should be done inside ad7173_get_ref_voltage_milli()"
https://lore.kernel.org/all/71452f6882efe6a181d477914488617d28a38e2f.camel@gmail.com/

This change should be in a different patch or should it not've been done
this way?

