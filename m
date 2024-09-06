Return-Path: <linux-iio+bounces-9239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0596F011
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 11:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BEC1F28038
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A561C8FDF;
	Fri,  6 Sep 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PowfCfWx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EF1C8FD4
	for <linux-iio@vger.kernel.org>; Fri,  6 Sep 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615940; cv=none; b=HVDZxTsVqfkqkls5YB29jJxYUxI2mFw6fHNZxLYofDDFVUtDa3I508iNFr2UxSvKlXI+jUkX4HNwfbm/nXIwkBOXAd34oKq0TwBiK/2NGh+VRWvEZJrY9bvZNISuSNXSaTuoI/Vq4IsYS2hqP5GS0u58PlvfWW37wpB0WmUCo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615940; c=relaxed/simple;
	bh=7PbyHCGSU/EBWPpLh2nI/FGAdjLSfkCd7ogz0SmyE84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Txsykb5AxJyAgAGPyODUITh1SMKNQlQZtv0455EOW5MKQgdZKCSLXlnq4TMoOsMmwlTNdADn6Z1DTm8Ivml6WbuBZm4OiSiyITEJrr3G61BftsmQMTqe2HtPIAKFwMaFU9dJuZ9iTKo0aLxwesWfdFID/9r4n+wx08fG6+zKFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PowfCfWx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso18742455e9.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725615937; x=1726220737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMLNOnOgZigxncEhDKlQLxYVkdY5WouKUkAt0vKRysU=;
        b=PowfCfWxNUrSItjl69Eo1wCgYEEnZAj/SzvU4+iPbZRVOqWp5JxuEbVpxyEgJzyPLl
         1YmutkpIFxnpTCqjmQb19+e99OnR5riwaoDnuZZAOmLbYh4zNyly0nYCaj/U+2HhC0xT
         pgyw7x9XdUIdIj/hDYLG35pIB0TQGdGP5eEwaDu82M0Xnp0dHTGAHMASvVSIjo1wrhWi
         bUYlnr2g8G6egEA9VU0O6GeV5XFZEj1UIN0Ant8TJNbvigqBuf+5fcg06wGQR2uAWatj
         AjOxOq2YQ34nKO2m5xLt8yTWj3qcnXnk9do138tLbZR8Jmxqzoc+YQIO3hvrbupt52Cs
         gbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725615937; x=1726220737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMLNOnOgZigxncEhDKlQLxYVkdY5WouKUkAt0vKRysU=;
        b=X88lmf/lQxp9iS7upF06FXln3Aa+iACZ/FhI8izKhb3mpundc3RZqHVPH352x/vPii
         jOfwy/ge0DYIG5o89ZSU9/FZbJ5DfQ577X8fPZjh7l4ax/VlTHwMZO3vA+wM44WYD2kg
         WvtYZdc1lEtSy3n2ZelOcxv+nN2H4FyMuk8+n3UfQkBepcjgyMYwE/j3UgKEMTeo1Zpa
         kBHdeeZwZ6luJCcyLo573f9K3CPpFaLW4YQuLjkU1yEPWcl1D7l96mJ3LSkEUIgfP68P
         j3w/8RtzX9ewHT7bHb88Oqw9t/FNulEjnuk/M9gPFcX187OLzhOKavSFzPmu0UVJWAys
         W/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVVeZBC405ttkr7EmF7g5f77iYjAy51A5aM9PxZL7lEfGbRfN+od1jjJjngCg9J+PW8+JX3NKuNhoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyueFqpnAXjADg9zZzpGcQ27foIrKgoV0sU22xtLuTQzNiRKc1K
	2NZSdBaGmCKRMG45LFMn84q+7nGoL6qe2ehjdUbnBXvDaWpLwz8UVo7FxfKGYEA=
X-Google-Smtp-Source: AGHT+IECmYyhyA+IpABo5bXuqpdZnToIY8Sd1IRurZQbW8hGzZw7lteqMNDonXje3MoT/oWp4yuj+A==
X-Received: by 2002:a05:600c:1d99:b0:428:f0a:3f92 with SMTP id 5b1f17b1804b1-42c9f98c2b0mr17597355e9.21.1725615936652;
        Fri, 06 Sep 2024 02:45:36 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca053ec61sm14854315e9.0.2024.09.06.02.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 02:45:36 -0700 (PDT)
Message-ID: <fb50e9a6-f78f-41ba-af67-8eb414e9d54c@baylibre.com>
Date: Fri, 6 Sep 2024 11:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] iio: add support for the ad3552r AXI DAC IP
To: Conor Dooley <conor@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240906-unwatched-backshift-4782a627278f@squawk>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240906-unwatched-backshift-4782a627278f@squawk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Conor,

On 06/09/24 11:07 AM, Conor Dooley wrote:
> On Thu, Sep 05, 2024 at 05:17:30PM +0200, Angelo Dureghello wrote:
>> The serie comes from the previously discussed RFC, that i
>> converted to a normal patch from this v2.
>>
>> Purpose is to add ad3552r AXI DAC (fpga-based) support.
>>
>> The fpga DAC IP has been created to reach the maximum speed
>> (33MUPS) supported from the ad3552r. To obtain the maximum
>> transfer rate, the custom module has been implemented using
>> the QSPI lines in DDR mode, using a dma buffer.
>>
>> The design is actually using the DAC backend since the register
>> map is the same of the generic DAC IP, except for some customized
>> bitfields. For this reason, a new "compatible" has been added
>> in adi-axi-dac.c.
>>
>> Also, backend has been extended with all the needed functions
>> needed for this use case, keeping the names gneric.
>>
>> Note: the following patch is actually for linux-iio/testing
>> ---
>> Changes in v2:
>> - use unsigned int on bus_reg_read/write
>> - add a compatible in axi-dac backend for the ad3552r DAC IP
>> - minor code alignment fixes
>> - fix a return value not checked
>> - change devicetree structure setting ad3552r-axi as a backend
>>    subnode
>> - add synchronous_mode_available in the ABI doc
> Please give reviewers a chance to response to in-progress discussion on
> a version before sending a new one. I've left a couple of responses to
> v1 that I only had a chance to reply to today due to travel.

sure, will wait some more days next time.

Regards,
-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


