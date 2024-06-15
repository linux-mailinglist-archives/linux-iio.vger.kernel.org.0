Return-Path: <linux-iio+bounces-6280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF69096B0
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 10:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E092FB21B10
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1A18638;
	Sat, 15 Jun 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jX5LQ8Ae"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4318052
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438594; cv=none; b=eiD4FIecYbdiE+XT/yuUdRmhgFCTF5bvclI3gypBFoCWxpl4//Bo6aBtKa5BbVvmFtA4LaI7nb6vFpH3gUTZxeMWGGFtsdsZOg3phtMaR0Yl3PhsJbuhM1jKQtJv3cV/hk7PpK9w2dYlg+p+26exoO/TtmE+hfqOGxyaLdRtNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438594; c=relaxed/simple;
	bh=zh8wFqlkhu1LOYUvNSAdvMQzn9efxj16Mc5cp9NZux4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUAdJt/1kVSGzzoMEA9KOulv4J/D02l3Y+fpayxd8DDw0hatViEn6EQZC6mLiwF1abfOOS1Kp7Qg3rfIzpUH7bVWVi24SAKMeYOMrqO5fy6xgy6bPYXzbZJGOtP71L6unFrqAHbUj+PmsGJxsbxkBQHDDwtURJaE6LLoJ/N7bxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jX5LQ8Ae; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so3561504a12.2
        for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718438591; x=1719043391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zOGB4ty0lN3NCNyIJ260rYDoej6YMyuL1DkilGLprq4=;
        b=jX5LQ8AeBhA4W+2km7luY6Sixj9wKzjIEvWeYfkepTIGjA9eeGDqxR+WCuwszdcB8o
         l/DCIvsqFa6WDwW1BFUqMXbzQrahZscIJ3YsdtQNDH/OMRRWZ2H8NUOJlySbDeKjg446
         AQsxcgloWLZK9qtp+wyUrzAhOTTZnRIZgOYvB6PhfYUDLKj0NkLLi7e9s6J6cUhq1O9G
         wYs7lG5MR9GgonV41hd/b4i4yVmYuWN6+a53cDy/tEvWj2J3n9IFVjzwCgPPgcGW1S3G
         ooEnl4w+V22zwywAoWXhtZUzI4HuWcGzTyghygRxfaYvK6vm/lhilvwTVuB2iVYxeCtL
         nINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718438591; x=1719043391;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOGB4ty0lN3NCNyIJ260rYDoej6YMyuL1DkilGLprq4=;
        b=CrBSEB5HHiTsCtxMIs17Frj/3ATVNBII8MH2dVEPxrsruBQ6ylV6jUcG+szPAawu5c
         ScrwWoAETrcFljsnfwyS3MbSc7LtysiawLu2PkkCoj16L3u78j6YUUBh9Ib5x512rW3d
         tsBuJHgVMl4vJm4nmAC0PE/chDDSSoOL8ngvMd3rCmLxALtSS2SZl+m68WdipTrfZOOp
         ZP/pM0DwFILBcBP0bbZVdzHHOj3ImJowTJWg7bECxBmh3L5D3T2Qq7h/gqQ/66ixnIZl
         5UFPvzZuE1D6UNCDgQm0RqvvCYpeUuCdnjWs9YJS5oNKTeZKLojxhiFPQDR6qS4DGjEG
         qTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqrswo0WVABI6D/K+uvoccvQkAVmpGiefM8JQF9jy+AkHTggw1lkwMqCdQTO4uJs2rBvaqS6uNYsBYj2lUwJqMFDjGgbeZzRMS
X-Gm-Message-State: AOJu0YzXlvhriZEp8CreRUL8zN/Q0Ffnwa3pG1p2uns6r9DHthRMK2bk
	lJVjbVILz+2m8UaZcD+Na5RcJj87Qgc4hdJoxs0379X/5Ih1omC+r95fOiutUu0=
X-Google-Smtp-Source: AGHT+IGcUqmW23OJOLctm0PilyvalwSahHFmwbkA/ty941zZUuGnFSGlIjdG0pmdv62CKNXHzx2K1Q==
X-Received: by 2002:a50:a456:0:b0:57c:73fc:a8d7 with SMTP id 4fb4d7f45d1cf-57cbd69dd0dmr2882939a12.14.1718438591096;
        Sat, 15 Jun 2024 01:03:11 -0700 (PDT)
Received: from [192.168.0.18] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72daa67sm3310438a12.38.2024.06.15.01.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 01:03:10 -0700 (PDT)
Message-ID: <54dcddce-bd31-4e04-8fa3-ecca9b0162f8@linaro.org>
Date: Sat, 15 Jun 2024 10:03:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: drop stale Anson Huang from maintainers
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20240614095927.88762-1-krzysztof.kozlowski@linaro.org>
 <20240614170123.00002e0f@Huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240614170123.00002e0f@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2024 18:01, Jonathan Cameron wrote:
> On Fri, 14 Jun 2024 11:59:27 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Emails to Anson Huang bounce:
>>
>>   Diagnostic-Code: smtp; 550 5.4.1 Recipient address rejected: Access denied.
>>
>> Add IMX platform maintainers for bindings which would become orphaned.
> That doesn't make much sense for the magnetometer which has nothing to do with
> imx.
> 
> Make that one my problem under my jic23@kernel.org address.
> 
> Thanks,
> 
> Jonathan
> 
> 
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
>> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml b/Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml
>> index 6b54d32323fc..467002a5da43 100644
>> --- a/Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml
>> +++ b/Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml
>> @@ -7,7 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> Not sure the new maintainers make sense here.
> 
> Flip it to me if no one else volunteers.

Indeed, too much automation. I'll do that for v2.

Best regards,
Krzysztof


