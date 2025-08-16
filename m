Return-Path: <linux-iio+bounces-22855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB395B29027
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA701B67CF2
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700BE205E2F;
	Sat, 16 Aug 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S1igk2Qo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6761FE470
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755370537; cv=none; b=DRZxEb1z+ZhmoxJTHe7k8Mk0sST1ou6A5XwbOdtpxPJuxQIK0gA6TNl2mkn8NXtsJnd1ZtkKVOaE9t7uVWJNn+FPcMBEzKvYOjDZvGkkP2JUAeGOxhIa9eEXcJ05qztXZM+8hfU2q7JQaAD/li1B+6CATf+BEmGiV42kMKHRcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755370537; c=relaxed/simple;
	bh=e7uChWhGMvZHa6Mpyo4vNChVMnVBmFr56RHl7o6kiq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpYdrqQSU4JHgmPB66p8Y1vldfjqOispoXvLNUSYe8seAz4yNIOJT/JyRgfw6juh8qqqKFKNgelZMw6UrKuGxJ+RDZoNu/qDHzKMpWeDlELy43te5Zseom/jBjsFzNG6RT4FXVOfZTtBxiN7smkQ6Q3VRcWrH/e2ra+o9upD5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S1igk2Qo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74381e0a227so2125449a34.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755370534; x=1755975334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffPmnzaqLO3di+HvejIJSUJDzn9TWvgequfo9PXfSM0=;
        b=S1igk2Qoa9bDBOAF/e5k3FdjHD1V2HTomiRHp40QZE0MPI3d92UOrh22x7QsJlZIz5
         uKaTMObYlBAiLh52RXauM/3mpg1x1A8lNz/UxUgLw/JoKiXeeEF87axSVbip7bg40IKH
         LqNsft42EzC7NKB6vhfpfYwp7Hi3P31dviBnmQzoni9pp1zPwmuuWGf7E6Gf+4aoEgtc
         H1mFKNCGllFy04RF2g0qW5MqrgYWphclRO/EX67pYUd/2+SUB9w41hpMFIDlJ3Dsd0kc
         CW8KIiCyORqODQSrwQJ1oHub2DrYhP8OK0T4iTSgCPVzMegokvMd5/tw1M8wwj7naVE4
         FLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755370534; x=1755975334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffPmnzaqLO3di+HvejIJSUJDzn9TWvgequfo9PXfSM0=;
        b=Yl3D+FSn5tLo476K2b/CRIISNPxQpADWfQpSaMXA0sru78bkxsBjDT+2cg8P1ay3ft
         eWcKZ0jgBKujeogn7Pxd/+bLi5TqrKI3G5gM5u5pNOkek8CtMHuTInuQEbgVyq7QhtIn
         6kQKvSpxC/7N+eR1E3n4NtS34SNgo42whs/8KveXjKeLEJdvvxRgR93Z19JT4at4Zkc9
         ehyYYUrL3s1HM9BopKJ096gMXSzxuM5BT0EOkDpp3U6HE/n9Wh6CQ+g3gKzdZt4yRF+L
         okZkglJgjrylotzPyUb3amkpjakQyKktcFNKpNnuqtbRNQMV+YPCS5kz02X0N221bSbM
         +AvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqINbbceyFrMnS4fPB9Y15Wynfi1eAOSG6n3HeQ0SlTXNIyc9zV3Tv4FZndhFjD0IqOJdIcss0JPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDPGkZ62SN3Gad57Lx25FDblsBpY63A2dzwU3/Ie/dqACdpt6
	uTOjhzRSxmE7mu7zAKIzC4IS2qStSxx0+2iuY3tgWFi1esw0Z0rcXjphA2f6u9gW3Lg=
X-Gm-Gg: ASbGncvPlAarXM7EJCu5IO/c/5dxWu7O0vnY5g8aRBSxbsisyjnceggDcZNF25yCZ77
	upb1HfEsdbndhPI8uC7CvPNRyMkV2mRfI6sJ7oIJWUEOOB58sjLkJgoxPlAKyoF9/pZyDYokFDj
	KjtQDi+svzbsFJixo6imT6hBuq30riXJP6FcJIMg4HcjFZAZxbj0dxgI+ZDNQIRg1mYZ98nBNHR
	xVhJ/O03eh9I/Ec+vK3iWn1kBkfNn0FDJDTuQ1DWR475aetNRvyqXL08J/32xdS7QOr5vscZMcw
	MUc4i7Z6anIq/sZHYmvDbwhDFpgQnDUUSzAgztTe/gip195AqmzR8bVjotXbLYmSkco/8iIttuN
	AQK1xP5MnkCwLtvi5WUYVLa+n9dcVhmPwqSr52JJ/FeYpl8a0VXaMggGLPX6EhJQaUbvjdVXp
X-Google-Smtp-Source: AGHT+IEo6Cd9FfYudnBVmWWkFVcb8dBQtaWN3pYM49rfwJr5rFglXZnKGElmuA2TlxnPrLBE2fctyw==
X-Received: by 2002:a05:6830:6f8c:b0:741:a842:18a8 with SMTP id 46e09a7af769-7439bae80a5mr1909896a34.22.1755370533643;
        Sat, 16 Aug 2025 11:55:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bebfb34f2sm488110eaf.10.2025.08.16.11.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 11:55:32 -0700 (PDT)
Message-ID: <66063382-78c6-4d93-be25-46e972e390f4@baylibre.com>
Date: Sat, 16 Aug 2025 13:55:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
To: Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-2-bcollins@watter.com>
 <20250816105825.35e69652@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250816105825.35e69652@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/25 4:58 AM, Jonathan Cameron wrote:
> On Fri, 15 Aug 2025 16:46:03 +0000
> Ben Collins <bcollins@watter.com> wrote:
> 
>> The mcp9600 driver supports the mcp9601 chip, but complains about not
>> recognizing the device id on probe. A separate patch...
>>
>> 	iio: mcp9600: Recognize chip id for mcp9601
>>
>> ...addresses this. This patch updates the dt-bindings for this chip to
>> reflect the change to allow explicitly setting microchip,mcp9601 as
>> the expected chip type.
>>
>> The mcp9601 also supports features not found on the mcp9600, so this
>> will also allow the driver to differentiate the support of these
>> features.
> 
> If it's additional features only then you can still use a fallback
> compatible.  Intent being that a new DT vs old kernel still 'works'.
> 
> Then for the driver on new kernels we match on the new compatible and
> support those new features.  Old kernel users get to keep the ID
> mismatch warning - they can upgrade if they want that to go away ;)
> 
> Krzysztof raised the same point on v2 but I'm not seeing it addressed
> in that discussion.

One could make the argument that these are not entirely fallback
compatible since bit 4 of the STATUS register has a different
meaning depending on if the chip is MCP9601/L01/RL01 or not.

Interestingly, the existing bindings include interrupts for
open circuit and short circuit alert pins. But these pins
also only exist on MCP9601/L01/RL01. If we decide these aren't
fallback compatible, then those properties should have the
proper constraints added as well.

> 
> Jonathan
> 
>>
>> Signed-off-by: Ben Collins <bcollins@watter.com>
>> ---
>>  .../bindings/iio/temperature/microchip,mcp9600.yaml         | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>> index d2cafa38a5442..d8af0912ce886 100644
>> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Microchip MCP9600 thermocouple EMF converter
>> +title: Microchip MCP9600 and similar thermocouple EMF converters
>>  
>>  maintainers:
>>    - Andrew Hepp <andrew.hepp@ahepp.dev>
>> @@ -14,7 +14,9 @@ description:
>>  
>>  properties:
>>    compatible:
>> -    const: microchip,mcp9600
>> +    enum:
>> +      - microchip,mcp9600
>> +      - microchip,mcp9601
>>  
>>    reg:
>>      maxItems: 1
> 


