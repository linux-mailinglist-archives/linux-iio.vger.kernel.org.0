Return-Path: <linux-iio+bounces-23898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C754B4A698
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 11:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794593A3477
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA1278E53;
	Tue,  9 Sep 2025 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4cs4zG1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C52797B1
	for <linux-iio@vger.kernel.org>; Tue,  9 Sep 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408671; cv=none; b=l7ZnTtKTsQMKau+4E1UXa/hLuzrHlZjCK3sD/vIOrA7JqqH7vMGc8AMfrox+oQgHzMVqTU6psYRlgvjmoqB461fsizvsmn/9Fpiyj1i+MJwJ2Sg3y33t9uaiVQUipqUKHRLQ9NkCRXgCPz5r3DC/TWyknaZiESf+TJ6USoGOsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408671; c=relaxed/simple;
	bh=npAdt2MXok2VEU//pTwTqp9KnuJyLtKd07PIs+LRgEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu+kcYXfNYzY0mWhxWYubvs232sU/85X4L7Y618I/Az0WRXb6WQhQghtU3cjzfLVdzBkaM45u0fIY6pjAxqemhvVKndPPziAIavxeNMBHj9zMRC1q+Bf3HgNIlgbDGihsKgpYRYMwJnCRn/QlkW55EkRaKZepetDRk7120/YZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4cs4zG1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so2682451f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Sep 2025 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757408668; x=1758013468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDNp+09RRMXcmw2av/GSmihaAI/fIen6tu2gvQNcAWI=;
        b=s4cs4zG13o5VtF1N/OFW3trPOTnaJEeWsEDl0HR5iAyo1JTPztHqa/0ogfSb268Gsy
         jVgPLlUHCLBjEAMGJdPL5YDXrrAXshoTcBj/ZSKdFmGG/3J5oM68dmslH4aDs1lOU69U
         TfiEmr/OAFp2AzAFMMBjHZ4jsuRZvrqYOeBXjfsWESNxHWrLSJvBeazNFpmkrd3h2uyf
         WTTuWFElH2U2+6Ll1BCX20JM2CsgsaTpD763BIpbA/fxKnuzbD4VoXUzt3W94K4w2y5m
         JRvrdeaPQiEzAeJP+PKt8OiykFp3TWIM2xtuSECzRxCYdpkgtBIVp1Ms9K2Pp5/nOIcQ
         gAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408668; x=1758013468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDNp+09RRMXcmw2av/GSmihaAI/fIen6tu2gvQNcAWI=;
        b=cG4Hz6jxka1ytLbNQ0UZt8gHx/WF6+Hi9eFvlCF/2m12iw2qByC7weQxkMgnp1zOlZ
         dNVbhtfiEsiqX+Q0k9WPFyuqMLqjOWrR5wCCEPyLGy3pSsN83ovKaOUeW1TsH8BHmoJc
         gbKQSyW/R3lLWtsM0Tq2ZaTBBN3hh8KSShnljIBi3hYT3Ea2bbepZzgQNHGohEs0cSgM
         qYGoYAlBHLdQCGjmWlr9dmAFTZA0zxCM0ddsS97ECQRXFzDWzbgjH9gNRnH4MMo0Zo9d
         1o0cOEsHqYnTzH3R8fM+JnSJpZUYlFQkCw1TuDiR85zgD5O28kXjStzJTjnLmak1T7Z4
         C7rg==
X-Forwarded-Encrypted: i=1; AJvYcCU/iEaROndQ4XV2NW2NGCFqur02KldYP6Y6sXW0Njw8/3LaXEOkSKRMQksb/hn2EkXpqFzZao41Qm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYpqGpYfaQKj3SgWCFLm4vR9TsHApCKsa9XLqdYFEmR7SjxqD
	wWyvKE9bC6A2kotuV9yHS93H1BH5IRKgUtE3IA15AABqPuV0rgPD+9AwHi9H9iKiJbk=
X-Gm-Gg: ASbGncubntDyjsO0yyc+srCtcpooidTPPTcMlIhlJ2UnKU7Lv62KtCK8vKtohCfqZ/j
	vqHMDVo+4ImQwGwcifEA44+bzWGwi4IPCO/IMPQZcCf99M/MHJQ0wnjd8qG/mRpR25TYoJ4QOvm
	UbuQkllj2acxON3ZMNd+lncpu79wO0VQ5nyxhu1uQG8xXQb1NK8x5/Zwt+KY5hThFiI1IEomOcM
	srWYW3kY218D/TR+gVHslqe0pCpFqyl0gcu9VeDgSaLbF3a0VM+iQeHiX2Xq3ziiE1yVtpUWq4B
	VuBiC77IUjSC0RUbS3ahKpS7FUPSRvAs9tEW4lHEmjeXn3OJla9augioy9PrTITl5SuUV58+rUr
	HZf/0IKutQh33qqFjj1mc0lF+F9EcVLfNkjfleqKMOpRPGB5WTk9M+GmP7gifNsdJjPvjNK5/yf
	VGjgX6ngXbIDCp
X-Google-Smtp-Source: AGHT+IGpok2rbe+PM/m3BufdeCo188/KOxQEw562uyqXa+yKjY0Jrvcfkxzp0puKcXaQ7WzgbjFXkQ==
X-Received: by 2002:a05:6000:420f:b0:3d1:5869:d4c5 with SMTP id ffacd0b85a97d-3e641e3b134mr10268242f8f.17.1757408667499;
        Tue, 09 Sep 2025 02:04:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:545e:637a:28a6:9ede? ([2a05:6e02:1041:c10:545e:637a:28a6:9ede])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm315163425e9.6.2025.09.09.02.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:04:27 -0700 (PDT)
Message-ID: <47d31043-f25c-487d-9676-928f391516ff@linaro.org>
Date: Tue, 9 Sep 2025 11:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
 <a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org>
 <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2025 09:33, Andy Shevchenko wrote:
> On Wed, Sep 03, 2025 at 05:28:09PM +0200, Daniel Lezcano wrote:
>> On 03/09/2025 13:48, Andy Shevchenko wrote:
>>> On Wed, Sep 03, 2025 at 12:27:56PM +0200, Daniel Lezcano wrote:

[ ... ]

>>>> +		nxp_sar_adc_channels_enable(info, 1 >> chan->channel);
>>>
>>> 1 >> ?!? Did you want BIT(channel)? Or simply channel != 0?
>>
>> Yeah, BIT(chan->channel) is better
> 
> But is the above a bug in the original proposal or not? I mean one wanted left
> instead of right shift.

It is actually a bug, you are right it should have been left shift

>>>> +	dmaengine_tx_status(info->dma_chan,
>>>> +			    info->cookie, &state);
>>>
>>> Perfectly one line. No return check?
>>
>> Ok, will see if the IIO DMA API has an impact on this portion of code before
>> checking the return code. However, the status is often ignored in the other
>> drivers.
> 
> ...which doesn't mean it's a good example to follow.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

