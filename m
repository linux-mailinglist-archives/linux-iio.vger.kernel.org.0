Return-Path: <linux-iio+bounces-27028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB8CB727A
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D0733033D7D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A031AAB1;
	Thu, 11 Dec 2025 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVm0i7z6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC4319848
	for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484873; cv=none; b=QOqpJSz+HeRyStaZVk+EZXqo3rADTPN8GiOOXb176rjx5anlUkkuh3ub3as8ZzD6KqAESqQjrA7hwmQfJ5eoNYbzEvNMptuDELh/rJdoJm4y7tDgslNvAINcJJ8r3GUJwHltaL8kH/9Pzdkak+1JyEmLJlq6i7SySrxjs70LhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484873; c=relaxed/simple;
	bh=ltkyJe63XhFW2XPK6AylI7PaYkhEU0IDnxaKPNLsdjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzENG7Ztkzt6nAKcLeXZF+BRy6f8w2SLr812IsaFAIWGHgX4GpisIygS7ge6k7V1c5WmIQXNqV80zbPPorN1nJhcMfPM21Dh8u41mpaBgvFDnW3jM5cNsFcAv/1g4sM+ur78AiZWWUblMHrytzdw9Pnm33usQFc3ynZ4uLyQPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVm0i7z6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so566639b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765484871; x=1766089671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RFNvjy025P4j3juJp/7mMNUGy36biZNwQLRzE8g0SZM=;
        b=EVm0i7z6XcTCUONIW/atv1XbAXeduN/UlNnj/lH5+Q8QpeYYXuAShMZ5wKjJoQzIVj
         AKVhPY6GcvV/oypaRXeWpeji3PmOTvxENr/lt02FnNbAjEJbUVTV8HrY7Vn3hjgqitku
         L2JGn/IusZapvFqXQataan7FMuCVHpEo3ZcoYkOM9ndZSnmbLmLVLuDPctgcHQC7OAAk
         JrWuH4rhOYK32M4Lp4LkKJXZdTJ5E68YKgXB4HxTrWHppZVgU6dEMWDiIDXtcwfbJbJJ
         k4byOrTXBzUilcwg+C+om2wAMBVl9k5he4H1n3rueZLy3N9xKrAwGMD/TKiC6JwO+5Zq
         Kg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765484871; x=1766089671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFNvjy025P4j3juJp/7mMNUGy36biZNwQLRzE8g0SZM=;
        b=UG/g7RiZqEqTcGubS8/Iec2ptTPLB1aX7s8PgWpfhPtLVELv8D3G2f3gMOsmw2PpMb
         qhWNgi7hy0vVeuJCny445nsTdHtyLlNXENzwYaq+Hm7GgSm+EBKzV3TKes8Lje+LLBdx
         ueuSxQ9PwgKRplPC1PbTyVFvkhxdwQshvtmDpgOXxbfvnOESPjI9H7C7hNNPy5p3Ho+A
         TboEiT+leymHXj5QJBkwgDau6L9DT2hquZkX/w5qIWj+vPTX0PNFZx49+NV5FhVNAy60
         VxpTnUKS70ZM4T9vwxcsd5yIo+gHzAwZ5OKjhcz5ONU4VP7+4C1jf59dpezKKUPNKArs
         14gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjFjpQsFgXbNboT+/VHeXVLpu0DgukfJPkDdtQfS3Bk2oVZtlMmbnCa0JbrLwwD6JpRyhG2v5oMOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2KN/XXxVqA0GtD3ty+fJ/DZzGmA+n0buZYt0BAd85pg+ew4s
	U8z8NiN5wXETE5GHMEv/9qCx4/ru/3URx8HVVbUCwWEOW2iMd6kVBYS7
X-Gm-Gg: AY/fxX5FfH86Akp4S64Qs1orkUPSMyLzTg6mmKpl06cYAJ4f7HLFeX5/ZHKWwgDSZh6
	5WpkqlAylcRJyoTn/d6BU6c0s5vswgytzg39B5yf65oXxqcMlgXsaA0PE5VqE2R0q6nWAR63/0C
	JMcUdXv3HH2nXRwk+0iV4nJ91LoADc4Nb5DzHWaDNaipArP738DoJAfnHQ27yCrUtbqmWdcuWxo
	yb/nqao6iqw6gi8OhVYB60iezFtwWMud/9S9+fPvlZviyRWgJRii+R5UOEdaSw2eknTTlaPQ/M4
	9iSMhhJDflVIMqnYv91VN23KL8StsqE7I3gEn9U88INw3PCmENALsRnVesbwKmZ45TPJLrYEw5p
	J+pDcdbRtutzFglYCUb57/RJgSmeLWluL2D8aZQ/vQJ2Z8nYC1Us7L47b8qaAt1HbuUoKruaHKD
	01gSPTq8RpEx1hYaUdlg03oaSGedFMUp9h/NO+TMfvQ8v0BaeF1Bd9+QAMyt8=
X-Google-Smtp-Source: AGHT+IHV4Iszd+K6pE+L70YOIdvHkZVJ03UYXalyKOYspoVp8AFbIBx4gAlLx501zb5azUo1ikN80g==
X-Received: by 2002:a05:6a21:6d89:b0:244:d3d0:962a with SMTP id adf61e73a8af0-366e0de878dmr8196886637.22.1765484871216;
        Thu, 11 Dec 2025 12:27:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e3casm3142680a12.21.2025.12.11.12.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 12:27:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f17d93db-f96b-469d-88f0-0878a0fc9fe7@roeck-us.net>
Date: Thu, 11 Dec 2025 12:27:48 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/16] dt-bindings: hwmon: Convert
 aspeed,ast2400-pwm-tacho to DT schema
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-1-21b18b9ada77@codeconstruct.com.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251211-dev-dt-warnings-all-v1-1-21b18b9ada77@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/25 00:45, Andrew Jeffery wrote:
> From: "Rob Herring (Arm)" <robh@kernel.org>
> 
> Convert the ASpeed fan controller binding to DT schema format.
> 
> The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
> rather 1.
> 
> Some users define more that 8 fan nodes where 2 fans share a PWM. The
> driver seems to let the 2nd fan just overwrite the 1st one. That also
> creates some addressing errors in the DT (duplicate addresses and wrong
> unit-addresses).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

I am not sure I understand what the plan is here. I am assuming it will be
applied through a non-hwmon branch.

Acked-by: Guenter Roeck <linux@roeck-us.net>


