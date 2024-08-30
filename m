Return-Path: <linux-iio+bounces-8895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3768966434
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1931C239DC
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4511B2510;
	Fri, 30 Aug 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DArQ4dOg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F91384B3;
	Fri, 30 Aug 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028222; cv=none; b=m05MJTLYUJ7rSUVDn0+D1OyvXM0KEacMa42ttod9jDL5A7kJCFB9+xoeph7fsFcK5opNZfHWRNDeoOZ42ItMeXgVnjk73ng2o/uXuyFBFto8bTjnxi3iu92koIohHeApQuAuRczIXYXENV3WXoAqFxdRNGWbbPw+dGfdasSax+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028222; c=relaxed/simple;
	bh=wBTRrgazQK+ti3KYuGnncmUScCXMLECzC9r1UQejTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3a/LmbwVTdvYmJ8fZnuL6m6OU/+svK7oIEysOe/n6TczBvI0wVE+qFm+ycwSVzvkPAOAf6HNFh/B4+2ztFg4CqdjNO0Tn3+FBk4sSPX13FooK8O5kyMh3Rkl+ahpwjcXV+AD30YFoeoIqoLGqvw2jmc0saj8qxi8UtYtfWAwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DArQ4dOg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714187df604so1848932b3a.1;
        Fri, 30 Aug 2024 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725028220; x=1725633020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4mVjXdfO2slGfU+rRaBTKJWa5PwKOyNveXco5EU4Dmo=;
        b=DArQ4dOgakIhDB0RkJzS2uHKq1p33bL2Od57QcAItAZjYVvBn+t/2b/dmNRUvqOMog
         f+/iOy5NpFHvCfOR8agBQpGK0qgB36IwHaY+jlEvmMlPhcx+CVSh1L4EeqFTLuHOEwX6
         oGA2t/pmYDbGPLymAylnl30aS6K2nz9oxOKM1/6gC+SJMr+IDUJQ6HDFYbYCAN4f80XF
         SkDI23Z1f9CpuzaCej5qF2ReqhAGIZzwwMb+M+mc49H3gUsT9cBo9ON18q10KQkqLba5
         JiQybwIsW+ixifbv46ohJeCAA5Yrfl4yIt/phLE9w5abLeX6b72l75XXsn3Y5oywIZG9
         l/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725028220; x=1725633020;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mVjXdfO2slGfU+rRaBTKJWa5PwKOyNveXco5EU4Dmo=;
        b=wddw1zxSpoa76rSUNwzMivKTIVjDSbLqSt+ZHoq0jw48OlSD8QzUZnS0nB/wN5hzm9
         uRuC8zvqWdVwnigzcvXhvwKszKVNCReY+Peo8AXD98/jRlqAZ2zYSusZ39vMYhhEO1F6
         fyh0xmcSSn+yyERTj1rJ1BilzeKRxUpKEUKjqFD+xEdmsYp52IHwiW0tAXY87lrXNQwQ
         GpUYfUrlOOMiOA8MFb1IL4OkamoBpqKJ8Ym0tIpHqRPlkvYAVwqKgEPbRaShjAbYMWUd
         SfVzCtwIbnds1FT2SDnWn09Lajr9fci2B9CCgAIncimcLSuaLsfCluj+IKoSoNddty8j
         aGlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIKUKeEnVwb7yNrn9Rekj1a+FkaHp+QFcvhgzw45uhVZLJHV1gSf3wcuEfm9Zn1gLlzDPOy7rG2nLT@vger.kernel.org, AJvYcCX3q4Zrs+qx+9cfZRtblY0wC840MhDpw5MqiCtFK7mTjhPvtpuOB+eNMDKn1ryGdOjOTqGiX935Vvty@vger.kernel.org, AJvYcCXMZlcaB/jX/bGY795XVuns5wj0v0f2wNQfHodymccTK4ZbMcHg543RgHOfa5F3rdLiicxEVRyAxtSnAEU=@vger.kernel.org, AJvYcCXRizk6kA+B7bWxHDEAM/g/qLHBMjAz+7ORko5TdZHtnP0Yl4j3xiZwXy7nWPJPhKWGP6aRo+AdJJmS@vger.kernel.org
X-Gm-Message-State: AOJu0YypcOg4Z2uzMldD0eCVQw5KBaNBa2OaUrv9cwcGQLaIEx1OOpYD
	ckDSyD8GwLE9G5FHjSGhhBLybVvOP0Mq8v/VCQHJp8LazCZc0naM
X-Google-Smtp-Source: AGHT+IEutG1Jk0UGCfHvTIzrCWtY4Zur758fWFmWXRd912KGJZIho8O+oYihbVMZsPwS8TNUWc2ofg==
X-Received: by 2002:a05:6a21:70cb:b0:1c4:6e77:71a3 with SMTP id adf61e73a8af0-1ccee75eeb4mr3727047637.3.1725028220166;
        Fri, 30 Aug 2024 07:30:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bef08sm3051595a12.58.2024.08.30.07.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 07:30:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <766b9892-ef54-4f0a-96dd-19e8a1b3279c@roeck-us.net>
Date: Fri, 30 Aug 2024 07:30:16 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
To: Conor Dooley <conor@kernel.org>,
 "Sperling, Tobias" <Tobias.Sperling@softing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <20240830-chaos-unrivaled-04c5c4c6add9@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240830-chaos-unrivaled-04c5c4c6add9@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 06:14, Conor Dooley wrote:
> Hey Tobias, Guenter, Jonathan,
> 
> On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:
>>  From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00 2001
>> From: Tobias Sperling <tobias.sperling@softing.com>
>> Date: Fri, 23 Aug 2024 12:08:33 +0200
>> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
>>
>> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
>> analog-to-digital converters. These ADCs have a wide operating range and
>> a wide feature set. Communication is based on an I2C interface.
>> The driver provides the functionality of manually reading single channels
>> or sequentially reading all channels automatically.
>>
>> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
>> ---
>>   .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++
> 
> If this is a "generic" adc, why is it going into hwmon?
> I would have expected this to be in iio/adc, and use more typical adc
> bindings, even if the driver is in hwmon.
> 
> Guenter/Jonathan wdyt?
> 

Same thought here. While the chip supports limits, making it suitable for
hardware monitoring, its primary use seems to be as ADC, not as hardware
monitoring device. The hardware monitoring API isn't well suited for the
fast sample rate supported by this chip.

Guenter


