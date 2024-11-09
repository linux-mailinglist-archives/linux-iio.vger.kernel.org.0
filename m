Return-Path: <linux-iio+bounces-12059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227EF9C28A2
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 01:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469E31C23BDC
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC815A55;
	Sat,  9 Nov 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyVmD5Cp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752B322A;
	Sat,  9 Nov 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111093; cv=none; b=C6wOmQqGwDcvqb7jSPn7r604A6OiQqjok2O4WuH/qouGT05wz4JE8QZ8eWvMyvOWe0/TKEfyV3uXaSUyTGreVUq0MBD04IivjsD/lGJYu5I7I0MLKwVAvpGYa2LNjipjAoya0WtsfEjVB360KCd5ljO2rAEdf3O7KzTrSlN47Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111093; c=relaxed/simple;
	bh=9NwaDc+sH59d+cHFwqfcTVbsIdXs0neqNpY43IxGzbY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cAN9ZuOlOvt73T4Uj1JVoTJsS9CS59gz1Byi4rgiTF/3of1U5nttnqAXW2+3M1f6z9+Pxtk2JR6fWJ4xUci181et4HGeyEkERClZcfwp84BUZuki0HZ/tdcGYFqkMzo3e1HqAlUxazzyK24BsHtcbEVVrnVfbkrjcRA6SIScrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyVmD5Cp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7eae96e6624so1960240a12.2;
        Fri, 08 Nov 2024 16:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111091; x=1731715891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3IZGLZAVK1oqGbVkQTDsgw2qviq88uDM6MYfmQbYgOw=;
        b=VyVmD5CpaPsZAX7poP8BatyMebflBOY5rJYIUJT0pPKmS/ZJsCoZAlDjlEIFpYpQ5g
         HdpcUk7MzqYZfrAAD9Coo6Ts+GslSy/D1KV9hwAJKZGKGL1RscQp9MaxX+WA4nhlJRWG
         FHWcfVwYv8EMYFzYey76a9FNk8VgRfj5MsrWq6BOk2Tcz2eTo2hXXlYlwvG2SVQlpEM9
         Mc1AzHe+cf9t7Fh/LX5UX1l2BxM8ut4FFttm/U1qroa/V+p4YqJfg5yoCYP/KgWwFsh7
         HDnHSafrYkwyt5bxkdns0G2UYEeq7rASEi3TcZkA53h08eS8eKRg3yyKuaty+J4jXSEi
         XcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111091; x=1731715891;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IZGLZAVK1oqGbVkQTDsgw2qviq88uDM6MYfmQbYgOw=;
        b=I5j+WsYo2F38VB7Ahwv/DBah+uWvNyj1g/xwKd0T1SfJJs6PUBXdRFuT9simlUqw7e
         r049pyJHzVG1k6g6Win1VPhsd2SbGaFAyQlHegH/e15PdNNmot5pyqTCseBaYvyAxOjz
         N2gHO+uOU3OSnHNAVa+LVuPdV0DQeHf0MUe9TCB4WNA24ZDNol5K6n6b+9iZUILK9o2K
         P4UJpqnCJJ9q+xliCcuL3Bw7lR6oQ+mY09isFcrXO7ageXs0qRSIyqdjvfR7RnF5tBfJ
         9U4/GW9Q+Qev/4h7SEcSa196OcLkpy32ehJOS7A7fLZufvb8T1XCkaV7xoGD0TVukyl6
         bKkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTPkF9iTkK2R6v4tjppRalkL3KlmgXn9ENcVz87HB9HoMghoLDWZicMMKWTB6v4PyZDX3xgSQT1q3S@vger.kernel.org, AJvYcCWaWxUC/b9yKIPx1ngKtw/gVF4tGQtdcf8xkFRIzLclWYK9u/PZE3CVeW1pwlp/spJQeIK9xUb9EGiZ9QD5@vger.kernel.org, AJvYcCWfIehGoPCBFgHNcCRRUIhN63+MTuGGMP7TBJ3J45F9/L9Egg8RP8F8sn27vWK6tOfQ9S/qYSwziEZlyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKr6UIglfekm9B9EdXRVYn8BI3ZPSbC8hXIY6wlO6WtStjcsBv
	5qtYLymrp7Z8c3lSyN4UyVavmEw6A6v7XcVZzRMMswI6aJQY1u8S
X-Google-Smtp-Source: AGHT+IGuXcqZTQ3uvvLT9UskUYdxGCdtqXC8QEEu9t5fHd+ir4QXBLBtFwW74giJKCVZUtxSJ6Qjqg==
X-Received: by 2002:a17:90b:314a:b0:2d6:1981:bbf7 with SMTP id 98e67ed59e1d1-2e9b17947a4mr6159364a91.32.1731111091548;
        Fri, 08 Nov 2024 16:11:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f8f1dasm4677556a91.25.2024.11.08.16.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 16:11:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b262ff19-dc57-4a72-9395-25d81e48a476@roeck-us.net>
Date: Fri, 8 Nov 2024 16:11:29 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hwmon: tmp108: Add help function
 tmp108_common_probe()
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-hwmon@vger.kernel.org
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
 <20241108-p3t1085-v2-2-6a8990a59efd@nxp.com>
 <c1b77ef0-f01b-4926-8259-e387166d0750@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c1b77ef0-f01b-4926-8259-e387166d0750@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 15:55, Guenter Roeck wrote:
> On 11/8/24 14:26, Frank Li wrote:
>> Add help function tmp108_common_probe() to pave road to support i3c for
> 
> help -> helper
> 
>> P3T1085(NXP) chip.
>>
>> Using dev_err_probe() simple code.
> 
> Use dev_err_probe() to simplify the code.
> 
>>
>> Add compatible string "nxp,p3t1085".
>>
> 
> This is borderline and problematic. First, it is the one functional change,
> and second, that functional change is not mentioned in the subject. At the very
> least it needs to be mentioned in the subject. I would, however, prefer two
> separate patches, even if that is just a one-liner.
> 
I forgot: The additional chip support should also be mentioned in Kconfig and in
Documentation/hwmon/tmp108.rst.

Thanks,
Guenter


